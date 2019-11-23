component extends="preside.system.base.AdminHandler" {

	property name="dashboardService" 	inject="dashboardService";

	public void function preHandler( event ) output=false {
		super.preHandler( argumentCollection=arguments );

		prc.pageIcon     = "fa-tachometer";
		event.addAdminBreadCrumb(
			  title = translateResource( "dashboard:dashboard.breadcrumb" )
			, link  = event.buildAdminLink( linkTo="dashboard" )
		);
	}

	public function index( event, rc, prc, args={} ) {
		prc.pageTitle    = translateResource( "cms:dashboard.page.title"    );
		prc.pageSubTitle = translateResource( "cms:dashboard.page.subtitle" );
		prc.pageIcon     = "fa-tachometer";

		var elements = dashboardService.getUserElements( user = event.getAdminUserId() );

		if ( !elements.recordcount ) {
			dashboardService.addUserElements( 
				  user       = event.getAdminUserId()
				, widgetid   = "rule1"
				, instanceid = "rule1" );

			prc.widgets = [ { id="ruleElement", contextData={ id="rule1" }, configInstanceId="rule1" } ];

		} else {
			prc.widgets = [];

			for ( var element in elements ) {
				prc.widgets.append( { id="ruleElement", contextData={ id="#element.widgetid#" }, configInstanceId="#element.instanceid#" } )
			}
		}

	}

	public function addElement( event, rc, prc, args={} ) {
		var id = "rule" & randRange(1, 999999999);
		dashboardService.addUserElement( 
			  user       = event.getAdminUserId() 
			, widgetid   = id 
			, instanceid = id );

		setNextEvent( url=event.buildAdminLink( linkTo="dashboard" ) );
	}

	public function deletelement( event, rc, prc, args={} ) {
		widgetid = args.widgetid ?: ( rc.widgetid ?: "" );

		dashboardService.deleteUserElement( 
			  user     = event.getAdminUserId() 
			, widgetid = widgetid );

		setNextEvent( url=event.buildAdminLink( linkTo="dashboard" ) );

	}

}