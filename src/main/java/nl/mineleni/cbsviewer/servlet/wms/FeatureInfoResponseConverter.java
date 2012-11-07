/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.wms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.parsers.ParserConfigurationException;

import org.geotools.GML;
import org.geotools.GML.Version;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.opengis.feature.simple.SimpleFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

/**
 * Utility klasse FeatureInfoResponseConverter kan gebruikt worden om
 * FeatureInfo responses te parsen en te converteren naar een andere vorm.
 * 
 * @author mprins
 * @since 1.6
 */
public class FeatureInfoResponseConverter {

	/**
	 * het inputstream type.
	 * 
	 * @see FeatureInfoResponseConverter#convertToHTMLTable(InputStream, type,
	 *      String[])
	 */
	public enum type {
		/** het gmltype. */
		GMLTYPE,
		/** het htmltype. */
		HTMLTYPE;
	}

	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(FeatureInfoResponseConverter.class);

	/**
	 * Cleanup html.
	 * 
	 * @param htmlStream
	 *            the html stream
	 * @return the string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 * @todo implementatie
	 */
	private static String cleanupHTML(final InputStream htmlStream)
			throws IOException {
		LOGGER.warn("unsported feature");
		return convertStreamToString(htmlStream);
	}

	/**
	 * Converteer gml imputstream naar html tabel.
	 * 
	 * @param gmlStream
	 *            the gml stream
	 * @param attributes
	 *            the attributes
	 * @return een html tabel
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private static String convertGML(final InputStream gmlStream,
			final String[] attributes) throws IOException {
		final StringBuilder sb = new StringBuilder();
		try {
			final GML gml = new GML(Version.WFS1_0);
			final SimpleFeatureIterator iter = gml
					.decodeFeatureIterator(gmlStream);
			// tabel maken
			sb.append("<table id=\"attribuutTabel\" class=\"attribuutTabel\">");
			sb.append("<caption>");
			sb.append("Informatie over de zoeklocatie.");
			sb.append("</caption>");
			sb.append("<thead><tr>");
			for (final String n : attributes) {
				sb.append("<th scope=\"col\">" + n + "</th>");
			}
			sb.append("</tr></thead>");
			sb.append("<tbody>");
			int i = 0;
			while (iter.hasNext()) {
				sb.append("<tr class=\"" + (((i++ % 2) == 0) ? "" : "even")
						+ "\">");
				final SimpleFeature f = iter.next();
				for (final String n : attributes) {
					sb.append("<td>" + f.getAttribute(n) + "</td>");
				}
				sb.append("</tr>");
			}
			sb.append("</tbody>");
			sb.append("</table>");
			LOGGER.debug("Gemaakte HTML tabel:\n" + sb);
		} catch (ParserConfigurationException | SAXException e) {
			LOGGER.error("Fout tijdens parsen van GML. ", e);
		} finally {
			gmlStream.close();
		}
		return sb.toString();
	}

	/**
	 * Converteert een stream naar een string.
	 * 
	 * @param is
	 *            de InputStream met data
	 * @return de data als string
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private static String convertStreamToString(final InputStream is)
			throws IOException {
		if (is != null) {
			final Writer writer = new StringWriter();
			final char[] buffer = new char[1024];
			try {
				final Reader reader = new BufferedReader(new InputStreamReader(
						is, "UTF-8"));
				int n;
				while ((n = reader.read(buffer)) != -1) {
					writer.write(buffer, 0, n);
				}
			} finally {
				is.close();
			}
			return writer.toString();
		} else {
			return "";
		}
	}

	/**
	 * Converteer de input naar een html tabel.
	 * 
	 * @param input
	 *            inputstream met de featureinfo response.
	 * @param type
	 *            het type conversie
	 * @param attributes
	 *            namen van de feature attributen
	 * @return een html tabel
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	public static String convertToHTMLTable(final InputStream input,
			final FeatureInfoResponseConverter.type type,
			final String[] attributes) throws IOException {
		switch (type) {
		case GMLTYPE:
			return convertGML(input, attributes);
		case HTMLTYPE:
			return cleanupHTML(input);
		default:
			return convertStreamToString(input);
		}
	}

	/**
	 * private constructor.
	 */
	private FeatureInfoResponseConverter() {
		// private constructor voor utility klasse
	}
}
