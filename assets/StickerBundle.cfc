component output=false {

	public void function configure( bundle ) output=false {
		bundle.addAsset( id="chart-js" , path="/js/Chart.bundle.min.js" );
		bundle.addAsset( id="chartdeferred-js" , path="/js/chartjs-plugin-deferred.min.js" );
		bundle.addAsset( id="chartcustom-js" , path="/js/chartcustom.js" );

	}

}