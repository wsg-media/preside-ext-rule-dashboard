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

	public void function index( event, rc, prc, args={} ) {
		prc.pageTitle    = translateResource( "cms:dashboard.page.title"    );
		prc.pageSubTitle = translateResource( "cms:dashboard.page.subtitle" );
		prc.pageIcon     = "fa-tachometer";

		//return renderView( view="/admin/dashboard/index", args=args );

	}


}