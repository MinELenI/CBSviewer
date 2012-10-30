package nl.mineleni.openls.parser;

import java.io.IOException;
import java.io.StringReader;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import nl.mineleni.openls.databinding.gml.Point;
import nl.mineleni.openls.databinding.gml.Pos;
import nl.mineleni.openls.databinding.openls.Address;
import nl.mineleni.openls.databinding.openls.Building;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;
import nl.mineleni.openls.databinding.openls.GeocodeResponseList;
import nl.mineleni.openls.databinding.openls.GeocodedAddress;
import nl.mineleni.openls.databinding.openls.Place;
import nl.mineleni.openls.databinding.openls.PostalCode;
import nl.mineleni.openls.databinding.openls.Street;
import nl.mineleni.openls.databinding.openls.StreetAddress;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 * The Class OpenLSResponseParser.
 */
public class OpenLSResponseParser extends DefaultHandler {

    /** logger. */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(OpenLSResponseParser.class);

    /** The e val buf. */
    private StringBuffer eValBuf;

    /** object stack. */

    private final Stack objStack = new Stack();

    /** SAX parser. */
    private SAXParser parser;

    /**
     * Instantiates a new open ls response parser.
     */
    public OpenLSResponseParser() {
        final SAXParserFactory factory = SAXParserFactory.newInstance();
        factory.setValidating(false);
        try {
            this.parser = factory.newSAXParser();
        } catch (final ParserConfigurationException e) {
            LOGGER.error("Configureren van de saxparser is mislukt: ", e);
        } catch (final SAXException e) {
            LOGGER.error("Maken van de saxparser is mislukt: ", e);
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.xml.sax.helpers.DefaultHandler#characters(char[], int, int)
     */
    @Override
    public void characters(final char[] ch, final int start, final int length)
            throws SAXException {
        this.eValBuf.append(ch, start, length);
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.xml.sax.helpers.DefaultHandler#endElement(java.lang.String,
     * java.lang.String, java.lang.String)
     */
    @Override
    public void endElement(final String uri, final String localName,
            final String qName) throws SAXException {
        final String[] nsName = qName.split(":");
        String eName = "";
        if (nsName.length > 1) {
            eName = nsName[1];
        } else {
            eName = nsName[0];
        }
        if (eName.equalsIgnoreCase("GeocodeResponseList")) {
            final GeocodeResponseList obj = (GeocodeResponseList) (this.objStack
                    .pop());
            if (this.objStack.peek().getClass() == new GeocodeResponse()
                    .getClass()) {
                ((GeocodeResponse) (this.objStack.peek()))
                        .addGeocodeResponseList(obj);
            }
        } else if (eName.equalsIgnoreCase("GeocodedAddress")) {
            final GeocodedAddress obj = (GeocodedAddress) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new GeocodeResponseList()
                    .getClass()) {
                ((GeocodeResponseList) (this.objStack.peek()))
                        .addGeocodedAddress(obj);
            }
        } else if (eName.equalsIgnoreCase("Point")) {
            final Point obj = (Point) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new GeocodedAddress()
                    .getClass()) {
                ((GeocodedAddress) (this.objStack.peek())).setPoint(obj);
            }
        } else if (eName.equalsIgnoreCase("pos")) {
            final Pos obj = (Pos) (this.objStack.pop());
            obj.setXY(this.eValBuf.toString());
            if (this.objStack.peek().getClass() == new Point().getClass()) {
                ((Point) (this.objStack.peek())).addPos(obj);
            }
        } else if (eName.equalsIgnoreCase("Address")) {
            final Address obj = (Address) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new GeocodedAddress()
                    .getClass()) {
                ((GeocodedAddress) (this.objStack.peek())).setAddress(obj);
            }
        } else if (eName.equalsIgnoreCase("StreetAddress")) {
            final StreetAddress obj = (StreetAddress) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new Address().getClass()) {
                ((Address) (this.objStack.peek())).setStreetAddress(obj);
            }
        } else if (eName.equalsIgnoreCase("Building")) {
            final Building obj = (Building) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new StreetAddress()
                    .getClass()) {
                ((StreetAddress) (this.objStack.peek())).setBuilding(obj);
            }
        } else if (eName.equalsIgnoreCase("Street")) {
            final Street obj = (Street) (this.objStack.pop());
            obj.setStreet(this.eValBuf.toString());
            if (this.objStack.peek().getClass() == new StreetAddress()
                    .getClass()) {
                ((StreetAddress) (this.objStack.peek())).setStreet(obj);
            }
        } else if (eName.equalsIgnoreCase("Place")) {
            final Place obj = (Place) (this.objStack.pop());
            obj.setPlace(this.eValBuf.toString());
            if (this.objStack.peek().getClass() == new Address().getClass()) {
                ((Address) (this.objStack.peek())).addPlace(obj);
            }
        } else if (eName.equalsIgnoreCase("PostalCode")) {
            final PostalCode obj = (PostalCode) (this.objStack.pop());
            obj.setPostalCode(this.eValBuf.toString());
            if (this.objStack.peek().getClass() == new Address().getClass()) {
                ((Address) (this.objStack.peek())).setPostalCode(obj);
            }
        }
    }

    /**
     * Gets the geocode response.
     * 
     * @return the geocode response
     */
    public GeocodeResponse getGeocodeResponse() {
        GeocodeResponse geocodeResponse = null;
        if (this.objStack.firstElement() != null) {
            if (this.objStack.firstElement().getClass() == new GeocodeResponse()
                    .getClass()) {
                geocodeResponse = (GeocodeResponse) this.objStack
                        .firstElement();
            }
        }
        return geocodeResponse;
    }

    /**
     * Parses the open ls response.
     * 
     * @param data
     *            the data which is an OpenLS response xml document
     * @return the geocode response object, will return null if parsing the data
     *         failed
     */
    public GeocodeResponse parseOpenLSResponse(final String data) {
        this.objStack.clear();
        try {
            this.parser.parse(new InputSource(new StringReader(data)), this);
        } catch (final SAXException e) {
            LOGGER.error("OpenLS response XML verwerken is mislukt: " + data
                    + ": ", e);
        } catch (final IOException e) {
            LOGGER.error("OpenLS response XML lezen is mislukt: ", e);
        }
        return this.getGeocodeResponse();
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.xml.sax.helpers.DefaultHandler#startElement(java.lang.String,
     * java.lang.String, java.lang.String, org.xml.sax.Attributes)
     */
    @Override
    public void startElement(final String uri, final String localName,
            final String qName, final Attributes attributes)
            throws SAXException {
        this.eValBuf = new StringBuffer();
        final String[] nsName = qName.split(":");
        String eName = "";
        if (nsName.length > 1) {
            eName = nsName[1];
        } else {
            eName = nsName[0];
        }
        if (eName.equalsIgnoreCase("GeocodeResponse")) {
            final GeocodeResponse obj = new GeocodeResponse();
            this.objStack.push(obj);
        } else if (eName.equalsIgnoreCase("GeocodeResponseList")) {
            final GeocodeResponseList obj = new GeocodeResponseList();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("numberOfGeocodedAddresses")) {
                    final int val = Integer.parseInt(value);
                    obj.setNumberOfGeocodedAddresses(val);
                }
            }
        } else if (eName.equalsIgnoreCase("GeocodedAddress")) {
            final GeocodedAddress obj = new GeocodedAddress();
            this.objStack.push(obj);
        } else if (eName.equalsIgnoreCase("Point")) {
            final Point obj = new Point();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("srsName")) {
                    obj.setSrsName(value);
                }
            }
        } else if (eName.equalsIgnoreCase("pos")) {
            final Pos obj = new Pos();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("dimension")) {
                    obj.setDimension(Integer.parseInt(value));
                }
            }
        } else if (eName.equalsIgnoreCase("Address")) {
            final Address obj = new Address();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("countryCode")) {
                    obj.setCountryCode(value);
                }
            }
        } else if (eName.equalsIgnoreCase("StreetAddress")) {
            final StreetAddress obj = new StreetAddress();
            this.objStack.push(obj);
        } else if (eName.equalsIgnoreCase("Building")) {
            final Building obj = new Building();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("number")) {
                    obj.setNumber(value);
                }
            }
        } else if (eName.equalsIgnoreCase("Street")) {
            final Street obj = new Street();
            this.objStack.push(obj);
        } else if (eName.equalsIgnoreCase("Place")) {
            final Place obj = new Place();
            this.objStack.push(obj);
            for (int i = 0; i < attributes.getLength(); i++) {
                final String key = attributes.getQName(i);
                final String value = attributes.getValue(i);
                if (key.equalsIgnoreCase("type")) {
                    obj.setType(value);
                }
            }
        } else if (eName.equalsIgnoreCase("PostalCode")) {
            final PostalCode obj = new PostalCode();
            this.objStack.push(obj);
        }
    }

}
