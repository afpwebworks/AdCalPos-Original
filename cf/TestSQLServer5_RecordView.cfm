
<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1 USERNAME="vs139312_1_dbo" PASSWORD="gmsne4848n">
	SELECT tblStores.StoreID AS ViewField1, tblStores.StoreName AS ViewField2, tblStores.Manager1Name AS ViewField3, tblStores.Manager2Name AS ViewField4, tblStores.StoreGroupID AS ViewField5, tblStores.Phone AS ViewField6, tblStores.Fax AS ViewField7, tblStores.Mobile AS ViewField8, tblStores.email AS ViewField9, tblStores.AcctBalance AS ViewField10, tblStores.CreditLimit AS ViewField11, tblStores.NoLongerUsed AS ViewField12, tblStores.FridayFactor AS ViewField13, tblStores.DateEntered AS ViewField14, tblStores.ChainID AS ViewField15, tblStores.ABN AS ViewField16, tblStores.StoreID AS ID_Field
	FROM tblStores
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblStores.StoreID = #URL.RecordID#
	</CFIF>
</CFQUERY>

<HTML><HEAD>
	<TITLE>TestSQLServer5 - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLServer5</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestSQLServer5_RecordAction.cfm" method="post">
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
	<TD valign="top"> StoreID: </TD>
	<TD> #ViewField1# </TD>
	</TR>

	<TR>
	<TD valign="top"> StoreName: </TD>
	<TD> #ViewField2# </TD>
	</TR>

	<TR>
	<TD valign="top"> Manager1Name: </TD>
	<TD> #ViewField3# </TD>
	</TR>

	<TR>
	<TD valign="top"> Manager2Name: </TD>
	<TD> #ViewField4# </TD>
	</TR>

	<TR>
	<TD valign="top"> StoreGroupID: </TD>
	<TD> #ViewField5# </TD>
	</TR>

	<TR>
	<TD valign="top"> Phone: </TD>
	<TD> #ViewField6# </TD>
	</TR>

	<TR>
	<TD valign="top"> Fax: </TD>
	<TD> #ViewField7# </TD>
	</TR>

	<TR>
	<TD valign="top"> Mobile: </TD>
	<TD> #ViewField8# </TD>
	</TR>

	<TR>
	<TD valign="top"> email: </TD>
	<TD> #ViewField9# </TD>
	</TR>

	<TR>
	<TD valign="top"> AcctBalance: </TD>
	<TD> #ViewField10# </TD>
	</TR>

	<TR>
	<TD valign="top"> CreditLimit: </TD>
	<TD> #ViewField11# </TD>
	</TR>

	<TR>
	<TD valign="top"> NoLongerUsed: </TD>
	<TD> #ViewField12# </TD>
	</TR>

	<TR>
	<TD valign="top"> FridayFactor: </TD>
	<TD> #ViewField13# </TD>
	</TR>

	<TR>
	<TD valign="top"> DateEntered: </TD>
	<TD> #ViewField14# </TD>
	</TR>

	<TR>
	<TD valign="top"> ChainID: </TD>
	<TD> #ViewField15# </TD>
	</TR>

	<TR>
	<TD valign="top"> ABN: </TD>
	<TD> #ViewField16# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
