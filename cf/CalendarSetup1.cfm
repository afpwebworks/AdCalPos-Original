
<cfsetting enablecfoutputonly="yes">
<cflock timeout="5" type="EXCLUSIVE">
	<cfparam name="session.monthCal" default="0"> 
</cflock>
<cfif isDefined("url.pos")>
	<!--- - forward from current month - --->
	<cfif url.pos EQ "fwd">
		<cflock timeout="5" type="EXCLUSIVE">
			<cfset session.monthCal=session.monthCal+1>	
		</cflock>
	<!--- - backward from current month - --->
	<cfelseif url.pos EQ "bwd">	
		<cflock timeout="5" type="EXCLUSIVE">	
			<cfset session.monthCal=session.monthCal-1>
		</cflock>
	</cfif>
<cfelseif isDefined("url.month")>
	<cfif url.month GT url.current>
		<cfset local.calMovment=url.month-url.current>
		<cflock timeout="5" type="EXCLUSIVE">
			<cfset session.monthCal=session.monthCal+local.calMovment>
		</cflock>
	<cfelseif url.month LT url.current>	
		<cfset local.calMovment=url.current-url.month>
		<cflock timeout="5" type="EXCLUSIVE">
			<cfset session.monthCal=session.monthCal-local.calMovment>
		</cflock>
	</cfif>	
<cfelseif isDefined("url.year")>
	<cfif url.year GT url.current>
		<cfset local.calMovment=(url.year-url.current)*12>
		<cflock timeout="5" type="EXCLUSIVE">
			<cfset session.monthCal=session.monthCal+local.calMovment>
		</cflock>
	<cfelseif url.year LT url.current>	
		<cfset local.calMovment=(url.current-url.year)*12>
		<cflock timeout="5" type="EXCLUSIVE">
			<cfset session.monthCal=session.monthCal-local.calMovment>
		</cflock>
	</cfif>
</cfif>
<cfsetting enablecfoutputonly="no">
