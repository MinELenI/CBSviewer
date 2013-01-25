/*
 * Copyright (c) 2012, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 * 
 * Gepubliceerd onder de BSD 2-clause licentie, 
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie. 
 */
package nl.mineleni.cbsviewer.servlet;

import static javax.servlet.http.HttpServletResponse.SC_FORBIDDEN;
import static javax.servlet.http.HttpServletResponse.SC_OK;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.mineleni.cbsviewer.servlet.wms.FeatureInfoResponseConverter;
import nl.mineleni.cbsviewer.util.AvailableLayersBean;
import nl.mineleni.cbsviewer.util.EncodingUtil;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//CHECKSTYLE.OFF: LineLength - geen controle van deze doc op regel lengte
/**
 * Dit is een proxy servlet voor WxS services; ter verhelping van het single
 * domain javascript policy fenomeen. <br>
 * Servlet configuratie:
 * 
 * <pre>
 *  &lt;servlet&gt;
 *     &lt;servlet-name&gt;ReverseProxyServlet&lt;/servlet-name&gt;
 *     &lt;display-name&gt;ReverseProxyServlet&lt;/display-name&gt;
 *     &lt;description&gt;reverse proxy servlet om XHR te laten werken&lt;/description&gt;
 *     &lt;servlet-class&gt;nl.mineleni.cbsviewer.servlet.ReverseProxyServlet&lt;/servlet-class&gt;
 *  &lt;init-param&gt;
 *    &lt;param-name&gt;allowed_hosts&lt;/param-name&gt;
 *    &lt;param-value&gt;dbr4011v.dbr.agro.nl; ws.geonames.org; cacheflow.nic.agro.nl:8080&lt;/param-value&gt;
 *    &lt;description&gt;Servers die zijn toegestaan om te benaderen via deze proxy, scheiden door een ; [punt-komma]. Verplichte param&lt;/description&gt;
 *  &lt;/init-param&gt;
 *  &lt;init-param&gt;
 *    &lt;param-name&gt;force_xml_mime&lt;/param-name&gt;
 *    &lt;param-value&gt;false&lt;/param-value&gt;
 *  &lt;description&gt;optie om text/xml mime type voor response te forceren, optionele param&lt;/description&gt;
 *  &lt;/init-param&gt;
 *    &lt;load-on-startup&gt;2&lt;/load-on-startup&gt;
 *  &lt;/servlet&gt;
 * </pre>
 * 
 * @author prinsmc
 * @since 1.7
 */
public class ReverseProxyServlet extends AbstractBaseServlet {
	// CHECKSTYLE.ON:
	/** Forceer xml output optie sleutel. {@value} */
	public static final String FORCE_XML_MIME = "force_xml_mime";

	/** Allowed hosts config optie. {@value} */
	public static final String ALLOWED_HOSTS = "allowed_hosts";

	/** Foutmelding in geval van missende 'allowed_hosts' optie. {@value} */
	public static final String ERR_MSG_MISSING_CONFIG = "De \'allowed_hosts\' parameter ontbreekt in servletconfig.";

	/** Melding als proxy wordt geweigerd. {@value} */
	private static final String ERR_MSG_FORBIDDEN = " is niet in de lijst met toegestane servers.";

	/** generated serialVersionUID. */
	private static final long serialVersionUID = 1512103319305509379L;

	/** log4j logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(ReverseProxyServlet.class);
	/** layers bean. */
	private final transient AvailableLayersBean layers = new AvailableLayersBean();
	/**
	 * Set van toegestane hosts voor proxy-ing.
	 * 
	 * @see #ALLOWED_HOSTS
	 */
	private final Set<String> allowedHosts = new HashSet<>();

	/**
	 * optie om text/xml mime type voor response te forceren. default waarde is
	 * <code>false</code>
	 * 
	 * @see #FORCE_XML_MIME
	 */
	private boolean forceXmlResponse = false;

	/** onze http client. */
	private final transient HttpClient client = new DefaultHttpClient();

	/**
	 * Parse out the server name and check if the specified server name is in
	 * the list of allowed servernames.
	 * 
	 * @param serverUrl
	 *            the url to check
	 * @return <code>true</code> if the name of the server is found in the list
	 */
	private boolean checkUrlAllowed(String serverUrl) {
		serverUrl = serverUrl.toLowerCase();
		serverUrl = serverUrl.substring(serverUrl.indexOf("//") + 2);
		if (serverUrl.contains("/")) {
			serverUrl = serverUrl.substring(0, serverUrl.indexOf("/"));
		}
		LOGGER.debug("test server = " + serverUrl);
		return (this.allowedHosts.contains(serverUrl));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.GenericServlet#destroy()
	 */
	@Override
	public void destroy() {
		this.client.getConnectionManager().shutdown();
		super.destroy();
	}

	/**
	 * Process the HTTP Get request. Voor een Openlayers proxy wordt de url dan
	 * iets van: <br/>
	 * <code>WMSproxy/proxy?</code> <br/>
	 * waarin WMSproxy de naam van de webapp is en proxy de servlet mapping.
	 * 
	 * @param request
	 *            the request
	 * @param response
	 *            the response
	 * @throws ServletException
	 *             the servlet exception
	 */
	@Override
	protected void doGet(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException {
		try {
			String serverUrl = request.getQueryString();
			serverUrl = URLDecoder.decode(serverUrl, "UTF-8");
			if (serverUrl.startsWith("http://")
					|| serverUrl.startsWith("https://")) {
				// check if allowed
				if (!this.checkUrlAllowed(serverUrl)) {
					LOGGER.warn(serverUrl + ERR_MSG_FORBIDDEN);
					response.sendError(SC_FORBIDDEN, serverUrl
							+ ERR_MSG_FORBIDDEN);
					response.flushBuffer();
				} else {
					LOGGER.debug("proxy GET param:" + serverUrl);
					// intercept and modify request
					if (serverUrl.contains("GetFeatureInfo")) {
						serverUrl = serverUrl.replace("text%2Fhtml",
								"application%2Fvnd.ogc.gml");
						LOGGER.debug("proxy GetFeatureInfo GET param: "
								+ serverUrl);
					}

					final HttpResponse get = this.client.execute(new HttpGet(
							serverUrl));
					if (get.getStatusLine().getStatusCode() == SC_OK) {
						String responseBody;
						if (serverUrl.contains("GetFeatureInfo")) {
							String lName = "";
							// uitzoeken querylayers
							final String[] params = serverUrl.split("&");
							for (final String s : params) {
								if (s.contains("QUERY_LAYERS=")) {
									lName = EncodingUtil.decodeURIComponent(s
											.substring(
													"QUERY_LAYERS=".length(),
													s.length()));
									LOGGER.debug("Query layers = " + lName);
								}
							}
							final String wmsUrl = serverUrl.substring(0,
									serverUrl.indexOf("?"));
							LOGGER.debug("WMS url = " + wmsUrl);
							responseBody = FeatureInfoResponseConverter
									.convertToHTMLTable(get.getEntity()
											.getContent(), "GMLTYPE",
											this.layers.getLayerByLayers(lName,
													wmsUrl));

						} else {
							// force the response to have XML content type (WMS
							// servers generally don't)
							if (this.forceXmlResponse) {
								response.setContentType("text/xml");
							}
							responseBody = EntityUtils
									.toString(get.getEntity()).trim();
						}
						response.setContentLength(responseBody.length());
						final PrintWriter out = response.getWriter();
						out.print(responseBody);
						response.flushBuffer();
					} else {
						LOGGER.warn("Onverwachte fout(server url=" + serverUrl
								+ "): " + get.getStatusLine().toString());
						response.sendError(get.getStatusLine().getStatusCode(),
								get.getStatusLine().toString());
					}
				}
			} else {
				throw new ServletException("Only HTTP(S) protocol is supported");
			}
		} catch (final UnsupportedEncodingException e) {
			LOGGER.error("Proxy fout.", e);
			throw new ServletException(e);
		} catch (final IOException e) {
			LOGGER.error("Proxy IO fout.", e);
			throw new ServletException(e);
		}
	}

	// /**
	// * Process the HTTP Post request. niet duidelijk of dit 100% werkt..
	// *
	// * @param serverUrl
	// * the server url
	// * @return true, if successful
	// */
	// @Override
	// public void doPost(HttpServletRequest request, HttpServletResponse
	// response)
	// throws ServletException {
	// try {
	// String serverUrl = request.getQueryString();
	// serverUrl = URLDecoder.decode(serverUrl, "UTF-8");
	// if (serverUrl.startsWith("http://")
	// || serverUrl.startsWith("https://")) {
	// // check if allowed
	// if (!this.checkUrlAllowed(serverUrl)) {
	// LOGGER.warn(serverUrl + ERR_MSG_FORBIDDEN);
	// response.sendError(SC_FORBIDDEN, serverUrl
	// + ERR_MSG_FORBIDDEN);
	// response.flushBuffer();
	// }
	// final HttpPost httppost = new HttpPost(serverUrl);
	// // Transfer bytes from in to out
	// LOGGER.info("HTTP POST transfering..." + serverUrl);
	// final PrintWriter out = response.getWriter();
	// final HttpClient client = new DefaultHttpClient();
	//
	// httppost.setEntity(new InputStreamEntity(request
	// .getInputStream(), request.getContentLength(),
	// ContentType.create(request.getContentType())));
	// if (0 == httppost.getParams().length) {
	// LOGGER.debug("No Name/Value pairs found ... pushing as raw_post_data");
	// httppost.setParameter("raw_post_data", body);
	// }
	//
	// client.execute(httppost);
	// if (LOGGER.isDebugEnabled()) {
	// final Header[] respHeaders = httppost.getAllHeaders();
	// for (int i = 0; i < respHeaders.length; ++i) {
	// final String headerName = respHeaders[i].getName();
	// final String headerValue = respHeaders[i].getValue();
	// LOGGER.debug("responseHeaders:" + headerName + "="
	// + headerValue);
	// }
	// }
	// if (httppost.getStatusCode() == SC_OK) {
	// response.setContentType("text/xml");
	// final String responseBody = httppost
	// .getResponseBodyAsString();
	//
	// response.setContentLength(responseBody.length());
	// LOGGER.info("responseBody:" + responseBody);
	// out.print(responseBody);
	// } else {
	// LOGGER.error("Unexpected failure: "
	// + httppost.getStatusLine().toString());
	// }
	// client.getConnectionManager().shutdown();
	// } else {
	// throw new ServletException("only HTTP(S) protocol supported");
	// }
	// } catch (final Throwable e) {
	// throw new ServletException(e);
	// }
	// }

	/**
	 * Initialize variables called when context is initialized. Leest de waarden
	 * van {@link #ALLOWED_HOSTS} (verplichte optie) en {@link #FORCE_XML_MIME}
	 * uit de configuratie.
	 * 
	 * @param config
	 *            the <code>ServletConfig</code> object that contains
	 *            configutation information for this servlet
	 * @throws ServletException
	 *             if an exception occurs that interrupts the servlet's normal
	 *             operation
	 */
	@Override
	public void init(final ServletConfig config) throws ServletException {
		super.init(config);
		final String forceXML = config.getInitParameter(FORCE_XML_MIME);
		this.forceXmlResponse = (null != forceXML ? Boolean
				.parseBoolean(forceXML) : false);

		String csvHostnames = config.getInitParameter(ALLOWED_HOSTS);
		if (csvHostnames == null) {
			LOGGER.error(ERR_MSG_MISSING_CONFIG);
			throw new ServletException(ERR_MSG_MISSING_CONFIG);
		}
		// clean-up whitespace and case
		csvHostnames = csvHostnames.replaceAll("\\s", "").toLowerCase();
		final String[] names = csvHostnames.split(";");
		for (final String name : names) {
			this.allowedHosts.add(name);
			LOGGER.debug("toevoegen aan allowed host namen: " + name);
		}

		if ((null != this.getProxyHost()) && (this.getProxyPort() > 0)) {
			this.client.getParams().setParameter(
					ConnRoutePNames.DEFAULT_PROXY,
					new HttpHost(this.getProxyHost(), this.getProxyPort(),
							"http"));
		}
		// override referer, ignore cookies
		this.client.getParams().setParameter("Referer", "/");
		this.client.getParams().setParameter(ClientPNames.COOKIE_POLICY,
				CookiePolicy.IGNORE_COOKIES);
	}
}
