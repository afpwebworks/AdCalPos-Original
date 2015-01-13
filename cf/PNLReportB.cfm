
<cfset strPageTitle = "PageTitle View">

<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->

<!--- Initialise variable--->
<!---  Daily ECR totals --->
<cfset dblCashDay1 = 0>
<cfset dblCreditDay1 = 0>
<cfset dblCustomersDay1 = 0>
<cfset dblAveSaleDay1 = 0>
<cfset dblGSTDay1 = 0>
<cfset dblVoidDay1 = 0>
<cfset dblDiscountDay1 = 0>
<cfset dblGrossDay1 = 0>

<!--- Total of all days ECR Totals --->
<cfset dblCashTotal = 0>
<cfset dblCreditTotal = 0>
<cfset dblCustomersTotal = 0>
<cfset dblAveSaleTotal = 0>
<cfset dblGSTTotal = 0>
<cfset dblVoidTotal = 0>
<cfset dblDiscountTotal = 0>
<cfset dblGrossTotal = 0>

<!--- Weekly Other Totals --->
<cfset dblPurchasesTotal = 0>
<cfset dblStartStockTotal = 0>		<!--- stock hist start of day --->
<cfset dblClosingStockTotal = 0>	<!--- calculated --->

<cfset dblComputerStockTotal = 0>	<!--- stock hist end of day --->

<cfset dblGrossProfitD = 0>
<cfset dblGPPercent = 0>

<cfset dblPayroll = 0>
<cfset dblPayrollPercent = 0>

<cfset dblExpense1 = 0>
<cfset dblExpense2 = 0>
<cfset dblExpense3 = 0>
<cfset dblExpense4 = 0>
<cfset dblExpense5 = 0>
<cfset dblExpense6 = 0>
<cfset dblExpense7 = 0>
<cfset dblExpense8 = 0>
<cfset dblExpense9 = 0>
<cfset dblExpense11 = 0>
<cfset dblExpense12 = 0>
<cfset dblExpense13 = 0>
<cfset dblExpense14 = 0>
<cfset dblExpense15 = 0>
<cfset dblExpense16 = 0>
<cfset dblExpense17 = 0>
<cfset dblExpense18 = 0>
<cfset dblExpense19 = 0>
<cfset dblExpense20 = 0>

<cfset dblExpenseTotal = 0>

<!--- End Variable initialisation --->


<cfset strDate = "08032003">
<cfset lngStoreID = 1>

<cfset strDate = "08032003">

<cfset strDate1 = "08032003">

<!--- Get the ECR TABLE data --->
<cfset strQuery = "SELECT tblStore_ECRTotals.StoreID, ".
<cfset strQuery = strQuery & "CStr(Format(Day([Date]),'00')) & CStr(Format(Month([Date]),'00')) & CStr(Year([Date])) AS MyDate, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.CashSalesD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.CreditSalesD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.Sales, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.GSTCashSaleD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.GSTCreditSaleD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.CashRefundD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.CreditRefundD, ">
<cfset strQuery = strQuery & "tblStore_ECRTotals.DiscountD ">
<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
<cfset strQuery = strQuery & "WHERE (((tblStore_ECRTotals.StoreID)=#lngStoreID#) AND ((CStr(Format(Day([Date]),'00')) & CStr(Format(Month([Date]),'00')) & CStr(Year([Date])))='#strDate1#'))">
<CFQUERY name="GetECRTotalDay1" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>




<cfif #GetECRTotalDay1.RecordCount# GT 0>
	<!--- Daily ECR totals --->
	<cfset dblCashDay1 = #GetECRTotalDay1.CashSalesD#>
	<cfset dblCreditDay1 = #GetECRTotalDay1.CreditSalesD#>
	<cfset dblCustomersDay1 = #GetECRTotalDay1.Sales#>
	<cfset dblGSTDay1 = #GetECRTotalDay1.GSTCashSaleD# +#GetECRTotalDay1.GSTCreditSaleD# >

	<cfset dblVoidDay1 = #GetECRTotalDay1.CashRefundD# + #GetECRTotalDay1.CreditRefundD#>
	<cfset dblDiscountDay1 = #GetECRTotalDay1.DiscountD#>

	<cfset dblGrossDay1 = dblCashDay1 + dblCreditDay1
	<cfset dblAveSaleDay1 = dblGrossDay1/dblCustomersDay1>
</cfif>


<cfset strStoreName = "#GetStoreName.StoreName#">

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
      <div align="right"><a href="tblXXX_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;
	  
	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

