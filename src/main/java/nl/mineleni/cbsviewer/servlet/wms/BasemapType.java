/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms;

/**
 * Het type basemap.
 * 
 * @author mprins
 * @since 1.6
 * 
 */
public enum BasemapType {
	/** het type "luchtfoto". */
	luchtfoto("luchtfoto"),
	/** het type "topografie". */
	topografie("topografie");

	private final String type;

	BasemapType(String type) {
		this.type = type;
	}

	public String getType() {
		return this.type;
	}

	@Override
	public String toString() {
		return this.type;
	}
}