package nl.mineleni.openls;

import java.io.Serializable;

/**
 * The Interface XmlNamespaceConstants.
 */
public interface XmlNamespaceConstants extends Serializable {

    /** De constante OPENLS_NAMESPACE_URI. {@value} */
    final String OPENLS_NAMESPACE_URI = "http://www.opengis.net/xls";

    /** De constante OPENLS_NAMESPACE_PREFIX. {@value} */
    final String OPENLS_NAMESPACE_PREFIX = "xls";

    /** De constante OGC_GML_NAMESPACE_URI. {@value} */
    final String OGC_GML_NAMESPACE_URI = "http://www.opengis.net/gml/3.2";

    /** De constante OGC_GML_NAMESPACE_PREFIX. {@value} */
    final String OGC_GML_NAMESPACE_PREFIX = "gml";

    /**
     * geeft een XML string representatie van dit object.
     * 
     * @return een XML string die dit object beschrijft
     */
    String toXML();
}
