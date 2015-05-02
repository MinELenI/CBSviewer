/**
 * Handle browser print events.
 * 
 * @todo browser print events zijn buggy.
 * @author PrinsMC
 * 
 */
(function() {
	var beforePrint = function() {
		//Functionality to run before printing
		Viewer.printPrepare();
	};
	var afterPrint = function() {
		//Functionality to run after printing
		// Viewer.toggleFullSize();
	};

	if (window.matchMedia) {
		var mediaQueryList = window.matchMedia('print');
		mediaQueryList.addListener(function(mql) {
			if (mql.matches) {
				beforePrint();
			} else {
				afterPrint();
			}
		});
	}

	window.onbeforeprint = beforePrint;
	window.onafterprint  = afterPrint;
}());
