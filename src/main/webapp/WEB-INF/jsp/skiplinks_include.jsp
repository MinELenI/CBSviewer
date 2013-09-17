<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"
		language="java" />
	<!--
		voegt skip links aan de pagina toe; nb. om de focus van de cursor mee te 
		laten springen dient de href een focusable element te zijn.
	-->
	<fmt:setBundle basename="SkipLinks" />
	
	<div id="skiplinks" class="skipLinks">
		<a href="#inhoud" class="skipLink"><fmt:message key="KEY_INHOUD" /></a>
		<a href="#adres" class="skipLink"><fmt:message key="KEY_ZOEKEN" /></a>
		<a href="#mainMenu" class="skipLink"><fmt:message key="KEY_MAINMENU" /></a>
	</div>
</jsp:root>
