/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

import static javax.servlet.http.HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.custommonkey.xmlunit.Validator;
import org.junit.Test;

/**
 * Testcases voor index.jsp.
 * 
 * @author mprins
 */
public class ErrorJSPIntegrationTest extends JSPIntegrationTest {

	@Override
	protected void boilerplateValidationTests(final HttpResponse response)
			throws Exception {
		assertEquals("Response status moet SC_INTERNAL_SERVER_ERROR zijn.",
				SC_INTERNAL_SERVER_ERROR, response.getStatusLine()
						.getStatusCode());

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
	 * testcase voor error.jsp.
	 * 
	 * @throws Exception
	 */
	@Override
	@Test
	public void testIfValidResponse() throws Exception {
		response = client
				.execute(new HttpGet("http://localhost:8020/error.jsp"));
		boilerplateValidationTests(response);
	}
}
