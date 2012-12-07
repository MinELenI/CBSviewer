<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core" 
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		import="nl.mineleni.cbsviewer.util.StringConstants"
		trimDirectiveWhitespaces="false" language="java" isThreadSafe="false"
		isErrorPage="false" />
<jsp:output doctype-root-element="html"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		omit-xml-declaration="no" />

	<fmt:setBundle basename="LabelsBundle" />

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
<head>
<jsp:include page="WEB-INF/jsp/head_include.jsp" />

		<c:if test="${not empty xcoord}">
			<c:set value="${xcoord}" var="xcoord" />
		</c:if>

		<c:if test="${not empty ycoord}">
			<c:set value="${ycoord}" var="ycoord" />
		</c:if>
		<c:if test="!${not empty straal}">
			<c:set value="${straal}" var="straal" />
		</c:if>
		<!-- meer adressen -->
		<c:if test="${not empty param.xcoord}">
			<c:set value="${param.xcoord}" var="xcoord" />
		</c:if>
		<c:if test="${not empty param.ycoord}">
			<c:set value="${param.ycoord}" var="ycoord" />
		</c:if>
		<c:if test="${not empty param.straal}">
			<c:set value="${param.straal}" var="straal" />
		</c:if>

		<jsp:include page="kaart">
			<!-- TODO: mapid waarde moet uit de request komen bijv. ?mapid=cbs_inwoners_2000_per_hectare -->
			<!-- StringConstants.REQ_PARAM_MAPID -->
			<!--<jsp:param name="mapid" value="cbs_inwoners_2000_per_hectare" />-->
			<jsp:param name="mapid" value="wijkenbuurten2011_thema_gemeenten2011_aantal_inwoners" />

			<jsp:param value="${xcoord}" name="xcoord" />
			<jsp:param value="${ycoord}" name="ycoord" />
			<jsp:param value="${straal}" name="straal" />
		</jsp:include>

<c:if test="${param.coreonly!=true}">
	<script type="text/javascript" charset="utf-8">
		document.documentElement.className += ' js';
	</script>
</c:if>

<title>Kaart <c:out value="${param.mapname}" /></title>
</head>

<body>

<div class="header">
    <div id="headerleft" class="headerColumn headertop">
		<div class="logo">			
			<div id="cbslogo">
				<!--img src="" id="cbslogo" width="100%" usemap="#cbsmap" alt="CBS in uw buurt: Centraal Bureau voor de Statistiek"/-->
			</div>
		</div>
	</div>
    <div id="headercenter" class="headerColumn headermiddle">
		<jsp:include page="WEB-INF/jsp/zoekformulier.jsp" />
	</div>
    <div id="headerright" class="headerColumn headertop">
		<div class="utilBlock">	
			<a class="featureinfo" href="#">Over CBS in uw buurt
				<!-- NB. expliciet lege alt voor info.png -->
				<span class="custom menuinfo"><img src="img/info.png" alt="" height="37" width="32" />
					<em>Over CBS in uw buurt</em>Het CBS heeft veel gegevens op regionaal niveau. Die zijn al lange tijd beschikbaar via de statistische database StatLine. Cartografische systemen geven de mogelijkheid de regionale gegevens ook op een meer aantrekkelijke manier te presenteren. Daarvoor heeft het CBS deze site opgezet. 
Drie maal per jaar vernieuwt het CBS de gegevens op deze site. Zo mogelijk wordt de site dan ook uitgebreid met nieuwe onderwerpen. 
Zoekt u meer gegevens dan deze site u biedt? Wilt u niet alleen gegevens zien over buurten, maar ook over wijken? Wilt u er zeker van zijn dat u de meest recente cijfers ziet? Ga dan naar  de tabel "Kerncijfers wijken en buurten" in StatLine. U kunt daar selecteren welke gegevens u op uw scherm wilt zien.
				</span>
			</a>
			<a href="#">Hoe werkt dit?</a>
			<a href="#">Veel gestelde vragen</a>
			<a href="#">Contact</a>
		</div>
	</div>
</div>
<div id="inhoud">
	<div id="coreContainer" class="kaartContainer">
		<!-- hier komt de statische kaart -->
		<c:if test="${not empty kaart}">
			<!-- StringConstants.MAP_CACHE_DIR -->
			<img id="coreMapImage" src="${dir}/${kaart.name}"
				alt="kaart voor thema: ${mapname}" width="512px"
				height="512px" longdesc="#featureinfo"/>
			<!-- navigatie knoppen zonder javascript -->
			<jsp:include page="WEB-INF/jsp/core_nav_buttons_include.jsp" />
		</c:if>
	</div>

	<div id="kaartContainer" class="kaartContainer">		
		<div id="cbsKaart" class="kaart">			
			<!-- hier wordt de dynamische kaart ingehangen -->
		</div>		
	</div>
	
	<jsp:include page="WEB-INF/jsp/main_menu_include.jsp" />
	
	<div class="ac-container">
		<div>
			<input id="ac-1" name="accordion-1" type="checkbox" checked="checked"/>
			<label for="ac-1"><fmt:message key="KEY_LEGENDA_TITEL" /></label>
			<div class="ac-small" id="legenda">
				<p>
					<!-- plaats voor de legenda, dynamisch en statisch -->
					<c:if test="${param.coreonly==true}">
						<c:if test="${not empty legendas}">
							<c:forEach items="${legendas}" varStatus="legenda">
								<img src="${dir}/${legendas[legenda.index].name}"
									alt="legenda item" />
							</c:forEach>
						</c:if>
					</c:if>
				</p>
			</div>
		</div>
		<div>
			<input id="ac-2" name="accordion-1" type="checkbox"/>
			<label for="ac-2"><fmt:message key="KEY_INFO_TITEL" /></label>
			<div class="ac-small" id="featureinfo">
				<p>
					<c:if test="${param.coreonly==true}">
						<c:if test="${not empty featureinfo}">
							<c:out value="${featureinfo}" escapeXml="false" />
						</c:if>
					</c:if>
				</p>
			</div>
		</div>
	</div>

	<div id="copyright" class="copy">
		<fmt:message key="KEY_COPYRIGHT" />
	</div>
</div>

<div id="footer">
	<div class="teaserPanel">
				<div class="teaserContent">
					<a href="http://www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/publicaties/gemeente-op-maat/gemeente-op-maat/default.htm" class="opMaat" title="Uw Gemeente Op Maat">Uw Gemeente Op Maat<span>Publicaties en Documenten</span></a>
					<a href="http://www.cbs.nl/nl-NL/menu/_unique/_nieuws/default.htm" title="CBS In uw buurt nieuws" class="rss">CBS In uw buurt nieuws<span>De laatste ontwikkelingen</span></a>
					<a href="http://statline.cbs.nl" title="CBS Databank - Statline" class="databank">CBS Databank - Statline<span>Professionele data nodig?</span></a>
					<a href="http://www.cbs.nl/nl-NL/menu/informatie/publiek/inlichtingen/default.htm" title="Gebruikersreacties gezocht" class="gezocht"><strong>Gezocht:</strong> Gebruikersreacties<span>Heeft u tips of suggesties?</span></a>
				</div>
			</div>		
			<div class="footer">
				<div id="_footerPanel">
					<fmt:message key="KEY_COPYRIGHT" />
					<a href="#">Doorsturen</a>
					<a href="#">Disclaimer</a>
					<a href="#">Privacyverklaring</a>
					<a href="#">Sitemap</a>
					<a href="#" class="last">RSS</a> 
				</div>
            </div>		
</div>

		<c:if test="${param.coreonly!=true}">
			<!-- scripts als laatste laden -->
			<jsp:include page="WEB-INF/jsp/javascript_include.jsp" />
		</c:if>
		<c:if test="${param.coreonly==true}">
			<!-- scripts als laatste laden -->
			<jsp:include page="WEB-INF/jsp/javascript_coreonly_include.jsp" />
		</c:if>	
			
		</body>
	</html>
</jsp:root>