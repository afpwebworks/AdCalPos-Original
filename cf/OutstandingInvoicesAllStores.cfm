
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

<cfset lngStoreID = #URL.SID#>

<cfset strPageTitle = "Outstanding Invoices">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
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
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
  <tr> 
 	<td colspan="3"> 
      <div align="center"><h3><cfoutput>#strStoreName#</cfoutput></h3></div>
    </td>
  </tr>
</table>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="0">
          <tr> 
            <td><div align="center"><h4>Invoice No</h4></div></td>
            <td><div align="center"><h4>Date</h4></div></td>
            <td><div align="center"><h4>Amount</div></h4></td>
            <td><div align="center"><h4>Paid</div></h4></td>
            <td><div align="center"><h4>Outstanding</h4></div></td>
          </tr>


		<!--- get the lines --->
		<cfset strQuery = "SELECT qryInvoiceDetailTotalPayApplication.InvoiceID, qryInvoiceDetailTotalPayApplication.StoreID, qryInvoiceDetailTotalPayApplication.InvoiceDate, qryInvoiceDetailTotalPayApplication.GrandTotalIncGST, qryInvoiceDetailTotalPayApplication.AmountRemaining, qryInvoiceDetailTotalPayApplication.AmountApplied, qryInvoiceDetailTotalPayApplication.InvoiceDateFormatted ">
		<cfset strQuery = strQuery & "FROM qryInvoiceDetailTotalPayApplication ">
		<cfset strQuery = strQuery & "WHERE (qryInvoiceDetailTotalPayApplication.StoreID = #lngStoreID#) and (FullyApplied = 0)">
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset strQuery = "SELECT * from qryInvoiceDetailTotalPayApplication_GrandTotal ">
		<cfset strQuery = strQuery & "WHERE (((qryInvoiceDetailTotalPayApplication_GrandTotal.StoreID)=#lngStoreID#))">
		<CFQUERY name="GetTotal" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetTotal" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
  <cfoutput query = "GetRecord">
          <tr> 
            <td><h4>#GetRecord.InvoiceID#&nbsp;</h4></td>
            <td><h4>#GetRecord.InvoiceDateFormatted#&nbsp;</h4></td>
            <td><div align="right"><h4>#numberformat(GetRecord.GrandTotalIncGST,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.AmountApplied,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.AmountRemaining,"_____.00")#&nbsp;</h4></div></td>
          </tr>
  </cfoutput>
          <tr> 
            <td colspan="4"><h3>Grand Total</h3></td>
			<cfoutput>
            <td><div align="right"><h3>#numberformat(GetTotal.GT_AmountRemaining,"_____.00")#&nbsp;</h3></div></td>
			</cfoutput>
          </tr>

        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>

