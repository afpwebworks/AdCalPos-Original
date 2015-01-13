
<cfset strDateToday = #Form.strDateToday#>

<cfif #len(strDateToday)# LT 8>
	<cfset lngDateToday = "0" & "#strDateToday#">
<cfelse>
	<cfset lngDateToday =  "#strDateToday#">
</cfif>
<cfset lngStoreID = #Form.lngStoreID#>
<cfset lngNumRecords = #Form.lngNumRecords#>
<!--- Check the data and report an erro if you see an error --->
<cfoutput>
<cfset lngErrorFound  = 0>
<CFLOOP INDEX="lngLineNumber" FROM="1" TO="#lngNumRecords#" STEP="1">
		<CFLOOP INDEX="lngFromTo" FROM="1" TO="4" STEP="1">
		    <cfif lngFromTo EQ 1>
				<cfset MyFieldNameDesc = "Time_From_Line" & #lngLineNumber#>
			<cfelseif lngFromTo EQ 2>
				<cfset MyFieldNameDesc = "Time_To_Line" & #lngLineNumber#>
			<cfelseif lngFromTo EQ 3>
				<cfset MyFieldNameDesc = "Entitlement_Time_From_Line" & #lngLineNumber#>
			<cfelse>
				<cfset MyFieldNameDesc = "Entitlement_Time_To_Line" & #lngLineNumber#>
			</cfif>
			<cfset MyFieldName = "Form.#MyFieldNameDesc#">
			<cfset strDay_From_LineValue = #evaluate(MyFieldName)#>
			<cfset strDay_From_LineValue = "#NumberFormat(strDay_From_LineValue,"0000")#">
			<cfset Hour1 = #mid(strDay_From_LineValue,1,2)#>
			<cfset Min1 = #mid(strDay_From_LineValue,3,2)#>
			<cfif #Hour1# GT 24>
				<cfset lngErrorFound  = 1>
				<p>Please go back and check  #MyFieldNameDesc#. You have typed #strDay_From_LineValue#</p>
			</cfif> 
			<cfif #Min1# GT 59>
				<cfset lngErrorFound  = 1>
				<p>Please go back and check  #MyFieldNameDesc#. You have typed #strDay_From_LineValue#</p>
			</cfif> 
			<!--- Check the duration --->
			<cfif lngFromTo EQ 1>	
				<cfset D1 = #Int(strDay_From_LineValue)#>
			</cfif> 
			<cfif lngFromTo EQ 2>	
				<cfset D2 = #Int(strDay_From_LineValue)#>
			</cfif> 
			<cfif lngFromTo EQ 3>	
				<cfset D3 = #Int(strDay_From_LineValue)#>
			</cfif> 
			<cfif lngFromTo EQ 4>	
				<cfset D4 = #Int(strDay_From_LineValue)#>
			</cfif> 

			<!--- We will receive 2 lines of warning if entitlement type is not selected.  Let it be like that.  If want to change to just one line then modify the next line to --->
			<!--- <cfif lngFromTo EQ 3> --->
			<cfif (lngFromTo EQ 3) or (lngFromTo EQ 4)>	
			    <!--- <BR>lngFromTo: #lngFromTo#	Hour1: #Hour1# Min1: #Min1# --->
				<cfif (Hour1 NEQ '00') or (Min1 NEQ '00')>
					<cfset MyFieldNameDesc = "EntType_Line" & #lngLineNumber#>
					<cfset MyFieldName = "Form.#MyFieldNameDesc#">
					<cfset strDayEntType = #evaluate(MyFieldName)#>
					<!--- <br>strDayEntType: #strDayEntType# --->
					<cfif strDayEntType eq 'NA'>
						<cfset lngErrorFound  = 1>
						<p>Please go back and check the entitlement type on line #lngLineNumber#. You have not nominated the entitlement type.</p>
					</cfif>
				</cfif>
			</cfif> 
		</cfloop>
		<!--- Check durations --->
		<cfif D1 GT (D2 + 0.0001)>
			<cfset lngErrorFound  = 1>
			<p>The start time can not be larger than the end time on line #lngLineNumber#. You have typed start time = #D1# and end time = #D2#.</p>
		</cfif>
		<cfif D3 GT (D4 + 0.0001)>
			<cfset lngErrorFound  = 1>
			<p>The entitlement start time can not be larger than the end time on line #lngLineNumber#. You have typed start time = #D3# and end time = #D4#.</p>
		</cfif>
</cfloop>
</cfoutput>

<cfif lngErrorFound  EQ 1>
	<cfabort>
</cfif>

<!--- Save the information and return to the previous page --->
<CFLOOP INDEX="lngLineNumber" FROM="1" TO="#lngNumRecords#" STEP="1">
	<cfset MyFieldNameDesc = "RosterID_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset lngRosterID = #evaluate(MyFieldName)#>
	<cfset MyFieldNameDesc = "Time_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay1From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Time_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay1To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Entitlement_Time_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDayEntitlement1From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Entitlement_Time_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDayEntitlement1To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "EntType_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset StrDayEntitlement1Type = "#strDay_LineValue#">

	<cfset MyFieldNameDesc = "Bonus_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset dblBonus = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Expenses_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset dblExpenses = "#strDay_LineValue#">
		
	<cfset strQuery = "UPDATE tblEmpHoursWorked SET tblEmpHoursWorked.StartTime = '#StrDay1From#', tblEmpHoursWorked.EndTime = '#StrDay1To#', tblEmpHoursWorked.OtherStartTime = '#StrDayEntitlement1From#', tblEmpHoursWorked.OtherEndTime = '#StrDayEntitlement1To#', tblEmpHoursWorked.OtherTimeType = '#StrDayEntitlement1Type#', tblEmpHoursWorked.Bonus = #dblBonus#, tblEmpHoursWorked.Expenses = #dblExpenses# ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.HoursWorkedID)= #lngRosterID# ))">
	<CFQUERY name="UpdateRecord" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="UpdateRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" > --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
</cfloop>
<!--- Update hours worked field in the EodSummary table --->
<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodHoursWorkedUpdated = 1 ">
<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#lngDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
<CFQUERY name="UpdateEodSummary" datasource="#application.dsn#" > 
<!--- <CFQUERY name="UpdateEodSummary" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" > --->
   #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfoutput>
<!--- kf amendment, Jan 25 '04, save and reload report date not current date --->
<!--- <cfif isdefined("form.lngMN")>
	<CFLOCATION url="HoursWorked.cfm?CDS=#lngDateToday#&MN=#form.lngMN#">
<cfelse>
	<CFLOCATION url="HoursWorked.cfm?CDS=#lngDateToday#">
</cfif> --->
<cfif isdefined("form.lngMN")>
	<CFLOCATION url="HoursWorked.cfm?CDS=#strDateReport#&MN=#form.lngMN#">
<cfelse>
	<CFLOCATION url="HoursWorked.cfm?CDS=#strDateReport#">
</cfif>
<!--- end --->
</cfoutput>
