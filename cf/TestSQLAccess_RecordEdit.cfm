
<CFSET FormFieldList = "PictureFileName">
<cfparam name="LocalAppCostiDB" default="#Applic_AppRoot#">
<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="Microsoft.Jet.OLEDB.4.0" dataSource="#LocalAppCostiDB#costi.mdb" PROVIDERDSN="#LocalAppCostiDB#costi.mdb" USERNAME="admin">
		SELECT tblPictureFile.PictureFileName, tblPictureFile.PictureFileID AS ID_Field
		FROM tblPictureFile
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblPictureFile.PictureFileID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "PictureFileID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "PictureFileID" )>
	</CFIF>

			
			<CFSET PictureFileName_Value = '#GetRecord.PictureFileName#'>
		

<CFELSE>

			
			<CFSET PictureFileName_Value = ''>
		

</CFIF>


<HTML><HEAD>
	<TITLE>TestSQLAccess - Edit Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQLAccess</FONT> <BR>
<FONT size="+2"><B>Edit Record</B></FONT>

<CFOUTPUT>
<FORM action="TestSQLAccess_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="PictureFileID" value="#URL.RecordID#">
</CFIF>


<TABLE>

	
	<TR>
	<TD valign="top"> PictureFileName: </TD>
    <TD>
	
		<INPUT type="text" name="PictureFileName" value="#PictureFileName_Value#" maxLength="100">
		
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
