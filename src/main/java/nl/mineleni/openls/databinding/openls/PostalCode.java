package nl.mineleni.openls.databinding.openls;

import nl.mineleni.openls.XmlNamespaceConstants;

/**
 * http://schemas.opengis.net/ols/1.2.0/ADT.xsd
 * 
 * <pre>
 * <element name="PostalCode" type="xls:PostalCodeType">
 *   <annotation>
 *     <documentation>A zipcode or international postal code as
 *     defined by the governing postal authority.</documentation>
 *   </annotation>
 * </element>
 * <simpleType name="PostalCodeType">
 *   <annotation>
 *     <documentation>The AbstractPostalCodeType is an abstract type
 *     for postal code within an AddressType. We do this because the
 *     components of a postal code vary greatly throughout the world.
 *     So that the schema can accommodate this variation we create
 *     derived types such as the USZipCodeType which has the
 *     components for a US zipcode</documentation>
 *   </annotation>
 *   <restriction base="string" />
 * </simpleType>
 * </pre>
 * 
 * @author mprins
 */
public class PostalCode implements XmlNamespaceConstants {
    /**
     * serialization id.
     */
    private static final long serialVersionUID = -78484525678140670L;

    private String postalCode;

    private boolean hasPostalCode;

    public PostalCode() {
        this.hasPostalCode = false;
    }

    public void setPostalCode(String postalCode) {
        this.hasPostalCode = true;
        this.postalCode = postalCode;
    }

    public String getPostalCode() {
        return this.postalCode;
    }

    public boolean hasPostalCode() {
        return this.hasPostalCode;
    }

    @Override
    public String toXML() {
        String xml = "<" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":PostalCode>";
        if (this.hasPostalCode()) {
            xml += this.getPostalCode();
        }
        xml += "</" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":PostalCode>";
        return xml;
    }
}
