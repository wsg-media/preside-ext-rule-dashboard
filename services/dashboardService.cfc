/**
 *
 * @singleton
 * @presideservice
 * @autodoc
 */
component output=false{
	property name="rulesEngineFilterService" inject="rulesEngineFilterService";

	public any function init( ) {
		return this;
	}

	public boolean function collectData( any logger ) output=false {

		var canInfo    =  arguments.logger.canInfo();

		if ( canInfo ) { arguments.logger.info( "Executing collectData" ); }

		try {

			var tasks = $getPresideObject( "dashboard_rules" ).selectData(
				      selectFields  = ["id","condition","crontab_definition","label"]
					, filter        = "enabled = 1 and ( CURDATE() > next_run OR last_ran IS NULL OR next_run IS NULL )"
			);	

			if ( canInfo && tasks.recordcount == 0 ) { 
				arguments.logger.info( "Nothing to do" ); 
			};

			for ( var task in tasks ) {

				var rule = $getPresideObject( "rules_engine_condition" ).selectData(
							  id = task.condition 
					);

				var count = rulesEngineFilterService.getMatchingRecordCount(
					  objectName      = rule.filter_object
					, expressionArray = DeSerializeJson(rule.expressions)
				);	

				if ( canInfo ) { arguments.logger.info( "#task.label# #count# hits" ); }

				$getPresideObject("dashboard_data").insertData(
					  data    = { 
									  rule = task.id
									, hits = count 			
								}
				);	

				$getPresideObject("dashboard_rules").updateData(
					  data       = {   next_run = getNextRunDate( crontab_definition = task.crontab_definition )
									 , last_ran = now() }
					, id         = task.id
				);

			}

		} catch (e) {
			if ( canInfo ) { 
				arguments.logger.info( "Error: " & e.message ); 
			}

			return false;
		}


		if ( canInfo ) { arguments.logger.info( "Completed" ); }

		return true;
	}


	public query function getCondition( required string conditionID ) {

		return var rule = $getPresideObject( "rules_engine_condition" ).selectData(
					  id = arguments.conditionID
			);
	}

	public numeric function executeCondition( required query rule ) {

		return rulesEngineFilterService.getMatchingRecordCount(
			  objectName      = arguments.rule.filter_object
			, expressionArray = DeSerializeJson(arguments.rule.expressions)
		);

	}


	public string function getNextRunDate( required string crontab_definition, date lastRun=Now() ) {

		var cronTabExpression = _getCrontabExpressionObject( arguments.crontab_definition );
		var lastRunJodaTime   = _createJodaTimeObject( DateAdd( 'n', 1, arguments.lastRun ) ); // add 1 minute to the time so that we don't get a mini loop of repeated task running due to interesting way the java lib calcs the next time

		return cronTabExpression.nextTimeAfter( lastRunJodaTime  ).toDate();
	}

	public query function getUserElements( required string user ) {

		return $getPresideObject( "dashboard_element" ).selectData(
				  filter   = { user = arguments.user }
				, orderBy  = "ordinalOrder asc"
		);	
	}

	public string function addUserElement( 
		  required string user
		, required string widgetid
		, required string instanceid ) {


		return $getPresideObject( "dashboard_element" ).insertData(
				data = { user       = arguments.user 
					   , widgetid   = arguments.widgetid 
					   , instanceid = arguments.instanceid }
		);	

	}

	public void function deleteUserElement( 
		  required string user
		, required string widgetid ) {

		$getPresideObject( "dashboard_element" ).deleteData(
			filter = { widgetid = arguments.widgetid, user = arguments.user }
		);	

	}




	public query function getWidgets( string widget = "") {
		var filter = "";
		var filterParams = {};

		if ( arguments.widget != "" ) {
			filter = "id =:id";
			filterParams.Append( {id = arguments.widget} );
		}

		var widgets = $getPresideObject( "dashboard_rules" ).selectData(
			      selectFields  = ["id","label"]
				, filter        = filter
				, filterParams  = filterParams
		);	

		return widgets;
	}

	public any function getWidgetData( string widget = "") {
		var filter = "";
		var filterParams = {};

		if ( arguments.widget != "" ) {
			filter = "rule =:rule";
			filterParams.Append( {rule = arguments.widget} );
		}

		var widgets = $getPresideObject( "dashboard_data" ).selectData(
			      selectFields  = ["hits as y","DATE_FORMAT(datecreated, '%M %d %Y') as x"]
				, filter        = filter
				, filterParams  = filterParams
				, orderBy       = "datecreated desc"
		);	

		return QueryToStruct(widgets,"lower");
	}



// PRIVATE HELPERS
	private any function _createJodaTimeObject( required date cfmlDateTime ) {
		return CreateObject( "java", "org.joda.time.DateTime", _getLib() ).init( cfmlDateTime );
	}

	private any function _getCrontabExpressionObject( required string expression ) {
		return CreateObject( "java", "fc.cron.CronExpression", _getLib() ).init( arguments.expression );
	}

	private array function _getLib() {
		return [
			  "/preside/system/services/taskmanager/lib/cron-parser-2.6-SNAPSHOT.jar"
			, "/preside/system/services/taskmanager/lib/commons-lang3-3.3.2.jar"
			, "/preside/system/services/taskmanager/lib/joda-time-2.9.4.jar"
			, "/preside/system/services/taskmanager/lib/cron-1.0.jar"
		];
	}


	private any function QueryToStruct( required query qList, string convertcase="upper" ) {

		var retData = [];
		var rowcounter = 1;
		for (var current in arguments.qList ) {
			var rowStruct = QueryRowData(arguments.qList,rowcounter);
			if (arguments.convertcase NEQ "") {
				 var newRowStruct = {};
				 for (var key in rowStruct) {
				 	if (arguments.convertcase EQ "upper") {
				 		newRowStruct[UCASE(key)] = rowStruct[key];

				 	} else if (arguments.convertcase EQ "lower") {
				 		newRowStruct[LCASE(key)] = rowStruct[key];

				 	} else {
				 		newRowStruct[key] = rowStruct[key] ;
				 	};
				 	
				 };
				 rowStruct = newRowStruct;
			};
			arrayAppend(retData, rowStruct);
			rowcounter++;
		};

		return retData;

	}


}
