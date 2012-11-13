<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		import="nl.mineleni.cbsviewer.util.LabelsBundle, nl.mineleni.cbsviewer.util.AvailableLayersBean"
		trimDirectiveWhitespaces="true" language="java" />

	<jsp:scriptlet>LabelsBundle RESOURCES = new LabelsBundle();
			AvailableLayersBean layers = new AvailableLayersBean();</jsp:scriptlet>

	<!-- 
	include bestand met de javascript tags, 
	let op dat dit bestand vanuit de root van de webapplicatie wordt ingevoegd  
	 -->

	 <!-- jquery-simple can be removed later, use latest jquery. The jquery layout also has to work without javascript enabled. -->
	 
	<jsp:text>
		<![CDATA[<script type="text/javascript" src="lib/OpenLayers.js"></script>
<script type="text/javascript" src="lib/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="lib/jquery.form.js"></script>
<script type="text/javascript" src="lib/jquery-ui-1.9.1.custom.min.js"></script>
<script type="text/javascript" src="lib/jquery.jeditable.mini.js"></script>
<script type="text/javascript" src="lib/jquery.layout.js"></script>		
<script type="text/javascript" src="js/cbsviewer.js"></script>
<script type="text/javascript" id="language" charset="utf-8">]]>
	</jsp:text>
	<!-- hiermee maken we de resourcebundle beschikbaar in het javascript deel van de applicatie -->
	<jsp:expression>RESOURCES.getOpenLayersLangBundle()</jsp:expression>
	<!-- en alle kaartlagen -->
	<jsp:expression>layers.asJSON()</jsp:expression>
	<jsp:text>
		<![CDATA[</script>
<script type="text/javascript" src="js/config.js"></script>
<script type="text/javascript" src="js/script.js"></script>]]>
	</jsp:text>	 
	
</jsp:root>