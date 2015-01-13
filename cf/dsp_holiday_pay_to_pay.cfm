
<CFOUTPUT>
   <cfset strPageTitle = "Employee Holiday Pay">
   <CFSET hoursInDay = 7.6>
   <CFSET loadingPerCent = 0.175>
</cfoutput>
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<!---[   <CFINCLUDE template="act_security_check.cfm">   ]---->
<CFSET startLeaveDate = #CREATEDATE(#MID(sDate,1,4)#,#MID(sDate,5,2)#,#MID(sDate,7,2)#)#>
<CFSET endLeaveDate   = #CREATEDATE(#MID(eDate,1,4)#,#MID(eDate,5,2)#,#MID(eDate,7,2)#)#>

<CFSET datesListDDMMYYYY="">
<CFloop from="#startLeaveDate#" to="#endLeaveDate#" index="loop">	   
   <CFSET thisDateDDMMYYYY = #DateFormat(loop, "DDMMYYYY")#>
   <CFIF NOT ( dayOfWeek(loop) is 7 or  dayOfWeek(loop) is 1) >
      <CFSET datesListDDMMYYYY=#listAppend(datesListDDMMYYYY, thisDateDDMMYYYY)#>
   </cfif>
</CFloop>

<cfset strQuery = "SELECT [date] as dateDDMMYYYY from tblEmpPublicHol ">
<cfset strQuery = strQuery & "where [DATE] in (#datesListDDMMYYYY#)">
<CFQUERY name="checkBankHols" datasource="#application.dsn#" > 
    #PreserveSingleQuotes(strQuery)#
</CFQUERY>


<cfset strQuery = "SELECT * from tblEmployee ">
<cfset strQuery = strQuery & "WHERE EmployeeID = #employee_ID#">

<CFQUERY name="GetEmployee" datasource="#application.dsn#" > 
    #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<CFSET bankHolidaysTaken = checkBankHols.recordCount>
<cfset strQuery = "SELECT tblEmpStatus.Status, tblSecurityUserTypes.UserType, qryEmployeeView.LeaveMinsAccumultedBy100 , qryEmployeeView.SickMinsAccumultedBy100 , ">
<cfset strQuery = strQuery & "case when qryEmployeeView.NoLongerUsed=0 then 'No' else 'Yes' end AS NLU, ">
<cfset strQuery = strQuery & "tblStores.StoreID, tblStores.StoreName, qryEmployeeView.*, qryEmployeeView.EmployeeID AS ID_Field ">
<cfset strQuery = strQuery & "FROM ((qryEmployeeView INNER JOIN tblEmpStatus ON qryEmployeeView.EmpStatusID = tblEmpStatus.EmpStatusID) "> 
<cfset strQuery = strQuery & "INNER JOIN tblSecurityUserTypes ON qryEmployeeView.UserTypeID = tblSecurityUserTypes.UserTypeID) ">
<cfset strQuery = strQuery & "INNER JOIN tblStores ON qryEmployeeView.StoreID = tblStores.StoreID ">
<cfset strQuery = strQuery & "WHERE qryEmployeeView.EmployeeID = #employee_ID#">


<CFQUERY name="GetLeaveDue" datasource="#application.dsn#" > 
    #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- KF Feb 04, query global employee pay parameters --->
<CFINCLUDE template="act_getEmployeePayOptions.cfm">

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>	
	<SCRIPT language="JAVASCRIPT">
	   function CheckWeCanSubmit(inForm)
	   {
	      allOK=true;
	      if (inForm.notEnoughLeave)
		  {
		     allOK = confirm("Are you sure you wih to procede with this payment.\nThis employee has insufficient leave","");
		  }	 
		  
		  if (allOK)
		     inForm.submit();
	   }
	</script>
</HEAD>
<body>
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="tblEmployee_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
   <CFOUTPUT>
	<CFSET weekendDays = 0>
<!--- 	<CFloop from="#startLeaveDate#" to="#endLeaveDate#" index="thisDate">	   
	   <!--- <CFSET thisDate = #CREATEDATE(#MID(loop,1,4)#,#MID(loop,5,2)#,#MID(loop,7,2)#)#>	    --->
	   <!--- Sunday=1 and Saturday=7. --->
	   <CFIF dayOfWeek(thisDate) is 7 or  dayOfWeek(thisDate) is 1>
	      <CFSET weekendDays = weekendDays + 1>
	   </cfif>
	</CFloop>		
 --->	<FORM action="act_holiday_pay.cfm" method="post" name="holidayLoading">
	   <INPUT type="TEXT" name="employee_ID" value="#employee_ID#">
	   <INPUT type="TEXT" name="store_ID" value="#store_ID#">
	   <INPUT type="TEXT" name="datesListDDMMYYYY" value="#datesListDDMMYYYY#">
   	   <INPUT type="TEXT" name="bankHolidaysListDDMMYYYY" value="#valueList(checkBankHols.dateDDMMYYYY)#">
		<table align="CENTER" border="0">
		  <tr><td colspan="2">Taking leave from #dateFormat(startLeaveDate,"dd mmm yyyy")# to #dateFormat(endLeaveDate,"dd mmm yyyy")# (inclusive)</td></tr>
	      <TR><TD>Employee</TD><TD><b>#getEmployee.givenName[1]# #getEmployee.surname[1]#</b></td></tr>
		  <tr><TD>Employment terms</td><td>#GetLeaveDue.Status#</td></TR>
		  <TR><TD>Days elapsed</td><td>#listLen(datesListDDMMYYYY)#</td></tr>	  
		  <TR><TD>Weekend days</td><td>#weekendDays#</td></tr>	  
		  <TR><TD>Bank holidays</td><td>#bankHolidaysTaken#</td></tr>	  
		      <CFSET daysLeave = listLen(datesListDDMMYYYY) - weekendDays - bankHolidaysTaken>
		  <TR><TD>Days Leave Requested</td><td>#daysLeave#</td></tr>	  
		      <CFSET hoursLeave = daysLeave * hoursInDay>
		  <TR><TD><b>Hours Leave Requested</b></td><td><b>#hoursLeave#</b></td></tr>	  
		  <tr><TD><b>Hours Leave Available</b></td><td><b>#numberFormat(leaveDueHours,"_____.99")#</b></td></tr>
		    <CFIF leaveDueHours lt hoursLeave>
		       <tr><TD class="redText" colspan="2"><b>NB Leave available less than leave required</b></td></tr>
			   <INPUT type="HIDDEN" name="notEnoughLeave" value="true">
			<CFELSE>
			   <INPUT type="HIDDEN" name="notEnoughLeave" value="false">			   
		    </cfif>
		  <CFIF #FIND("CASUAL",GetLeaveDue.Status)# is 0> <!--- must be f/t, p/t, salaried --->
		    <CFSET baseDueMoney = GetLeaveDue.MonthlySalary / variables.standardHoursInWeek >			
			<TR><TD colspan="2"><br>
			  <TABLE width="100%" border="1" cellpadding="4" cellspacing="0">
			    <TR><TD>Hours leave</td><td>Hourly Rate</td><TD>Sub total</td><td>Holiday Loading</td><TD>Total Due</td></tr>
				<TR><TD>#hoursLeave#</td>
				    <td>#NumberFormat(baseDueMoney,"_____.99")#</td>
					   <CFSET subTotal = hoursLeave * baseDueMoney>
					<TD>#NumberFormat(subTotal,"_____.99")#</td>
					   <CFSET loading = subTotal * loadingPerCent>
					<td>#NumberFormat(loading,"_____.99")#</td>
					   <CFSET grandTotal = subTotal + loading>
					<TD>#NumberFormat(grandTotal,"_____.99")#</td>
				</tr>
			  </table>		
			</td></tr>
		  </cfif> 	  
		  <TR>
		    <td colspan="2" align="CENTER"><br><br>	
			  <INPUT type="SUBMIT" value="Cancel" onClick="JAVASCRIPT:history.go(-1);">
			     &nbsp;&nbsp;&nbsp;&nbsp;
		      <INPUT type="BUTTON" value="   PAY   " onClick="CheckWeCanSubmit(this.form);return false;">
			</td>
		</table>
	</FORM>
   </cfoutput> 	
</body>
</HTML>




