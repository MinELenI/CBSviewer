package nl.mineleni.openls.databinding.openls;

import java.util.Vector;

import nl.mineleni.openls.XmlNamespaceConstants;

/**
 * http://schemas.opengis.net/ols/1.2.0/LocationUtilityService.xsd
 * 
 * <pre>
 *  <complexType name="GeocodeResponseType">
 *   <annotation>
 *     <documentation>GeocodeResponse. The addresses returned will be normalized Address ADTs as a result of any parsing by the geocoder, etc.</documentation>
 *   </annotation>
 *   <complexContent>
 *     <extension base="xls:AbstractResponseParametersType">
 *       <sequence>
 *         <element ref="xls:GeocodeResponseList" maxOccurs="unbounded" />
 *       </sequence>
 *     </extension>
 *   </complexContent>
 * </complexType>
 * </pre>
 * 
 * @author Mark
 */
public class GeocodeResponse implements XmlNamespaceConstants {
    /**
     * serialization id.
     */
    private static final long serialVersionUID = -8343502033013447204L;

    private Vector<GeocodeResponseList> geocodeResponseList = new Vector<GeocodeResponseList>();

    public void addGeocodeResponseList(GeocodeResponseList val) {
        this.geocodeResponseList.add(val);
    }

    public GeocodeResponseList getGeocodeResponseListAt(int i) {
        return this.geocodeResponseList.get(i);
    }

    public int getGeocodeResponseListSize() {
        return this.geocodeResponseList.size();
    }

    @Override
    public String toXML() {
        final StringBuilder sb = new StringBuilder("<"
                + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeResponse " + "xmlns:"
                + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX + "=\""
                + XmlNamespaceConstants.OPENLS_NAMESPACE_URI + "\" " + "xmlns:"
                + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX + "=\""
                + XmlNamespaceConstants.OGC_GML_NAMESPACE_URI + "\">");
        for (final GeocodeResponseList gcrl : this.geocodeResponseList) {
            sb.append(gcrl.toXML());
        }
        sb.append("</" + XmlNamespaceConstants.OPENLS_NAMESPACE_PREFIX
                + ":GeocodeResponse>");
        return sb.toString();
    }
}
