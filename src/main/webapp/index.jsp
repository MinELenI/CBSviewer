<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
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
	<!-- TODO: mapid waarde moet uit de request/menu komen bijv. ?mapid=cbs_inwoners_2000_per_hectare -->
	<!-- StringConstants.REQ_PARAM_MAPID -->
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

	<title><fmt:message key="KEY_PAG_TITEL" />: <fmt:message key="KEY_KAART_TITEL"><fmt:param value="${mapname}" /></fmt:message></title>
</head>

<body>

	<div class="header">
	
		<div id="headerleft" class="headerColumn headertop">
			<div class="logo">
				<div id="cbslogo">
					<h1 id="pagTitle" class="titel">
						<fmt:message key="KEY_PAG_TITEL" />
					</h1>
					<h2 id="pagSubTitle" class="subtitel">
						<fmt:message key="KEY_KAART_TITEL"><fmt:param value="${mapname}" /></fmt:message>
					</h2>
				</div>
			</div>
		</div>
		
		<div id="headercenter" class="headerColumn headermiddle">
			<jsp:include page="WEB-INF/jsp/zoekformulier.jsp" />
		</div>
		
		<div id="headerright" class="headerColumn headertop">
			<div class="utilBlock">
				<a class="featureinfo" href="#">Over CBS in uw buurt 
					<!-- NB. expliciet lege alt voor img/info.png -->
					<span class="custom menuinfo"> <img src="img/info.png"
						alt="" height="37" width="32" /> <fmt:message key="KEY_PAG_ABOUT" />
				</span>
				</a> 
				<a href="help.jsp">Hoe werkt dit?</a> 
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
					alt="kaart voor thema: ${mapname}" width="512px" height="512px"
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

		<jsp:include page="WEB-INF/jsp/main_menu_include.jsp" />

		<ul class="settingsPanel">
			<li id="keylegend" class="legendPanel">
				<a href="#keylegend"><fmt:message key="KEY_LEGENDA_TITEL" /></a>
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
				</div>
			</li>
			<li id="keyfeatureinfo" class="featureinfoPanel">
				<a href="#keyfeatureinfo"><fmt:message key="KEY_INFO_TITEL" /></a>
				<div id="featureinfo" class="settingsContent">
					<c:if test="${param.coreonly==true}">
						<c:if test="${not empty featureinfo}">
							<c:out value="${featureinfo}" escapeXml="false" />
						</c:if>
					</c:if>
				</div>
			</li>
		</ul>
		
	</div>

	<div id="copyright" class="copy">
		<fmt:message key="KEY_COPYRIGHT" />
	</div>
	
	<div id="downloadLink">
		<!-- StringConstants.REQ_PARAM_DOWNLOADLINK -->
		<c:if test="${not empty downloadLink}">
			<fmt:message var="linkText" key="KEY_LINK_DOWNLOAD"><fmt:param value="${mapname}" /></fmt:message>
			<a href="${downloadLink}"><c:out value="${linkText}"/></a>
		</c:if>
	</div>

	<jsp:include page="WEB-INF/jsp/footer_include.jsp" />

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