
<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->

		SELECT qryEmployeeView.EmployeeID AS ID_Field
		FROM qryEmployeeView

		<CFIF ParameterExists(Form.btnView_Previous)>
			WHERE qryEmployeeView.EmployeeID < #Form.RecordID#
			ORDER BY qryEmployeeView.EmployeeID DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			WHERE qryEmployeeView.EmployeeID > #Form.RecordID#
			ORDER BY qryEmployeeView.EmployeeID

		<CFELSEIF ParameterExists(Form.btnView_First)>
			ORDER BY qryEmployeeView.EmployeeID

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			WHERE qryEmployeeView.EmployeeID > #Form.RecordID#
			ORDER BY qryEmployeeView.EmployeeID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblEmployee_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblEmployee_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>


    <CFQUERY name="CheckDeleteRecord" datasource="#application.dsn#" > 	
		select EmployeeID, GivenName + ' '+ SurName as Name from tblEmployee where EmployeeID = #Form.RecordID#
	</CFQUERY>
	<cfif session.usertype EQ 0 OR session.usertype EQ 1>
	    <cfif CheckDeleteRecord.RecordCount GT 0>
			<cfoutput>
			<cfif isDefined("form.yes")>
				<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 	
					DELETE
					FROM tblEmployee
					WHERE tblEmployee.EmployeeID = #Form.RecordID#
				</CFQUERY>
				#CheckDeleteRecord.Name# has been deleted from the system. &nbsp;&nbsp;
				<a href="tblEmployee_RecordList.cfm">Back</a>
			<cfelseif isDefined("form.no")>
				<CFLOCATION url="tblEmployee_RecordList.cfm">
			<cfelse>
				Are you sure you want to delete #CheckDeleteRecord.Name# ?
				<form name="deleteEmployee" id="deleteEmployee" action="tblEmployee_RecordAction.cfm" method="post">
					<input type="hidden" name="btnView_Delete" id="btnView_Delete" value="1">
					<input type="hidden" name="RecordID" id="RecordID" value="#RecordID#">
					<input type="submit" name="yes" id="yes" value="YES">
					<input type="submit" name="no" id="no" value="NO">
				</form>
			</cfif>
			<cfabort>
			</cfoutput>
		<cfelse>
			ERROR: The employee was not found in the system. Please try again.
		</cfif>	
	<cfelse>
		<p>
		<br><h3>The employee can not be deleted (insufficient privilege).</h3>
		<br>
		<br>
		<br><h3>Click the back button on the browser to go back to the previous page.</h3>
		<cfabort>
	</cfif>

    
	<!--- <CFLOCATION url="tblEmployee_RecordView.cfm"> --->


<!---			OK BUTTON (edit page)				--->

<CFELSEIF ParameterExists(Form.btnEdit_OK)>
<cfset MyDate = "#form.BirthDay#">
<cfset MyComm = "#form.Commenced#">
<cfset MyFini = "#form.Finished#">
<cfif #len(MyDate)# eq 7>
	<cfset MyDate = '0' & #MyDate# >
</cfif>
<cfif #len(MyComm)# eq 7>
	<cfset MyComm = '0' & #MyComm# >
</cfif>
<cfif #len(MyFini)# eq 7>
	<cfset MyFini = '0' & #MyFini# >
</cfif>
<!--- 
<cfoutput><BR>MyDate: #MyDate#</cfoutput>
<cfoutput><BR>MyComm: #MyComm#</cfoutput>
<cfoutput><BR>MyFini: #MyFini#</cfoutput>
 --->
<cfif #Len(MyFini)# GT 0>
	<cf_ValidateDate strDateValue = #MyFini# lngWeekDay =0>
</cfif>

<cf_ValidateDate strDateValue = #MyDate# lngWeekDay =0>
<cf_ValidateDate strDateValue = #MyComm# lngWeekDay =0>
<!--- 
<cfoutput><BR>MyDate: #MyDate#</cfoutput>
<cfoutput><BR>MyComm: #MyComm#</cfoutput>
 --->
	<CFIF ParameterExists(Form.RecordID)>

		<cfset strQuery = "update tblEmployee set StoreID = convert(int,#Form.StoreID#) , GivenName = '#Form.GivenName#', Surname = '#Form.Surname#', TaxFileNo = '#Form.TaxFileNo#', Street = '#Form.Street#', Address1 = '#Form.Address1#', Address2 = '#Form.Address2#', PostCode = '#Form.PostCode#', State = '#Form.State#', Phone = '#Form.Phone#', Fax = '#Form.Fax#', Mobile = '#Form.Mobile#', Email = '#Form.Email#', BirthDay = '#MyDate#', EmpStatusID = convert(int,#Form.EmpStatusID#), HourlyPayRate = #Form.HourlyPayRate#, MonthlySalary = #Form.MonthlySalary#, Commenced = '#MyComm#', Finished = '#MyFini#', NoLongerUsed = #form.NoLongerUsed#, UserTypeID = convert(int,#form.UserTypeID#), UserName = '#Form.UserName#', Password = '#Form.Password#' ">
		<cfset strQuery = strQuery & "FROM tblEmployee where EmployeeID = #Form.RecordID#">
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmployee" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#Form.RecordID#">

	<CFELSE>
		<cfset strQuery = "insert into tblEmployee (StoreID                     , GivenName         , Surname         , TaxFileNo         , Street         , Address1         , Address2         , PostCode         , State         , Phone        , Fax          , Mobile         , Email         , BirthDay  , EmpStatusID                    , HourlyPayRate       , MonthlySalary       , Commenced , Finished  , NoLongerUsed       , UserTypeID                    , UserName         , Password         ) ">
		<cfset strQuery = strQuery & "values       (convert(int,#Form.StoreID#) , '#Form.GivenName#', '#Form.Surname#', '#Form.TaxFileNo#', '#Form.Street#', '#Form.Address1#', '#Form.Address2#', '#Form.PostCode#', '#Form.State#', '#Form.Phone#', '#Form.Fax#', '#Form.Mobile#', '#Form.Email#', '#MyDate#', convert(int,#Form.EmpStatusID#), #Form.HourlyPayRate#, #Form.MonthlySalary#, '#MyComm#', '#MyFini#', #form.NoLongerUsed#, convert(int,#form.UserTypeID#), '#Form.UserName#', '#Form.Password#')">
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- <CFINSERT DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblEmployee" formFields="#Form.FieldList#"> --->
		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 	
        <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNewRecord"  maxRows=1> --->
			SELECT tblEmployee.EmployeeID AS ID_Field
			FROM tblEmployee
			ORDER BY tblEmployee.EmployeeID DESC
		</CFQUERY>
		<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">

	</CFIF>


<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblEmployee_RecordView.cfm">
	</CFIF>

</CFIF>
