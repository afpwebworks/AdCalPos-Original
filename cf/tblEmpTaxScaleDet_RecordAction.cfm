
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpTaxScaleDet.TaxScaleDetID AS ID_Field
		FROM tblEmpTaxScaleDet

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpTaxScaleDet.TaxScaleDetID < #Form.RecordID#
			ORDER BY tblEmpTaxScaleDet.TaxScaleDetID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpTaxScaleDet.TaxScaleDetID > #Form.RecordID#
			ORDER BY tblEmpTaxScaleDet.TaxScaleDetID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpTaxScaleDet.TaxScaleDetID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpTaxScaleDet.TaxScaleDetID > #Form.RecordID#
			ORDER BY tblEmpTaxScaleDet.TaxScaleDetID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpTaxScaleDet_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpTaxScaleDet_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->
<CFELSEIF ParameterExists(Form.btnView_Delete)>
	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpTaxScaleDet
		WHERE tblEmpTaxScaleDet.TaxScaleDetID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm">
<!---			OK BUTTON (edit page)				--->
<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblEmpTaxScaleDet set  TaxScaleID = convert(int,#Form.TaxScaleID#), GrossTo = #Form.GrossTo#, a = #Form.a#, b =#Form.b#, c = #Form.c# ">
		<cfset strQuery = strQuery & "WHERE TaxScaleDetID = convert(int,#Form.TaxScaleDetID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpTaxScaleDet" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "insert into tblEmpTaxScaleDet ( TaxScaleID                    , GrossTo       , a       , b       , c        ) ">
		<cfset strQuery = strQuery & "values             ( convert(int,#Form.TaxScaleID#), #Form.GrossTo#, #Form.a#, #Form.b#, #Form.c# )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpTaxScaleDet" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpTaxScaleDet.TaxScaleDetID AS ID_Field
			FROM tblEmpTaxScaleDet
			ORDER BY tblEmpTaxScaleDet.TaxScaleDetID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>
<!---			CANCEL BUTTON (edit page)			--->
<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>
	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpTaxScaleDet_RecordView.cfm">
	</CFIF>
</CFIF>
