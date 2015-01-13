
	<cfset strPartNo = #URL.PN#>
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>

	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	
	
	<!--- Get the store name --->
	<cfset strQuery = "SELECT * from tblStores" >
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & " where StoreID IN(#lngStoreID#)">
	</cfif>
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Get the PLU list --->
	<cfset strQuery = "SELECT tblStocktakeLogVariance.PartNo, tblStockMaster.Description, CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2)) AS DateYYYYMMDD, ">
	<cfset strQuery = strQuery & "SUM(tblStocktakeLogVariance.AF_QtyOnHand - tblStocktakeLogVariance.B4_QtyOnHand) AS QtyDiscrepancy, SUM( (tblStocktakeLogVariance.AF_QtyOnHand - tblStocktakeLogVariance.B4_QtyOnHand)* tblStocktakeLogVariance.Wholesale ) AS ValDiscrepancy, tblStocktakeLogVariance.DDate ">
	<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance INNER JOIN tblStockMaster ON tblStocktakeLogVariance.PartNo = tblStockMaster.PartNo ">
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID IN(#lngStoreID#)) ">
	</cfif>
	<cfset strQuery = strQuery & "Group By tblStocktakeLogVariance.PartNo, tblStockMaster.Description, (CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2) )), tblStocktakeLogVariance.DDate ">
	<cfset strQuery = strQuery & "Having (CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2) ) BETWEEN '#lngFD#' AND '#lngTD#') AND (tblStocktakeLogVariance.PartNo = '#strPartNo#')">

	<CFQUERY name="GetPlu" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

<cfset strPageTitle = "Inventory Control">

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
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a>
	</td>
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
		    		
	  
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td width="25%"> 
      <cfoutput>
	  <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenuInventory.cfm?FD=#lngFD#&TD=#lngTD#&SID=#lngStoreID#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
	 </td>
	
	<cfset TotalQty = 0>
	<cfset TotalAmount = 0>
 <table align="center" width="80%" border="1">
  <tr align="center"> 
    <td><b><font size="2">PLU</font></b></td>
    <td><b><font size="2">Description</font></b></td>
    <td><b><font size="2">Date</font></b></td>
    <td><b><font size="2">QTY Discrepancy</font></b></td>
    <td><b><font size="2">Value Discrepancy</font></b></td>
  </tr>
	
  <cfoutput query = "GetPlu">
 	<cfset TotalQty = TotalQty + #GetPlu.QtyDiscrepancy#>
	<cfset TotalAmount = TotalAmount + #GetPlu.ValDiscrepancy#>
	<tr>
    	<td><font size="2"><a 	href="ReportMenuInventoryDeB.cfm?PN=#GetPlu.PartNo#&SID=#lngStoreID#&FD=#lngFD#&TD=#lngTD#&DM=#GetPlu.DDate#&MD=#GetPlu.DateYYYYMMDD#"><h3>#GetPlu.PartNo#</h3></a></font></td>
    <td><font size="2">#GetPlu.Description#</font></td>
    <td><font size="2">#GetPlu.DDate#</font></td>
    <td align="right"><font size="2">#numberformat(GetPlu.QtyDiscrepancy,"_______.000")#</font></td>
    <td align="right"><font size="2">#numberformat(GetPlu.ValDiscrepancy,"_______.00")#</font></td>
  </tr>
</cfoutput>	
<cfoutput>	
  <tr> 
    <td colspan="3"><font size="3"><b>Total</b></font></div></td>
    <td align="right"><font size="2"><b>#numberformat(TotalQty,"_______.000")#</b></font></td>
    <td align="right"><font size="2"><b>#numberformat(TotalAmount,"_______.00")#</b></font></td>
  </tr>
</cfoutput>	
</table>
	  
    </td>
  </tr>
</table>

</body>
</HTML>

