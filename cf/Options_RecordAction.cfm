
<!--- - wb 22/02/2004 -  - --->
<cfif isDefined("form.hc") AND trim(form.Comments) NEQ "">
	<cfset form.Comments=form.Comments&"/:/">
</cfif>
<cfif isDefined("form.hc2") AND trim(form.Comments2) NEQ "">
	<cfset form.Comments2=form.Comments2&"/:/">
</cfif>
<cfif isDefined("form.hc3") AND trim(form.Comments3) NEQ "">
	<cfset form.Comments3=form.Comments3&"/:/">
</cfif>
<cfif isDefined("form.hc4") AND trim(form.Comments4) NEQ "">
	<cfset form.Comments4=form.Comments4&"/:/">
</cfif>
<cfif isDefined("form.hc5") AND trim(form.Comments5) NEQ "">
	<cfset form.Comments5=form.Comments5&"/:/">
</cfif>


<!---			NAVIGATION BUTTONS (view page)			--->

<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#"  >  
<!--- <CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">	 --->

		SELECT tblOptions.OptionID AS ID_Field
		FROM tblOptions

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblOptions.OptionID < #Form.RecordID#
			ORDER BY tblOptions.OptionID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblOptions.OptionID > #Form.RecordID#
			ORDER BY tblOptions.OptionID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblOptions.OptionID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblOptions.OptionID > #Form.RecordID#
			ORDER BY tblOptions.OptionID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="Options_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="Options_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="Options_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="Options_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#"  >  
<!--- <CFQUERY name="DeleteRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		DELETE
		FROM tblOptions
		WHERE tblOptions.OptionID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="Options_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "UPDATE tblOptions SET tblOptions.CutOffTime = '#Form.CutOffTime#', tblOptions.Comments = '#Form.Comments#', tblOptions.Comments2 = '#Form.Comments2#', tblOptions.Comments3 = '#Form.Comments3#', tblOptions.Comments4 = '#Form.Comments4#', tblOptions.Comments5 = '#Form.Comments5#', tblOptions.DaysToMakeACredit = #Form.DaysToMakeACredit# , FranchiseFeePercentage  = #Form.FranchiseFeePercentage# , MarketingFeePercentage = #Form.MarketingFeePercentage# , GPPriceList=#FORM.GPPriceListPercentage#, clearancedays=#FORM.ClearanceDays#,
		updateStockMaster=#form.UpdateStockMaster#,
		updateStockLocation=#Form.UpdateStockLocation# ">
		<cfset strQuery = strQuery & "WHERE (((tblOptions.OptionID)=#Form.OptionID#))">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#"  >  
#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblOptions" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="Options_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "Insert into tblOptions (CutOffTime         , Comments         , Comments2         , Comments3         , Comments4         , Comments5         , DaysToMakeACredit , FranchiseFeePercentage , MarketingFeePercentage, UpdateStockMaster, UpdateStockLocation  ) ">
		<cfset strQuery = "Values                 ('#Form.CutOffTime#', '#Form.Comments#', '#Form.Comments2#', '#Form.Comments3#', '#Form.Comments4#', '#Form.Comments5#', #Form.DaysToMakeACredit# , #Form.FranchiseFeePercentage# , #Form.MarketingFeePercentage#, #Form.GPPriceListPercentage#, #Form.UpdateStockMaster#, #Form.UpdateStockLocation# ) ">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#"  >  
#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblOptions" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#"  >  
<!--- <CFQUERY name="GetNewRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			SELECT tblOptions.OptionID AS ID_Field
			FROM tblOptions
			ORDER BY tblOptions.OptionID DESC
		</CFQUERY>
		<CFLOCATION url="Options_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="Options_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="Options_RecordView.cfm">
	</CFIF>

</CFIF>
