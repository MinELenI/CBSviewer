<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="true"
		language="java" />
	<!--
		voegt skip links aan de pagina toe; nb. om de focus van de cursor mee te 
		laten springen dient de href naar een focusable element te zijn.
	-->
	<fmt:setBundle basename="SkipLinks" />
	
	<div id="skiplinks" class="skipLinks">
		<!-- adres zoek veld -->
		<a href="#adres" class="skipLink"><fmt:message key="KEY_ZOEKEN" /></a>
		<!-- eerste link in menubalk -->
		<a href="#mainMenu_Home" class="skipLink"><fmt:message key="KEY_MAINMENU" /></a>
		<!-- todo: #inhoud is niet focusable want een div, evt. programmatisch ondervangen 
			door met javascript een tabIndex toe te wijzen:
				document.getElementById('inhoud').tabIndex = -1;
		-->
		<a href="#inhoud" class="skipLink"><fmt:message key="KEY_INHOUD" /></a>
	</div>
</jsp:root>
