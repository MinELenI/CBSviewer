/**
 * @fileoverview event handlers en elementen voor de ria pagina.
 */

// multiple versions of JQuery/JQuery UI can cause problems.
jQuery.noConflict();

/**
 * document onload event handling.
 */
jQuery(document).ready(
	function() {
		// create map
		Viewer.init(config);

		if (getCookie(COOKIE.mapid)){
			config.defaultMapId = getCookie(COOKIE.mapid);
		}

		var maps = jQuery.grep(_layers, function(n, i) {
			return n.id == config.defaultMapId;
		});
		Viewer.loadWMS(maps[0]);

		if(getCookie(COOKIE.X) && getCookie(COOKIE.Y) && getCookie(COOKIE.S) ) {
			// cast cookies naar number + zoom in
			Viewer.zoomTo(getCookie(COOKIE.X)/1, getCookie(COOKIE.Y)/1, getCookie(COOKIE.S)/1, false);
		}
		
		/* popup */
		jQuery('.fancybox').fancybox();
		/* slidedown effect */
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
			jQuery('#legenda').css('max-height', 
					jQuery(window).height() - 
					jQuery('#footerWrapper').height() - 
					jQuery('.header').height() - 
					jQuery('#keyfeatureinfo').height() - 100
				);					
		});
		
		jQuery('#legenda').css('max-height', 
			jQuery(window).height() - 
			jQuery('#footerWrapper').height() - 
			jQuery('.header').height() - 
			jQuery('#keyfeatureinfo').height() - 100
		);	

		jQuery('#thememenu2Header').click(function() {
			jQuery('#thememenu2Content').load('main_menu_theme2_include.jsp');
		});		

		jQuery('.OverviewMapMaximizeButton').click(function() {	
			jQuery('#toggleBaseMap').css('bottom','150px');
			jQuery('#toggleBaseMap').css('right','10px');
		});

		jQuery('.OverviewMapMinimizeButton').click(function() {	
			jQuery('#toggleBaseMap').css('bottom','2px');
			jQuery('#toggleBaseMap').css('right','25px');
		});
		
		jQuery('#toggleSize').click(function() {	
			if (jQuery(this).hasClass('restore')) {
				jQuery(this).css('top','-1px');
				jQuery(this).css('right','-1px');			
			}
			else {
				jQuery(this).css('top','16px');
				jQuery(this).css('right','-23px');			
			}
		});
		
		jQuery('#infobox').html(OpenLayers.i18n('KEY_SELECTMENU_DEFAULT_HOVER'));
});
				
/**
 * Close megamenu on menu click
 * 
 * @returns false
 */ 
jQuery('#hasMenu').click(function() {
	if (parseInt(jQuery('.navDropDown').css('left')) < 0) {
		jQuery('.navDropDown').css('left', 'auto');
	} else {
		jQuery('.navDropDown').css('left', '-9999px');
	}
	return false;
});

/**
  * Close all sub menu's and open current
  */
jQuery(document).on('click', 'ul.navleft li, ul.navright li', function (event) {
    event.preventDefault();

	// hide all except the one clicked on
	jQuery('ul.submenu').not(jQuery(this).find('ul.submenu')).hide();
	jQuery('.menuAccordionContent').not(jQuery(this).find('a')).find('a').removeClass('submenuopened');
	
	if( !jQuery(this).find('ul.submenu').is(':visible') ) {
		jQuery(this).find('ul.submenu').show(70);
		jQuery(this).children('a').addClass('submenuopened');		
    }
	else {
		jQuery(this).find('ul.submenu').hide();
		jQuery(this).children('a').removeClass('submenuopened');
	}
});

/**
 * Show infobox on hover
 */
 jQuery(document).on('mouseover','.dropDownMenu a', function(event) {
	event.preventDefault();
	jQuery(this).children('span').css("display", "none");	
	jQuery('#infobox').html(jQuery(this).find('span').text());
});

/**
 * Hide infobox on mouseout
 */
 jQuery(document).on('mouseout','.dropDownMenu a', function(event) {
	jQuery('#infobox').html('');
});

/**
 * Hide main menu on click
 */
jQuery('.closeMega').click(function() {
	jQuery('.navDropDown').css('left', '-9999px');
});

/**
 * Change theme from menu
 * 
 * @param event
 *            DOM click event
 */ 
jQuery(document).on('click', '.megaMenu a', function(event) {
	event.preventDefault();
	
	// retrieve mapid from url
	function getURLParameter(name, url) {
		return decodeURIComponent
		(
			(new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(url)||[,""])[1].replace(/\+/g, '%20')
		)
		|| null;
	}

	var selectedMap = getURLParameter('mapid', jQuery(this).attr('href'));
	
	// only load new themes
	if (selectedMap != config.defaultMapId 
		&& selectedMap != null
		&& jQuery(this).attr('href') != '#'				
		&& jQuery(this).attr('class') != 'accordionheader') {
		
		var _id = selectedMap;

		var maps = jQuery.grep(_layers, function(n, i) {
			return n.id == _id;
		});
		Viewer.loadWMS(maps[0]);
		// bijwerken pagina titel, IE7/8 proof
		document.title = OpenLayers.i18n('KEY_KAART_TITEL', {
			'0' : '' + maps[0].name
		});
		
		jQuery('#pagSubTitle').html(OpenLayers.i18n('KEY_KAART_TITEL', {
			'0' : '' + maps[0].name
		}));

		// hide submenu
		jQuery('ul.submenu').hide();
		jQuery('.menuAccordionContent').find('a').removeClass('submenuopened');
		
		// bijwerken download link
		/*if (maps[0].link) {
			jQuery('#downloadLink').html(
					'<a href="' + maps[0].link + '">Download de dataset voor'
							+ OpenLayers.i18n('KEY_KAART_TITEL', {
								'0' : '' + maps[0].name
							}) + '</a>');
		} else {
			jQuery('#downloadLink').html('');
		}*/

		// close menu
		jQuery('.navDropDown').css('left', '-9999px');
		
		config.defaultMapId = _id;
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
				+ '\').attr(\'tabindex\',-1).focus(); return false;">' + OpenLayers.i18n('KEY_KEYBOARDNAV')
				+ '<br/>'+ OpenLayers.i18n('KEY_KEYBOARDNAV_TTL') + OpenLayers.i18n('KEY_MENU_HELP')+'</a>';
		jQuery('#' + config.mapDiv).before(aLink);

		// core link toevoegen aan de kaart voor het geval de javascript kaart
		// niet "goed" is
		var aCore = '<a id="naarCoreLink" class="accesskey" href="?coreonly=true">' 
						+ OpenLayers.i18n('KEY_CSSERROR') + '</a>';
		jQuery('#' + config.mapDiv).before(aCore);

		ZoekFormulier.init();

		// uitvouwen van de accordion na change event, klap de legenda in voor
		// meer duidelijkheid voor de gebruiker
		jQuery('#' + config.featureInfoDiv).change(function() {
			if (jQuery('#keyfeatureinfo a').attr('class') != 'active') {
				jQuery('#keyfeatureinfo a').next().stop(true, true).slideToggle('normal');
				jQuery('#keyfeatureinfo a').addClass('active');
			}
		});
	}
};

setupPage.init();
