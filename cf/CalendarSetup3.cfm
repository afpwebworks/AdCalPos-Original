
<cfsetting enablecfoutputonly="yes">
<!--- - // setup 1st date calendar // - --->
<!--- - wb 12/12/2003 -  forward from current month - --->
<cflock timeout="5" type="EXCLUSIVE">
	<cfparam name="session.monthCal" default="0"> 
</cflock>
<cfif isDefined("url.pos") AND url.pos EQ "fwd">
	<cflock timeout="5" type="EXCLUSIVE">
		<cfset session.monthCal=session.monthCal+1>	
	</cflock>
<cfelseif isDefined("url.pos") AND url.pos EQ "bwd">	
	<cflock timeout="5" type="EXCLUSIVE">	
		<cfset session.monthCal=session.monthCal-1>
	</cflock>
</cfif>
<cfsetting enablecfoutputonly="no">
<cfset strPageTitle = "Check Credits">
<cfset lngStoreID = #session.StoreID#>

<!--- - // setup 2nd date calendar // - --->
<!--- - wb 12/12/2003 -  forward from current month - --->
<cflock timeout="5" type="EXCLUSIVE">
	<cfparam name="session.monthCal2" default="0"> 
</cflock>
<cfif isDefined("url.pos2") AND url.pos2 EQ "fwd2">
	<cflock timeout="5" type="EXCLUSIVE">
		<cfset session.monthCal2=session.monthCal2+1>	
	</cflock>
<cfelseif isDefined("url.pos2") AND url.pos2 EQ "bwd2">	
	<cflock timeout="5" type="EXCLUSIVE">	
		<cfset session.monthCal2=session.monthCal2-1>
	</cflock>
</cfif>

<!--- - // setup 3rd date calendar // - --->
<!--- - wb 12/12/2003 -  forward from current month - --->
<cflock timeout="5" type="EXCLUSIVE">
	<cfparam name="session.monthCal3" default="0"> 
</cflock>
<cfif isDefined("url.pos3") AND url.pos3 EQ "fwd3">
	<cflock timeout="5" type="EXCLUSIVE">
		<cfset session.monthCal3=session.monthCal3+1>	
	</cflock>
<cfelseif isDefined("url.pos3") AND url.pos3 EQ "bwd3">	
	<cflock timeout="5" type="EXCLUSIVE">	
		<cfset session.monthCal3=session.monthCal3-1>
	</cflock>
</cfif>
<cfsetting enablecfoutputonly="no">
