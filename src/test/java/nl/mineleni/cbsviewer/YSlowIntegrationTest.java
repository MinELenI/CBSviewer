/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer;

import static org.junit.Assert.assertEquals;

import java.io.File;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * YSlow Testcase voor index.jsp.
 * 
 * @author mprins
 */
public class YSlowIntegrationTest implements IntegrationTestConstants {
	private Process phantomProcess;
	private ProcessBuilder pb;

	@BeforeClass
	public static void createDiretory() throws Exception {
		new File("target/yslow/").mkdirs();
	}

	/**
	 * voorbereidingen voor testcases.
	 * 
	 * @throws Exception
	 */
	@Before
	public void preparePhantomJS() throws Exception {
		pb = new ProcessBuilder("phantomjs");
		pb.command().add("target/yslow.js");
		pb.command().add("--verbose");

		pb.command().add("--format");
		pb.command().add("junit");

		pb.command().add("--info");
		pb.command().add("grade");

		pb.command().add("--threshold");
		pb.command().add("B");

		pb.command().add("--viewport");
		pb.command().add("800x600");

		pb.redirectError(new File("phantomjs_error.log"));
	}

	@After
	public void stopPhantomJS() {
		this.phantomProcess.destroy();
	}

	/**
	 * testcase voor about.jsp.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexRIATest() throws Exception {
		pb.command().add(BASE_TEST_URL + "index.jsp");
		pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexRIA.xml"));

		System.out.println("Command list is: " + pb.command());
		this.phantomProcess = pb.start();

		assertEquals("YSlow analysis failed", 0, this.phantomProcess.waitFor());
	}

	/**
	 * testcase voor about.jsp.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexCORETest() throws Exception {

		pb.command().add(BASE_TEST_URL + "index.jsp?coreonly=true");
		pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexCORE.xml"));

		System.out.println("Command list is: " + pb.command());
		this.phantomProcess = pb.start();

		assertEquals("YSlow analysis failed", 0, this.phantomProcess.waitFor());
	}
}
