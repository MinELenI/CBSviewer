<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		import="nl.mineleni.cbsviewer.util.LabelsBundle, nl.mineleni.cbsviewer.util.StringConstants"
		trimDirectiveWhitespaces="true" language="java" isThreadSafe="false"
		isErrorPage="false" />
<jsp:output doctype-root-element="html"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		omit-xml-declaration="no" />

	<jsp:scriptlet>LabelsBundle RESOURCES = new LabelsBundle();</jsp:scriptlet>

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
<head>

<jsp:include page="WEB-INF/jsp/head_include.jsp" />

<c:if test="${param.coreonly!=true}">
	<script type="text/javascript" charset="utf-8">
		document.documentElement.className += ' js';
	</script>
</c:if>

<title>Kaart <c:out value="${param.mapid}" /></title>
</head>

<body>

		<div class="ui-layout-north">
				<div class="pageheader">
					<div class="logo">
						<a href="#">							
							<!--jsp:expression>RESOURCES.getString("KEY_KAART_TITEL")</jsp:expression-->
							<img src="./img/template/hdr_logo.gif" usemap="#cbsmap" alt="CBS in uw buurt: Centraal Bureau voor de Statistiek"/>
						</a>
					</div>
					<div class="utilBlock">
						<a href="#" class="active">Home</a>
						<a href="#">Over CBS in uw buurt</a>
						<a href="#">Hoe werkt dit?</a>
						<a href="#">Veel gestelde vragen</a>
						<a href="#">Contact</a>
					</div>
				</div>
         </div>		
		<div class="ui-layout-west">
			
				<div class="smartStep">
					<label class="meerweten"><span>1. Meer weten over uw omgeving?</span></label>
					<div id="zoekenContainer" class="zoeken">
						<jsp:include page="WEB-INF/jsp/zoekformulier.jsp" />
					</div>
				</div>

				<div class="secondstep">
					
					<!-- invullen van parameters voor de kaart.
					TODO: mogelijk moet dit stuk code gewoon boven de head sectie van de pagina. -->
					<!-- 1 adres -->
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
						<jsp:param name="mapid" value="cbs_inwoners_2000_per_hectare" />
	
						<jsp:param value="${xcoord}" name="xcoord" />
						<jsp:param value="${ycoord}" name="ycoord" />
						<jsp:param value="${straal}" name="straal" />
					</jsp:include>

				
					<div id="legendaContainer" class="legenda">
						<jsp:expression>RESOURCES.getString("KEY_LEGENDA_TITEL")</jsp:expression>
						<div id="legenda">
							<!-- plaats voor de legenda, dynamisch en statisch -->
							<c:if test="${param.coreonly==true}">
								<c:if test="${not empty legendas}">
									<c:forEach items="${legendas}" varStatus="legenda">
										<img src="${dir}/${legendas[legenda.index].name}"
											alt="legenda item" />
									</c:forEach>
								</c:if>
							</c:if>
						</div>
					</div>

					<div id="infoContainer" class="featureinfo">
						<jsp:expression>RESOURCES.getString("KEY_INFO_TITEL")</jsp:expression>
						<div id="featureinfo">
							<!-- plaats voor de feature info, dynamisch en statisch-->
							<c:if test="${param.coreonly==true}">
								<c:if test="${not empty featureinfo}">
									<c:out value="${featureinfo}" escapeXml="false" />
								</c:if>
							</c:if>
						</div>
					</div>
					
				</div>				

		</div>
		<div class="ui-layout-center" style="background-color:#EEEEEE">
		
			<div id="coreContainer" class="kaartContainer">
				<!-- hier komt de statische kaart -->
				<c:if test="${not empty kaart}">
					<!-- StringConstants.MAP_CACHE_DIR -->
					<img id="coreMapImage" src="${dir}/${kaart.name}"
						alt="kaart voor thema: ${mapname}" width="440px"
						height="440px" longdesc="#featureinfo"/>
					<!-- navigatie knoppen zonder javascript -->
					<jsp:include page="WEB-INF/jsp/core_nav_buttons_include.jsp" />
				</c:if>
			</div>

			<div id="kaartContainer" class="kaartContainer">
				<div id="cbsKaart" class="kaart">
					<!-- hier wordt de dynamische kaart ingehangen -->
				</div>
			</div>

			<div id="copyright" class="copy">
				<jsp:expression>RESOURCES.getString("KEY_COPYRIGHT")</jsp:expression>
			</div>
			
		</div>
		
		<div class="ui-layout-south">
		
			<div class="teaserPanel">
				<div class="teaserContent">
					<a id="_teasersControl__linkOpMaatHyperLink" class="opMaat" title="Uw Gemeente Op Maat" style="cursor: pointer; ">Uw Gemeente Op Maat<span>Publicaties en Documenten</span></a>
					<a href="#" title="CBS In uw buurt nieuws" class="rss">CBS In uw buurt nieuws<span>De laatste ontwikkelingen</span></a>
					<a href="#" title="CBS Databank - Statline" class="databank">CBS Databank - Statline<span>Professionele data nodig?</span></a>
					<a href="#" title="Gebruikersreacties gezocht" class="gezocht"><strong>Gezocht:</strong> Gebruikersreacties<span>Heeft u tips of suggesties?</span></a>
				</div>
			</div>		
			<div class="footer">
				<div id="_footerPanel">
					<jsp:expression>RESOURCES.getString("KEY_COPYRIGHT")</jsp:expression>
					<a href="#">Doorsturen</a>
					<a href="#">Disclaimer</a>
					<a href="#">Privacyverklaring</a>
					<a href="#">Sitemap</a>
					<a href="#" class="last">RSS</a> 
				</div>
            </div>
            
		</div>

		<jsp:include page="WEB-INF/jsp/main_menu_include.jsp" />

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