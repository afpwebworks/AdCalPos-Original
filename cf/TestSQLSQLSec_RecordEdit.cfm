
<CFSET FormFieldList = "BundyNo,StoreID,GivenName,Surname,TaxFileNo,Street,Address1,Address2,PostCode,State,Phone,Fax,Mobile,Email,BirthDay,EmpStatusID,HourlyPayRate,MonthlySalary,Commenced,Finished,entLeaveAvail,entLeaveTaken,entSickAvail,entSickTaken,ytdGross,ytdTax,ytdNetPay,ytdSuper,NoLongerUsed,UserTypeID,UserName,Password,CarAllowancePerWeek,OtherAllowancePerWeek">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" dataSource="CostiSQLSQLSec" USERNAME="sa" PASSWORD="" maxRows=1>
		SELECT tblEmployee.BundyNo, tblEmployee.StoreID, tblEmployee.GivenName, tblEmployee.Surname, tblEmployee.TaxFileNo, tblEmployee.Street, tblEmployee.Address1, tblEmployee.Address2, tblEmployee.PostCode, tblEmployee.State, tblEmployee.Phone, tblEmployee.Fax, tblEmployee.Mobile, tblEmployee.Email, tblEmployee.BirthDay, tblEmployee.EmpStatusID, tblEmployee.HourlyPayRate, tblEmployee.MonthlySalary, tblEmployee.Commenced, tblEmployee.Finished, tblEmployee.entLeaveAvail, tblEmployee.entLeaveTaken, tblEmployee.entSickAvail, tblEmployee.entSickTaken, tblEmployee.ytdGross, tblEmployee.ytdTax, tblEmployee.ytdNetPay, tblEmployee.ytdSuper, tblEmployee.NoLongerUsed, tblEmployee.UserTypeID, tblEmployee.UserName, tblEmployee.Password, tblEmployee.CarAllowancePerWeek, tblEmployee.OtherAllowancePerWeek, tblEmployee.EmployeeID AS ID_Field
		FROM tblEmployee
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmployee.EmployeeID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "EmployeeID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "EmployeeID" )>
	</CFIF>

			
			<CFSET BundyNo_Value = #GetRecord.BundyNo#>
				
			<CFSET StoreID_Value = #GetRecord.StoreID#>
				
			<CFSET GivenName_Value = '#GetRecord.GivenName#'>
				
			<CFSET Surname_Value = '#GetRecord.Surname#'>
				
			<CFSET TaxFileNo_Value = '#GetRecord.TaxFileNo#'>
				
			<CFSET Street_Value = '#GetRecord.Street#'>
				
			<CFSET Address1_Value = '#GetRecord.Address1#'>
				
			<CFSET Address2_Value = '#GetRecord.Address2#'>
				
			<CFSET PostCode_Value = '#GetRecord.PostCode#'>
				
			<CFSET State_Value = '#GetRecord.State#'>
				
			<CFSET Phone_Value = '#GetRecord.Phone#'>
				
			<CFSET Fax_Value = '#GetRecord.Fax#'>
				
			<CFSET Mobile_Value = '#GetRecord.Mobile#'>
				
			<CFSET Email_Value = '#GetRecord.Email#'>
				
			<CFSET BirthDay_Value = '#GetRecord.BirthDay#'>
				
			<CFSET EmpStatusID_Value = #GetRecord.EmpStatusID#>
				
			<CFSET HourlyPayRate_Value = #GetRecord.HourlyPayRate#>
				
			<CFSET MonthlySalary_Value = #GetRecord.MonthlySalary#>
				
			<CFSET Commenced_Value = '#GetRecord.Commenced#'>
				
			<CFSET Finished_Value = '#GetRecord.Finished#'>
				
			<CFSET entLeaveAvail_Value = #GetRecord.entLeaveAvail#>
				
			<CFSET entLeaveTaken_Value = #GetRecord.entLeaveTaken#>
				
			<CFSET entSickAvail_Value = #GetRecord.entSickAvail#>
				
			<CFSET entSickTaken_Value = #GetRecord.entSickTaken#>
				
			<CFSET ytdGross_Value = #GetRecord.ytdGross#>
				
			<CFSET ytdTax_Value = #GetRecord.ytdTax#>
				
			<CFSET ytdNetPay_Value = #GetRecord.ytdNetPay#>
				
			<CFSET ytdSuper_Value = #GetRecord.ytdSuper#>
				
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>
				
			<CFSET UserTypeID_Value = #GetRecord.UserTypeID#>
				
			<CFSET UserName_Value = '#GetRecord.UserName#'>
				
			<CFSET Password_Value = '#GetRecord.Password#'>
				
			<CFSET CarAllowancePerWeek_Value = #GetRecord.CarAllowancePerWeek#>
				
			<CFSET OtherAllowancePerWeek_Value = #GetRecord.OtherAllowancePerWeek#>
		

<CFELSE>

			
			<CFSET BundyNo_Value = ''>
				
			<CFSET StoreID_Value = ''>
				
			<CFSET GivenName_Value = ''>
				
			<CFSET Surname_Value = ''>
				
			<CFSET TaxFileNo_Value = ''>
				
			<CFSET Street_Value = ''>
				
			<CFSET Address1_Value = ''>
				
			<CFSET Address2_Value = ''>
				
			<CFSET PostCode_Value = ''>
				
			<CFSET State_Value = ''>
				
			<CFSET Phone_Value = ''>
				
			<CFSET Fax_Value = ''>
				
			<CFSET Mobile_Value = ''>
				
			<CFSET Email_Value = ''>
				
			<CFSET BirthDay_Value = ''>
				
			<CFSET EmpStatusID_Value = ''>
				
			<CFSET HourlyPayRate_Value = ''>
				
			<CFSET MonthlySalary_Value = ''>
				
			<CFSET Commenced_Value = ''>
				
			<CFSET Finished_Value = ''>
				
			<CFSET entLeaveAvail_Value = ''>
				
			<CFSET entLeaveTaken_Value = ''>
				
			<CFSET entSickAvail_Value = ''>
				
			<CFSET entSickTaken_Value = ''>
				
			<CFSET ytdGross_Value = ''>
				
			<CFSET ytdTax_Value = ''>
				
			<CFSET ytdNetPay_Value = ''>
				
			<CFSET ytdSuper_Value = ''>
				
			<CFSET NoLongerUsed_Value = 0>
				
			<CFSET UserTypeID_Value = ''>
				
			<CFSET UserName_Value = ''>
				
			<CFSET Password_Value = ''>
				
			<CFSET CarAllowancePerWeek_Value = ''>
				
			<CFSET OtherAllowancePerWeek_Value = ''>
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestSQL_SQLSec - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQL_SQLSec</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestSQLSQLSec_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="EmployeeID" value="#URL.RecordID#">
</CFIF>


<TABLE>

	
	<TR>
	<TD valign="top"> BundyNo: </TD>
    <TD>
	
		<INPUT type="text" name="BundyNo" value="#BundyNo_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="BundyNo_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> StoreID: </TD>
    <TD>
	
		<INPUT type="text" name="StoreID" value="#StoreID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="StoreID_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> GivenName: </TD>
    <TD>
	
		<INPUT type="text" name="GivenName" value="#GivenName_Value#" maxLength="40">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Surname: </TD>
    <TD>
	
		<INPUT type="text" name="Surname" value="#Surname_Value#" maxLength="60">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> TaxFileNo: </TD>
    <TD>
	
		<INPUT type="text" name="TaxFileNo" value="#TaxFileNo_Value#" maxLength="24">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Street: </TD>
    <TD>
	
		<INPUT type="text" name="Street" value="#Street_Value#" maxLength="140">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Address1: </TD>
    <TD>
	
		<INPUT type="text" name="Address1" value="#Address1_Value#" maxLength="100">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Address2: </TD>
    <TD>
	
		<INPUT type="text" name="Address2" value="#Address2_Value#" maxLength="100">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> PostCode: </TD>
    <TD>
	
		<INPUT type="text" name="PostCode" value="#PostCode_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> State: </TD>
    <TD>
	
		<INPUT type="text" name="State" value="#State_Value#" maxLength="6">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Phone: </TD>
    <TD>
	
		<INPUT type="text" name="Phone" value="#Phone_Value#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Fax: </TD>
    <TD>
	
		<INPUT type="text" name="Fax" value="#Fax_Value#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Mobile: </TD>
    <TD>
	
		<INPUT type="text" name="Mobile" value="#Mobile_Value#" maxLength="50">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Email: </TD>
    <TD>
	
		<INPUT type="text" name="Email" value="#Email_Value#" maxLength="140">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> BirthDay: </TD>
    <TD>
	
		<INPUT type="text" name="BirthDay" value="#BirthDay_Value#" maxLength="16">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> EmpStatusID: </TD>
    <TD>
	
		<INPUT type="text" name="EmpStatusID" value="#EmpStatusID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="EmpStatusID_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> HourlyPayRate: </TD>
    <TD>
	
		<INPUT type="text" name="HourlyPayRate" value="#HourlyPayRate_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="HourlyPayRate_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> MonthlySalary: </TD>
    <TD>
	
		<INPUT type="text" name="MonthlySalary" value="#MonthlySalary_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="MonthlySalary_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> Commenced: </TD>
    <TD>
	
		<INPUT type="text" name="Commenced" value="#Commenced_Value#" maxLength="16">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Finished: </TD>
    <TD>
	
		<INPUT type="text" name="Finished" value="#Finished_Value#" maxLength="16">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> entLeaveAvail: </TD>
    <TD>
	
		<INPUT type="text" name="entLeaveAvail" value="#entLeaveAvail_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="entLeaveAvail_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> entLeaveTaken: </TD>
    <TD>
	
		<INPUT type="text" name="entLeaveTaken" value="#entLeaveTaken_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="entLeaveTaken_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> entSickAvail: </TD>
    <TD>
	
		<INPUT type="text" name="entSickAvail" value="#entSickAvail_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="entSickAvail_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> entSickTaken: </TD>
    <TD>
	
		<INPUT type="text" name="entSickTaken" value="#entSickTaken_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="entSickTaken_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> ytdGross: </TD>
    <TD>
	
		<INPUT type="text" name="ytdGross" value="#ytdGross_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ytdGross_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> ytdTax: </TD>
    <TD>
	
		<INPUT type="text" name="ytdTax" value="#ytdTax_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ytdTax_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> ytdNetPay: </TD>
    <TD>
	
		<INPUT type="text" name="ytdNetPay" value="#ytdNetPay_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ytdNetPay_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> ytdSuper: </TD>
    <TD>
	
		<INPUT type="text" name="ytdSuper" value="#ytdSuper_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ytdSuper_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> NoLongerUsed: </TD>
    <TD>
	
		<INPUT type="radio" name="NoLongerUsed" value="1"<CFIF #NoLongerUsed_Value# is 1> checked</CFIF>> Yes
		<INPUT type="radio" name="NoLongerUsed" value="0"<CFIF #NoLongerUsed_Value# is 0> checked</CFIF>> No
	
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> UserTypeID: </TD>
    <TD>
	
		<INPUT type="text" name="UserTypeID" value="#UserTypeID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="UserTypeID_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> UserName: </TD>
    <TD>
	
		<INPUT type="text" name="UserName" value="#UserName_Value#" maxLength="20">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Password: </TD>
    <TD>
	
		<INPUT type="text" name="Password" value="#Password_Value#" maxLength="20">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> CarAllowancePerWeek: </TD>
    <TD>
	
		<INPUT type="text" name="CarAllowancePerWeek" value="#CarAllowancePerWeek_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="CarAllowancePerWeek_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> OtherAllowancePerWeek: </TD>
    <TD>
	
		<INPUT type="text" name="OtherAllowancePerWeek" value="#OtherAllowancePerWeek_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="OtherAllowancePerWeek_float">
	</TR>
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>



</BODY></HTML>
