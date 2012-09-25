<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" />

	<!-- 
	include bestand met de javascript tags, 
	let op dat dit bestand vanuit de root van de webapplicatie wordt ingevoegd  
	 -->

	<!-- TODO scripts alleen laden als de browser css ondersteund anders niet, 
	dat kan door het sniffen voor de js klasse op het html element van het document -->
	<jsp:text>
		<![CDATA[<script type="text/javascript" src="lib/OpenLayers.js"></script>
<script type="text/javascript" src="lib/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="js/cbsviewer.js"></script>
<script type="text/javascript" src="js/config.js"></script>
<script type="text/javascript" src="js/script.js"></script>]]>
	</jsp:text>
</jsp:root>