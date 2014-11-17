/*
 * Copyright (c) 2012-2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
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

import java.text.NumberFormat;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.mineleni.cbsviewer.util.CookieNamesConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Algemene initialisatie code en gedeelde functies voor de WxS servlets.
 * 
 * @author prinsmc
 * @since 1.6
 * @since Servlet API 2.5
 * @note gedeelde basis voor de WxS servlets
 */
public abstract class AbstractWxSServlet extends AbstractBaseServlet {

	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(AbstractWxSServlet.class);
	/** leeftijd voor cookies. */
	private static final int AGE = 90 * 24 * 60 * 60;

	/** serialization id. */
	private static final long serialVersionUID = -5563479037661945586L;

	/**
	 * Checking for String that is not null, not empty, and not white space only
	 * using standard Java classes.
	 * 
	 * @param toTest
	 *            String to be checked for not null, not empty, and not white
	 *            space only.
	 * @return {@code true} if provided String is not null, is not empty, and
	 *         has at least one character that is not considered white space.
	 */
	protected boolean isNotNullNotEmptyNotWhiteSpaceOnly(final String toTest) {
		return ((toTest != null) && !toTest.isEmpty() && !toTest.trim()
				.isEmpty());
	}

	/**
	 * Parse de forward parameter van een request.
	 * 
	 * @see nl.mineleni.cbsviewer.util.StringConstants#REQ_PARAM_FORWARD
	 * @return {@code true}, als parameter aanwezig is en waarde "true" heeft,
	 *         anders / default {@code false}
	 * @param request
	 *            Het servlet request
	 */
	protected boolean parseForward(final HttpServletRequest request) {
		return (null == request.getParameter(REQ_PARAM_FORWARD.code) ? false
				: Boolean.valueOf(request.getParameter(REQ_PARAM_FORWARD.code)));
	}

	/**
	 * Parse locatie uit een request. Indien waarden niet geldig zijn of
	 * ontbreken worden de defaults
	 * {@link nl.mineleni.cbsviewer.util.NumberConstants#DEFAULT_XCOORD} ,
	 * {@link nl.mineleni.cbsviewer.util.NumberConstants#DEFAULT_YCOORD} en
	 * {@link nl.mineleni.cbsviewer.util.NumberConstants#OPENLS_ZOOMSCALE_STANDAARD}
	 * gebruikt.
	 * 
	 * @param request
	 *            Het servlet request
	 * @return een {@code double[xcoord,ycoord,straal]}
	 * @throws ServletException
	 *             Als parsen is mislukt
	 */
	protected int[] parseLocation(final HttpServletRequest request)
			throws ServletException {
		try {
			// request params uitlezen voor het zoeken
			final NumberFormat nf = NumberFormat.getInstance();
			final int xcoord = nf
					.parse((!this.isNotNullNotEmptyNotWhiteSpaceOnly(request
							.getParameter(REQ_PARAM_XCOORD.code)) ? DEFAULT_XCOORD
							.toString() : request
							.getParameter(REQ_PARAM_XCOORD.code))).intValue();
			final int ycoord = nf
					.parse((!this.isNotNullNotEmptyNotWhiteSpaceOnly(request
							.getParameter(REQ_PARAM_YCOORD.code)) ? DEFAULT_YCOORD
							.toString() : request
							.getParameter(REQ_PARAM_YCOORD.code))).intValue();
			final int straal = nf
					.parse((!this.isNotNullNotEmptyNotWhiteSpaceOnly(request
							.getParameter(REQ_PARAM_STRAAL.code)) ? OPENLS_ZOOMSCALE_STANDAARD
							.toString() : request
							.getParameter(REQ_PARAM_STRAAL.code))).intValue();
			request.setAttribute(REQ_PARAM_XCOORD.code, xcoord);
			request.setAttribute(REQ_PARAM_YCOORD.code, ycoord);
			request.setAttribute(REQ_PARAM_STRAAL.code, straal);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("request params:(" + xcoord + ";" + ycoord
						+ ") straal:" + straal);
			}
			return new int[] { xcoord, ycoord, straal };
		} catch (final NumberFormatException | ParseException e) {
			LOGGER.error(
					"Een van de vereiste parameters kon niet geparsed worden als Integer.",
					e);
			throw new ServletException(e);
		}
	}

	/**
	 * cookie instellen of updaten.
	 * 
	 * @param response
	 *            waarop de cookie wordt ingesteld
	 * @param name
	 *            naam van de cookie
	 * @param value
	 *            de waarde voor de cookie
	 * 
	 */
	protected void setCookie(HttpServletResponse response,
			CookieNamesConstants name, String value) {
		Cookie cookie = new Cookie(name.value, value);
		cookie.setMaxAge(AGE);
		response.addCookie(cookie);
	}

	/**
	 * cookie instellen of updaten.
	 * 
	 * @param response
	 *            waarop de cookie wordt ingesteld
	 * @param name
	 *            naam van de cookie
	 * @param value
	 *            de waarde voor de cookie
	 * 
	 */
	protected void setCookie(HttpServletResponse response,
			CookieNamesConstants name, Integer value) {
		Cookie cookie = new Cookie(name.value, Integer.toString(value));
		cookie.setMaxAge(AGE);
		response.addCookie(cookie);
	}
}
