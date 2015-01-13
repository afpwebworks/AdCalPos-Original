
<CFSET FormFieldList = "PartNo,Description,SupplyUnit,OrderingUnit,Label,GroupNo,TCode,PCode,RCode">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" dataSource="CostiDSN" maxRows=1>
		SELECT tblStockMaster.PartNo, tblStockMaster.Description, tblStockMaster.SupplyUnit, tblStockMaster.OrderingUnit, tblStockMaster.Label, tblStockMaster.GroupNo, tblStockMaster.TCode, tblStockMaster.PCode, tblStockMaster.RCode, tblStockMaster.PartNo AS ID_Field
		FROM tblStockMaster
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblStockMaster.PartNo = '#URL.RecordID#'
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "PartNo" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "PartNo" )>
	</CFIF>

			
			<CFSET PartNo_Value = '#GetRecord.PartNo#'>
				
			<CFSET Description_Value = '#GetRecord.Description#'>
				
			<CFSET SupplyUnit_Value = '#GetRecord.SupplyUnit#'>
				
			<CFSET OrderingUnit_Value = '#GetRecord.OrderingUnit#'>
				
			<CFSET Label_Value = '#GetRecord.Label#'>
				
			<CFSET GroupNo_Value = #GetRecord.GroupNo#>
				
			<CFSET TCode_Value = #GetRecord.TCode#>
				
			<CFSET PCode_Value = #GetRecord.PCode#>
				
			<CFSET RCode_Value = #GetRecord.RCode#>
		

<CFELSE>

			
			<CFSET PartNo_Value = ''>
				
			<CFSET Description_Value = ''>
				
			<CFSET SupplyUnit_Value = ''>
				
			<CFSET OrderingUnit_Value = ''>
				
			<CFSET Label_Value = ''>
				
			<CFSET GroupNo_Value = ''>
				
			<CFSET TCode_Value = ''>
				
			<CFSET PCode_Value = ''>
				
			<CFSET RCode_Value = ''>
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestSQL2 - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQL2</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestSQL2_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="PartNo" value="#URL.RecordID#">
</CFIF>


<TABLE>

	
	<CFIF not ParameterExists(URL.RecordID)>
	
	<TR>
	<TD valign="top"> PartNo: </TD>
    <TD>
	
		<INPUT type="text" name="PartNo" value="#PartNo_Value#" maxLength="32">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	</CFIF>
	
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<INPUT type="text" name="Description" value="#Description_Value#" maxLength="80">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> SupplyUnit: </TD>
    <TD>
	
		<INPUT type="text" name="SupplyUnit" value="#SupplyUnit_Value#" maxLength="6">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> OrderingUnit: </TD>
    <TD>
	
		<INPUT type="text" name="OrderingUnit" value="#OrderingUnit_Value#" maxLength="6">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> Label: </TD>
    <TD>
	
		<INPUT type="text" name="Label" value="#Label_Value#" maxLength="110">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> GroupNo: </TD>
    <TD>
	
		<INPUT type="text" name="GroupNo" value="#GroupNo_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="GroupNo_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> TCode: </TD>
    <TD>
	
		<INPUT type="text" name="TCode" value="#TCode_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="TCode_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> PCode: </TD>
    <TD>
	
		<INPUT type="text" name="PCode" value="#PCode_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="PCode_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> RCode: </TD>
    <TD>
	
		<INPUT type="text" name="RCode" value="#RCode_Value#" maxLength="4">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="RCode_integer">
	</TR>
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>



</BODY></HTML>





