
<cfset strPageTitle = "Payslip">

<cfset lngSID = #URL.SID#>
<Cfset strWE = #URL.WE#>
<cfif #len(strWE)# LT 8>
	<cfset strWE = "0" & "#strWE#">
</cfif>

<cfset strQuery = "SELECT qryEmpHoursAB19_Paid.WageID, qryEmpHoursAB19_Paid.StoreID, qryEmpHoursAB19_Paid.WeekEnding, qryEmpHoursAB19_Paid.FullName, * ">
<cfset strQuery = strQuery & "FROM qryEmpHoursAB19_Paid ">
<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAB19_Paid.StoreID)=#lngSID#) AND ((qryEmpHoursAB19_Paid.WeekEnding)='#strWE#')) ">
<cfset strQuery = strQuery & "ORDER BY qryEmpHoursAB19_Paid.FullName">
<CFQUERY name="GetData" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT Sum(qryEmpHoursAB19_Paid.Tax) AS Tax, Sum(qryEmpHoursAB19_Paid.NettPay) AS NettPay ">
<cfset strQuery = strQuery & "FROM qryEmpHoursAB19_Paid ">
<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAB19_Paid.StoreID)=#lngSID#) AND ((qryEmpHoursAB19_Paid.WeekEnding)='#strWE#'))">
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
 	<td align="CENTER"> 
      <h1><cfoutput>#strPageTitle# for #strStoreName#</CFOUTPUT></h1>
	  	  <!--- KF dec 03 --->
         <h2><cfoutput>Week Ending #MID(url.WE,1,2)#/#MID(url.WE,3,2)#/#MID(url.WE,5,4)#</CFOUTPUT></h2>
	  <!--- end --->

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
      <div align="center"><font size="2"><b>Name</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>Pay</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>NOR</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>OT1</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>OT2</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>HOL L</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>HOL</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>SIK</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>BON</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>EXP</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>SHF</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>CAR</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>OTH</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>TAXABL</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>NONTAX</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>Tax</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2"><b>Net</b></font></div>
    </td>
  </tr>
  <CFSET wageIDlist = "">
  <cfoutput query ="GetData">
	  <tr> 
	    <td><div align="left"><font size="2"><b>#GetData.FullName#&nbsp;</b></font></div></td>
	    <cfif #GetData.NettPay# GT 0.0001>
			<td><div align="left"><font size="2"><b><a href="PayrollSelectPayPagePaySlip.cfm?WID=#GetData.WageID#&SID=#lngSID#&WE=#strWE#"><h3>Payslip</h3></a></b></font></div></td>
		<cfelse>
			<td>&nbsp;</td>	
		</cfif>
	    <td><div align="right"><font size="2">#numberformat(GetData.NormalHoursPay,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.OT1Pay,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.OT2Pay,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.HolidayLoadingValue,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.HolidayHrsCanBePaidValue,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.SickHrsCanBePaidValue,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.Bonus,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.Expenses,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.ShiftAllowance,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.CarAllowance,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.OtherAllowance,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.TaxableIncome,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.NonTaxableIncome,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2">#numberformat(GetData.Tax,"_____.00")#&nbsp;</font></div></td>
	    <td><div align="right"><font size="2"><b>#numberformat(GetData.NettPay,"_____.00")#&nbsp;</b></font></div></td>
	  </tr>
    <CFSET wageIDlist = listAppend(wageIDlist,GetData.WageID)>
  </cfoutput>
  <cfoutput query ="GetTotalData">
  <tr> 
    <td colspan="15" align="left"><font size="2"><b>Total</b></font></td>
    <td><div align="right"><font size="2"><b>#numberformat(GetTotalData.Tax,"_____.00")#</b>&nbsp;</font></div></td>
    <td><div align="right"><font size="2"><b>#numberformat(GetTotalData.NettPay,"_____.00")#</b>&nbsp;</font></div></td>
  </tr>
  </cfoutput>
</table>
<br>
<table width="90%" border="0" cellspacing="0">
  <tr> 
    <td colspan="17" align="left"><font size="2"><b>Click on Payslip to see the payslip.</b></font></td>
	<!--- KF amendment dec 03, allow multi printing of pay slips --->
	<CFOUTPUT>	
	 	<td>
		   <FORM name="TEMP" method="POST" action="showAllPayslips.cfm">
		     <INPUT type="hidden" name="wageIDList" value="#wageIDlist#">
			 <INPUT type="hidden" name="SID" value="#lngSID#">
			 <INPUT type="hidden" name="WE" value="#strWE#">
			 <INPUT type="submit" value="Click here to view/print all pay slips">		 
		   </form>	
		</td>
	</cfoutput>
  </tr>
</table>
<br>
<table width="90%" border="0" cellspacing="0">
  <tr> 
    <td width="8%"><b><font size="2">NOR</font></b></td>
    <td width="31%"><font size="2">Normal Pay</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">SHF</font></b></td>
    <td width="42%"><font size="2">Shift Allowance</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">OT1</font></b></td>
    <td width="31%"><font size="2">Overtime 1</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">CAR</font></b></td>
    <td width="42%"><font size="2">Car Allowance</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">OT2</font></b></td>
    <td width="31%"><font size="2">Overtime 2</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">OTH</font></b></td>
    <td width="42%"><font size="2">Other Allowance</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">HOLL</font></b></td>
    <td width="31%"><font size="2">Holiday Loading</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">TAXABL</font></b></td>
    <td width="42%"><font size="2">Taxable Income</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">HOL </font></b></td>
    <td width="31%"><font size="2">Holiday pay (excluding the loading)</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">NONTAX</font></b></td>
    <td width="42%"><font size="2">Non Taxable Income</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">SIK</font></b></td>
    <td width="31%"><font size="2">Sick Pay</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">TAX</font></b></td>
    <td width="42%"><font size="2">Tax</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">BON</font></b></td>
    <td width="31%"><font size="2">Bonus</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%"><b><font size="2">NET</font></b></td>
    <td width="42%"><font size="2">Net Pay</font></td>
  </tr>
  <tr> 
    <td width="8%"><b><font size="2">EXP</font></b></td>
    <td width="31%"><font size="2">Expense</font></td>
    <td width="8%">&nbsp;</td>
    <td width="11%">&nbsp;</td>
    <td width="42%">&nbsp;</td>
  </tr>
</table>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

