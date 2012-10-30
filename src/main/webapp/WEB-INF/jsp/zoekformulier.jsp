<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		import="nl.mineleni.cbsviewer.util.LabelsBundle, nl.mineleni.cbsviewer.util.StringConstants"
		trimDirectiveWhitespaces="true" language="java" isThreadSafe="false"
		isErrorPage="false" />

	<jsp:scriptlet>LabelsBundle RESOURCES = new LabelsBundle();</jsp:scriptlet>

	<!-- zoek formulier voor de versie zonder javascript en/of css -->
	<form id="zoekFormulier" action="adres" method="get"
		title="Zoekformulier" name="zoekFormulier">
		<jsp:expression>RESOURCES.getString("KEY_ADRESZOEKEN_TITEL")</jsp:expression>
		<p id="zoekresultaten">
			<c:out value="${gevonden}" />
		</p>
		<c:if test="${adreslijst!=null }">
			<!-- for item in lijst maak url -->
			<ul class="adreslijst">
				<c:forEach var="adres" items="${adreslijst}">
					<li><a
						href="index.jsp?gevonden=${adres}&amp;xcoord=${adres.getxCoord()}&amp;ycoord=${adres.getyCoord()}&amp;straal=${adres.getRadius()}&amp;coreonly=${param.coreonly}"
						title="zoom in op ${adres}">${adres}</a></li>
				</c:forEach>
			</ul>
		</c:if>
		<p>
			<label for="adres">Postcode of plaatsnaam</label> <input type="text"
				id="adres" name="adres" value="${param.adres}" />
		</p>

		<p class="button">
			<c:if test="${request.straal != null}">
				<input type="hidden" name="straal" value="${straal}" />
			</c:if>

			<input type="hidden" name="coreonly" value="true" /> <input
				type="hidden" name="forward" value="true" />

			<button type="submit">
				<span><jsp:expression>RESOURCES.getString("KEY_ZOEKEN_SUBMIT")</jsp:expression></span>
			</button>
		</p>
	</form>

</jsp:root>