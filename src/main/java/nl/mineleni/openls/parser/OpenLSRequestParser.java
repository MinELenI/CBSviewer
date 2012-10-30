package nl.mineleni.openls.parser;

import java.io.IOException;
import java.io.StringReader;
import java.util.Stack;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import nl.mineleni.openls.databinding.openls.Address;
import nl.mineleni.openls.databinding.openls.Building;
import nl.mineleni.openls.databinding.openls.GeocodeRequest;
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
 * The Class OpenLSRequestParser.
 */
public class OpenLSRequestParser extends DefaultHandler {

    /** logger. */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(OpenLSRequestParser.class);

    /** The e val buf. */
    private StringBuffer eValBuf;

    /** The obj stack. */
    private final Stack objStack = new Stack();

    /** The parser. */
    private SAXParser parser;

    /**
     * Instantiates a new open ls request parser.
     */
    public OpenLSRequestParser() {
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
        if (eName.equalsIgnoreCase("Address")) {
            final Address obj = (Address) (this.objStack.pop());
            if (this.objStack.peek().getClass() == new GeocodeRequest()
                    .getClass()) {
                ((GeocodeRequest) (this.objStack.peek())).addAddress(obj);
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
     * Gets the geocode request.
     * 
     * @return the geocode request
     */
    public GeocodeRequest getGeocodeRequest() {
        GeocodeRequest geocodeRequest = null;
        if (this.objStack.firstElement() != null) {
            if (this.objStack.firstElement().getClass() == new GeocodeRequest()
                    .getClass()) {
                geocodeRequest = (GeocodeRequest) this.objStack.firstElement();
            }
        }
        return geocodeRequest;
    }

    /**
     * Parses the open ls request.
     * 
     * @param data
     *            the data
     * @return the geocode request
     */
    public GeocodeRequest parseOpenLSRequest(final String data) {
        this.objStack.clear();
        try {
            this.parser.parse(new InputSource(new StringReader(data)), this);
        } catch (final SAXException e) {
            LOGGER.error("OpenLS response XML verwerken is mislukt: " + data
                    + ": ", e);
        } catch (final IOException e) {
            LOGGER.error("OpenLS response XML lezen is mislukt: ", e);
        }
        return this.getGeocodeRequest();
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
        if (eName.equalsIgnoreCase("GeocodeRequest")) {
            final GeocodeRequest obj = new GeocodeRequest();
            this.objStack.push(obj);
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
