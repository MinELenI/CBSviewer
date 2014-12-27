<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false" />

	<fmt:setBundle basename="LabelsBundle" />
	<!-- 
	include bestand met de footer tags, 
	let op dat dit bestand vanuit de root van de webapplicatie wordt ingevoegd  
	 -->
	<jsp:text>
		<![CDATA[
		<footer id="footerWrapper">	
			<span class="introduction"><fmt:message key="KEY_COPYRIGHT" /></span>
		</footer>
		]]>
	</jsp:text>
</jsp:root>