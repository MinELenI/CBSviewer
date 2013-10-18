/*
 * Copyright (c) 2012-2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.openls.parser;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientUtil;
import nl.mineleni.openls.AbstractTestUtils;
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

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The Class OpenLSResponseParserTest.
 * 
 * @since 1.7
 */
public class OpenLSResponseParserTest extends AbstractTestUtils {
	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(OpenLSResponseParserTest.class);

	/**
	 * Test open ls request parser. Iterate through the sample openls response
	 * files and try to extract a GeocodeResponse from them.
	 * 
	 * @throws java.io.IOException
	 *             Signals that an I/O exception has occurred.
	 */
	@Test
	public void testOpenLSResponseParser() throws IOException {
		final OpenLSResponseParser rp = new OpenLSResponseParser();
		final File folder = new File("./target/test-classes/sampleresponses/");
		final List<File> fileList = new ArrayList<>();
		this.listDirectoryFilenames(folder, fileList);
		final java.util.Iterator<File> fileIt = fileList.iterator();
		while (fileIt.hasNext()) {
			final String fileName = "/sampleresponses/"
					+ fileIt.next().getName();
			final String responseString = this.readFileAsString(fileName);
			final GeocodeResponse gcr = rp.parseOpenLSResponse(responseString);
			if (gcr != null) {
				LOGGER.info(gcr.toXML());
			}
			assertNotNull(gcr);
		}
	}

	/**
	 * Test open ls response roundtrip.
	 * <ol>
	 * <li>create an openls response</li>
	 * <li>serialize it to xml string</li>
	 * <li>use the response parser to deserialize the xml to a new openls</li>
	 * response object</li>
	 * <li>serialize the new openls object to xml string</li>
	 * <li>check if the first xml string is the same as the second xml string</li>
	 * </ol>
	 * 
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	@Test
	public void testOpenLSResponseRoundtrip() throws IOException {
		final GeocodeResponse gcr = new GeocodeResponse();

		final GeocodeResponseList gcrl = new GeocodeResponseList();
		gcrl.setNumberOfGeocodedAddresses(1);

		final GeocodedAddress gca = new GeocodedAddress();

		final Address address = new Address();

		final StreetAddress sa = new StreetAddress();

		final Building building = new Building();
		building.setNumber("100");

		final Place p = new Place();
		p.setType(OpenLSClientUtil.PLACE_TYPE_MUNICIPALITY);
		p.setPlace("Utrecht");

		final PostalCode pc = new PostalCode();
		pc.setPostalCode("1234HH");

		final Street street = new Street();
		street.setStreet("Kosterijland 78");

		final Point point = new Point();
		point.setSrsName("EPSG:28992");

		final Pos pos = new Pos();
		pos.setX(new Double(1234));
		pos.setY(new Double(5678));

		point.addPos(pos);
		sa.setStreet(street);
		sa.setBuilding(building);
		address.setPostalCode(pc);
		address.setCountryCode("NL");
		address.addPlace(p);
		address.setStreetAddress(sa);
		gca.setAddress(address);
		gca.setPoint(point);
		gcrl.addGeocodedAddress(gca);
		gcr.addGeocodeResponseList(gcrl);

		// create xml from response object
		final String gcrXML = gcr.toXML();

		final OpenLSResponseParser rp = new OpenLSResponseParser();
		final GeocodeResponse newgcr = rp.parseOpenLSResponse(gcrXML);
		final String newgcrXML = newgcr.toXML();

		LOGGER.info(gcrXML);
		LOGGER.info(newgcrXML);

		assertEquals(gcrXML, newgcrXML);
	}

}
