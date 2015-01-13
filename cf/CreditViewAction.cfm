
<cfset lngCreditDetID = #Form.CreditDetID#>
<cfset strComment = "#Form.Comment#">
<cfset strEmployee = "#Form.EmployeeName#">

<cfset strPageTitle = "Credits">

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
      <div align="center"><cfoutput><h1>#strPageTitle#</h1></cfoutput></div>
    </td>
    <td width="25%"> 
      <div align="right"><a href="CreditList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<CFIF ParameterExists(Form.btnApprove)>
	<!--- Make sure that the line has not been applied already --->
	<cfset strQuery = "SELECT tbCreditDetail.CreditDetID, tbCreditDetail.Status ">
	<cfset strQuery = strQuery & "FROM tbCreditDetail ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)=#lngCreditDetID#) AND ((tbCreditDetail.Status)='Rejected' Or (tbCreditDetail.Status)='Approved'))">
	<CFQUERY name="CheckForAlreadyApproved" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="CheckForAlreadyApproved" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfif #CheckForAlreadyApproved.RecordCount# GT 0>
		<p><h3>This credit has alredy been approved / rejected and it can not be applied again.</h3></p>
		<cfabort>
	</cfif>

	<cfset strQuery = "UPDATE tbCreditDetail SET tbCreditDetail.Status = 'Approved', tbCreditDetail.ActionedBy = '#strEmployee#', tbCreditDetail.ActionedDate = replace(str(datepart(dd, getdate()),2),' ','0') + replace(str(datepart(mm, getdate()),2),' ','0') + str(datepart(yyyy, getdate()),4) , tbCreditDetail.ActionedComment = '#strComment#' ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)= #lngCreditDetID# ))">
    
	<CFQUERY name="SaveApproved" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="SaveApproved" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Adjust the stock levels --->
	<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = [QtyOnHand]-[QtySupplied] ">
	<cfset strQuery = strQuery & "From tblStockLocation, tbCreditDetail ">
	<cfset strQuery = strQuery & "WHERE (tbCreditDetail.StoreID = tblStockLocation.StoreID) AND (tbCreditDetail.PartNo = tblStockLocation.PartNo) AND (tbCreditDetail.CreditDetID=#lngCreditDetID#) AND (tbCreditDetail.Status='Approved') AND (tbCreditDetail.StockLevelAdjusted=0)">
	<!--- <cfset strQuery = "UPDATE tbCreditDetail INNER JOIN tblStockLocation ON (tbCreditDetail.PartNo = tblStockLocation.PartNo) AND (tbCreditDetail.StoreID = tblStockLocation.StoreID) SET tblStockLocation.QtyOnHand = [QtyOnHand]-[QtySupplied], tbCreditDetail.StockLevelAdjusted = Yes "> --->
	<!--- <cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)=#lngCreditDetID#) AND ((tbCreditDetail.Status)='Approved') AND ((tbCreditDetail.StockLevelAdjusted)=No))"> --->
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
	<CFQUERY name="AdjustStockLevel" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="AdjustStockLevel" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "UPDATE tbCreditDetail SET tbCreditDetail.StockLevelAdjusted = 1 ">
	<cfset strQuery = strQuery & "From tblStockLocation, tbCreditDetail ">
	<cfset strQuery = strQuery & "WHERE (tbCreditDetail.StoreID = tblStockLocation.StoreID) AND (tbCreditDetail.PartNo = tblStockLocation.PartNo) AND (tbCreditDetail.CreditDetID=#lngCreditDetID#) AND (tbCreditDetail.Status='Approved') AND (tbCreditDetail.StockLevelAdjusted=0)">
	<CFQUERY name="AdjustStockLevelB" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	
	<!--- Add the credited line to the invoice with the negative qty supplied --->
	<cfset strQuery = "INSERT INTO tblOrderInvoiceDetail ( InvoiceID, OrderDetID, StoreID, OrderDate, PartNo, Description, Invoiced, OrderID, QtyOrdered, QtySupplied, OrderingUnit, SupplyUnit, PrepCode, MaxRetailExGST, SCtoStoreUnitPriceExG, SCRebateUnitExG, THRebateUnitExG, Ratio, CostExG, PluType, TCode, PCode, RCode, ThreeHRebate, SCRebate, Credited, CreditAccepted ) ">
	<cfset strQuery = strQuery & "SELECT tbCreditDetail.InvoiceID, tbCreditDetail.OrderDetID, tbCreditDetail.StoreID, tbCreditDetail.OrderDate, tbCreditDetail.PartNo, tbCreditDetail.Description, tbCreditDetail.Invoiced, tbCreditDetail.OrderID, tbCreditDetail.QtyOrdered, -1*[QtySupplied] AS QS, tbCreditDetail.OrderingUnit, tbCreditDetail.SupplyUnit, tbCreditDetail.PrepCode, tbCreditDetail.MaxRetailExGST, tbCreditDetail.SCtoStoreUnitPriceExG, tbCreditDetail.SCRebateUnitExG, tbCreditDetail.THRebateUnitExG, tbCreditDetail.Ratio, tbCreditDetail.CostExG, tbCreditDetail.PluType, tbCreditDetail.TCode, tbCreditDetail.PCode, tbCreditDetail.RCode, tbCreditDetail.ThreeHRebate, tbCreditDetail.SCRebate, 1 AS Credited, 1 AS CreditAccepted ">
	<cfset strQuery = strQuery & "FROM tbCreditDetail ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)=#lngCreditDetID#) AND ((tbCreditDetail.Status)='Approved'))">
	<CFQUERY name="AddNegativeValueToInvoice" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="AddNegativeValueToInvoice" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<h2>Credit Approved</h2>
	
<cfelseif ParameterExists(Form.btnReject)>
	<!--- Make sure that the line has not been applied already --->
	<cfset strQuery = "SELECT tbCreditDetail.CreditDetID, tbCreditDetail.Status ">
	<cfset strQuery = strQuery & "FROM tbCreditDetail ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)=#lngCreditDetID#) AND ((tbCreditDetail.Status)='Rejected' Or (tbCreditDetail.Status)='Approved'))">
	<CFQUERY name="CheckForAlreadyRejected" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="CheckForAlreadyRejected" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfif #CheckForAlreadyRejected.RecordCount# GT 0>
		<p><h3>This credit has alredy been approved / rejected and it can not be applied again.</h3></p>
		<cfabort>
	</cfif>

	<cfset strQuery = "UPDATE tbCreditDetail SET tbCreditDetail.Status = 'Rejected', tbCreditDetail.ActionedBy = '#strEmployee#', tbCreditDetail.ActionedDate = replace(str(datepart(dd, getdate()),2),' ','0') + replace(str(datepart(mm, getdate()),2),' ','0') + str(datepart(dd, getdate()),4) , tbCreditDetail.ActionedComment = '#strComment#' ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)= #lngCreditDetID# ))">
	<CFQUERY name="SaveRejected" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="SaveRejected" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<h2>Rejected Credit</h2>
</cfif>

<p>&nbsp;</p>

	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

