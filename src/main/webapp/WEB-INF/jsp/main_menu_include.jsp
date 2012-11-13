<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt" version="2.1">
	<jsp:directive.page contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false"
		import="nl.mineleni.cbsviewer.util.LabelsBundle, nl.mineleni.cbsviewer.util.StringConstants"
		trimDirectiveWhitespaces="true" language="java" isThreadSafe="false"
		isErrorPage="false" />

	<jsp:scriptlet>LabelsBundle RESOURCES = new LabelsBundle();</jsp:scriptlet>
	
	<!-- menu dat alleen css gebruikt, de onderdelen die via javascript werken nog een coreonly voor plaatsen, tevels Excel module afronden en localiseren -->
	<div class="dropDownMenu clearfix">
	<!--a id="skipNavigation"></a-->
	<ul class="siteNavigation">
		<li class="sectionDepartment">
			<a class="hasMenu" href="#">Selecteer een CBS kaartlaag</a>
			<div class="navDropDown"> 
				<ol class="navCategories">
					<li>
						<a href="#">Op thema</a>
							<div class="contentasset">
								<div class="megaMenu megaThreeColumns">
									<ul class="navleft">
										<!--ul class="navleft"-->
											<li class="menuTitle editable_textarea">Bevolking</li>	
											<li><a class="editable_select">Inwoners totaal</a>
											</li>
											<li><a class="editable_select">Inwoners 0 tot 15 jaar</a>
											</li>	
											<li><a class="editable_select">Inwoners 0 tot 20 jaar</a>
											</li>	
											<li><a class="editable_select">Inwoners 15 tot 25 jaar</a>
											</li>	
											<li><a class="editable_select">Inwoners 25 tot 45 jaar</a>
											</li>	
											<li><a class="editable_select">Inwoners 45 tot 65 jaar</a>
											</li>	
											<li><a class="editable_select">Inwoners 65 jaar en ouder</a>
											</li>	
											<li><a class="editable_select">Bevolkingsdichtheid</a>
											</li>	
											<li><a class="editable_select">Verandering inwonertal 2000-2010</a>
											</li>

											<li class="menuTitle editable_textarea">Huishoudens</li>	
											<li><a class="editable_select">Eenpersoonshuishoudens</a>
											</li>
											<li><a class="editable_select">Huishoudens zonder kinderen</a>
											</li>
											<li><a class="editable_select">Huishoudens met kinderen</a>
											</li>
											
											<li class="menuTitle editable_textarea">Herkomst</li>	
											<li><a class="editable_select">Autochtonen (%)</a>
											</li>
											<li><a class="editable_select">Niet-westerse allochtonen (%)</a>
											</li>
											<li><a class="editable_select">Westerse allochtonen (%)</a>
											</li>

										<!--/ul-->
									</ul>
									<ul id="toplevel" class="navleft">
										<!--ul class="navleft"-->
											<li class="menuTitle editable_textarea">Inkomen</li>	
											<li><a class="editable_select">Aantal inkomensontvangers</a>
											</li>
											<li><a class="editable_select">Inkomen per ontvanger</a>
											</li>
											<li><a class="editable_select">Inwoners met laag inkomen (%)</a>
											</li>
											<li><a class="editable_select">Inwoners met hoog inkomen (%)</a>
											</li>
											<li><a class="editable_select">Huishoudens met laag inkomen (%)</a>
											</li>											
											<li><a class="editable_select">Huishoudens met hoog inkomen (%)</a>
											</li>											
											<li><a class="editable_select">Huishoudens rond of onder sociaal minimum (%)</a>
											</li>
											
											<li class="menuTitle editable_textarea">Wonen</li>	
											<li><a class="editable_select">Woningen</a>
											</li>		
											<li><a class="editable_select">Woning WOZ-waarde</a>
											</li>		

											<li class="menuTitle editable_textarea">Bedrijven</li>	
											<li><a class="editable_select">Agrarische bedrijven</a>
											</li>		
											<li><a class="editable_select">Industrie (%)</a>
											</li>
											<li><a class="editable_select">Commerciele dienstverlening (%)</a>
											</li>												
											<li><a class="editable_select">Niet-commerciele dienstverlening (%)</a>
											</li>	
											
										<!--/ul-->
									</ul>
									<ul class="navright">
										<!--ul class="navright"-->
											<li class="menuTitle editable_textarea"><i>Voorzieningen</i><br/>Kortste afstand</li>
											<li><a class="editable_select">Huisartsenpraktijk</a>
											</li>
											<li><a class="editable_select">Huisartsenpost</a>
											</li>
											<li><a class="editable_select">Ziekenhuis, excl. buitenpolikliniek</a>
											</li>
											<li><a class="editable_select">Kinderdagverblijf</a>
											</li>
											<li><a class="editable_select">Buitenschoolse opvang</a>
											</li>
											<li><a class="editable_select">Basisonderwijs</a>
											</li>
											<li><a class="editable_select">VMBO onderwijs</a>
											</li>
											<li><a class="editable_select">HAVO/VWO onderwijs</a>
											</li>
											<li><a class="editable_select">Grote supermarkt</a>
											</li>
												<li><a class="editable_select">Ov. dagelijkse levensmiddelen</a>
											</li>
											
											<li class="menuTitle editable_textarea">Stedelijkheid</li>
											<li><a class="editable_select">Omgevingsadressendichtheid</a>
											</li>
										<!--/ul-->
									</ul>
								</div>
							</div>
					</li>			
					<li><a href="#">Op jaar</a>
						 <div class="contentasset">
							<div class="megaMenu megaThreeColumns">
								<ul>
									<li class="menuTitle editable_textarea">2012</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea">2011</li>
									<li><a class="editable_select">Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea">2010</li>
									<li><a class="editable_select">Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea">2009</li>
									<li><a class="editable_select">Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
								</ul>
								<ul>
									
									
									<li class="menuTitle editable_textarea">2008</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									<li><a class="editable_select">Bevolkingskern</a></li>
									<li><a class="editable_select">Bodemgebruik</a></li>

									<li class="menuTitle editable_textarea">2007</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea">2006</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									<li><a class="editable_select">Bodemgebruik</a></li>
									
									<li class="menuTitle editable_textarea">2005</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>

									<li class="menuTitle editable_textarea">2004</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
								</ul>
								<ul>
									<li class="menuTitle editable_textarea">2003</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>

									<li class="menuTitle editable_textarea">2002</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>

									<li class="menuTitle editable_textarea">2001</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>
									<li><a class="editable_select">Bevolkingskern</a></li>
									
									<li class="menuTitle editable_textarea">2000</li>
									<li><a class="editable_select">100m vierkant</a></li>
									<li><a class="editable_select">500m vierkant</a></li>	
								</ul>
							</div>
						</div>
					</li>
					<li>
						<a href="#">Op kaartlaag</a>
						<div class="contentasset">
							<div class="megaMenu megaFourColumns">
								<ul>										
									<li class="menuTitle"><p><img src="img/template/bodemgebruik.png" alt="Bodemgebruik"/></p>Bodemgebruik</li>
									<li><a class="editable_select">2006</a></li>
									<li><a class="editable_select">2008</a></li>
								</ul>
								<ul>										
									<li class="menuTitle"><p><img src="img/template/bevolkingskernen.png" alt="Bevolkingskernen"/></p>Bevolkingskernen</li>
									<li><a class="editable_select">2001</a></li>
									<li><a class="editable_select">2008</a></li>									
								</ul>
								<ul>									
									<li class="menuTitle"><p><img src="img/template/vierkanten.png" alt="Vierkanten"/></p>Vierkanten 100m</li>
									<li><a class="editable_select">2000</a> | <a class="editable_select">2007</a></li>
									<li><a class="editable_select">2001</a> | <a class="editable_select">2008</a></li>
									<li><a class="editable_select">2002</a> | <a class="editable_select">2009</a></li>
									<li><a class="editable_select">2003</a> | <a class="editable_select">2010</a></li>
									<li><a class="editable_select">2004</a> | <a class="editable_select">2011</a></li>
									<li><a class="editable_select">2005</a> | <a class="editable_select">2012</a></li>
									<li><a class="editable_select">2006</a></li>
									
									<li class="menuTitle">Vierkanten 500m</li>
									<li><a class="editable_select">2000</a> | <a class="editable_select">2007</a></li>
									<li><a class="editable_select">2001</a> |  <a class="editable_select">2008</a></li>
									<li><a class="editable_select">2002</a> | <a class="editable_select">2009</a></li>
									<li><a class="editable_select">2003</a> | <a class="editable_select">2010</a></li>
									<li><a class="editable_select">2004</a> | <a class="editable_select">2011</a></li>
									<li><a class="editable_select">2005</a> | <a class="editable_select">2012</a></li>
									<li><a class="editable_select">2006</a></li>
									
								</ul>
								<ul>									
									<li class="menuTitle"><p><img src="img/template/wijkenbuurten.png" alt="Wijken en buurten"/></p>Buurten</li>
									<li><a class="editable_select">2009</a></li>
									<li><a class="editable_select">2010</a></li>
									<li><a class="editable_select">2011</a></li>

									<li class="menuTitle">Wijken</li>
									<li><a class="editable_select">2009</a></li>
									<li><a class="editable_select">2010</a></li>
									<li><a class="editable_select">2011</a></li>

									<li class="menuTitle">Gemeenten</li>
									<li><a class="editable_select">2009</a></li>
									<li><a class="editable_select">2010</a></li>
									<li><a class="editable_select">2011</a></li>									
								</ul>
							</div>
						</div>
					</li>
					<li id="infobox">Beweeg met de muis over een item voor meer informatie. <br/><br/>Klik op de hoofdgroep om de standaardlaag te laden. Deze is aangegeven met een sterretje (<span class="redcolor">*</span>)</li>  
				</ol>
			</div>
		</li>
	</ul>
</div>		

</jsp:root>