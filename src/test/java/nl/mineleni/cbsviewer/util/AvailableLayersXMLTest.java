/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.util;

import static org.custommonkey.xmlunit.XMLAssert.assertXpathEvaluatesTo;
import static org.custommonkey.xmlunit.XMLAssert.assertXpathExists;
import static org.custommonkey.xmlunit.XMLAssert.assertXpathNotExists;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import org.custommonkey.xmlunit.XMLUnit;
import org.custommonkey.xmlunit.exceptions.ConfigurationException;
import org.custommonkey.xmlunit.exceptions.XMLUnitRuntimeException;
import org.custommonkey.xmlunit.exceptions.XpathException;
import org.custommonkey.xmlunit.jaxp13.Validator;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.xml.sax.SAXException;

/**
 * Test case voor {@link AvailableLayers.xml} en {@link AvailableLayers.xsd}.
 * 
 * @author mprins
 */
public class AvailableLayersXMLTest {
	private static final String ID1 = "vierkanten500m_oad2000";

	private Validator v;

	/**
	 * Converteert een stream naar een string.
	 * 
	 * @param is
	 *            de InputStream met data
	 * @return de data als string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private static String convertStreamToString(final InputStream is)
			throws IOException {
		if (is != null) {
			final Writer writer = new StringWriter();
			final char[] buffer = new char[1024];
			try {
				final Reader reader = new BufferedReader(new InputStreamReader(
						is, "UTF-8"));
				int n;
				while ((n = reader.read(buffer)) != -1) {
					writer.write(buffer, 0, n);
				}
			} finally {
				is.close();
			}
			return writer.toString();
		} else {
			return "";
		}
	}

	/**
	 * set up before test case.
	 */
	@BeforeClass
	public static void initXmlUnit() {
		XMLUnit.setIgnoreWhitespace(true);
		XMLUnit.setIgnoreAttributeOrder(true);
		XMLUnit.setIgnoreComments(true);
		XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
	}

	/**
	 * after each test.
	 * 
	 */
	@After
	public void afterTest() {
		this.v = null;
	}

	/**
	 * set up before each test.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@Before
	public void beforeTest() throws Exception {
		this.v = new Validator();
		final Source schema = new StreamSource(new File(
				"target/classes/AvailableLayers.xsd"));
		this.v.addSchemaSource(schema);
	}

	/**
	 * XML testcase voor test {@link AvailableLayers.xml} en
	 * {@link invalidAvailableLayers.xml}, valideer documenten.
	 * 
	 * @throws IOException
	 */
	@Test
	public void testAvailableLayersXML() throws IOException {
		final Source invaliddoc = new StreamSource(this.getClass()
				.getClassLoader()
				.getResourceAsStream("invalidAvailableLayers.xml"));

		// final Source invaliddoc = new StreamSource(new File(
		// "target/test-classes/invalidAvailableLayers.xml"));
		try {
			assertFalse(this.v.isInstanceValid(invaliddoc));
			// fail("Expected excepion did not occur.");
		} catch (final XMLUnitRuntimeException x) {
			assertEquals("Schema is invalid", x.getMessage());
		}

		final Source doc = new StreamSource(this.getClass().getClassLoader()
				.getResourceAsStream("AvailableLayers.xml"));
		// final Source doc = new StreamSource(new File(
		// "target/test-classes/AvailableLayers.xml"));
		assertTrue(this.v.isInstanceValid(doc));

	}

	/**
	 * XML testcase voor test {@link AvailableLayers.xml} en
	 * {@link invalidAvailableLayers.xml}.
	 * 
	 * @throws IOException
	 */
	@Test
	public void testAvailableLayersXMLXPath() {
		// test inhoud van het geldige test document
		try {
			final String TESTXML = convertStreamToString(this.getClass()
					.getClassLoader()
					.getResourceAsStream("AvailableLayers.xml"));
			// vanwege gekkigheid in XPath werken selecties in de default
			// namespace niet, bijv.
			// /Layers/Layerdescriptor[1]/id faalt.
			// Daarom local-name functie gebruiken
			assertXpathExists(
					"/*[local-name()='Layers']/*[local-name()='Layerdescriptor']/*[local-name()='id']",
					TESTXML);

			assertXpathEvaluatesTo("" + 2,
					"count(//*[local-name()='Layerdescriptor'])", TESTXML);

			assertXpathEvaluatesTo(
					ID1,
					"//*[local-name()='Layerdescriptor'][1]/*[local-name()='id']",
					TESTXML);

			assertXpathExists(
					"//*[local-name()='Layerdescriptor'][2]/*[local-name()='link']",
					TESTXML);
			assertXpathNotExists(
					"//*[local-name()='Layerdescriptor'][1]/*[local-name()='link']",
					TESTXML);
		} catch (ConfigurationException | XpathException | IOException
				| SAXException e) {
			fail(e.getMessage());
		}
	}

	/**
	 * XML testcase voor {@link AvailableLayers.xsd}, valideer de xsd.
	 */
	@Test
	public void testAvailableLayersXSD() {
		try {
			assertTrue(this.v.isSchemaValid());
		} catch (final ConfigurationException e) {
			fail(e.getMessage());
		} catch (final Exception e) {
			fail(e.getMessage());
		}
	}

	/**
	 * XML testcase voor deployment {@link AvailableLayers.xml}, valideert het
	 * document dat in de war terecht komt.
	 */
	@Test
	public void testDeploymentAvailableLayersXML() {
		// final Source schema = new
		// StreamSource(this.getClass().getClassLoader()
		// .getResourceAsStream("AvailableLayers.xsd"));
		final Source doc = new StreamSource(Thread.currentThread()
				.getContextClassLoader()
				.getResourceAsStream("../classes/AvailableLayers.xml"));
		// final Source doc = new StreamSource(new
		// File("target/classes//AvailableLayers.xml"));
		assertTrue(this.v.isInstanceValid(doc));
	}

}
