/*
 * Copyright (c) 2013-2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.util;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.List;

import nl.mineleni.cbsviewer.util.xml.LayerDescriptor;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import flexjson.JSONDeserializer;

/**
 * Test case voor {@link AvailableLayersBean}.
 * 
 * @author prinsmc
 */
public class AvailableLayersBeanTest {
	private static final String ID1 = "vierkanten500m_oad2000";
	private static final String LAYERS1 = "omgevings_adres_dichtheid_2000";
	private static final String STYLES1 = "cbsvierkanten500m.oad2000";
	private static final String NAME1 = "Omgevingsadressendichtheid 2000 - Vierkant 500m";
	private static final String URL1 = "http://geodata.nationaalgeoregister.nl/cbsvierkanten500m/wms";

	/** test subject. */
	private AvailableLayersBean bean;

	/**
	 * set up before each test.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void beforeTest() throws Exception {
		this.bean = new AvailableLayersBean();
	}

	/**
	 * after each test.
	 * 
	 */
	@After
	public void afterTest() {
		this.bean = null;
	}

	/**
	 * testcase voor {@link AvailableLayersBean#asJSON()}.
	 */
	@Test
	public void testAsJSON() {
		assertTrue(this.bean.asJSON().startsWith(
				"\n/* <![CDATA[ */ var _layers="));
	}

	/**
	 * testcase voor {@link AvailableLayersBean#asJSON(boolean) }.
	 */
	@Test
	public void testAsJSONBoolean() {
		assertTrue(this.bean.asJSON(true).startsWith(
				"\n/* <![CDATA[ */ var _layers="));
		assertFalse(this.bean.asJSON(false).startsWith(
				"\n/* <![CDATA[ */ var _layers="));
		assertTrue(this.bean.asJSON(false).startsWith("["));
		// round trip tests
		List<LayerDescriptor> layers = new JSONDeserializer<List<LayerDescriptor>>()
				.use("values", LayerDescriptor.class).deserialize(
						this.bean.asJSON(false));
		assertFalse(layers.isEmpty());
		assertEquals(NAME1, layers.get(0).getName());
	}

	/**
	 * testcase voor {@link AvailableLayersBean#getLayerByID(String)}.
	 */
	@Test
	public void testGetLayerByID() {
		assertEquals(ID1, this.bean.getLayerByID(ID1).getId());
		assertEquals(NAME1, this.bean.getLayerByID(ID1).getName());
	}

	/**
	 * testcase voor
	 * {@link AvailableLayersBean#getLayerByLayers(String, String) }.
	 * 
	 * 
	 */
	@Test
	public void testGetLayerByLayersStringString() {
		assertEquals(ID1, this.bean.getLayerByLayers(LAYERS1, URL1).getId());
	}

	/**
	 * testcase voor
	 * {@link AvailableLayersBean#getLayerByLayers(String,String, String) }.
	 */
	@Test
	public void testGetLayerByLayersStringStringString() {
		assertEquals(ID1, this.bean.getLayerByLayers(LAYERS1, URL1, STYLES1)
				.getId());
	}

	/**
	 * testcase voor
	 * {@link nl.mineleni.cbsviewer.util.AvailableLayersBean#getLayerByName(String)}
	 * .
	 */
	@Test
	public void testGetLayerByName() {
		assertEquals(ID1, this.bean.getLayerByName(NAME1).getId());
		assertEquals(NAME1, this.bean.getLayerByName(NAME1).getName());
	}

	/**
	 * testcase voor
	 * {@link nl.mineleni.cbsviewer.util.AvailableLayersBean#getLayers()}.
	 */
	@Test
	public void testGetLayers() {
		assertEquals(2, this.bean.getLayers().size());
		// test ook de ordering van de onderliggende arraylist
		assertEquals(ID1, this.bean.getLayers().get(0).getId());
	}

	/**
	 * testcase voor
	 * {@link nl.mineleni.cbsviewer.util.AvailableLayersBean#getLayers()}.
	 */
	@Test(expected = UnsupportedOperationException.class)
	public void testGetLayersImmutable() {
		this.bean.getLayers().add(new LayerDescriptor());
	}
}