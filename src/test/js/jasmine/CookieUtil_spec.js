// dit wordt normaal in een java bean gegenereerd
/* <![CDATA[ */ var COOKIE = {};COOKIE.baselyr='baselyr',COOKIE.mapid='mapid',COOKIE.x='x',COOKIE.y='y',COOKIE.z='z'; /* ]]> */

/**
 * Jasmine Unit tests voor CookieUtil.
 * 
 * @author mprins
 */
describe('CookieUtil', function() {
	var _svalue = 'Cookie.MapID_testwaarde';

	describe('COOKIE keys test', function() {
		it('Opgeslagen cookie bestaat en heeft de juiste waarde', function() {
			setCookie(COOKIE.mapid, _svalue);
			expect(getCookie(COOKIE.mapid)).toEqual(_svalue);
		});

		it('Niet bestaande cookie opvragen geeft waarde null', function() {
			expect(getCookie(Math.random())).toBeNull();
		});
	});

	describe('Benoemde cookie wissen', function() {
		it('Gewiste cookie opvragen geeft waarde null', function() {
			eraseCookie(COOKIE.mapid);
			expect(getCookie(COOKIE.mapid)).toBeNull();
		});
	});

	describe('Cookies wissen', function() {
		it('Gewiste cookies opvragen geeft waarde null', function() {
			setCookie(COOKIE.mapid, "a");
			eraseCookies();
			expect(getCookie(COOKIE.mapid)).toBeNull();
			expect(getCookie(COOKIE.baselyr)).toBeNull();
			expect(getCookie(COOKIE.x)).toBeNull();
		});
	});
});