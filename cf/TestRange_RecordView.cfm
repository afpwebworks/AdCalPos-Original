
<CFQUERY name="GetRecord" dataSource="costi" maxRows=1>
	SELECT tblStockMaster.PartNo AS ViewField1, tblStockMaster.Description AS ViewField2, tblStockMaster.SupplyUnit AS ViewField3, tblStockMaster.MaxRetail AS ViewField4, tblStockMaster.PartNo AS ID_Field
	FROM tblStockMaster
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblStockMaster.PartNo = '#URL.RecordID#'
	</CFIF>
</CFQUERY>


<HTML><HEAD>
	<TITLE>TestRange - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestRange</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestRange_RecordAction.cfm" method="post">
	<INPUT type="hidden" name="RecordID" value="#ID_Field#">

	<!--- form buttons --->
	<INPUT type="submit" name="btnView_First" value=" << ">
	<INPUT type="submit" name="btnView_Previous" value="  <  ">
	<INPUT type="submit" name="btnView_Next" value="  >  ">
	<INPUT type="submit" name="btnView_Last" value=" >> ">
	<INPUT type="submit" name="btnView_Add" value="   Add    ">
	<INPUT type="submit" name="btnView_Edit" value="  Edit  ">
	<INPUT type="submit" name="btnView_Delete" value="Delete">

</FORM>


<TABLE>

	<TR>
	<TD valign="top"> PartNo: </TD>
	<TD> #ViewField1# </TD>
	</TR>

	<TR>
	<TD valign="top"> Description: </TD>
	<TD> #ViewField2# </TD>
	</TR>

	<TR>
	<TD valign="top"> SupplyUnit: </TD>
	<TD> #ViewField3# </TD>
	</TR>

	<TR>
	<TD valign="top"> MaxRetail: </TD>
	<TD> #ViewField4# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
