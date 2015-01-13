
   	<cfset dbtTime1 = #gettickcount()#>

	<cfset strDM = #URL.DM#>
	<cfif len(strDM) EQ 7>
		<cfset strDM = "0" & #strDM#>	
	</cfif>	
	<cfset strMD = #URL.MD#>

	<cfset strPartNo = #URL.PN#>
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>

	<cfset strDateFrom = '#mid(strMD,7,2)#' & '#mid(strMD,5,2)#' & '#mid(strMD,1,4)#'>
	
	<!--- Get the store name --->
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > SELECT *
	FROM tblStores where 1=1
		<CFIF lngStoreID is not "all">
			  and storeID in (#lngStoreID#) 
		</cfif>
	</CFQUERY>

	<!--- Get the PLU list --->
	<cfset strQuery = "SELECT tblStocktakeLogVariance.PartNo, tblStockMaster.Description, CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2)) AS DateYYYYMMDD, ">
	<cfset strQuery = strQuery & "SUM(tblStocktakeLogVariance.AF_QtyOnHand - tblStocktakeLogVariance.B4_QtyOnHand) AS QtyDiscrepancy, SUM( (tblStocktakeLogVariance.AF_QtyOnHand - tblStocktakeLogVariance.B4_QtyOnHand)* tblStocktakeLogVariance.Wholesale ) AS ValDiscrepancy, tblStocktakeLogVariance.DDate ">
	<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance INNER JOIN tblStockMaster ON tblStocktakeLogVariance.PartNo = tblStockMaster.PartNo ">
	<CFIF lngStoreID is not "all">
	 <cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID IN(#lngStoreID#)) ">
	 </cfif>
	<cfset strQuery = strQuery & "Group By tblStocktakeLogVariance.PartNo, tblStockMaster.Description, (CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2) )), tblStocktakeLogVariance.DDate ">
	<cfset strQuery = strQuery & "Having (CONVERT(int, SUBSTRING(tblStocktakeLogVariance.DDate, 5, 4) + SUBSTRING(tblStocktakeLogVariance.DDate, 3, 2) + SUBSTRING(tblStocktakeLogVariance.DDate, 1, 2) ) = '#strMD#') AND (tblStocktakeLogVariance.PartNo = '#strPartNo#')">

	<CFQUERY name="GetPlu" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Get the starting stock --->
	<cfset strQuery = "SELECT StartingStock, Wholesale ">
	<cfset strQuery = strQuery & "FROM tblStockHistStart ">
	<cfset strQuery = strQuery & "WHERE (DDate = '#strMD#') ">
	<CFIF lngStoreID is not "all">
		<cfset strQuery = strQuery & "AND (StoreID IN(#lngStoreID#)) ">
	</cfif>
	 <cfset strQuery = strQuery & "AND (PartNo = '#strPartNo#')">
	<CFQUERY name="GetStartingStock" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset StartingStock = '?????'>
	<cfif #GetStartingStock.RecordCount# GT 0>
		<cfif #isnumeric(GetStartingStock.StartingStock)#>
			<cfset StartingStock = #GetStartingStock.StartingStock#>
		</cfif>
	</cfif>

	<!--- Get the closing stock --->
	<cfset strQuery = "SELECT ClosingStock, Wholesale ">
	<cfset strQuery = strQuery & " FROM tblStockHistEnding ">
	<cfset strQuery = strQuery & " WHERE (DDate = '#strMD#')">
	<CFIF lngStoreID is not "all">
	 <cfset strQuery = strQuery & " AND (StoreID IN (#lngStoreID#))">
	 </cfif>
	  <cfset strQuery = strQuery & " AND (PartNo = '#strPartNo#')">
	<CFQUERY name="GetClosingStock" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset ClosingStock = '?????'>
	<cfif #GetClosingStock.RecordCount# GT 0>
		<cfif #isnumeric(GetClosingStock.ClosingStock)#>
			<cfset ClosingStock = #GetClosingStock.ClosingStock#>
		</cfif>
	</cfif>
	
	<!--- Get Purchases --->
	<cfset strQuery = "SELECT SUM(QtySupplied) AS SQtySupplied ">
	<cfset strQuery = strQuery & "FROM tblOrderInvoiceDetail ">
	<cfset strQuery = strQuery & "WHERE" >
	<CFIF lngStoreID is not "all">
	 <cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND">
	 </cfif>
	  <cfset strQuery = strQuery & " (OrderDate = '#strDM#') AND (PartNo = '#strPartNo#')">
	<CFQUERY name="GetPurchases" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblPurchases = 0>
	<cfif #GetPurchases.RecordCount# GT 0>
		<cfif #isnumeric(GetPurchases.SQtySupplied)#>
			<cfset dblPurchases = #GetPurchases.SQtySupplied#>
		</cfif>
	</cfif>


	<!--- Get Qty Sold --->
	<cfset strQuery = "SELECT SUM(Quantity) AS SQty ">
	<cfset strQuery = strQuery & "FROM tblStore_PLUTotals ">
	<cfset strQuery = strQuery & "WHERE (PLUNumber = '#strPartNo#')">
	<CFIF lngStoreID is not "all">
		<cfset strQuery = strQuery & " AND (StoreID IN(#lngStoreID#))">
	</cfif>
	 <cfset strQuery = strQuery & "AND ({ fn YEAR(Date) } * 10000 + { fn MONTH(Date) } * 100 + day(Date) = #strMD#)">	
	<CFQUERY name="GetSold" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblQtySold = 0>
	<cfif #GetSold.RecordCount# GT 0>
		<cfif #isnumeric(GetSold.SQty)#>
			<cfset dblQtySold = #GetSold.SQty#>
		</cfif>
	</cfif>

	<!--- Get Total KG Sold --->
	<cfset strQuery = "SELECT SUM(TotalKg) AS Skg ">
	<cfset strQuery = strQuery & "FROM tblStore_PLUTotals ">
	<cfset strQuery = strQuery & "WHERE (PLUNumber = '#strPartNo#')">
	<CFIF lngStoreID is not "all">
	 <cfset strQuery = strQuery & "AND (StoreID IN(#lngStoreID#))">
	 </cfif>
	  <cfset strQuery = strQuery & "AND ({ fn YEAR(Date) } * 10000 + { fn MONTH(Date) } * 100 + day(Date) = #strMD#)">	
	<CFQUERY name="GetSoldKG" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblKgSold = 0>
	<cfif #GetSoldKG.RecordCount# GT 0>
		<cfif #isnumeric(GetSoldKG.Skg)#>
			<cfset dblKgSold = #GetSoldKG.Skg#>
		</cfif>
	</cfif>
	
	<!--- Get Wastage --->
	<cfset strQuery = "SELECT SUM(Wastage) AS SWastage ">
	<cfset strQuery = strQuery & "FROM dbo.tblWastageLog ">
	<cfset strQuery = strQuery & "WHERE">
	<CFIF lngStoreID is not "all">
	<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND">
	</cfif>
	<cfset strQuery = strQuery & " (PartNo = '#strPartNo#') AND ">
	<cfset strQuery = strQuery & "({ fn YEAR(DateEntered) } * 10000 + { fn MONTH(DateEntered) } * 100 + day(DateEntered) =  #strMD# )">	

	<CFQUERY name="GetWastage" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblQtyWasted = 0>
	<cfif #GetWastage.RecordCount# GT 0>
		<cfif #isnumeric(GetWastage.SWastage)#>
			<cfset dblQtyWasted = #GetWastage.SWastage#>
		</cfif>
	</cfif>

	<!--- Get Transfer to other plu's --->
	<cfset strQuery = "SELECT SUM(TeansferQty) AS STeansferQty ">
	<cfset strQuery = strQuery & "FROM dbo.tblTransferLog ">
	<cfset strQuery = strQuery & "WHERE">
	<CFIF lngStoreID is not "all">
	 <cfset strQuery = strQuery & "(StoreID IN (#lngStoreID#)) AND">
	 </cfif>
	  <cfset strQuery = strQuery & "(PartNo = '#strPartNo#') AND ">
	<cfset strQuery = strQuery & "({ fn YEAR(DateEntered) } * 10000 + { fn MONTH(DateEntered) } * 100 + day(DateEntered) = #strMD# )">
	
	<CFQUERY name="GetTransferToOtherPlu" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblQtyTransferedToOtherPlu = 0>
	<cfif #GetTransferToOtherPlu.RecordCount# GT 0>
		<cfif #isnumeric(GetTransferToOtherPlu.STeansferQty)#>
			<cfset dblQtyTransferedToOtherPlu = #GetTransferToOtherPlu.STeansferQty#>
		</cfif>
	</cfif>

	<!--- Get Transfer From other plu's to this PLU --->
	<cfset strQuery = "SELECT SUM(TeansferQty) AS STeansferQty ">
	<cfset strQuery = strQuery & "FROM tblTransferLog ">
	<cfset strQuery = strQuery & "WHERE">
	<CFIF lngStoreID is not "all">
	<cfset strQuery = strQuery & " (StoreID IN (#lngStoreID#)) AND">
	</cfif>
	
	<cfset strQuery = strQuery & " ({ fn YEAR(DateEntered) } * 10000 + { fn MONTH(DateEntered) } * 100 + day(DateEntered) = #strMD# ) AND (TransferToPlu = '#strPartNo#')">
	<CFQUERY name="GetTransferFromOtherPluToThisPlu" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblQtyTransferedToThisPlu = 0>
	<cfif #GetTransferFromOtherPluToThisPlu.RecordCount# GT 0>
		<cfif #isnumeric(GetTransferFromOtherPluToThisPlu.STeansferQty)#>
			<cfset dblQtyTransferedToThisPlu = #GetTransferFromOtherPluToThisPlu.STeansferQty#>
		</cfif>
	</cfif>
	
			
<cfset strPageTitle = "#GetStoreDetail.StoreName# Inventory Control">

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
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenuInventoryDeA.cfm?PN=#strPartNo#&SID=#lngStoreID#&FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>	
    </td>
  </tr>
  <tr valign="center"> 
 	<td colspan="3"> 
      <h1><cfoutput> #mid(strMD,7,2)#/#mid(strMD,5,2)#/#mid(strMD,1,4)#</CFOUTPUT></h1>
    </td>
  </tr>
</table>
<br>
<br>

<table align="center" width="90%" border="0">
  <tr>
    <td>
      <div align="center">

<cfset TotalQty = 0>
<cfset TotalAmount = 0>
	  
<table width="60%" border="1" cellspacing="0" cellpadding="0">
  <cfoutput>
  <tr> 
    <td><div align="left"><font size="2"><b>PLU</b></font></div></td>
    <td><div align="center"><font size="2"><b>#GetPlu.PartNo#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Description</b></font></div></td>
    <td><div align="left"><font size="2"><b>#GetPlu.Description#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Date</b></font></div></td>
	
	<cfset DisplayDate = mid(GetPlu.DDate,1,2) & "/" & mid(GetPlu.DDate,3,2) & "/" & mid(GetPlu.DDate,5,4)>
    <td><div align="right"><font size="2"><b>#DisplayDate#</b></font></div></td>
<!---     <td><div align="left"><font size="2"><b>#GetPlu.DDate#</b></font></div></td>
 --->
 
   </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Starting Stock</b></font></div></td>
	<cfif #isnumeric(StartingStock)#>
    	<td><div align="right"><font size="2"><b>#numberformat(StartingStock,"_______.000")#</b></font></div></td>
	<cfelse>
	    <td><div align="right"><font size="2"><b>#StartingStock#</b></font></div></td>
	</cfif>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Qty Purchased</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblPurchases,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Qty Sold</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblQtySold,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>KG Sold</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblKgSold,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Qty Wasted</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblQtyWasted,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Transfered to other PLU</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblQtyTransferedToOtherPlu,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Transfered to this PLU</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(dblQtyTransferedToThisPlu,"_______.000")#</b></font></div></td>
  </tr>
  
  <!--- 
	Qty Before Count =	B4_QtyOnHand
	Discrepancy Qty	= AF_QtyOnHand  - B4_QtyOnHand
	Discrepancy Value =	Discrepancy Qty * Wholesale
 --->
  <tr> 
    <td><div align="left"><font size="2"><b>Qty before count/ComputerStock</b></font></div></td>
	<cfif #isnumeric(ClosingStock)#>
    	<td><div align="right"><font size="2"><b>#numberformat(ClosingStock - GetPlu.QtyDiscrepancy,"_______.000")#</b></font></div></td>
	<cfelse>
	    <td><div align="right"><font size="2"><b>#ClosingStock#</b></font></div></td>
	</cfif>
  </tr>

  <tr> 
    <td><div align="left"><font size="2"><b>Qty after count/Physical Stock</b></font></div></td>
	<cfif #isnumeric(ClosingStock)#>
    	<td><div align="right"><font size="2"><b>#numberformat(ClosingStock,"_______.000")#</b></font></div></td>
	<cfelse>
	    <td><div align="right"><font size="2"><b>#ClosingStock#</b></font></div></td>
	</cfif>
  </tr>
  
  
  <tr> 
    <td><div align="left"><font size="2"><b>Qty Discrepancy</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(GetPlu.QtyDiscrepancy,"_______.000")#</b></font></div></td>
  </tr>
  <tr> 
    <td><div align="left"><font size="2"><b>Value Discrepancy</b></font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(GetPlu.ValDiscrepancy,"_______.00")#</b></font></div></td>
  </tr>
  
  
</cfoutput>	
</table>
	  </div>
    </td>
  </tr>
</table>
	<cfset dbtTime2 = #gettickcount()#>
	<cfset dbtTime3 = #dbtTime2# - #dbtTime1#>
	<!--- <cfoutput>Time taken: #dbtTime3#</cfoutput> --->
</body>
</HTML>

