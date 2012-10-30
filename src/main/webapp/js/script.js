/**
 * @fileoverview event handlers en elementen voor de pagina.
 */
jQuery(document).ready(function() {
	// create map
	Viewer.init(config);

	// opzoeken van de gevraagde kaart in de _layers, id's zitten in
	// AvailableLayers.xml
	var _id = 'cbs_inwoners_2000_per_hectare';

	var maps = jQuery.grep(_layers, function(n, i) {
		return n.id == _id;
	});
	// console.debug('opzoeken van ' + _id + ' in ', _layers, maps);
	Viewer.loadWMS(maps[0]);
});

/**
 * dynamische elementen aan de pagina toevoegen.
 */
var setupPage = {
	init : function() {
		OpenLayers.Lang.setCode('nl');

		// verwijder core container, die hebben we niet nodig als er javascript
		// ondersteuning is.
		jQuery('#coreContainer').remove();

		// toggle knop voor vergroten van de kaart
		var aToggle = '<a class="max" href="#" id="toggleSize" title="' + OpenLayers.i18n('KEY_TOGGLE_SIZE')
				+ '" onclick="Viewer.toggleFullSize();"></a>';
		jQuery('#' + config.mapDiv).prepend(aToggle);

		// a11y link toevoegen in de DOM boven de kaart
		var aLink = '<a class="accesskey" href="" accesskey="1" onclick="jQuery(\'#' + config.mapDiv
				+ '\').attr(\'tabindex\',-1).focus(); return false;" title="' + OpenLayers.i18n('KEY_KEYBOARDNAV_TTL')
				+ '">' + OpenLayers.i18n('KEY_KEYBOARDNAV') + '</a>';
		jQuery('#' + config.mapDiv).prepend(aLink);

		// core link toevoegen aan de kaart voor het geval de javascript kaart
		// niet "goed" is
		var aCore = '<a class="accesskey" href="?coreonly=true">' + OpenLayers.i18n('KEY_CSSERROR') + '</a>';
		jQuery('#' + config.mapDiv).prepend(aCore);

		// eventueel de font-size aanpassen zodat het altijd past:
		// http://jsfiddle.net/ad5pf/1/ en
		// http://stackoverflow.com/questions/4165836/javascript-scale-text-to-fit-in-fixed-div
		
		ZoekFormulier.init();
	}
};

setupPage.init();
