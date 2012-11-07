/**
 * 
 */
package nl.mineleni.cbsviewer.servlet.wms;

import static nl.mineleni.cbsviewer.util.StringConstants.MAP_CACHE_DIR;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_CACHEDIR;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_FEATUREINFO;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_KAART;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_LEGENDAS;
import static nl.mineleni.cbsviewer.util.StringConstants.REQ_PARAM_MAPNAME;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.mineleni.cbsviewer.servlet.AbstractWxSServlet;
import nl.mineleni.cbsviewer.servlet.wms.cache.ImageCaching;
import nl.mineleni.cbsviewer.servlet.wms.cache.WMSCache;
import nl.mineleni.cbsviewer.util.AvailableLayersBean;
import nl.mineleni.cbsviewer.util.SpatialUtil;
import nl.mineleni.cbsviewer.util.xml.LayerDescriptor;

import org.geotools.data.ows.Layer;
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
 * @todo cache voor voorgrond WMS afbeeldingen (en evt. feature info + legenda)
 *       implementeren voor verhogen van performance
 */
public class WMSClientServlet extends AbstractWxSServlet {

    /** serialVersionUID. */
    private static final long serialVersionUID = 4958212343847516071L;

    /** logger. */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(WMSClientServlet.class);
    /**
     * vaste afmeting van de kaart (hoogte en breedte). {@value}
     * 
     * @see #MAP_DIMENSION_MIDDLE
     */
    private static final int MAP_DIMENSION = 440;

    /**
     * helft van de afmeting van de kaart (hoogte en breedte). {@value}
     * 
     * @see #MAP_DIMENSION
     */
    private static final int MAP_DIMENSION_MIDDLE = MAP_DIMENSION / 2;

    /**
     * voorgrond wms request.
     * 
     * @todo refactor naar lokale variabele
     */
    private transient GetMapRequest getMapRequest = null;

    /** De achtergrond WMS. */
    private transient WebMapServer bgWMS = null;

    /** verzameling lagen voor de achtergrondkaart. */
    private String[] bgWMSlayers = null;

    /** layers bean. */
    private final transient AvailableLayersBean layers = new AvailableLayersBean();

    /** cache voor achtergrond kaartjes. */
    private transient ImageCaching<BoundingBox, BufferedImage> bgWMSCache = null;

    /**
     * de verzameling met (voorgrond) WMSsen die we benaderen. Het opstarten van
     * een WMS duurt lang vanwege de capabilities uitvraag en versie
     * onderhandeling.
     */
    private transient Map<String, WebMapServer> wmsServersCache = null;

    /*
     * (non-Javadoc)
     * 
     * @see javax.servlet.GenericServlet#destroy()
     */
    @Override
    public void destroy() {
        this.bgWMSCache.clear();
        this.bgWMS = null;
        this.wmsServersCache.clear();
        super.destroy();
    }

    /**
     * Achtergrondkaart ophalen en opslaan in de cache.
     * 
     * @param bbox
     *            the bbox
     * @return background/basemap image
     * @throws ServletException
     *             Geeft aan dat er een fout is opgetreden bij het benaderen van
     *             de achtergrondgrond WMS service
     */
    private BufferedImage getBackGroundMap(final BoundingBox bbox)
            throws ServletException {

        if (this.bgWMSCache.containsKey(bbox)) {
            // check cache
            return this.bgWMSCache.get(bbox);
        }

        final GetMapRequest map = this.bgWMS.createGetMapRequest();
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
        map.setDimensions(MAP_DIMENSION, MAP_DIMENSION);
        map.setTransparent(true);
        map.setBGColour("0xffffff");
        map.setExceptions("application/vnd.ogc.se_inimage");
        map.setSRS("EPSG:28992");
        map.setBBox(bbox);

        LOGGER.debug("Achtergrond WMS url is: " + map.getFinalURL());

        try {
            final GetMapResponse response = this.bgWMS.issueRequest(map);
            final BufferedImage image = ImageIO.read(response.getInputStream());
            this.bgWMSCache.put(bbox, image);

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
     * @throws MalformedURLException
     *             the malformed url exception
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
     * @param lyrDesc
     *            de layerdescriptor met de WMS informatie
     * @return Een string met feature info
     * @throws ServiceException
     *             Geeft aan dat er een fout is opgetreden tijden het benaderen
     *             van de WMS
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     */
    private String getFeatureInfo(final LayerDescriptor lyrDesc)
            throws ServiceException, IOException {

        final GetFeatureInfoRequest getFeatureInfoRequest = this.getCachedWMS(
                lyrDesc).createGetFeatureInfoRequest(this.getMapRequest);

        final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
        final Set<Layer> queryLayers = new HashSet<Layer>();
        final WMSCapabilities caps = this.getCachedWMS(lyrDesc)
                .getCapabilities();

        for (final Layer wmsLyr : caps.getLayerList()) {
            if ((wmsLyr.getName() != null) && (wmsLyr.getName().length() != 0)) {
                for (final String layerName : layerNames) {
                    if (wmsLyr.getName().equalsIgnoreCase(layerName)) {
                        queryLayers.add(wmsLyr);
                    }
                }
            }
        }
        getFeatureInfoRequest.setQueryLayers(queryLayers);
        getFeatureInfoRequest.setInfoFormat("application/vnd.ogc.gml");
        getFeatureInfoRequest.setFeatureCount(10);
        getFeatureInfoRequest.setQueryPoint(MAP_DIMENSION_MIDDLE,
                MAP_DIMENSION_MIDDLE);
        LOGGER.debug("WMS feature info request url is: "
                + getFeatureInfoRequest.getFinalURL());
        final GetFeatureInfoResponse response = this.getCachedWMS(lyrDesc)
                .issueRequest(getFeatureInfoRequest);

        return FeatureInfoResponseConverter.convertToHTMLTable(response
                .getInputStream(), FeatureInfoResponseConverter.type.GMLTYPE,
                lyrDesc.getAttributes().split(",\\s*"));
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
                    "Er is een fout opgetreden bij het benaderen van de achtergrond WMS service.",
                    e);
            throw new ServletException(e);
        }
    }

    /**
     * haalt de legenda op voor de thema laag.
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
    private File[] getLegends(final LayerDescriptor lyrDesc)
            throws ServiceException, IOException {

        final String[] layerNames = lyrDesc.getLayers().split(",\\s*");
        final String[] styleNames = lyrDesc.getStyles().split(",\\s*");

        final File[] legends = new File[layerNames.length];
        final GetLegendGraphicRequest legend = this.getCachedWMS(lyrDesc)
                .createGetLegendGraphicRequest();
        BufferedImage image;
        for (int l = 0; l < layerNames.length; l++) {
            legend.setLayer(layerNames[l]);
            legend.setStyle(styleNames[l]);
            legend.setFormat("image/png");
            legend.setExceptions("application/vnd.ogc.se_inimage");

            LOGGER.debug("Voorgrond WMS legenda url is: "
                    + legend.getFinalURL());
            final GetLegendGraphicResponse response = this
                    .getCachedWMS(lyrDesc).issueRequest(legend);
            image = ImageIO.read(response.getInputStream());
            legends[l] = File.createTempFile("legenda", ".png", new File(this
                    .getServletContext().getRealPath(MAP_CACHE_DIR.code)));
            legends[l].deleteOnExit();
            ImageIO.write(image, "png", legends[l]);
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
     * @return de file met de afbeelding
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     */
    private File getMap(final BufferedImage imageVoorgrond,
            final BufferedImage imageAchtergrond) throws IOException {

        final BufferedImage composite = new BufferedImage(MAP_DIMENSION,
                MAP_DIMENSION, BufferedImage.TYPE_INT_ARGB);
        final Graphics g = composite.getGraphics();
        g.drawImage(imageAchtergrond, 0, 0, null);
        if (imageVoorgrond != null) {
            g.drawImage(imageVoorgrond, 0, 0, null);
            // zoeklocatie intekenen met plaatje
            final BufferedImage infoImage = ImageIO.read(new File(this
                    .getClass().getClassLoader().getResource("info.png")
                    .getFile()));
            // CHECKSTYLE.OFF: MagicNumber - dit zijn midden en hoogte van het
            // plaatje
            g.drawImage(infoImage, MAP_DIMENSION_MIDDLE - 16,
                    MAP_DIMENSION_MIDDLE - 37, null);
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
        return kaartAfbeelding;
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
        try {
            this.bgWMSCache = new WMSCache(this.getServletContext()
                    .getRealPath(MAP_CACHE_DIR.code));
        } catch (final IOException e) {
            LOGGER.error(
                    "Inititalisatie fout voor de achtergrond bitmap cache.", e);
        }

        // achtergrond kaart
        final String bgCapabilitiesURL = config
                .getInitParameter("bgCapabilitiesURL");
        LOGGER.debug("WMS capabilities url van achtergrond kaart: "
                + bgCapabilitiesURL);
        try {
            this.bgWMS = new WebMapServer(new URL(bgCapabilitiesURL));
        } catch (final MalformedURLException e) {
            LOGGER.error(
                    "Een url die gebruikt wordt voor de WMS capabilities is misvormd",
                    e);
            throw new ServletException(e);
        } catch (final ServiceException e) {
            LOGGER.error(
                    "Er is een service exception (WMS server fout) opgetreden bij het ophalen van de achtergrond WMS capabilities",
                    e);
            throw new ServletException(e);
        } catch (final IOException e) {
            LOGGER.error(
                    "Er is een I/O fout opgetreden bij benaderen van de WMS services",
                    e);
            throw new ServletException(e);
        }
        final String bgWMSlyrs = config.getInitParameter("bgWMSlayers");
        LOGGER.debug("Achtergrond kaartlagen: " + bgWMSlyrs);
        if ((bgWMSlyrs != null) && (bgWMSlyrs.length() > 0)) {
            this.bgWMSlayers = bgWMSlyrs.split("[,]\\s*");
        }
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

        BufferedImage fg = null;
        final String mapName = request.getParameter(REQ_PARAM_MAPNAME.code);
        LOGGER.debug("WMS layer id: " + mapName);

        if (mapName != null) {
            final LayerDescriptor layer = this.layers.getLayerByID(mapName);
            LOGGER.debug("LayerDescriptor: " + layer);

            final String fgCapabilitiesURL = layer.getUrl();
            LOGGER.debug("WMS capabilities url van voorgrond kaart: "
                    + fgCapabilitiesURL);
            try {
                fg = this.getForeGroundMap(bbox, layer);
                final File[] legendas = this.getLegends(layer);
                final String fInfo = this.getFeatureInfo(layer);
                request.setAttribute(REQ_PARAM_LEGENDAS.code, legendas);
                request.setAttribute(REQ_PARAM_FEATUREINFO.code, fInfo);
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
        final BufferedImage bg = this.getBackGroundMap(bbox);
        final File kaart = this.getMap(fg, bg);

        request.setAttribute(REQ_PARAM_CACHEDIR.code, MAP_CACHE_DIR.code);
        request.setAttribute(REQ_PARAM_KAART.code, kaart);
    }
}
