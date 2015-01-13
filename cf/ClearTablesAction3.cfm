
<cfset strPageTitle = "Clear Tables">
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

<cfset lngDayTo = #Form.DT#>
<cfset lngMonthTo = #Form.MT#>
<cfset lngYearTo = #Form.YT#>

<cfif #len(lngDayTo)# LT 2>
	<cfset lngDayTo = "0" & "#lngDayTo#">
</cfif>
<cfif #len(lngMonthTo)# LT 2>
	<cfset lngMonthTo = "0" & "#lngMonthTo#">
</cfif>
<cfset strDateTo = "#lngDayTo#" & "#lngMonthTo#" & "#lngYearTo#">

<cfset lngStoreID = #session.storeid#>


<CFIF ParameterExists(Form.AmountToPay)>
	<cflocation URL = "PayrollSelectReportPageTax.cfm?DF=#strDate#&DT=#strDateTo#&SID=#lngStoreID#">				
</cfif>

