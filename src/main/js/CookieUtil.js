/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */

/**
 * Cookie utilities.
 * @author mprins
 */

/**
 * Sla een waarde op in een cookie met een verval tijd van 90 dagen.
 * 
 * @param key
 *            sleutel voor de cookie
 * @param value
 *            waarde voor de cookie
 */
function setCookie(key, value) {
	var expires = new Date();
	expires.setTime(expires.getTime() + (90 * 24 * 60 * 60 * 1000));
	document.cookie = key + '=' + encodeURIComponent(value) + ';path=/;expires=' + expires.toUTCString();
}

/**
 * Lees een waarde uit een cookie.
 * 
 * @param key
 *            zoeksleutel
 * @returns de waarde of null indien de cookie geen waarde heeft of niet
 *          bestaat.
 */
function getCookie(key) {
	var value = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
	return value ? decodeURIComponent(value[2]) : null;
}

/**
 * wis de gevraagde cookie.
 * 
 * @param key
 *            te wissen cookie
 */
function eraseCookie(key) {
	date = new Date();
	date.setDate(date.getDate() - 1);
	document.cookie = key + '=;path=/;expires=' + date.toUTCString();
}

/**
 * Alle cookies die we kennen wissen.
 */
function eraseCookies() {
	for ( var key in COOKIE) {
		if (COOKIE.hasOwnProperty(key)) {
			eraseCookie(key);
		}
	}
}