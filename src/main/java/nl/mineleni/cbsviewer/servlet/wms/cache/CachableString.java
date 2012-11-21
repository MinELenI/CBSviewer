/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

/**
 * Beschrijft een cache object dat een String wrapt.
 * 
 * @author mprins
 * @since 1.6
 * 
 */
public class CachableString implements Cachable<String> {
	/** de String die wordt opgeslagen in de cache. */
	private final String toCache;

	/** de expire-by timestamp in milliseconden (UNIX time). */
	private final long expireBy;

	/**
	 * Instantiates a new cachable string.
	 * 
	 * @param toCache
	 *            de String om te bewaren
	 * @param expireBy
	 *            de expire-by timestamp in milliseconden (UNIX time)
	 */
	public CachableString(final String toCache, final long expireBy) {
		this.toCache = toCache;
		this.expireBy = expireBy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.Cachable#getExpireBy()
	 */
	@Override
	public long getExpireBy() {
		return this.expireBy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.Cachable#getItem()
	 */
	@Override
	public String getItem() {
		return this.toCache;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see nl.mineleni.cbsviewer.servlet.wms.cache.Cachable#isValid()
	 */
	@Override
	public boolean isValid() {
		return ((this.toCache != null) && (this.expireBy > System
				.currentTimeMillis()));
	}
}
