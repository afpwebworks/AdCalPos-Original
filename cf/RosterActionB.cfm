
<cfset strDate = #Form.strDate#>

<cfif #len(strDate)# LT 8>
	<cfset lngDay = "0" & "#strDate#">
</cfif>
<cfset lngStoreID = #Form.lngStoreID#>
<cfset lngNumRecords = #Form.lngNumRecords#>
<!--- Check the data and report an erro if you see an error --->
<cfoutput>
<cfset lngErrorFound  = 0>
<CFLOOP INDEX="lngLineNumber" FROM="1" TO="#lngNumRecords#" STEP="1">
    <p></p>
	<cfset lngFromTo = 0>
	<CFLOOP INDEX="lngField" FROM="1" TO="7" STEP="1">
		<CFLOOP INDEX="lngFromTo" FROM="1" TO="2" STEP="1">
		    <cfif lngFromTo EQ 1>
				<cfset MyFieldNameDesc = "Day_#lngField#_From_Line" & #lngLineNumber#>
			<cfelse>
				<cfset MyFieldNameDesc = "Day_#lngField#_To_Line" & #lngLineNumber#>
			</cfif>
			<cfset MyFieldName = "Form.#MyFieldNameDesc#">
			<cfset strDay_From_LineValue = #evaluate(MyFieldName)#>
			<cfset strDay_From_LineValue = "#NumberFormat(strDay_From_LineValue,"0000")#">
			<cfset Hour1 = #left(strDay_From_LineValue,2)#>
			<cfset Min1 = #right(strDay_From_LineValue,2)#>
			<cfif #Hour1# GT 24>
				<cfset lngErrorFound  = 1>
				<p>Please go back and check  #MyFieldNameDesc#. You have typed #strDay_From_LineValue#</p>
			</cfif> 
			<cfif #Min1# GT 59>
				<cfset lngErrorFound  = 1>
				<p>Please go back and check  #MyFieldNameDesc#. You have typed #strDay_From_LineValue#</p>
			</cfif> 
		    <!--- <br>Line: #lngLineNumber# Field: #MyFieldName# Value: #strDay_From_LineValue# --->
		</cfloop>
	</cfloop>
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

		
	<cfset MyFieldNameDesc = "Day_1_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay1From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_2_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay2From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_3_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay3From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_4_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay4From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_5_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay5From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_6_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay6From = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_7_From_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay7From = "#strDay_LineValue#">


	<cfset MyFieldNameDesc = "Day_1_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay1To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_2_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay2To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_3_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay3To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_4_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay4To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_5_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay5To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_6_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay6To = "#strDay_LineValue#">
	<cfset MyFieldNameDesc = "Day_7_To_Line" & #lngLineNumber#>
		<cfset MyFieldName = "Form.#MyFieldNameDesc#">
		<cfset strDay_LineValue = #evaluate(MyFieldName)#>
		<cfset strDay_LineValue = "#NumberFormat(strDay_LineValue,"0000")#">
		<cfset StrDay7To = "#strDay_LineValue#">
		
	<cfset strQuery = "UPDATE tblEmpRoster SET tblEmpRoster.SunStart = '#StrDay1From#', tblEmpRoster.SunEnd = '#StrDay1To#', tblEmpRoster.MonStart = '#StrDay2From#', tblEmpRoster.MonEnd = '#StrDay2To#', tblEmpRoster.TueStart = '#StrDay3From#', tblEmpRoster.TueEnd = '#StrDay3To#', tblEmpRoster.WedStart = '#StrDay4From#', tblEmpRoster.WedEnd = '#StrDay4To#', tblEmpRoster.ThuStart = '#StrDay5From#', tblEmpRoster.ThuEnd = '#StrDay5To#', tblEmpRoster.FriStart = '#StrDay6From#', tblEmpRoster.FriEnd = '#StrDay6To#', tblEmpRoster.SatStart = '#StrDay7From#', tblEmpRoster.SatEnd = '#StrDay7To#' ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.RosterID)=#lngRosterID#))">
	<CFQUERY name="UpdateRecord" datasource="#application.dsn#" > 
	<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="UpdateRecord" > --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
		
</cfloop>
	<CFLOCATION url="tblEmpRoster_RecordList.cfm?D=#strDate#">

