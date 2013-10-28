/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms;

import java.io.File;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import org.custommonkey.xmlunit.XMLUnit;
import org.custommonkey.xmlunit.exceptions.ConfigurationException;
import org.custommonkey.xmlunit.exceptions.XMLUnitRuntimeException;
import org.custommonkey.xmlunit.jaxp13.Validator;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assume.assumeNotNull;

/**
 * Test case voor
 * {@link nl.mineleni.cbsviewer.servlet.wms.AttributeValuesFilter}.
 * 
 * @author prinsmc
 */
public class AttributeValuesFilterTest {
	/** test subject. */
	private AttributeValuesFilter filter;

	/**
	 * set up.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void setUp() throws Exception {
		XMLUnit.setIgnoreWhitespace(true);
		XMLUnit.setIgnoreComments(true);
		this.filter = new AttributeValuesFilter();
	}

	/**
	 * Test voor
	 * {@link nl.mineleni.cbsviewer.servlet.wms.AttributeValuesFilter#hasFilters()}
	 * .
	 */
	@Test
	public void testHasFilters() {
		assertTrue(this.filter.hasFilters());
	}

	/**
	 * Test voor
	 * {@link nl.mineleni.cbsviewer.servlet.wms.AttributeValuesFilter#filterValue(String)}
	 * .
	 */
	@Test
	public void testFilterValue() {
		assertEquals("expected", this.filter.filterValue("expected"));
		assertEquals("geheim", this.filter.filterValue(-99997));
	}

	/**
	 * XML testcase voor deployment {@link validAttributeValuesFilter.xml} en
	 * {@link invalidAttributeValuesFilter.xml}.
	 */
	@Test
	public void testAttributeValuesFilterXML() {
		// valideer document
		final Validator v = new Validator();
		final Source schema = new StreamSource(this.getClass().getClassLoader()
				.getResourceAsStream("AttributeValuesFilter.xsd"));
		v.addSchemaSource(schema);

		// test resources
		final Source validdoc = new StreamSource(this.getClass()
				.getClassLoader()
				.getResourceAsStream("validAttributeValuesFilter.xml"));
		assertTrue(v.isInstanceValid(validdoc));

		final Source invaliddoc = new StreamSource(this.getClass()
				.getClassLoader()
				.getResourceAsStream("invalidAttributeValuesFilter.xml"));
		try {
			v.isInstanceValid(invaliddoc);
			fail("Expected excepion did not occur.");
		} catch (final XMLUnitRuntimeException x) {
			assertEquals("Schema is invalid", x.getMessage());
		}
	}

	/**
	 * XML testcase voor {@link AttributeValuesFilter.xsd}.
	 */
	@Test
	public void testAttributeValuesFilterXSD() {
		try {
			// valideer xsd
			final Source schema = new StreamSource(this.getClass()
					.getClassLoader()
					.getResourceAsStream("AttributeValuesFilter.xsd"));
			final Validator v = new Validator();
			v.addSchemaSource(schema);
			assertTrue(v.isSchemaValid());
		} catch (final ConfigurationException e) {
			fail(e.getMessage());
		}
	}

	/**
	 * XML testcase voor deployment {@link AttributeValuesFilter.xml}.
	 */
	@Test
	public void testDeploymentAttributeValuesFilterXML() {
		// valideer document
		final Validator v = new Validator();
		final Source schema = new StreamSource(this.getClass().getClassLoader()
				.getResourceAsStream("AttributeValuesFilter.xsd"));
		v.addSchemaSource(schema);
		// deployment resource
		//final Source doc = new StreamSource(Thread.currentThread()
		//		.getContextClassLoader()
		//		.getResourceAsStream("../classes/AttributeValuesFilter.xml"));
		final Source doc = new StreamSource(
				new File("target/classes/AttributeValuesFilter.xml"));
		assumeNotNull(doc);
		assertTrue(v.isInstanceValid(doc));

	}
}