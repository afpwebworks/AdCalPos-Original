
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpRateMultiplier.RateMultID AS ID_Field
		FROM tblEmpRateMultiplier

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpRateMultiplier.RateMultID < #Form.RecordID#
			ORDER BY tblEmpRateMultiplier.RateMultID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpRateMultiplier.RateMultID > #Form.RecordID#
			ORDER BY tblEmpRateMultiplier.RateMultID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpRateMultiplier.RateMultID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpRateMultiplier.RateMultID > #Form.RecordID#
			ORDER BY tblEmpRateMultiplier.RateMultID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpRateMultiplier_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpRateMultiplier_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpRateMultiplier
		WHERE tblEmpRateMultiplier.RateMultID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
   <cfif #Form.EmployeeStatusID# LT 1>
   		<Cfoutput><br>Please select the employee status ID and try again.</cfoutput> 
		<cfabort>
   </cfif> 

	<CFIF ParameterExists(Form.RecordID)>
		<!--- Make sure that there is no duplicates --->
		<cfset strQuery = "select * from tblEmpRateMultiplier ">
		<cfset strQuery = strQuery & "where WeekDay = Convert(int,#Form.WeekDay#) and EmployeeStatusID = Convert(int,#Form.EmployeeStatusID#) and RateMultID <> Convert(int, #Form.RateMultID#)">
		<CFQUERY name="CheckTheDuplicate" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckTheDuplicate.RecordCount# GT 0>
			<cfoutput><BR>This record will create a duplicate and can not be saved</cfoutput>
			<cfabort>
		</cfif>
	
		<cfset strQuery = "update tblEmpRateMultiplier set Description = '#Form.Description#', WeekDay = Convert(int,#Form.WeekDay#), EmployeeStatusID = Convert(int,#Form.EmployeeStatusID#), StandardMult = #Form.StandardMult#, OT1Mult = #Form.OT1Mult#, OT2Mult = #Form.OT2Mult# ">
		<cfset strQuery = strQuery & "WHERE RateMultID = Convert(int, #Form.RateMultID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpRateMultiplier" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<!--- Make sure that there is no duplicates --->
		<cfset strQuery = "select * from tblEmpRateMultiplier ">
		<cfset strQuery = strQuery & "where WeekDay = Convert(int,#Form.WeekDay#) and EmployeeStatusID = Convert(int,#Form.EmployeeStatusID#)">
		<CFQUERY name="CheckTheDuplicate" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckTheDuplicate.RecordCount# GT 0>
			<cfoutput><BR>This record will create a duplicate and can not be saved</cfoutput>
			<cfabort>
		</cfif>

		<cfset strQuery = "insert into tblEmpRateMultiplier (Description         , WeekDay                    , EmployeeStatusID                    , StandardMult       , OT1Mult       , OT2Mult        ) ">
		<cfset strQuery = strQuery & "values                ('#Form.Description#', Convert(int,#Form.WeekDay#), Convert(int,#Form.EmployeeStatusID#), #Form.StandardMult#, #Form.OT1Mult#, #Form.OT2Mult# )">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpRateMultiplier" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpRateMultiplier.RateMultID AS ID_Field
			FROM tblEmpRateMultiplier
			ORDER BY tblEmpRateMultiplier.RateMultID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpRateMultiplier_RecordView.cfm">
	</CFIF>

</CFIF>
