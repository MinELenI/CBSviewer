/**
 * Functies voor het zoekformulier zoals gedefinieerd in zoekformulier.jsp.
 * 
 * @fileoverview zorgt voor afhandeling van het adreszoek formulier.
 * @author mprins
 * @requires jQuery
 * @requires zoekformulier.jsp
 * @requires Viewer.js
 * @class
 */
var ZoekFormulier = {
	/**
	 * aanhaken van handler aan submit event van formulier.
	 * 
	 * @constructor
	 */
	init : function() {
		jQuery('#zoekFormulier').ajaxForm({
			beforeSerialize : this.handleBeforeSerialize,
			success : this.handleSuccess,
			dataType : 'json',
			data : {
				format : 'json'
			}
		});
	},
	/**
	 * Bijwerken van verborgen velden in het formulier.
	 * 
	 * @param {String}
	 *            $form html snippet
	 * @param {Object}
	 *            options een jQuery.ajax options object
	 * @returns {Boolean} true to continue the request
	 * 
	 * @see http://docs.jquery.com/Ajax/jQuery.ajax#options
	 * @private
	 */
	handleBeforeSerialize : function($form, options) {
		$form.find('input[name="coreonly"]').val('false');
		$form.find('input[name="forward"]').val('false');
		return true;
	},
	/**
	 * Bijwerken van de pagina en eventueel de kaart inzoomen.
	 * 
	 * @param {Array}
	 *            data json array met adreslijst
	 * @param {String}
	 *            statusText response status tekst
	 * @param xhr
	 *            jQuery XHR
	 * @param {String}
	 *            $form html snippet
	 * 
	 * @todo Strings van de meldingen overbrengen naar resource bundle
	 * 
	 * @private
	 */
	handleSuccess : function(data, statusText, xhr, $form) {
		var html = "";
		var paragraaf = jQuery('#zoekresultaten');

		// in het geval dat een eerdere actie niets opleverde
		paragraaf.removeClass('error');

		switch (data.length) {
		case 0:
			paragraaf.addClass('error');
			html += 'Er is geen adres gevonden.';
			break;
		case 1:
			html += 'Er is een adres gevonden.';
			html += '<ul class="adreslijst"><li>' + data[0].addressString + '</li></ul>';
			Viewer.zoomTo(data[0].xCoord, data[0].yCoord, data[0].radius);
			break;
		default:
			html += 'Er zijn ' + data.length + ' adressen gevonden.';
			html += '<ul class="adreslijst">';
			for ( var i = 0; i < data.length; i++) {
				html += '<li>' + '<a href="#" onclick="Viewer.zoomTo(' + data[i].xCoord + ',' + data[i].yCoord + ','
						+ data[i].radius + ');return false;" title="Zoom naar adres">' + data[i].addressString
						+ '</a></li>';
			}
			html += '</ul>';
		}
		paragraaf.empty().html(html);
	},
};
