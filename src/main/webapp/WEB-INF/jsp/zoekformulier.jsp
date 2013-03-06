<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false"
		language="java" isThreadSafe="false" isErrorPage="false" />

	<fmt:setBundle basename="LabelsBundle" />

	<div id="zoekContainer">
		<form title="Zoekformulier" method="get" action="adres"
			id="zoekFormulier">
			<p class="zoekinput">
				<label for="adres">adres zoeken<input type="text" id="adres"
					accesskey="8" name="adres" title="Vul een adres of postcode in"
					value="${param.adres}" /> <input value="" type="submit"
					accesskey="s" id="searchbutton" /></label>

				<c:if test="${request.straal != null}">
					<input type="hidden" name="straal" value="${straal}" />
				</c:if>

				<input type="hidden" name="coreonly" value="true" /> <input
					type="hidden" name="forward" value="true" />
			</p>
		</form>

		<div id="zoekresultaten">
			<!-- REQ_PARAM_GEVONDEN.code -->
			<c:out value="${gevonden}" />
			<c:out value="${param.gevonden}" />

			<c:if test="${adreslijst!=null}">
				<!-- for item in lijst maak url -->
				<ul class="adreslijst">
					<li class="list"><a class="selector" href="#">maak een
							keuze uit de lijst</a>
						<ul class="adressen">
							<c:forEach var="adres" items="${adreslijst}">
								<fmt:message var="ttl" key="KEY_ZOEKEN_LINK_TTL">
									<fmt:param value="${adres}" />
								</fmt:message>
								<li><c:url value="/index.jsp" var="adreslink">
										<c:param name="gevonden" value="${adres}" />
										<c:param name="xcoord" value="${adres.xCoord}" />
										<c:param name="ycoord" value="${adres.yCoord}" />
										<c:param name="straal" value="${adres.radius}" />
										<c:param name="coreonly" value="${param.coreonly}" />
									</c:url> <a href="${fn:escapeXml(adreslink)}" title="${ttl}">${adres}</a>
								</li>
							</c:forEach>
						</ul></li>
				</ul>
			</c:if>
		</div>
	</div>
</jsp:root>