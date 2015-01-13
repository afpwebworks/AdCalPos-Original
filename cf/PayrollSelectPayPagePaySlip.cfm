
<cfset strPageTitle = "Payslip">

<!--- 
  looping thru slips, so taking SID and WE from CFMODULE scope, not URL
<cfset lngSID = #URL.SID#>
<Cfset strWE = #URL.WE#>
<cfset lngWID = #URL.WID#>
 --->
<CFIF isDefined("url.SID")>
  <cfset lngSID = #url.SID#>
  <Cfset strWE = #url.WE#>
  <cfset lngWID = #url.WID#>
<CFELSE>
  <cfset lngSID = #SID#>
  <Cfset strWE = #WE#>
  <cfset lngWID = #WID#>
</cfif> 
 
<cfif #len(strWE)# LT 8>
	<cfset strWE = "0" & "#strWE#">
</cfif>


<cfset strQuery = "SELECT * from qryEmpHoursAB19_Paid ">
<cfset strQuery = strQuery & "WHERE qryEmpHoursAB19_Paid.WageID = #lngWID#">
<CFQUERY name="GetData" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngEmployeeID = #GetData.EmployeeID#>
<cfset lngStoreID = #GetData.StoreID#>
<cfset strWeekEnding = #GetData.WeekEnding#>

<cfset strQuery = "SELECT * from tblStores ">
<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngSID#">
<CFQUERY name="GetStore" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetStore" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Get the employee status --->
<cfset strQuery = "SELECT tblEmpStatus.Status, tblEmpStatus.EmpStatusID ">
<cfset strQuery = strQuery & "FROM tblEmployee INNER JOIN tblEmpStatus ON tblEmployee.EmpStatusID = tblEmpStatus.EmpStatusID ">
<cfset strQuery = strQuery & "WHERE tblEmployee.EmployeeID = #lngEmployeeID#">
<CFQUERY name="GetStatus" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStatus = "">
<cfif #GetStatus.recordcount# GT 0>
	<cfset strStatus = #GetStatus.Status#>
</cfif>

<cfset strQuery = "SELECT * from tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE WageID = #lngWID#">
<CFQUERY name="GetSupData" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset dblSup = 0>
<cfif #GetSupData.recordcount# GT 0>
	<cfset dblSup = #GetSupData.SuperAccumulated#>
</cfif>


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

<!--- KFC dec 03, remove header from pay slip 
<cfinclude template="navbar_header_small.cfm">


<table width="100%">
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td> 
      <!--- <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1> --->
	  &nbsp;
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="PayrollSelectReportPagePaySlip.cfm?SID=#lngSID#&WE=#strWE#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>	
    </td>
  </tr>
</table>
---end --->
<br>
<br>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
		<cfoutput query = "GetData">

<table width="90%" border="0" cellspacing="0">
  <tr> 
    <td colspan="4"> 
      <div align="center"><font size="6"><b>Pay Confirmation Slip</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td><font size="3">Employee's Name:</font></td>
    <td><b><font size="3">#GetData.FullName#&nbsp;</font></b></td>
    <td><font size="3"></font></td>
    <td><b><font size="3">Steve Costi Seafood</font></b></td>
  </tr>
  <tr> 
    <td><font size="3">Pay Week / Period Ending</font></td>
    <td><b><font size="3">#mid(GetData.WeekEnding,1,2)#/#mid(GetData.WeekEnding,3,2)#/#mid(GetData.WeekEnding,5,4)#</font></b></td>
    <td><font size="3"></font></td>
    <td><b><font size="3">#GetStore.StoreName#&nbsp;</font></b></td>
  </tr>
  <tr> 
    <td><font size="3">Employee Status</font></td>
    <td><font size="3">#strStatus#</font></td>
    <td>&nbsp;</td>
    <td><b>ABN: #GetStore.ABN#</b></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">Normal Hours</font></b></td>
    <td><font size="3">#numberformat(GetData.NormalHoursPay,"_____.00")#&nbsp;</font></td>
    <td><b><font size="3">Taxable Income</font></b></td>
    <td><b><font size="3">#numberformat(GetData.TaxableIncome,"_____.00")#&nbsp;</font></b></td>
  </tr>
  <tr> 
    <td><b><font size="3">Overtime 1</font></b></td>
    <td><font size="3">#numberformat(GetData.OT1Pay,"_____.00")#&nbsp;</font></td>
    <td><b><font size="3">Non Taxable Income</font></b></td>
    <td><b><font size="3">#numberformat(GetData.NonTaxableIncome,"_____.00")#&nbsp;</font></b></td>
  </tr>
  <tr> 
    <td><b><font size="3">Overtime 2</font></b></td>
    <td><font size="3">#numberformat(GetData.OT2Pay,"_____.00")#&nbsp;</font></td>
    <td><b><font size="3">Tax</font></b></td>
    <td><b><font size="3">#numberformat(GetData.Tax,"_____.00")#&nbsp;</font></b></td>
  </tr>
  <tr> 
    <td><b><font size="3">Holiday Pay</font></b></td>
    <td><font size="3">#numberformat(GetData.HolidayHrsCanBePaidValue,"_____.00")#&nbsp;</font></td>
    <td><b><font size="3"></font></b></td>
    <td><b><font size="3"></font></b></td>
  </tr>
  <tr> 
    <td><b><font size="3">Holiday Loading</font></b></td>
    <td><font size="3">#numberformat(GetData.HolidayLoadingValue,"_____.00")#&nbsp;</font></td>
    <td><b><font size="3">Net</font></b></td>
    <td><b><font size="3">#numberformat(GetData.NettPay,"_____.00")#&nbsp;</font></b></td>
  </tr>
  <tr> 
    <td><b><font size="3">Sick Pay</font></b></td>
    <td><font size="3">#numberformat(GetData.SickHrsCanBePaidValue,"_____.00")#&nbsp;</font></td>
    <td><font size="3"><b>Super Contribution</b></font></td>
    <td><font size="3"><b>#numberformat(dblSup,"_____.00")#&nbsp;</b></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">Shift Allowance</font></b></td>
    <td><font size="3">#numberformat(GetData.ShiftAllowance,"_____.00")#&nbsp;</font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">Bonus</font></b></td>
    <td><font size="3">#numberformat(GetData.Bonus,"_____.00")#&nbsp;</font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">General Expense</font></b></td>
    <td><font size="3">#numberformat(GetData.Expenses,"_____.00")#&nbsp;</font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">Car Expense</font></b></td>
    <td><font size="3">#numberformat(GetData.CarAllowance,"_____.00")#&nbsp;</font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
  <tr> 
    <td><b><font size="3">Other Expense</font></b></td>
    <td><font size="3">#numberformat(GetData.OtherAllowance,"_____.00")#&nbsp;</font></td>
    <td><font size="3"></font></td>
    <td><font size="3"></font></td>
  </tr>
</table>

	    </cfoutput>
	  </div>
    </td>
  </tr>
</table>

<!--- Display the hours worked --->

<cfset strQuery = "SELECT 10000 * substring(DateWorked,5,4) + 100 * substring(DateWorked,3,2) + substring(DateWorked,1,2) as SortedDate,   * from tblEmpHoursWorked ">
<cfset strQuery = strQuery & "WHERE (EmployeeID = #lngEmployeeID#) and (StoreID = #lngStoreID#) and (WeekEnding = '#strWeekEnding#')  ">
<cfset strQuery = strQuery & "Order By SortedDate ">
<CFQUERY name="GetHoursWorked" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<p></p>

<table width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center">
        <table width="60%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="3"> 
              <div align="center"><b>Week Summary</b></div>
            </td>
          </tr>
          <tr> 
            <td><b>Date</b></td>
            <td><b>From</b></td>
            <td><b>To</b></td>
          </tr>
		  <cfoutput query = "GetHoursWorked">
				<cfset strDate = #mid(GetHoursWorked.DateWorked,1,2)# & "/" & #mid(GetHoursWorked.DateWorked,3,2)# & "/" &#mid(GetHoursWorked.DateWorked,5,4)# >
	          <tr> 
	            <td>#strDate# </td>
	            <td>#GetHoursWorked.StartTime#</td>
	            <td>#GetHoursWorked.EndTime#</td>
	          </tr>
		  </cfoutput>
        </table>
      </div>
    </td>
  </tr>
</table>


</body>
</HTML>

