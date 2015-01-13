
<cfset strPageTitle = "Payment Application (3 / 3)">

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

<CFIF ParameterExists(URL.lngStoreID)>
	<cfset lngStoreID = #URL.lngStoreID#>
<cfelse>
	<cfset lngStoreID = #Form.lngStoreID#>
</cfif>

<CFIF ParameterExists(URL.lngPymentID)>
	<cfset lngPymentID = #URL.lngPymentID#>
<cfelse>
	<cfset lngPymentID = #Form.PymentID#>
</cfif>

<!--- Write a query to select the payemnt --->
<cfset strQuery = "SELECT * from qryPayment ">
<cfset strQuery = strQuery & "WHERE PymentID=#lngPymentID#">

<CFQUERY name="GetPayment" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetPayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Write a query to select the invoices --->
<cfset strQuery = "SELECT * FROM qryInvoiceDetailTotalPayApplication ">
<cfset strQuery = strQuery & "WHERE (((StoreID)=#lngStoreID#) AND ((AmountRemaining)>0.001) AND ((FullyApplied)=0)) ">
<cfset strQuery = strQuery & "Order by (substring(InvoiceDate,5,4) + substring(InvoiceDate,3,2) + substring(InvoiceDate,1,2) )">
<CFQUERY name="GetItems" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetItems" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Get the app;lication summary --->
<cfset strQuery = "SELECT tblPaymentApplication.ApplicationID, tblPaymentApplication.StoreID, tblPaymentApplication.PymentID, tblPaymentApplication.ApplicationDate , tblPaymentApplication.AmountApplied,substring([ApplicationDate],1,2) + '/' + substring([ApplicationDate],3,2) + '/' + substring([ApplicationDate],5,4)  as ApplicationDateFormatted , tblPaymentApplication.InvoiceID ">
<cfset strQuery = strQuery & "FROM tblPaymentApplication ">
<cfset strQuery = strQuery & "WHERE (((tblPaymentApplication.StoreID)=#lngStoreID#) AND ((tblPaymentApplication.PymentID)=#lngPymentID#))">
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="GetAppliedPayments" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetAppliedPayments" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfif #GetPayment.RecordCount# GT 0>
	<cfset dblPaymentValue = #GetPayment.Value#>
<cfelse>
	<cfset dblPaymentValue = 0>
</cfif>

<cfset lngNumItems = 1 + #GetItems.RecordCount#>

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
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="Payment_App.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>

<cfif #GetItems.recordcount# LT 1>
	<p><h3>There are no invoices to be paid.</h3></p>
	</body>
	</HTML>
	<cfabort>
</cfif>
<cfoutput>
<table width="100%" border="1">
  <tr>
    <td>
      <div align="left">
		<table width="50%" border="0" cellspacing="0">
		  <tr> 
		    <td width="38%">Payment ID:</td>
		    <td width="62%">#lngPymentID#</td>
		  </tr>
		  <tr> 
		    <td width="38%">Date:</td>
		    <td width="62%">#GetPayment.PaymentDate#</td>
		  </tr>
		  <tr> 
		    <td width="38%">Amount Not Applied:</td>
		    <td width="62%"><h2>#NumberFormat(dblPaymentValue,"$9999999.00")#</h2></td>
		  </tr>
		</table>
	  </div>
    </td>
  </tr>
</table>
</cfoutput>
<FORM action="Payment_AppD.cfm" method="post">
<cfoutput>
<input type="hidden" name="lngStoreID" value="#lngStoreID#">		
<input type="hidden" name="lngPymentID" value="#lngPymentID#">		
</cfoutput>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="515" border="1">
  <tr> 
    <td colspan="4"> 
      <div align="center"><b>Invoices</b></div>
    </td>
  </tr>
  <tr> 
    <td width="86"> 
      <div align="right"><b>&nbsp;</b></div>
    </td>
    <td width="112"> 
      <div align="center"><b>Invoice ID</b></div>
    </td>
    <td width="131"> 
      <div align="center"><b>Date</b></div>
    </td>
    <td width="168"> 
      <div align="right"><b>Amount Outstanding</b></div>
    </td>
  </tr>
  <cfoutput query ="GetItems">
  <tr> 
    <td width="86"><a href="Payment_AppD.cfm?adj=0&sid=#lngStoreID#&pid=#lngPymentID#&iid=#GetItems.InvoiceID#"><h3>Apply</h3></a></td>
    <td width="112"> 
      <div align="center">#GetItems.InvoiceID#</div>
    </td>
    <td width="131"> 
      <div align="center">#GetItems.InvoiceDateFormatted#</div>
    </td>
    <td width="168"> 
      <div align="right">#NumberFormat(GetItems.AmountRemaining,"$9999999.00")#</div>
    </td>
  </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>	  

<cfif #GetAppliedPayments.recordCount# GT 0>
<table width="515" border="1">
  <tr> 
    <td colspan="4"> 
      <div align="center"><b>Application Summary</b></div>
    </td>
  </tr>
  <tr> 
    <td width="86"> 
      <div align="right"><b>&nbsp;</b></div>
    </td>
    <td width="112"> 
      <div align="center"><b>Invoice ID</b></div>
    </td>
    <td width="131"> 
      <div align="center"><b>Date</b></div>
    </td>
    <td width="168"> 
      <div align="right"><b>Amount Applied</b></div>
    </td>
  </tr>
  <cfoutput query ="GetAppliedPayments">
  <tr> 
    <td width="86"><a href="Payment_AppD.cfm?adj=1&sid=#lngStoreID#&pid=#lngPymentID#&aid=#GetAppliedPayments.ApplicationID#"><h3>Remove</h3></a></td>
    <td width="112"> 
      <div align="center">#GetAppliedPayments.InvoiceID#</div>
    </td>
    <td width="131"> 
      <div align="center">#GetAppliedPayments.ApplicationDateFormatted#</div>
    </td>
    <td width="168"> 
      <div align="right">#NumberFormat(GetAppliedPayments.AmountApplied,"$9999999.00")#</div>
    </td>
  </tr>
  </cfoutput>
</table>
</cfif>
	  
	  <p>&nbsp;</p>
	  </form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

