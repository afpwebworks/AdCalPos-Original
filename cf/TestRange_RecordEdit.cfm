
<CFSET FormFieldList = "PartNo,Description,SupplyUnit,MaxRetail">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" dataSource="costi" maxRows=1>
		SELECT tblStockMaster.PartNo, tblStockMaster.Description, tblStockMaster.SupplyUnit, tblStockMaster.MaxRetail, tblStockMaster.PartNo AS ID_Field
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
				
			<CFSET MaxRetail_Value = #GetRecord.MaxRetail#>
		

<CFELSE>

			
			<CFSET PartNo_Value = ''>
				
			<CFSET Description_Value = ''>
				
			<CFSET SupplyUnit_Value = ''>
				
			<CFSET MaxRetail_Value = '0'>
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestRange - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestRange</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestRange_RecordAction.cfm" method="post">
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
	
		<INPUT type="text" name="PartNo" value="#PartNo_Value#" maxLength="16">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	</CFIF>
	
	
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
	
		<INPUT type="text" name="Description" value="#Description_Value#" maxLength="40">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> SupplyUnit: </TD>
    <TD>
	
		<INPUT type="text" name="SupplyUnit" value="#SupplyUnit_Value#" maxLength="3">
		
	</TD>
	<!--- field validation --->
	</TR>
	
	
	<TR>
	<TD valign="top"> MaxRetail: </TD>
    <TD>
	
		<INPUT type="text" name="MaxRetail" value="#MaxRetail_Value#" maxLength="10">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="MaxRetail_range" Value = "MIN=5 MAX=50">
	<INPUT type="hidden" name="MaxRetail_required" Value = "Please enter the Max Retail value" >
	</TR>
		
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>



</BODY></HTML>
