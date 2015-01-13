
<HTML><HEAD>
    <TITLE>TestDrill - Search Form</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestDrill</FONT> <BR>
<FONT size="+2"><B>Search Form</B></FONT>

<!--- Search form --->
<FORM action="TestDrill_Result.cfm" method="post">

<TABLE>


	<!--- Field: tblStockMaster.PartNo=CHAR;32;FALSE --->
	<INPUT type="hidden" name="Crit1_FieldName" value="tblStockMaster.PartNo">
	
	<INPUT type="hidden" name="Crit1_FieldType" value="CHAR">
	<TR>
	<TD>PartNo</TD>
	<TD><SELECT name="Crit1_Operator">
		
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="SMALLER_THAN">before
			<OPTION value="GREATER_THAN">after
		
		</SELECT>
	</TD>
	<TD>
	
	<INPUT type="text" name="Crit1_Value">
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.Description=CHAR;80;FALSE --->
	<INPUT type="hidden" name="Crit2_FieldName" value="tblStockMaster.Description">
	
	<INPUT type="hidden" name="Crit2_FieldType" value="CHAR">
	<TR>
	<TD>Description</TD>
	<TD><SELECT name="Crit2_Operator">
		
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="SMALLER_THAN">before
			<OPTION value="GREATER_THAN">after
		
		</SELECT>
	</TD>
	<TD>
	
	<INPUT type="text" name="Crit2_Value">
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.GroupNo=INT;4;FALSE --->
	<INPUT type="hidden" name="Crit3_FieldName" value="tblStockMaster.GroupNo">
	<INPUT type="hidden" name="Crit3_Value_integer">
	
	<INPUT type="hidden" name="Crit3_FieldType" value="INT">
	<TR>
	<TD>GroupNo</TD>
	<TD><SELECT name="Crit3_Operator">
		
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		
		</SELECT>
	</TD>
	<TD>
	
	<INPUT type="text" name="Crit3_Value">
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.RCode=INT;4;FALSE --->
	<INPUT type="hidden" name="Crit4_FieldName" value="tblStockMaster.RCode">
	<INPUT type="hidden" name="Crit4_Value_integer">
	
	<INPUT type="hidden" name="Crit4_FieldType" value="INT">
	<TR>
	<TD>RCode</TD>
	<TD><SELECT name="Crit4_Operator">
		
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		
		</SELECT>
	</TD>
	<TD>
	
	<INPUT type="text" name="Crit4_Value">
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.PluType=CHAR;2;FALSE --->
	<INPUT type="hidden" name="Crit5_FieldName" value="tblStockMaster.PluType">
	
	<INPUT type="hidden" name="Crit5_FieldType" value="CHAR">
	<TR>
	<TD>PluType</TD>
	<TD><SELECT name="Crit5_Operator">
		
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="SMALLER_THAN">before
			<OPTION value="GREATER_THAN">after
		
		</SELECT>
	</TD>
	<TD>
	
	<INPUT type="text" name="Crit5_Value">
	
	</TD>
	</TR>


</TABLE>
<P>
<INPUT type="submit">

</FORM>

</BODY></HTML>
