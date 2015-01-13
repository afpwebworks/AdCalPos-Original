
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblSupplier.SupplierID AS ID_Field
		FROM tblSupplier

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblSupplier.SupplierID < #Form.RecordID#
			ORDER BY tblSupplier.SupplierID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblSupplier.SupplierID > #Form.RecordID#
			ORDER BY tblSupplier.SupplierID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblSupplier.SupplierID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblSupplier.SupplierID > #Form.RecordID#
			ORDER BY tblSupplier.SupplierID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblSupplier_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblSupplier_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblSupplier_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblSupplier_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblSupplier
		WHERE tblSupplier.SupplierID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblSupplier_RecordView.cfm">
<!---			OK BUTTON (edit page)				--->
<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblSupplier set SupplierName = '#Form.SupplierName#', Phone = '#Form.Phone#', Fax = '#Form.Fax#', Mobile = '#Form.Mobile#', email = '#Form.email#', AcctBalance = #Form.AcctBalance# , CreditLimit = #Form.CreditLimit#, NoLongerUsed = #Form.NoLongerUsed# ">
		<cfset strQuery = strQuery & "WHERE SupplierID = Convert(int,#Form.SupplierID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblSupplier" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSupplier" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblSupplier_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<cfset strQuery = "insert into tblSupplier (SupplierName         , Phone         , Fax         , Mobile         , email         , AcctBalance        , CreditLimit       , NoLongerUsed        ) ">
		<cfset strQuery = strQuery & "values       ('#Form.SupplierName#', '#Form.Phone#', '#Form.Fax#', '#Form.Mobile#', '#Form.email#', #Form.AcctBalance# , #Form.CreditLimit#, #Form.NoLongerUsed# )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblSupplier" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblSupplier" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 	
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblSupplier.SupplierID AS ID_Field
			FROM tblSupplier
			ORDER BY tblSupplier.SupplierID DESC
		</CFQUERY>
		<CFLOCATION url="tblSupplier_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>
<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblSupplier_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblSupplier_RecordView.cfm">
	</CFIF>

</CFIF>
