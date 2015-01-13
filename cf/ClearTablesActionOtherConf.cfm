
<cfset lngStoreID = #Form.lngStoreID#>
<cfset strString = #Form.strString#>

<cfif strString EQ "All">
	<cfset strStringMessage = "">
<cfelse>
	<cfset strStringMessage = "#strString#">
</cfif>	

<cfif isdefined("Form.CancelTask")>
	<cfoutput>
	<CFLOCATION url="ClearTablesOther.cfm?SID=#lngStoreID#">
	</cfoutput>
	<cfabort>
</cfif>

	<cfset strQuery = "SELECT tblStores.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores ">
	<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngStoreID#">
	<CFQUERY name="GetStore" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strStoreName = #GetStore.StoreName#>


<!--- For All button clear the tblStore_ tables --->
<cfif strString EQ "All" >
	<cfset strQuery = "delete from tblStore_CashInDraw where StoreID =  #lngStoreID#">
	<CFQUERY name="UpdateData" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "delete from tblStore_ECRTotals where StoreID =  #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "delete from tblStore_OperatorTotals where StoreID =  #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "delete from tblStore_PLUTotals where StoreID =  #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<!--- In the store clear the initial stocktake flag --->
	<cfset strQuery = "Update tblStores set StartingStockEntered = 0 ">
	<cfset strQuery = strQuery & "from tblStores where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData4" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		

<cfif (strString EQ "All") or (strString EQ "Stock on hand totals")>
	<cfset strQuery = "update tblStockLocation set LastCost = 0, AverageCost = 0, RetailPrice = 0, MaxRetail = 0, QtyOnHand = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<cfset strQuery = "update tblStockLocation set LastCost = tblStockMaster.Wholesale , AverageCost = tblStockMaster.Wholesale, RetailPrice = tblStockMaster.Wholesale, MaxRetail = tblStockMaster.Wholesale , QtyOnHand = 0 ">
	<cfset strQuery = strQuery & "from tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<cfset strQuery = strQuery & "where tblStockLocation.StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataAndSetPrices" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<cfset strQuery = "update tblEodSummary set StartingStockValEx = 0, EndingStockValEx = 0, StockVarianceValEx = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataEOD" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		
<cfif (strString EQ "All") or (strString EQ "Wastage")>
	<cfset strQuery = "update tblStockLocation set Wastage = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblWastageLog where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "update tblEodSummary set EodWasteUpdated = 0, WastageValEx = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataEOD" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		
<cfif (strString EQ "All") or (strString EQ "Transfers")>
	<cfset strQuery = "update tblStockLocation set TeansferQty = 0 , TransferToPlu = null ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblTransferLog where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "update tblEodSummary set EodTransferUpdated = 0, StockVarianceValEx = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataEOD" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		
<cfif (strString EQ "All") or (strString EQ "Stocktakes")>
	<cfset strQuery = "update tblStockLocation set Prev_QtyOnHand = 0, Freezer_QtyOnHand = 0, CoolRoom_QtyOnHand = 0, Display_QtyOnHand = 0  ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblStocktakeLog where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblStocktakeLogVariance where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>
<!--- - wb 06/12/2003 - Orders - --->		
<cfif (strString EQ "All") or (strString EQ "Orders")>
	<cfset strQuery = "update tblEodSummary set PurchaseValEx = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataEOD" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblOrderDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblOrderHeader where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<!--- - wb 06/12/2003 - <cfset strQuery = "Delete from tblOrderInvoiceDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblOrderInvoiceHeader where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData4" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tbCreditDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData5" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblPaymentApplication where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData6" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblPayment where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData7" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY> - --->
</cfif>
<!--- - wb 06/12/2003 - Invoices - --->	
<cfif (strString EQ "All") or (strString EQ "Invoices")>
	<cfset strQuery = "update tblEodSummary set PurchaseValEx = 0 ">
	<cfset strQuery = strQuery & "where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateDataEOD" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<!--- - wb 06/12/2003 - <cfset strQuery = "Delete from tblOrderDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblOrderHeader where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY> --->
	<cfset strQuery = "Delete from tblOrderInvoiceDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblOrderInvoiceHeader where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData4" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tbCreditDetail where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData5" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblPaymentApplication where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData6" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblPayment where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData7" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>	
<cfif (strString EQ "All") or (strString EQ "Expense Transactions")>
	<cfset strQuery = "Delete from tblSupplierTranDet where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		
<cfif (strString EQ "All") or (strString EQ "Rosters")>
	<cfset strQuery = "Delete from tblEmpRoster where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>		
<cfif (strString EQ "All") or (strString EQ "Hours worked")>
	<cfset strQuery = "Delete from tblEmpHoursWorked where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>	
<cfif (strString EQ "All") or (strString EQ "Pay, Tax & Super")>
	<cfset strQuery = "Delete from tblEmpPayRoll where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblEmpPayRollPaid where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblEmpSuperPaid where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblEmpTaxPaid where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData4" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>	
<cfif (strString EQ "All") or (strString EQ "End of day")>
	<cfset strQuery = "Delete from tblEODAutomatedLog where Store = #lngStoreID#">
	<CFQUERY name="UpdateData1" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblEodSummary where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData2" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblStockHistEnding where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData3" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset strQuery = "Delete from tblStockHistStart where StoreID = #lngStoreID#">
	<CFQUERY name="UpdateData4" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfif>	


<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Clear Tables</TITLE>
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
      <cfoutput><h1>Delete Confirmation for #strStoreName#</h1></cfoutput>
    </td>
    <td width="25%"> 
      <cfoutput><div align="right"><a href="ClearTablesOther.cfm?SID=#lngStoreID#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div></cfoutput>
    </td>
  </tr>
</table>
<br>
<br>
<!--- <FORM action="ClearTablesActionOtherConf.cfm" method="post"> --->
<cfoutput>
	<INPUT type="hidden" name="lngStoreID" value="#lngStoreID#">
	<INPUT type="hidden" name="strString" value="#strString#">

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="75%" border="0">
  <tr>
    <td colspan="2">     
	  <div align="center"><h2>Finished clearing all #strStringMessage# information of #strStoreName#</h2>
    </td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr>
    &nbsp;
<!---   
	<td align="center"><input type="submit" name="ProceedWithTask" value="  YES  "></td>
	<td align="center"><input type="submit" name="CancelTask" value="  NO  "></td>
 --->
  </tr>
</table>
	  </div>
    </td>
  </tr>
</table>
</cfoutput>
</Form>
</body>
</HTML>

