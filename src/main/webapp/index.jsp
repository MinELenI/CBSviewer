<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false"
		language="java" isThreadSafe="false" isErrorPage="false"
		import="nl.mineleni.cbsviewer.util.CookieNamesConstants" />
	<jsp:output doctype-root-element="html"
		doctype-system="about:legacy-compat" omit-xml-declaration="true" />

	<fmt:setBundle basename="LabelsBundle" />

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
<head>
<jsp:include page="WEB-INF/jsp/head_include.jsp" />

<jsp:scriptlet>
// namen van de cookie enum beschikbaar maken
for (CookieNamesConstants e : CookieNamesConstants.values()) {
	  request.setAttribute(e.name(), e.value);
}
</jsp:scriptlet>

<c:if test="${not empty xcoord}">
	<c:set value="${xcoord}" var="xcoord" />
</c:if>
<c:if test="${not empty ycoord}">
	<c:set value="${ycoord}" var="ycoord" />
</c:if>
<c:if test="!${not empty straal}">
	<c:set value="${straal}" var="straal" />
</c:if>

<c:if test="${empty param.xcoord}">
	<c:set value="${cookie[COOKIE_X].value}" var="xcoord" />

</c:if>
<c:if test="${empty param.ycoord}">
	<c:set value="${cookie[COOKIE_Y].value}" var="ycoord" />
</c:if>
<c:if test="${empty param.straal}">
	<c:set value="${cookie[COOKIE_S].value}" var="straal" />
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

<c:if test="${empty param.mapid}">
	<!-- default thema kaartlaag -->
	<c:set value="gemeenten2013_bevolkingsdichtheid_inwoners_per_km2" var="mapid" />
	<c:if test="${not empty cookie[COOKIE_mapid].value }">
		<c:set value='${cookie[COOKIE_mapid].value}' var="mapid" />
	</c:if>
</c:if>

<c:if test="${not empty param.mapid}">
	<c:set value="${param.mapid}" var="mapid" />
</c:if>

<c:if test="${(empty achtergrond) }">
	<c:set value="topografie" var="achtergrond" />
	<c:if test='${not empty cookie[COOKIE_baselyr].value }'>
		<c:set value='${cookie[COOKIE_baselyr].value}' var="achtergrond" />
	</c:if>
</c:if>
<c:if test="${!empty param.achtergrond}">
	<c:set value="${param.achtergrond}" var="achtergrond" />
</c:if>


<jsp:include page="kaart">
	<jsp:param value="${mapid}" name="mapid" />
	<jsp:param value="${xcoord}" name="xcoord" />
	<jsp:param value="${ycoord}" name="ycoord" />
	<jsp:param value="${straal}" name="straal" />
	<jsp:param value="${achtergrond}" name="achtergrond" />
</jsp:include>

<c:if test="${param.coreonly!=true}">
	<script type="text/javascript">
		document.documentElement.className += ' js';
	</script>
</c:if>

<title><fmt:message key="KEY_PAG_TITEL" />: <fmt:message
		key="KEY_KAART_TITEL">
		<fmt:param value="${mapname}" />
	</fmt:message></title>
</head>

<body>
	<jsp:include page="WEB-INF/jsp/skiplinks_include.jsp" />
	<jsp:include page="WEB-INF/jsp/debug_include.jsp" />

	<c:if test="${param.coreonly!=true}">
		<fmt:message key="KEY_BROWSERERROR" var="browser_error" />
		<![CDATA[
	<!--[if lte IE 7]><p class="error"><a href="?coreonly=true">${browser_error}</a></p><![endif]-->
	]]>
	</c:if>

	<div class="page">
		<header class="header">
			<div class="h1">
				<c:url value="./index.jsp" var="indexLink">
					<c:param name="coreonly" value="${param.coreonly}" />
				</c:url>
				<a href="${fn:escapeXml(indexLink)}" title="www.cbsinuwbuurt.nl"
					id="top"> <span class="visually-hidden">www.cbsinuwbuurt.nl</span>
					<img src="img/new/img_CBSLogo.png" alt="CBS in uw buurt"
					title="CBS in uw buurt" width="192" height="59" />
				</a>
			</div>

			<jsp:include page="WEB-INF/jsp/sitemenu_include.jsp" />

			<jsp:include page="WEB-INF/jsp/mainmenu_include.jsp" />

			<jsp:include page="WEB-INF/jsp/zoekformulier.jsp" />
		</header>

		<main id="inhoud">
		<div class="pagetitle">
			<h1 id="pagSubTitle">
				<fmt:message key="KEY_KAART_TITEL">
					<fmt:param value="${mapname}" />
				</fmt:message>
			</h1>
		</div>

		<div id="coreContainer" class="kaartContainer">
			<!-- hier komt de statische kaart -->
			<c:if test="${not empty kaart}">
				<!-- StringConstants.MAP_CACHE_DIR -->
				<img id="coreMapImage" src="${dir}/${kaart.name}"
					alt="kaart voor thema: ${mapname}" width="512" height="512"
					longdesc="#featureinfo" />
				<!-- navigatie knoppen zonder javascript -->
				<jsp:include page="WEB-INF/jsp/core_nav_buttons_include.jsp" />
			</c:if>
		</div>

		<div id="kaartContainer" class="kaartContainer">
			<div id="cbsKaart" class="kaart">
				<!-- hier wordt de dynamische kaart ingehangen -->
			</div>
		</div>

		<ul class="settingsPanel">
			<li id="keylegend" class="legendPanel"><a href="#keylegend"><fmt:message
						key="KEY_LEGENDA_TITEL" /></a>
				<div id="legenda" class="settingsContent">
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
				</div></li>
			<li id="keyfeatureinfo" class="featureinfoPanel"><a
				href="#keyfeatureinfo"><fmt:message key="KEY_INFO_TITEL" /></a>
				<div id="featureinfo" class="settingsContent">
					<c:if test="${param.coreonly==true}">
						<c:if test="${not empty featureinfo}">
							<c:out value="${featureinfo}" escapeXml="false" />
						</c:if>
					</c:if>
				</div></li>
		</ul>
		<jsp:include page="WEB-INF/jsp/main_menu_include.jsp" /> </main>

		<jsp:include page="WEB-INF/jsp/footer_include.jsp" />
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
