
<cfset strPageTitle = "Price Formula">
<cfset strPartNo = #URL.PN#>



<CFQUERY name="GetData" datasource="#application.dsn#" > 
        SELECT 
            tblStockPriceFormula.PriceFormulaID, 
            tblStockPriceFormula.PartNo, 
            tblStockPriceFormula.PriceFrom, 
            tblStockPriceFormula.PriceTo, 
            tblStockPriceFormula.MaxRetail 
        FROM tblStockPriceFormula 
        WHERE (((tblStockPriceFormula.PartNo)= '#strPartNo#' )) 
        ORDER BY tblStockPriceFormula.PriceFrom
</CFQUERY>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
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

<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<FORM action="PriceFormulaGridAction.cfm" method="post">
<table width="100%" border="0" cellspacing="0">
  <tr>
    <td>
      <div align="center">
				<table width="40%" border="0" cellspacing="0">
				  <tr> 
				    <td colspan="3"><cfoutput><h2>PLU: #strPartNo#</h2></cfoutput></td>
				  </tr>
				  <tr> 
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr> 
				    <td>From</td>
				    <td>To</td>
				    <td>Max Retail</td>
				  </tr>
				  <cfset TotalLines = 10 + #GetData.RecordCount#>
				  <cfoutput>
					  <input type="hidden" name="txNumLines" value="#TotalLines#">
   					  <input type="hidden" name="PartNo" value="#strPartNo#">
				  </cfoutput>
				  <cfset lngLineNumber = 0>
				  <cfoutput Query = "GetData">
				  		  <cfset lngLineNumber = lngLineNumber + 1>
						  <tr> 
						    <td>
								<input type="hidden" name="PriceFormulaID_#lngLineNumber#" value="#GetData.PriceFormulaID#">
								<input type="text" name="PriceFrom_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(GetData.PriceFrom,"_______.00")#">
								<input type="hidden" name="PriceFrom_#lngLineNumber#_float" value="Please type Price From on line #lngLineNumber#">
								<input type="hidden" name="PriceFrom_#lngLineNumber#_required" value="Please type Price From on line #lngLineNumber#">
							</td>
						    <td>
								<input type="text" name="PriceTo_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(GetData.PriceTo,"_______.00")#">
								<input type="hidden" name="PriceTo_#lngLineNumber#_float" value="Please type Price To on line #lngLineNumber#">
								<input type="hidden" name="PriceTo_#lngLineNumber#_required" value="Please type Price To on line #lngLineNumber#">
							</td>
						    <td>
								<input type="text" name="MaxRetail_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(GetData.MaxRetail,"_______.00")#">
								<input type="hidden" name="MaxRetail_#lngLineNumber#_float" value="Please type Max Retail on line #lngLineNumber#">
								<input type="hidden" name="MaxRetail_#lngLineNumber#_required" value="Please type Max Retail on line #lngLineNumber#">
							</td>
						  </tr>
				  </cfoutput>
						  <tr> 
						    <td colspan="3">&nbsp;</td>
						  </tr>
				  <cfloop index="lngLoopIndex" from="1" to="10" step="1">
  				  		  <cfset lngLineNumber = lngLineNumber + 1>
						  <cfoutput>
						  <tr> 
						    <td>
								<input type="hidden" name="PriceFormulaID_#lngLineNumber#" value="0">
								<input type="text" name="PriceFrom_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(0,"_______.00")#">
								<input type="hidden" name="PriceFrom_#lngLineNumber#_float" value="Please type Price From on line #lngLineNumber#">
								<input type="hidden" name="PriceFrom_#lngLineNumber#_required" value="Please type Price From on line #lngLineNumber#">
							</td>
						    <td>
								<input type="text" name="PriceTo_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(0,"_______.00")#">
								<input type="hidden" name="PriceTo_#lngLineNumber#_float" value="Please type Price To on line #lngLineNumber#">
								<input type="hidden" name="PriceTo_#lngLineNumber#_required" value="Please type Price To on line #lngLineNumber#">
							</td>
						    <td>
								<input type="text" name="MaxRetail_#lngLineNumber#" maxlength="10" size = "10" value="#NumberFormat(0,"_______.00")#">
								<input type="hidden" name="MaxRetail_#lngLineNumber#_float" value="Please type Max Retail on line #lngLineNumber#">
								<input type="hidden" name="MaxRetail_#lngLineNumber#_required" value="Please type Max Retail on line #lngLineNumber#">
							</td>
						  </tr>
				  		  </cfoutput>
				  </cfloop>
						  <tr> 
						    <td colspan="3">&nbsp;</td>
						  </tr>
				</table>
				<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
				<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">
		</div>
    </td>
  </tr>
</table>

</form>
</body>
</HTML>

