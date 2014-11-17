/*
 * Copyright (c) 2013-2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

import static javax.servlet.http.HttpServletResponse.SC_OK;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_baselyr;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_mapid;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import org.apache.http.Header;
import org.apache.http.client.methods.HttpGet;
import org.junit.Test;

/**
 * Testcases voor index.jsp.
 * 
 * @author mprins
 */
public class IndexJSPIntegrationTest extends JSPIntegrationTest {
	/**
	 * testcase voor index.jsp.
	 * 
	 * @throws Exception
	 */
	@Override
	@Test
	public void testIfValidResponse() throws Exception {
		response = client.execute(new HttpGet(BASE_TEST_URL + "index.jsp"));
		assertThat("Response status is OK.", response.getStatusLine()
				.getStatusCode(), equalTo(SC_OK));
		boilerplateValidationTests(response);
	}

	/**
	 * test of cookies voor basemap + thema juist zijn ingesteld.
	 * 
	 * @throws Exception
	 */
	@Test
	public void testIfCookiesSet() throws Exception {
		response = client.execute(new HttpGet(BASE_TEST_URL + "index.jsp"));

		// get cookies
		Header[] headers = response.getHeaders("Set-Cookie");

		int cookiesFound = 0;
		for (int i = 0; i < headers.length; i++) {
			// if value contains X it should contain Y
			if (headers[i].getValue().contains(COOKIE_baselyr.value)) {
				cookiesFound++;
				assertTrue("base layer cookie is juist ingesteld", headers[i]
						.getValue().contains("topografie"));
			}
			if (headers[i].getValue().contains(COOKIE_mapid.value)) {
				cookiesFound++;
				assertTrue(
						"thema layer cookie is juist ingesteld",
						headers[i]
								.getValue()
								.contains(
										"gemeenten2012_bevolkingsdichtheid_inwoners_per_km2"));
			}

		}
		assertEquals("Aantal gevonden cookies is gelijk aan twee", 2,
				cookiesFound);
	}
}
