
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpPublicHol.PublicHolID AS ID_Field
		FROM tblEmpPublicHol

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpPublicHol.PublicHolID < #Form.RecordID#
			ORDER BY tblEmpPublicHol.PublicHolID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpPublicHol.PublicHolID > #Form.RecordID#
			ORDER BY tblEmpPublicHol.PublicHolID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpPublicHol.PublicHolID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpPublicHol.PublicHolID > #Form.RecordID#
			ORDER BY tblEmpPublicHol.PublicHolID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpPublicHol_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpPublicHol_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpPublicHol
		WHERE tblEmpPublicHol.PublicHolID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpPublicHol_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<cfset MyDate=right(form.sDate,2) & mid(form.sDate,5,2) & left(form.sDate,4)>
	<cfif #len(MyDate)# EQ 7>
		<cfset MyDate = "0" & #MyDate#>
	</cfif>
	<cf_ValidateDate strDateValue = #MyDate# lngWeekDay =0>

	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "Update tblEmpPublicHol set Date = '#MyDate#', Name = '#Form.Name#', Trading = #Form.Trading#">
		<cfset strQuery = strQuery & "WHERE PublicHolID = convert(int,#Form.PublicHolID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblEmpPublicHol" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpPublicHol" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "insert into tblEmpPublicHol (Date      , Name         , Trading       ) ">
		<cfset strQuery = strQuery & "values           ('#MyDate#', '#Form.Name#', #Form.Trading#)">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblEmpPublicHol" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpPublicHol" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpPublicHol.PublicHolID AS ID_Field
			FROM tblEmpPublicHol
			ORDER BY tblEmpPublicHol.PublicHolID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpPublicHol_RecordView.cfm">
	</CFIF>

</CFIF>
