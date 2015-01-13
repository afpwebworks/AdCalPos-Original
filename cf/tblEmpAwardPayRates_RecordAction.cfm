
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord"  maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpAwardPayRates.AwardID AS ID_Field
		FROM tblEmpAwardPayRates

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpAwardPayRates.AwardID < #Form.RecordID#
			ORDER BY tblEmpAwardPayRates.AwardID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpAwardPayRates.AwardID > #Form.RecordID#
			ORDER BY tblEmpAwardPayRates.AwardID 

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpAwardPayRates.AwardID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpAwardPayRates.AwardID > #Form.RecordID#
			ORDER BY tblEmpAwardPayRates.AwardID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpAwardPayRates_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpAwardPayRates_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord"  maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpAwardPayRates
		WHERE tblEmpAwardPayRates.AwardID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>

	<CFIF ParameterExists(Form.RecordID)>
		<!--- Check for the duplicates first --->
		<cfset strQuery = "select * from tblEmpAwardPayRates ">
		<cfset strQuery = strQuery & "where Age = Convert(int,#Form.Age#) and EmpStatusID = Convert(int,#Form.EmpStatusID#) and AwardID <> Convert(int,#Form.AwardID#)">
		<CFQUERY name="CheckForDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckForDuplicates.recordCount# GT 0>
			<cfoutput>This record will create a duplicate.  It can not be saved.</cfoutput>
			<cfabort>
		</cfif>
	
		<cfset strQuery = "update tblEmpAwardPayRates set Age = Convert(int,#Form.Age#), EmpStatusID = Convert(int,#Form.EmpStatusID#), HourlyPay = #Form.HourlyPay# ">
		<cfset strQuery = strQuery & "where AwardID = Convert(int,#Form.AwardID#)">
		<cfoutput><BR>strQuery: #strQuery#</cfoutput>
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblEmpAwardPayRates" formFields="#Form.FieldList#"> --->
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpAwardPayRates" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<!--- Check for the duplicates first --->
		<cfset strQuery = "select * from tblEmpAwardPayRates ">
		<cfset strQuery = strQuery & "where Age = Convert(int,#Form.Age#) and EmpStatusID = Convert(int,#Form.EmpStatusID#)">
		<CFQUERY name="CheckForDuplicates" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckForDuplicates.recordCount# GT 0>
			<cfoutput>This record will create a duplicate.  It can not be saved.</cfoutput>
			<cfabort>
		</cfif>
	
		<cfset strQuery = "insert into tblEmpAwardPayRates (Age                    , EmpStatusID                    , HourlyPay       ) ">
		<cfset strQuery = strQuery & "values               (Convert(int,#Form.Age#), Convert(int,#Form.EmpStatusID#), #Form.HourlyPay#)">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT datasource="#application.dsn#"  tableName="tblEmpAwardPayRates" formFields="#Form.FieldList#"> --->
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpAwardPayRates" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord"  maxRows=1 datasource="#application.dsn#" > 	
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpAwardPayRates.AwardID AS ID_Field
			FROM tblEmpAwardPayRates
			ORDER BY tblEmpAwardPayRates.AwardID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpAwardPayRates_RecordView.cfm">
	</CFIF>

</CFIF>
