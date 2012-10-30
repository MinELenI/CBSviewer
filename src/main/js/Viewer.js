/**
 * Viewer.
 * 
 * @author mprins
 * @returns {Viewer} Viewer object
 * @class
 */
Viewer = function() {
	/**
	 * Map object, initially null.
	 * 
	 * @private
	 * @type {OpenLayers.Map}
	 */
	var _map = null;

	/**
	 * Toggle vlag voor fuulsize functie.
	 * 
	 * @type {Boolean}
	 */
	var _fullSize = false;

	/**
	 * update het informatie element met feature info.
	 * 
	 * @param {OpenLayers.Event}
	 *            evt Het featureinfo event
	 * @private
	 * @todo opschonen van feauture info response html
	 */
	function _showInfo(evt) {
		if (evt.text != undefined) {
			jQuery('#' + config.featureInfoDiv).html('<p class="todo">TODO: html parsen/opschonen</p>' + evt.text);
		}
	}

	/**
	 * Publieke interface van deze klasse.
	 * 
	 * @returns {Viewer} publieke methodes
	 */
	return {

		/**
		 * Constructor, attach to the DOM.
		 * 
		 * @param {object}
		 *            config Configratie object
		 */
		init : function(config) {
			this.config = config;
			OpenLayers.ImgPath = config.imgPath;
			OpenLayers.IMAGE_RELOAD_ATTEMPTS = 2;
			OpenLayers.Number.decimalSeparator = ",";

			// merge any controls met default
			jQuery.extend(true, this.config, {
				map : {
					controls : []
				}
			});
			jQuery(window).unload(function() {
				Viewer.destroy();
			});

			jQuery('#' + this.config.mapDiv).width(this.config.map.width).height(this.config.map.height);

			_map = new OpenLayers.Map(this.config.mapDiv, this.config.map);
			this.addBaseMap();
			this.addControls();
			_map.zoomTo(this.config.map.initialZoom);
		},

		/**
		 * Accessor voor de kaart.
		 * 
		 * @return {OpenLayers.Map} object van deze Viewer of null als het
		 *         object niet is geinitialiseerd
		 * @deprecated probeer deze niet te gebruiken
		 */
		getMap : function() {
			(window.console && console.warn('Deprecated function called: Viewer::getMap().'));
			return _map;
		},
		
		/**
		 * verplaats en zoom de kaart naar de gevraagde locatie.
		 * 
		 * @param {number}
		 *            x x coordinaat
		 * @param {number}
		 *            y y coordinaat
		 * @param {number}
		 *            radius straal van het gebied
		 */
		zoomTo : function(x, y, radius) {
			_map.panTo(new OpenLayers.LonLat(x, y));
			var zm = _map.getZoomForExtent(new OpenLayers.Bounds(x - radius, y - radius, x + radius, y + radius));
			_map.zoomTo(zm);
		},
		
		/**
		 * Controls aan de kaart hangen.
		 * 
		 * @private
		 */
		addControls : function() {
			_map.addControl(new UpdateLegendControl({
				div : jQuery('#' + this.config.legendDiv)[0]
			}));
			_map.addControl(new OpenLayers.Control.KeyboardDefaults({
				/* alleen actief als de kaart focus heeft */
				observeElement : this.config.mapDiv
			}));
			_map.addControl(new OpenLayers.Control.Zoom());
			_map.addControl(new OpenLayers.Control.Navigation({
				zoomWheelEnabled : false
			}));
			_map.addControl(new OpenLayers.Control.KeyboardClick({
				/* alleen actief als de kaart focus heeft */
				observeElement : this.config.mapDiv
			}));
			_map.addControl(new WMSGetFeatureInfo({
				eventListeners : {
					getfeatureinfo : _showInfo
				}
			}));
			_map.addControl(new ClickDrawControl());
		},

		/**
		 * cleanup. Moet aangeroepen voor dat een eventueel DOM element van de
		 * pagina wordt verwijderd. Wordt automatische aangeroepen bij verlaten
		 * van de pagina.
		 */
		destroy : function() {
			if (_map !== null) {
				_map.destroy();
				_map = null;
			}
		},

		/**
		 * Voeg WMS toe aan de kaart. Uitgangspunt is dat de WMS transparante
		 * PNG ondersteund. eerder geladen WMS lagen worden verwijderd
		 * 
		 * @param {object}
		 *            wmsConfig Een object met WMS parameters. <code>
		 * {
		 * 'name' : 'cbs_inwoners_2010_per_hectare',
		 * 'url' : 'http://geodata.nationaalgeoregister.nl/cbsvierkanten100m2010/ows',
		 * 'layers' : 'cbsvierkanten100m2010:cbs_inwoners_2000_per_hectare',
		 * 'styles' : 'cbsvierkant100m_inwoners_2000'
		 * }
		 * </code>
		 */
		loadWMS : function(wmsConfig) {
			this.removeOverlays();
			var layer = new OpenLayers.Layer.WMS(wmsConfig.name, wmsConfig.url, {
				layers : wmsConfig.layers,
				styles : wmsConfig.styles,
				version : '1.3.0',
				format : 'image/png',
				transparent : true
			}, {
				isBaseLayer : false,
				visibility : true,
				singleTile : true
			});
			_map.addLayer(layer);
		},

		/**
		 * verwijder de WMS uit de kaart.
		 * 
		 * @param {string}
		 *            wmsLyrName naam van de WMS service
		 */
		removeWMS : function(wmsLyrName) {
			var lyrs = _map.getLayersByName(wmsLyrName);
			for ( var lyr = 0; lyr < lyrs.length; lyr++) {
				_map.removeLayer(lyrs[lyr]);
				lyrs[lyr].destroy();
			}
		},

		/**
		 * verwijder alle overlays. Voorlopig alleen type {OpenLayers.Layer.WMS}
		 */
		removeOverlays : function() {
			var lyrs = _map.getLayersByClass('OpenLayers.Layer.WMS');
			for ( var lyr = 0; lyr < lyrs.length; lyr++) {
				_map.removeLayer(lyrs[lyr]);
				lyrs[lyr].destroy();
			}
		},

		/**
		 * Afmeting van de kaart aanpassen aan schermbreedte.
		 * 
		 * @todo hoogte instellen werkt niet omdat de parent hoogte de afmeting
		 *       van de child heeft.
		 */
		toggleFullSize : function() {
			if (_fullSize) {
				// terugzetten
				jQuery('#' + this.config.mapDiv).width(this.config.map.width).height(this.config.map.height);
				jQuery('#toggleSize').toggleClass('restore max');
				_fullSize = false;
			} else {
				// vergroten
				var w = jQuery('#' + this.config.mapDiv).parent().width();
				var h = jQuery('#' + this.config.mapDiv).parent().height();
				jQuery('#' + this.config.mapDiv).width(w).height(h);
				jQuery('#toggleSize').toggleClass('restore max');
				_fullSize = true;
			}
			_map.updateSize();
		},

		/**
		 * set up basemap.
		 * 
		 * @private
		 */
		addBaseMap : function() {
			var matrixIds = [ 13 ];
			for ( var i = 0; i < 13; ++i) {
				matrixIds[i] = "EPSG:28992:" + i;
			}
			_map.addLayer(new OpenLayers.Layer.WMTS({
				name : "achtergrond",
				url : "http://geodata.nationaalgeoregister.nl/tiles/service/wmts/brtachtergrondkaart/",
				layer : "brtachtergrondkaart",
				matrixSet : 'EPSG:28992',
				matrixIds : matrixIds,
				format : 'image/png8',
				style : '_null'
			}));
		}
	};
}();
