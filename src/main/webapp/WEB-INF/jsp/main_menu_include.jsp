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
											<li class="menuTitle">Bevolking</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('De bevolking van Nederland op 1 januari.')">Inwoners totaal</a>
												<ul>
													<li><p class="editable_textarea" id="paragraph_1">911 ? ?  Google: Israel Did 9-11</p></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>100m vierkant<br/><a href="#">2012</a> | <a href="#">2011</a> | <a href="#">2010</a><br/><a href="#">2009</a> | <a href="#">2008</a> | <a href="#">2007</a><br/><a href="#">2006</a> | <a href="#">2005</a> | <a href="#">2004</a><br/><a href="#">2003</a> | <a href="#">2002</a> | <a href="#">2001</a><br/><a href="#">2000</a></li>
													<li>500m vierkant<br/><a href="#">2012</a> | <a href="#">2011</a> | <a href="#">2010</a><br/><a href="#">2009</a> | <a href="#">2008</a> | <a href="#">2007</a><br/><a href="#">2006</a> | <a href="#">2005</a> | <a href="#">2004</a><br/><a href="#">2003</a> | <a href="#">2002</a> | <a href="#">2001</a><br/><a href="#">2000</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a> | <a href="#">2006</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 0 tot 15 jaar.')">Inwoners 0 tot 15 jaar</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 0 tot 20 jaar.')">Inwoners 0 tot 20 jaar</a>
												<ul>
													<li>100m vierkant<br/><a href="#">2011</a><span class="redcolor">*</span></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 15 tot 25 jaar.')">Inwoners 15 tot 25 jaar</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 20 tot 45 jaar.')">Inwoners 25 tot 45 jaar</a>
												<ul>
													<li>100m vierkant<br/><a href="#">2011</a><span class="redcolor">*</span></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 25 tot 45 jaar.')">Inwoners 45 tot 65 jaar</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>100m vierkant<br/><a href="#">2011</a></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 45 tot 65 jaar.')">Inwoners 65 jaar en ouder</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>100m vierkant<br/><a href="#">2011</a></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Het percentage personen van 65 jaar en ouder.')">Bevolkingsdichtheid</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>100m vierkant<br/><a href="#">2011</a><span class="redcolor">*</span></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Bevolkingsdichtheid uitleg')">Verandering inwonertal 2000-2010</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>100m vierkant<br/><a href="#">2011</a></li>
													<li>500m vierkant<br/><a href="#">2011</a></li>
													<li>Bevolkingskern<br/><a href="#">2008</a></li>
												</ul>
											</li>

											<li class="menuTitle">Huishoudens</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Aantal particuliere huishoudens uitleg.')">Eenpersoonshuishoudens</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Eenpersoonshuishoudens uitleg.')">Huishoudens zonder kinderen</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Huishoudens zonder kinderen uitleg.')">Huishoudens met kinderen</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											
											<li class="menuTitle">Herkomst</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Aantal particuliere huishoudens uitleg.')">Autochtonen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Eenpersoonshuishoudens uitleg.')">Niet-westerse allochtonen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Huishoudens zonder kinderen uitleg.')">Westerse allochtonen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>

										<!--/ul-->
									</ul>
									<ul id="toplevel" class="navleft">
										<!--ul class="navleft"-->
											<li class="menuTitle">Inkomen</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Woningen uitleg.')">Aantal inkomensontvangers</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Woning WOZ-waarde uitleg.')">Inkomen per ontvanger</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Huurwoning uitleg.')">Inwoners met laag inkomen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Koopwoning uitleg.')">Inwoners met hoog inkomen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Koopwoning uitleg.')">Huishoudens met laag inkomen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>											
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Koopwoning uitleg.')">Huishoudens met hoog inkomen (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>											
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Koopwoning uitleg.')">Huishoudens rond of onder sociaal minimum (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											
											<li class="menuTitle">Wonen</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Aantal inkomensontvangers uitleg.')">Woningen</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>		
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Inkomen per ontvanger uitleg.')">Woning WOZ-waarde</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>		

											<li class="menuTitle">Bedrijven</li>	
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('?? uitleg.')">Agrarische bedrijven</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>		
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('?? uitleg.')">Industrie (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('?? uitleg.')">Commerciele dienstverlening (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>												
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('?? uitleg.')">Niet-commerciele dienstverlening (%)</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>	
											
										<!--/ul-->
									</ul>
									<ul class="navright">
										<!--ul class="navright"-->
											<li class="menuTitle"><i>Voorzieningen</i><br/>Kortste afstand</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Agrarische bedrijven uitleg.')" >Huisartsenpraktijk</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Gewassenbedrijven uitleg.')">Huisartsenpost</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Veeteeltbedrijven uitleg.')">Ziekenhuis, excl. buitenpolikliniek</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Industrie uitleg.')">Kinderdagverblijf</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Commerciele dienstverlening uitleg.')">Buitenschoolse opvang</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Niet-commerciele dienstverlening uitleg.')">Basisonderwijs</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Niet-commerciele dienstverlening uitleg.')">VMBO onderwijs</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Niet-commerciele dienstverlening uitleg.')">HAVO/VWO onderwijs</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Niet-commerciele dienstverlening uitleg.')">Grote supermarkt</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
												<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Niet-commerciele dienstverlening uitleg.')">Ov. dagelijkse levensmiddelen</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
											</li>
											
											<li class="menuTitle">Stedelijkheid</li>
											<li><a href="#" onmouseout="wijzigTerug()" onmouseover="wijzig('Omgevingsadressendichtheid uitleg.')">Omgevingsadressendichtheid</a>
												<ul>
													<li>Gemeente<br/><a href="#">2011</a><span class="redcolor">*</span> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Wijk<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
													<li>Buurt<br/><a href="#">2011</a> | <a href="#">2010</a> | <a href="#">2009</a></li>
												</ul>
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
									<li class="menuTitle">2012</li>
									<li><a href="#" class="tooltip" onmouseout="wijzigTerug()" onmouseover="wijzig('- Aantal inwoners: Ja')">100m vierkant</a></li>
									<li><a href="#" class="tooltip" onmouseout="wijzigTerug()" onmouseover="wijzig('- Aantal inwoners: Ja')">500m vierkant</a></li>
									
									<li class="menuTitle">2011</li>
									<li><a href="#" class="tooltip" onmouseout="wijzigTerug()" onmouseover="wijzig('Even kijken hoe dit op te lossen')">Gemeente / Wijk / Buurt</a></li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									
									<li class="menuTitle">2010</li>
									<li><a href="#" class="tooltip" onmouseout="wijzigTerug()" onmouseover="wijzig('Even kijken hoe dit op te lossen')">Gemeente / Wijk / Buurt</a></li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									
									<li class="menuTitle">2009</li>
									<li><a href="#" class="tooltip" onmouseout="wijzigTerug()" onmouseover="wijzig('Even kijken hoe dit op te lossen')">Gemeente / Wijk / Buurt</a></li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
								</ul>
								<ul>
									
									
									<li class="menuTitle">2008</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									<li><a href="#">Bevolkingskern</a></li>
									<li><a href="#">Bodemgebruik</a></li>

									<li class="menuTitle">2007</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									
									<li class="menuTitle">2006</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									<li><a href="#">Bodemgebruik</a></li>
									
									<li class="menuTitle">2005</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>

									<li class="menuTitle">2004</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
								</ul>
								<ul>
									<li class="menuTitle">2003</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>

									<li class="menuTitle">2002</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>

									<li class="menuTitle">2001</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>
									<li><a href="#">Bevolkingskern</a></li>
									
									<li class="menuTitle">2000</li>
									<li><a href="#">100m vierkant</a></li>
									<li><a href="#">500m vierkant</a></li>	
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
									<li><a href="#">2006</a></li>
									<li><a href="#">2008</a></li>
								</ul>
								<ul>										
									<li class="menuTitle"><p><img src="img/template/bevolkingskernen.png" alt="Bevolkingskernen"/></p>Bevolkingskernen</li>
									<li><a href="#">2001</a></li>
									<li><a href="#">2008</a></li>									
								</ul>
								<ul>									
									<li class="menuTitle"><p><img src="img/template/vierkanten.png" alt="Vierkanten"/></p>Vierkanten 100m</li>
									<li><a href="#">2000</a> | <a href="#">2007</a></li>
									<li><a href="#">2001</a> | <a href="#">2008</a></li>
									<li><a href="#">2002</a> | <a href="#">2009</a></li>
									<li><a href="#">2003</a> | <a href="#">2010</a></li>
									<li><a href="#">2004</a> | <a href="#">2011</a></li>
									<li><a href="#">2005</a> | <a href="#">2012</a></li>
									<li><a href="#">2006</a></li>
									
									<li class="menuTitle">Vierkanten 500m</li>
									<li><a href="#">2000</a> | <a href="#">2007</a></li>
									<li><a href="#">2001</a> |  <a href="#">2008</a></li>
									<li><a href="#">2002</a> | <a href="#">2009</a></li>
									<li><a href="#">2003</a> | <a href="#">2010</a></li>
									<li><a href="#">2004</a> | <a href="#">2011</a></li>
									<li><a href="#">2005</a> | <a href="#">2012</a></li>
									<li><a href="#">2006</a></li>
									
								</ul>
								<ul>									
									<li class="menuTitle"><p><img src="img/template/wijkenbuurten.png" alt="Wijken en buurten"/></p>Buurten</li>
									<li><a href="#">2009</a></li>
									<li><a href="#">2010</a></li>
									<li><a href="#">2011</a></li>

									<li class="menuTitle">Wijken</li>
									<li><a href="#">2009</a></li>
									<li><a href="#">2010</a></li>
									<li><a href="#">2011</a></li>

									<li class="menuTitle">Gemeenten</li>
									<li><a href="#">2009</a></li>
									<li><a href="#">2010</a></li>
									<li><a href="#">2011</a></li>									
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