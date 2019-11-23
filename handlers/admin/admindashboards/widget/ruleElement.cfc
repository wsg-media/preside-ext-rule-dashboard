component {
	property name="dashboardService" 	inject="dashboardService";

	private string function render( event, rc, prc, args={} ) {

		var timelineWidgets     = args.config.dashboard_rules ?: "";
		var statusWidgets     = args.config.dashboard_conditions ?: "";

		args.heading = args.config.heading ?: "";
		var datasets = [];
		var colourList="rgba(255, 99, 132, 0.2)|rgba(54, 162, 235, 0.2)|rgba(255, 206, 86, 0.2)|rgba(75, 192, 192, 0.2)|rgba(153, 102, 255, 0.2)|rgba(255, 159, 64, 0.2)";
		var lineList="rgba(255,99,132,1)|rgba(54, 162, 235, 1)|rgba(255, 206, 86, 1)|rgba(75, 192, 192, 1)|rgba(153, 102, 255, 1)|rgba(255, 159, 64, 1)";
		var counter=1;
		var labels  = [];

		if ( timelineWidgets.len() ) {
			args.graphtype = args.config.graph ?: "bar";

			for (var widget in timelineWidgets) {
				var widgetDetails = dashboardService.getWidgets( widget = widget );
				var widgetData    = dashboardService.getWidgetData( widget = widget );
				var dataset = {};
				structInsert(dataset, "data", widgetData);
				structInsert(dataset, "label", widgetDetails.label);
				structInsert(dataset, "backgroundColor", listGetAt(colourList, counter,"|"));
				structInsert(dataset, "borderColor", listGetAt(lineList, counter,"|"));
				arrayAppend(datasets, dataset);
				counter++;
			}	

		} else {
			args.graphtype = args.config.condition_graph ?: "pie";
			var data  = [];
			
			var backgroundColor  = [];
			var borderColor  = [];


			for (var widget in statusWidgets) {
				var widgetDetails = dashboardService.getCondition( conditionID = widget );
				var widgetData    = dashboardService.executeCondition( rule = widgetDetails );

				arrayAppend(data, widgetData);
				arrayAppend(labels, widgetDetails.condition_name);
				arrayAppend(backgroundColor, listGetAt(colourList, counter,"|") );
				arrayAppend(borderColor, listGetAt(lineList, counter,"|") );

				counter++;
			}	

			var structure = {};
			structInsert(structure, "data", data);
			structInsert(structure, "backgroundColor", backgroundColor);
			structInsert(structure, "borderColor", borderColor);
			//structInsert(labels, "labels", label);
			
			arrayAppend(datasets, structure);
		}


		args.data = SerializeJSON(var = datasets);
		args.labels = labels;
		args.id = "graph" & randRange(1, 999999);

		return renderView( view="/admin/admindashboards/widgets/ruleElement/index", args=args );

	}

	// An OPTIONAL permissions checking handler that returns true or false
	private boolean function hasPermission( event, rc, prc, args={} ) {
		return true;
	}


	private string function additionalMenu( event, rc, prc, args={} ) {

		var configInstanceId = args.configInstanceId ?: "";
		var addLink = event.buildAdminLink(LinkTo = 'dashboard.addElement');
		var deleteLink = event.buildAdminLink(LinkTo = 'dashboard.deletelement', queryString = "widgetid=#configInstanceId#");


		return '<a href="#deleteLink#"><i class="fa fa-fw fa-trash-o grey"></i></a><a href="#addLink#"><i class="fa fa-fw fa-plus grey"></i></a>&nbsp; ';
	}		


}