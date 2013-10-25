/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer;

/**
 * Marker interface met constanten voor de integratie tests.
 * 
 * @author prinsmc
 * 
 */
public abstract class IntegrationTestConstants {
	/**
	 * Basis url voor de integratie tests, {@value} , poort wordt ingesteld door
	 * Maven, default 8021.
	 */
	public static final String BASE_TEST_URL = "http://localhost:"
			+ (System.getProperty("jetty.port") == null ? "8021" : System
					.getProperty("jetty.port")) + "/";
}
