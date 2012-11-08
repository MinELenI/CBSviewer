package nl.mineleni.openls.databinding.openls;

import java.util.Vector;

import nl.mineleni.openls.XmlNamespaceConstants;

/**
 * http://schemas.opengis.net/ols/1.2.0/LocationUtilityService.xsd
 * 
 * <pre>
 * <!-- ====================================================== --> 
 * <element name="GeocodeRequest" type="xls:GeocodeRequestType" substitutionGroup="xls:_RequestParameters"> 
 *  <annotation>
 *      <documentation>Geocode Service Request</documentation> 
 *  </annotation>
 * </element> 
 * <!-- ====================================================== --> 
 * <complexType name="GeocodeRequestType"> 
 * <annotation>
 *      <documentation>Geocode Request.</documentation> 
 * </annotation>
 * <complexContent> 
 *  <extension base="xls:AbstractRequestParametersType">
 *  <sequence> 
 *      <element ref="xls:Address" maxOccurs="unbounded"/> 
 *  </sequence>
 *  <attribute name="returnFreeForm" type="boolean" use="optional" default="false"> 
 *      <annotation> 
 *          <documentation>Used to request freeform addresses in the response, as opposed to structured adddresses</documentation> 
 *      </annotation> 
 *  </attribute> 
 * </extension>
 * </complexContent>
 * </complexType>
 * 
 * </pre>
 * 
 * @author mprins
 * @since 1.6
 */

public class GeocodeRequest implements XmlNamespaceConstants {
    /**
     * serialization id.
     */
    private static final long serialVersionUID = -1347583150356760221L;
    private final Vector<Address> addressList = new Vector<Address>();

    public void addAddress(Address val) {
        this.addressList.add(val);
    }

    public Address getAddressAt(int i) {
        return this.addressList.get(i);
    }

    public int getAddressSize() {
        return this.addressList.size();
    }

    @Override
    public String toXML() {

        final StringBuilder sb = new StringBuilder("<"
                + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeRequest " + "xmlns:"
                + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX + "=\""
                + XmlNamespaceConstants.OPENLS_NAMESPACE_URI + "\" " + "xmlns:"
                + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX + "=\""
                + XmlNamespaceConstants.OGC_GML_NAMESPACE_URI + "\">");

        for (final Address addrl : this.addressList) {
            sb.append(addrl.toXML());
        }
        sb.append("</" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeRequest>");
        return sb.toString();
    }
}