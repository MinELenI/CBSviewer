<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" trimDirectiveWhitespaces="false" />

	<!-- 
	include bestand met de header tags, 
	let op dat dit bestand vanuit de root van de webapplicatie wordt ingevoegd  
	 -->
	<jsp:text>
		<![CDATA[
		<meta charset='utf-8' />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="dns-prefetch" href="http://geodata.nationaalgeoregister.nl/" />
		<link rel="dns-prefetch" href="http://geodata1.nationaalgeoregister.nl/" />
		<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
		<meta name="description" content="Kaart applicatie" />
		<!-- Dublin Core metadata tags geven fouten in sommige validators..
		link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" / -->
		<meta name="DCTERMS.type" content="Text" />
		<meta name="DCTERMS.language" title="XSD.language" content="nl-NL" />
		<meta name="DCTERMS.coverage" content="Nederland" />
		<meta name="DCTERMS.temporal" content="start=2008-03-12;" />
		<meta name="DCTERMS.format" content="text/html" />
		<meta name="DCTERMS.audience" content="particulier" />
		<meta name="DCTERMS.identifier" content="http://www.cbs.nl/" />
		<meta name="DCTERMS.creator" content="CBS" />
		<meta name="DCTERMS.modified" title="XSD.dateTime" content="2012-09-10" />
		<meta name="DCTERMS.title" content="Documenten en publicaties - CBS.nl" />
		<meta name="DCTERMS.description" content="Kaart applicatie" />
		<meta name="DCTERMS.format" content="text/html" />
		<meta name="DCTERMS.language" content="nl-NL" />
		<meta name="DCTERMS.creator" content="CBS" />
		<meta name="DCTERMS.publisher" content="CBS" />

		<link rel="stylesheet" href="css/no-theme/jquery-ui-1.10.4.custom.min.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/no-theme/jquery.fancybox.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/compiled.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
		<link rel="stylesheet" href="css/menu.css" type="text/css" media="all" />

		<!--[if lte IE 7]><link rel="stylesheet" href="css/ie-lte7.css" type="text/css" media="screen" /><![endif]-->
		<!--[if IE 8]>    <link rel="stylesheet" href="css/ie-8.css" type="text/css" media="screen" />   <![endif]-->
		<!--[if lt IE 9]> <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>          <![endif]-->

		<link rel="stylesheet" href="css/print.css" type="text/css" media="print" />
		]]>
	</jsp:text>
</jsp:root>
