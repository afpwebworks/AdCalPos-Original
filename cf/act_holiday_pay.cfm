
<CFSET otherEndTime="1730">
<CFSET otherStartTime="0900">
<CFSET otherTimeType="LV">

<CFOUTPUT>
	<CFLOOP list="#datesListDDMMYYYY#" index="thisdate">
	<br>
	   <CFSET thisDateFormatted = #CREATEDATE(#MID(thisDate,5,4)#,#MID(thisDate,3,2)#,#MID(thisDate,1,2)#)#>
	   Processing #thisDateFormatted#
	   <CFSET daysToSaturday = 7 - dayOfWeek(thisDateFormatted)>
	   <CFSET weekEnding = #DATEFORMAT(dateAdd('d',daysToSaturday,thisDateFormatted),"DDMMYYYY")#> 
	   
	        <!--- Check to see if this line exist in the employee hours worked or not ---> 
			<cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster ">
			<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
			<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)= #employee_ID# ) AND ((tblEmpHoursWorked.StoreID)= #Store_ID# ) AND ((tblEmpHoursWorked.DateWorked)= '#thisDate#' ))" >
			<CFQUERY name="CheckHoursWorked" datasource="#application.dsn#" > 
			   #PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckHoursWorked.RecordCount# LT 1>
				<!--- Add the information from the roster to hours worked --->
				<CFIF listFind(bankHolidaysListDDMMYYYY,thisDate)>
				   <cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, otherStartTime, otherEndTime, OtherTimeType, PublicHoliday ) Values ('#weekEnding#', #employee_ID# , #store_ID# , '#thisdate#' , '#otherStartTime#' , '#otherEndTime#'  , '#otherTimeType#','1')" >
				<CFELSE>
				   <cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, otherStartTime, otherEndTime, OtherTimeType ) Values ('#weekEnding#', #employee_ID# , #store_ID# , '#thisdate#' , '#otherStartTime#' , '#otherEndTime#'  , '#otherTimeType#')" >
				</CFIF>
				<CFQUERY name="InsertDataIntoHoursWorked" datasource="#application.dsn#" > 
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			<CFELSE>
				<cfset strQuery = "UPDATE tblEmpHoursWorked ">
				<cfset strQuery = strQuery & "set otherStartTime='#otherStartTime#', ">
				<cfset strQuery = strQuery & "    otherEndTime='#otherEndTime#', ">
				<cfset strQuery = strQuery & "    otherTimetype='#otherTimeType#' ">
				<CFIF listFind(bankHolidaysListDDMMYYYY,thisDate)>
					<cfset strQuery = strQuery & "  ,publicHoliday = '1'">														
				</CFIF>
				<cfset strQuery = strQuery & " where EmployeeID = #employee_ID# ">						
				<cfset strQuery = strQuery & "  and storeID = #store_ID# ">						
				<cfset strQuery = strQuery & "  and dateWorked  = '#thisDate#'">														
				<CFQUERY name="CheckHoursWorked" datasource="#application.dsn#" > 
				   #PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			</cfif>
	</cfloop>
<cfabort>
</cfoutput>
<!--- <!--- Check to see if this line exist in the employee hours worked or not ---> 

<cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster ">
<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)= #employeeID# ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ))">
		<CFQUERY name="CheckHoursWorked" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckHoursWorked.RecordCount# LT 1>
			<!--- Add the information from the roster to hours worked --->
			<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster ) ">
			<cfset strQuery = strQuery & "Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )">
			<CFQUERY name="InsertDataIntoHoursWorked" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="InsertDataIntoHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<br>Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )
		</cfif>


<CFQUERY name="UpdateEodSummary" datasource="#application.dsn#" > 
	 UPDATE tblEmpHoursWorked 
	 SET tblEmpHoursWorked.StartTime  = '#NumberFormat(evaluate("Time_From_Line#loop#"),"0000")#', 	 
	 tblEmpHoursWorked.EndTime        = '#NumberFormat(evaluate("Time_To_Line#loop#"),"0000")#',
	 tblEmpHoursWorked.OtherStartTime = '#NumberFormat(evaluate("Entitlement_Time_From_Line#loop#"),"0000")#',
	 tblEmpHoursWorked.OtherEndTime   = '#NumberFormat(evaluate("Entitlement_Time_To_Line#loop#"),"0000")#',
	 tblEmpHoursWorked.OtherTimeType  = '#evaluate("EntType_Line#loop#")#',
	 tblEmpHoursWorked.Bonus          =  #evaluate("Bonus_Line#loop#")#,
	 tblEmpHoursWorked.Expenses       =  #evaluate("Expenses_Line#loop#")#
	 where hoursWorkedID              =  #evaluate("RosterID_Line#loop#")#
</CFQUERY>
 --->
