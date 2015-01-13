
<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetRecord" dataSource="costi" maxRows=1> --->
	SELECT tblStockLocation.ID AS ViewField1, tblStockLocation.PartNo AS ViewField2, tblStockLocation.Prev_QtyOnHand AS ViewField3, tblStockLocation.Freezer_QtyOnHand AS ViewField4, tblStockLocation.CoolRoom_QtyOnHand AS ViewField5, tblStockLocation.Display_QtyOnHand AS ViewField6, tblStockLocation.ID AS ID_Field
	FROM tblStockLocation
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblStockLocation.ID = #URL.RecordID#
	</CFIF>
</CFQUERY>

<HTML><HEAD>
	<TITLE>StocktakeAdjust - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">StocktakeAdjust</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="StocktakeAdjust_RecordAction.cfm" method="post">
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
	<TD valign="top"> ID: </TD>
	<TD> #ViewField1# </TD>
	</TR>

	<TR>
	<TD valign="top"> PartNo: </TD>
	<TD> #ViewField2# </TD>
	</TR>

	<TR>
	<TD valign="top"> Prev_QtyOnHand: </TD>
	<TD> #ViewField3# </TD>
	</TR>

	<TR>
	<TD valign="top"> Freezer_QtyOnHand: </TD>
	<TD> #ViewField4# </TD>
	</TR>

	<TR>
	<TD valign="top"> CoolRoom_QtyOnHand: </TD>
	<TD> #ViewField5# </TD>
	</TR>

	<TR>
	<TD valign="top"> Display_QtyOnHand: </TD>
	<TD> #ViewField6# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
