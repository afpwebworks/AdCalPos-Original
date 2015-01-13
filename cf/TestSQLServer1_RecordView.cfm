
<CFQUERY name="GetRecord" dataSource="vs139312_1_x" maxRows=1>
	SELECT qryEmployee.EmployeeID AS ViewField1, qryEmployee.BundyNo AS ViewField2, qryEmployee.StoreID AS ViewField3, qryEmployee.GivenName AS ViewField4, qryEmployee.Surname AS ViewField5, qryEmployee.TaxFileNo AS ViewField6, qryEmployee.Street AS ViewField7, qryEmployee.Address1 AS ViewField8, qryEmployee.Address2 AS ViewField9, qryEmployee.PostCode AS ViewField10, qryEmployee.State AS ViewField11, qryEmployee.Phone AS ViewField12, qryEmployee.Fax AS ViewField13, qryEmployee.Mobile AS ViewField14, qryEmployee.Email AS ViewField15, qryEmployee.BirthDay AS ViewField16, qryEmployee.EmpStatusID AS ViewField17, qryEmployee.HourlyPayRate AS ViewField18, qryEmployee.MonthlySalary AS ViewField19, qryEmployee.Commenced AS ViewField20, qryEmployee.Finished AS ViewField21, qryEmployee.entLeaveAvail AS ViewField22, qryEmployee.TheStoreID AS ID_Field
	FROM qryEmployee
	<CFIF ParameterExists(URL.RecordID)>
	WHERE qryEmployee.TheStoreID = #URL.RecordID#
	</CFIF>
</CFQUERY>


<HTML><HEAD>
	<TITLE>TestSQLServer1 - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLServer1</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestSQLServer1_RecordAction.cfm" method="post">
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
	<TD valign="top"> EmployeeID: </TD>
	<TD> #ViewField1# </TD>
	</TR>

	<TR>
	<TD valign="top"> BundyNo: </TD>
	<TD> #ViewField2# </TD>
	</TR>

	<TR>
	<TD valign="top"> StoreID: </TD>
	<TD> #ViewField3# </TD>
	</TR>

	<TR>
	<TD valign="top"> GivenName: </TD>
	<TD> #ViewField4# </TD>
	</TR>

	<TR>
	<TD valign="top"> Surname: </TD>
	<TD> #ViewField5# </TD>
	</TR>

	<TR>
	<TD valign="top"> TaxFileNo: </TD>
	<TD> #ViewField6# </TD>
	</TR>

	<TR>
	<TD valign="top"> Street: </TD>
	<TD> #ViewField7# </TD>
	</TR>

	<TR>
	<TD valign="top"> Address1: </TD>
	<TD> #ViewField8# </TD>
	</TR>

	<TR>
	<TD valign="top"> Address2: </TD>
	<TD> #ViewField9# </TD>
	</TR>

	<TR>
	<TD valign="top"> PostCode: </TD>
	<TD> #ViewField10# </TD>
	</TR>

	<TR>
	<TD valign="top"> State: </TD>
	<TD> #ViewField11# </TD>
	</TR>

	<TR>
	<TD valign="top"> Phone: </TD>
	<TD> #ViewField12# </TD>
	</TR>

	<TR>
	<TD valign="top"> Fax: </TD>
	<TD> #ViewField13# </TD>
	</TR>

	<TR>
	<TD valign="top"> Mobile: </TD>
	<TD> #ViewField14# </TD>
	</TR>

	<TR>
	<TD valign="top"> Email: </TD>
	<TD> #ViewField15# </TD>
	</TR>

	<TR>
	<TD valign="top"> BirthDay: </TD>
	<TD> #ViewField16# </TD>
	</TR>

	<TR>
	<TD valign="top"> EmpStatusID: </TD>
	<TD> #ViewField17# </TD>
	</TR>

	<TR>
	<TD valign="top"> HourlyPayRate: </TD>
	<TD> #ViewField18# </TD>
	</TR>

	<TR>
	<TD valign="top"> MonthlySalary: </TD>
	<TD> #ViewField19# </TD>
	</TR>

	<TR>
	<TD valign="top"> Commenced: </TD>
	<TD> #ViewField20# </TD>
	</TR>

	<TR>
	<TD valign="top"> Finished: </TD>
	<TD> #ViewField21# </TD>
	</TR>

	<TR>
	<TD valign="top"> entLeaveAvail: </TD>
	<TD> #ViewField22# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
