/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import java.awt.image.BufferedImage;

// TODO: Auto-generated Javadoc
/**
 * Cachable image implementatie.
 * 
 * @author prinsmc
 * @since 1.6
 */
public class CacheImage implements CachableImage<BufferedImage> {

	/** de expire-by timestamp in milliseconden (UNIX time). */
	private final long expireBy;

	/** bestandsnaam. */
	private String fName;

	/** image. */
	private BufferedImage image = null;

	/**
	 * Maak een nieuwe cache afbeelding aan.
	 * 
	 * @param image
	 *            de afbeelding
	 * @param filename
	 *            de bestandsnaam
	 * @param expireBy
	 *            de expire-by timestamp in milliseconden (UNIX time)
	 */
	public CacheImage(final BufferedImage image, final String filename,
			final long expireBy) {
		this.image = image;
		this.fName = filename;
		this.expireBy = expireBy;
	}

	/**
	 * Maak een nieuwe cache afbeelding aan.
	 * 
	 * @param image
	 *            de afbeelding
	 * @param secondsToLive
	 *            seconds to live in de cache
	 */
	public CacheImage(final BufferedImage image, final long secondsToLive) {
		final long expires = secondsToLive != -1 ? System.currentTimeMillis()
				+ (secondsToLive * 1000) : secondsToLive;
		this.image = image;
		this.expireBy = expires;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.CachableImage#getExpireBy()
	 */
	@Override
	public long getExpireBy() {
		return this.expireBy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.eleni.gcc.vpziek.cache.CachableImage#getImage()
	 */
	@Override
	public BufferedImage getItem() {
		return this.image;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.eleni.gcc.vpziek.cache.CachableImage#getName()
	 */
	@Override
	public String getName() {
		return this.fName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.eleni.gcc.vpziek.cache.CachableImage#isValid()
	 */
	@Override
	public boolean isValid() {
		return ((this.image != null) && (this.fName != null) && (this.expireBy > System
				.currentTimeMillis()));
	}

	/**
	 * Gets the image.
	 * 
	 * @return the image
	 */
	public BufferedImage getImage() {
		return getItem();
	}

	/**
	 * Sets the file name.
	 * 
	 * @param name
	 *            the new file name
	 */
	public void setFileName(String name) {
		this.fName = name;
	}
}
