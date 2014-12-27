/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 *
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

import static javax.servlet.http.HttpServletResponse.SC_OK;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

import org.apache.http.client.methods.HttpGet;
import org.junit.Test;

/**
 * Testcase voor /toegankelijkheid.
 *
 * @author mprins
 */
public class ToegankelijkheidJSPIntegrationTest extends JSPIntegrationTest {

	/**
	 * testcase voor download.jsp.
	 *
	 * @throws Exception
	 */
	@Override
	@Test
	public void testIfValidResponse() throws Exception {
		this.response = client.execute(new HttpGet(BASE_TEST_URL
				+ "toegankelijkheid"));
		assertThat("Response status is OK.", this.response.getStatusLine()
				.getStatusCode(), equalTo(SC_OK));

		this.boilerplateValidationTests(this.response);
	}
}
