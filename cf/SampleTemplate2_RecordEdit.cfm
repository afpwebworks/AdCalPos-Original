
<CFSET FormFieldList = "PartNo,Description,GroupNo,TCode,PCode,NoLongerUsed,SuppressOrder">

<!--- Get the combo values --->
<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetCombo">
	SELECT tblStockGroup.GroupNo, tblStockGroup.Group
	FROM tblStockGroup
	ORDER BY tblStockGroup.Group
</CFQUERY>

<CFIF ParameterExists(URL.RecordID)>
    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord" maxRows=1>
		SELECT tblStockMaster.PartNo, tblStockMaster.Description, tblStockMaster.GroupNo, tblStockMaster.TCode, tblStockMaster.PCode, tblStockMaster.NoLongerUsed, tblStockMaster.SuppressOrder, tblStockMaster.PartNo AS ID_Field
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
				
			<CFSET GroupNo_Value = #GetRecord.GroupNo#>
				
			<CFSET TCode_Value = #GetRecord.TCode#>
				
			<CFSET PCode_Value = #GetRecord.PCode#>
				
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>
				
			<CFSET SuppressOrder_Value = #GetRecord.SuppressOrder#>
		

<CFELSE>

			
			<CFSET PartNo_Value = ''>
				
			<CFSET Description_Value = ''>
				
			<CFSET GroupNo_Value = ''>
				
			<CFSET TCode_Value = '0'>
				
			<CFSET PCode_Value = '0'>
				
			<CFSET NoLongerUsed_Value = 0>
				
			<CFSET SuppressOrder_Value = 0>
		

</CFIF>


<HTML><HEAD>
	<TITLE>SampleTemplate2 - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">SampleTemplate2</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="SampleTemplate2_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="PartNo" value="#URL.RecordID#">
</CFIF>


<TABLE>

	
	<CFIF not ParameterExists(URL.RecordID)>
	
	<TR>
	<TD valign="top"> PLU: </TD>
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
	<TD valign="top"> Group: </TD>
    <TD>
         </cfoutput>
		  <select name="GroupNo">
          	   <cfif (#GroupNo_Value# EQ 0) or (#GroupNo_Value# EQ '') >
               		<option value="0" selected>None</option>
	           <cfelse>
    	           	<option value="0">None</option>
        	   </cfif>
		        <cfoutput query = "GetCombo" >
			        	<cfif #GroupNo_Value# EQ #GetCombo.GroupNo#>
                    		<option value="#GetCombo.GroupNo#" selected>#GetCombo.Group#</option>
	                    <cfelse>
    	                	<option value="#GetCombo.GroupNo#">#GetCombo.Group#</option>
        	            </cfif>
				</cfoutput>
          </select>
		  <cfoutput>
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="GroupNo_integer">
	</TR>
	
	
	<TR>
	<TD valign="top"> TCode: </TD>
    <TD>
	
		<INPUT type="text" name="TCode" value="#TCode_Value#" maxLength="10">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="TCode_integer">
	<INPUT type="hidden" name="TCode_required" value="Please type T code.">	
	</TR>
	
	
	<TR>
	<TD valign="top"> PCode: </TD>
    <TD>
	
		<INPUT type="text" name="PCode" value="#PCode_Value#" maxLength="10">
		
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="PCode_integer">
	<INPUT type="hidden" name="PCode_required" value="Please type P code.">	
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
	<TD valign="top"> SuppressOrder: </TD>
    <TD>
	
		<INPUT type="radio" name="SuppressOrder" value="1"<CFIF #SuppressOrder_Value# is 1> checked</CFIF>> Yes
		<INPUT type="radio" name="SuppressOrder" value="0"<CFIF #SuppressOrder_Value# is 0> checked</CFIF>> No
	
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
