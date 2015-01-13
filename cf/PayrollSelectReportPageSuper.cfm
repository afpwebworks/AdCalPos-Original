
<cfset strPageTitle = "Super Summary">

<cfset lngSID = #URL.SID#>
<Cfset strDF = #URL.DF#>
<cfif #len(strDF)# LT 8>
	<cfset strDF = "0" & "#strDF#">
</cfif>

<Cfset strDT = #URL.DT#>
<cfif #len(strDT)# LT 8>
	<cfset strDT = "0" & "#strDT#">
</cfif>
<cfset strDFSort = "#mid(strDF,5,4)#" & "#mid(strDF,3,2)#" & "#mid(strDF,1,2)#">
<cfset strDTSort = "#mid(strDT,5,4)#" & "#mid(strDT,3,2)#" & "#mid(strDT,1,2)#">

<cfset strQuery = "SELECT tblEmpPayRollPaid.StoreID, 10000*substring([WeekEnding],5,4)+100*substring([WeekEnding],3,2)+substring([WeekEnding],1,2) AS WE, substring([WeekEnding],1,2) + '/' + substring([WeekEnding],3,2) + '/' + substring([WeekEnding],5,4) AS WeekEndingString, tblEmpPayRollPaid.WeekEnding, [GivenName] + ' ' + [Surname] AS FullName, tblEmpPayRollPaid.SuperAccumulated ">
<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.StoreID)=#lngSID#) AND ((10000*substring([WeekEnding],5,4)+100*substring([WeekEnding],3,2)+substring([WeekEnding],1,2)) Between #strDFSort# And #strDTSort#) AND ((tblEmpPayRollPaid.SuperPaidDate)='' Or (tblEmpPayRollPaid.SuperPaidDate) Is Null)) ">
<cfset strQuery = strQuery & "ORDER BY 10000*substring([WeekEnding],5,4)+100*substring([WeekEnding],3,2)+substring([WeekEnding],1,2), [GivenName] + ' ' + [Surname]">
<CFQUERY name="GetData" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT Sum(tblEmpPayRollPaid.SuperAccumulated) AS SuperAccumulated ">
<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.StoreID)=#lngSID#) AND ((10000*substring([WeekEnding],5,4)+100*substring([WeekEnding],3,2)+substring([WeekEnding],1,2)) Between #strDFSort# And #strDTSort#) AND ((tblEmpPayRollPaid.SuperPaidDate)='' Or (tblEmpPayRollPaid.SuperPaidDate) Is Null))">
<CFQUERY name="GetTotalData" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetTotalData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngStoreID = #lngSID#>
	<cfset strQuery = "SELECT tblStores.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores ">
	<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngStoreID#">
	<CFQUERY name="GetStore" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strStoreName = #GetStore.StoreName#>

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
      <h1><cfoutput>#strPageTitle# for #strStoreName#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="Payroll.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="90%" border="1" cellspacing="0">
  <tr> 
    <td> 
      <div align="center"><font size="2"><b>Week Ending</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>Name</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>Super</b></font></div>
    </td>
  </tr>
  <cfoutput query ="GetData">
  <tr> 
    <td><div align="left"><font size="2"><b>#GetData.WeekEndingString#&nbsp;</b></font></div></td>
    <td><div align="left"><font size="2"><b>#GetData.FullName#&nbsp;</b></font></div></td>
    <td><div align="right"><font size="2">#numberformat(GetData.SuperAccumulated,"_____.00")#&nbsp;</font></div></td>
  </tr>
  </cfoutput>
  <cfoutput query ="GetTotalData"><tr> 
    <td colspan="2" align="left"><font size="2"><b>Total</b></font></td>
    <td><div align="right"><font size="2"><b>#numberformat(GetTotalData.SuperAccumulated,"_____.00")#</b>&nbsp;</font></div></td>
  </tr></cfoutput>
</table>
<br>
<cfif #GetData.RecordCount# GT 0>
	<FORM action="PayrollSelectReportPageSuperAction.cfm" method="post">
	<cfoutput>
		<INPUT TYPE="hidden" NAME="SID" VALUE="#lngSID#">
		<INPUT TYPE="hidden" NAME="strDF" VALUE="#strDF#">
		<INPUT TYPE="hidden" NAME="strDT" VALUE="#strDT#">
		<INPUT TYPE="hidden" NAME="strDFSort" VALUE="#strDFSort#">
		<INPUT TYPE="hidden" NAME="strDTSort" VALUE="#strDTSort#">
		<INPUT TYPE="hidden" NAME="dblSuper" VALUE="#numberformat(GetTotalData.SuperAccumulated,"_____.00")#">		
	</cfoutput>

        <table width="90%" border="1">
			<tr>
				<td>Payment Method:</td>
				<td>
				  <select name="cmbPaymentMethod">
				  		<option value="CHQ" selected>Cheque</option>
    					<option value="DD">Direct Deposit</option>
				  </select>
				</td>
			</tr>
			<tr>
				<td>Refrence Number:</td>
				<td>
					<input type="text" name="RefNumber" size="30" maxlength="20">
					<INPUT TYPE="hidden" NAME="RefNumber_required" VALUE="Please type the reference number.">
				</td>
			</tr>
        </table>
	    <p><input type="submit" name="Pay" value=" Save Payment "></p>
	    <p>&nbsp;</p>
	</form>
</cfif>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

