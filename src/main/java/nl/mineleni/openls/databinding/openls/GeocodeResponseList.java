package nl.mineleni.openls.databinding.openls;

import java.util.Vector;

import nl.mineleni.openls.XmlNamespaceConstants;

/**
 * http://schemas.opengis.net/ols/1.2.0/LocationUtilityService.xsd
 * 
 * <pre>
 *  <complexType name="GeocodeResponseListType">
 *   <sequence>
 *     <element name="GeocodedAddress" type="xls:GeocodedAddressType" maxOccurs="unbounded">
 *       <annotation>
 *         <documentation>The list of 1-n addresses that are returned for each Address request, sorted by Accuracy.</documentation>
 *       </annotation>
 *     </element>
 *   </sequence>
 *   <attribute name="numberOfGeocodedAddresses" type="nonNegativeInteger" use="required">
 *     <annotation>
 *       <documentation>This is the number of responses generated per the different requests. Within each geocoded address it's possible to have multiple candidates</documentation>
 *     </annotation>
 *   </attribute>
 * </complexType>
 * 
 * </pre>
 * 
 * @author mprins
 */
public class GeocodeResponseList implements XmlNamespaceConstants {

    /** serialisation id */
    private static final long serialVersionUID = 6830914161263736467L;
    private Vector<GeocodedAddress> geocodedAddress = new Vector<GeocodedAddress>();
    private int numberOfGeocodedAddresses;

    public void addGeocodedAddress(GeocodedAddress val) {
        this.geocodedAddress.add(val);
    }

    public GeocodedAddress getGeocodedAddressAt(int i) {
        return this.geocodedAddress.get(i);
    }

    public int getGeocodedAddressSize() {
        return this.geocodedAddress.size();
    }

    public void setNumberOfGeocodedAddresses(int val) {
        this.numberOfGeocodedAddresses = val;
    }

    public int getNumberOfGeocodedAddresses() {
        return this.numberOfGeocodedAddresses;
    }

    @Override
    public String toXML() {
        final StringBuilder sb = new StringBuilder("<"
                + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeResponseList " + "numberOfGeocodedAddresses=\""
                + Integer.toString(this.getGeocodedAddressSize()) + "\">");
        for (final GeocodedAddress gca : this.geocodedAddress) {
            sb.append(gca.toXML());
        }
        sb.append("</" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeResponseList>");
        return sb.toString();
    }
}
