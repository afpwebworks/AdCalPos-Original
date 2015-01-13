
<cfset strPageTitle = "Payment Application (2 / 3)">

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

<cfset lngStoreID = #Form.StoreID#>

<!--- Write a query to select the stores that have defined an order --->
<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.PaymentDate, [Amount]-[AmountApplied] AS [Value], 'ID: ' + Str([PymentID]) + '  Date: ' + Str([PaymentDate]) + '  $' + Str([Amount]-[AmountApplied]) AS Description ">
<cfset strQuery = strQuery & "FROM tblPayment ">
<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND (([Amount]-[AmountApplied])>0.001) AND ((tblPayment.FullyApplied)=0))">
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="GetItems" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetItems" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

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
<FORM action="Payment_AppC.cfm" method="post">
<cfoutput>
<input type="hidden" name="lngStoreID" value="#lngStoreID#">		
</cfoutput>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
      <TABLE>
        <TR>				  
          <TD>
            <P align=right>Payment: </P></TD>
          <TD>
			<cfoutput><select name="PymentID"  size="#lngNumItems#"></cfoutput>
				<cfset lngIndex = 0>
				<cfoutput Query = "GetItems">
					<cfset lngIndex = lngIndex + 1>
			    	<cfif lngIndex EQ 1>
						<option value="#GetItems.PymentID#" selected>#GetItems.Description#</option>
					<cfelse>
						<option value="#GetItems.PymentID#">#GetItems.Description#</option>
					</cfif>
				</cfoutput>
			</select>
			<input type="hidden" name="PymentID_integer" value="Please select the payemnt">
			<input type="hidden" name="PymentID_required" value="Please select the payment">		
		  </TD>
		</TR>
		<TR>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		</TR>
		<TR>
    		<td colspan="2"> 
      			<div align="center"><input type="submit" name="Submit" value="  Next  "></div>
    		</td>
		</TR>
	  </TABLE>
	  <p>&nbsp;</p>
	  </form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

