<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		trimDirectiveWhitespaces="false" language="java" isThreadSafe="false"
		isErrorPage="false" />

	<fmt:setBundle basename="MenuLabelsBundle" />	
	
	<c:url value="/index.jsp" var="adreslink">
		<c:param name="gevonden" value="${adres}" />
		<c:param name="xcoord" value="${adres.xCoord}" />
		<c:param name="ycoord" value="${adres.yCoord}" />
		<c:param name="straal" value="${adres.radius}" />
		<c:param name="coreonly" value="${param.coreonly}" />
		<c:param name="mapid" value="cID" />
	</c:url>
	<ul class="navleft">
				<li class="menuTitle">Bevolking</li>
				<li><a href="#">Inwoners 0 tot 20 jaar<span><fmt:message key="KEY_TOOLTIP9" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inwoners_tot_20_jaar')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Inwoners 20 tot 45 jaar<span><fmt:message key="KEY_TOOLTIP10" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inwoners_20_tot_45_jaar')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Binnenlandse migratie<span><fmt:message key="KEY_TOOLTIP11" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_saldo_binnenlandse_migratie')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_saldo_binnenlandse_migratie')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Buitenlandse migratie<span><fmt:message key="KEY_TOOLTIP12" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_saldo_buitenlandse_migratie')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_saldo_buitenlandse_migratie')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Mannen<span><fmt:message key="KEY_TOOLTIP13" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_mannen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_mannen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_mannen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_mannen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_mannen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_mannen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_mannen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_mannen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_mannen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_mannen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_mannen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_mannen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_mannen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_mannen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_mannen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_mannen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_mannen_2008')}">2008</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_SQUARE100" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_mannen_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_mannen_2011')}">2011</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_SQUARE500" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_mannen_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_mannen_2011')}">2011</a></li>
					</ul>
				</li>
				<li><a href="#">Vrouwen<span><fmt:message key="KEY_TOOLTIP14" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_vrouwen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_vrouwen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_vrouwen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_vrouwen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_vrouwen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_vrouwen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_vrouwen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_vrouwen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_vrouwen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_vrouwen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_vrouwen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_vrouwen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_vrouwen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_vrouwen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_vrouwen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_vrouwen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_vrouwen_2008')}">2008</a></li>													
						<li><fmt:message key="KEY_LAYERTYPE_SQUARE100" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_vrouwen_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_vrouwen_2011')}">2011</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_SQUARE500" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_vrouwen_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_vrouwen_2011')}">2011</a></li>
					</ul>
				</li>
				
				<li class="menuTitle">Huishouden</li>
				<li><a href="#">Aantal particuliere huishoudens<span><fmt:message key="KEY_TOOLTIP15" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_huishoudens')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_huishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_huishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_huishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_huishoudens')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_huishoudens')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_huishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_huishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_huishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_huishoudens')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_huishoudens')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_huishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_huishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_huishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_huishoudens')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Ongehuwd<span><fmt:message key="KEY_TOOLTIP19" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_percentage_ongehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_ongehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_ongehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_ongehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_ongehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_percentage_ongehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_ongehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_ongehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_ongehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_ongehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_percentage_ongehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_ongehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_ongehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_ongehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_ongehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_inwoners_ongehuwd')}">2011</a></li>
					</ul>
				</li>
				<li><a href="#">Gehuwd<span><fmt:message key="KEY_TOOLTIP20" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_percentage_gehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_gehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_gehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_gehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_gehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_percentage_gehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_gehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_gehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_gehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_gehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_percentage_gehuwden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_gehuwden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_gehuwden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_gehuwden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_gehuwden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_inwoners_gehuwd')}">2011</a></li>
					</ul>
				</li>
				<li><a href="#">Gescheiden<span><fmt:message key="KEY_TOOLTIP21" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_percentage_gescheiden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_gescheiden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_gescheiden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_gescheiden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_gescheiden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_percentage_gescheiden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_gescheiden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_gescheiden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_gescheiden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_gescheiden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_percentage_gescheiden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_gescheiden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_gescheiden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_gescheiden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_gescheiden')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Gemiddelde huishoudensgrootte<span><fmt:message key="KEY_TOOLTIP22" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_gemiddelde_huishoudgrootte')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_huishoudgrootte')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_huishoudgrootte')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_huishoudgrootte')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_huishoudgrootte')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_gemiddelde_huishoudgrootte')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_huishoudgrootte')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_huishoudgrootte')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_huishoudgrootte')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_huishoudgrootte')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_gemiddelde_huishoudgrootte')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_huishoudgrootte')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_huishoudgrootte')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_huishoudgrootte')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_huishoudgrootte')}">2009</a></li>
					</ul>
				</li>

				<li class="menuTitle">Inkomen</li>
				<li><a href="#">Inkomen per ontvanger<span><fmt:message key="KEY_TOOLTIP27" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_inkomen_inwoner')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_inkomen_inwoner')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_inkomen_inwoner')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_inkomen_inwoner')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_inkomen_inwoner')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_inkomen_inwoner')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Niet actieven<span><fmt:message key="KEY_TOOLTIP34" /></span></a>
					<ul class="submenu navbottom">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_niet_actieven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_niet_actieven')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_niet_actieven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_niet_actieven')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_niet_actieven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_niet_actieven')}">2009</a></li>
					</ul>
				</li>
				
				<li class="menuTitle">Sociale zekerheid</li>
				<li><a href="#">Arbeids ongeschiktheid<span><fmt:message key="KEY_TOOLTIP35" /></span></a>
					<ul class="submenu navbottom">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_arbeidsongeschiktheiduitkeringen_15_tot_65')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Uitkeringen werkloosheid<span><fmt:message key="KEY_TOOLTIP36" /></span></a>
					<ul class="submenu navbottom">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_ww_uitkeringen_15_tot_65')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_ww_uitkeringen_15_tot_65')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_ww_uitkeringen_15_tot_65')}">2009</a></li>
					</ul>
				</li>
		</ul>
	<ul class="navleft">
				<li class="menuTitle">Wonen</li>
				<li><a href="#">Huurwoning<span><fmt:message key="KEY_TOOLTIP39" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_huurwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_huurwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_huurwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_huurwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_huurwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_huurwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_huurwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_huurwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_huurwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_huurwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_huurwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_huurwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_percentage_huurwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_percentage_huurwoningen')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Koopwoning<span><fmt:message key="KEY_TOOLTIP40" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_koopwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_koopwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_koopwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_koopwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_koopwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_koopwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_koopwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_koopwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_koopwoningen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_koopwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_koopwoningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_koopwoningen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_percentage_koopwoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_percentage_koopwoningen')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Bouwjaarklasse tot 2000<span><fmt:message key="KEY_TOOLTIP41" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_bouwjaarklasse_tot_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_bouwjaarklasse_tot_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_bouwjaarklasse_tot_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_bouwjaarklasse_tot_2000')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_bouwjaarklasse_tot_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_bouwjaarklasse_tot_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_bouwjaarklasse_tot_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_bouwjaarklasse_tot_2000')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_bouwjaarklasse_tot_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_bouwjaarklasse_tot_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_bouwjaarklasse_tot_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_bouwjaarklasse_tot_2000')}">2009</a></li>
					</ul>
				</li>														
				<li><a href="#">Bouwjaarklasse vanaf 2000<span><fmt:message key="KEY_TOOLTIP42" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_bouwjaarklasse_vanaf_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_bouwjaarklasse_vanaf_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_bouwjaarklasse_vanaf_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_bouwjaarklasse_vanaf_2000')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_bouwjaarklasse_vanaf_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_bouwjaarklasse_vanaf_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_bouwjaarklasse_vanaf_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_bouwjaarklasse_vanaf_2000')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_bouwjaarklasse_vanaf_2000')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_bouwjaarklasse_vanaf_2000')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_bouwjaarklasse_vanaf_2000')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_bouwjaarklasse_vanaf_2000')}">2009</a></li>
					</ul>
				</li>	
				<li><a href="#">Wooneenheden<span><fmt:message key="KEY_TOOLTIP43" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_wooneenheden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_wooneenheden')}">2008</a></li>
					</ul>
				</li>
				<li><a href="#">Recreatiewoningen<span><fmt:message key="KEY_TOOLTIP44" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_CORE" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern_aantal_recreatiewoningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_recreatiewoningen')}">2008</a></li>
					</ul>
				</li>

				<li class="menuTitle">Energie</li>
				<li><a href="#">Gemiddeld gasverbruik totaal<span><fmt:message key="KEY_TOOLTIP45" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_gasverbruik_particuliere_woning')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_gasverbruik_particuliere_woning')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_gasverbruik_particuliere_woning')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_gasverbruik_particuliere_woning')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_gasverbruik_particuliere_woning')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_gasverbruik_particuliere_woning')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_gasverbruik_particuliere_woning')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_gasverbruik_particuliere_woning')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_gasverbruik_particuliere_woning')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Stadsverwarming<span><fmt:message key="KEY_TOOLTIP46" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aandeel_stadsverwarming')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aandeel_stadsverwarming')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aandeel_stadsverwarming')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aandeel_stadsverwarming')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aandeel_stadsverwarming')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aandeel_stadsverwarming')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aandeel_stadsverwarming')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aandeel_stadsverwarming')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aandeel_stadsverwarming')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Gemiddeld elektriciteitsverbruik totaal<span><fmt:message key="KEY_TOOLTIP47" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_elektricteitsverbruik_totaal')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_elektricteitsverbruik_totaal')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_elektricteitsverbruik_totaal')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_elektricteitsverbruik_totaal')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_elektricteitsverbruik_totaal')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_elektricteitsverbruik_totaal')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_elektricteitsverbruik_totaal')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_elektricteitsverbruik_totaal')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_elektricteitsverbruik_totaal')}">2009</a></li>
					</ul>
				</li>

				<li class="menuTitle">Motorvoertuigen</li>
				<li><a href="#">Personenauto's totaal<span><fmt:message key="KEY_TOOLTIP48" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_personenautos')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_personenautos')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_personenautos')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_personenautos')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_personenautos')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_personenautos')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_personenautos')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_personenautos')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_personenautos')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_personenautos')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_personenautos')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_personenautos')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_personenautos')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_personenautos')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_personenautos')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Personenauto's per huishoudens<span><fmt:message key="KEY_TOOLTIP49" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_gemiddeld_aantal_autos_per_huishouden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddeld_aantal_autos_per_huishouden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_aantal_autos_per_huishouden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_aantal_autos_per_huishouden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_aantal_autos_per_huishouden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_gemiddeld_aantal_autos_per_huishouden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddeld_aantal_autos_per_huishouden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_aantal_autos_per_huishouden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_aantal_autos_per_huishouden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_aantal_autos_per_huishouden')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_gemiddeld_aantal_autos_per_huishouden')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddeld_aantal_autos_per_huishouden')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_aantal_autos_per_huishouden')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_aantal_autos_per_huishouden')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_aantal_autos_per_huishouden')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Bedrijfsmotorvoertuigen totaal<span><fmt:message key="KEY_TOOLTIP50" /></span></a>
					<ul class="submenu">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_bedrijfsmotorvoertuigen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_bedrijfsmotorvoertuigen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_bedrijfsmotorvoertuigen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_bedrijfsmotorvoertuigen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_bedrijfsmotorvoertuigen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_bedrijfsmotorvoertuigen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_bedrijfsmotorvoertuigen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_bedrijfsmotorvoertuigen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_bedrijfsmotorvoertuigen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_bedrijfsmotorvoertuigen')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_bedrijfsmotorvoertuigen')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_bedrijfsmotorvoertuigen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_bedrijfsmotorvoertuigen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_bedrijfsmotorvoertuigen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_bedrijfsmotorvoertuigen')}">2009</a></li>
					</ul>
				</li>
				<li><a href="#">Motortweewielers totaal<span><fmt:message key="KEY_TOOLTIP51" /></span></a>
					<ul class="submenu navbottom">
						<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_motortweewielers')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_motortweewielers')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_motortweewielers')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_motortweewielers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_motortweewielers')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_motortweewielers')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_motortweewielers')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_motortweewielers')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_motortweewielers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_motortweewielers')}">2009</a></li>
						<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_motortweewielers')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_motortweewielers')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_motortweewielers')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_motortweewielers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_motortweewielers')}">2009</a></li>
					</ul>
				</li>
		</ul>
	<ul class="navright">
			<li class="menuTitle">Bedrijven</li>
			<li><a href="#">Gewassenbedrijven<span><fmt:message key="KEY_TOOLTIP58" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_gewassenbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_gewassenbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_gewassenbedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_gewassenbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_gewassenbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_gewassenbedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_gewassenbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_gewassenbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_gewassenbedrijven')}">2009</a></li>
				</ul>
			</li>	
			<li><a href="#">Veeteeltbedrijven<span><fmt:message key="KEY_TOOLTIP59" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_veeteeltbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_veeteeltbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_veeteeltbedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_veeteeltbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_veeteeltbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_veeteeltbedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_veeteeltbedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_veeteeltbedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_veeteeltbedrijven')}">2009</a></li>
				</ul>
			</li>	
			<li><a href="#">Combinatiebedrijven<span><fmt:message key="KEY_TOOLTIP60" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_combinatiebedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_combinatiebedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_combinatiebedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_combinatiebedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_combinatiebedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_combinatiebedrijven')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_combinatiebedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_combinatiebedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_combinatiebedrijven')}">2009</a></li>
				</ul>
			</li>	

			<li class="menuTitle">Kortste afstand</li>
			<li><a href="#">Restaurant<span><fmt:message key="KEY_TOOLTIP70" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_afstand_tot_restaurant')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_restaurant')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_restaurant')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_restaurant')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_afstand_tot_restaurant')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_restaurant')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_restaurant')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_restaurant')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_afstand_tot_restaurant')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_restaurant')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_restaurant')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_restaurant')}">2009</a></li>
				</ul>
			</li>	
			<li><a href="#">Bibliotheek<span><fmt:message key="KEY_TOOLTIP71" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_gemiddelde_afstand_tot_bibliotheek')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_afstand_tot_bibliotheek')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_bibliotheek')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_gemiddelde_afstand_tot_bibliotheek')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_afstand_tot_bibliotheek')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_bibliotheek')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_gemiddelde_afstand_tot_bibliotheek')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_afstand_tot_bibliotheek')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_bibliotheek')}">2009</a></li>
				</ul>
			</li>	
			<li><a href="#">Zwembad<span><fmt:message key="KEY_TOOLTIP72" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_afstand_tot_zwembad')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_zwembad')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_zwembad')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_zwembad')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_afstand_tot_zwembad')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_zwembad')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_zwembad')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_zwembad')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_afstand_tot_zwembad')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_zwembad')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_zwembad')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_zwembad')}">2009</a></li>
				</ul>
			</li>
			<li><a href="#">Bioscoop<span><fmt:message key="KEY_TOOLTIP73" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_afstand_tot_bioscoop')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_bioscoop')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_bioscoop')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_bioscoop')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_afstand_tot_bioscoop')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_bioscoop')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_bioscoop')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_bioscoop')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_afstand_tot_bioscoop')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_bioscoop')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_bioscoop')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_bioscoop')}">2009</a></li>
				</ul>
			</li>
			<li><a href="#">Treinstation<span><fmt:message key="KEY_TOOLTIP74" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_gemiddelde_afstand_tot_treinstation')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddelde_afstand_tot_treinstation')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_treinstation')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_treinstation')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_treinstation')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_gemiddelde_afstand_tot_treinstation')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddelde_afstand_tot_treinstation')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_treinstation')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_treinstation')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_treinstation')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_gemiddelde_afstand_tot_treinstation')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddelde_afstand_tot_treinstation')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_treinstation')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_treinstation')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_treinstation')}">2009</a></li>
				</ul>
			</li>

			<li class="menuTitle">Aantal binnen 3 kilometer</li>
			<li><a href="#">Kinderdagverblijf<span><fmt:message key="KEY_TOOLTIP75" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2013_aantal_kinderdagverblijven_binnen_3_km')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_kinderdagverblijven_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_kinderdagverblijven_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_kinderdagverblijven_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_kinderdagverblijven_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2013_aantal_kinderdagverblijven_binnen_3_km')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_kinderdagverblijven_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_kinderdagverblijven_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_kinderdagverblijven_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_kinderdagverblijven_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2013_aantal_kinderdagverblijven_binnen_3_km')}">2013</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_kinderdagverblijven_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_kinderdagverblijven_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_kinderdagverblijven_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_kinderdagverblijven_binnen_3_km')}">2009</a></li>
				</ul>
			</li>
			<li><a href="#">Basisonderwijs<span><fmt:message key="KEY_TOOLTIP76" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddeld_aantal_basisscholen_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_aantal_basisscholen_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_aantal_basisscholen_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_aantal_basisscholen_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddeld_aantal_basisscholen_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_aantal_basisscholen_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_aantal_basisscholen_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_aantal_basisscholen_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddeld_aantal_basisscholen_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_aantal_basisscholen_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_aantal_basisscholen_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_aantal_basisscholen_binnen_3_km')}">2009</a></li>
				</ul>
			</li>
			<li><a href="#">Grote supermarkt<span><fmt:message key="KEY_TOOLTIP77" /></span></a>
				<ul class="submenu">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_aantal_grote_supermarkten_binnen_3_km')}">2009</a></li>
				</ul>
			</li>

			<li class="menuTitle">Aantal binnen 5 kilometer</li>
			<li><a href="#">VMBO onderwijs<span><fmt:message key="KEY_TOOLTIP79" /></span></a>
				<ul class="submenu navbottom">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_aantal_VMBO_scholen_binnen_5_km')}">2009</a></li>
				</ul>
			</li>
			<li><a href="#">HAVO/VWO onderwijs<span><fmt:message key="KEY_TOOLTIP80" /></span></a>
				<ul class="submenu navbottom">
					<li><fmt:message key="KEY_LAYERTYPE_MUNICIPALITY" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_HAVO_VWO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_HAVO_VWO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_HAVO_VWO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_HAVO_VWO_scholen_binnen_5_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_AREA" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_HAVO_VWO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_HAVO_VWO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_HAVO_VWO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_HAVO_VWO_scholen_binnen_5_km')}">2009</a></li>
					<li><fmt:message key="KEY_LAYERTYPE_NEIGHBOURHOOD" /><br /><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_HAVO_VWO_scholen_binnen_5_km')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_HAVO_VWO_scholen_binnen_5_km')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_HAVO_VWO_scholen_binnen_5_km')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_HAVO_VWO_scholen_binnen_5_km')}">2009</a></li>
				</ul>
			</li>
		</ul>
</jsp:root>
					