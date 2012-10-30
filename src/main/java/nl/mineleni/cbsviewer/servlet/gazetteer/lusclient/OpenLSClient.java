package nl.mineleni.cbsviewer.servlet.gazetteer.lusclient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;

import nl.mineleni.openls.databinding.openls.GeocodeRequest;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;
import nl.mineleni.openls.parser.OpenLSResponseParser;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
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
    private final HttpClient client;

    /** De open ls response parser. */
    private final OpenLSResponseParser openLSResponseParser;

    /**
     * Maakt een nieuwe instance van de LUS client. Stelt de http proxy in mits
     * deze in de omgevingsvariabelen is gedefinieerd middels
     * {@code http.proxyHost} en {@code http.proxyPort}.
     */
    public OpenLSClient() {
        this.client = new HttpClient();
        final String pHost = System.getProperty("http.proxyHost");
        int pPort = -1;
        try {
            pPort = Integer.valueOf(System.getProperty("http.proxyPort"));
        } catch (final NumberFormatException e) {
            LOGGER.debug("Geen proxy poort gedefinieerd.");
        }
        LOGGER.debug("proxy config data (host:port): " + pHost + ":" + pPort);

        if ((null != pHost) && (pPort > 0)) {
            LOGGER.info("Instellen van proxy config: " + pHost + ":" + pPort);
            this.client.getHostConfiguration().setProxy(pHost, pPort);
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
                        .append(URLEncoder.encode(getParam.getValue(), "UTF-8"))
                        .append("&");
            }
        } catch (final UnsupportedEncodingException e) {
            LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
                    + e);
        }
        LOGGER.debug("GETting OLS query:\n\t" + qs.toString());
        final GetMethod getMethod = new GetMethod(qs.toString());
        BufferedReader br = null;
        final StringBuilder sb = new StringBuilder();
        try {
            final int returnCode = this.client.executeMethod(getMethod);
            if (returnCode == HttpStatus.SC_OK) {
                br = new BufferedReader(new InputStreamReader(
                        getMethod.getResponseBodyAsStream(), "UTF-8"));
                String readLine;
                while (((readLine = br.readLine()) != null)) {
                    sb.append(readLine);
                }
            } else {
                LOGGER.error("OpenLS server get error response: "
                        + getMethod.getResponseBodyAsString());
            }
        } catch (final HttpException e) {
            LOGGER.error(
                    "Versturen get request naar OpenLS server is mislukt: ", e);
        } catch (final IOException e) {
            LOGGER.error(
                    "Ontvangen get response van OpenLS server is mislukt: ", e);
        } finally {
            getMethod.releaseConnection();
            if (br != null) {
                try {
                    br.close();
                } catch (final IOException fe) {
                    LOGGER.debug(
                            "Fout opgetreden tijdens release van verbinding, "
                                    + "hier is niks meer aan te doen.", fe);
                }
            }
        }
        return this.openLSResponseParser.parseOpenLSResponse(sb.toString());
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
        final PostMethod postMethod = new PostMethod(url);
        LOGGER.debug("POSTting OLS query:\n\t" + request.toXML());

        StringRequestEntity str = null;
        try {
            str = new StringRequestEntity(request.toXML(), "text/xml", "UTF-8");
        } catch (final UnsupportedEncodingException e) {
            LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
                    + e);
        }
        postMethod.setRequestEntity(str);
        final StringBuilder sb = new StringBuilder();
        BufferedReader br = null;
        try {
            final int returnCode = this.client.executeMethod(postMethod);
            if (returnCode == HttpStatus.SC_OK) {
                br = new BufferedReader(new InputStreamReader(
                        postMethod.getResponseBodyAsStream(), "UTF-8"));
                String readLine;
                while (((readLine = br.readLine()) != null)) {
                    sb.append(readLine);
                }
            } else {
                LOGGER.error("OpenLS server post error response: "
                        + postMethod.getResponseBodyAsString());
            }
        } catch (final HttpException e) {
            LOGGER.error(
                    "Versturen post request naar OpenLS server is mislukt: ", e);
        } catch (final IOException e) {
            LOGGER.error(
                    "Ontvangen post response van OpenLS server is mislukt: ", e);
        } finally {
            postMethod.releaseConnection();
            if (br != null) {
                try {
                    br.close();
                } catch (final IOException fe) {
                    LOGGER.debug(
                            "Fout opgetreden tijden release van verbinding, "
                                    + "hier is niks meer aan te doen.", fe);
                }
            }
        }
        return this.openLSResponseParser.parseOpenLSResponse(sb.toString());
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
        final PostMethod postMethod = new PostMethod(url);
        try {
            for (final Entry<String, String> getParam : getParams.entrySet()) {
                postMethod.addParameter(
                        URLEncoder.encode(getParam.getKey(), "UTF-8"),
                        URLEncoder.encode(getParam.getValue(), "UTF-8"));
            }
        } catch (final UnsupportedEncodingException e) {
            LOGGER.error("De gebruikte Java VM ondersteunt geen UTF-8 encoding: "
                    + e);
        }

        BufferedReader br = null;
        final StringBuilder sb = new StringBuilder();
        try {
            final int returnCode = this.client.executeMethod(postMethod);
            if (returnCode == HttpStatus.SC_OK) {
                br = new BufferedReader(new InputStreamReader(
                        postMethod.getResponseBodyAsStream(), "UTF-8"));
                String readLine;
                while (((readLine = br.readLine()) != null)) {
                    sb.append(readLine);
                }
            } else {
                LOGGER.error("OpenLS server get error response: "
                        + postMethod.getResponseBodyAsString());
            }
        } catch (final HttpException e) {
            LOGGER.error(
                    "Versturen get request naar OpenLS server is mislukt: ", e);
        } catch (final IOException e) {
            LOGGER.error(
                    "Ontvangen get response van OpenLS server is mislukt: ", e);
        } finally {
            postMethod.releaseConnection();
            if (br != null) {
                try {
                    br.close();
                } catch (final IOException fe) {
                    LOGGER.debug(
                            "Fout opgetreden tijdens release van verbinding, "
                                    + "hier is niks meer aan te doen.", fe);
                }
            }
        }
        return this.openLSResponseParser.parseOpenLSResponse(sb.toString());
    }
}
