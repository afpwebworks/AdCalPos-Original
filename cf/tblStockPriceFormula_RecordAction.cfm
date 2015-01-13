
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblStockPriceFormula.PriceFormulaID AS ID_Field
		FROM tblStockPriceFormula

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblStockPriceFormula.PriceFormulaID < #Form.RecordID#
			ORDER BY tblStockPriceFormula.PriceFormulaID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblStockPriceFormula.PriceFormulaID > #Form.RecordID#
			ORDER BY tblStockPriceFormula.PriceFormulaID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblStockPriceFormula.PriceFormulaID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblStockPriceFormula.PriceFormulaID > #Form.RecordID#
			ORDER BY tblStockPriceFormula.PriceFormulaID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblStockPriceFormula_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblStockPriceFormula_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStockPriceFormula
		WHERE tblStockPriceFormula.PriceFormulaID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStockPriceFormula_RecordView.cfm">
<!---			OK BUTTON (edit page)				--->
<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<CFUPDATE datasource="#application.dsn#"  tableName="tblStockPriceFormula" formFields="#Form.FieldList#">
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockPriceFormula" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<!--- Make sure that the part no exists --->
		<cfset strQuery = "SELECT PartNo from tblStockMaster where PartNo = '#Form.PartNo#'">
		<CFQUERY name="CheckPlu" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckPlu.RecordCount# LT 1>
			<Cfoutput><BR>Plu #Form.PartNo# does not exist.  Please change it and try again.</cfoutput>
			<cfabort>
		</cfif>

		<CFINSERT datasource="#application.dsn#"  tableName="tblStockPriceFormula" formFields="#Form.FieldList#">
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStockPriceFormula" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblStockPriceFormula.PriceFormulaID AS ID_Field
			FROM tblStockPriceFormula
			ORDER BY tblStockPriceFormula.PriceFormulaID DESC
		</CFQUERY>
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStockPriceFormula_RecordView.cfm">
	</CFIF>

</CFIF>
