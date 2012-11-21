/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 * Interface Caching.
 * 
 * @param <K>
 *            generic type voor de sleutel, bijvoorbeeld een bounding box.
 * @param <V>
 *            generic type voor de waarde, bijvoorlbeeld een Image
 * @param <T>
 *            the generic type
 */
interface Caching<K, V extends Cachable<T>, T> {

	/** Wist de complete cache. */
	void clear();

	/**
	 * Kijkt of de gegegeven sleuten in de cache voorkomt.
	 * 
	 * @param bbox
	 *            de sleutel
	 * @return true, if successful
	 */
	boolean containsKey(K bbox);

	/**
	 * Geeft de inhoud van de cache als {@code Set<Entry>}.
	 * 
	 * @return Entry set van de cache
	 */
	Set<Entry<K, V>> entrySet();

	/**
	 * Geeft de waarde die bij de gevraagde sleutel hoort, mits aanwezig in de
	 * cache, anders {@code null}. Gebruik {@link #containsKey(Object)} om te
	 * bepalen of er een mapping in de cache is voor deze sleutel.
	 * 
	 * @param bbox
	 *            de sleutel
	 * @return de waarde, of {@code null}
	 */
	V get(K bbox);

	/**
	 * haalt alle elementen op uit de cache met een verzameling sleutels.
	 * 
	 * @param collection
	 *            Verzameling sleutels waarvoor de waarden uit de cache moeten
	 *            worden gehaald.
	 * @return de verzamelingen elementen uit de cache
	 */
	Map<K, V> getAll(Collection<K> collection);

	/**
	 * Slaat de waarde op in de cache met de gegeven sleutel.
	 * 
	 * @param bbox
	 *            sleutel
	 * @param cacheValue
	 *            waarde
	 */
	void put(K bbox, V cacheValue);

	/**
	 * verwijder de sleutel uit de cache.
	 * 
	 * @param bbox
	 *            sleutel
	 */
	void remove(K bbox);

	/**
	 * Geeft de grootte van de cache.
	 * 
	 * @return het aantal elementen in de cache
	 */
	int size();
}
