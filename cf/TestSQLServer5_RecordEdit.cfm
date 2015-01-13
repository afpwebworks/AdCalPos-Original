
<CFSET FormFieldList = "StoreID,StoreName,Manager1Name,Manager2Name,StoreGroupID,Phone,Fax,Mobile,email,AcctBalance,CreditLimit,NoLongerUsed,FridayFactor,DateEntered,ChainID,ABN">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1 USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">
		SELECT tblStores.StoreID, tblStores.StoreName, tblStores.Manager1Name, tblStores.Manager2Name, tblStores.StoreGroupID, tblStores.Phone, tblStores.Fax, tblStores.Mobile, tblStores.email, tblStores.AcctBalance, tblStores.CreditLimit, tblStores.NoLongerUsed, tblStores.FridayFactor, tblStores.DateEntered, tblStores.ChainID, tblStores.ABN, tblStores.StoreID AS ID_Field
		FROM tblStores
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblStores.StoreID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "StoreID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "StoreID" )>
	</CFIF>

			
			<CFSET StoreID_Value = #GetRecord.StoreID#>
				
			<CFSET StoreName_Value = '#GetRecord.StoreName#'>
				
			<CFSET Manager1Name_Value = '#GetRecord.Manager1Name#'>
				
			<CFSET Manager2Name_Value = '#GetRecord.Manager2Name#'>
				
			<CFSET StoreGroupID_Value = #GetRecord.StoreGroupID#>
				
			<CFSET Phone_Value = '#GetRecord.Phone#'>
				
			<CFSET Fax_Value = '#GetRecord.Fax#'>
				
			<CFSET Mobile_Value = '#GetRecord.Mobile#'>
				
			<CFSET email_Value = '#GetRecord.email#'>
				
			<CFSET AcctBalance_Value = #GetRecord.AcctBalance#>
				
			<CFSET CreditLimit_Value = #GetRecord.CreditLimit#>
				
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>
				
			<CFSET FridayFactor_Value = #GetRecord.FridayFactor#>
				
			<CFSET DateEntered_Value = #GetRecord.DateEntered#>
				
			<CFSET ChainID_Value = #GetRecord.ChainID#>
				
			<CFSET ABN_Value = '#GetRecord.ABN#'>
		

<CFELSE>

			
			<CFSET StoreID_Value = ''>
				
			<CFSET StoreName_Value = ''>
				
			<CFSET Manager1Name_Value = ''>
				
			<CFSET Manager2Name_Value = ''>
				
			<CFSET StoreGroupID_Value = ''>
				
			<CFSET Phone_Value = ''>
				
			<CFSET Fax_Value = ''>
				
			<CFSET Mobile_Value = ''>
				
			<CFSET email_Value = ''>
				
			<CFSET AcctBalance_Value = ''>
				
			<CFSET CreditLimit_Value = ''>
				
			<CFSET NoLongerUsed_Value = 0>
				
			<CFSET FridayFactor_Value = ''>
				
			<CFSET DateEntered_Value = ''>
				
			<CFSET ChainID_Value = ''>
				
			<CFSET ABN_Value = ''>
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestSQLServer5 - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLServer5</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestSQLServer5_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="StoreID" value="#URL.RecordID#">
</CFIF>


<TABLE>

	
	<CFIF not ParameterExists(URL.RecordID)>
	
	<TR>
	<TD valign="top"> StoreID: </TD>
    <TD>
	
		<INPUT type="text" name="StoreID" value="#StoreID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="StoreID_integer">
	</TR>
	
	</CFIF>
	
	
	<TR>
	<TD valign="top"> StoreName: </TD>
    <TD>
	
		<INPUT type="text" name="StoreName" value="#StoreName_Value#" maxLength="60">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Manager1Name: </TD>
    <TD>
	
		<INPUT type="text" name="Manager1Name" value="#Manager1Name_Value#" maxLength="100">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Manager2Name: </TD>
    <TD>
	
		<INPUT type="text" name="Manager2Name" value="#Manager2Name_Value#" maxLength="100">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> StoreGroupID: </TD>
    <TD>
	
		<INPUT type="text" name="StoreGroupID" value="#StoreGroupID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="StoreGroupID_integer">
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
	<TD valign="top"> email: </TD>
    <TD>
	
		<INPUT type="text" name="email" value="#email_Value#" maxLength="140">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> AcctBalance: </TD>
    <TD>
	
		<INPUT type="text" name="AcctBalance" value="#AcctBalance_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="AcctBalance_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> CreditLimit: </TD>
    <TD>
	
		<INPUT type="text" name="CreditLimit" value="#CreditLimit_Value#" maxLength="21">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="CreditLimit_float">
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
	<TD valign="top"> FridayFactor: </TD>
    <TD>
	
		<INPUT type="text" name="FridayFactor" value="#FridayFactor_Value#" maxLength="8">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="FridayFactor_float">
	</TR>
	
	
	<TR>
	<TD valign="top"> DateEntered: </TD>
    <TD>
	
		<INPUT type="text" name="DateEntered" value="#DateEntered_Value#" maxLength="16">
		(i.e. 12/31/97)
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="DateEntered_date">
	</TR>
	
	
	<TR>
	<TD valign="top"> ChainID: </TD>
    <TD>
	
		<INPUT type="text" name="ChainID" value="#ChainID_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ChainID_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> ABN: </TD>
    <TD>
	
		<INPUT type="text" name="ABN" value="#ABN_Value#" maxLength="40">
		
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
