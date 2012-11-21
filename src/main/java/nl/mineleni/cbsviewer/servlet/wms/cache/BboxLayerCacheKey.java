/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms.cache;

import nl.mineleni.cbsviewer.util.xml.LayerDescriptor;

import org.opengis.geometry.BoundingBox;

/**
 * Een cache key bestaande uit een bounding box en een layer descriptor.
 * 
 * @author mprins
 * @since 1.6
 */
public class BboxLayerCacheKey {

	/** de bounding box van dit object. */
	private final BoundingBox bbox;
	/** de layer descriptor van dit object. */
	private final LayerDescriptor ld;

	/**
	 * Instantiates a new bbox layer cache key.
	 * 
	 * @param bbox
	 *            the bbox
	 * @param ld
	 *            the ld
	 */
	public BboxLayerCacheKey(final BoundingBox bbox, final LayerDescriptor ld) {
		this.bbox = bbox;
		this.ld = ld;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(final Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		final BboxLayerCacheKey other = (BboxLayerCacheKey) obj;
		if (bbox == null) {
			if (other.bbox != null) {
				return false;
			}
		} else if (!bbox.equals(other.bbox)) {
			return false;
		}
		if (ld == null) {
			if (other.ld != null) {
				return false;
			}
		} else if (!ld.equals(other.ld)) {
			return false;
		}
		return true;
	}

	/**
	 * Gets het bbox deel van dit object.
	 * 
	 * @return the bbox
	 */
	public BoundingBox getBbox() {
		return bbox;
	}

	/**
	 * Gets het layer descriptor deel van dit object.
	 * 
	 * @return the ld
	 */
	public LayerDescriptor getLd() {
		return ld;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bbox == null) ? 0 : bbox.hashCode());
		result = prime * result + ((ld == null) ? 0 : ld.hashCode());
		return result;
	}
}
