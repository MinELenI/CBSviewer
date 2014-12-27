/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;

/**
 * Test case voor
 * {@link nl.mineleni.cbsviewer.servlet.wms.AttributesNamesFilter}.
 * 
 * @author mprins
 */
public class AttributesNamesFilterTest {
	/** test subject. */
	private AttributesNamesFilter filter;

	/** layer id voor layer met aliases. */
	private final String hasFilterID = "gemeenten2011_aantal_inwoners";

	/** layer id voor layer zonder aliases. */
	private final String hasNoFilterID = "vierkanten500m_oad2000";

	/**
	 * set up.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void setUp() throws Exception {
		this.filter = new AttributesNamesFilter();
	}

	/**
	 * Test voor
	 * {@link nl.mineleni.cbsviewer.servlet.wms.AttributesNamesFilter#filterValue(String, String) }
	 * .
	 */
	@Test
	public void testFilterValue() {
		assertEquals("expected",
				this.filter.filterValue("expected", this.hasFilterID));
		assertEquals("Gemeente",
				this.filter.filterValue("gemeentenaam", this.hasFilterID));
		assertEquals("expected",
				this.filter.filterValue("expected", this.hasNoFilterID));
	}
}
