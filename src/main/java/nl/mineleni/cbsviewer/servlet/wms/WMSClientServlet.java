/*
 * Copyright (c) 2012-2013, Dienst Landelijk Gebied - Ministerie van Economische Zaken
 *
 * Gepubliceerd onder de BSD 2-clause licentie,
 * zie https://github.com/MinELenI/CBSviewer/blob/master/LICENSE.md voor de volledige licentie.
 */
package nl.mineleni.cbsviewer.servlet.wms;

import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_S;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_X;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_Y;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_baselyr;
import static nl.mineleni.cbsviewer.util.CookieNamesConstants.COOKIE_mapid;
import static nl.mineleni.cbsviewer.util.StringConstants.MAP_CACHE_DIR;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_BGMAP;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_CACHEDIR;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_DOWNLOADLINK;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_FEATUREINFO;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_FGMAP_ALPHA;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_KAART;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_LEGENDAS;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_MAPID;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.awt.image.RescaleOp;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.mineleni.cbsviewer.servlet.AbstractWxSServlet;
import nl.mineleni.cbsviewer.servlet.wms.FeatureInfoResponseConverter.CONVERTER_TYPE;
import nl.mineleni.cbsviewer.servlet.wms.cache.BboxLayerCacheKey;
import nl.mineleni.cbsviewer.servlet.wms.cache.CachableString;
import nl.mineleni.cbsviewer.servlet.wms.cache.Cache;
import nl.mineleni.cbsviewer.servlet.wms.cache.CacheImage;
import nl.mineleni.cbsviewer.servlet.wms.cache.WMSCache;
import nl.mineleni.cbsviewer.util.AvailableLayersBean;
import nl.mineleni.cbsviewer.util.SpatialUtil;
import nl.mineleni.cbsviewer.util.xml.LayerDescriptor;

import org.geotools.data.ows.Layer;
import org.geotools.data.ows.StyleImpl;
import org.geotools.data.ows.WMSCapabilities;
import org.geotools.data.wms.WMSUtils;
import org.geotools.data.wms.WebMapServer;
import org.geotools.data.wms.request.GetFeatureInfoRequest;
import org.geotools.data.wms.request.GetLegendGraphicRequest;
import org.geotools.data.wms.request.GetMapRequest;
import org.geotools.data.wms.response.GetFeatureInfoResponse;
import org.geotools.data.wms.response.GetLegendGraphicResponse;
import org.geotools.data.wms.response.GetMapResponse;
import org.geotools.ows.ServiceException;
import org.opengis.geometry.BoundingBox;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * WMS client voor de applicatie.
 *
 * @author prinsmc
 * @since 1.7
 */
public class WMSClientServlet extends AbstractWxSServlet {

	/** maximum aantal elementen per cache. {@value} */
	private static final int NUMBER_CACHE_ELEMENTS = 1000;

	/** logger. */
	private static final Logger LOGGER = LoggerFactory
			.getLogger(WMSClientServlet.class);

	/**
	 * type featureinfo response.
	 */
	private static CONVERTER_TYPE type = CONVERTER_TYPE.GMLTYPE;

	/**
	 * vaste afmeting van de kaart (hoogte en breedte). {@value}
	 *
	 * @see #MAP_DIMENSION_MIDDLE
	 */
	private static final int MAP_DIMENSION = 512;

	/**
	 * helft van de afmeting van de kaart (hoogte en breedte). {@value}
	 *
	 * @see #MAP_DIMENSION
	 */
	private static final int MAP_DIMENSION_MIDDLE = MAP_DIMENSION / 2;

	/** time-to-live voor cache elementen. {@value} seconden. */
	private static final long SECONDS_TO_CACHE_ELEMENTS = 60 * 60/* 1 uur */;

	/** time-to-live voor cache elementen. {@value} milliseconden. */
	private static final long MILLISECONDS_TO_CACHE_ELEMENTS = SECONDS_TO_CACHE_ELEMENTS * 1000;

	/** serialVersionUID. */
	private static final long serialVersionUID = 4958212343847516071L;

	/** De achtergrond kaart WMS. */
	private transient WebMapServer bgWMS;

	/** cache voor legenda afbeeldingen. */
	private transient Cache<String, CacheImage, BufferedImage> legendCache;

	/** cache voor voorgrond WMS afbeeldingen. */
	private transient Cache<BboxLayerCacheKey, CacheImage, BufferedImage> fgWMSCache;

	/** cache voor feature info. */
	private transient Cache<BboxLayerCacheKey, CachableString, String> featInfoCache;

	/** verzameling lagen voor de achtergrondkaart. */
	private transient String[] bgWMSlayers;

	/**
	 * voorgrond wms request.
	 *
	 * @todo refactor naar lokale variabele
	 */
	private transient GetMapRequest getMapRequest;

	/** layers bean. */
	private final transient AvailableLayersBean layers = new AvailableLayersBean();

	/** cache voor achtergrond kaartjes. */
	private transient WMSCache bgWMSCache;

	/** De achtergrond luchtfoto WMS. */
	private transient WebMapServer lufoWMS;

	/** cache voor achtergrond kaartjes. */
	private transient WMSCache bgWMSLuFoCache;

	/** verzameling lagen voor de achtergrondkaart. */
	private transient String[] lufoWMSlayers;

	/**
	 * de verzameling met (voorgrond) WMSsen die we benaderen. Het opstarten van
	 * een WMS duurt lang vanwege de capabilities uitvraag en versie
	 * onderhandeling.
	 */
	private transient Map<String, WebMapServer> wmsServersCache;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.GenericServlet#destroy()
	 */
	@Override
	public void destroy() {
		this.bgWMSCache.clear();
		this.bgWMSLuFoCache.clear();
		this.wmsServersCache.clear();
		this.legendCache.clear();
		this.fgWMSCache.clear();
		this.featInfoCache.clear();
		super.destroy();
	}

	/**
	 * Teken een schaalbalk in de (kaart) afbeelding. meter based CRS only.
	 *
	 * @param bbox
	 *            the bbox
	 * @param image
	 *            afbeelding waarin de schaalbalk wordt getekend
	 *
	 * @todo only works for CRS in meters
	 */
	private void drawScaleBar(final BufferedImage image, final BoundingBox bbox) {
		// CHECKSTYLE.OFF: MagicNumber - pixel layout
		// start positie in px
		final int xOffset = 10;
		final int fontSize = 12;
		final int yOffset = MAP_DIMENSION - xOffset;
		final Graphics2D g = image.createGraphics();
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
				RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

		// scale crs units per px
		final double scale = bbox.getWidth() / MAP_DIMENSION;
		// max lengte in px van schaalbalk
		int barLength = MAP_DIMENSION / 2;
		// crs units
		int dist = (int) (barLength * scale);
		// logaritmisch lengte afronden
		final int digits = (int) (Math.log(dist) / Math.log(10));
		final double pow10 = Math.pow(10, digits);
		final int iRounded = (int) (dist / pow10);
		int barLen = 1;
		if (iRounded > 5) {
			barLen = 5;
		} else if (iRounded > 2) {
			barLen = 2;
		}
		dist = (int) (barLen * pow10);
		barLength = (int) (dist / scale);

		// TODO CRS units gebruiken
		// bbox.getCoordinateReferenceSystem().getCoordinateSystem().getAxis(0).getUnit()...
		String units = "m";
		if (dist >= 1000) {
			dist = dist / 1000;
			units = "km";
		}

		g.setColor(Color.BLACK);
		g.setStroke(new BasicStroke(2, BasicStroke.CAP_ROUND,
				BasicStroke.JOIN_ROUND));
		g.drawLine(xOffset, yOffset, xOffset + barLength, yOffset);
		g.drawLine(xOffset, yOffset, xOffset, yOffset - fontSize);
		g.drawLine(xOffset + barLength, yOffset, xOffset + barLength, yOffset
				- fontSize);

		final Font font = new Font(Font.SANS_SERIF, Font.BOLD, fontSize);
		final FontMetrics metrics = g.getFontMetrics(font);
		g.setFont(font);
		g.drawString(
				dist + units,
				(xOffset + (barLength / 2))
						- (metrics.stringWidth(dist + units) / 2), yOffset
						- metrics.getDescent() - 2);
		// CHECKSTYLE.ON: MagicNumber
	}

	/**
	 * Achtergrondkaart ophalen en opslaan in de cache.
	 *
	 * @param bbox
	 *            the bbox
	 * @param baseMapType
	 *            het type basemap, {@code "luchtfoto"} of (default)
	 *            {@code "topografie"}
	 * @return background/basemap image
	 * @throws ServletException
	 *             Geeft aan dat er een fout is opgetreden bij het benaderen van
	 *             de achtergrondgrond WMS service
	 */
	private BufferedImage getBackGroundMap(final BoundingBox bbox,
			final String baseMapType, HttpServletResponse response)
			throws ServletException {

		GetMapRequest map;

		switch (baseMapType.toLowerCase()) {
		case "luchtfoto":
			this.setCookie(response, COOKIE_baselyr, "luchtfoto");
			if (this.bgWMSLuFoCache.containsKey(bbox)) {
				// ophalen uit cache
				LOGGER.debug("Achtergrond " + baseMapType
						+ " afbeelding uit de cache serveren.");
				return this.bgWMSLuFoCache.getImage(bbox);
			}
			map = this.lufoWMS.createGetMapRequest();
			if (this.lufoWMSlayers != null) {
				for (final String lyr : this.lufoWMSlayers) {
					// per laag toevoegen met de default style
					map.addLayer(lyr, "");
				}
			} else {
				// alle lagen toevoegen
				for (final Layer layer : WMSUtils.getNamedLayers(this.lufoWMS
						.getCapabilities())) {
					map.addLayer(layer);
				}
			}
			map.setFormat("image/jpeg");
			break;
		case "topografie":
			// implicit fall thru naar default
		default:
			this.setCookie(response, COOKIE_baselyr, "topografie");
			if (this.bgWMSCache.containsKey(bbox)) {
				// ophalen uit cache
				LOGGER.debug("Achtergrond " + baseMapType
						+ " afbeelding uit de cache serveren.");
				return this.bgWMSCache.getImage(bbox);
			}
			map = this.bgWMS.createGetMapRequest();
			if (this.bgWMSlayers != null) {
				for (final String lyr : this.bgWMSlayers) {
					// per laag toevoegen met de default style
					map.addLayer(lyr, "");
				}
			} else {
				// alle lagen toevoegen
				for (final Layer layer : WMSUtils.getNamedLayers(this.bgWMS
						.getCapabilities())) {
					map.addLayer(layer);
				}
			}
			map.setFormat("image/png");
		}

		map.setDimensions(MAP_DIMENSION, MAP_DIMENSION);
		map.setTransparent(true);
		map.setBGColour("0xffffff");
		map.setExceptions("application/vnd.ogc.se_inimage");
		map.setSRS("EPSG:28992");
		map.setBBox(bbox);

		LOGGER.debug("Achtergrond WMS url is: " + map.getFinalURL());

		try {
			final GetMapResponse mapResponse = this.bgWMS.issueRequest(map);
			final BufferedImage image = ImageIO.read(mapResponse
					.getInputStream());
			switch (baseMapType.toLowerCase()) {
			case "luchtfoto":
				this.bgWMSLuFoCache.put(bbox, image, SECONDS_TO_CACHE_ELEMENTS);
				break;
			case "topografie":
				// implicit fall thru naar default
			default:
				this.bgWMSCache.put(bbox, image, SECONDS_TO_CACHE_ELEMENTS);
				break;
			}

			if (LOGGER.isDebugEnabled()) {
				// achtergrond plaatje bewaren in debug modus
				final File temp = File.createTempFile(
						"bgwms",
						".png",
						new File(this.getServletContext().getRealPath(
								MAP_CACHE_DIR.code)));
				temp.deleteOnExit();
				ImageIO.write(image, "png", temp);
			}

			return image;
		} catch (ServiceException | IOException e) {
			LOGGER.error(
					"Er is een fout opgetreden bij het benaderen van de achtergrond WMS service.",
					e);
			throw new ServletException(e);
		}

	}

	/**
	 * zoekt of maakt de gevraagde WebMapServer.
	 *
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return the cached wms
	 * @throws ServiceException
	 *             the service exception
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private WebMapServer getCachedWMS(final LayerDescriptor lyrDesc)
			throws ServiceException, IOException {
		if (this.wmsServersCache.containsKey(lyrDesc.getUrl())) {
			LOGGER.debug("WMS gevonden in cache.");
			return this.wmsServersCache.get(lyrDesc.getUrl());
		} else {
			LOGGER.debug("Aanmaken van nieuwe WMS (inclusief versie onderhandeling).");
			final WebMapServer fgWMS = new WebMapServer(new URL(
					lyrDesc.getUrl()));
			this.wmsServersCache.put(lyrDesc.getUrl(), fgWMS);
			return fgWMS;
		}
	}

	/**
	 * Haalt de feature info op.
	 *
	 * @param bbox
	 *            the bbox
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return Een string met feature info
	 * @throws ServiceException
	 *             Geeft aan dat er een fout is opgetreden tijden het benaderen
	 *             van de WMS
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private String getFeatureInfo(final BoundingBox bbox,
			final LayerDescriptor lyrDesc) throws ServiceException, IOException {
		final BboxLayerCacheKey key = new BboxLayerCacheKey(bbox, lyrDesc);
		if (this.featInfoCache.containsKey(key)) {
			// ophalen uit cache
			final CachableString fInfo = this.featInfoCache.get(key);
			if (null != fInfo) {
				// dit kan null zijn in het geval het item verlopen is
				LOGGER.debug("FeatureInfo uit de cache serveren.");
				return fInfo.getItem();
			}
		}

		try {
			final GetFeatureInfoRequest getFeatureInfoRequest = this
					.getCachedWMS(lyrDesc).createGetFeatureInfoRequest(
							this.getMapRequest);

			final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
			final Set<Layer> queryLayers = new HashSet<>();
			final WMSCapabilities caps = this.getCachedWMS(lyrDesc)
					.getCapabilities();

			for (final Layer wmsLyr : caps.getLayerList()) {
				if ((wmsLyr.getName() != null)
						&& (wmsLyr.getName().length() != 0)) {
					for (final String layerName : layerNames) {
						if (wmsLyr.getName().equalsIgnoreCase(layerName)) {
							queryLayers.add(wmsLyr);
						}
					}
				}
			}
			getFeatureInfoRequest.setQueryLayers(queryLayers);
			getFeatureInfoRequest.setFeatureCount(10);
			getFeatureInfoRequest.setQueryPoint(MAP_DIMENSION_MIDDLE,
					MAP_DIMENSION_MIDDLE);
			getFeatureInfoRequest.setInfoFormat(type.toString());
			LOGGER.debug("WMS feature info request url is: "
					+ getFeatureInfoRequest.getFinalURL());
			final GetFeatureInfoResponse response = this.getCachedWMS(lyrDesc)
					.issueRequest(getFeatureInfoRequest);

			final String html = FeatureInfoResponseConverter
					.convertToHTMLTable(response.getInputStream(), type,
							lyrDesc);
			this.featInfoCache.put(key,
					new CachableString(html, System.currentTimeMillis()
							+ MILLISECONDS_TO_CACHE_ELEMENTS));
			return html;

		} catch (final UnsupportedOperationException u) {
			LOGGER.warn("De WMS server ("
					+ this.getCachedWMS(lyrDesc).getInfo().getTitle()
					+ ") ondersteund geen GetFeatureInfoRequest.", u);
			return "";
		}
	}

	/**
	 * voorgrondkaart ophalen.
	 *
	 * @param bbox
	 *            the bbox
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return voorgrond afbeelding
	 * @throws ServletException
	 *             Geeft aan dat er een fout is opgetreden bij het benaderen van
	 *             de voorgrond WMS service
	 */
	private BufferedImage getForeGroundMap(final BoundingBox bbox,
			final LayerDescriptor lyrDesc) throws ServletException {

		final BboxLayerCacheKey key = new BboxLayerCacheKey(bbox, lyrDesc);
		if (this.fgWMSCache.containsKey(key)) {
			// ophalen uit cache
			final CacheImage cImg = this.fgWMSCache.get(key);
			if (null != cImg) {
				LOGGER.debug("Voorgrond afbeelding uit de cache serveren.");
				return cImg.getImage();
			}
		}

		// wms request doen
		try {
			this.getMapRequest = this.getCachedWMS(lyrDesc)
					.createGetMapRequest();
			final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
			final String[] styleNames = lyrDesc.getStyles().split(",\\s*");

			for (int l = 0; l < layerNames.length; l++) {
				this.getMapRequest.addLayer(layerNames[l], styleNames[l]);
			}
			this.getMapRequest.setFormat("image/png");
			this.getMapRequest.setDimensions(MAP_DIMENSION, MAP_DIMENSION);
			this.getMapRequest.setTransparent(true);
			this.getMapRequest.setSRS("EPSG:28992");
			this.getMapRequest.setBBox(bbox);
			this.getMapRequest.setExceptions("application/vnd.ogc.se_inimage");
			this.getMapRequest.setBGColour("0xffffff");
			LOGGER.debug("Voorgrond WMS url is: "
					+ this.getMapRequest.getFinalURL());

			// thema/voorgrond ophalen
			final GetMapResponse response = this.getCachedWMS(lyrDesc)
					.issueRequest(this.getMapRequest);
			final BufferedImage image = ImageIO.read(response.getInputStream());
			this.drawScaleBar(image, bbox);
			this.fgWMSCache.put(key, new CacheImage(image,
					SECONDS_TO_CACHE_ELEMENTS));

			if (LOGGER.isDebugEnabled()) {
				// voorgrond plaatje bewaren in debug modus
				final File temp = File.createTempFile(
						"fgwms",
						".png",
						new File(this.getServletContext().getRealPath(
								MAP_CACHE_DIR.code)));
				temp.deleteOnExit();
				ImageIO.write(image, "png", temp);
			}
			return image;
		} catch (ServiceException | IOException e) {
			LOGGER.error(
					"Er is een fout opgetreden bij het benaderen van de voorgrond WMS service.",
					e);
			throw new ServletException(e);
		}
	}

	/**
	 * Haalt de legenda op voor de thema laag.
	 *
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return een array met legenda afbeeldings bestanden
	 * @throws ServiceException
	 *             Geeft aan dat er een fout is opgetreden tijdens het benaderen
	 *             van de WMS
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private File[] getLegends(final LayerDescriptor lyrDesc)
			throws ServiceException, IOException {
		if (null == this.getCachedWMS(lyrDesc).getCapabilities().getRequest()
				.getGetLegendGraphic()) {
			LOGGER.debug("getGetLegendGraphic tested null, server ondersteund geen getGetLegendGraphic request.");
			return this.getLegendsFromLayerStyles(lyrDesc);
		} else {
			return this.getLegendsFromService(lyrDesc);
		}
	}

	/**
	 * get legenda afbeeldingen door gebruik te maken legendUrl.
	 *
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return een array met legenda afbeeldings bestanden
	 * @throws ServiceException
	 *             Geeft aan dat er een fout is opgetreden tijden het benaderen
	 *             van de WMS
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private File[] getLegendsFromLayerStyles(final LayerDescriptor lyrDesc)
			throws ServiceException, IOException {
		final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
		final String[] styleNames = lyrDesc.getStyles().split(",\\s*");
		final File[] legends = new File[layerNames.length];

		for (int l = 0; l < layerNames.length; l++) {
			final String key = layerNames[l] + "::" + styleNames[l];
			if (this.legendCache.containsKey(key)) {
				// in de cache kijken of we deze legenda afbeelding nog
				// hebben
				final CacheImage cImg = this.legendCache.get(key);
				if (null != cImg) {
					// element zou verlopen kunnen zijn
					legends[l] = new File(cImg.getName());
					if (!legends[l].exists()) {
						// (mogelijk) is het bestand gewist..
						ImageIO.write(this.legendCache.get(key).getImage(),
								"png", legends[l]);
					}
					LOGGER.debug("Legenda bestand uit cache: "
							+ legends[l].getAbsolutePath());
				}
			} else {
				for (final Layer layer : this.getCachedWMS(lyrDesc)
						.getCapabilities().getLayerList()) {
					if (layerNames[l].equalsIgnoreCase(layer.getName())) {
						// layer gevonden
						for (final StyleImpl style : layer.getStyles()) {
							if (styleNames[l].equalsIgnoreCase(style.getName())) {
								// style gevonden, eerste legenda ophalen
								final String legendUrl = (String) style
										.getLegendURLs().get(0);
								LOGGER.debug("Legenda url uit capabilities is: "
										+ legendUrl);
								if (this.isNotNullNotEmptyNotWhiteSpaceOnly(legendUrl)) {
									try {
										legends[l] = this.cacheLegend(ImageIO
												.read(new URL(legendUrl)), key);
									} catch (final MalformedURLException e) {
										LOGGER.warn(
												"Er werd geen geldige URL voor de legenda gevonden.",
												e);
									}
								}
							}
						}
					}
				}
			}
		}
		return legends;
	}

	/**
	 * get legenda afbeeldingen door gebruik te maken van
	 * GetLegendGraphicRequest.
	 *
	 * @param lyrDesc
	 *            de layerdescriptor met de WMS informatie
	 * @return een array met legenda afbeeldings bestanden
	 * @throws ServiceException
	 *             Geeft aan dat er een fout is opgetreden tijden het benaderen
	 *             van de WMS
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private File[] getLegendsFromService(final LayerDescriptor lyrDesc)
			throws ServiceException, IOException {
		final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
		final String[] styleNames = lyrDesc.getStyles().split(",\\s*");
		final File[] legends = new File[layerNames.length];

		try {
			final GetLegendGraphicRequest legend = this.getCachedWMS(lyrDesc)
					.createGetLegendGraphicRequest();
			for (int l = 0; l < layerNames.length; l++) {
				final String key = layerNames[l] + "::" + styleNames[l];

				if (this.legendCache.containsKey(key)) {
					// in de cache kijken of we deze legenda afbeelding nog
					// hebben
					final CacheImage cImg = this.legendCache.get(key);
					if (null != cImg) {
						// element zou verlopen kunnen zijn
						legends[l] = new File(cImg.getName());
						if (!legends[l].exists()) {
							// (mogelijk) is het bestand gewist..
							ImageIO.write(this.legendCache.get(key).getImage(),
									"png", legends[l]);
						}
						LOGGER.debug("Legenda bestand uit cache: "
								+ legends[l].getAbsolutePath());
					}
				} else {
					// legenda opvragen
					legend.setLayer(layerNames[l]);
					legend.setStyle(styleNames[l]);
					legend.setFormat("image/png");
					legend.setExceptions("application/vnd.ogc.se_inimage");

					LOGGER.debug("Voorgrond WMS legenda url is: "
							+ legend.getFinalURL());
					final GetLegendGraphicResponse response = this
							.getCachedWMS(lyrDesc).issueRequest(legend);
					legends[l] = this.cacheLegend(
							ImageIO.read(response.getInputStream()), key);
				}
			}
		} catch (final UnsupportedOperationException u) {
			LOGGER.warn("De WMS server ("
					+ this.getCachedWMS(lyrDesc).getInfo().getTitle()
					+ ") ondersteund geen GetLegendGraphicRequest.", u);
			return null;
		}
		return legends;
	}

	/**
	 * kaart maken op basis van de opgehaalde afbeeldingen.
	 *
	 * @param imageVoorgrond
	 *            de voorgrondkaart
	 * @param imageAchtergrond
	 *            de achtergrondgrondkaart
	 * @param alpha
	 *            alpha transparantie van de voorgrondkaart
	 * @return de file met de afbeelding
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private File getMap(final BufferedImage imageVoorgrond,
			final BufferedImage imageAchtergrond, float alpha)
			throws IOException {

		final BufferedImage composite = new BufferedImage(MAP_DIMENSION,
				MAP_DIMENSION, BufferedImage.TYPE_INT_ARGB);
		final Graphics2D g = composite.createGraphics();

		g.drawImage(imageAchtergrond, 0, 0, null);
		if (imageVoorgrond != null) {
			final float[] scales = { 1f, 1f, 1f, alpha };
			final RescaleOp rop = new RescaleOp(scales, new float[4], null);
			g.drawImage(imageVoorgrond, rop, 0, 0);
			// zoeklocatie intekenen met plaatje
			final BufferedImage infoImage = ImageIO.read(new File(this
					.getClass().getClassLoader().getResource("info.png")
					.getFile()));
			// CHECKSTYLE.OFF: MagicNumber - dit zijn midden en hoogte van het
			// plaatje "info.png"
			g.drawImage(infoImage, MAP_DIMENSION_MIDDLE - 16,
					MAP_DIMENSION_MIDDLE - 36, null);
			// CHECKSTYLE.ON: MagicNumber
		}
		// opslaan van plaatje zodat de browser het op kan halen
		final File kaartAfbeelding = File.createTempFile(
				"wmscombined",
				".png",
				new File(this.getServletContext().getRealPath(
						MAP_CACHE_DIR.code)));
		kaartAfbeelding.deleteOnExit();
		ImageIO.write(composite, "png", kaartAfbeelding);
		g.dispose();
		return kaartAfbeelding;
	}

	/**
	 * cache een legenda plaatje.
	 *
	 * @param image
	 *            de afbeelding om op te slaan
	 * @param key
	 *            de sleutel
	 * @return het bestand met opgeslagen afbeelding
	 * @throws IOException
	 *             Signals that an I/O exception has occurred.
	 */
	private File cacheLegend(final BufferedImage image, final String key)
			throws IOException {
		// op schijf opslaan
		final File legend = File.createTempFile("legenda", ".png", new File(
				this.getServletContext().getRealPath(MAP_CACHE_DIR.code)));
		legend.deleteOnExit();
		ImageIO.write(image, "png", legend);
		// in de cache opslaan
		this.legendCache.put(
				key,
				new CacheImage(image, legend.getAbsolutePath(), System
						.currentTimeMillis()
						+ (MILLISECONDS_TO_CACHE_ELEMENTS * 24)));
		LOGGER.debug("Legenda bestand opgeslagen: " + legend.getAbsolutePath());
		return legend;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * nl.mineleni.cbsviewer.servlet.AbstractBaseServlet#init(javax.servlet.
	 * ServletConfig)
	 */
	@Override
	public void init(final ServletConfig config) throws ServletException {
		super.init(config);
		final ServletContext ctx = this.getServletContext();
		try {
			this.bgWMSCache = new WMSCache(ctx.getRealPath(MAP_CACHE_DIR.code),
					NUMBER_CACHE_ELEMENTS);
		} catch (final IOException e) {
			LOGGER.error(
					"Inititalisatie fout voor de achtergrond topografie cache.",
					e);
		}

		try {
			this.bgWMSLuFoCache = new WMSCache(
					ctx.getRealPath(MAP_CACHE_DIR.code), NUMBER_CACHE_ELEMENTS);
		} catch (final IOException e) {
			LOGGER.error(
					"Inititalisatie fout voor de achtergrond luchtfoto cache.",
					e);
		}

		this.legendCache = new Cache<>(NUMBER_CACHE_ELEMENTS);

		this.featInfoCache = new Cache<>(NUMBER_CACHE_ELEMENTS);

		this.fgWMSCache = new Cache<>(NUMBER_CACHE_ELEMENTS);

		// achtergrond kaart
		final String bgCapabilitiesURL = config
				.getInitParameter("bgCapabilitiesURL");
		LOGGER.debug("WMS capabilities url van achtergrond kaart: "
				+ bgCapabilitiesURL);
		try {
			this.bgWMS = new WebMapServer(new URL(bgCapabilitiesURL));
		} catch (final MalformedURLException e) {
			LOGGER.error(
					"Een url die gebruikt wordt voor de topografie WMS capabilities is misvormd",
					e);
			throw new ServletException(e);
		} catch (final ServiceException e) {
			LOGGER.error(
					"Er is een service exception (WMS server fout) opgetreden bij het ophalen van de topografie WMS capabilities",
					e);
			throw new ServletException(e);
		} catch (final IOException e) {
			LOGGER.error(
					"Er is een I/O fout opgetreden bij benaderen van de topografie WMS services",
					e);
			throw new ServletException(e);
		}
		final String bgWMSlyrs = config.getInitParameter("bgWMSlayers");
		LOGGER.debug("Achtergrond kaartlagen topografie: " + bgWMSlyrs);
		if ((bgWMSlyrs != null) && (bgWMSlyrs.length() > 0)) {
			this.bgWMSlayers = bgWMSlyrs.split("[,]\\s*");
		}

		// achtergrond luchtfoto
		final String lufoCapabilitiesURL = config
				.getInitParameter("lufoCapabilitiesURL");
		LOGGER.debug("WMS capabilities url van achtergrond luchtfoto: "
				+ lufoCapabilitiesURL);
		try {
			this.lufoWMS = new WebMapServer(new URL(lufoCapabilitiesURL));
		} catch (final MalformedURLException e) {
			LOGGER.error(
					"De url die gebruikt wordt voor de luchtfoto WMS capabilities is misvormd",
					e);
			throw new ServletException(e);
		} catch (final ServiceException e) {
			LOGGER.error(
					"Er is een service exception (WMS server fout) opgetreden bij het ophalen van de luchtfoto WMS capabilities",
					e);
			throw new ServletException(e);
		} catch (final IOException e) {
			LOGGER.error(
					"Er is een I/O fout opgetreden bij benaderen van de luchtfoto WMS services",
					e);
			throw new ServletException(e);
		}
		final String lufoWMSlyrs = config.getInitParameter("lufoWMSlayers");
		LOGGER.debug("Achtergrond kaartlagen luchtfoto: " + lufoWMSlyrs);
		if ((lufoWMSlyrs != null) && (lufoWMSlyrs.length() > 0)) {
			this.lufoWMSlayers = lufoWMSlyrs.split("[,]\\s*");
		}

		// voorgond feature info response type
		final String mType = config.getInitParameter("featureInfoType");
		LOGGER.debug("voorgrond kaartlagen mimetype: " + mType);
		if ((mType != null) && (mType.length() > 0)) {
			type = CONVERTER_TYPE.valueOf(mType);
		}
		// init servers cache
		this.wmsServersCache = new ConcurrentHashMap<String, WebMapServer>();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse)
	 */
	@Override
	protected void service(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {

		final int[] dXcoordYCoordStraal = this.parseLocation(request);
		final int xcoord = dXcoordYCoordStraal[0];
		final int ycoord = dXcoordYCoordStraal[1];
		final int straal = dXcoordYCoordStraal[2];
		final BoundingBox bbox = SpatialUtil.calcRDBBOX(xcoord, ycoord, straal);

		this.setCookie(response, COOKIE_X, xcoord);
		this.setCookie(response, COOKIE_Y, ycoord);
		this.setCookie(response, COOKIE_S, straal);

		float alpha = 0.8f;
		final String trans = request.getParameter(REQ_PARAM_FGMAP_ALPHA.code);
		if (this.isNotNullNotEmptyNotWhiteSpaceOnly(trans)) {
			// CHECKSTYLE.OFF: MagicNumber - default alpha transparantie is 80%
			try {
				alpha = 1 - (Float.parseFloat(trans) / 100);
				if ((0 > alpha) && (alpha > 1)) {
					alpha = 0.8f;
				}
			} catch (final NumberFormatException n) {
				alpha = 0.8f;
			}
			// CHECKSTYLE.ON: MagicNumber
		}
		LOGGER.debug("Transparantie / alpha ingesteld op:" + alpha);

		String basemaptype = "topografie";
		final String mType = request.getParameter(REQ_PARAM_BGMAP.code);
		if (this.isNotNullNotEmptyNotWhiteSpaceOnly(mType)) {
			basemaptype = mType;
		}
		final BufferedImage bg = this.getBackGroundMap(bbox, basemaptype,
				response);

		BufferedImage fg = null;
		final String mapid = request.getParameter(REQ_PARAM_MAPID.code);
		if (this.isNotNullNotEmptyNotWhiteSpaceOnly(mapid)) {
			this.setCookie(response, COOKIE_mapid, mapid);
			final LayerDescriptor layer = this.layers.getLayerByID(mapid);
			request.setAttribute("mapname", layer.getName());
			LOGGER.debug("LayerDescriptor::Name is: " + layer.getName());

			final String fgCapabilitiesURL = layer.getUrl();
			LOGGER.debug("WMS capabilities url van voorgrond kaart: "
					+ fgCapabilitiesURL);
			try {
				fg = this.getForeGroundMap(bbox, layer);
				final File[] legendas = this.getLegends(layer);
				final String fInfo = this.getFeatureInfo(bbox, layer);
				request.setAttribute(REQ_PARAM_MAPID.code, mapid);
				request.setAttribute(REQ_PARAM_LEGENDAS.code, legendas);
				request.setAttribute(REQ_PARAM_FEATUREINFO.code, fInfo);
				request.setAttribute(REQ_PARAM_DOWNLOADLINK.code,
						layer.getLink());
			} catch (final ServiceException e) {
				LOGGER.error(
						"Er is een service exception opgetreden bij benaderen van de voorgrond WMS",
						e);
				throw new ServletException(e);
			} catch (final MalformedURLException e) {
				LOGGER.error(
						"De url die gebruikt wordt voor de WMS capabilities is misvormd.",
						e);
				throw new ServletException(e);
			}
		}

		final File kaart = this.getMap(fg, bg, alpha);

		request.setAttribute(REQ_PARAM_CACHEDIR.code, MAP_CACHE_DIR.code);
		request.setAttribute(REQ_PARAM_KAART.code, kaart);
		request.setAttribute(REQ_PARAM_BGMAP.code, basemaptype);
	}
}
