
<cfset strPageTitle = "Pay">

<cfset lngSID = #URL.SID#>
<Cfset strWE = #URL.WE#>
<cfif #len(strWE)# LT 8>
	<cfset strWE = "0" & "#strWE#">
</cfif>
<cfset lngWID = #URL.WID#>

<cfset strQuery = "SELECT * from qryEmpHoursAB18 ">
<cfset strQuery = strQuery & "WHERE qryEmpHoursAB18.WageID = #lngWID#">
<CFQUERY name="GetData" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
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
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="PayrollSelectReportPage.cfm?SID=#lngSID#&WE=#strWE#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>	
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="PayrollSelectPayAction.cfm" method="post">

<cfoutput>
	<INPUT TYPE="hidden" NAME="SID" VALUE="#lngSID#">
	<INPUT TYPE="hidden" NAME="WE" VALUE="#strWE#">
	<INPUT TYPE="hidden" NAME="WID" VALUE="#lngWID#">	
	<cfif #GetData.RecordCount# GT 0>
		<INPUT TYPE="hidden" NAME="EmployeeID" VALUE="#GetData.EmployeeID#">	
	</cfif>
</cfoutput>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
		<cfoutput query = "GetData">
        <table width="80%" border="1">
			<tr>
				<td>Week Ending:</td>
				<td>#mid(GetData.WeekEnding,1,2)#/#mid(GetData.WeekEnding,3,2)#/#mid(GetData.WeekEnding,5,4)#&nbsp;</td>
			</tr>
			<tr>
				<td>Name:</td>
				<td>#GetData.FullName#&nbsp;</td>
			</tr>
			<tr>
				<td>Net Pay:</td>
				<td>#numberformat(GetData.NettPay,"_____.00")#&nbsp;</td>
			</tr>
			<tr>
				<td>Payment Method:</td>
				<td>
				  <select name="cmbPaymentMethod">
				  		<option value="CHQ" selected>Cheque</option>
    					<option value="DD">Direct Deposit</option>
					    <option value="CSH">Cash</option>
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
	    <p><input type="submit" name="Pay" value=" Pay "></p>
	    <p>&nbsp;</p>
	    </cfoutput>
	  </div>
    </td>
  </tr>
</table>
</form>
</body>
</HTML>

