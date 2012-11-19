/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

/**
 * Beschrijft cacheable objecten.
 * 
 * @author prinsmc
 * 
 * @param <T>
 *            type cacheble object
 */
interface Cachable<T> {
	/**
	 * Gets de expire-by timestamp voor dit object.
	 * 
	 * @return the expire by
	 */
	long getExpireBy();

	/**
	 * Haalt het opgeslagen item {@code <T>} op.
	 * 
	 * @return item <T>
	 */
	T getItem();

	/**
	 * Controleert of dit object geldig is.
	 * 
	 * @return {@code true}, indien geldig
	 */
	boolean isValid();
}
