/**
 * @fileoverview event handlers en elementen voor de ria pagina.
 */

// opzoeken van de gevraagde kaart in de _layers, id's zitten in
// AvailableLayers.xml
var _defaultId = "wijkenbuurten2011_thema_gemeenten2011_aantal_inwoners";

/**
 * document onload event handling.
 */
jQuery(document)
		.ready(
				function() {
					// create map
					Viewer.init(config);

					var maps = jQuery.grep(_layers, function(n, i) {
						return n.id == _defaultId;
					});
					// console.debug('opzoeken van ' + _defaultId + ' in ',
					// _layers, maps);
					Viewer.loadWMS(maps[0]);

					// het accordion menu en settings panel werkt nu ook zonder
					// Javascript en CSS3.
					// Dit stukje zorgt voor een vloeiender menu
					var settings_head = jQuery('.settingsPanel > li > a');
					settings_head.first().addClass('active').next().slideDown('normal');

					settings_head.on('click', function(event) {
						event.preventDefault();

						jQuery(this).next().stop(true, true).slideToggle('normal');
						if (jQuery(this).attr('class') != 'active') {
							jQuery(this).addClass('active');
						} else {
							jQuery(this).removeClass('active');
						}
					});

					var menuAccordion_head = jQuery('.menuAccordion > li > .accordionheader'), menuAccordion_body = jQuery('.menuAccordion li > .menuAccordionContent');
					menuAccordion_head.first().addClass('active').next().slideDown('normal');
					menuAccordion_head.on('click', function(event) {
						event.preventDefault();

						if (jQuery(this).attr('class') != 'active') {
							menuAccordion_body.slideUp('normal');
							jQuery(this).next().stop(true, true).slideToggle('normal');
							menuAccordion_head.removeClass('active');
							jQuery(this).addClass('active');
						}
					});

					/*
					 * jQuery("#adres").keyup(function() {
					 * jQuery("#x").fadeIn(); if
					 * (jQuery.trim(jQuery("#adres").val()) == "") {
					 * jQuery("#x").fadeOut(); jQuery(".adreslijst").empty();
					 * jQuery("#zoekresultaten").empty(); } });
					 * 
					 * jQuery("#delete").click(function() {
					 * jQuery("#adres").val(""); jQuery(".adreslijst").empty();
					 * jQuery("#zoekresultaten").empty(); jQuery("#x").hide();
					 * });
					 */

					/* for testing purposes only at the moment */
					jQuery('#content a').click(function() {
						// Destroy currrent tooltip if present
						if (jQuery(this).data("qtip"))
							jQuery(this).qtip("destroy");

						jQuery(this).html('topRight').qtip({
							content : 'Dit is de inhoud',
							position : {
								adjust : {
									screen : true,
									scroll : true,
									resize : true
								}
							},
							show : {
								solo : true,
								when : false,
								ready : true
							},
							hide : false,
							style : {
								border : {
									width : 1,
									radius : 3
								},
								padding : 5,
								textAlign : 'center',
								tip : true,
								name : 'light'
							}
						});
					});

					/*
					 * Fix this just like the accordion
					 * jQuery('.hasMenu').focus(function() { if
					 * (jQuery('.navDropDown').css('left') == '0px') {
					 * jQuery(".navDropDown").css("left","-9999px");
					 * jQuery(".megaMenu").focus(); } else {
					 * jQuery(".navDropDown").css("left","0px"); } });
					 */
				});

// jQuery('.megaMenu a').mouseover(function() {
// jQuery('span',this).html('Get name from AvailableLayers.xml?');
// });

/**
 * Change theme from menu
 */
jQuery('.megaMenu a').click(
		function() {
			// only load new themes
			if (jQuery(this).attr('name') != _defaultId && jQuery(this).attr('class') != 'accordionheader') {
				var _id = jQuery(this).attr('name');

				var maps = jQuery.grep(_layers, function(n, i) {
					return n.id == _id;
				});
				Viewer.loadWMS(maps[0]);
				// bijwerken pagina titel
				jQuery('title').html(OpenLayers.i18n('KEY_KAART_TITEL', {
					'0' : '' + maps[0].name
				}));
				jQuery('#pagSubTitle').html(OpenLayers.i18n('KEY_KAART_TITEL', {
					'0' : '' + maps[0].name
				}));

				// bijwerken download link
				if (maps[0].link) {
					jQuery('#downloadLink').html(
							'<a href="' + maps[0].link + '">Download de dataset voor'
									+ OpenLayers.i18n('KEY_KAART_TITEL', {
										'0' : '' + maps[0].name
									}) + '</a>');
				} else {
					jQuery('#downloadLink').html('');
				}

				_defaultId = _id;
			}
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

		// a11y link toevoegen in de DOM boven de kaart
		var aLink = '<a id="activeerKeys" class="accesskey" href="" accesskey="1" onclick="jQuery(\'#' + config.mapDiv
				+ '\').attr(\'tabindex\',-1).focus(); return false;" title="' + OpenLayers.i18n('KEY_KEYBOARDNAV_TTL')
				+ '">' + OpenLayers.i18n('KEY_KEYBOARDNAV') + '</a>';
		jQuery('#' + config.mapDiv).prepend(aLink);

		// core link toevoegen aan de kaart voor het geval de javascript kaart
		// niet "goed" is
		var aCore = '<a id="naarCoreLink" class="accesskey" href="?coreonly=true">' + OpenLayers.i18n('KEY_CSSERROR')
				+ '</a>';
		jQuery('#' + config.mapDiv).prepend(aCore);

		ZoekFormulier.init();
		ZoekFormulier.addPlaceholders();

		// uitvouwen van de accordion na change event, klap de legenda in voor
		// meer duideijkheid voor de gebruiker
		jQuery('#' + config.featureInfoDiv).change(function() {
			if (jQuery('#keyfeatureinfo a').attr('class') != 'active') {
				jQuery('#keyfeatureinfo a').next().stop(true, true).slideToggle('normal');
				jQuery('#keyfeatureinfo a').addClass('active');
			}
		});
	}
};

setupPage.init();
