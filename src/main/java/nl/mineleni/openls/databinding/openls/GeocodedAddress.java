package nl.mineleni.openls.databinding.openls;

import nl.mineleni.openls.XmlNamespaceConstants;
import nl.mineleni.openls.databinding.gml.Point;

/**
 * http://schemas.opengis.net/ols/1.2.0/LocationUtilityService.xsd
 * 
 * <pre>
 * 
 *  <complexType name="GeocodedAddressType">
 *   <sequence>
 *     <element ref="gml:Point" />
 *     <element ref="xls:Address" />
 *     <element ref="xls:GeocodeMatchCode" minOccurs="0" />
 *   </sequence>
 * </complexType>
 * 
 * </pre>
 * 
 * @author mprins
 */
public class GeocodedAddress implements XmlNamespaceConstants {
    /**
     * serialization id.
     */
    private static final long serialVersionUID = -2711370703109529657L;

    private Point point;
    private Address address;

    private boolean hasPoint;
    private boolean hasAddress;

    public GeocodedAddress() {
        this.hasPoint = false;
        this.hasAddress = false;
    }

    public void setPoint(Point point) {
        this.hasPoint = true;
        this.point = point;
    }

    public Point getPoint() {
        return this.point;
    }

    public boolean hasPoint() {
        return this.hasPoint;
    }

    public void setAddress(Address address) {
        this.hasAddress = true;
        this.address = address;
    }

    public Address getAddress() {
        return this.address;
    }

    public boolean hasAddress() {
        return this.hasAddress;
    }

    @Override
    public String toXML() {
        String xml = "<" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodedAddress>";
        if (this.hasPoint()) {
            xml += this.point.toXML();
        }
        if (this.hasAddress()) {
            xml += this.address.toXML();
        }
        xml += "</" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodedAddress>";
        return xml;
    }
}
