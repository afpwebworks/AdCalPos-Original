
<cfset strDate = #FORM.txtOrderDate#>
<cfset lngStoreID = #FORM.txtStoreID#>

<!--- validate the date --->
<cfif len(#strDate#) EQ 7>
	<cfset strDate = "0" & "#strDate#" >
</cfif>
<cfif isDefined("form.notFrozen")>
	<cflocation URL = "PackingList.cfm?DD=#strDate#&ST=#lngStoreID#&type=2">
<cfelse>
	<cflocation URL = "PackingList.cfm?DD=#strDate#&ST=#lngStoreID#&type=1">
</cfif>


