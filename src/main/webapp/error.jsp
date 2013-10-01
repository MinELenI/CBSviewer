<?xml version="1.0" encoding="UTF-8"?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false"
		language="java" isThreadSafe="true" isErrorPage="true"
		import="org.slf4j.Logger, org.slf4j.LoggerFactory" />
	<jsp:output doctype-root-element="html"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
		omit-xml-declaration="no" />

	<fmt:setBundle basename="ErrorLabelsBundle" />

	<jsp:scriptlet>Logger logger = LoggerFactory.getLogger("nl.mineleni.cbsviewer");
			if (logger.isDebugEnabled()) {
				logger.debug("LET OP: de applicatie draait in debug modus");
			}
			pageContext.setAttribute("isDebugEnabled", logger.isDebugEnabled());

			logger.error(exception.getLocalizedMessage(), exception);</jsp:scriptlet>

	<c:set var="exception"
		value="${requestScope['javax.servlet.error.exception']}" />

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
<head>
<jsp:include page="WEB-INF/jsp/head_include.jsp" />

<title>Systeemfout</title>
</head>
<body>
	<jsp:include page="WEB-INF/jsp/debug_include.jsp" />
	<div class="page smallpopup">
		<h1>Systeemfout</h1>

		<p class="error">
			<fmt:message key="KEY_ERROR_UITLEG" />
		</p>
		<ul>
			<li><fmt:message key="KEY_ERROR_500_OPLOSSING1" /></li>
			<li><fmt:message key="KEY_ERROR_500_OPLOSSING2" /></li>
		</ul>
		<p class="error">
			<fmt:message key="KEY_ERROR_SYSTEEMMELDING">
				<fmt:param value="${exception}" />
			</fmt:message>
		</p>

		<!-- Stack trace -->
		<c:if test="${isDebugEnabled}">
			<p>
				<code>
					<c:forEach items="${exception.stackTrace}" var="element">
						<c:out value="${element}" />
						<br />
					</c:forEach>
				</code>
			</p>
		</c:if>
	</div>
</body>
	</html>
</jsp:root>