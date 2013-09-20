/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.jsp;

import org.apache.http.client.methods.HttpGet;
import org.junit.Ignore;
import org.junit.Test;

/**
 * Testcases voor versie.jsp.
 * 
 * @author mprins
 */
public class VersieJSPIntegrationTest extends JSPIntegrationTest {

	/**
	 * testcase voor versie.jsp.
	 * 
	 * @todo kijken of we de integratie tests tegen de echte war kunnen laten
	 *       draaien
	 * @throws Exception
	 */
	@Override
	@Test
	@Ignore("Mislukt vooralsnog omdat het bestand met versie informatie (/META-INF/MANIFEST.MF) niet gevonden kan worden.")
	public void testIfValidResponse() throws Exception {
		response = client.execute(new HttpGet(
				"http://localhost:8020/versie.jsp"));
		boilerplateValidationTests(response);
	}
}
