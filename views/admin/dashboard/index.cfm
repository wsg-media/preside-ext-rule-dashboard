
<cfscript>
	event.include( "chart-js" )
		 .include( "chartdeferred-js" )
		 .include( "chartcustom-js" );
</cfscript>

<cfoutput>

	<div class="top-right-button-group">
		<a class="pull-right inline" href="#event.buildAdminLink( objectName="dashboard_rules" )#" data-global-key="c">
			<button class="btn btn-default btn-sm">
				<i class="fa fa-cogs"></i>
				#translateResource( uri="cms:dashboard.configure.btn" )#
			</button>
		</a>
	</div>

	#renderAdminDashboard( 
	      dashboardId = "mainAdminDashboard"
	    , widgets     = [ "ruleElement","ruleElement" ]
	    , columnCount = 2
	)#
</cfoutput>