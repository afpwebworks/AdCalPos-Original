
<!--- <CFQUERY name="GetRecord" dataSource="CostiDSN" maxRows=1> --->
<!--- <CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="Microsoft.Jet.OLEDB.4.0" dataSource="E:\InetPub\vs166129\ssl\costi\database\costi.mdb" PROVIDERDSN="E:\InetPub\vs166129\ssl\costi\database\costi.mdb" USERNAME="admin"> --->
<cfparam name="LocalAppCostiDB" default="#Applic_AppRoot#">

<CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="Microsoft.Jet.OLEDB.4.0" dataSource="#LocalAppCostiDB#costi.mdb" PROVIDERDSN="#LocalAppCostiDB#costi.mdb" USERNAME="admin">
	
	SELECT tblPictureFile.PictureFileID AS ViewField1, tblPictureFile.PictureFileName AS ViewField2, tblPictureFile.PictureFileID AS ID_Field
	FROM tblPictureFile
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblPictureFile.PictureFileID = #URL.RecordID#
	</CFIF>
	</CFQUERY>

<HTML><HEAD>
	<TITLE>TestSQLAccess - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLAccess</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<CFOUTPUT query="GetRecord">

<FORM action="TestSQLAccess_RecordAction.cfm" method="post">
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
	<TD valign="top"> PictureFileID: </TD>
	<TD> #ViewField1# </TD>
	</TR>

	<TR>
	<TD valign="top"> PictureFileName: </TD>
	<TD> #ViewField2# </TD>
	</TR>

</TABLE>

</CFOUTPUT>

</BODY></HTML>
