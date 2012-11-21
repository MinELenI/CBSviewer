/**
 * 
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.Set;

import org.junit.Before;
import org.junit.Test;

/**
 * Test case for {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache }.
 * 
 * @author mprins
 * 
 */
public class CacheTest {

	/** cache elements. */
	private final int CACHE_ELEMENTS = 100;

	/** een lege cache. */
	private Cache<String, CachableString, String> emptyCache;

	/** een gevulde cache. */
	private Cache<String, CachableString, String> filledCache;

	/** seconds to cache elements. */
	private final int MILLI_SECONDS_TO_CACHE_ELEMENTS = 120 * 1000;

	/** test key. */
	String testKey = "key";

	/** test value. */
	String testValue = "value";

	/**
	 * Sets up.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void setUp() throws Exception {
		this.emptyCache = new Cache<String, CachableString, String>(
				this.CACHE_ELEMENTS);
		this.filledCache = new Cache<String, CachableString, String>(
				this.CACHE_ELEMENTS);

		filledCache.put(this.testKey,
				new CachableString(this.testValue, System.currentTimeMillis()
						+ MILLI_SECONDS_TO_CACHE_ELEMENTS));
	}

	/**
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#clear()}.
	 */
	@Test
	public final void testClear() {
		this.filledCache.clear();
		this.emptyCache.clear();
		assertEquals(this.filledCache.mapSize(), this.emptyCache.mapSize());
		assertTrue(this.filledCache.mapSize() == 0);
	}

	/**
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#containsKey(java.lang.Object)}
	 * .
	 */
	@Test
	public final void testContainsKey() {
		assertTrue(this.filledCache.containsKey(this.testKey));
		assertFalse(this.emptyCache.containsKey(this.testKey));
	}

	/**
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#entrySet()}.
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
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#get(java.lang.Object)}
	 * .
	 */
	@Test
	public final void testGet() {
		assertNull(this.emptyCache.get(this.testKey));
		assertEquals(this.testValue, this.filledCache.get(this.testKey)
				.getItem());
	}

	/** test methode om max aantal elementen in de cache te testen. */
	@Test
	public void testOverSize() {
		for (int i = 0; i < this.CACHE_ELEMENTS + 10; i++) {
			this.emptyCache.put(this.testKey + i, new CachableString(
					this.testValue + i, System.currentTimeMillis()
							+ MILLI_SECONDS_TO_CACHE_ELEMENTS));
		}
		assertEquals(CACHE_ELEMENTS, this.emptyCache.size());
		assertEquals(CACHE_ELEMENTS, this.emptyCache.mapSize());
		assertEquals(CACHE_ELEMENTS, this.emptyCache.queueSize());
	}

	/**
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#put(java.lang.Object, nl.mineleni.cbsviewer.servlet.wms.cache.Cachable)}
	 * .
	 */
	@Test
	public final void testPut() {
		this.emptyCache.put(this.testKey, new CachableString(this.testValue,
				System.currentTimeMillis() + MILLI_SECONDS_TO_CACHE_ELEMENTS));
		assertEquals(1, this.emptyCache.size());

		// testKey zit al in deze cache!
		this.filledCache.put(this.testKey, new CachableString(this.testValue,
				System.currentTimeMillis() + MILLI_SECONDS_TO_CACHE_ELEMENTS));
		assertEquals(1, this.filledCache.size());

		assertEquals(this.filledCache.size(), this.emptyCache.size());
		assertTrue(this.filledCache.containsKey(this.testKey));
		assertTrue(this.emptyCache.containsKey(this.testKey));

		assertEquals(this.filledCache.get(this.testKey).getItem(),
				this.emptyCache.get(this.testKey).getItem());
	}

	/**
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#remove(java.lang.Object)}
	 * .
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
	 * Test method for
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.Cache#size()}.
	 */
	@Test
	public final void testSize() {
		assertEquals(1, this.filledCache.size());
		assertEquals(0, this.emptyCache.size());
	}
}
