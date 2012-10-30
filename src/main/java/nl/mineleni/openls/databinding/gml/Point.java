package nl.mineleni.openls.databinding.gml;

import java.util.Vector;

import nl.mineleni.openls.XmlNamespaceConstants;

/**
 * http://schemas.opengis.net/gml/3.2.1/geometryBasic0d1d.xsd
 * 
 * <pre>
 * 
 * <complexType name="PointType">
 *   <complexContent>
 *     <extension base="gml:AbstractGeometricPrimitiveType">
 *       <sequence>
 *         <choice>
 *           <element ref="gml:pos" />
 *           <element ref="gml:coordinates" />
 *         </choice>
 *       </sequence>
 *     </extension>
 *   </complexContent>
 * </complexType>
 * 
 * </pre>
 * 
 * @author mprins
 */
public class Point implements XmlNamespaceConstants {

    /**
     * serialisation id.
     */
    private static final long serialVersionUID = -163863783181316506L;
    private Vector<Pos> pos = new Vector<Pos>();;
    private String srsName;

    private boolean hasSrsName;

    public Point() {
        this.hasSrsName = false;
    }

    public void addPos(Pos pos) {
        this.pos.add(pos);
    }

    public Pos getPosAt(int i) {
        return this.pos.get(i);
    }

    public int getPosSize() {
        return this.pos.size();
    }

    public void setSrsName(String srsName) {
        this.hasSrsName = true;
        this.srsName = srsName;
    }

    public String getSrsName() {
        return this.srsName;
    }

    public boolean hasSrsName() {
        return this.hasSrsName;
    }

    @Override
    public String toXML() {
        final StringBuilder sb = new StringBuilder("<"
                + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX + ":Point");

        if (this.hasSrsName()) {
            sb.append(" srsName=\"").append(this.getSrsName()).append("\"");
        }
        sb.append(">");
        for (final Pos p : this.pos) {
            sb.append(p.toXML());
        }
        sb.append("</" + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX
                + ":Point>");
        return sb.toString();

        // String xml = "<" + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX
        // + ":Point";
        // if (hasSrsName()) {
        // xml += " srsName=\"" + getSrsName() + "\"";
        // }
        // xml += ">";
        // for (Pos p : pos) {
        // xml += p.toXML();
        // }
        // xml += "</" + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX
        // + ":Point>";
        // return xml;
    }
}
