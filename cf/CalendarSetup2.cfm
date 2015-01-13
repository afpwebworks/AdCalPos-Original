
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<!--- - // setup from date calendar // - --->
<!--- - wb 12/12/2003 -  forward from current month - --->
	<cfparam name="session.monthCal" default="0"> 
<cfif isDefined("url.pos")>
	<cfif isDefined("url.pos") AND url.pos EQ "fwd">
			<cfset session.monthCal=session.monthCal+1>	
	<cfelseif isDefined("url.pos") AND url.pos EQ "bwd">	
			<cfset session.monthCal=session.monthCal-1>
	</cfif>
<cfelseif isDefined("url.month1")>
	<cfif url.month1 GT url.current>
		<cfset local.calMovment=url.month1-url.current>
			<cfset session.monthCal=session.monthCal+local.calMovment>
	<cfelseif url.month1 LT url.current>	
		<cfset local.calMovment=url.current-url.month1>
			<cfset session.monthCal=session.monthCal-local.calMovment>
	</cfif>	
<cfelseif isDefined("url.year1")>
	<cfif url.year1 GT url.current>
		<cfset local.calMovment=(url.year1-url.current)*12>
			<cfset session.monthCal=session.monthCal+local.calMovment>
	<cfelseif url.year1 LT url.current>	
		<cfset local.calMovment=(url.current-url.year1)*12>
			<cfset session.monthCal=session.monthCal-local.calMovment>
	</cfif>
</cfif>	
<!--- - // setup to date calendar // - --->
<!--- - wb 12/12/2003 -  forward from current month - --->
	<cfparam name="session.monthCalTo" default="0"> 
<cfif isDefined("url.posTo")>
	<cfif isDefined("url.posTo") AND url.posTo EQ "fwdTo">
			<cfset session.monthCalTo=session.monthCalTo+1>	
	<cfelseif isDefined("url.posTo") AND url.posTo EQ "bwdTo">	
			<cfset session.monthCalTo=session.monthCalTo-1>
	</cfif>
<cfelseif isDefined("url.month2")>
	<cfif url.month2 GT url.current>
		<cfset local.calMovment=url.month2-url.current>
		<cfset session.monthCalTo=session.monthCalTo+local.calMovment>
	<cfelseif url.month2 LT url.current>	
		<cfset local.calMovment=url.current-url.month2>
		<cfset session.monthCalTo=session.monthCalTo-local.calMovment>
	</cfif>	
<cfelseif isDefined("url.year2")>
	<cfif url.year2 GT url.current>
		<cfset local.calMovment=(url.year2-url.current)*12>
		<cfset session.monthCalTo=session.monthCalTo+local.calMovment>
	<cfelseif url.year2 LT url.current>	
		<cfset local.calMovment=(url.current-url.year2)*12>
		<cfset session.monthCalTo=session.monthCalTo-local.calMovment>
	</cfif>
</cfif>	