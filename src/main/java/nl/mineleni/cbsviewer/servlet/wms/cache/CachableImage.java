/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import java.awt.Image;

/**
 * Interface CachableImage. Beschrijft de functies die een afbeelding cachable
 * maken.
 * 
 * @param <T>
 *            the generic type of the object to cache.
 * @author prinsmc
 */
interface CachableImage<T extends Image> extends Cachable<T> {

	/**
	 * Accessor voor de naam van de gecachede afbeelding, bijvoorbeeld de
	 * bestandnaam.
	 * 
	 * @return de naam
	 */
	String getName();
}
