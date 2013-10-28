/*
 * Copyright (c) 2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.yslow;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.core.IsNot.not;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.RandomAccessFile;

import nl.mineleni.cbsviewer.IntegrationTestConstants;

import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * YSlow Testcase voor index.jsp.
 * 
 * @author mprins
 */
public class YSlowIntegrationTest extends IntegrationTestConstants {
	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(YSlowIntegrationTest.class);
	private Process phantomProcess;
	private ProcessBuilder pb;
	private int allowedToFail = 0;

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
	 * Voorbereiding van phantomjs proces voor de testcases.
	 * 
	 * @see http://yslow.org/phantomjs/
	 * @throws Exception
	 */
	@Before
	public void preparePhantomJS() throws Exception {
		this.pb = new ProcessBuilder("phantomjs");

		this.pb.command().add("target/yslow.js");
		this.pb.command().add("-v");

		this.pb.command().add("-f");
		this.pb.command().add("junit");

		this.pb.command().add("-i");
		this.pb.command().add("grade");

		this.pb.command().add("-t");
		this.pb.command().add(
				"{overall:'B', 'ycdn':'F', 'yexpires':'F', 'ycompress':'F'}");
		allowedToFail = /* 3x 'F' */3 + /* 1 ignored */1;

		this.pb.command().add("-vp");
		this.pb.command().add("800x600");

		this.pb.redirectError(new File("phantomjs_error.log"));
	}

	/**
	 * phantomjs proces cleanup.
	 */
	@After
	public void stopPhantomJS() {
		LOGGER.debug("PhantomJS process stopped, exit code: "
				+ this.phantomProcess.exitValue());
		this.phantomProcess.destroy();
	}

	/**
	 * testcase voor index.jsp in ria modus.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexRIATest() throws Exception {
		this.pb.command().add(BASE_TEST_URL + "index.jsp");
		this.pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexRIA.xml"));

		LOGGER.debug("PhantomJS commandline options: " + this.pb.command());
		this.phantomProcess = this.pb.start();

		assertThat("Number of YSlow violations returned.",
				this.phantomProcess.waitFor(), not(greaterThan(allowedToFail)));

		try (RandomAccessFile report = new RandomAccessFile(
				"target/yslow/TEST-YSlowIndexRIA.xml", "r")) {
			assertFalse("Running test has failed.", report.readLine()
					.startsWith("FAIL to load undefined"));

			report.seek(0);
			assertTrue("Running test has failed.", report.readLine()
					.startsWith("<?xml version="));
		}
	}

	/**
	 * testcase voor index.jsp in core modus.
	 * 
	 * @throws Exception
	 */
	@Test
	public void phantomYSlowIndexCORETest() throws Exception {
		this.pb.command().add(BASE_TEST_URL + "index.jsp?coreonly=true");
		this.pb.redirectOutput(new File("target/yslow/TEST-YSlowIndexCORE.xml"));
		LOGGER.debug("PhantomJS commandline options: " + this.pb.command());
		this.phantomProcess = this.pb.start();

		assertThat("Number of YSlow violations returned.",
				this.phantomProcess.waitFor(), not(greaterThan(allowedToFail)));

		try (RandomAccessFile report = new RandomAccessFile(
				"target/yslow/TEST-YSlowIndexRIA.xml", "r")) {

			assertFalse("Running test has failed.", report.readLine()
					.startsWith("FAIL to load undefined"));
			report.seek(0);
			assertTrue("Running test has failed.", report.readLine()
					.startsWith("<?xml version="));
		}
	}
}
