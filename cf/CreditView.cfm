
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

<cfset lngCreditDetID = #URL.ID#>
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
      <div align="center"><cfoutput><INPUT type="text"  name="PageHeader" size="10" value ="#strPageTitle#" ></cfoutput></div>
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
      <div align="center">&nbsp;
	  
	<cfset strQuery = "SELECT tbCreditDetail.CreditDetID, tbCreditDetail.Status, tblStores.StoreName, tblOrderInvoiceHeader.InvoiceID, tblOrderInvoiceHeader.InvoiceDate, tbCreditDetail.PartNo, tbCreditDetail.Description, tbCreditDetail.QtySupplied, tbCreditDetail.Reason ">
	<cfset strQuery = strQuery & "FROM (tbCreditDetail INNER JOIN tblStores ON tbCreditDetail.StoreID = tblStores.StoreID) INNER JOIN tblOrderInvoiceHeader ON (tblStores.StoreID = tblOrderInvoiceHeader.StoreID) AND (tbCreditDetail.InvoiceID = tblOrderInvoiceHeader.InvoiceID) ">
	<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.CreditDetID)=#lngCreditDetID#))">

	<CFQUERY name="GetLines" datasource="#application.dsn#" > 	
	<!--- <CFQUERY name="GetLines" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
<table width="100%" border="1" cellspacing="0">
  <tr> 
    <td><b><font size="2">Store</font></b></td>
    <td><b><font size="2">Invoice </font></b></td>
    <td><b><font size="2">Invoice Date</font></b></td>
    <td><b><font size="2">Plu</font></b></td>
    <td><b><font size="2">Description</font></b></td>
    <td><b><font size="2">Quantity</font></b></td>
    <td><b><font size="2">Reason</font></b></td>
  </tr>
  <cfoutput query = "GetLines">
  <tr> 
    <td><font size="2">#GetLines.StoreName#&nbsp;</font></td>
    <td><font size="2">#GetLines.InvoiceID#&nbsp;</font></td>
    <td><font size="2">#GetLines.InvoiceDate#&nbsp;</font></td>
    <td><font size="2">#GetLines.PartNo#&nbsp;</font></td>
    <td><font size="2">#GetLines.Description#&nbsp;</font></td>
    <td> 
      <div align="center"><font size="2">#GetLines.QtySupplied#&nbsp;</font></div>
    </td>
    <td><font size="2">#GetLines.Reason#&nbsp;</font></td>
  </tr>
  </cfoutput>  
</table>
<p>&nbsp;</p>
<form method="post" action="CreditViewAction.cfm">
<cfoutput>
<INPUT type="hidden" name="CreditDetID" value = "#lngCreditDetID#">
<INPUT type="hidden" name="EmployeeName" value = "#session.empfullname#">
</cfoutput>
<table width="500" border="0" cellspacing="0">
  <tr> 
    <td width="100">Comment</td>
    <td colspan="2"><div align="center"><textarea name="Comment" rows="5" cols="35"></textarea></div>
  		            <INPUT type="hidden" name="Comment_required"> 
	</td>
  </tr>
  <tr>
  	<td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td><div align="right"><INPUT type=submit value="  Approve  " name="btnApprove"></div>
	</td>
    <td><div align="left"><INPUT type=submit value="  Reject  " name="btnReject"></div>
	</td>
  </tr>
</table>
</form>	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

