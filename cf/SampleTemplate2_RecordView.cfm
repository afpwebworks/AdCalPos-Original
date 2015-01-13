
<cfset strQuery = "SELECT tblStockGroup.Group, IIf([NoLongerUsed]=0,'No','Yes') AS NLU, IIf([SuppressOrder]=0,'No','Yes') AS SupOrd, tblStockMaster.* ">
<cfset strQuery = strQuery & "FROM tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo ">
	<CFIF ParameterExists(URL.RecordID)>
		<cfset strQuery = strQuery & "WHERE tblStockMaster.PartNo = '#URL.RecordID#'">
	</CFIF>

<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord" maxRows=1>
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<HTML><HEAD>
	<TITLE>SampleTemplate2 - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">SampleTemplate2</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="SampleTemplate2_RecordAction.cfm" method="post">
	<INPUT type="hidden" name="RecordID" value="#GetRecord.PartNo#">

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
	<TD valign="top"> PLU: </TD>
	<TD> #GetRecord.PartNo# </TD>
	</TR>

	<TR>
	<TD valign="top"> Description: </TD>
	<TD> #GetRecord.Description# </TD>
	</TR>

	<TR>
	<TD valign="top"> Group: </TD>
	<TD> #GetRecord.Group# </TD>
	</TR>

	<TR>
	<TD valign="top"> TCode: </TD>
	<TD> #GetRecord.TCode# </TD>
	</TR>

	<TR>
	<TD valign="top"> PCode: </TD>
	<TD> #GetRecord.PCode# </TD>
	</TR>

	<TR>
	<TD valign="top"> PluType: </TD>
	<TD> #GetRecord.PluType# </TD>
	</TR>

	<TR>
	<TD valign="top"> NoLongerUsed: </TD>
	<TD> #GetRecord.NLU# </TD>
	</TR>

	<TR>
	<TD valign="top"> SuppressOrder: </TD>
	<TD> #GetRecord.SupOrd# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
