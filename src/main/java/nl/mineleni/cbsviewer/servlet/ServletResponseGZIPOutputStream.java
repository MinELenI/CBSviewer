/*
 * Copyright (c) 2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletOutputStream;

/**
 * comprimeert de output stream met gzip.
 * 
 * @author prinsmc
 *
 */
public class ServletResponseGZIPOutputStream extends ServletOutputStream {
	/** gzip output. */
	GZIPOutputStream gzipStream;
	/** vlag voor ststus van gzip output stream. */
	final AtomicBoolean open = new AtomicBoolean(true);
	/** output stream die gecomprimeerd wordt. */
	OutputStream output;

	/**
	 * Instantiates a new servlet response gzip output stream.
	 *
	 * @param output
	 *            the output
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public ServletResponseGZIPOutputStream(OutputStream output)
			throws IOException {
		this.output = output;
		gzipStream = new GZIPOutputStream(output);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.io.OutputStream#close()
	 */
	@Override
	public void close() throws IOException {
		if (open.compareAndSet(true, false)) {
			gzipStream.close();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.io.OutputStream#flush()
	 */
	@Override
	public void flush() throws IOException {
		gzipStream.flush();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.io.OutputStream#write(byte[])
	 */
	@Override
	public void write(byte b[]) throws IOException {
		write(b, 0, b.length);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.io.OutputStream#write(byte[], int, int)
	 */
	@Override
	public void write(byte b[], int off, int len) throws IOException {
		if (!open.get()) {
			throw new IOException("Stream closed!");
		}
		gzipStream.write(b, off, len);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.io.OutputStream#write(int)
	 */
	@Override
	public void write(int b) throws IOException {
		if (!open.get()) {
			throw new IOException("Stream closed!");
		}
		gzipStream.write(b);
	}

}
