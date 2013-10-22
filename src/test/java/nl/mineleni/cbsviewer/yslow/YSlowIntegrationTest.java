/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.yslow;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.core.IsNot.not;
import static org.junit.Assert.assertThat;

import java.io.File;

import nl.mineleni.cbsviewer.IntegrationTestConstants;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * YSlow Testcase voor index.jsp.
 * 
 * @author mprins
 */
public class YSlowIntegrationTest extends IntegrationTestConstants {
	private Process phantomProcess;
	private ProcessBuilder pb;

	/**
	 * aanmaken van de rapportage directory, dat blijkt phantomjs + yslow niet
	 * te kunnen.
	 * 
	 * @throws Exception
	 */
	@BeforeClass
	public static void createDirectory() throws Exception {
		new File("target/yslow/").mkdirs();
	}

	/**
	 * voorbereidingen van phantomjs proces voor de testcases.
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

	/**
	 * phantomjs proces cleanup.
	 */
	@After
	public void stopPhantomJS() {
		this.phantomProcess.destroy();
	}

	/**
	 * testcase voor index.jsp in ria modus.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexRIATest() throws Exception {
		pb.command().add(BASE_TEST_URL + "index.jsp");
		pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexRIA.xml"));
		this.phantomProcess = pb.start();

		assertThat("Number of YSlow violations returned.",
				this.phantomProcess.waitFor(), not(greaterThan(0)));

	}

	/**
	 * testcase voor index.jsp in core modus.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexCORETest() throws Exception {
		pb.command().add(BASE_TEST_URL + "index.jsp?coreonly=true");
		pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexCORE.xml"));
		this.phantomProcess = pb.start();

		assertThat("Number of YSlow violations returned.",
				this.phantomProcess.waitFor(), not(greaterThan(0)));
	}
}
