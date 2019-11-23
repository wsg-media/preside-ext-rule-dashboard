component {

	public void function configure( required struct config ) {
		// core settings that will effect Preside
		var settings            = arguments.config.settings            ?: {};

		// other ColdBox settings
		var coldbox             = arguments.config.coldbox             ?: {};
		var i18n                = arguments.config.i18n                ?: {};
		var interceptors        = arguments.config.interceptors        ?: {};
		var interceptorSettings = arguments.config.interceptorSettings ?: {};
		var cacheBox            = arguments.config.cacheBox            ?: {};
		var wirebox             = arguments.config.wirebox             ?: {};
		var logbox              = arguments.config.logbox              ?: {};
		var environments        = arguments.config.environments        ?: {};

		settings.adminSideBarItems.append( "dashboard" );
		settings.adminRoles.sysadmin.append( "dashboard.*" );

		settings.enum.StateGraphs = [ "bar","radar","pie","doughnut" ];
		settings.enum.TimeGraphs = [ "line" ];
		settings.enum.filterObjects = [ "site_takeover","asset" ];

	}
}