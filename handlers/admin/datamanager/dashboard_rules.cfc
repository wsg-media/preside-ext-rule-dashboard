component {

	private void function rootBreadcrumb() {

		event.addAdminBreadCrumb( title="Dashboard"  , link=event.buildAdminLink( linkTo="dashboard" ) );

	}



	private void function postFetchRecordsForGridListing( event, rc, prc, args={} ) {
		var records = args.records ?: QueryNew( '' );
		//var secureCol = [];
//writeDump(records);abort;

		 for (var i = 1; i <= records.recordCount; i++) { 
		 	records["crontab_definition"][i] = _cronTabExpressionToHuman( records["crontab_definition"][i] );
		 } 


	}


	private string function _cronTabExpressionToHuman( required string expression ) {
		if ( arguments.expression == "disabled" ) {
			return "disabled";
		}
		return CreateObject( "java", "net.redhogs.cronparser.CronExpressionDescriptor", _getLib() ).getDescription( arguments.expression );
	}
	private array function _getLib() {
		return [
			  "/preside/system/services/taskmanager/lib/cron-parser-2.6-SNAPSHOT.jar"
			, "/preside/system/services/taskmanager/lib/commons-lang3-3.3.2.jar"
			, "/preside/system/services/taskmanager/lib/joda-time-2.9.4.jar"
			, "/preside/system/services/taskmanager/lib/cron-1.0.jar"
		];
	}
}