package nl.mineleni.cbsviewer.servlet.gazetteer;

import static nl.mineleni.cbsviewer.util.StringConstants.OPENLS_REQ_PARAM_REQUEST;
import static nl.mineleni.cbsviewer.util.StringConstants.OPENLS_REQ_PARAM_SEARCH;
import static nl.mineleni.cbsviewer.util.StringConstants.OPENLS_REQ_VALUE_GEOCODE;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_GEVONDEN;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_STRAAL;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_XCOORD;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_YCOORD;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.mineleni.cbsviewer.servlet.AbstractWxSServlet;
import nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClient;
import nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientAddress;
import nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientUtil;
import nl.mineleni.openls.databinding.openls.GeocodeResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import flexjson.JSONSerializer;

/**
 * Servlet implementation class AdresZoekServlet.
 * 
 * @author mprins
 */
public class AdresZoekServlet extends AbstractWxSServlet {
	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(AbstractWxSServlet.class);
	/** serialization id. */
	private static final long serialVersionUID = 1L;

	/** De open ls client die het echte werk doet. */
	private transient OpenLSClient openLSClient;

	/** de Open LS server url. */
	private String openLSServerUrl;

	/** gazetteer service url. {@value} . */
	public static final String SERVLETCONFIG_OPENLS_SERVER_URL = "openlsserverurl";

	/**
	 * zorgt ervoor dat eventuele doubles als integer worden gerenderd. Als het
	 * niet lukt wordt de oorspronkelijke waarde teruggeven.
	 * 
	 * @param coord
	 *            een coordinaat waarde
	 * @return de waarde in integer formaat
	 */
	private String formatCoord(final String coord) {
		/** coordinaten formatter. */
		final DecimalFormat fmt = new DecimalFormat("###");
		try {
			// formatting als int
			return "" + (fmt.parse(coord).intValue());
		} catch (final ParseException e) {
			LOGGER.warn("Fout tijden parsen van cooridnaat: " + coord, e);
			return coord;
		} catch (final NullPointerException e) {
			LOGGER.warn("Fout tijden parsen van cooridnaat: " + coord, e);
			return coord;
		}
	}

	/*
	 * @see Servlet#init(ServletConfig)
	 */
	@Override
	public void init(final ServletConfig config) throws ServletException {
		super.init(config);
		this.openLSClient = new OpenLSClient();
		// init params inlezen en controleren
		this.openLSServerUrl = config
				.getInitParameter(SERVLETCONFIG_OPENLS_SERVER_URL);
		if (this.openLSServerUrl == null) {
			LOGGER.error("config param " + SERVLETCONFIG_OPENLS_SERVER_URL
					+ " is null.");
			throw new ServletException("config param "
					+ SERVLETCONFIG_OPENLS_SERVER_URL + " is null.");
		}
	}

	/**
	 * Return json van adreszoek resultaten.
	 * 
	 * @param addrl
	 *            Een {@code List} met adressen, de lijst mag leeg zijn
	 * @return een javascript array met geserialiseerde
	 *         {@link nl.mineleni.cbsviewer.servlet.gazetteer.lusclient.OpenLSClientAddress}
	 *         objecten
	 */
	private String returnJson(final List<OpenLSClientAddress> addrl) {
		final JSONSerializer serializer = new JSONSerializer();
		String json = "";
		switch (addrl.size()) {
		case 0:
			json = serializer.exclude("class")
					.prettyPrint(LOGGER.isDebugEnabled()).serialize(addrl);
			break;
		default:
			json = serializer.exclude("class")
					.prettyPrint(LOGGER.isDebugEnabled()).serialize(addrl);
			break;
		}
		LOGGER.debug("json: " + json);
		return json;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void service(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {

		final boolean forwardResponse = this.parseForward(request);
		final String format = request.getParameter("format");

		final String zoekTerm = request.getParameter("adres");
		LOGGER.debug("Zoeken naar: " + zoekTerm);
		if (zoekTerm.length() < 1) {
			request.setAttribute(REQ_PARAM_GEVONDEN.code,
					"Geen adres ingevuld.");
			if (forwardResponse) {
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);
			}
		} else {
			final Map<String, String> openLSParams = new TreeMap<String, String>();
			openLSParams.put(OPENLS_REQ_PARAM_REQUEST.code,
					OPENLS_REQ_VALUE_GEOCODE.code);
			openLSParams.put(OPENLS_REQ_PARAM_SEARCH.code, zoekTerm);
			final GeocodeResponse gcr = this.openLSClient.doGetOpenLSRequest(
					this.openLSServerUrl, openLSParams);
			final List<OpenLSClientAddress> addrl = OpenLSClientUtil
					.getOpenLSClientAddressList(gcr);

			if (forwardResponse) {
				if (addrl.isEmpty()) {
					// niets gevonden
					LOGGER.debug("Er is niets gevonden voor: " + zoekTerm);
					request.setAttribute(REQ_PARAM_GEVONDEN.code,
							"Er is niets gevonden voor: " + zoekTerm);
				} else if (addrl.size() == 1) {
					// 1 adres gevonden
					LOGGER.debug("Er is 1 match gevonden voor: " + zoekTerm);
					final OpenLSClientAddress addr = addrl.get(0);

					request.setAttribute(REQ_PARAM_XCOORD.code,
							this.formatCoord(addr.getxCoord()));
					request.setAttribute(REQ_PARAM_YCOORD.code,
							this.formatCoord(addr.getyCoord()));
					request.setAttribute(REQ_PARAM_STRAAL.code,
							addr.getRadius());
					request.setAttribute(REQ_PARAM_GEVONDEN.code,
							"Gevonden adres: " + addr.getAddressString());
				} else {
					// meer dan 1 adressen gevonden
					LOGGER.debug("Er is meer dan 1 match gevonden voor: "
							+ zoekTerm);
					request.setAttribute("adreslijst", addrl);
					request.setAttribute(REQ_PARAM_GEVONDEN.code,
							"Er is meer dan 1 adres gevonden");
				}
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);
			} else {
				if (format != null && format.equalsIgnoreCase("json")) {
					// geeft zoekresultaat als json
					final String json = returnJson(addrl);
					response.setCharacterEncoding("UTF-8");
					response.setContentType("application/json");
					response.setContentLength(json.length());
					response.getWriter().print(json);
					response.flushBuffer();
				}
			}
		}
	}
}
