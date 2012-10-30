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
	<!--//--><![CDATA[//><!--
		document.documentElement.className += ' js';
		//--><!]]>
	</script>
</c:if>

<title>Kaart <c:out value="${param.mapname}" /></title>
</head>

<body>

	<div id="wrapper" class="wrapper">

		<div id="header" class="header">
			<jsp:expression>RESOURCES.getString("KEY_KAART_TITEL")</jsp:expression>
		</div>

		<div id="article" class="article">

			<div id="coreContainer" class="kaartContainer">
				<!-- 1 adres -->
				<c:if test="${not empty xcoord}">
					<c:set value="${xcoord}" var="xcoord" />
				</c:if>

				<c:if test="${not empty ycoord}">
					<c:set value="${ycoord}" var="ycoord" />
				</c:if>
				<c:if test="!${not empty straal}">
					<c:set value="${straal-1}" var="straal" />
				</c:if>
				<!-- meer adressen -->
				<c:if test="${not empty param.xcoord  }">
					<c:set value="${param.xcoord}" var="xcoord" />
				</c:if>
				<c:if test="${not empty param.ycoord  }">
					<c:set value="${param.ycoord}" var="ycoord" />
				</c:if>
				<c:if test="${not empty param.straal  }">
					<c:set value="${param.straal+1}" var="straal" />
				</c:if>

				<!-- hier komt de statische kaart -->
				<jsp:include page="kaart">
					<!-- TODO: mapname waarde moet uit de request komen bijv. ?mapname=cbs_inwoners_2000_per_hectare -->
					<!-- StringConstants.REQ_PARAM_MAPNAME -->
					<jsp:param name="mapname" value="cbs_inwoners_2000_per_hectare" />

					<jsp:param value="${xcoord}" name="xcoord" />
					<jsp:param value="${ycoord}" name="ycoord" />
					<jsp:param value="${straal}" name="straal" />
				</jsp:include>

				<c:if test="${not empty kaart}">
					<!-- StringConstants.MAP_CACHE_DIR -->
					<img id="coreMapImage" src="${dir}/${kaart.name}"
						alt="kaart voor thema: ${param.mapname}" width="440px"
						height="440px" />
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


		<div id="aside" class="aside">

			<div id="zoekenContainer" class="zoeken">

				<jsp:include page="WEB-INF/jsp/zoekformulier.jsp" />
			</div>

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
							<p class="todo">TODO: html parsen/opschonen</p>
							<!-- hiermee worden de html tags als entities edncoded, niet wat we willen
							 <c:out value="${featureinfo}" /> -->
							<!--<jsp:expression>request.getAttribute("featureinfo")</jsp:expression>-->
							<c:out value="${featureinfo}" escapeXml="false" />
						</c:if>
					</c:if>
				</div>
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