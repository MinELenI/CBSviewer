/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Set;

import org.geotools.geometry.Envelope2D;
import org.junit.Before;
import org.junit.Test;
import org.opengis.geometry.BoundingBox;

/**
 * @author prinsmc
 */
public class WMSCacheTest {
	private final int CACHE_ELEMENTS = 100;

	/** cache directory. */
	private final String CACHEDIR = "target";

	/** een lege cache */
	private WMSCache emptyCache;

	/** een gevulde cache */
	private WMSCache filledCache;

	private final int SECONDS_TO_CACHE_ELEMENTS = 120;

	/** to cache key. */
	private final BoundingBox testKey = new Envelope2D(null, 0, 0, 200, 200);
	/** to cache object. */
	private final BufferedImage testValue = new BufferedImage(100, 100,
			BufferedImage.TYPE_INT_RGB);

	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		this.emptyCache = new WMSCache(this.CACHEDIR, this.CACHE_ELEMENTS);

		final HashMap<BoundingBox, BufferedImage> cacheData = new HashMap<BoundingBox, BufferedImage>();
		cacheData.put(this.testKey, this.testValue);
		this.filledCache = new WMSCache(cacheData, this.CACHEDIR,
				this.CACHE_ELEMENTS, this.SECONDS_TO_CACHE_ELEMENTS);
	}

	/**
	 * Test methode voor {@link WMSCache#clear()} .
	 */
	@Test
	public final void testClear() {
		this.filledCache.clear();
		this.emptyCache.clear();
		assertEquals(this.filledCache.mapSize(), this.emptyCache.mapSize());
		assertTrue(this.filledCache.mapSize() == 0);
	}

	/**
	 * Test methode voor
	 * {@link WMSCache#containsKey(org.opengis.geometry.BoundingBox)} .
	 */
	@Test
	public final void testContainsKey() {
		assertTrue(this.filledCache.containsKey(this.testKey));
		assertFalse(this.emptyCache.containsKey(this.testKey));
	}

	/**
	 * Test methode voor {@link WMSCache#entrySet()} .
	 */
	@Test
	public final void testEntrySet() {
		final Set<?> emptySet = this.emptyCache.entrySet();
		assertNotNull(emptySet);
		assertEquals(0, emptySet.size());

		final Set<?> filledSet = this.filledCache.entrySet();
		assertNotNull(filledSet);
		assertEquals(1, filledSet.size());
	}

	/**
	 * Test methode voor {@link WMSCache#get(org.opengis.geometry.BoundingBox)}
	 * .
	 */
	@Test
	public final void testGet() {
		assertNull(this.emptyCache.get(this.testKey));
		assertEquals(this.testValue, this.filledCache.get(this.testKey)
				.getImage());
	}

	/**
	 * Test methode voor {@link WMSCache#getCacheDir()} .
	 */
	@Test
	public final void testGetCacheDir() {
		assertEquals(this.CACHEDIR, this.filledCache.getCacheDir());
	}

	/**
	 * Test methode voor {@link WMSCache#WMSCache(String) } test een ongeldig pad
	 * .
	 */
	@Test
	public final void testInvalidCachePath() {
		try {
			this.emptyCache = new WMSCache("pom.xml", this.CACHE_ELEMENTS);
			fail("Verwachte fout is niet opgetreden");
		} catch (final IOException e) {
			assertTrue(true);
		}
	}

	/** test methode om max aantal elementen in de cache te testen. */
	@Test
	public void testOverage() {
		for (int i = 0; i < 110; i++) {
			this.emptyCache.put(new Envelope2D(null, i, i, 200 + 1, 200 + 1),
					this.testValue, 500);
		}
		assertEquals(100, this.emptyCache.size());
		assertEquals(100, this.emptyCache.mapSize());
		assertEquals(100, this.emptyCache.queueSize());
	}

	/**
	 * Test methode voor {@link WMSCache#put(BoundingBox, BufferedImage) } .
	 */
	@Test
	public final void testPut() {
		this.emptyCache.put(this.testKey, this.testValue,
				this.SECONDS_TO_CACHE_ELEMENTS);
		assertEquals(1, this.emptyCache.size());

		// testKey zit al in deze cache!
		this.filledCache.put(this.testKey, this.testValue,
				this.SECONDS_TO_CACHE_ELEMENTS);
		assertEquals(1, this.filledCache.size());

		assertEquals(this.filledCache.size(), this.emptyCache.size());
		assertTrue(this.filledCache.containsKey(this.testKey));
		assertTrue(this.emptyCache.containsKey(this.testKey));

		assertEquals(this.filledCache.get(this.testKey).getImage(),
				this.emptyCache.get(this.testKey).getImage());

	}

	/**
	 * Test methode voor {@link WMSCache#size()} .
	 */
	@Test
	public final void testRemove() {
		// testKey zit al in deze cache!
		this.filledCache.remove(this.testKey);
		assertFalse(this.filledCache.containsKey(this.testKey));
		assertNull(this.filledCache.get(this.testKey));
		assertEquals(0, this.filledCache.size());
		assertEquals(0, this.filledCache.mapSize());
	}

	/**
	 * Test methode voor {@link WMSCache#size()} .
	 */
	@Test
	public final void testSize() {
		assertEquals(1, this.filledCache.size());
		assertEquals(0, this.emptyCache.size());
	}
}
