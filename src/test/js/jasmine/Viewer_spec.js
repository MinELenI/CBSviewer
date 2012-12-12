/**
 * Jasmine Unit tests voor Viewer.
 * 
 * @author prinsmc
 */
describe(
		'Viewer',
		function() {
			it('Object type Viewer bestaat', function() {
				expect(Viewer).toBeDefined();
			});
			it('map object van Viewer is null', function() {
				expect(Viewer.getMap()).toBeNull();
			});

			describe(
					'Na het initialiseren van Viewer',
					function() {
						var _wms = {
							'name' : 'autochtonen_2011',
							'url' : 'http://geodata.nationaalgeoregister.nl/cbsvierkanten500m/wms',
							'layers' : 'autochtonen_2011',
							'styles' : 'cbsvierkanten500m.p_auto2011'
						};
						var _wms2 = {
							'name' : 'wijkenbuurten2011_thema_buurten2011_percentage_niet_westerse_allochtonen',
							'url' : 'http://geodata.nationaalgeoregister.nl/wijkenbuurten2011/wms',
							'layers' : 'cbs_buurten_2011',
							'styles' : 'wijkenbuurten2011_thema_buurten2011_percentage_niet_westerse_allochtonen'
						};

						beforeEach(function() {
							mapDiv = document.createElement('div');
							mapDiv.id = config.mapDiv;
							mapDiv.style.width = '300px';
							mapDiv.style.height = '300px';
							document.body.appendChild(mapDiv);

							Viewer.init(config);
						});

						afterEach(function() {
							Viewer.destroy();
							document.body.removeChild(mapDiv);
						});

						it('De kaart moet een OpenLayers.Map instance zijn', function() {
							expect(Viewer.getMap()).toBeInstanceOf(OpenLayers.Map);
						});

						it('De projectie van de kaart is gelijk aan de configuratie.', function() {
							expect(Viewer.getMap().projection).toEqual(config.map.projection);
						});

						it('De kaart moet 3 lagen hebben na toevoegen van 1 WMS', function() {
							Viewer.loadWMS(_wms);
							expect(Viewer.getMap().layers.length).toBe(3);
						});

						it('De kaart moet 3 lagen hebben na toevoegen van 2 WMS', function() {
							Viewer.loadWMS(_wms);
							Viewer.loadWMS(_wms2);
							expect(Viewer.getMap().layers.length).toBe(3);
						});

						it('De kaart moet 2 lagen hebben na toevoegen en verwijderen van 1 WMS', function() {
							Viewer.loadWMS(_wms);
							Viewer.removeWMS(_wms.name);
							expect(Viewer.getMap().layers.length).toBe(2);
						});

						it(
								'De kaart moet 1 laag en van type WMTS (de basemap) hebben na toevoegen en verwijderen van WMSsen',
								function() {
									Viewer.loadWMS(_wms);
									Viewer.loadWMS(_wms2);
									Viewer.removeOverlays();
									var lyrs = Viewer.getMap().layers;
									expect(lyrs.length).toBe(2);
									expect(lyrs[0]).toBeInstanceOf(OpenLayers.Layer.WMTS);
								});

						it('Na destroy is de kaart null', function() {
							Viewer.destroy();
							expect(Viewer.getMap()).toBeNull();
						});

						it('Full size is groter dan minimum na toggle.', function() {
							// maximize
							Viewer.toggleFullSize();
							var w = document.getElementById(config.mapDiv).style.width;
							expect(config.map.width).toBeLessThan(parseInt(w));
							var h = document.getElementById(config.mapDiv).style.height;
							// console.log('h:', h);
							expect(config.map.height).toBeLessThan(parseInt(h));

							// toggle back
							Viewer.toggleFullSize();
							w = document.getElementById(config.mapDiv).style.width;
							h = document.getElementById(config.mapDiv).style.height;
							expect(config.map.width).toEqual(parseInt(w));
							expect(config.map.height).toEqual(parseInt(h));
						});

						it(
								'na aanroepen van zoomTo is de x coordinaat voor het midden van de kaart gelijk aan gevraagd en is zoomnivo anders.',
								function() {
									var x = 150000, y = 300000, r = 20000;
									Viewer.zoomTo(x, y, r);
									var latlon = Viewer.getMap().getCenter();
									expect(latlon.lon).toEqual(x);
									// Openlayers geeft voorrang aan de breedte,
									// dus de hoogte wordt aangepast
									// expect(latlon.lat).toEqual(y);
									expect(Viewer.getMap().getZoom()).not.toEqual(config.map.initialZoom);
								});

						it('na schakelen basemap is de actieve basemap lufo', function() {
							Viewer.toggleBaseMap();
							expect(Viewer.getMap().baseLayer.name).toEqual('lufo');
						});

						it('na twee keer schakelen basemap is de actieve basemap topo', function() {
							Viewer.toggleBaseMap();
							Viewer.toggleBaseMap();
							expect(Viewer.getMap().baseLayer.name).toEqual('topo');
						});

						it('printpreview kaart afmeting is gelijk aan config.', function() {
							Viewer.printPrepare();
							var w = document.getElementById(config.mapDiv).style.width;
							var h = document.getElementById(config.mapDiv).style.height;
							expect(config.map.width).toEqual(parseInt(w));
							expect(config.map.height).toEqual(parseInt(h));
						});
					});

		});
