/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

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
		response = client
				.execute(new HttpGet("http://localhost:8020/index.jsp"));
		boilerplateValidationTests(response);
	}
}
