
<CFSET FormFieldList = "BundyNo,StoreID,GivenName,Surname,TaxFileNo,Street,Address1,Address2,PostCode,State,Phone,Fax,Mobile,Email,BirthDay">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1>
		SELECT qryEmployee.BundyNo, qryEmployee.StoreID, qryEmployee.GivenName, qryEmployee.Surname, qryEmployee.TaxFileNo, qryEmployee.Street, qryEmployee.Address1, qryEmployee.Address2, qryEmployee.PostCode, qryEmployee.State, qryEmployee.Phone, qryEmployee.Fax, qryEmployee.Mobile, qryEmployee.Email, qryEmployee.BirthDay, qryEmployee.TheStoreID AS ID_Field
		FROM qryEmployee
		<CFIF ParameterExists(URL.RecordID)>
		WHERE qryEmployee.TheStoreID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "TheStoreID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "TheStoreID" )>
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
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestSQLServer1 - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLServer1</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestSQLServer1_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="TheStoreID" value="#URL.RecordID#">
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
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>



</BODY></HTML>
