
<cfset lngDay = #Form.DF#>
<cfset lngMonth = #Form.MF#>
<cfset lngYear = #Form.YF#>

<cfif #len(lngDay)# LT 2>
	<cfset lngDay = "0" & "#lngDay#">
</cfif>
<cfif #len(lngMonth)# LT 2>
	<cfset lngMonth = "0" & "#lngMonth#">
</cfif>
<cfset strDate = "#lngDay#" & "#lngMonth#" & "#lngYear#">

<cfset lngStoreID = #session.storeid#>

<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strDate#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# EQ "Y">
	<!--- get the start and finish dates for the selected week --->
		<cfset strEndWeekDate = #strDate#>	
		<CFSET strNextDate = ''>
		<CF_GetXDaysFromNow baseDate="#strEndWeekDate#" numDays="-6">
		<cfoutput><br>#strNextDate#</cfoutput>
		<cfset strStartWeekDate = #strNextDate#>	
	    <!--- Convert the dates into numbers --->
	
		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strEndWeekDate#">
		<cfset lngEndWeekDate = #lngDateLong#>	
		<cfoutput><br>#lngEndWeekDate#</cfoutput>

		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strStartWeekDate#">
		<cfset lngStartWeekDate = #lngDateLong#>	
		<cfoutput><br>#lngStartWeekDate#</cfoutput>

<!--- Delete the payroll records that have not been paid --->
		<cfset strQuery = "DELETE ">
		<cfset strQuery = strQuery & "FROM tblEmpPayRoll ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null))">
		<CFQUERY name="DeleteNotPaidPayRecords" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="DeleteNotPaidPayRecords" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

	
<!--- Public Holiday Section --->	
		<cfset strQuery = "SELECT qryPublicHoliday.PubHolDateLong, * ">
		<cfset strQuery = strQuery & "FROM qryPublicHoliday ">
		<cfset strQuery = strQuery & "WHERE (((qryPublicHoliday.PubHolDateLong) Between #lngStartWeekDate# And #lngEndWeekDate#))">
		<CFQUERY name="CheckPublicHoliday" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckPublicHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cfif #CheckPublicHoliday.RecordCount# GT 0 >
			<cfloop query="CheckPublicHoliday">
				<cfset strPublicHol = #CheckPublicHoliday.Date#>			
				<cfset lngPublicHol = #CheckPublicHoliday.PubHolDateLong#>						
				<!--- Make sure that this date does not exist for the employees of the same store over the time range --->
				<cfset lngStoreID = #GetRecord.StoreID#>						
			
				<cfset strQuery = "SELECT tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID ">
				<cfset strQuery = strQuery & "FROM tblEmpHoursWorked INNER JOIN qryEmployee ON tblEmpHoursWorked.EmployeeID = qryEmployee.EmployeeID ">
				<cfset strQuery = strQuery & "WHERE (((qryEmployee.EmpStatusID)=2) AND ((tblEmpHoursWorked.DatePaid)="" Or (tblEmpHoursWorked.DatePaid) Is Null)) ">
				<cfset strQuery = strQuery & "GROUP BY tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID ">
				<cfset strQuery = strQuery & "HAVING (((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#') AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#))">
		
				<CFQUERY name="CheckPubHoliday" datasource="#application.dsn#" > 
				<!--- <CFQUERY name="CheckPubHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<cfif #CheckPubHoliday.RecordCount#	GT 0>
					<cfloop query="CheckPubHoliday">				
						<cfset lngEmployeeID = #CheckPubHoliday.EmployeeID#>			
						<!--- Check to see if the employee so there are ---> 
						<cfset strQuery = "SELECT tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked ">
						<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
						<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)=#lngEmployeeID#) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.DateWorked)='#strPublicHol#'))">
						<CFQUERY name="CheckPubHolidayForEmployee" datasource="#application.dsn#" > 
						<!--- <CFQUERY name="CheckPubHolidayForEmployee" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
							#PreserveSingleQuotes(strQuery)#
						</CFQUERY>
						<cfif #CheckPubHolidayForEmployee.RecordCount# LT 0>
							<!--- Add the public holiday for the employee --->
							<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster, RecordAddedByComputer ) ">
							<cfset strQuery = strQuery & "Values ('#strEndWeekDate#',#lngEmployeeID# ,#lngStoreID# , '#strPublicHol#', '0900' , '1730' ,'0000' , '0000' , Yes)">
							<CFQUERY name="AddPubHolidayForEmployee" datasource="#application.dsn#" > 
							<!--- <CFQUERY name="AddPubHolidayForEmployee" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
								#PreserveSingleQuotes(strQuery)#
							</CFQUERY>
						</cfif>
					</cfloop> 
				</cfif>
			</cfloop> 
		</cfif>

<!--- Casual Sat Shift Allowance Section --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked INNER JOIN qryEmpHoursAA_SatShitAllowanceB ON tblEmpHoursWorked.HoursWorkedID = qryEmpHoursAA_SatShitAllowanceB.HoursWorkedID SET tblEmpHoursWorked.ShiftAllowance = [qryEmpHoursAA_SatShitAllowanceB].[ShiftAllowance] ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAA_SatShitAllowanceB.StoreID)=#lngStoreID#) AND ((qryEmpHoursAA_SatShitAllowanceB.WeekEnding)='#strEndWeekDate#') AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null))">
		<CFQUERY name="AddCasualSatAllowance" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="AddCasualSatAllowance" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Hours Worked and multiplier section --->
		<cfset strQuery = "UPDATE qryEmpHoursAB INNER JOIN tblEmpHoursWorked ON qryEmpHoursAB.HoursWorkedID = tblEmpHoursWorked.HoursWorkedID SET tblEmpHoursWorked.STMins = [ST], tblEmpHoursWorked.OT1Mins = [oT1], tblEmpHoursWorked.Ot2Mins = [oT2], tblEmpHoursWorked.SickMins = [Sick], tblEmpHoursWorked.LeaveMins = [Leave], tblEmpHoursWorked.STMultiplier = [StandardMultiplier], tblEmpHoursWorked.OT1Multiplier = [Mult_Ot1], tblEmpHoursWorked.OT2Multiplier = [Mult_Ot2], tblEmpHoursWorked.PublicHoliday = Null, tblEmpHoursWorked.PayRateBase = [ActualHourlyPayRate] ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAB.WeekEnding)='#strEndWeekDate#') AND ((qryEmpHoursAB.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null))">
		<CFQUERY name="CalculateHoursWorked" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CalculateHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Mark Public Holidays --->
		<cfset strQuery = "UPDATE tblEmpPublicHol INNER JOIN tblEmpHoursWorked ON tblEmpPublicHol.Date = tblEmpHoursWorked.DateWorked SET tblEmpHoursWorked.PublicHoliday = 'P' ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.RecordAddedByComputer)=0) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
		<CFQUERY name="MarkPublicHolidays" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Check the multipliers for public holidays --->
		<cfset strQuery = "UPDATE (tblEmpHoursWorked INNER JOIN tblEmployee ON tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID) INNER JOIN tblEmpRateMultiplier ON tblEmployee.EmpStatusID = tblEmpRateMultiplier.EmployeeStatusID SET tblEmpHoursWorked.STMultiplier = [StandardMult], tblEmpHoursWorked.OT1Multiplier = [OT1Mult]*[StandardMult], tblEmpHoursWorked.OT2Multiplier = [OT2Mult]*[StandardMult] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpRateMultiplier.WeekDay)=0) AND ((tblEmpHoursWorked.PublicHoliday)='P') AND ((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
		<CFQUERY name="MarkPublicHolidaysB" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Sick and Leave --->
		<cfset strQuery = "UPDATE tblEmpHoursWorked INNER JOIN qryEmpHoursEntitlementB ON tblEmpHoursWorked.HoursWorkedID = qryEmpHoursEntitlementB.HoursWorkedID SET tblEmpHoursWorked.SickMinsAccumultedBy100 = Int(100*[SK_Leave]*[STMins]), tblEmpHoursWorked.LeaveMinsAccumultedBy100 = Int(100*[HolidayPay]*[STMins]) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.DatePaid)='' Or (tblEmpHoursWorked.DatePaid) Is Null) AND ((tblEmpHoursWorked.StoreID)=#lngStoreID#) AND ((tblEmpHoursWorked.WeekEnding)='#strEndWeekDate#'))">
		<CFQUERY name="MarkPublicHolidaysC" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkPublicHolidays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
<!--- Write the summary to the payroll table --->
		<cfset strQuery = "INSERT INTO tblEmpPayRoll ( EmployeeID, EmpStatusID, WeekEnding, StoreID, TaxScaleID, Age, NormalHours, OT1, OT2, HolidayHrs, SickHrs, NormalHoursPay, OT1Pay, OT2Pay, Bonus, Expenses, CarAllowance, OtherAllowance, SickMinsAccumultedBy100, LeaveMinsAccumultedBy100, SuperAccumulated, WorkCompAccumulated , GivenName, Surname) ">
		<cfset strQuery = strQuery & "SELECT qryEmpHoursAC_Week.EmployeeID, qryEmpPayB.EmpStatusID, qryEmpHoursAC_Week.WeekEnding, qryEmpHoursAC_Week.StoreID, qryEmpPayB.TaxScaleID, qryEmpPayB.PayrollAge, qryEmpHoursAC_Week.SSTHours, qryEmpHoursAC_Week.SOT1Hours, qryEmpHoursAC_Week.SOt2Hours, qryEmpHoursAC_Week.SLeaveHours, qryEmpHoursAC_Week.SSickHours, qryEmpHoursAC_Week.STValue, qryEmpHoursAC_Week.OT1Value, qryEmpHoursAC_Week.Ot2Value, qryEmpHoursAC_Week.SBonus, qryEmpHoursAC_Week.SExpenses, qryEmpPayB.CarAllowancePerWeek, qryEmpPayB.OtherAllowancePerWeek, qryEmpHoursAC_Week.SSickMinsAccumultedBy100, qryEmpHoursAC_Week.SLeaveMinsAccumultedBy100, qryEmpHoursAC_Week.SSuperAccumulated, qryEmpHoursAC_Week.SWorkCompAccumulated , qryEmpPayB.GivenName, qryEmpPayB.Surname ">
		<cfset strQuery = strQuery & "FROM qryEmpHoursAC_Week INNER JOIN qryEmpPayB ON (qryEmpHoursAC_Week.StoreID = qryEmpPayB.StoreID) AND (qryEmpHoursAC_Week.EmployeeID = qryEmpPayB.EmployeeID) ">
		<cfset strQuery = strQuery & "WHERE (((qryEmpHoursAC_Week.WeekEnding)='#strEndWeekDate#') AND ((qryEmpHoursAC_Week.StoreID)=#lngStoreID#))">
		<CFQUERY name="WriteSummary" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="WriteSummary" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Calculate sick and leave hours that we can pay --->
		<cfset strQuery = "UPDATE tblEmployee INNER JOIN tblEmpPayRoll ON (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmployee.StoreID = tblEmpPayRoll.StoreID) SET tblEmpPayRoll.HolidayHrsCanBePaid = IIf([HolidayHrs]<=([tblEmployee].[LeaveMinsAccumultedBy100]/100),[HolidayHrs],([tblEmployee].[LeaveMinsAccumultedBy100]/100)) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null) AND ((tblEmpPayRoll.HolidayHrs)>0.0001))">
		<CFQUERY name="MarkTheHoliday" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkTheHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmployee INNER JOIN tblEmpPayRoll ON (tblEmployee.EmployeeID = tblEmpPayRoll.EmployeeID) AND (tblEmployee.StoreID = tblEmpPayRoll.StoreID) SET tblEmpPayRoll.SickHrsCanBePaid = IIf([SickHrs]<=([tblEmployee].[SickMinsAccumultedBy100]/100),[SickHrs],([tblEmployee].[SickMinsAccumultedBy100]/100)) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.PayPaidDate)='' Or (tblEmpPayRoll.PayPaidDate) Is Null) AND ((tblEmpPayRoll.SickHrs)>0.0001))">
		<CFQUERY name="MarkTheHolidayB" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkTheHoliday" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Holiday Loading , Holiday Pay, Sick Pay --->
		<cfset strQuery = "UPDATE tblEmpPayRoll, qryEmpPayOptions SET tblEmpPayRoll.HolidayLoading = [qryEmpPayOptions].[HolidayLoading] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="HolidayLoading" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="HolidayLoading" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>
		
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.HolidayLoadingValue = [HolidayLoading]*[HolidayHrsCanBePaid]*[NormalHoursPay], tblEmpPayRoll.HolidayHrsCanBePaidValue = [HolidayHrsCanBePaid]*[NormalHoursPay] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.HolidayHrsCanBePaid)>0.0001))">
		<CFQUERY name="MarkHolidayValues" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkHolidayValues" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.SickHrsCanBePaidValue = [SickHrsCanBePaid]*[NormalHoursPay] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.SickHrsCanBePaid)>0.0001) AND ((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="MarkSickValues" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkSickValues" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Taxable, Non taxable Income --->
		<cfset strQuery = "UPDATE tblEmpPayRoll SET tblEmpPayRoll.TaxableIncome = [NormalHoursPay]+[OT1Pay]+[OT2Pay]+[HolidayHrsCanBePaidValue]+[SickHrsCanBePaidValue]+[Bonus]+[ShiftAllowance], tblEmpPayRoll.NonTaxableIncome = [HolidayLoadingValue]+[Expenses]+[CarAllowance]+[OtherAllowance] ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="TaxableIncome" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="TaxableIncome" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Calculate Tax --->
		<cfset strQuery = "UPDATE tblEmpPayRoll INNER JOIN tblEmpTaxScaleDet ON tblEmpPayRoll.TaxScaleID = tblEmpTaxScaleDet.TaxScaleID SET tblEmpPayRoll.Tax = Format(IIf(([a]*[TaxableIncome])-[b]<0.0001,0,([a]*[TaxableIncome])-[b]),'Fixed') ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#) AND ((tblEmpPayRoll.TaxableIncome) Between [GrossFrom] And [GrossTo]))">
		<CFQUERY name="CalculateTax" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CalculateTax" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

<!--- Super / Workers Comp --->
		<cfset strQuery = "UPDATE tblEmpPayRoll, qryEmpPayOptions SET tblEmpPayRoll.SuperAccumulated = [SuperRate]*([TaxableIncome]+[NonTaxableIncome]), tblEmpPayRoll.WorkCompAccumulated = [WorkersComp]*([TaxableIncome]+[NonTaxableIncome]) ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpPayRoll.WeekEnding)='#strEndWeekDate#') AND ((tblEmpPayRoll.StoreID)=#lngStoreID#))">
		<CFQUERY name="WorkersComp" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="WorkersComp" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
 		</CFQUERY>

</cfif>		
	
	<cfabort>	
	
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">


