/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import static org.junit.Assert.assertEquals;
import nl.mineleni.cbsviewer.util.xml.LayerDescriptor;
import nl.mineleni.cbsviewer.util.xml.ObjectFactory;

import org.geotools.geometry.Envelope2D;
import org.junit.Before;
import org.junit.Test;
import org.opengis.geometry.BoundingBox;

/**
 * test case voor.
 * 
 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey}.
 * 
 * @author mprins
 */
public class BboxLayerCacheKeyTest {

	/** key1. */
	private BboxLayerCacheKey key1;

	/** key2. */
	private BboxLayerCacheKey key2;

	/** bbox1. */
	private final BoundingBox bbox1 = new Envelope2D(null, 0, 0, 200, 200);

	/** bbox2. */
	private final BoundingBox bbox2 = new Envelope2D(null, 0, 0, 200, 200);

	/** ld. */
	private LayerDescriptor ld;

	/**
	 * set up.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void setUp() throws Exception {
		ld = (new ObjectFactory()).createLayerDescriptor();
		key1 = new BboxLayerCacheKey(bbox1, ld);
		key2 = new BboxLayerCacheKey(bbox2, ld);
	}

	/**
	 * Test method for.
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey#equals(java.lang.Object)}
	 * .
	 */
	@Test
	public final void testEqualsObject() {
		assertEquals(key1, key2);
	}

	/**
	 * Test method for.
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey#getBbox()}
	 * .
	 */
	@Test
	public final void testGetBbox() {
		assertEquals(bbox1, key1.getBbox());
	}

	/**
	 * Test method for.
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey#getLd()}
	 * .
	 */
	@Test
	public final void testGetLd() {
		assertEquals(ld, key1.getLd());
	}

	/**
	 * Test method for.
	 * 
	 * {@link nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey#hashCode()}
	 * .
	 */
	@Test
	public final void testHashCode() {
		assertEquals(key1.hashCode(), key2.hashCode());
	}
}
