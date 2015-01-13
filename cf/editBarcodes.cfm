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
<cfset strPageTitle = "Add/Edit Barcodes">
<!----[ commented out temporarily  - MK 
<cfif not (isdefined("barcodeErrorHandler") )>
       <cfset barcodeErrorHandler = application.beanfactory.getbean("Errorhandler") />
</cfif>
]---->
 <cfset StockmasterDAO = Application.beanfactory.getbean("StockmasterDAO") />
 <cfset StockBarcodesDAO = Application.beanfactory.getbean("StockBarcodesDAO") />

<cfscript>
	stockmaster = Application.beanfactory.getbean("Stockmaster");
	stockmaster.setPartNo( url.partno );
	StockmasterDAO.readbypartno( stockmaster  );
</cfscript>
<!---[   Get the  barcodes associated with this plu   ]---->
<cfset qbarcodes = StockBarcodesDAO.GetBarcodesforProduct( stockmaster.getPartNo() ) />
<cfif isdefined("form") and structkeyexists(form,"return")>
  <cfoutput>
  <cflocation addtoken="no" url="/cf/tblStockMaster_RecordView.cfm?PartNo=#stockmaster.getPartNo()#" />
  <cfabort>
  </cfoutput>
  <cfelseif isdefined("form") and structkeyexists(form,"submitvalues") >
  
  <!---[ loop through the list of submitted barcodes looking to make sure they are unique  ]---->
  <!----[
   (commented out temporarily while I check the syntax of this code - MK)
<cfloop list="form.barcode" index="bc">
  <cfset bcCount = listfind( form.barcode, #bc#, "ALL") />
</cfloop>


<cfset StockBarcodesDAO.UpdateBarcodesforPartNo( form.barcode,form.partno,form.productid,barcodeErrorHandler) />
<cfif barcodeErrorHandler.haserrors()>
   <!----[ Recreate the  qbarcodes query ]---->
   <cfset qBarcodes = querynew( "barcode,PartNo,ProductID,StockBarcodeID", "varchar,varchar,integer,integer"   ) />
   <cfloop list="form.barcode" index="bc">
   <cfscript>
   queryaddrow(qBarcodes);
   querysetCell(qbarcodes,"barcode", "#bc#");
   querysetCell(qbarcodes,"partNo", "#form.partno#");
   querysetCell(qbarcodes, "ProductID")
   </cfscript>
   </cfloop>   ]---->
  
  <cfset StockBarcodesDAO.UpdateBarcodesforPartNo( form.barcode,form.partno,form.productid) />
  <cfset qbarcodes = StockBarcodesDAO.GetBarcodesforProduct( form.partno ) />
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
<cfif application.siteversion eq "development">
  <cfdump var="#qbarcodes#">
</cfif>
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
              <th>Barcode</th>
            </tr>
            <cfif qbarcodes.recordcount>
              <cfloop query="qbarcodes">
              <tr class="#IIf(CurrentRow Mod 2, DE('lite'), DE('dark'))#">
                <td><input type="text" name="barcode" value="#barcode#" size="30" maxlength="16"/></td>
              </tr>
              </cfloop>
            </cfif>
            <cfloop from="1" to="10" index="i">
            <tr class="#IIf(i Mod 2, DE('lite'), DE('dark'))#">
              <td><input type="text" name="barcode" value="" size="30" maxlength="16"/></td>
            </tr>
            </cfloop>
            <tr>
              <td colspan="2"><input type="submit" name="submitvalues" value="Submit">
                <input type="submit" name="return" value="Return to Product View" />
          </table>
        </form>
        <p><a href="tblStockMaster_RecordView.cfm?RecordID=#url.PartNo#">return to product page</a></p>
        </cfoutput>
      </div></td>
  </tr>
</table>
</body>
</html>
