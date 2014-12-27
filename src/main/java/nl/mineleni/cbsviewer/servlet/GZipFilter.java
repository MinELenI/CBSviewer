/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpHeaders;

/**
 * Eenvoudige GZip compressie filter ter optimalisatie van bandbreedte.
 * 
 * @author prinsmc
 *
 */
public class GZipFilter implements Filter {

	/**
	 * Comprimeert de response met GZip mits de clinet aangeeft dat die gzip
	 * accepteert.
	 * 
	 * {@inheritDoc}
	 * 
	 * @param request
	 *            het request
	 * @param response
	 *            de response
	 * @param chain
	 *            de filter chain
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 * @throws ServletException
	 *             the servlet exception
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 *      javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 * 
	 * 
	 */
	@Override
	public void doFilter(final ServletRequest request,
			final ServletResponse response, final FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String acceptEncoding = httpRequest
				.getHeader(HttpHeaders.ACCEPT_ENCODING);
		if (acceptEncoding != null) {
			if (acceptEncoding.indexOf("gzip") >= 0) {
				GZIPHttpServletResponseWrapper gzipResponse = new GZIPHttpServletResponseWrapper(
						httpResponse);
				chain.doFilter(request, gzipResponse);
				gzipResponse.finish();
				return;
			}
		}
		chain.doFilter(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(final FilterConfig filterConfig) throws ServletException {
		// do nothing
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy() {
		// do nothing
	}
}
