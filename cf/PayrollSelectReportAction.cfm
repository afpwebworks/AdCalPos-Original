
<cfset strPageTitle = "Payroll Reports">
<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->
<cfset lngStoreID = #session.storeid#> 

<cfset lngDay=right(form.sDate,2)>
<cfset lngMonth=mid(form.sDate,5,2)>
<cfset lngYear=left(form.sDate,4)>

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
		<cfset strStartWeekDate = #strNextDate#>	
	
		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strEndWeekDate#">
		<cfset lngEndWeekDate = #lngDateLong#>	

		<CFSET lngDateLong = 0>
		<CF_GetDateLong baseDate="#strStartWeekDate#">
		<cfset lngStartWeekDate = #lngDateLong#>	

		<CFIF ParameterExists(Form.AmountToPay)>
			<cflocation URL = "PayrollSelectReportPage.cfm?WE=#strEndWeekDate#&SID=#lngStoreID#">				
		</cfif>
<cfelse>		
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">		
</cfif>

