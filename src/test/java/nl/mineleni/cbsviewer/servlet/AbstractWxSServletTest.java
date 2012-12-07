/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet;

import static nl.mineleni.cbsviewer.util.NumberConstants.DEFAULT_XCOORD;
import static nl.mineleni.cbsviewer.util.NumberConstants.DEFAULT_YCOORD;
import static nl.mineleni.cbsviewer.util.NumberConstants.OPENLS_ZOOMSCALE_STANDAARD;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_FORWARD;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_STRAAL;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_XCOORD;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_YCOORD;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.jmock.Expectations;
import org.jmock.Mockery;
import org.jmock.integration.junit4.JMock;
import org.jmock.integration.junit4.JUnit4Mockery;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * @author Mark
 */
@RunWith(JMock.class)
public class AbstractWxSServletTest {
    /** servlet die we testen. */
    private AbstractWxSServlet servlet;
    /** junit mockery. */
    private final Mockery mockery = new JUnit4Mockery();
    /** mocked servlet request. */
    private HttpServletRequest request;

    /**
     * @throws java.lang.Exception
     */
    @SuppressWarnings("serial")
    @Before
    public void setUp() throws Exception {
        this.request = this.mockery.mock(HttpServletRequest.class);

        this.servlet = new AbstractWxSServlet() {

        };

        this.mockery.checking(new Expectations() {
            {
                this.allowing(AbstractWxSServletTest.this.request)
                        .getAttributeNames();
                this.allowing(AbstractWxSServletTest.this.request)
                        .getParameterMap();
                this.allowing(AbstractWxSServletTest.this.request)
                        .setAttribute(REQ_PARAM_XCOORD.code, 100);
                this.allowing(AbstractWxSServletTest.this.request)
                        .setAttribute(REQ_PARAM_YCOORD.code, 100);
                this.allowing(AbstractWxSServletTest.this.request)
                        .setAttribute(REQ_PARAM_STRAAL.code, 100);
            }
        });

    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#parseForward(javax.servlet.http.HttpServletRequest)}
     * .
     */
    @Test
    public void testParseForwardFalse() {
        // als param == false
        this.mockery.checking(new Expectations() {
            {
                this.atMost(3).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_FORWARD.code);
                this.will(returnValue("false"));
            }
        });
        assertFalse(this.servlet.parseForward(this.request));
    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#parseForward(javax.servlet.http.HttpServletRequest)}
     * .
     */
    @Test
    public void testParseForwardNull() {
        // als param afwezig
        this.mockery.checking(new Expectations() {
            {
                this.atMost(2).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_FORWARD.code);
                this.will(returnValue(null));
            }
        });
        assertFalse(this.servlet.parseForward(this.request));
    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#parseForward(javax.servlet.http.HttpServletRequest)}
     * .
     */
    @Test
    public void testParseForwardTrue() {
        // als param == true
        this.mockery.checking(new Expectations() {
            {
                this.atMost(3).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_FORWARD.code);
                this.will(returnValue("true"));

            }
        });
        assertTrue(this.servlet.parseForward(this.request));
    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#parseLocation(javax.servlet.http.HttpServletRequest)}
     * .
     * 
     * @throws ServletException
     */
    @Test
    public void testParseLocation() throws ServletException {
        this.mockery.checking(new Expectations() {
            {
                this.atMost(2).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_XCOORD.code);
                this.will(returnValue("100"));
                this.atMost(2).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_YCOORD.code);
                this.will(returnValue("100"));
                this.atMost(2).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_STRAAL.code);
                this.will(returnValue("100"));

            }
        });
        final int[] d = this.servlet.parseLocation(this.request);
        assertArrayEquals(new int[] { 100, 100, 100 }, d);
    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#parseLocation(javax.servlet.http.HttpServletRequest)}
     * .
     * 
     * @throws ServletException
     */
    @Test
    public void testParseLocationNull() throws ServletException {
        this.mockery.checking(new Expectations() {
            {
                this.atMost(1).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_XCOORD.code);
                this.will(returnValue(null));
                this.atMost(1).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_YCOORD.code);
                this.will(returnValue(null));
                this.atMost(1).of(AbstractWxSServletTest.this.request)
                        .getParameter(REQ_PARAM_STRAAL.code);
                this.will(returnValue(null));

                this.oneOf(AbstractWxSServletTest.this.request).setAttribute(
                        REQ_PARAM_XCOORD.code, DEFAULT_XCOORD.intValue());
                this.oneOf(AbstractWxSServletTest.this.request).setAttribute(
                        REQ_PARAM_YCOORD.code, DEFAULT_YCOORD.intValue());
                this.oneOf(AbstractWxSServletTest.this.request).setAttribute(
                        REQ_PARAM_STRAAL.code,
                        OPENLS_ZOOMSCALE_STANDAARD.intValue());
            }
        });
        final int[] d = this.servlet.parseLocation(this.request);
        assertArrayEquals(
                new int[] { DEFAULT_XCOORD.intValue(),
                        DEFAULT_YCOORD.intValue(),
                        OPENLS_ZOOMSCALE_STANDAARD.intValue() }, d);
    }

    /**
     * test methode voor
     * {@link AbstractWxSServlet#isNotNullNotEmptyNotWhiteSpaceOnly(String) }.
     * 
     * @throws ServletException
     */
    @Test
    public void testIsNotNullNotEmptyNotWhiteSpaceOnly() {
        assertTrue(this.servlet.isNotNullNotEmptyNotWhiteSpaceOnly("test"));
        assertFalse(this.servlet.isNotNullNotEmptyNotWhiteSpaceOnly(null));
        assertFalse(this.servlet.isNotNullNotEmptyNotWhiteSpaceOnly(""));
    }
}
