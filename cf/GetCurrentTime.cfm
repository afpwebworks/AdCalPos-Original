
<!--- Calculates the current time ---> 
<cfset lngCurTime = 100 * #numberformat(hour(now()),"00")# + #numberformat(minute(now()),"00")#>
<CFSET Caller.lngCurTime = #lngCurTime#>



