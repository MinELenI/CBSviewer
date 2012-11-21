/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.awt.image.BufferedImage;

import org.junit.Before;
import org.junit.Test;

/**
 * Test case voor {@link CacheImage }.
 */
public class CacheImageTest {
	/** test subject. */
	private CacheImage cImage;

	/** expire by. */
	private final long expireBy = System.currentTimeMillis() + 1000 * 1000l;

	/** naam. */
	private final String name = "NAAM";

	/** to cache object. */
	private final BufferedImage rgbImage = new BufferedImage(100, 100,
			BufferedImage.TYPE_INT_RGB);

	/**
	 * Sets up.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void setUp() throws Exception {
		this.cImage = new CacheImage(this.rgbImage, this.name, this.expireBy);
	}

	/**
	 * Test methode voor {@link CacheImage#getImage() }.
	 */
	@Test
	public final void testGetImage() {
		assertEquals(this.rgbImage, this.cImage.getImage());
	}

	/**
	 * Test methode voor {@link CacheImage#getName() }.
	 */
	@Test
	public final void testGetName() {
		assertEquals(this.name, this.cImage.getName());
	}

	/**
	 * Test methode voor {@link CacheImage#isValid() }.
	 */
	@Test
	public final void testIsValid() {
		assertTrue(this.cImage.isValid());

		final CacheImage invalid = new CacheImage(this.rgbImage, null,
				this.expireBy);
		assertFalse(invalid.isValid());

		final CacheImage invalid2 = new CacheImage(null, null, this.expireBy);
		assertFalse(invalid2.isValid());

		final CacheImage invalid3 = new CacheImage(null, this.name,
				this.expireBy);
		assertFalse(invalid3.isValid());

		final CacheImage invalid4 = new CacheImage(null, this.name,
				this.expireBy - 1000l);
		assertFalse(invalid4.isValid());
	}
}
