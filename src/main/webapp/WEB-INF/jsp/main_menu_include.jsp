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
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Bevolking</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners totaal</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 0 tot 15 jaar</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 0 tot 20 jaar</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 15 tot 25 jaar</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 25 tot 45 jaar</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 45 tot 65 jaar</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Inwoners 65 jaar en ouder</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Bevolkingsdichtheid</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Verandering inwonertal 2000-2010</a>
											</li>

											<li class="menuTitle editable_textarea"><input type="checkbox"/>Huishoudens</li>	
											<li><a class="editable_select"><input type="checkbox"/>Eenpersoonshuishoudens</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Huishoudens zonder kinderen</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Huishoudens met kinderen</a>
											</li>
											
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Herkomst</li>	
											<li><a class="editable_select"><input type="checkbox"/>Autochtonen (%)</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Niet-westerse allochtonen (%)</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Westerse allochtonen (%)</a>
											</li>

										<!--/ul-->
									</ul>
									<ul id="toplevel" class="navleft">
										<!--ul class="navleft"-->
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Inkomen</li>	
											<li><a class="editable_select"><input type="checkbox"/>Aantal inkomensontvangers</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Inkomen per ontvanger</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Inwoners met laag inkomen (%)</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Inwoners met hoog inkomen (%)</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Huishoudens met laag inkomen (%)</a>
											</li>											
											<li><a class="editable_select"><input type="checkbox"/>Huishoudens met hoog inkomen (%)</a>
											</li>											
											<li><a class="editable_select"><input type="checkbox"/>Huishoudens sociaal minimum (%)</a>
											</li>											
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Wonen</li>	
											<li><a class="editable_select"><input type="checkbox"/>Woningen</a>
											</li>		
											<li><a class="editable_select"><input type="checkbox"/>Woning WOZ-waarde</a>
											</li>		
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Bedrijven</li>	
											<li><a class="editable_select"><input type="checkbox"/>Agrarische bedrijven</a>
											</li>		
											<li><a class="editable_select"><input type="checkbox"/>Industrie (%)</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Commerciele dienstverlening (%)</a>
											</li>												
											<li><a class="editable_select"><input type="checkbox"/>Niet-commerciele dienstverlening (%)</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>												
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>											
											
										<!--/ul-->
									</ul>
									<ul class="navright">
										<!--ul class="navright"-->
											<li class="menuTitle editable_textarea"><input type="checkbox"/><i>Voorzieningen (Kortste afstand)</i></li>
											<li><a class="editable_select"><input type="checkbox"/>Huisartsenpraktijk</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Huisartsenpost</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Ziekenhuis, excl. buitenpolikliniek</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Kinderdagverblijf</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Buitenschoolse opvang</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Basisonderwijs</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>VMBO onderwijs</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>HAVO/VWO onderwijs</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Grote supermarkt</a>
											</li>
												<li><a class="editable_select"><input type="checkbox"/>Ov. dagelijkse levensmiddelen</a>
											</li>
											
											<li class="menuTitle editable_textarea"><input type="checkbox"/>Stedelijkheid</li>
											<li><a class="editable_select"><input type="checkbox"/>Omgevingsadressendichtheid</a>
											</li>
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>												
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>	
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>												
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
											</li>		
											<li><a class="editable_select"><input type="checkbox"/>Leeg</a>
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
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2012</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2011</li>
									<li><a class="editable_select"><input type="checkbox"/>Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2010</li>
									<li><a class="editable_select"><input type="checkbox"/>Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2009</li>
									<li><a class="editable_select"><input type="checkbox"/>Gemeente / Wijk / Buurt</a></li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>											
								</ul>
								<ul>
									
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2008</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>Bevolkingskern</a></li>
									<li><a class="editable_select"><input type="checkbox"/>Bodemgebruik</a></li>

									<li class="menuTitle editable_textarea"><input type="checkbox"/>2007</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2006</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>Bodemgebruik</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2005</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>

									<li class="menuTitle editable_textarea"><input type="checkbox"/>2004</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
								</ul>
								<ul>
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2003</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>

									<li class="menuTitle editable_textarea"><input type="checkbox"/>2002</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>

									<li class="menuTitle editable_textarea"><input type="checkbox"/>2001</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>Bevolkingskern</a></li>
									
									<li class="menuTitle editable_textarea"><input type="checkbox"/>2000</li>
									<li><a class="editable_select"><input type="checkbox"/>100m vierkant</a></li>
									<li><a class="editable_select"><input type="checkbox"/>500m vierkant</a></li>	
									
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>		
									<li><a class="editable_select"><input type="checkbox"/>Leeg</a></li>										
								</ul>
							</div>
						</div>
					</li>
					<li>
						<a href="#">Op kaartlaag</a>
						<div class="contentasset">
							<div class="megaMenu megaFourColumns">
								<ul>										
									<li class="menuTitle editable_textarea"><p><img src="img/template/bodemgebruik.png" alt="Bodemgebruik"/></p>Bodemgebruik</li>
									<li><a class="editable_select"><input type="checkbox"/>2006</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2008</a></li>
								</ul>
								<ul>										
									<li class="menuTitle editable_textarea"><p><img src="img/template/bevolkingskernen.png" alt="Bevolkingskernen"/></p>Bevolkingskernen</li>
									<li><a class="editable_select"><input type="checkbox"/>2001</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2008</a></li>									
								</ul>
								<ul>									
									<li class="menuTitle editable_textarea"><p><img src="img/template/vierkanten.png" alt="Vierkanten"/></p><input type="checkbox"/>Vierkanten 100m</li>
									<li><a class="editable_select"><input type="checkbox"/>2000</a> | <a class="editable_select"><input type="checkbox"/>2007</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2001</a> | <a class="editable_select"><input type="checkbox"/>2008</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2002</a> | <a class="editable_select"><input type="checkbox"/>2009</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2003</a> | <a class="editable_select"><input type="checkbox"/>2010</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2004</a> | <a class="editable_select"><input type="checkbox"/>2011</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2005</a> | <a class="editable_select"><input type="checkbox"/>2012</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2006</a></li>
									
									<li class="menuTitle editable_textarea">Vierkanten 500m</li>
									<li><a class="editable_select"><input type="checkbox"/>2000</a> | <a class="editable_select"><input type="checkbox"/>2007</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2001</a> |  <a class="editable_select"><input type="checkbox"/>2008</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2002</a> | <a class="editable_select"><input type="checkbox"/>2009</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2003</a> | <a class="editable_select"><input type="checkbox"/>2010</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2004</a> | <a class="editable_select"><input type="checkbox"/>2011</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2005</a> | <a class="editable_select"><input type="checkbox"/>2012</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2006</a></li>
									
								</ul>
								<ul>									
									<li class="menuTitle"><p><img src="img/template/wijkenbuurten.png" alt="Wijken en buurten"/></p><input type="checkbox"/>Buurten</li>
									<li><a class="editable_select"><input type="checkbox"/>2009</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2010</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2011</a></li>

									<li class="menuTitle"><input type="checkbox"/>Wijken</li>
									<li><a class="editable_select"><input type="checkbox"/>2009</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2010</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2011</a></li>

									<li class="menuTitle"><input type="checkbox"/>Gemeenten</li>
									<li><a class="editable_select"><input type="checkbox"/>2009</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2010</a></li>
									<li><a class="editable_select"><input type="checkbox"/>2011</a></li>									
								</ul>
							</div>
						</div>
					</li>
				<li>
						<a href="#">Maak/wijzig kaartlaag</a>
						<div class="contentasset">
							<div class="megaMenu megaOneColumn">
								<ul>									
									<li class="menuTitle editable_select">Selecteer huidige kaartlaag om deze te wijzigen:</li>
									<li class="menuTitle">Voer de volgende gegevens in:</li>
									<li><label class="addmenuitem" for="menulabel">Menu label</label><input id="menulabel" type="text"/></li>
									<li><label class="addmenuitem" for="menutooltip">Menu tooltip</label><input id="menutooltip" type="text"/></li>
									<li><label class="addmenuitem" for="wmslabel">WMS label</label><input id="wmslabel" type="text"/></li>
									<li><label class="addmenuitem" for="wmsurl">WMS URL</label><input id="wmsurl" type="text"/></li>
									<li><label class="addmenuitem" for="wmslayers">WMS layers</label><input id="wmslayers" type="text"/></li>
									<li><label class="addmenuitem" for="wmsstyles">WMS styles</label><input id="wmsstyles" type="text"/></li>
									<li><input type="submit" value="Voeg toe"/></li>
								</ul>
							</div>
						</div>
					</li>

					
					<li id="infobox"></li>  
				</ol>
			</div>
		</li>
	</ul>
</div>		

</jsp:root>