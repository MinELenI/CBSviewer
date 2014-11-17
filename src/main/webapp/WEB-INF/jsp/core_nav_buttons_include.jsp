<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false"
		language="java" isThreadSafe="false" isErrorPage="false" />

	<fmt:setBundle basename="LabelsBundle" />

	<fmt:parseNumber var="straal" value="${param.straal}" type="number"
		integerOnly="true" parseLocale="en-US" />
	<fmt:parseNumber var="xcoord" value="${param.xcoord}" type="number"
		integerOnly="true" parseLocale="en-US" />
	<fmt:parseNumber var="ycoord" value="${param.ycoord}" type="number"
		integerOnly="true" parseLocale="en-US" />

	<fmt:formatNumber var="zoomin" maxFractionDigits="0"
		value="${straal/2}" minFractionDigits="0" type="number" pattern="###" />

	<c:set var="naarLinks" value="${xcoord-zoomin}" />
	<c:set var="naarRechts" value="${xcoord+zoomin}" />
	<c:set var="naarBoven" value="${ycoord+zoomin}" />
	<c:set var="naarBeneden" value="${ycoord-zoomin}" />

	<c:choose>
		<c:when test="${achtergrond eq 'topografie'}">
			<c:set var="wisselachtergrond" value="luchtfoto" />
			<fmt:message key="KEY_TOGGLE_BASEMAP_LUFO" var="wisselachtergrondBtn" />
		</c:when>
		<c:when test="${achtergrond eq 'luchtfoto'}">
			<c:set var="wisselachtergrond" value="topografie" />
			<fmt:message key="KEY_TOGGLE_BASEMAP_TOPO" var="wisselachtergrondBtn" />
		</c:when>
		<!-- default is topografie, dus wissel is luchtfoto -->
		<c:otherwise>
			<c:set var="wisselachtergrond" value="luchtfoto" />
			<c:set var="achtergrond" value="topografie" />
			<fmt:message key="KEY_TOGGLE_BASEMAP_LUFO" var="wisselachtergrondBtn" />
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${empty param.doorzicht}">
			<!-- 20% doorzichtig (.8 alpha) is de default -->
			<c:set var="doorzicht" value="20" />
		</c:when>
		<c:otherwise>
			<c:set var="doorzicht" value="${param.doorzicht}" />
		</c:otherwise>
	</c:choose>

	<!--  de te gebruiken HTTP methode (post|get) voor de formulieren -->
	<c:set var="formMethod" value="get" />

	<!-- 
	include bestand met navigatie knoppen voor de core versie, 
	let op dat dit bestand vanuit de root van de webapplicatie wordt ingevoegd  
	 -->

	<div id="kaartnavi" class="kaartnavi">
		<fmt:message key="KEY_NAVIGATIE_TITEL" />
		<form id="zoomFormulier" action="index.jsp" method="${formMethod}">
			<!-- knoppen -->
			<fieldset id="in-en-uit-zoomen">
				<legend>
					<fmt:message key="KEY_NAVIGATIE_ZOOM_LEGEND" />
				</legend>


				<label for="zoomUitBtn"><fmt:message
						key="KEY_BTN_NAVI_ZOOMOUT_LBL" /></label>
				<button id="zoomUitBtn" type="submit" name="straal"
					value="${straal*2}">−</button>


				<label for="zoomInBtn"><fmt:message
						key="KEY_BTN_NAVI_ZOOMIN_LBL" /></label>
				<button id="zoomInBtn" type="submit" name="straal" value="${zoomin}">+</button>
			</fieldset>
			<p>
				<input type="hidden" name="coreonly" value="true" />
				<!-- defaults -->
				<input type="hidden" name="straal" value="${straal}" /> <input
					type="hidden" name="xcoord" value="${xcoord}" /> <input
					type="hidden" name="ycoord" value="${ycoord}" /> <input
					type="hidden" name="achtergrond" value="${achtergrond}" /> <input
					type="hidden" name="mapid" value="${mapid}" /> <input
					type="hidden" name="gevonden" value="${param.gevonden}" /><input
					type="hidden" name="doorzicht" value="${doorzicht}" />
			</p>
		</form>

		<form id="schuifFormulier" action="index.jsp" method="${formMethod}">
			<fieldset id="verschuiven">
				<legend>
					<fmt:message key="KEY_NAVIGATIE_SCHUIF_LEGEND" />
				</legend>

				<label for="schuifLinksBtn"><fmt:message
						key="KEY_BTN_NAVI_PANLEFT_LBL" /></label>
				<button id="schuifLinksBtn" type="submit" name="xcoord"
					value="${naarLinks}">←</button>

				<label for="schuifRechtsBtn"><fmt:message
						key="KEY_BTN_NAVI_PANRIGHT_LBL" /></label>
				<button id="schuifRechtsBtn" type="submit" name="xcoord"
					value="${naarRechts}">→</button>

				<label for="schuifOmhoogBtn"><fmt:message
						key="KEY_BTN_NAVI_PANUP_LBL" /></label>
				<button id="schuifOmhoogBtn" type="submit" name="ycoord"
					value="${naarBoven}">↑</button>

				<label for="schuifOmlaagBtn"><fmt:message
						key="KEY_BTN_NAVI_PANDOWN_LBL" /></label>
				<button id="schuifOmlaagBtn" type="submit" name="ycoord"
					value="${naarBeneden}">↓</button>
			</fieldset>

			<p>
				<input type="hidden" name="coreonly" value="true" />

				<!-- defaults -->
				<input type="hidden" name="straal" value="${straal}" /> <input
					type="hidden" name="xcoord" value="${xcoord}" /> <input
					type="hidden" name="ycoord" value="${ycoord}" /> <input
					type="hidden" name="achtergrond" value="${achtergrond}" /> <input
					type="hidden" name="mapid" value="${mapid}" /> <input
					type="hidden" name="doorzicht" value="${doorzicht}" />
			</p>
		</form>

		<form id="achtergrondFormulier" action="index.jsp"
			method="${formMethod}">
			<fieldset id="wisselachtergrond">
				<legend>
					<fmt:message key="KEY_NAVIGATIE_BASEMAP_LEGEND" />
				</legend>
				<label for="wisselBtn"><fmt:message
						key="KEY_TOGGLE_BASEMAP_TITLE" /></label>
				<button id="wisselBtn" type="submit" name="achtergrond"
					value="${wisselachtergrond}">${wisselachtergrondBtn}</button>
			</fieldset>

			<p>
				<input type="hidden" name="coreonly" value="true" />
				<!-- defaults -->
				<input type="hidden" name="straal" value="${straal}" /> <input
					type="hidden" name="xcoord" value="${xcoord}" /> <input
					type="hidden" name="ycoord" value="${ycoord}" />
				<input type="hidden" name="mapid" value="${mapid}" /> <input
					type="hidden" name="gevonden" value="${param.gevonden}" /><input
					type="hidden" name="doorzicht" value="${doorzicht}" />
			</p>
		</form>

		<form id="voorgrondFormulier" action="index.jsp"
			method="${formMethod}">
			<fieldset id="transparantie">
				<legend>
					<fmt:message key="KEY_NAVIGATIE_FGMAP_LEGEND" />
				</legend>

				<label for="transSlct"><fmt:message
						key="KEY_NAVIGATIE_FGMAP_TRANSP_LABEL" /></label> <select id="transSlct"
					name="doorzicht">
					<c:forEach begin="10" end="90" step="10" var="alpha">
						<fmt:message key="KEY_TRANSP_SLIDER_LABEL" var="alphaLabel">
							<fmt:param value="${alpha}"></fmt:param>
						</fmt:message>
						<c:choose>
							<c:when test="${doorzicht eq alpha}">
								<option value="${alpha}" selected="selected">${alphaLabel}</option>
							</c:when>
							<c:otherwise>
								<option value="${alpha}">${alphaLabel}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<button type="submit">
					<fmt:message key="KEY_NAVIGATIE_FGMAP_TRANSP_SUBMIT" />
				</button>
			</fieldset>
			<p>
				<input type="hidden" name="coreonly" value="true" />
				<!-- defaults -->
				<input type="hidden" name="straal" value="${straal}" /> <input
					type="hidden" name="xcoord" value="${xcoord}" /> <input
					type="hidden" name="ycoord" value="${ycoord}" /> <input
					type="hidden" name="achtergrond" value="${achtergrond}" /> <input
					type="hidden" name="mapid" value="${param.mapid}" /> <input
					type="hidden" name="gevonden" value="${param.gevonden}" />
			</p>
		</form>
	</div>
</jsp:root>
