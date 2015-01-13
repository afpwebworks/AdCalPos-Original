
<cfapplication name="costiSQL" clientmanagement="Yes" sessionmanagement="Yes" setclientcookies="Yes" sessiontimeout="#createtimespan(0,0,59,0)#" applicationtimeout="#createtimespan(1,0,0,0)#"> 
<!--- Check to see if this is the first time that the application is accessed by a client.  If so then set variables --->
<!--- - LM 29/7/2007 - Live site DB details - --->
<cfset Applic_DBTYPE = "OLEDB">
<cfset Applic_PROVIDER = "SQLOLEDB">
<cfset Applic_dataSource = "vs277779_1"> <!--- user database --->
<cfset Applic_PROVIDERDSN = "vs277779_1"> <!--- data source name --->
<cfset Applic_USERNAME = "vs277779_1_dbo"> <!--- database related --->
<cfset Applic_PASSWORD = "etxt6S3Tdg"> <!--- database related --->
<cfset Applic_DBNAME = "vs277779_1"> <!--- user database --->
<cfset Applic_DBSERVER = "wic016q.server-sql.com,4657"> <!--- server name --->
<!--- <cfset Applic_WebRoot="E:\InetPub\vs247001\"> <!--- web root for this user ---> --->
<cfset Applic_WebRoot="\\bne108v\e$\Inetpub\vs247001\"> <!--- web root for this user --->
<cfset Applic_AppRoot=Applic_WebRoot & "ssl\ffe\database\costi_SQL_EOD.mdb">
<cfset Applic_DBRoot=Applic_WebRoot & "ssl\ffe\database\">

<!--- <!--- LM 20070729 should this be here? it is not in Steve Costi Seafoods --->
<cfset application.http="svc002.bne108v.server-web.com">
 --->
<!--- Old settings --->
<!--- <cfset AppCostiDB1 = "E:\InetPub\vs277779\ssl\ffe\database\costi.mdb">  --->
<cfset AppProvider = "Microsoft.Jet.OLEDB.4.0">

<cfif not isdefined("session.rollcount")>
	<cfset session.rollcount=1>
</cfif>

