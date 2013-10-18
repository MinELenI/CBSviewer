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
import nl.mineleni.openls.databinding.openls.Address;
import nl.mineleni.openls.databinding.openls.Building;
import nl.mineleni.openls.databinding.openls.GeocodeRequest;
import nl.mineleni.openls.databinding.openls.Place;
import nl.mineleni.openls.databinding.openls.PostalCode;
import nl.mineleni.openls.databinding.openls.Street;
import nl.mineleni.openls.databinding.openls.StreetAddress;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The Class OpenLSRequestParserTest.
 * 
 * @since 1.7
 */
public class OpenLSRequestParserTest extends AbstractTestUtils {
	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(OpenLSRequestParserTest.class);

	/**
	 * Test open ls request parser. Iterate through the sample openls request
	 * files and try to extract a GeocodeRequest from them.
	 * 
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	@Test
	public void testOpenLSRequestParser() throws IOException {
		final OpenLSRequestParser rp = new OpenLSRequestParser();
		final File folder = new File("./target/test-classes/samplerequests/");
		final List<File> fileList = new ArrayList<>();
		this.listDirectoryFilenames(folder, fileList);
		final java.util.Iterator<File> fileIt = fileList.iterator();
		while (fileIt.hasNext()) {
			final String fileName = "/samplerequests/"
					+ fileIt.next().getName();
			final String requestString = this.readFileAsString(fileName);
			final GeocodeRequest gcrq = rp.parseOpenLSRequest(requestString);
			if (gcrq != null) {
				LOGGER.info(gcrq.toXML());
			}
			assertNotNull(gcrq);
		}
	}

	/**
	 * Test open ls request roundtrip.
	 * <ol>
	 * <li>create an openls request</li>
	 * <li>serialize it to xml string</li>
	 * <li>use the request parser to deserialize the xml to a new openls request
	 * object</li>
	 * <li>serialize the new openls request object to xml string</li>
	 * <li>check if the first xml string is the same as the second xml string</li>
	 * </ol>
	 * 
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	@Test
	public void testOpenLSRequestRoundtrip() throws IOException {
		final GeocodeRequest gcr = new GeocodeRequest();

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

		sa.setStreet(street);
		sa.setBuilding(building);
		address.setPostalCode(pc);
		address.setCountryCode("NL");
		address.addPlace(p);
		address.setStreetAddress(sa);

		gcr.addAddress(address);

		// create xml from response object
		final String gcrXML = gcr.toXML();

		final OpenLSRequestParser rp = new OpenLSRequestParser();
		final GeocodeRequest newgcr = rp.parseOpenLSRequest(gcrXML);
		final String newgcrXML = newgcr.toXML();

		LOGGER.info(gcrXML);
		LOGGER.info(newgcrXML);

		assertEquals(gcrXML, newgcrXML);
	}

}
