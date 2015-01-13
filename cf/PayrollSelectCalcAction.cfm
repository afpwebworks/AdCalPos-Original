
<cfset strPageTitle = "Calculate Payroll">
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
		<CFLOCATION url="frmLogin.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="frmLogin.htm">
</CFIF>


<cfset lngStoreID = #session.storeid#>
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

<cfset lngDay=right(form.sDate,2)>
<cfset lngMonth=mid(form.sDate,5,2)>
<cfset lngYear=left(form.sDate,4)>

<cfif #len(lngDay)# LT 2>
	<cfset lngDay = "0" & "#lngDay#">
</cfif>
<cfif #len(lngMonth)# LT 2>
	<cfset lngMonth = "0" & "#lngMonth#">
</cfif>
<cfset strDate = "#lngDay#" & "#lngMonth#" & "#lngYear#">

<cfset lngStoreID = #session.storeid#>

<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strDate#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# EQ "Y">
	<!--- get the start and finish dates for the selected week --->
		<cfset strEndWeekDate = #strDate#>	
		<CFSET strNextDate = ''>
		<CF_GetXDaysFromNow baseDate="#strEndWeekDate#" numDays="-6">
		<!--- <cfoutput><br>#strNextDate#</cfoutput> --->
		<cfset strStartWeekDate = #strNextDate#>	
	    <!--- Convert the dates into numbers --->
	
		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strEndWeekDate#">
		<cfset lngEndWeekDate = #lngDateLong#>	
		<!--- <cfoutput><br>#lngEndWeekDate#</cfoutput> --->

		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strStartWeekDate#">
		<cfset lngStartWeekDate = #lngDateLong#>	
		<!--- <cfoutput><br>#lngStartWeekDate#</cfoutput> --->

<!--- Delete the payroll records that have not been paid --->
		<cfset strQuery = "DELETE FROM tblEmpPayRoll ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null))">
		<CFQUERY name="DeleteNotPaidPayRecords" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="DeleteNotPaidPayRecords" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

<!--- Delete the payroll records From the temp file --->
		<cfset strQuery = "DELETE FROM tblEmpPayRollTemp ">
		<cfset strQuery = strQuery & "WHERE tblEmpPayRollTemp.StoreID =#lngStoreID# ">
		<CFQUERY name="DeleteTemporaryPayRecords" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
<!--- Public Holiday Section --->	
		<cfset strQuery = "SELECT qryPublicHoliday.PubHolDateLong, * ">
		<cfset strQuery = strQuery & "FROM qryPublicHoliday ">
		<cfset strQuery = strQuery & "WHERE (((qryPublicHoliday.PubHolDateLong) Between #lngStartWeekDate# And #lngEndWeekDate#))">
		
		<CFQUERY name="CheckPublicHoliday" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckPublicHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cfif #CheckPublicHoliday.RecordCount# GT 0 >
			<cfloop query="CheckPublicHoliday">
				<cfset strPublicHol = #CheckPublicHoliday.Date#>			
				<cfset lngPublicHol = #CheckPublicHoliday.PubHolDateLong#>						
				<!--- Make sure that this date does not exist for the employees of the same store over the time range --->
				<!--- <cfset lngStoreID = #GetRecord.StoreID#> --->						
			           
				<cfset strQuery = "SELECT tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID ">
				<cfset strQuery = strQuery & "FROM tblEmpHoursWorked INNER JOIN qryEmployee ON tblEmpHoursWorked.EmployeeID = qryEmployee.EmployeeID ">
				<cfset strQuery = strQuery & "WHERE (((qryEmployee.EmpStatusID)=2) AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null)) ">
				<cfset strQuery = strQuery & "GROUP BY tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID ">
				<cfset strQuery = strQuery & "HAVING (((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#') AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#))">
				<!--- <cfoutput>#StrQuery#</cfoutput> --->
				<CFQUERY name="CheckPubHoliday" datasource="#application.dsn#" > 
				<!--- <CFQUERY name="CheckPubHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<cfif #CheckPubHoliday.RecordCount#	GT 0>
					<cfloop query="CheckPubHoliday">				
						<cfset lngEmployeeID = #CheckPubHoliday.EmployeeID#>			
						<!--- Check to see if the employee so there are ---> 
						<cfset strQuery = "SELECT tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked ">
						<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
						<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)=#lngEmployeeID#) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.DateWorked)='#strPublicHol#'))">
						<CFQUERY name="CheckPubHolidayForEmployee" datasource="#application.dsn#" > 
						<!--- <CFQUERY name="CheckPubHolidayForEmployee" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
							#PreserveSingleQuotes(strQuery)#
						</CFQUERY>
						<cfif #CheckPubHolidayForEmployee.RecordCount# LT 0>
							<!--- Add the public holiday for the employee --->
							<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster, RecordAddedByComputer ) ">
							<cfset strQuery = strQuery & "Values ('#strEndWeekDate#',#lngEmployeeID# ,#lngStoreID# , '#strPublicHol#', '0900' , '1730' ,'0000' , '0000' , Yes)">
							<CFQUERY name="AddPubHolidayForEmployee" datasource="#application.dsn#" > 
							<!--- <CFQUERY name="AddPubHolidayForEmployee" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
								#PreserveSingleQuotes(strQuery)#
							</CFQUERY>
						</cfif>
					</cfloop> 
				</cfif>
			</cfloop> 
		</cfif>

<!--- Casual Sat Shift Allowance Section --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.ShiftAllowance = [qryEmpHoursAA_SatShitAllowanceB].[ShiftAllowance] ">
		<cfset strQuery = strQuery & "from tblEmpHoursWorked, qryEmpHoursAA_SatShitAllowanceB ">
		<cfset strQuery = strQuery & "WHERE (tblEmpHoursWorked.HoursWorkedID = qryEmpHoursAA_SatShitAllowanceB.HoursWorkedID) AND (qryEmpHoursAA_SatShitAllowanceB.StoreID=#lngStoreID#) AND (qryEmpHoursAA_SatShitAllowanceB.WeekEnding='#strEndWeekDate#') AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null)">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpHoursWorked INNER JOIN qryEmpHoursAA_SatShitAllowanceB ON tblEmpHoursWorked.HoursWorkedID = qryEmpHoursAA_SatShitAllowanceB.HoursWorkedID SET tblEmpHoursWorked.ShiftAllowance = [qryEmpHoursAA_SatShitAllowanceB].[ShiftAllowance] ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAA_SatShitAllowanceB.StoreID)=#lngStoreID#) AND ((qryEmpHoursAA_SatShitAllowanceB.WeekEnding)='#strEndWeekDate#') AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null))">
		 --->		
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="AddCasualSatAllowance" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="AddCasualSatAllowance" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		
<!--- Reduce the amount of standard time by the 0.5 hr lunch time --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.LunchMinutes = [LunchMins] ">
		<cfset strQuery = strQuery & "from tblEmpHoursWorked, qryEmpHoursAA_Lunch ">
		<cfset strQuery = strQuery & "WHERE (qryEmpHoursAA_Lunch.HoursWorkedID = tblEmpHoursWorked.HoursWorkedID) AND (qryEmpHoursAA_Lunch.WeekEnding='#strEndWeekDate#') AND (qryEmpHoursAA_Lunch.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null)">
		<CFQUERY name="CalculateLunchMins" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Hours Worked and multiplier section --->
        <!--- MH20030808  Calculate the minutes worked first --->
		<cfset strQuery = "update tblEmpHoursWorked set tblEmpHoursWorked.TotalMinutesWorked = (qryEmpHoursA1.MinutesWorked - tblEmpHoursWorked.LunchMinutes) ">
		<cfset strQuery = strQuery & "from tblEmpHoursWorked, qryEmpHoursA1 ">
		<cfset strQuery = strQuery & "WHERE (tblEmpHoursWorked.HoursWorkedID = qryEmpHoursA1.HoursWorkedID) AND (qryEmpHoursA1.WeekEnding='#strEndWeekDate#') AND (qryEmpHoursA1.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null) ">
		<CFQUERY name="CalculateMinutesWorked" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.STMins = [ST] , tblEmpHoursWorked.OT1Mins = [oT1], tblEmpHoursWorked.Ot2Mins = [oT2], tblEmpHoursWorked.SickMins = [Sick], tblEmpHoursWorked.LeaveMins = [Leave], tblEmpHoursWorked.STMultiplier = [StandardMultiplier], tblEmpHoursWorked.OT1Multiplier = [Mult_Ot1], tblEmpHoursWorked.OT2Multiplier = [Mult_Ot2], tblEmpHoursWorked.PublicHoliday = Null, tblEmpHoursWorked.PayRateBase = [ActualHourlyPayRate] ">
		<cfset strQuery = strQuery & "from tblEmpHoursWorked, qryEmpHoursAB ">
		<cfset strQuery = strQuery & "WHERE (qryEmpHoursAB.HoursWorkedID = tblEmpHoursWorked.HoursWorkedID) AND (qryEmpHoursAB.WeekEnding='#strEndWeekDate#') AND (qryEmpHoursAB.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null)">
		<!--- 
		<cfset strQuery = "UPDATE qryEmpHoursAB INNER JOIN tblEmpHoursWorked ON qryEmpHoursAB.HoursWorkedID = tblEmpHoursWorked.HoursWorkedID SET tblEmpHoursWorked.STMins = [ST], tblEmpHoursWorked.OT1Mins = [oT1], tblEmpHoursWorked.Ot2Mins = [oT2], tblEmpHoursWorked.SickMins = [Sick], tblEmpHoursWorked.LeaveMins = [Leave], tblEmpHoursWorked.STMultiplier = [StandardMultiplier], tblEmpHoursWorked.OT1Multiplier = [Mult_Ot1], tblEmpHoursWorked.OT2Multiplier = [Mult_Ot2], tblEmpHoursWorked.PublicHoliday = Null, tblEmpHoursWorked.PayRateBase = [ActualHourlyPayRate] ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAB.WeekEnding)='#strEndWeekDate#') AND ((qryEmpHoursAB.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null))">
		 --->
  	    <!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<!--- 		<CFQUERY name="CalculateHoursWorked" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CalculateHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
 --->
<!--- Mark Public Holidays --->
		
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.PublicHoliday = 'P' ">
		<cfset strQuery = strQuery & "From tblEmpHoursWorked, tblEmpPublicHol ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPublicHol.Date = tblEmpHoursWorked.DateWorked) AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null) AND (tblEmpHoursWorked.RecordAddedByComputer=0) AND (tblEmpHoursWorked.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.WeekEnding='#strEndWeekDate#')">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpPublicHol INNER JOIN tblEmpHoursWorked ON tblEmpPublicHol.Date = tblEmpHoursWorked.DateWorked SET tblEmpHoursWorked.PublicHoliday = 'P' ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.RecordAddedByComputer)=0) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
		 --->
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> ---> 
		<CFQUERY name="MarkPublicHolidays" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		
<!--- Check the multipliers for public holidays --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.STMultiplier = [StandardMult], tblEmpHoursWorked.OT1Multiplier = [OT1Mult]*[StandardMult], tblEmpHoursWorked.OT2Multiplier = [OT2Mult]*[StandardMult] ">
		<cfset strQuery = strQuery & "from tblEmpHoursWorked, tblEmployee, tblEmpRateMultiplier ">
		<cfset strQuery = strQuery & "WHERE (tblEmployee.EmpStatusID = tblEmpRateMultiplier.EmployeeStatusID) AND (tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID) AND (tblEmpRateMultiplier.WeekDay=0) AND (tblEmpHoursWorked.PublicHoliday='P') AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null) AND (tblEmpHoursWorked.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.WeekEnding='#strEndWeekDate#')">
<!--- 
		<cfset strQuery = "UPDATE (tblEmpHoursWorked INNER JOIN tblEmployee ON tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID) INNER JOIN tblEmpRateMultiplier ON tblEmployee.EmpStatusID = tblEmpRateMultiplier.EmployeeStatusID SET tblEmpHoursWorked.STMultiplier = [StandardMult], tblEmpHoursWorked.OT1Multiplier = [OT1Mult]*[StandardMult], tblEmpHoursWorked.OT2Multiplier = [OT2Mult]*[StandardMult] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpRateMultiplier.WeekDay)=0) AND ((tblEmpHoursWorked.PublicHoliday)='P') AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
 --->		
		<CFQUERY name="MarkPublicHolidays" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Sick and Leave --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.SickMinsAccumultedBy100 = convert(int,100*[SK_Leave]*[STMins]), tblEmpHoursWorked.LeaveMinsAccumultedBy100 = convert(int,100*[HolidayPay]*[STMins]) ">
		<cfset strQuery = strQuery & "From tblEmpHoursWorked, qryEmpHoursEntitlementB ">
		<cfset strQuery = strQuery & "WHERE (tblEmpHoursWorked.HoursWorkedID = qryEmpHoursEntitlementB.HoursWorkedID) AND (tblEmpHoursWorked.DatePaid='' Or tblEmpHoursWorked.DatePaid Is Null) AND (tblEmpHoursWorked.StoreID=#lngStoreID#) AND (tblEmpHoursWorked.WeekEnding='#strEndWeekDate#')">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpHoursWorked INNER JOIN qryEmpHoursEntitlementB ON tblEmpHoursWorked.HoursWorkedID = qryEmpHoursEntitlementB.HoursWorkedID SET tblEmpHoursWorked.SickMinsAccumultedBy100 = Int(100*[SK_Leave]*[STMins]), tblEmpHoursWorked.LeaveMinsAccumultedBy100 = Int(100*[HolidayPay]*[STMins]) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
		 --->
		<!--- <cfoutput>#strQuery#</cfoutput> --->

		 
		<CFQUERY name="MarkPublicHolidays" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
<!--- 		
		<cfoutput><BR>Hello Dear 4</cfoutput>
		<cfabort>
 --->
<!--- Salaried people do not get overtime MH:20030401 --->

		<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.OT1Mins = 0, tblEmpHoursWorked.Ot2Mins = 0 ">
		<cfset strQuery = strQuery & "From tblEmpHoursWorked, tblEmployee ">
		<cfset strQuery = strQuery & "WHERE (tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID) AND (tblEmpHoursWorked.WeekEnding='#strEndWeekDate#') AND (tblEmpHoursWorked.StoreID=#lngStoreID#) AND (tblEmployee.EmpStatusID=1)">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpHoursWorked INNER JOIN tblEmployee ON tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID SET tblEmpHoursWorked.OT1Mins = 0, tblEmpHoursWorked.Ot2Mins = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#') AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmployee.EmpStatusID)=1))">
		 --->
 	    <!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="UpdateOvertimes" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateOvertimes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

	
<!--- Write the summary to the payroll temproray table mh 20030808 --->
		<cfset strQuery = "INSERT INTO tblEmpPayRollTemp ( EmployeeID, EmpStatusID, WeekEnding, StoreID, TaxScaleID, Age, NormalHours, OT1, OT2, HolidayHrs, SickHrs, NormalHoursPay, OT1Pay, OT2Pay, Bonus, Expenses, CarAllowance, OtherAllowance, SickMinsAccumultedBy100, LeaveMinsAccumultedBy100, SuperAccumulated, WorkCompAccumulated , GivenName, Surname,ShiftAllowance) ">
		<cfset strQuery = strQuery & "SELECT qryEmpHoursAC_Week.EmployeeID, qryEmpPayB.EmpStatusID, qryEmpHoursAC_Week.WeekEnding, qryEmpHoursAC_Week.StoreID, qryEmpPayB.TaxScaleID, qryEmpPayB.PayrollAge, qryEmpHoursAC_Week.SSTHours, qryEmpHoursAC_Week.SOT1Hours, qryEmpHoursAC_Week.SOt2Hours, qryEmpHoursAC_Week.SLeaveHours, qryEmpHoursAC_Week.SSickHours, qryEmpHoursAC_Week.STValue, qryEmpHoursAC_Week.OT1Value, qryEmpHoursAC_Week.Ot2Value, qryEmpHoursAC_Week.SBonus, qryEmpHoursAC_Week.SExpenses, qryEmpPayB.CarAllowancePerWeek, qryEmpPayB.OtherAllowancePerWeek , qryEmpHoursAC_Week.SSickMinsAccumultedBy100, qryEmpHoursAC_Week.SLeaveMinsAccumultedBy100, qryEmpHoursAC_Week.SSuperAccumulated, qryEmpHoursAC_Week.SWorkCompAccumulated , qryEmpPayB.GivenName, qryEmpPayB.Surname, qryEmpHoursAC_Week.SShiftAllowance ">
		<cfset strQuery = strQuery & "FROM qryEmpHoursAC_Week INNER JOIN qryEmpPayB ON (qryEmpHoursAC_Week.StoreID = qryEmpPayB.StoreID) AND (qryEmpHoursAC_Week.EmployeeID = qryEmpPayB.EmployeeID) ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAC_Week.WeekEnding)='#strEndWeekDate#') AND ((qryEmpHoursAC_Week.StoreID)=#lngStoreID#))">
		<!--- <cfoutput>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="WriteTempSummary" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		
<!--- Calculate the weekly overtimes --->
		<cfset strQuery = "update qryEmpHoursAB_Weekly set NormalHours = NewNormalHours, OT1Weekly = Wot1, OT2Weekly = Wot2 ">
		<cfset strQuery = strQuery & "FROM qryEmpHoursAB_Weekly ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAB_Weekly.WeekEnding)='#strEndWeekDate#') AND ((qryEmpHoursAB_Weekly.StoreID)=#lngStoreID#))">
		<CFQUERY name="CalculateWeeklyOvertimes" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Salaried people do not get overtime MH:20030811 --->
		<cfset strQuery = "UPDATE tblEmpPayRollTemp SET tblEmpPayRollTemp.OT1Weekly = 0, tblEmpPayRollTemp.OT2Weekly = 0 ">
		<cfset strQuery = strQuery & "From tblEmpPayRollTemp ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRollTemp.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRollTemp.StoreID = #lngStoreID#)  AND (tblEmpPayRollTemp.EmpStatusID=1)">
		<CFQUERY name="UpdateWeeklyOvertimes" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Define the hourly pay rate MH:20030811 --->
		<cfset strQuery = "UPDATE tblEmpPayRollTemp SET tblEmpPayRollTemp.HourlyRate = qryEmpPayB.ActualHourlyPayRate ">
		<cfset strQuery = strQuery & "From tblEmpPayRollTemp, qryEmpPayB ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRollTemp.EmployeeID = qryEmpPayB.EmployeeID) and (tblEmpPayRollTemp.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRollTemp.StoreID = #lngStoreID#) ">
		<CFQUERY name="UpdateWeeklyA" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Define the weekly multipliers MH:20030811 --->
		<cfset strQuery = "UPDATE tblEmpPayRollTemp SET tblEmpPayRollTemp.OT1WeeklyMultiplier = tblEmpRateMultiplier.OT1Mult, tblEmpPayRollTemp.OT2WeeklyMultiplier =tblEmpRateMultiplier.OT2Mult ">
		<cfset strQuery = strQuery & "from tblEmpPayRollTemp, tblEmpRateMultiplier ">
		<cfset strQuery = strQuery & "WHERE  (tblEmpPayRollTemp.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRollTemp.StoreID = #lngStoreID#) AND (tblEmpRateMultiplier.WeekDay = 2) and (tblEmpPayRollTemp.EmpStatusID = tblEmpRateMultiplier.EmployeeStatusID) ">
		<CFQUERY name="UpdateWeeklyB" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Calculate dollar values MH:20030811 --->
		<cfset strQuery = "UPDATE tblEmpPayRollTemp SET NormalHoursPay = NormalHoursPay - HourlyRate * (OT1Weekly + OT2Weekly)  , OT1PayWeekly = OT1WeeklyMultiplier * OT1Weekly * HourlyRate , OT2PayWeekly = OT2WeeklyMultiplier * OT2Weekly * HourlyRate ">
		<cfset strQuery = strQuery & "from tblEmpPayRollTemp ">
		<cfset strQuery = strQuery & "WHERE  (tblEmpPayRollTemp.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRollTemp.StoreID = #lngStoreID#) ">
		<CFQUERY name="UpdateWeeklyC" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		
<!--- Write the summary to the payroll table --->
		<cfset strQuery = "INSERT INTO tblEmpPayRoll ( EmployeeID, EmpStatusID, WeekEnding, StoreID, TaxScaleID, Age, NormalHours, OT1, OT2, HolidayHrs, SickHrs, NormalHoursPay, OT1Pay, OT2Pay, Bonus, Expenses, CarAllowance, OtherAllowance, SickMinsAccumultedBy100, LeaveMinsAccumultedBy100, SuperAccumulated, WorkCompAccumulated , GivenName, Surname, ShiftAllowance) ">
		<cfset strQuery = strQuery & "SELECT tblEmpPayRollTemp.EmployeeID, tblEmpPayRollTemp.EmpStatusID, tblEmpPayRollTemp.WeekEnding, tblEmpPayRollTemp.StoreID, tblEmpPayRollTemp.TaxScaleID, tblEmpPayRollTemp.Age, tblEmpPayRollTemp.NormalHours, tblEmpPayRollTemp.OT1 + tblEmpPayRollTemp.OT1Weekly, tblEmpPayRollTemp.OT2 + tblEmpPayRollTemp.OT2Weekly , tblEmpPayRollTemp.HolidayHrs, tblEmpPayRollTemp.SickHrs, tblEmpPayRollTemp.NormalHoursPay, tblEmpPayRollTemp.OT1Pay + tblEmpPayRollTemp.OT1PayWeekly, tblEmpPayRollTemp.OT2Pay + tblEmpPayRollTemp.OT2PayWeekly , tblEmpPayRollTemp.Bonus, tblEmpPayRollTemp.Expenses, tblEmpPayRollTemp.CarAllowance, tblEmpPayRollTemp.OtherAllowance, tblEmpPayRollTemp.SickMinsAccumultedBy100, tblEmpPayRollTemp.LeaveMinsAccumultedBy100, tblEmpPayRollTemp.SuperAccumulated, tblEmpPayRollTemp.WorkCompAccumulated , tblEmpPayRollTemp.GivenName, tblEmpPayRollTemp.Surname , tblEmpPayRollTemp.ShiftAllowance ">
		<cfset strQuery = strQuery & "FROM tblEmpPayRollTemp ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRollTemp.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRollTemp.StoreID = #lngStoreID# ) ">
		<CFQUERY name="WriteSummary" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Calculate sick and leave hours that we can pay --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.HolidayHrsCanBePaid = case when [HolidayHrs]<=([tblEmployee].[LeaveMinsAccumultedBy100]/100) then [HolidayHrs] else ([tblEmployee].[LeaveMinsAccumultedBy100]/100) end ">
		<cfset strQuery = strQuery & "from tblEmpPayRoll, tblEmployee ">
		<cfset strQuery = strQuery & "WHERE (tblEmployee.StoreID = tblEmpPayRoll.StoreID) AND (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmpPayRoll.StoreID=#lngStoreID#) AND (tblEmpPayRoll.WeekEnding='#strEndWeekDate#') AND (tblEmpPayRoll.PayPaidDate='' Or tblEmpPayRoll.PayPaidDate Is Null) AND (tblEmpPayRoll.HolidayHrs > 0.00001)">
		<!--- 
		<cfset strQuery = "UPDATE tblEmployee INNER JOIN tblEmpPayRoll ON (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmployee.StoreID = tblEmpPayRoll.StoreID) SET tblEmpPayRoll.HolidayHrsCanBePaid = IIf([HolidayHrs]<=([tblEmployee].[LeaveMinsAccumultedBy100]/100),[HolidayHrs],([tblEmployee].[LeaveMinsAccumultedBy100]/100)) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null) AND ((tblEmpPayRoll.HolidayHrs)>0.0001))">
		 --->
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> ---> 
		<CFQUERY name="MarkTheHoliday" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkTheHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SickHrsCanBePaid = case when [SickHrs]<=([tblEmployee].[SickMinsAccumultedBy100]/100) then [SickHrs] else ([tblEmployee].[SickMinsAccumultedBy100]/100) end ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, tblEmployee ">
		<cfset strQuery = strQuery & "WHERE (tblEmployee.StoreID = tblEmpPayRoll.StoreID) AND (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmpPayRoll.StoreID=#lngStoreID#) AND (tblEmpPayRoll.WeekEnding='#strEndWeekDate#') AND (tblEmpPayRoll.PayPaidDate='' Or tblEmpPayRoll.PayPaidDate Is Null) AND (tblEmpPayRoll.SickHrs>0.00001)">
		<!--- 
		<cfset strQuery = "UPDATE tblEmployee INNER JOIN tblEmpPayRoll ON (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmployee.StoreID = tblEmpPayRoll.StoreID) SET tblEmpPayRoll.SickHrsCanBePaid = IIf([SickHrs]<=([tblEmployee].[SickMinsAccumultedBy100]/100),[SickHrs],([tblEmployee].[SickMinsAccumultedBy100]/100)) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null) AND ((tblEmpPayRoll.SickHrs)>0.0001))">
		 --->
		<CFQUERY name="MarkTheHoliday" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkTheHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Holiday Loading , Holiday Pay, Sick Pay --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.HolidayLoading = [qryEmpPayOptions].[HolidayLoading] ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, qryEmpPayOptions ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRoll.WeekEnding='#strEndWeekDate#') AND (tblEmpPayRoll.StoreID=#lngStoreID#)">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpPayRoll, qryEmpPayOptions SET tblEmpPayRoll.HolidayLoading = [qryEmpPayOptions].[HolidayLoading] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		 --->
		<CFQUERY name="HolidayLoading" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="HolidayLoading" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
<!--- 		
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.HolidayLoadingValue = [HolidayLoading]*[HolidayHrsCanBePaid]*[NormalHoursPay], tblEmpPayRoll.HolidayHrsCanBePaidValue = [HolidayHrsCanBePaid]*[NormalHoursPay] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.HolidayHrsCanBePaid)>0.0001))">
		<CFQUERY name="MarkHolidayValues" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SickHrsCanBePaidValue = [SickHrsCanBePaid]*[NormalHoursPay] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.SickHrsCanBePaid)>0.0001) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="MarkSickValues" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
 --->
<!---  15/12/2003 --->

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.HolidayLoadingValue = tblEmpPayRoll.[HolidayLoading] * tblEmpPayRoll.[HolidayHrsCanBePaid] * qryEmpPayB.[ActualHourlyPayRate], tblEmpPayRoll.HolidayHrsCanBePaidValue = tblEmpPayRoll.[HolidayHrsCanBePaid] * qryEmpPayB.[ActualHourlyPayRate] ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, qryEmpPayB ">
		<cfset strQuery = strQuery & "WHERE  (tblEmpPayRoll.EmployeeID = qryEmpPayB.EmployeeID) AND (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.HolidayHrsCanBePaid)>0.0001))">
		<CFQUERY name="MarkHolidayValues" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SickHrsCanBePaidValue = tblEmpPayRoll.[SickHrsCanBePaid] * qryEmpPayB.[ActualHourlyPayRate] ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, qryEmpPayB ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRoll.EmployeeID = qryEmpPayB.EmployeeID) AND (((tblEmpPayRoll.SickHrsCanBePaid)>0.0001) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="MarkSickValues" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
		
<!--- Taxable, Non taxable Income --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.TaxableIncome = [NormalHoursPay]+[OT1Pay]+[OT2Pay]+[HolidayHrsCanBePaidValue]+[SickHrsCanBePaidValue]+[Bonus]+[ShiftAllowance], tblEmpPayRoll.NonTaxableIncome = [HolidayLoadingValue]+[Expenses]+[CarAllowance]+[OtherAllowance] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="TaxableIncome" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="TaxableIncome" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Taxable, Non taxable Income for the salrary people mh 20030812 --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SickHrsCanBePaidValue = 0 ,tblEmpPayRoll.NormalHoursPay = 0 , tblEmpPayRoll.OT1Pay = 0 , tblEmpPayRoll.OT2Pay = 0, tblEmpPayRoll.TaxableIncome = tblEmployee.MonthlySalary + tblEmpPayRoll.Bonus, tblEmpPayRoll.NonTaxableIncome = [HolidayLoadingValue]+[Expenses]+[CarAllowance]+[OtherAllowance] ">
		<cfset strQuery = strQuery & "FROM tblEmpPayRoll INNER JOIN tblEmployee ON tblEmpPayRoll.EmployeeID = tblEmployee.EmployeeID ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRoll.EmpStatusID = 1) and (tblEmpPayRoll.WeekEnding = '#strEndWeekDate#') AND (tblEmpPayRoll.StoreID = #lngStoreID#) ">
		<CFQUERY name="TaxableIncomeForSalaryPeople" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Calculate Tax --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.Tax = convert(float, case when ([a]*[TaxableIncome])-[b] < 0.00001 then 0 else ([a]*[TaxableIncome])-[b] end) ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, tblEmpTaxScaleDet ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRoll.TaxScaleID = tblEmpTaxScaleDet.TaxScaleID) AND (tblEmpPayRoll.WeekEnding='#strEndWeekDate#') AND (tblEmpPayRoll.StoreID=#lngStoreID#) AND (tblEmpPayRoll.TaxableIncome Between [GrossFrom] And [GrossTo])">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpPayRoll INNER JOIN tblEmpTaxScaleDet ON tblEmpPayRoll.TaxScaleID = tblEmpTaxScaleDet.TaxScaleID SET tblEmpPayRoll.Tax = convert(float, case when ([a]*[TaxableIncome])-[b] < 0.00001 then 0 else ([a]*[TaxableIncome])-[b]) end ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.TaxableIncome) Between [GrossFrom] And [GrossTo]))">
		 --->		
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->		
		<CFQUERY name="CalculateTax" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CalculateTax" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.Tax = Round(tblEmpPayRoll.Tax,0) ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll ">
		<cfset strQuery = strQuery & "WHERE (tblEmpPayRoll.WeekEnding='#strEndWeekDate#') AND (tblEmpPayRoll.StoreID=#lngStoreID#) ">
		<CFQUERY name="RoundCalculateTax" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Super / Workers Comp --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SuperAccumulated = [SuperRate]*([TaxableIncome]+[NonTaxableIncome]), tblEmpPayRoll.WorkCompAccumulated = [WorkersComp]*([TaxableIncome]+[NonTaxableIncome]) ">
		<cfset strQuery = strQuery & "From tblEmpPayRoll, qryEmpPayOptions ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<!--- 
		<cfset strQuery = "UPDATE tblEmpPayRoll, qryEmpPayOptions SET tblEmpPayRoll.SuperAccumulated = [SuperRate]*([TaxableIncome]+[NonTaxableIncome]), tblEmpPayRoll.WorkCompAccumulated = [WorkersComp]*([TaxableIncome]+[NonTaxableIncome]) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		 --->
		<CFQUERY name="WorkersComp" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="WorkersComp" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
<cfelse>
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
</cfif>		
	
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
        <table width="80%" border="0">
			<tr>
				<td>
					<cfoutput>Successfully calculated the payroll for the week ending #mid(strEndWeekDate,1,2)#/#mid(strEndWeekDate,3,2)#/#mid(strEndWeekDate,5,4)#</cfoutput>
				</td>
			</tr>
        </table>
	  </div>
    </td>
  </tr>
</table>
<cfabort>	
</body>
</HTML>

