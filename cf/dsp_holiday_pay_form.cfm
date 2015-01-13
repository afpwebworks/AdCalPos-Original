
<cfset strPageTitle = "Employee Holiday Pay">
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="holidayLoading">
<cfset local.page="dsp_holiday_pay_form.cfm">
<CFOUTPUT><CFSET requiredParms = "&employee_id=#evaluate(employee_id)#&store_id=#evaluate(store_id)#"></cfoutput>
<!---[   <CFINCLUDE template="act_security_check.cfm">   ]---->

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

<cfset strQuery = "SELECT * from tblEmployee ">
<cfset strQuery = strQuery & "WHERE EmployeeID = #employee_ID#">

<CFQUERY name="GetEmployee" datasource="#application.dsn#" > 
    #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
	<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
<script language="JavaScript1.2" type="text/javascript">
function checkSelect(){
	var f=document.<cfoutput>#local.formName#</cfoutput>;
	document.all.selectMsg.innerHTML="";
	if(f.r_storeId.options.value == null || f.r_storeId.options.value == ""){
		document.all.selectMsg.innerHTML="Please select a store";
	}
	else{
		var r=submitCheck('<cfoutput>#local.formName#</cfoutput>');
		if(r==true) f.submit();
	}
}
</script>
<!--- - wb 12/12/2003 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>

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
<FORM action="dsp_holiday_pay_to_pay.cfm" method="post" name="holidayLoading">
	<table width="100%" border="0">
	  <tr>
	    <td>
	      <div align="center">
		   	<cfoutput>
			   <INPUT type="hidden" name="employee_ID" value="#employee_ID#">
			   <INPUT type="hidden" name="store_ID" value="#store_ID#">
	   		   <cfinclude template="CalendarDisplay2.cfm">
			</cfoutput>
		  </div>
	    </td>
	  </tr>
	</table>
<CFOUTPUT>
	<table width="100%" border="0">
	  <tr>
	    <td>
		   #getEmployee.givenName[1]# #getEmployee.surname[1]#<BR>
		   #getEmployee.street[1]#, 
		   #getEmployee.address1[1]#, 
		   #getEmployee.address2[1]#, 
		   #getEmployee.postcode[1]#, 
		   #getEmployee.state[1]#
	    </td>
		<td>
			<cfset dblLeaveAvail = #GetLeaveDue.LeaveMinsAccumultedBy100# / 6000 >
			#NumberFormat(dblLeaveAvail,"_____.99")# hours leave available
			<INPUT type="HIDDEN" name="leaveDueHours" value="#dblLeaveAvail#">
		</td>
		<td>
		   <INPUT type="SUBMIT" value="Calculate Holiday Pay">
		</td>	
	  </tr>
	</table>
</FORM>
</cfoutput>
</body>
</HTML>

