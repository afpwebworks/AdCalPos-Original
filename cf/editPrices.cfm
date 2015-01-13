<cfsilent>
<!----
==========================================================================================================
Filename:     editBarcodes.cfm
Description:  
Date:         
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset strPageTitle = "Add/Edit Prices">
<!----[ commented out temporarily  - MK 
<cfif not (isdefined("barcodeErrorHandler") )>
       <cfset barcodeErrorHandler = application.beanfactory.getbean("Errorhandler") />
</cfif>
]---->
<cfset StockmasterDAO = Application.beanfactory.getbean("StockmasterDAO") />
<cfset StockPricesDAO = Application.beanfactory.getbean("StockPricesDAO") />
<cfscript>
	stockmaster = Application.beanfactory.getbean("Stockmaster");
	stockmaster.setPartNo( url.partno );
	StockmasterDAO.readbypartno( stockmaster  );
	thePriceLevels = StockPricesDAO.GetAllStockPrices();
</cfscript>
<!---[   Get the  barcodes associated with this plu   ]---->

<cfif isdefined("form") and structkeyexists(form,"return")>
  <cfoutput>
  <cflocation addtoken="no" url="/cf/tblStockMaster_RecordView.cfm?RecordID=#stockmaster.getPartNo()#" />
  <cfabort>
  </cfoutput>
  <cfelseif isdefined("form") and ( structkeyexists(form,"submitvalues") or structkeyexists(form,"saveandreturn") ) >
  <cfif application.siteversion is "development">
	  <cfdump var="#form#">
  </cfif>
  <cfset ProductPrice = application.beanfactory.getbean("productprice") />
  <cfset ProductPrice.setproductid(  trim(form.productid)  ) />
  <cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
  <cfloop query="thePriceLevels">
  <cfset PriceID = thePriceLevels.PriceID />
  <cfscript>
     //transfer form values to the bean
     ProductPrice.setsellincludetax(  evaluate("form.sellinc_" & PriceID)   );
     ProductPrice.setsellunit(trim(      evaluate("form.Price_" & PriceID)        ));
     ProductPrice.setPriceID( PriceID ) ;
     
   </cfscript>
  <cfset ProductPrice.validate(errorhandler) />
  <cfif NOT(errorhandler.haserrors())>
    <cfset StockmasterDAO.saveProductPrice(ProductPrice) />
  </cfif>
   <cfif application.siteversion is "development">
	  <cfdump var="#ProductPrice.getsnapshot()#" />
  </cfif>
  </cfloop>
  
  <cfif structkeyexists(form,"saveandreturn")>
      <cflocation addtoken="no"  url="/cf/tblStockMaster_RecordView.cfm?PartNo=#form.PartNo#" />
      <cfabort>
  <cfelse>
      <cflocation addtoken="no"  url="/cf/editPrices.cfm?PartNo=#form.PartNo#" />
      <cfabort>
  </cfif>
</cfif>

<!---[   </cfif>   ]---->

</cfsilent>
<cfoutput>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<TITLE>#strPageTitle#</TITLE>
</cfoutput>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<cfoutput>
<table width="100%">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1>#strPageTitle#</h1></td>
    <td width="25%"><div align="right"><a href="tblStockMaster_RecordView.cfm?RecordID=#url.PartNo#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div></td>
  </tr>
  <tr>
    <td colspan="3" align="center">PLU: #stockmaster.getPartNo()# - #stockmaster.getDescription()#</td>
  </tr>
</table>
</cfoutput>
<br>
<br>
<cfif (isdefined("barcodeErrorHandler") AND  (barcodeErrorHandler.haserrors()))>
  <cfoutput>
  <div class="errorhandler"> #session.errorhandler.MakeErrorDisplay(barcodeErrorHandler)# </div>
  </cfoutput>
</cfif>
<table width="100%" border="0">
  <tr>
    <td><div align="center">
        <cfoutput>
        <form action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post" >
          <input type="hidden" name="partno" value="#stockmaster.getPartNo()#" />
          <input type="hidden" name="productid" value="#stockmaster.getproductid()#" />
          <table>
            <tr>
              <th>Description</th>
              <th>Price</th>
              <th>Include GST</th>
            </tr>
            <cfif thePriceLevels.recordcount>
              <cfloop query="thePriceLevels">
              <tr class="#IIf(CurrentRow Mod 2, DE('lite'), DE('dark'))#">
                <td>#thePriceLevels.description#</td>
                <td><input type="text" name="price_#thePriceLevels.PriceID#" value="#stockmaster.getPriceLevels()["#ThePriceLevels.description#"].SellUnit#" size="15" maxlength="16"/></td>
                <td><select name="sellinc_#thePriceLevels.PriceID#">
                    <option value="1" <cfif stockmaster.getPriceLevels()["#ThePriceLevels.description#"].SELLINCLUDETAX eq "1">selected="selected"</cfif> >Yes</option>
                    <option value="0" <cfif stockmaster.getPriceLevels()["#ThePriceLevels.description#"].SELLINCLUDETAX eq "0">selected="selected"</cfif> >No</option>
                  </select></td>
              </tr>
              </cfloop>
            </cfif>
            <tr>
              <td colspan="2"><input type="submit" name="submitvalues" value="Submit">
               <input type="submit" name="saveandreturn" value="Save and return" />
                <input type="submit" name="return" value="Return without saving" />
          </table>
        </form>

        </cfoutput>
      </div></td>
  </tr>
</table>

</body>
</html>
