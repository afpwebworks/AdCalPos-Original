
<CFIF 
	StructKeyExists(Form, "btnView_Previous") or 
	StructKeyExists(Form, "btnView_Next") or
	StructKeyExists(Form, "btnView_First") or
	StructKeyExists(Form, "btnView_Last")>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblStockRebate.RebateCode AS ID_Field
		FROM tblStockRebate

		<CFIF StructKeyExists(Form, "btnView_Previous")>
			WHERE tblStockRebate.RebateCode < #Form.RecordID#
			ORDER BY tblStockRebate.RebateCode DESC

		<CFELSEIF StructKeyExists(Form, "btnView_Next")>
			WHERE tblStockRebate.RebateCode > #Form.RecordID#
			ORDER BY tblStockRebate.RebateCode

		<CFELSEIF StructKeyExists(Form, "btnView_First")>
			ORDER BY tblStockRebate.RebateCode

		<CFELSEIF StructKeyExists(Form, "btnView_Last")>
			WHERE tblStockRebate.RebateCode > #Form.RecordID#
			ORDER BY tblStockRebate.RebateCode DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStockRebate_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStockRebate_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Edit")>

	<CFLOCATION url="tblStockRebate_RecordEdit.cfm?PartNo=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Add")>

	<CFLOCATION url="tblStockRebate_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Delete")>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStockRebate
		WHERE tblStockRebate.RebateCode = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStockRebate_RecordView.cfm">
<!---			OK BUTTON (edit page)				--->
<CFELSEIF StructKeyExists(Form, "btnEdit_OK")>
	<CFIF StructKeyExists(Form, "RecordID")>
		<CFUPDATE datasource="#application.dsn#"  tableName="tblStockRebate" formFields="#Form.FieldList#">
		<CFLOCATION url="tblStockRebate_RecordView.cfm?PartNo=#Form.RecordID#">
	<CFELSE>

		<CFQUERY name="GetMainHeading" datasource="#application.dsn#" > 
		Insert into tblStockRebate (RebateCode, ThreeHRebate, SCRebate) 
		Values (convert(int,#Form.RebateCode#), #Form.ThreeHRebate#, #Form.SCRebate#)
		</CFQUERY>

		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockRebate" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStockRebate.RebateCode AS ID_Field
			FROM tblStockRebate
			ORDER BY tblStockRebate.RebateCode DESC
		</CFQUERY>
		<CFLOCATION url="tblStockRebate_RecordView.cfm?PartNO=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF StructKeyExists(Form, "btnEdit_Cancel")>

	<CFIF StructKeyExists(Form, "RecordID")>
		<CFLOCATION url="tblStockRebate_RecordView.cfm?PartNo=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStockRebate_RecordView.cfm">
	</CFIF>

</CFIF>
