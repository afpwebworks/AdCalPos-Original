<cfsilent>
<!----
==========================================================================================================
Filename:     LogEntry.cfm
Description:  Logs the entry to the database for audit and debug checking.
Date:         5/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfquery name="qInserttoLog" datasource="#application.dsn#">
INSERT into EntryLog
	(Entry,TimeEntered,SourceIP )  Values (
    <cfqueryparam value="#form.data#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#request.austime#" cfsqltype="cf_sql_timestamp" />,
    <cfqueryparam value="#cgi.REMOTE_ADDR#" cfsqltype="cf_sql_varchar" />
    )
</cfquery>
</cfsilent>

