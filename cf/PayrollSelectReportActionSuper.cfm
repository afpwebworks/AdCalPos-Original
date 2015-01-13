
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

<cfset lngDayTo=right(form.eDate,2)>
<cfset lngMonthTo=mid(form.eDate,5,2)>
<cfset lngYearTo=left(form.eDate,4)>

<cfif #len(lngDayTo)# LT 2>
	<cfset lngDayTo = "0" & "#lngDayTo#">
</cfif>
<cfif #len(lngMonthTo)# LT 2>
	<cfset lngMonthTo = "0" & "#lngMonthTo#">
</cfif>
<cfset strDateTo = "#lngDayTo#" & "#lngMonthTo#" & "#lngYearTo#">


<cfset lngStoreID = #session.storeid#>

<CFIF ParameterExists(Form.AmountToPay)>
	<cflocation URL = "PayrollSelectReportPageSuper.cfm?DF=#strDate#&DT=#strDateTo#&SID=#lngStoreID#">				
</cfif>

