/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicInteger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * De Class Cache.
 * 
 * @param <K>
 *            het key type
 * @param <V>
 *            het value type
 * @param <T>
 *            het generic type
 * @author prinsmc
 */
public class Cache<K, V extends Cachable<T>, T> implements Caching<K, V, T> {
	/** logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(Cache.class);

	/** de cache. */
	private final Map<K, V> cache;

	/** aantal cache entries. */
	private final AtomicInteger cacheSize = new AtomicInteger();
	/**
	 * Used to restrict the size of the cache map.
	 */
	private final Queue<K> queue;
	/** max. aantal cache entries. */
	private final int maxSize;

	/**
	 * Instantiates a new cache.
	 * 
	 * @param maxSize
	 *            the max size
	 */
	public Cache(final int maxSize) {
		this.maxSize = maxSize;
		this.cache = new ConcurrentHashMap<K, V>(maxSize);
		this.queue = new ConcurrentLinkedQueue<K>();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.Caching#clear()
	 */
	@Override
	public void clear() {
		this.cache.clear();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Caching#containsKey(java.lang
	 * .Object)
	 */
	@Override
	public boolean containsKey(final K key) {
		return this.cache.containsKey(key);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.ImageCache#entrySet()
	 */
	@Override
	public Set<Entry<K, V>> entrySet() {
		final HashMap<K, V> s = new HashMap<K, V>();
		for (final Entry<K, V> e : this.cache.entrySet()) {
			s.put(e.getKey(), e.getValue());
		}
		return s.entrySet();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Caching#get(java.lang.Object)
	 */
	@Override
	public V get(final K key) {
		if (key == null) {
			throw new IllegalArgumentException("Invalid Key.");
		}
		final V entry = this.cache.get(key);
		if (entry == null) {
			return null;
		}

		final long timestamp = entry.getExpireBy();
		if ((timestamp != -1) && (System.currentTimeMillis() > timestamp)) {
			this.remove(key);
			return null;
		}
		return entry;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Caching#getAll(java.util.Collection
	 * )
	 */
	@Override
	public Map<K, V> getAll(final Collection<K> collection) {
		final Map<K, V> ret = new HashMap<K, V>();
		for (final K o : collection) {
			ret.put(o, this.get(o));
		}
		return ret;
	}

	/**
	 * Map size.
	 * 
	 * @return the int
	 */
	public int mapSize() {
		return this.cache.size();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Caching#put(java.lang.Object,
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Cachable)
	 */
	@Override
	public void put(final K key, final V cacheValue) {
		if (key == null) {
			throw new IllegalArgumentException("Invalid Key.");
		}
		if (cacheValue == null) {
			throw new IllegalArgumentException("Invalid Value.");
		}

		final boolean exists = this.cache.containsKey(key);
		if (!exists) {
			this.cacheSize.incrementAndGet();
			while (this.cacheSize.get() > this.maxSize) {
				this.remove(this.queue.poll());
			}
		}
		this.cache.put(key, cacheValue);
		this.queue.add(key);
	}

	/**
	 * Queue size.
	 * 
	 * @return the int
	 */
	public int queueSize() {
		return this.queue.size();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.wms.cache.Caching#remove(java.lang.Object)
	 */
	@Override
	public void remove(final K key) {
		final V entry = this.cache.get(key);
		if (entry != null) {
			this.cacheSize.decrementAndGet();
			this.cache.remove(key);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.Caching#size()
	 */
	@Override
	public int size() {
		LOGGER.debug("cache bevat " + this.cache.size() + " elementen.");
		return this.cacheSize.get();
	}
}
