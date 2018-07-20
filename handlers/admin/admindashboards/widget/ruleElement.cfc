component {
	property name="dashboardService" 	inject="dashboardService";

	private string function render( event, rc, prc, args={} ) {

		var widgets     = args.config.dashboard_rules ?: "";
		args.graphtype = args.config.graph ?: "bar";
		args.heading = args.config.heading ?: "";
		var datasets = [];
		var colourList="rgba(255, 99, 132, 0.2)|rgba(54, 162, 235, 0.2)|rgba(255, 206, 86, 0.2)|rgba(75, 192, 192, 0.2)|rgba(153, 102, 255, 0.2)|rgba(255, 159, 64, 0.2)";
		var lineList="rgba(255,99,132,1)|rgba(54, 162, 235, 1)|rgba(255, 206, 86, 1)|rgba(75, 192, 192, 1)|rgba(153, 102, 255, 1)|rgba(255, 159, 64, 1)";

		var counter=1;
		for (var widget in widgets) {
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

		args.data = SerializeJSON(var = datasets);

		return renderView( view="/admin/admindashboards/widgets/ruleElement/index", args=args );

	}

	// An OPTIONAL permissions checking handler that returns true or false
	private boolean function hasPermission( event, rc, prc, args={} ) {
		return true;
	}


		


}