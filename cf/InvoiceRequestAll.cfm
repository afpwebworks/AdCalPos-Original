
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

<cfset lngIID = 0 >
<CFIF ParameterExists(URL.IID)>
	<cfset lngIID = #URL.IID#>
</cfif>	

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Invoice Request</TITLE>
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
      <h1>Invoice Request</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	 
	  
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

<cfset lngUserType = #session.user.getUserType()# >
<cfset lngStoreID = #session.storeid#>

<cfif lngUserType LT 6 > 
	   <!--- Get the store names --->
	<cfset strQuery = "SELECT qryInvoiceHeaders.InvoiceID, qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber, qryInvoiceHeaders.InvoiceDate, [StoreName] + '  ( ' + [InvoiceDate] + ' )  Invoice number: ' + convert(varchar,[InvoiceID]) AS Description ">
	<cfset strQuery = strQuery & "FROM qryInvoiceHeaders ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceHeaders.InvoiceID, qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber, qryInvoiceHeaders.InvoiceDate, [StoreName] + '  ( ' + [InvoiceDate] + ' )  Invoice number: ' + convert(varchar,[InvoiceID]) ">
	<cfset strQuery = strQuery & "ORDER BY qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber DESC, qryInvoiceHeaders.InvoiceID DESC">
<cfelse>
	   <!--- Get the store names --->
	<cfset strQuery = "SELECT qryInvoiceHeaders.InvoiceID, qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber, qryInvoiceHeaders.InvoiceDate, [StoreName] + '  ( ' + [InvoiceDate] + ' )  Invoice number: ' + convert(varchar,[InvoiceID]) AS Description ">
	<cfset strQuery = strQuery & "FROM qryInvoiceHeaders ">
	<cfset strQuery = strQuery & "WHERE (qryInvoiceHeaders.StoreID = #lngStoreID#) ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceHeaders.InvoiceID, qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber, qryInvoiceHeaders.InvoiceDate, [StoreName] + '  ( ' + [InvoiceDate] + ' )  Invoice number: ' + convert(varchar,[InvoiceID]) ">
	<cfset strQuery = strQuery & "ORDER BY qryInvoiceHeaders.StoreName, qryInvoiceHeaders.InvoiceDateNumber DESC, qryInvoiceHeaders.InvoiceID DESC">
</cfif>
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStores"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<FORM action="InvoiceLayout.cfm" method="post">
          <table width="282" border="0">
            <tr> 
              <td width="109"> 
                <h3>Invoice</h3></td>
              <td width="163"> 
   				<select name="selInvoiceID">
			  	<cfoutput query ="GetStores"> 
				      <cfif #lngIID# EQ #GetStores.InvoiceID#>
						  <option value="#GetStores.InvoiceID#" selected>#GetStores.Description#</option>
					  <cfelse>				  
						  <option value="#GetStores.InvoiceID#">#GetStores.Description#</option>
					  </cfif>
				</cfoutput>
				</select>			  
		      </td>
			</tr>
		 </table>
<p></P>
<input type="submit" name="Submit" value=" Show Invoice ">
<cfif #session.user.getUserType()# LTE 5>
	<input type="submit" name="Submit3H" value=" Show Sup Invoice ">
	<input type="submit" name="SubmitRebate" value=" Show Margin Report ">
</cfif> 
</Form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

