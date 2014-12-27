/**
 * @fileoverview Dit is het globale javascript configuratie object voor de applicatie.
 */
/**
 * configuratie object voor het javascript deel van de applicatie.
 * 
 * @type {object}
 */
var config = {};
/** OpenLayers css/image pad. */
config.imgPath = "img/";

/** id van de div met de kaart. */
config.mapDiv = "cbsKaart";

/** id van de buttons voor het selecteren bij meerdere resultaten */
config.buttonDiv = "button";

/** id van de div voor de legenda. */
config.legendDiv = "legenda";

/** id van de div voor de featureinfo. */
config.featureInfoDiv = "featureinfo";

/** default map id, als in AvailableLayers.xml. */
config.defaultMapId = "gemeenten2013_bevolkingsdichtheid_inwoners_per_km2";

/** instellingen voor de kaart. Voorlopig alleen RD projectie. */
config.map = {
	projection : "EPSG:28992",
	restrictedExtent : new OpenLayers.Bounds(0, 300000, 280000, 625000),
	resolutions : [ 3440.640, 1720.320, 860.160, 430.080, 215.040, 107.520, 53.760, 26.880, 13.440, 6.720, 3.360,
			1.680, 0.840, 0.420 ],
	initialZoom : 3,
	// initiele afmeting van de kaart
	height : 500,
	width : 610,

	topoWMTS : {
		url : 'http://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaart/',
		layer : "brtachtergrondkaart",
		matrixSet : 'EPSG:28992',
		matrixIds : [ 'EPSG:28992:0', 'EPSG:28992:1', 'EPSG:28992:2', 'EPSG:28992:3', 'EPSG:28992:4', 'EPSG:28992:5',
				'EPSG:28992:6', 'EPSG:28992:7', 'EPSG:28992:8', 'EPSG:28992:9', 'EPSG:28992:10', 'EPSG:28992:11',
				'EPSG:28992:12', 'EPSG:28992:13' ],
		format : 'image/png8',
		style : '_null'
	},

	aerialWMTS : {
		url : 'http://geodata1.nationaalgeoregister.nl/luchtfoto/wms/',
		layer : 'luchtfoto',
		matrixSet : 'nltilingschema',
		matrixIds : [ '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13' ],
		format : 'image/jpeg',
		style : 'default'
	}
};

/**
 * schakel de kaart naar pagina vullend tijdens opstarten.
 * 
 * @type {Boolean}
 */
config.fullSize = true;

/**
 * Of de resize knop op de kaart moet worden gezet.
 * 
 * @type {Boolean}
 */
config.toggleSize = true;

/**
 * Of de transparantie slider op de kaart moet worden gezet. NB. hiervoor wordt
 * de jQuery UI slider gebruikt.
 * 
 * @see http://api.jqueryui.com/slider/
 * 
 * @type {Boolean}
 */
config.fgAlphaSlider = true;

/**
 * OpenLayers proxy url override.
 * 
 * @override
 */
OpenLayers.ProxyHost = 'xhr?';

/**
 * Rijksdriehoek (RD) bekend maken aan OpenLayers.
 */
jQuery.extend(true, OpenLayers.Projection.defaults, {
	"EPSG:28992" : {
		units : "m",
		maxExtent : [ -285401.92, 22598.08, 595401.9199999999, 903401.9199999999 ]
	}
});
