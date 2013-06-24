<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		trimDirectiveWhitespaces="false" language="java" isThreadSafe="false"
		isErrorPage="false" />

	<fmt:setBundle basename="MenuLabelsBundle" />

	<div class="contentasset">
		<div class="megaMenu megaThreeColumns">
			<ul class="menuAccordion">
				<c:url value="/index.jsp" var="adreslink">
					<c:param name="gevonden" value="${adres}" />
					<c:param name="xcoord" value="${adres.xCoord}" />
					<c:param name="ycoord" value="${adres.yCoord}" />
					<c:param name="straal" value="${adres.radius}" />
					<c:param name="coreonly" value="${param.coreonly}" />
					<c:param name="mapid" value="cID" />
				</c:url>
				<li id="thememenu1">
					<a href="#thememenu1" class="accordionheader"><fmt:message key="KEY_THEME_MAINTHEME" /><span><fmt:message key="KEY_THEME_MAINTHEME_TOOLTIP" /></span></a>
					<div class="menuAccordionContent">
						<ul class="navleft">
								<li class="menuTitle">Bevolking</li>
								<li>
									<a href="#">Inwoners totaal<span><fmt:message key="KEY_TOOLTIP1" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_aantal_inwoners')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_inwoners')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_inwoners')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_inwoners')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_aantal_inwoners')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_inwoners')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_inwoners')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_inwoners')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_aantal_inwoners')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_inwoners')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_inwoners')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_inwoners')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inwoners')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2011')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2010')}">2010</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2009')}">2009</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2008')}">2008</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2007')}">2007</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2006')}">2006</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2005')}">2005</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2004')}">2004</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2003')}">2003</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2002')}">2002</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2001')}">2001</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_inwoners_2000')}">2000</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2012')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2011')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2010')}">2010</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2009')}">2009</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2008')}">2008</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2007')}">2007</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2006')}">2006</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2005')}">2005</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2004')}">2004</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2003')}">2003</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2002')}">2002</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2001')}">2001</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_inwoners_2000')}">2000</a></li>
									</ul>
								</li>
								<li>
									<a href="#">Inwoners 0 tot 15 jaar<span><fmt:message key="KEY_TOOLTIP2" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_perc_personen_tot_15_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_perc_personen_tot_15_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_personen_tot_15_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_personen_tot_15_jaar')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_perc_personen_tot_15_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_perc_personen_tot_15_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_personen_tot_15_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_personen_tot_15_jaar')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_perc_personen_tot_15_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_perc_personen_tot_15_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_personen_tot_15_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_personen_tot_15_jaar')}">2009</a></li>
									</ul>													
								</li>
								<li>
									<a href="#">Inwoners 15 tot 25 jaar<span><fmt:message key="KEY_TOOLTIP3" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_perc_personen_15_tot_25_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_perc_personen_15_tot_25_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_personen_15_tot_25_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_personen_15_tot_25_jaar')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_perc_personen_15_tot_25_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_perc_personen_15_tot_25_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_personen_15_tot_25_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_personen_15_tot_25_jaar')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_perc_personen_15_tot_25_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_perc_personen_15_tot_25_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_personen_15_tot_25_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_personen_15_tot_25_jaar')}">2009</a></li>
									</ul>														
								</li>
								<li>
									<a href="#">Inwoners 25 tot 45 jaar<span><fmt:message key="KEY_TOOLTIP4" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_perc_personen_25_tot_45_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_perc_personen_25_tot_45_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_personen_25_tot_45_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_personen_25_tot_45_jaar')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_perc_personen_25_tot_45_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_perc_personen_25_tot_45_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_personen_25_tot_45_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_personen_25_tot_45_jaar')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_perc_personen_25_tot_45_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_perc_personen_25_tot_45_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_personen_25_tot_45_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_personen_25_tot_45_jaar')}">2009</a></li>
									</ul>															
								</li>
								<li>
									<a href="#">Inwoners 45 tot 65 jaar<span><fmt:message key="KEY_TOOLTIP5" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_perc_personen_45_tot_65_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_perc_personen_45_tot_65_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_personen_45_tot_65_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_personen_45_tot_65_jaar')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_perc_personen_45_tot_65_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_perc_personen_45_tot_65_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_personen_45_tot_65_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_personen_45_tot_65_jaar')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_perc_personen_45_tot_65_jaar')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_perc_personen_45_tot_65_jaar')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_personen_45_tot_65_jaar')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_personen_45_tot_65_jaar')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inwoners_45_tot_65_jaar')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_i2011_4564')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_i2011_4564')}">2011</a></li>
									</ul>															
								</li>
								<li>
									<a href="#">Inwoners 65 jaar en ouder<span><fmt:message key="KEY_TOOLTIP6" /></span></a>
									<ul class="submenu">    
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_perc_personen_65_jaar_en_ouder')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_perc_personen_65_jaar_en_ouder')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_personen_65_jaar_en_ouder')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_personen_65_jaar_en_ouder')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_perc_personen_65_jaar_en_ouder')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_perc_personen_65_jaar_en_ouder')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_personen_65_jaar_en_ouder')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_personen_65_jaar_en_ouder')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_perc_personen_65_jaar_en_ouder')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_perc_personen_65_jaar_en_ouder')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_personen_65_jaar_en_ouder')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_personen_65_jaar_en_ouder')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inwoners_65_jaar_en_ouder')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_i2011_65pl')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_i2011_65pl')}">2011</a></li>
									</ul>	
								</li>
								<li><a href="#">Bevolkingsdichtheid<span><fmt:message key="KEY_TOOLTIP7" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_bevolkingsdichtheid_inwoners_per_km2')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_bevolkingsdichtheid_inwoners_per_km2')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_bevolkingsdichtheid_inwoners_per_km2')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_bevolkingsdichtheid_inwoners_per_km2')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_bevolkingsdichtheid_inwoners_per_km2')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_bevolkingsdichtheid_inwoners_per_km2')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_bevolkingsdichtheid_inwoners_per_km2')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_bevolkingsdichtheid_inwoners_per_km2')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_bevolkingsdichtheid_inwoners_per_km2')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_bevolkingsdichtheid_inwoners_per_km2')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_bevolkingsdichtheid_inwoners_per_km2')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_bevolkingsdichtheid_inwoners_per_km2')}">2009</a></li>
									</ul>
								</li>
								<li><a href="#">Verandering inwonertal 2000-2010<span><fmt:message key="KEY_TOOLTIP8" /></span></a>
									<ul class="submenu">
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_toename_inwoners_2000_2010')}">2010-2000</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_toename_inwoners_2000_2010')}">2010-2000</a></li>
									</ul>
								</li>

								<li class="menuTitle">Huishoudens</li>
								<li><a href="#">Eenpersoonshuishoudens<span><fmt:message key="KEY_TOOLTIP15" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_eenpersoonshuishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_eenpersoonshuishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_eenpersoonshuishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_eenpersoonshuishoudens')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_eenpersoonshuishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_eenpersoonshuishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_eenpersoonshuishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_eenpersoonshuishoudens')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_eenpersoonshuishoudens')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_eenpersoonshuishoudens')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_eenpersoonshuishoudens')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_eenpersoonshuishoudens')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inw_in_eenpersoonshuish')}">2008</a></li>
									</ul>
								</li>
								<li><a href="#">Huishoudens zonder kinderen<span><fmt:message key="KEY_TOOLTIP16" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_huishoudens_zonder_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_huishoudens_zonder_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_huishoudens_zonder_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_huishoudens_zonder_kinderen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_huishoudens_zonder_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_huishoudens_zonder_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_huishoudens_zonder_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_huishoudens_zonder_kinderen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_huishoudens_zonder_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_huishoudens_zonder_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_huishoudens_zonder_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_huishoudens_zonder_kinderen')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inw_in_meerpers_huish_zonder_kin')}">2008</a></li>
									</ul>
								</li>
								<li><a href="#">Huishoudens met kinderen<span><fmt:message key="KEY_TOOLTIP17" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_huishoudens_met_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_huishoudens_met_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_huishoudens_met_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_huishoudens_met_kinderen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_huishoudens_met_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_huishoudens_met_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_huishoudens_met_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_huishoudens_met_kinderen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_huishoudens_met_kinderen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_huishoudens_met_kinderen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_huishoudens_met_kinderen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_huishoudens_met_kinderen')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_inw_in_meerpers_huish_met_kind')}">2008</a></li>
									</ul>
								</li>

								<li class="menuTitle">Herkomst</li>
								<li><a href="#">Autochtonen (%)<span><fmt:message key="KEY_TOOLTIP23" /></span></a>
									<ul class="submenu">
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_autochtonen')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_autochtonen_2011')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_autochtonen_2011')}">2011</a></li>
									</ul>
								</li>
								<li><a href="#">Niet-westerse allochtonen (%)<span><fmt:message key="KEY_TOOLTIP24" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_niet_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_niet_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_niet_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_niet_westerse_allochtonen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_niet_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_niet_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_niet_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_niet_westerse_allochtonen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_niet_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_niet_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_niet_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_niet_westerse_allochtonen')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_niet_westerse_allochtonen')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_niet_westers_allochtonen_2011')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_niet_westers_allochtonen_2011')}">2011</a></li>
									</ul>
								</li>
								<li><a href="#">Westerse allochtonen (%)<span><fmt:message key="KEY_TOOLTIP25" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_percentage_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_percentage_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_westerse_allochtonen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_percentage_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_percentage_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_westerse_allochtonen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_percentage_westerse_allochtonen')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_percentage_westerse_allochtonen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_westerse_allochtonen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_westerse_allochtonen')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_westerse_allochtonen')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_westers_allochtonen_2011')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_westers_allochtonen_2011')}">2011</a></li>
									</ul>
								</li>
						</ul>
						<ul class="navleft">
								<li class="menuTitle">Inkomen</li>
								<li><a href="#">Aantal inkomensontvangers<span><fmt:message key="KEY_TOOLTIP26" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_inkomensontvangers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_inkomensontvangers')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_inkomensontvangers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_inkomensontvangers')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_inkomensontvangers')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_inkomensontvangers')}">2009</a></li>
									</ul>
								</li>
								<li><a href="#">Inkomen per ontvanger<span><fmt:message key="KEY_TOOLTIP27" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddeld_inkomen_inkomensontvanger')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddeld_inkomen_inkomensontvanger')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddeld_inkomen_inkomensontvanger')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddeld_inkomen_inkomensontvanger')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddeld_inkomen_inkomensontvanger')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddeld_inkomen_inkomensontvanger')}">2009</a></li>
									</ul>
								</li>		
								<li><a href="#">Inwoners met laag inkomen (%)<span><fmt:message key="KEY_TOOLTIP28" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_personen_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_personen_met_laag_inkomen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_personen_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_personen_met_laag_inkomen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_personen_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_personen_met_laag_inkomen')}">2009</a></li>
									</ul>
								</li>	
								<li><a href="#">Inwoners met hoog inkomen (%)<span><fmt:message key="KEY_TOOLTIP29" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_personen_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_personen_met_hoog_inkomen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_personen_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_personen_met_hoog_inkomen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_personen_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_personen_met_hoog_inkomen')}">2009</a></li>
									</ul>
								</li>	
								<li><a href="#">Huishoudens met laag inkomen (%)<span><fmt:message key="KEY_TOOLTIP30" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_huish_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_huish_met_laag_inkomen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_huish_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_huish_met_laag_inkomen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_huish_met_laag_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_huish_met_laag_inkomen')}">2009</a></li>
									</ul>
								</li>	
								<li><a href="#">Huishoudens met hoog inkomen (%)<span><fmt:message key="KEY_TOOLTIP31" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_perc_huish_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_perc_huish_met_hoog_inkomen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_perc_huish_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_perc_huish_met_hoog_inkomen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_perc_huish_met_hoog_inkomen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_perc_huish_met_hoog_inkomen')}">2009</a></li>
									</ul>
								</li>	
								<li><a href="#">Huishoudens rond of onder sociaal minimum (%)<span><fmt:message key="KEY_TOOLTIP32" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_huish_onder_rond_sociaal_min')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_huish_onder_rond_sociaal_min')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_huish_onder_rond_sociaal_min')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_huish_onder_rond_sociaal_min')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_huish_onder_rond_sociaal_min')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_huish_onder_rond_sociaal_min')}">2009</a></li>
									</ul>
								</li>														

								<li class="menuTitle">Wonen</li>
								<li><a href="#">Woningen<span><fmt:message key="KEY_TOOLTIP37" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_woningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_woningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_woningen')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_woningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_woningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_woningen')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_woningen')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_woningen')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_woningen')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_aantal_woningen')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2011')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2010')}">2010</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2009')}">2009</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2008')}">2008</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2007')}">2007</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2006')}">2006</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2005')}">2005</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2004')}">2004</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2003')}">2003</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2002')}">2002</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2001')}">2001</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_woningen_2000')}">2000</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2011')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2010')}">2010</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2009')}">2009</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2008')}">2008</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2007')}">2007</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2006')}">2006</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2005')}">2005</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2004')}">2004</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2003')}">2003</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2002')}">2002</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2001')}">2001</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_woningen_2000')}">2000</a></li>
									</ul>
								</li>
								<li><a href="#">Woning WOZ-waarde<span><fmt:message key="KEY_TOOLTIP38" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_WOZwoningwaarde')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_WOZwoningwaarde')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_WOZwoningwaarde')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_WOZwoningwaarde')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_WOZwoningwaarde')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_WOZwoningwaarde')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_WOZwoningwaarde')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_WOZwoningwaarde')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_WOZwoningwaarde')}">2009</a></li>
										<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_WOZwoningwaarde')}">2008</a></li>
										<li>100m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten100m_gem_woz_waarde_woningen_2011')}">2011</a></li>
										<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_gem_woz_waarde_woningen_2011')}">2011</a></li>
									</ul>
								</li>

								<li class="menuTitle">Bedrijven</li>
								<li><a href="#">Agrarische bedrijven<span><fmt:message key="KEY_TOOLTIP54" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_aantal_agragrische_bedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_aantal_agragrische_bedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_aantal_agragrische_bedrijven')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_aantal_agragrische_bedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_aantal_agragrische_bedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_aantal_agragrische_bedrijven')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_aantal_agragrische_bedrijven')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_aantal_agragrische_bedrijven')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_aantal_agragrische_bedrijven')}">2009</a></li>
									</ul>
								</li>
								<li><a href="#">Industrie (%)<span><fmt:message key="KEY_TOOLTIP55" /></span></a>
									<ul class="submenu">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_industrie')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_industrie')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_industrie')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_industrie')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_industrie')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_industrie')}">2009</a></li>
									</ul>
								</li>
								<li><a href="#">Commerciele dienstverlening (%)<span><fmt:message key="KEY_TOOLTIP56" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_commerciele_dienstverlening')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_commerciele_dienstverlening')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_commerciele_dienstverlening')}">2009</a></li>
									</ul>
								</li>
								<li><a href="#">Niet-commerciele dienstverlening (%)<span><fmt:message key="KEY_TOOLTIP57" /></span></a>
									<ul class="submenu navbottom">
										<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_percentage_niet_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_percentage_niet_commerciele_dienstverlening')}">2009</a></li>
										<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_percentage_niet_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_percentage_niet_commerciele_dienstverlening')}">2009</a></li>
										<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_percentage_niet_commerciele_dienstverlening')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_percentage_niet_commerciele_dienstverlening')}">2009</a></li>
									</ul>
								</li>

							<!--/ul-->
						</ul>
						<ul class="navright">
						<!--ul class="navright"-->
							<li class="menuTitle"><em>Voorzieningen</em><br/>Kortste afstand</li>
							<li><a href="#">Huisartsenpraktijk<span><fmt:message key="KEY_TOOLTIP61" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_huisartspraktijk')}">2010</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_huisartspraktijk')}">2010</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_huisartspraktijk')}">2010</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_huisartspraktijk')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Huisartsenpost<span><fmt:message key="KEY_TOOLTIP62" /></span></a>
								<ul class="submenu">
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_huisartsenpost')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Ziekenhuis, excl. buitenpolikliniek<span><fmt:message key="KEY_TOOLTIP63" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_ziekenhuis_excl_buitenpoli')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_ziekenhuis_excl_')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Kinderdagverblijf<span><fmt:message key="KEY_TOOLTIP64" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_afstand_tot_kinderdagverblijf')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_afstand_tot_kinderdagverblijf')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_afstand_tot_kinderdagverblijf')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_afstand_tot_kinderdagverblijf')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_afstand_tot_kinderdagverblijf')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_afstand_tot_kinderdagverblijf')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_afstand_tot_kinderdagverblijf')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_afstand_tot_kinderdagverblijf')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_afstand_tot_kinderdagverblijf')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_kinderdagverblij')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Buitenschoolse opvang<span><fmt:message key="KEY_TOOLTIP65" /></span></a>
								<ul class="submenu">	
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_buitenschoolse_o')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Basisonderwijs<span><fmt:message key="KEY_TOOLTIP66" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_basisonderwijs')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_basisonderwijs')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_basisonderwijs')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_basisonderwijs')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_basisonderwijs')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_basisonderwijs')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_basisonderwijs')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_basisonderwijs')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_basisonderwijs')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_basisschool')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">VMBO onderwijs<span><fmt:message key="KEY_TOOLTIP67" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_VMBO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_VMBO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_VMBO_school')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_VMBO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_VMBO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_VMBO_school')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_VMBO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_VMBO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_VMBO_school')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_VMBO')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">HAVO/VWO onderwijs<span><fmt:message key="KEY_TOOLTIP68" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_HAVO_VWO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_HAVO_VWO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_HAVO_VWO_school')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_HAVO_VWO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_HAVO_VWO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_HAVO_VWO_school')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_HAVO_VWO_school')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_HAVO_VWO_school')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_HAVO_VWO_school')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_HAVO_VWO')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Grote supermarkt<span><fmt:message key="KEY_TOOLTIP682" /></span></a>
								<ul class="submenu">
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_gemiddelde_afstand_tot_grote_supermarkt')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_gemiddelde_afstand_tot_grote_supermarkt')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_gemiddelde_afstand_tot_grote_supermarkt')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_gemiddelde_afstand_tot_grote_supermarkt')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_gemiddelde_afstand_tot_grote_supermarkt')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_gemiddelde_afstand_tot_grote_supermarkt')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_gemiddelde_afstand_tot_grote_supermarkt')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_gemiddelde_afstand_tot_grote_supermarkt')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_gemiddelde_afstand_tot_grote_supermarkt')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_grote_supermarkt')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Ov. dagelijkse levensmiddelen<span><fmt:message key="KEY_TOOLTIP69" /></span></a>
								<ul class="submenu">
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_gemiddelde_afstand_tot_overige_dagelijk')}">2008</a></li>
								</ul>
							</li>
							<li class="menuTitle">Bodemgebruik</li>
							<li><a href="#">Bestand bodemgebruik<span><fmt:message key="KEY_TOOLTIP82" /></span></a>
								<ul class="submenu">    
									<li>Bodemgebruik<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bodemgebruik2008')}">2008</a></li>
								</ul>
							</li>
							<li><a href="#">Omgevingsadressendichtheid<span><fmt:message key="KEY_TOOLTIP81" /></span></a>
								<ul class="submenu navbottom">    
									<li>Gemeente<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2012_omgevingsadressendichtheid')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2011_omgevingsadressendichtheid')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2010_omgevingsadressendichtheid')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'gemeenten2009_omgevingsadressendichtheid')}">2009</a></li>
									<li>Wijk<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2012_omgevingsadressendichtheid')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2011_omgevingsadressendichtheid')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2010_omgevingsadressendichtheid')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'wijken2009_omgevingsadressendichtheid')}">2009</a></li>
									<li>Buurt<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2012_omgevingsadressendichtheid')}">2012</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2011_omgevingsadressendichtheid')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2010_omgevingsadressendichtheid')}">2010</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'buurten2009_omgevingsadressendichtheid')}">2009</a></li>
									<li>Bevolkingskernen<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'bevolkingskern2008_omgevingsadressendichtheid_adres_km2')}">2008</a></li>
									<li>500m vierkant<br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2011')}">2011</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2010')}">2010</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2009')}">2009</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2008')}">2008</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2007')}">2007</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2006')}">2006</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2005')}">2005</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2004')}">2004</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2003')}">2003</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2002')}">2002</a> | <a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2001')}">2001</a><br/><a href="${fn:replace(fn:escapeXml(adreslink), 'cID', 'vierkanten500m_OAD2000')}">2000</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</li>
				<li id="thememenu2">
					<a href="#thememenu2" id="thememenu2Header" class="accordionheader"><fmt:message key="KEY_THEME_SUBTHEME" /><span><fmt:message key="KEY_THEME_SUBTHEME_TOOLTIP" /></span></a>
					<div id="thememenu2Content" class="menuAccordionContent">
					</div>
				</li>
			</ul>
		</div>
	</div>

</jsp:root>
