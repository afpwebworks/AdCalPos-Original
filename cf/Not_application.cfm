
<cfapplication name="costiSQL" clientmanagement="Yes" sessionmanagement="Yes" setclientcookies="Yes" sessiontimeout="#createtimespan(0,0,59,0)#" applicationtimeout="#createtimespan(1,0,0,0)#"> 
<!--- Check to see if this is the first time that the application is accessed by a client.  If so then set variables --->
<!--- - LM 29/7/2007 - Live site DB details - --->
<cfset Applic_DBTYPE = "ODBC">
<cfset Applic_PROVIDER = "SQLOLEDB">

<!--- user database --->
<cfset Applic_dataSource = "spidert_spider"> 

<!--- data source name --->
<cfset Applic_PROVIDERDSN = "spidert_spider"> 

<!--- database related --->
<cfset Applic_USERNAME = "spider_testing">  

<!--- database related --->
<cfset Applic_PASSWORD = "spidertest"> 

<!--- user database --->
<cfset Applic_DBNAME = "spidertest"> 

<!--- database server name --->
<cfset Applic_DBSERVER = "mssql.joshua.fasthit.net,39322"> 

<!--- application web root for this user ---> 
<cfset Applic_WebRoot="D:\hshome\SpiderTe\"> 

<cfset Applic_AppRoot=Applic_WebRoot & "spider.fasthit.net\SpiderTest\database\costi_SQL_EOD.mdb">

<cfset Applic_DBRoot=Applic_WebRoot & "spider.fasthit.net\SpiderTest\database\">


<cfset AppProvider = "Microsoft.Jet.OLEDB.4.0">

<cfif not isdefined("session.rollcount")>
	<cfset session.rollcount=1>
</cfif>

