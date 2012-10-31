package nl.mineleni.openls.databinding.gml;

import nl.mineleni.openls.XmlNamespaceConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * http://schemas.opengis.net/gml/3.2.1/geometryBasic0d1d.xsd
 * 
 * <pre>
 * 
 * <complexType name="DirectPositionType">
 *   <annotation>
 *     <documentation>Direct position instances hold the coordinates
 *     for a position within some coordinate reference system (CRS).
 *     Since direct positions, as data types, will often be included
 *     in larger objects (such as geometry elements) that have
 *     references to CRS, the srsName attribute will in general be
 *     missing, if this particular direct position is included in a
 *     larger element with such a reference to a CRS. In this case,
 *     the CRS is implicitly assumed to take on the value of the
 *     containing object's CRS. if no srsName attribute is given, the
 *     CRS shall be specified as part of the larger context this
 *     geometry element is part of, typically a geometric object like
 *     a point, curve, etc.</documentation>
 *   </annotation>
 *   <simpleContent>
 *     <extension base="gml:doubleList">
 *       <attributeGroup ref="gml:SRSReferenceGroup" />
 *     </extension>
 *   </simpleContent>
 * </complexType>
 * <element name="pos" type="gml:DirectPositionType" />
 * 
 * </pre>
 * 
 * @author Mark
 */
public class Pos implements XmlNamespaceConstants {
    /**
     * serialisation id.
     */
    private static final long serialVersionUID = -1063398145364381070L;

    /** logger. */
    private static final Logger LOGGER = LoggerFactory.getLogger(Pos.class);

    private Double x;
    private Double y;
    private int dimension;

    private boolean hasX;
    private boolean hasY;
    private boolean hasXY;
    private boolean hasDimension;

    public Pos() {
        this.hasX = false;
        this.hasY = false;
        this.hasXY = false;
        this.hasDimension = false;
    }

    public void setXY(String xy) {
        try {
            final String[] xySplit = xy.split(" ");
            if (xySplit.length == 2) {
                this.setX(Double.parseDouble(xySplit[0]));
                this.setY(Double.parseDouble(xySplit[1]));
            }
            this.hasXY = true;
        } catch (final NumberFormatException e) {
            LOGGER.error("Verwerken van puntlocatie mislukt, waarde: " + xy
                    + ": ", e);
        }
    }

    public void setX(Double x) {
        this.hasX = true;
        if (this.hasY) {
            this.hasXY = true;
        }
        this.x = x;
    }

    public Double getX() {
        return this.x;
    }

    public void setY(Double y) {
        this.hasY = true;
        if (this.hasX) {
            this.hasXY = true;
        }
        this.y = y;
    }

    public Double getY() {
        return this.y;
    }

    public String getXY() {
        return this.x.toString() + " " + this.y.toString();
    }

    public boolean hasXY() {
        return this.hasXY;
    }

    public void setDimension(int dimension) {
        this.dimension = dimension;
    }

    public int getDimension() {
        return this.dimension;
    }

    public boolean hasDimension() {
        return this.hasDimension;
    }

    @Override
    public String toXML() {
        String xml = "<" + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX
                + ":Pos";
        if (this.hasDimension()) {
            xml += " dimension=\"" + this.getDimension() + "\"";
        }
        xml += ">";
        if (this.hasXY()) {
            xml += this.getXY();
        }
        xml += "</" + XmlNamespaceConstants.OGC_GML_NAMESPACE_PREFIX + ":Pos>";
        return xml;
    }
}
