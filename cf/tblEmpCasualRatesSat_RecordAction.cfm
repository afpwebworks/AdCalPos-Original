
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT tblEmpCasualRatesSat.ID AS ID_Field
		FROM tblEmpCasualRatesSat

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE tblEmpCasualRatesSat.ID < #Form.RecordID#
			ORDER BY tblEmpCasualRatesSat.ID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE tblEmpCasualRatesSat.ID > #Form.RecordID#
			ORDER BY tblEmpCasualRatesSat.ID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY tblEmpCasualRatesSat.ID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE tblEmpCasualRatesSat.ID > #Form.RecordID#
			ORDER BY tblEmpCasualRatesSat.ID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmpCasualRatesSat_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmpCasualRatesSat_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblEmpCasualRatesSat
		WHERE tblEmpCasualRatesSat.ID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
	<CFIF ParameterExists(Form.RecordID)>
		<cfset strQuery = "update tblEmpCasualRatesSat set Age = Convert(int,#Form.Age#), ShiftMinsFrom = Convert(int,#Form.ShiftMinsFrom#), ShiftMinsTo = Convert(int,#Form.ShiftMinsTo#),  ShiftAllowance = #Form.ShiftAllowance# ">
		<cfset strQuery = strQuery & "WHERE ID = Convert(int,#Form.ID#)">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpCasualRatesSat" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "Insert into tblEmpCasualRatesSat (ID                     , Age                    , ShiftMinsFrom                    , ShiftMinsTo                    ,  ShiftAllowance       ) ">
		<cfset strQuery = strQuery & "values                (Convert(int,#Form.ID#) , Convert(int,#Form.Age#), Convert(int,#Form.ShiftMinsFrom#), Convert(int,#Form.ShiftMinsTo#),  #Form.ShiftAllowance#)">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmpCasualRatesSat" formFields="#Form.FieldList#"> --->

		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmpCasualRatesSat.ID AS ID_Field
			FROM tblEmpCasualRatesSat
			ORDER BY tblEmpCasualRatesSat.ID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmpCasualRatesSat_RecordView.cfm">
	</CFIF>

</CFIF>
