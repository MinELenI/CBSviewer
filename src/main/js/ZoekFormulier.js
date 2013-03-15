/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
/**
 * Functies voor het zoekformulier zoals gedefinieerd in zoekformulier.jsp.
 * 
 * @fileoverview zorgt voor afhandeling van het adreszoek formulier.
 * @author mprins
 * @requires jQuery
 * @requires jQueryUI
 * @requires zoekformulier.jsp
 * @requires Viewer.js
 * @class {ZoekFormulier}
 */
var ZoekFormulier = {
	/**
	 * Aanhaken van autocomplete handler aan input veld van zoek formulier.
	 * 
	 * @constructor
	 */
	init : function(viewer) {
		// de zoekknop, method en action van formulier verwijderen, die hebben geen funtie meer in de RIA
		jQuery('input:submit').attr("disabled", true);
		jQuery('#zoekFormulier').removeAttr('action');
		jQuery('#zoekFormulier').removeAttr('method');

		// verborgen velden instellen voor RIA functies
		jQuery('#zoekFormulier').find('input[name="coreonly"]').val('false');
		jQuery('#zoekFormulier').find('input[name="forward"]').val('false');

		// aanhaken auto complete
		jQuery('#adres').autocomplete({
			source : function(request, response) {
				jQuery.ajax({
					url : 'adres',
					data : {
						adres : request.term,
						forward : false,
						format : 'json',
						coreonly : false
					},
					dataType : 'json'
				}).success(function(data) {
					var results = jQuery.map(data, function(val, i) {
						return {
							label : val.addressString,
							x : val.xCoord,
							y : val.yCoord,
							r : val.radius
						};
					});
					response(results);
				});
			},
			select : function(event, ui) {
				// console.debug(ui.item ? "Gekozen: " + ui.item.value + "
				// (x,y,r) :" + ui.item.x + ","
				// + ui.item.y + "," + ui.item.r : "Niets gekozen, de input was
				// " + this.value);
				if (ui.item) {
					Viewer.zoomTo(ui.item.x, ui.item.y, ui.item.r, true);
					//Viewer.featureInfo(ui.item.x, ui.item.y);
				}
			},
			// alleen items uit de lijst mogen ingevuld/gekozen worden
			change : function(event, ui) {
				if (!ui.item) {
					jQuery(this).val('');
				}
			},
			minLength : 4 /* characters */,
			delay : 400 /* milliseconds */,
			autoFocus : false
		});
	}
};
