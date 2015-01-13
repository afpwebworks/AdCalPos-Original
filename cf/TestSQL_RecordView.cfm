
<!--- <CFQUERY NAME="query_name"
    DATASOURCE="ds_name"
    DBTYPE="type"
    DBSERVER="dbms"
    DBNAME="database name"
    USERNAME="username"
    PASSWORD="password"
    MAXROWS="number"
    BLOCKFACTOR="blocksize"
    TIMEOUT="milliseconds"
    CACHEDAFTER="date" 
    CACHEDWITHIN="timespan" 
    PROVIDER="COMProvider" 
    PROVIDERDSN="datasource" 
    DEBUG="Yes/No">
 ---> 
<!--- SQL statements --->
<CFQUERY  DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="CostiSQL" PROVIDERDSN="CostiSQL" USERNAME="sa" PASSWORD="" name="GetRecord">
<!--- <CFQUERY name="GetRecord" dataSource="CostiDSN" maxRows=1> --->
	SELECT tblEmployee.EmployeeID AS ViewField1, tblEmployee.BundyNo AS ViewField2, tblEmployee.StoreID AS ViewField3, tblEmployee.GivenName AS ViewField4, tblEmployee.Surname AS ViewField5, tblEmployee.TaxFileNo AS ViewField6, tblEmployee.Street AS ViewField7, tblEmployee.Address1 AS ViewField8, tblEmployee.Address2 AS ViewField9, tblEmployee.PostCode AS ViewField10, tblEmployee.State AS ViewField11, tblEmployee.Phone AS ViewField12, tblEmployee.Fax AS ViewField13, tblEmployee.Mobile AS ViewField14, tblEmployee.Email AS ViewField15, tblEmployee.BirthDay AS ViewField16, tblEmployee.EmpStatusID AS ViewField17, tblEmployee.HourlyPayRate AS ViewField18, tblEmployee.MonthlySalary AS ViewField19, tblEmployee.Commenced AS ViewField20, tblEmployee.Finished AS ViewField21, tblEmployee.entLeaveAvail AS ViewField22, tblEmployee.entLeaveTaken AS ViewField23, tblEmployee.entSickAvail AS ViewField24, tblEmployee.entSickTaken AS ViewField25, tblEmployee.ytdGross AS ViewField26, tblEmployee.ytdTax AS ViewField27, tblEmployee.ytdNetPay AS ViewField28, tblEmployee.ytdSuper AS ViewField29, tblEmployee.NoLongerUsed AS ViewField30,  tblEmployee.UserName AS ViewField32, tblEmployee.Password AS ViewField33, tblEmployee.DateEntered AS ViewField34, tblEmployee.EmployeeID AS ID_Field
	FROM tblEmployee
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblEmployee.EmployeeID = #URL.RecordID#
	</CFIF>
</CFQUERY>


<HTML><HEAD>
	<TITLE>TestSQL - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQL</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestSQL_RecordAction.cfm" method="post">
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

	<TR>
	<TD valign="top"> entLeaveTaken: </TD>
	<TD> #ViewField23# </TD>
	</TR>

	<TR>
	<TD valign="top"> entSickAvail: </TD>
	<TD> #ViewField24# </TD>
	</TR>

	<TR>
	<TD valign="top"> entSickTaken: </TD>
	<TD> #ViewField25# </TD>
	</TR>

	<TR>
	<TD valign="top"> ytdGross: </TD>
	<TD> #ViewField26# </TD>
	</TR>

	<TR>
	<TD valign="top"> ytdTax: </TD>
	<TD> #ViewField27# </TD>
	</TR>

	<TR>
	<TD valign="top"> ytdNetPay: </TD>
	<TD> #ViewField28# </TD>
	</TR>

	<TR>
	<TD valign="top"> ytdSuper: </TD>
	<TD> #ViewField29# </TD>
	</TR>

	<TR>
	<TD valign="top"> NoLongerUsed: </TD>
	<TD> #ViewField30# </TD>
	</TR>

	<TR>
	<TD valign="top"> UserType: </TD>
	<TD> #ViewField31# </TD>
	</TR>

	<TR>
	<TD valign="top"> UserName: </TD>
	<TD> #ViewField32# </TD>
	</TR>

	<TR>
	<TD valign="top"> Password: </TD>
	<TD> #ViewField33# </TD>
	</TR>

	<TR>
	<TD valign="top"> DateEntered: </TD>
	<TD> #ViewField34# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
