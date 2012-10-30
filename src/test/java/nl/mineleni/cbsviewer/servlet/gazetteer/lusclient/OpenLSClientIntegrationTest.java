package nl.mineleni.cbsviewer.servlet.gazetteer.lusclient;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.util.Map;
import java.util.TreeMap;

import nl.mineleni.cbsviewer.util.StringConstants;
import nl.mineleni.openls.AbstractTestUtils;
import nl.mineleni.openls.databinding.openls.GeocodeRequest;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;
import nl.mineleni.openls.parser.OpenLSRequestParser;

import org.junit.Before;
import org.junit.Test;

/**
 * Testcases voor
 * {@link nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClient}.
 * 
 * @author mprins
 */
public class OpenLSClientIntegrationTest extends AbstractTestUtils {
    /** test subject. */
    private OpenLSClient openLSClient = null;

    @Before
    public void setUp() throws Exception {
        this.openLSClient = new OpenLSClient();
    }

    /**
     * Test open ls get. test methode voor
     * {@link OpenLSClient#doGetOpenLSRequest(String, Map)}
     */
    @Test
    public void testDoGetOpenLSRequest() {
        final Map<String, String> openLSParams = new TreeMap<String, String>();
        final String url = "http://geodata.nationaalgeoregister.nl/geocoder/Geocoder";
        openLSParams.put(StringConstants.OPENLS_REQ_PARAM_SEARCH.code,
                "hengelo");
        openLSParams.put(StringConstants.OPENLS_REQ_PARAM_REQUEST.code,
                StringConstants.OPENLS_REQ_VALUE_GEOCODE.code);
        final GeocodeResponse gcr = this.openLSClient.doGetOpenLSRequest(url,
                openLSParams);
        assertNotNull(gcr);
        assertTrue(gcr.getGeocodeResponseListSize() > 0);
    }

    /**
     * Test open ls post. Test methode voor
     * {@link OpenLSClient#doPostOpenLSRequest(String, GeocodeRequest)}
     * 
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     */
    @Test
    public void testDoPostOpenLSRequest() throws java.io.IOException {
        final String requestString = this
                .readFileAsString("/samplerequests/samplerequest.xml");
        final OpenLSRequestParser rp = new OpenLSRequestParser();
        final GeocodeRequest gcreq = rp.parseOpenLSRequest(requestString);
        final GeocodeResponse gcr = this.openLSClient.doPostOpenLSRequest(
                "http://geodata.nationaalgeoregister.nl/geocoder/Geocoder",
                gcreq);
        assertNotNull(gcr);
        assertTrue(gcr.getGeocodeResponseListSize() == 0);
    }

    /**
     * Test open ls free form post such as openrouteservice.org. Test methode
     * voor {@link OpenLSClient#doPostOpenLSRequest(String, Map) }
     * 
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     */
    @Test
    public void testDoPostOpenLSRequestFreeForm() throws java.io.IOException {
        final String url = "http://www.openrouteservice.org/php/OpenLSLUS_Geocode.php";
        final Map<String, String> openLSParams = new TreeMap<String, String>();
        openLSParams.put(StringConstants.OPENLS_REQ_PARAM_REQUEST.code,
                StringConstants.OPENLS_REQ_VALUE_GEOCODE.code);
        openLSParams.put("FreeFormAdress", "hengelo");
        openLSParams.put("MaxResponse", "3");
        final GeocodeResponse gcr = this.openLSClient.doPostOpenLSRequest(url,
                openLSParams);
        assertNotNull(gcr);
        assertTrue(gcr.getGeocodeResponseListSize() > 0);
    }

}
