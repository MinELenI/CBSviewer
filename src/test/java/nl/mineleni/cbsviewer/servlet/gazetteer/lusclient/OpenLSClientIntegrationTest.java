/*
 * Copyright (c) 2012-2014, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet.gazetteer.lusclient;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringCase;
import static org.hamcrest.Matchers.greaterThan;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.util.Map;
import java.util.TreeMap;

import nl.mineleni.cbsviewer.util.StringConstants;
import nl.mineleni.openls.AbstractTestUtils;
import nl.mineleni.openls.databinding.openls.GeocodeRequest;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;
import nl.mineleni.openls.databinding.openls.ReverseGeocodeResponse;
import nl.mineleni.openls.parser.OpenLSGeocodeRequestParser;

import org.junit.Before;
import org.junit.Test;

/**
 * Testcases voor {@link OpenLSClient}.
 * 
 * @author mprins
 * @since 1.7
 */
public class OpenLSClientIntegrationTest extends AbstractTestUtils {
	/** test subject. */
	private OpenLSClient openLSClient = null;

	/**
	 * Maak een nieuwe OpenLSClient.
	 * 
	 * @throws Exception
	 *             als t niet lukt
	 */
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
		final Map<String, String> openLSParams = new TreeMap<>();
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
	public void testDoPostOpenLSRequest() throws IOException {
		final String requestString = this
				.readFileAsString("/samplerequests/geocode/samplerequest.xml");
		final OpenLSGeocodeRequestParser rp = new OpenLSGeocodeRequestParser();
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
	public void testDoPostOpenLSRequestFreeForm() throws IOException {
		final String url = "http://www.openrouteservice.org/php/OpenLSLUS_Geocode.php";
		final Map<String, String> openLSParams = new TreeMap<>();
		openLSParams.put(StringConstants.OPENLS_REQ_PARAM_REQUEST.code,
				StringConstants.OPENLS_REQ_VALUE_GEOCODE.code);
		openLSParams.put("FreeFormAdress", "hengelo");
		openLSParams.put("MaxResponse", "3");
		final GeocodeResponse gcr = this.openLSClient.doPostOpenLSRequest(url,
				openLSParams);
		assertNotNull(gcr);
		assertTrue(gcr.getGeocodeResponseListSize() > 0);
	}

	/**
	 * Test open ls free form post such as openrouteservice.org. Test methode
	 * voor {@link OpenLSClient#doPostOpenLSReverseGeocodeRequest(String, Map) }
	 * 
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	@Test
	public void testDoPostReverseOpenLSRequestFreeForm() throws IOException {
		final String url = "http://openrouteservice.org/php/OpenLSLUS_Geocode.php";
		final Map<String, String> openLSParams = new TreeMap<>();
		openLSParams.put("Lon", "8.6935537939344");
		openLSParams.put("Lat", "49.409919381219");
		openLSParams.put("MaxResponse", "1");

		final ReverseGeocodeResponse gcr = this.openLSClient
				.doPostOpenLSReverseGeocodeRequest(url, openLSParams);
		assertNotNull(gcr);
		assertNotNull(gcr.getReverseGeocodedLocation());
		assertThat(gcr.getReverseGeocodedLocation().getAddress()
				.getCountryCode(), equalToIgnoringCase("de"));
		assertThat(gcr.getReverseGeocodedLocation().getAddress()
				.getPlaceByType("Municipality"), equalTo("Heidelberg"));
		assertThat(gcr.getReverseGeocodedLocation().getAddress()
				.getPlaceByType("CountrySubdivision"),
				equalTo("Baden-Württemberg"));
		assertThat(gcr.getReverseGeocodedLocation().getSearchCentreDistance()
				.getValue(), greaterThan(0d));

	}
}
