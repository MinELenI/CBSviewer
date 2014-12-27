/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.apache.http.HttpHeaders;

/**
 * The Class GZIPHttpServletResponseWrapper.
 */
public class GZIPHttpServletResponseWrapper extends HttpServletResponseWrapper {
	/** gecomprimeerde output. */
	private ServletResponseGZIPOutputStream gzipStream;
	/** te comprimeren output. */
	private ServletOutputStream outputStream;
	/** output. */
	private PrintWriter printWriter;

	/**
	 * Instantiates a new GZIP http servlet response wrapper.
	 *
	 * @param response
	 *            the response
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public GZIPHttpServletResponseWrapper(HttpServletResponse response)
			throws IOException {
		super(response);
		response.addHeader(HttpHeaders.CONTENT_ENCODING, "gzip");
	}

	/**
	 * Finish.
	 *
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public void finish() throws IOException {
		if (printWriter != null) {
			printWriter.close();
		}
		if (outputStream != null) {
			outputStream.close();
		}
		if (gzipStream != null) {
			gzipStream.close();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletResponseWrapper#flushBuffer()
	 */
	@Override
	public void flushBuffer() throws IOException {
		if (printWriter != null) {
			printWriter.flush();
		}
		if (outputStream != null) {
			outputStream.flush();
		}
		super.flushBuffer();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletResponseWrapper#getOutputStream()
	 */
	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		if (printWriter != null) {
			throw new IllegalStateException("printWriter already defined");
		}
		if (outputStream == null) {
			initGzip();
			outputStream = gzipStream;
		}
		return outputStream;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletResponseWrapper#getWriter()
	 */
	@Override
	public PrintWriter getWriter() throws IOException {
		if (outputStream != null) {
			throw new IllegalStateException("printWriter already defined");
		}
		if (printWriter == null) {
			initGzip();
			printWriter = new PrintWriter(new OutputStreamWriter(gzipStream,
					getResponse().getCharacterEncoding()));
		}
		return printWriter;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.ServletResponseWrapper#setContentLength(int)
	 */
	@Override
	public void setContentLength(int len) {
	}

	/**
	 * Inits the gzip.
	 *
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private void initGzip() throws IOException {
		gzipStream = new ServletResponseGZIPOutputStream(getResponse()
				.getOutputStream());
	}

}
