
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetRecord"  maxRows=1 datasource="#application.dsn#" > --->	

		SELECT tblTax.TaxID AS ID_Field
		FROM tblTax

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblTax.TaxID < #Form.RecordID#
			ORDER BY tblTax.TaxID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblTax.TaxID > #Form.RecordID#
			ORDER BY tblTax.TaxID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblTax.TaxID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblTax.TaxID > #Form.RecordID#
			ORDER BY tblTax.TaxID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblTax_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblTax_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblTax_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblTax_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
	<!--- <CFQUERY name="DeleteRecord"  maxRows=1 datasource="#application.dsn#" >	 --->
		DELETE
		FROM tblTax
		WHERE tblTax.TaxID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblTax_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblTax set TaxName = '#Form.TaxName#', TaxRate = #Form.TaxRate# ">
		<cfset strQuery = strQuery & "WHERE TaxID = Convert(int,#Form.TaxID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblTax" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblTax_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<!--- Check for duplicates --->
		<cfset strQuery = "select * from tblTax where TaxID = Convert(int,#Form.TaxID#)">
		<CFQUERY name="CheckDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckDuplicates.RecordCount# GT 0>
			<Cfoutput><BR>This record will create duplicates and can not be saved.</cfoutput>
			<cfabort>
		</cfif>
		<cfset strQuery = "insert into tblTax ( TaxID                     ,  TaxName         , TaxRate        ) ">
		<cfset strQuery = strQuery & "values  ( Convert(int,#Form.TaxID#) ,  '#Form.TaxName#', #Form.TaxRate# )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblTax" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
 	    <!--- <CFQUERY name="GetNewRecord"  maxRows=1 datasource="#application.dsn#" > --->			
			SELECT tblTax.TaxID AS ID_Field
			FROM tblTax
			ORDER BY tblTax.TaxID DESC
		</CFQUERY>
		<CFLOCATION url="tblTax_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblTax_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblTax_RecordView.cfm">
	</CFIF>

</CFIF>
