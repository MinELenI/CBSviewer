package nl.mineleni.cbsviewer.servlet.gazetteer.lusclient;

import static javax.servlet.http.HttpServletResponse.SC_OK;
import static nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientAddress.APPEND_GEMEENTE;
import static nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientAddress.APPEND_PLAATS;
import static nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientAddress.APPEND_PROVINCIE;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import nl.mineleni.openls.databinding.openls.GeocodeRequest;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;
import nl.mineleni.openls.parser.OpenLSResponseParser;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * OpenLSClient.
 * 
 * @author mprins
 */
public class OpenLSClient {

	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(OpenLSClient.class);

	/** de http client voor communicatie met de LUS. */
	private final CloseableHttpClient client;
	/** De open ls response parser. */
	private final OpenLSResponseParser openLSResponseParser;
	/** http request configuratie. */
	private RequestConfig requestConfig;

	/**
	 * Maakt een nieuwe instance van de LUS client. Stelt de http proxy in mits
	 * deze in de omgevingsvariabelen is gedefinieerd middels
	 * {@code http.proxyHost} en {@code http.proxyPort}.
	 */
	public OpenLSClient() {
		client = HttpClients.createSystem();
		requestConfig = RequestConfig.custom()
				.setCookieSpec(CookieSpecs.IGNORE_COOKIES).build();

		final String pHost = System.getProperty("http.proxyHost");
		int pPort = -1;
		try {
			pPort = Integer.valueOf(System.getProperty("http.proxyPort"));
		} catch (final NumberFormatException e) {
			LOGGER.debug("Geen proxy poort gedefinieerd.");
		}
		if ((null != pHost) && (pPort > 0)) {
			LOGGER.info("Instellen van proxy config: " + pHost + ":" + pPort);
			final HttpHost proxy = new HttpHost(pHost, pPort, "http");
			requestConfig = RequestConfig.copy(requestConfig).setProxy(proxy)
					.build();
		} else {
			LOGGER.info("Er wordt geen proxy ingesteld.");
		}
		this.openLSResponseParser = new OpenLSResponseParser();
	}

	/**
	 * Do get open ls request.
	 * 
	 * @param url
	 *            the url
	 * @param getParams
	 *            the get params
	 * @return the geocode response, will be null if something went wrong in the
	 *         process of getting an openls response and parsing it
	 */
	public GeocodeResponse doGetOpenLSRequest(final String url,
			final Map<String, String> getParams) {
		final String queryString = url.endsWith("?") ? url : url + "?";
		final StringBuilder qs = new StringBuilder(queryString);
		try {
			for (final Entry<String, String> getParam : getParams.entrySet()) {
				qs.append(URLEncoder.encode(getParam.getKey(), "UTF-8"))
						.append("=")
						.append(URLEncoder.encode(
								(getParam.getValue())
										.replaceAll(APPEND_GEMEENTE, "")
										.replaceAll(APPEND_PLAATS, "")
										.replaceAll(APPEND_PROVINCIE, ""),
								"UTF-8")).append("&");
			}
		} catch (final UnsupportedEncodingException e) {
			LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
					+ e);
		}
		LOGGER.debug("GETting OLS query:\n\t" + qs.toString());

		try {
			final HttpGet httpget = new HttpGet(qs.toString());
			httpget.setConfig(requestConfig);
			final HttpResponse getResp = this.client.execute(httpget);
			if (getResp.getStatusLine().getStatusCode() == SC_OK) {
				final String responseBody = EntityUtils.toString(
						getResp.getEntity()).trim();
				return this.openLSResponseParser
						.parseOpenLSResponse(responseBody);
			} else {
				LOGGER.error("OpenLS server get error response: "
						+ getResp.getStatusLine());
			}
		} catch (final ClientProtocolException e) {
			LOGGER.error(
					"Versturen get request naar OpenLS server is mislukt: ", e);
		} catch (final IOException e) {
			LOGGER.error(
					"Ontvangen get response van OpenLS server is mislukt: ", e);

		}
		return null;
	}

	/**
	 * Do post open ls request.
	 * 
	 * @param url
	 *            the url
	 * @param request
	 *            the request
	 * @return the geocode response, will be null if something went wrong in the
	 *         process of getting an openls response and parsing it
	 */
	public GeocodeResponse doPostOpenLSRequest(final String url,
			final GeocodeRequest request) {
		LOGGER.debug("POSTting OLS query:\n\t" + request.toXML());
		try {
			final StringEntity str = new StringEntity(request.toXML(),
					ContentType.TEXT_XML);
			final HttpPost httppost = new HttpPost(url);
			httppost.setEntity(str);
			httppost.setConfig(this.requestConfig);
			final HttpResponse resp = this.client.execute(httppost);
			if (resp.getStatusLine().getStatusCode() == SC_OK) {
				final String responseBody = EntityUtils.toString(
						resp.getEntity()).trim();
				return this.openLSResponseParser
						.parseOpenLSResponse(responseBody);
			} else {
				LOGGER.error("OpenLS server post error response: "
						+ resp.getStatusLine());
			}
		} catch (final UnsupportedEncodingException e) {
			LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
					+ e);
		} catch (final ClientProtocolException e) {
			LOGGER.error(
					"Versturen post request naar OpenLS server is mislukt: ", e);
		} catch (final IOException e) {
			LOGGER.error(
					"Ontvangen post response van OpenLS server is mislukt: ", e);
		}
		return null;
	}

	/**
	 * post a freeform open ls request. eg. to openrouteservice.org.
	 * 
	 * @param url
	 *            the url
	 * @param getParams
	 *            the post params
	 * @return the geocode response, will be null if something went wrong in the
	 *         process of getting an openls response and parsing it
	 */
	public GeocodeResponse doPostOpenLSRequest(final String url,
			final Map<String, String> getParams) {
		final HttpPost httppost = new HttpPost(url);
		try {
			final List<NameValuePair> nvps = new ArrayList<>();
			for (final Entry<String, String> getParam : getParams.entrySet()) {
				nvps.add(new BasicNameValuePair(URLEncoder.encode(
						getParam.getKey(), "UTF-8"), URLEncoder.encode(
						(getParam.getValue()).replaceAll(APPEND_GEMEENTE, "")
								.replaceAll(APPEND_PLAATS, "")
								.replaceAll(APPEND_PROVINCIE, ""), "UTF-8")));
			}
			httppost.setEntity(new UrlEncodedFormEntity(nvps, "UTF-8"));
			httppost.setConfig(this.requestConfig);

			final HttpResponse resp = this.client.execute(httppost);
			if (resp.getStatusLine().getStatusCode() == SC_OK) {
				final String responseBody = EntityUtils.toString(
						resp.getEntity()).trim();
				return this.openLSResponseParser
						.parseOpenLSResponse(responseBody);
			} else {
				LOGGER.error("OpenLS server get error response: "
						+ resp.getStatusLine());
			}

		} catch (final UnsupportedEncodingException e) {
			LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
					+ e);
		} catch (final ClientProtocolException e) {
			LOGGER.error(
					"Versturen post request naar OpenLS server is mislukt: ", e);

		} catch (final IOException e) {
			LOGGER.error(
					"Ontvangen get response van OpenLS server is mislukt: ", e);
		}
		return null;
	}
}
