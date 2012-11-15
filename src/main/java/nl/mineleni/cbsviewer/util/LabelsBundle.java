/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken, Landbouw en Innovatie
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.util;

import java.util.Enumeration;
import java.util.MissingResourceException;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Resourcebundel bundle voor de applicatie.
 * 
 * @author prinsmc
 * @since 1.6
 */
public class LabelsBundle extends ResourceBundle {

	/** LOGGER. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(LabelsBundle.class);

	/** resource bundle. */
	private PropertyResourceBundle resBundle;

	/**
	 * Instantiates a new labels bundle.
	 */

	public LabelsBundle() {
		try {
			this.resBundle = (PropertyResourceBundle) PropertyResourceBundle
					.getBundle(
							"LabelsBundle",
							ResourceBundle.Control
									.getControl(ResourceBundle.Control.FORMAT_PROPERTIES));
		} catch (final NullPointerException e) {
			LOGGER.error("baseName of control is null.", e);
		} catch (final MissingResourceException e) {
			LOGGER.error(
					"De resourcebundel (LabelsBundle.properties) is niet gevonden",
					e);
		} catch (final IllegalArgumentException e) {
			LOGGER.error(
					"ResourceBundle.Control heeft geen locale kunnen achterhalen.",
					e);
		}
	}

	/**
	 * Geeft sleutel/waarde paren als javascript OpenLayers object.
	 * 
	 * @return the open layers lang bundle
	 */
	public String getOpenLayersLangBundle() {
		final StringBuilder sb = new StringBuilder(
				"//<![CDATA[\nOpenLayers.Lang.nl = OpenLayers.Util.extend({");

		for (final Enumeration<String> keys = this.getKeys(); keys
				.hasMoreElements();) {
			final String key = keys.nextElement();
			sb.append("'");
			sb.append(key);
			sb.append("'");
			sb.append(":'");
			sb.append(this.getString(key));
			sb.append("',");
			if (LOGGER.isDebugEnabled()) {
				sb.append("\n");
			}
		}
		sb.deleteCharAt(sb.length() - 1);
		sb.append("}, OpenLayers.Lang.nl);\n//]]>\n");
		return sb.toString();
	}

	@Override
	public Enumeration<String> getKeys() {
		return this.resBundle.getKeys();
	}

	@Override
	protected Object handleGetObject(String key) {
		return this.resBundle.handleGetObject(key);
	}
}
