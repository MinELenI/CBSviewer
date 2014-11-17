/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 *
 * Gepubliceerd onder de BSD 2-clause licentie,
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.util;

/**
 * namen van de gebruikte cookies.
 *
 * @author Mark
 * @note bevat de namen van de gebruikte cookies
 */
public enum CookieNamesConstants {
	/**
	 * base layer.
	 */
	COOKIE_baselyr("baselyr"),
	/** map id. */
	COOKIE_mapid("mapid"),
	/** x coordinate. */
	COOKIE_X("x"),
	/** y coordinate. */
	COOKIE_Y("y"),
	/** zoom level. */
	COOKIE_S("s");

	/** De code (waarde) van dit object. */
	public final String value;

	/**
	 * Maakt een nieuw object aan met de gegeven code waarde.
	 *
	 * @param code
	 *            de code voor dit object
	 * @see #value
	 */
	CookieNamesConstants(final String code) {
		this.value = code;
	}

	/**
	 * Geeft de waarde van dit object terug. Analoog van {@link #code}
	 *
	 * @return de code
	 * @see #code
	 * @see java.lang.Enum#toString()
	 */
	@Override
	public String toString() {
		return this.value;
	}

	/**
	 * Maak een javascript representatie van dit object.
	 *
	 * @return een javascript statement van dit object, padded in een CDATA
	 *         sectie voor gebruik in xml documenten
	 */
	public static String asJavaScript() {
		final StringBuilder sb = new StringBuilder(
				"/* <![CDATA[ */ var COOKIE = {};");
		for (final CookieNamesConstants cconst : CookieNamesConstants.values()) {
			sb.append(cconst.name().replace('_', '.'));
			sb.append("='");
			sb.append(cconst.value);
			sb.append("',");
		}
		sb.deleteCharAt(sb.length() - 1);
		sb.append("; /* ]]> */");
		return sb.toString();
	}
}
