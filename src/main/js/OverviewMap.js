/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
/**
 * Overzichtskaart, gebaseerd op OpenLayers.Control.OverviewMap.
 * 
 * @author mprins
 * @class {OverviewMap}
 * @extends {OpenLayers.Control.OverviewMap}
 */
OverviewMap = OpenLayers.Class(OpenLayers.Control.OverviewMap, {

	/** @override */
	maximized : true,

	/** @override */
	mapOptions : {
		theme : null
	},

	/** @override */
	size : {
		w : 140,
		h : 140
	},
	
	/** @override */
	autoPan : true,

	/**
	 * Constructor: OpenLayers.Control.OverviewMap Create a new overview map
	 * 
	 * Parameters: options - {Object} Properties of this object will be set on
	 * the overview map object. Note, to set options on the map object contained
	 * in this control, set <mapOptions> as one of the options properties.
	 * 
	 * @override
	 */
	initialize : function(options) {
		this.layers = [];
		this.handlers = {};
		OpenLayers.Control.prototype.initialize.apply(this, [ options ]);
	},

	/**
	 * Method: draw Render the control in the browser.
	 * 
	 * @override
	 */
	draw : function() {
		OpenLayers.Control.prototype.draw.apply(this, arguments);
		if (this.layers.length === 0) {
			if (this.map.baseLayer) {
				var layer = this.map.baseLayer.clone();
				this.layers = [ layer ];
			} else {
				this.map.events.register("changebaselayer", this, this.baseLayerDraw);
				return this.div;
			}
		}

		// create overview map DOM elements
		this.element = document.createElement('div');
		this.element.className = this.displayClass + 'Element';
		this.element.style.display = 'none';

		this.mapDiv = document.createElement('div');
		this.mapDiv.style.width = this.size.w + 'px';
		this.mapDiv.style.height = this.size.h + 'px';
		this.mapDiv.style.position = 'relative';
		this.mapDiv.style.overflow = 'hidden';
		this.mapDiv.id = OpenLayers.Util.createUniqueID('overviewMap');

		this.extentRectangle = document.createElement('div');
		this.extentRectangle.style.position = 'absolute';
		this.extentRectangle.style.zIndex = 1000; // HACK
		this.extentRectangle.className = this.displayClass + 'ExtentRectangle';

		this.element.appendChild(this.mapDiv);

		this.div.appendChild(this.element);

		this.div.className += " " + this.displayClass + 'Container';

		// maximize button
		var btn = document.createElement("button");
		btn.innerHTML = '+';
		btn.type = 'button';
		btn.name = 'tonen';
		this.maximizeDiv = btn;
		this.maximizeDiv.style.display = 'none';
		this.maximizeDiv.className = this.displayClass + 'MaximizeButton overviewMapButton olButton';
		this.maximizeDiv.title = OpenLayers.i18n('KEY_TOGGLE_OVERVIEW_ON');
		this.div.appendChild(this.maximizeDiv);

		// minimize button
		var btn = document.createElement("button");
		btn.innerHTML = '−';
		btn.type = 'button';
		btn.name = 'verbergen';
		this.minimizeDiv = btn;
		this.minimizeDiv.style.display = 'none';
		this.minimizeDiv.className = this.displayClass + 'MinimizeButton overviewMapButton olButton';
		this.minimizeDiv.title = OpenLayers.i18n('KEY_TOGGLE_OVERVIEW_OFF');;
		this.div.appendChild(this.minimizeDiv);

		this.minimizeControl();

		if (this.map.getExtent()) {
			this.update();
		}

		this.map.events.on({
			buttonclick : this.onButtonClick,
			moveend : this.update,
			scope : this
		});

		if (this.maximized) {
			this.maximizeControl();
		}
		return this.div;
	},

	CLASS_NAME : 'OverviewMap'
});
