
<CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
<!--- <CFQUERY name="GetRecord" dataSource="costi" maxRows=1> --->
	SELECT tblStockMaster.PartNo AS ViewField1, tblStockMaster.Description AS ViewField2, tblStockMaster.SupplyUnit AS ViewField3, tblStockMaster.OrderingUnit AS ViewField4, tblStockMaster.Label AS ViewField5, tblStockMaster.GroupNo AS ViewField6, tblStockMaster.TCode AS ViewField7, tblStockMaster.PCode AS ViewField8, tblStockMaster.RCode AS ViewField9, tblStockMaster.Tolerance AS ViewField10, tblStockMaster.PartNo AS ID_Field
	FROM tblStockMaster
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblStockMaster.PartNo = '#URL.RecordID#'
	</CFIF>
</CFQUERY>


<HTML><HEAD>
	<TITLE>TestSQL2 - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQL2</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestSQL2_RecordAction.cfm" method="post">
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
	<TD valign="top"> OrderingUnit: </TD>
	<TD> #ViewField4# </TD>
	</TR>

	<TR>
	<TD valign="top"> Label: </TD>
	<TD> #ViewField5# </TD>
	</TR>

	<TR>
	<TD valign="top"> GroupNo: </TD>
	<TD> #ViewField6# </TD>
	</TR>

	<TR>
	<TD valign="top"> TCode: </TD>
	<TD> #ViewField7# </TD>
	</TR>

	<TR>
	<TD valign="top"> PCode: </TD>
	<TD> #ViewField8# </TD>
	</TR>

	<TR>
	<TD valign="top"> RCode: </TD>
	<TD> #ViewField9# </TD>
	</TR>

	<TR>
	<TD valign="top"> Tolerance: </TD>
	<TD> #ViewField10# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
