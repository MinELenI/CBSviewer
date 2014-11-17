/*
 * Copyright (c) 2012-2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
/**
 * Viewer.
 * 
 * @author mprins
 * @return {Viewer} Viewer object
 * @class Viewer, de viewer component.
 */
var Viewer = function() {
	/**
	 * Map object, initially null.
	 * 
	 * @private
	 * @type {OpenLayers.Map}
	 */
	var _map = null;

	/**
	 * Toggle vlag voor fullsize functie.
	 * 
	 * @type {Boolean}
	 * @private
	 */
	var _fullSize = false;
	/**
	 * Window resize timout flag.
	 * 
	 * @type {Boolean}
	 * @private
	 */
	var _resizeTimeOut = false;

	/**
	 * Opacity van de voorgrond (WMS) laag.
	 * 
	 * @type {Number}
	 * @private
	 */
	var _opacity = 0.8;

	/**
	 * update het informatie element met feature info.
	 * 
	 * @param {OpenLayers.Event}
	 *            evt Het featureinfo event
	 * @private
	 */
	function _showInfo(evt) {
		if (evt.text !== undefined) {
			jQuery('#' + config.featureInfoDiv).html(evt.text);
			jQuery('#' + config.featureInfoDiv).change();
		}
	}

	/**
	 * zorgt voor correct afhandelen van viewport resize.
	 * 
	 * @private
	 */
	function _resize() {
		if (_fullSize) {
			var borderW = parseInt(jQuery('#' + this.config.mapDiv).css('borderLeftWidth'), 10)
					+ parseInt(jQuery('#' + this.config.mapDiv).css('borderRightWidth'), 10);
			var borderH = parseInt(jQuery('#' + this.config.mapDiv).css('borderTopWidth'), 10)
					+ parseInt(jQuery('#' + this.config.mapDiv).css('borderBottomWidth'), 10);
			// inhoud padding set in css
			var headerH = parseInt(jQuery('#' + this.config.mapDiv).parent().parent().css('padding-top'), 10);
			var footerH = parseInt(jQuery('#' + this.config.mapDiv).parent().parent().css('padding-bottom'), 10);

			var w = jQuery('#' + this.config.mapDiv).parent().width() - borderW;
			var h = jQuery(window).height() - headerH - footerH - borderH;

			jQuery('#' + this.config.mapDiv).width(w).height(h);
			// TODO compute height and remove from here
			jQuery('#legenda').css('max-height', jQuery(window).height() - 500);

			_map.updateSize();
			var vectors = _map.getLayersByClass("OpenLayers.Layer.Vector");
			if (vectors.length > 0) {
				// in dit geval is er een kaartlaag met een featureinfo lokatie
				// verschuif naar die lokatie
				var bounds = vectors[0].getDataExtent();
				_map.panTo(bounds.getCenterLonLat());
			}
		}
	}

	/**
	 * Stelt de doorzichtigheid van de voorgrond kaart in.
	 * 
	 * @param alpha
	 *            float waarde tussen 0 1n 1
	 * @private
	 */
	function _setOpacity(alpha) {
		alpha = parseFloat(alpha);
		if (0.09 < alpha && alpha < 0.91) {
			_opacity = alpha;
			var lyrs = _map.getLayersByClass('OpenLayers.Layer.WMS');
			for (var lyr = 0; lyr < lyrs.length; lyr++) {
				if (!lyrs[lyr].isBaseLayer) {
					lyrs[lyr].setOpacity(_opacity);
				}
			}
		}
	}

	/**
	 * event handler voor na de zoomTo functie van deze viewer.
	 * 
	 * @param lonlat
	 *            {OpenLayers.LonLat} de zoomlokatie
	 * 
	 * @private
	 */
	function _afterZoomTo(lonlat) {
		_map.getControlsByClass('ClickDrawControl')[0].trigger({
			xy : _map.getPixelFromLonLat(lonlat)
		});

		_map.getControlsByClass('WMSGetFeatureInfo')[0].deactivate();
		_map.getControlsByClass('WMSGetFeatureInfo')[0].activate();
		_map.events.triggerEvent('click', {
			xy : _map.getPixelFromLonLat(lonlat)
		});

		_map.events.unregister('zoomend', _map, _afterZoomTo);
	}

	/**
	 * Update position cookies.
	 * 
	 * @private
	 */
	function _updateCookies() {
		var _ext = _map.getExtent();
		setCookie(COOKIE.X, Math.floor(_ext.getCenterLonLat().lon));
		setCookie(COOKIE.Y, Math.floor(_ext.getCenterLonLat().lat));
		setCookie(COOKIE.S, Math.floor(_ext.getWidth()));
	}

	/**
	 * Publieke interface van deze klasse.
	 * 
	 * @return {Viewer} publieke methodes
	 */
	return {
		/**
		 * Constructor, attach to the DOM.
		 * 
		 * @param {object}
		 *            config Configratie object
		 * @constructor
		 */
		init : function(config) {
			this.config = config;
			OpenLayers.ImgPath = config.imgPath;
			OpenLayers.IMAGE_RELOAD_ATTEMPTS = 2;
			OpenLayers.Number.decimalSeparator = ",";

			// merge any controls met default
			jQuery.extend(true, this.config, {
				map : {
					controls : [],
					theme : null
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

			_map.events.register('moveend', _map, _updateCookies);

			// toggle knop voor omschakelen basemap
			var aToggle = '<a class="lufo hasTooltip" href="#" id="toggleBaseMap" onclick="Viewer.toggleBaseMap();">'
					+ '<span role="tooltip">' + OpenLayers.i18n('KEY_TOGGLE_BASEMAP_TITLE') + '</span>';
			aToggle += _map.baseLayer.name === 'topografie' ? OpenLayers.i18n('KEY_TOGGLE_BASEMAP_LUFO') : OpenLayers
					.i18n('KEY_TOGGLE_BASEMAP_TOPO');
			aToggle += '</a>';
			jQuery('#' + config.mapDiv).prepend(aToggle);

			if (this.config.toggleSize) {
				// toggle knop voor vergroten/verkleinen van de kaart
				var aToggleMapSize = '<a class="max hasTooltip" href="#" id="toggleSize" onclick="Viewer.toggleFullSize();">'
						+ '<span role="tooltip">' + OpenLayers.i18n('KEY_TOGGLE_SIZE') + '</span></a>';
				jQuery('#' + config.mapDiv).prepend(aToggleMapSize);
			}
			if (this.config.fullSize) {
				this.toggleFullSize();
			}
			jQuery(window).resize(function() {
				// aanhaken bij window resize
				if (_resizeTimeOut) {
					clearTimeout(_resizeTimeOut);
				}
				_resizeTimeOut = setTimeout(_resize, 200 /* milliseconds */);
			});

			if (this.config.fgAlphaSlider) {
				var aSlider = jQuery('<div id="transparantie" class="transparantieslider"></div>').prependTo(
						jQuery('#' + config.mapDiv)).slider({
					value : _opacity * 100,
					range : 'min',
					min : 10,
					max : 90,
					step : 10,
					animate : 'slow',
					slide : function(event, ui) {
						_setOpacity(ui.value / 100);
						jQuery(this).find('a:first').text(ui.value);
						jQuery(this).find('a:first').append('<span>' + OpenLayers.i18n('KEY_TRANSP_SLIDER_LABEL', {
							'0' : (100 - ui.value)
						}) + '</span>');
						jQuery(this).find('a:first').addClass('hasTooltip');
					}
				});
				// instellen initiele waarde voor slider GUI
				jQuery('#transparantie').find('a:first').addClass('hasTooltip');
				jQuery('#transparantie').find('a:first').text((_opacity * 100));
				jQuery('#transparantie').find('a:first').append(
						'<span role="tooltip">' + OpenLayers.i18n('KEY_TRANSP_SLIDER_LABEL', {
							'0' : (100 - (_opacity * 100))
						}) + '</span>');
			}
		},

		/**
		 * Accessor voor de kaart.
		 * 
		 * @return {OpenLayers.Map} object van deze Viewer of null als het
		 *         object niet is geinitialiseerd
		 * @deprecated probeer deze niet te gebruiken
		 */
		getMap : function() {
			(window.console && console.warn('Deprecated method called: Viewer::getMap().'));
			return _map;
		},

		/**
		 * verplaats en zoom de kaart naar de gevraagde locatie.
		 * 
		 * @param {number}
		 *            x de x coordinaat
		 * @param {number}
		 *            y de y coordinaat
		 * @param {number}
		 *            radius straal van het gebied
		 * @param {boolean}
		 *            withFeatureInfo voert een featureInfo request uit na
		 *            uitvoeren van de zoom en pan actie.
		 */
		zoomTo : function(x, y, radius, withFeatureInfo) {
			var b = new OpenLayers.Bounds(x - radius, y - radius, x + radius, y + radius);
			_map.zoomToExtent(b, true);

			if (withFeatureInfo) {
				// met een zoomend werkt het soms raar, maar met wachten op
				// loadend van het eerste wms thema gaat het vaker mis
				_map.events.register('zoomend', _map, _afterZoomTo(new OpenLayers.LonLat(x, y)));
			}
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
			_map.addControl(new OpenLayers.Control.KeyboardDefaults(
			/* alleen actief als de kaart focus heeft */
			// { observeElement : this.config.mapDiv }
			));
			_map.addControl(new ZoomControl());
			_map.addControl(new OpenLayers.Control.Navigation());
			_map.addControl(new OpenLayers.Control.KeyboardClick(
			/* alleen actief als de kaart focus heeft */
			// { observeElement : this.config.mapDiv }
			));
			_map.addControl(new WMSGetFeatureInfo({
				eventListeners : {
					getfeatureinfo : _showInfo
				}
			}));
			_map.addControl(new ClickDrawControl());
			_map.addControl(new OpenLayers.Control.ScaleLine({
				maxWidth : 200,
				bottomOutUnits : '' // geen mi/ft
			}));
			_map.addControl(new OverviewMap({
				mapOptions : {
					maxExtent : this.config.map.restrictedExtent,
					resolutions : this.config.map.resolutions,
					projection : this.config.map.projection,
					theme : null
				}
			}));
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
		 * Stelt de doorzichtigheid van de voorgrond kaart in.
		 * 
		 * @param opacity
		 *            float waarde tussen 0 1n 1
		 */
		setOpacity : function(opacity) {
			_setOpacity(opacity);
		},

		/**
		 * Voeg WMS toe aan de kaart. Uitgangspunt is dat de WMS transparante
		 * PNG ondersteund. eerder geladen WMS lagen worden verwijderd
		 * 
		 * @param {object}
		 *            wmsConfig Een object met WMS parameters. <code>
		 * {
		 * 'id' : 'cbs_inwoners_2010_per_hectare',
		 * 'name': 'Inwoners 2010 per hectare'
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
				singleTile : false,
				opacity : _opacity
			});

			if (wmsConfig.hasOwnProperty('zoom')) {
				if (_map.getZoom() < parseInt(wmsConfig.zoom))
					_map.zoomTo(wmsConfig.zoom);
			}

			setCookie(COOKIE.mapid, wmsConfig.id);
			_map.addLayer(layer);

			var fInfoControl = _map.getControlsByClass('WMSGetFeatureInfo');
			fInfoControl[0].url = wmsConfig.url;
		},

		/**
		 * verwijder de WMS uit de kaart (behalve als het een base layer is).
		 * 
		 * @param {string}
		 *            wmsLyrName naam van de WMS service
		 */
		removeWMS : function(wmsLyrName) {
			var lyrs = _map.getLayersByName(wmsLyrName);
			for (var lyr = 0; lyr < lyrs.length; lyr++) {
				if (!lyrs[lyr].isBaseLayer) {
					_map.removeLayer(lyrs[lyr]);
					lyrs[lyr].destroy();
				}
			}
		},

		/**
		 * verwijder alle overlays. Voorlopig alleen type {OpenLayers.Layer.WMS}
		 */
		removeOverlays : function() {
			// reset featureinfo text
			jQuery('#' + config.featureInfoDiv).html(OpenLayers.i18n('KEY_INFO_GEEN_FEATURES'));
			// verwijder ikoontjes die de controls tekenen
			var lyrs = _map.getLayersByName('ClickDrawControl'), lyr;
			for (lyr = 0; lyr < lyrs.length; lyr++) {
				lyrs[lyr].removeAllFeatures();
			}
			lyrs = _map.getLayersByName('OpenLayers.Handler.KeyboardPoint');
			for (lyr = 0; lyr < lyrs.length; lyr++) {
				lyrs[lyr].removeAllFeatures();
			}

			// verwijder WMS lagen
			lyrs = _map.getLayersByClass('OpenLayers.Layer.WMS');
			for (lyr = 0; lyr < lyrs.length; lyr++) {
				if (!lyrs[lyr].isBaseLayer) {
					_map.removeLayer(lyrs[lyr]);
					lyrs[lyr].destroy();
				}
			}

			eraseCookie(COOKIE.mapid);
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
				_map.updateSize();

				var vectors = _map.getLayersByClass("OpenLayers.Layer.Vector");
				if (vectors.length > 0) {
					// in dit geval is er een kaartlaag met een featureinfo
					// lokatie verschuif naar die lokatie
					var bounds = vectors[0].getDataExtent();
					_map.panTo(bounds.getCenterLonLat());
				}
			} else {
				// vergroten
				var borderW = parseInt(jQuery('#' + this.config.mapDiv).css('borderLeftWidth'), 10)
						+ parseInt(jQuery('#' + this.config.mapDiv).css('borderRightWidth'), 10);
				var borderH = parseInt(jQuery('#' + this.config.mapDiv).css('borderTopWidth'), 10)
						+ parseInt(jQuery('#' + this.config.mapDiv).css('borderBottomWidth'), 10);
				// inhoud padding set in css
				var headerH = parseInt(jQuery('#' + this.config.mapDiv).parent().parent().css('padding-top'), 10);
				var footerH = parseInt(jQuery('#' + this.config.mapDiv).parent().parent().css('padding-bottom'), 10);

				var w = jQuery('#' + this.config.mapDiv).parent().width() - borderW;
				var h = jQuery(window).height() - headerH - footerH - borderH;

				jQuery('#' + this.config.mapDiv).width(w).height(h);
				jQuery('#toggleSize').toggleClass('restore max');
				_fullSize = true;
				_map.updateSize();
			}
		},

		/**
		 * Stel de kaart in voor afdrukken.
		 */
		printPrepare : function() {
			if (_fullSize) {
				this.toggleFullSize();
			}
		},

		/**
		 * Toggle basemap.
		 */
		toggleBaseMap : function() {
			var topo = _map.getLayersByName('topografie')[0];
			var lufo = _map.getLayersByName('luchtfoto')[0];
			if (topo.getVisibility()) {
				_map.setBaseLayer(lufo);
				jQuery('#toggleBaseMap').text(OpenLayers.i18n('KEY_TOGGLE_BASEMAP_TOPO'));
				setCookie(COOKIE.baselyr, 'luchtfoto');
			} else {
				_map.setBaseLayer(topo);
				jQuery('#toggleBaseMap').text(OpenLayers.i18n('KEY_TOGGLE_BASEMAP_LUFO'));
				setCookie(COOKIE.baselyr, 'topografie');
			}
			jQuery('#toggleBaseMap').append('<span>' + OpenLayers.i18n('KEY_TOGGLE_BASEMAP_TITLE') + '</span>');
			jQuery('#toggleBaseMap').toggleClass('lufo topo');
		},

		/**
		 * set up basemaps.
		 * 
		 * @private
		 */
		addBaseMap : function() {
			// topo
			_map.addLayer(new OpenLayers.Layer.WMTS(jQuery.extend(true, this.config.map.topoWMTS, {
				name : 'topografie'
			})));
			// luchtfoto
			_map.addLayer(new OpenLayers.Layer.WMTS(jQuery.extend(true, this.config.map.aerialWMTS, {
				name : 'luchtfoto'
			})));

			if (getCookie(COOKIE.baselyr)) {
				_map.setBaseLayer(_map.getLayersByName(getCookie(COOKIE.baselyr))[0]);
			}
		}
	};
}();
