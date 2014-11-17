/*
 * Copyright (c) 2012-2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms;

import static nl.mineleni.cbsviewer.servlet.AbstractBaseServlet.USER_ID;
import static nl.mineleni.cbsviewer.servlet.AbstractBaseServlet.USER_PASSWORD;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import static org.junit.Assume.assumeNoException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import nl.mineleni.cbsviewer.util.StringConstants;

import org.jmock.Expectations;
import org.jmock.integration.junit4.JUnitRuleMockery;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * Test case for {@link nl.mineleni.cbsviewer.servlet.wms.WMSClientServlet}.
 * 
 * @author mprins
 */
public class WMSClientServletTest {
	/** servlet die we testen. */
	private WMSClientServlet servlet;
	/** junit mockery. */
	private final JUnitRuleMockery mockery = new JUnitRuleMockery();
	/** ge-mockte servlet config gebruikt in de test. */
	private ServletConfig servletConfig;
	/** ge-mockte servlet context gebruikt in de test. */
	private ServletContext servletContext;

	/**
	 * Set up before each test.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@SuppressWarnings("serial")
	@Before
	public void setUp() throws Exception {
		this.servletConfig = this.mockery.mock(ServletConfig.class);
		this.servletContext = this.mockery.mock(ServletContext.class);

		this.servlet = new WMSClientServlet() {
			/** return de mocked servletContext. */
			@Override
			public ServletContext getServletContext() {
				return WMSClientServletTest.this.servletContext;
			}

			/** return de mocked servletConfig. */
			@Override
			public ServletConfig getServletConfig() {
				return WMSClientServletTest.this.servletConfig;
			}
		};

		this.mockery.checking(new Expectations() {
			{
				this.atLeast(1).of(WMSClientServletTest.this.servletContext)
						.getRealPath(StringConstants.MAP_CACHE_DIR.code);
				this.will(returnValue("C:/workspace/CBSviewer/target/"
						+ StringConstants.MAP_CACHE_DIR.code));
			}
		});

	}

	/**
	 * Tear down after each test.
	 * 
	 * @throws Exception
	 *             the exception
	 */
	@After
	public void tearDown() throws Exception {
		try {
			this.servlet.destroy();
		} catch (final NullPointerException e) {
			assertTrue(true);
		}
	}

	/**
	 * Test methode voor.
	 * {@link nl.mineleni.cbsviewer.servlet.wms.WMSClientServlet#init(javax.servlet.ServletConfig)}
	 * .
	 */
	@Test
	public void testInitServletConfigNull() {
		this.mockery.checking(new Expectations() {
			{
				this.ignoring(WMSClientServletTest.this.servletConfig)
						.getInitParameter(USER_ID);
				this.ignoring(WMSClientServletTest.this.servletConfig)
						.getInitParameter(USER_PASSWORD);
				this.ignoring(WMSClientServletTest.this.servletConfig)
						.getServletContext();
				this.atLeast(1).of(WMSClientServletTest.this.servletConfig)
						.getInitParameter("bgCapabilitiesURL");
				this.will(returnValue(null));
				this.atLeast(0).of(WMSClientServletTest.this.servletConfig)
						.getInitParameter("bgWMSlayers");
				this.will(returnValue(null));
				this.atLeast(0).of(WMSClientServletTest.this.servletConfig)
						.getInitParameter("lufoCapabilitiesURL");
				this.will(returnValue(null));
				this.atLeast(0).of(WMSClientServletTest.this.servletConfig)
						.getInitParameter("lufoWMSlayers");
				this.will(returnValue(null));
			}
		});
		try {
			// supposed to throw e
			this.servlet.init(this.servletConfig);
			fail("Een overwachte fail conditie is opgetreden.");
		} catch (final ServletException e) {
			assertTrue("De verwachte ServletException is opgetreden.", true);
		}
	}

	/**
	 * Test methode voor.
	 * {@link nl.mineleni.cbsviewer.servlet.wms.WMSClientServlet#init(javax.servlet.ServletConfig)}
	 * .
	 */
	@Test
	public void testInitServletConfig() {
		this.mockery.checking(new Expectations() {
			{
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter(USER_ID);
				this.will(returnValue("userID"));
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter(USER_PASSWORD);
				this.will(returnValue("passID"));

				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter("bgCapabilitiesURL");
				//this.will(returnValue("http://osm.wheregroup.com/cgi-bin/osm_basic.xml?REQUEST=GetCapabilities&SERVICE=WMS&amp;VERSION=1.1.1"));
				this.will(returnValue("http://www.openbasiskaart.nl/mapcache/?SERVICE=WMS&amp;VERSION=1.1.1&amp;REQUEST=GetCapabilities"));
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter("bgWMSlayers");
				//this.will(returnValue("Grenzen"));
				this.will(returnValue("osm-nb"));
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter("lufoCapabilitiesURL");
				// this.will(returnValue("http://gisdemo2.agro.nl/arcgis/services/Luchtfoto2010/MapServer/WMSServer?REQUEST=GetCapabilities&SERVICE=WMS"));
				this.will(returnValue("http://geodata1.nationaalgeoregister.nl/luchtfoto/wms?REQUEST=GetCapabilities"));
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter("lufoWMSlayers");
				this.will(returnValue(""));
				this.oneOf(WMSClientServletTest.this.servletConfig)
						.getInitParameter("featureInfoType");
				this.will(returnValue(""));
			}
		});

		try {
			this.servlet.init(this.servletConfig);
			assertEquals("userID", this.servlet.getUserID());
			assertEquals("passID", this.servlet.getPassID());
		} catch (final SecurityException s) {
			assumeNoException(s);
		} catch (final ServletException e) {
			if (e.getRootCause().getClass()
					.equals(java.net.ConnectException.class)) {
				assumeNoException(e);
			}
			fail("Servlet Exception voor init() in test setup.(testInitServletConfig) "
					+ e.getLocalizedMessage());
		}
	}
}
