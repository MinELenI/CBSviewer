/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

import static javax.servlet.http.HttpServletResponse.SC_OK;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.custommonkey.xmlunit.Validator;
import org.custommonkey.xmlunit.XMLUnit;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;

/**
 * Testcases voor jsp's in het project.
 * 
 * @author mprins
 */
public abstract class JSPIntegrationTest {
	/**
	 * test client.
	 */
	protected static HttpClient client;
	/**
	 * validation string.
	 */
	public static final String RESPONSEPROLOG = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
			+ "\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
			+ "\n<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"nl\" xml:lang=\"nl\">";

	/**
	 * init XMLUnit.
	 * 
	 * @throws Exception
	 */
	@BeforeClass
	public static void setUpClass() throws Exception {
		XMLUnit.setIgnoreWhitespace(false);
		XMLUnit.setIgnoreAttributeOrder(true);
		XMLUnit.setIgnoreComments(false);
		XMLUnit.setIgnoreDiffBetweenTextAndCDATA(true);
		client = new DefaultHttpClient();
	}

	/**
	 * test response.
	 */
	protected HttpResponse response;

	protected void boilerplateValidationTests(final HttpResponse response)
			throws Exception {
		assertEquals("Response status moet OK zijn.", SC_OK, response
				.getStatusLine().getStatusCode());

		// assertEquals("Response encoding zou UTF-8 moeten zijn.", "UTF-8",
		// response.getEntity().getContentEncoding().getValue());

		String body = new String(EntityUtils.toByteArray(response.getEntity()),
				"UTF-8");
		assertNotNull("Response body mag geen null zijn.", body);

		body = "<"
				+ body
				/* verwijder eventueel aanwezige non-word characters */.replaceFirst(
						"(^([\\W]+)<)", "")
						/* verwijder eventueel aanwezige UTF-8 BOM */.replace(
								"\uFEFF", "")
						/* trim leading en trailing whitespace */.trim()
						/**/.substring(1);

		assertTrue("Response body dient met juiste prolog te starten.",
				body.startsWith(RESPONSEPROLOG));

		// assertXMLValid("Response body dient geldige XHTML te zijn.", body);

		assertTrue("Response body dient geldige XHTML te zijn.", new Validator(
				body).isValid());
	}

	/**
	 * http verbindingen sluiten na afloop testcase.
	 */
	@After
	public void closeConnection() {
		client.getConnectionManager().shutdown();
	}

	/**
	 * voorbereidingen voor testcases.
	 */
	@Before
	public void prepareTestCase() {

	}

	/**
	 * test of de response geldig is.
	 */
	public abstract void testIfValidResponse() throws Exception;
}
