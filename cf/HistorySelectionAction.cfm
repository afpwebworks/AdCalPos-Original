
<!--- Vlidate the dates --->
&nbsp;
<!--- <cfif #len(Form.FromDate)# neq 8>
	<cfoutput><BR>#Form.FromDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif>
<cfif #len(Form.ToDate)# neq 8>
	<cfoutput><BR>#Form.ToDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<cfset strDateFrom=right(form.sDate,2) & mid(form.sDate,5,2) & left(form.sDate,4)>
<!--- <cfif #len(strDateFrom)# eq 7>
	<cfset strDateFrom = "0#strDateFrom#">
</cfif>	
<cfif len(strDateFrom) neq 8>
	<cfoutput><BR>#Form.FromDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<!--- <cfoutput>#len(strDateFrom)# strDateFrom: #strDateFrom#</cfoutput> --->
<cf_ValidateDate strDateValue ='#strDateFrom#' lngWeekDay = 0>

<cfset strDateTo=right(form.eDate,2) & mid(form.eDate,5,2) & left(form.eDate,4)>
<!--- <cfif #len(strDateTo)# eq 7>
	<cfset strDateTo = "0#strDateTo#">
</cfif>	
<cfif len(strDateTo) neq 8>
	<cfoutput><BR>#Form.ToDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<cf_ValidateDate strDateValue ='#strDateTo#' lngWeekDay = 0>

<cfset strDateToSQL = '#mid(strDateTo,5,4)#' & '#mid(strDateTo,3,2)#' & '#mid(strDateTo,1,2)#'>
<cfset strDateFromSQL = '#mid(strDateFrom,5,4)#' & '#mid(strDateFrom,3,2)#' & '#mid(strDateFrom,1,2)#'>

<cfset lngStoreID = #Form.StoreID#>
<!--- 
<cfoutput><BR>#strDateFromSQL#</cfoutput>
<cfoutput><BR>#strDateToSQL#</cfoutput>
 --->
<CFIF ParameterExists(Form.btnWage)>
	<CFLOCATION url="HistorySelectionWage.cfm?FD=#strDateFromSQL#&TD=#strDateToSQL#&SID=#lngStoreID#">
</cfif>
<CFIF ParameterExists(Form.btnSuper)>
	<CFLOCATION url="HistorySelectionSuper.cfm?FD=#strDateFromSQL#&TD=#strDateToSQL#&SID=#lngStoreID#">
</cfif>
<CFIF ParameterExists(Form.btnTax)>
	<CFLOCATION url="HistorySelectionTax.cfm?FD=#strDateFromSQL#&TD=#strDateToSQL#&SID=#lngStoreID#">
</cfif>


