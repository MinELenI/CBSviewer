/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
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

	/** het type. */
	private final String type;

	/**
	 * Instantiates a new basemap type.
	 * 
	 * @param type
	 *            het type
	 */
	BasemapType(final String type) {
		this.type = type;
	}

	/**
	 * Gets het type.
	 * 
	 * @return het type
	 */
	public String getType() {
		return this.type;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Enum#toString()
	 */
	@Override
	public String toString() {
		return this.type;
	}
}
