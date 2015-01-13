

<!--- KF amendment, no need for attributes scope as CFINCLUDE brings thru
variables anyway --->
<!--- <CFSET lngStoreID = Attributes.storeid > --->
<CFSET lngStoreID = storeid > 

	<cfset strDateToday = "">
	<cf_GetTodayDate>

	<cfset strTomorrowDate = "">
	<cf_GetTomorrowDate>

    <!--- Check to see if a record exist n the EOD summary for today --->
   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
	<cfset strQuery = strQuery & "FROM tblEodSummary ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strDateToday#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="CheckEODSummary"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckEODSummary.RecordCount# LT 1>
		<!--- Add a record to EOD summary --->
	   	<cfset strQuery = "insert into tblEodSummary (Date, StoreID ) ">
		<cfset strQuery = strQuery & "values ('#strDateToday#', #lngStoreID# )">
		<CFQUERY name="AddDateToEODSummary"  datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>

    <!--- Check to see if a record exist n the EOD summary for tomorrow --->
   	<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
	<cfset strQuery = strQuery & "FROM tblEodSummary ">
	<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strTomorrowDate#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
	<CFQUERY name="CheckEODSummary2"  datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfif #CheckEODSummary2.RecordCount# LT 1>
		<!--- Add a record to EOD summary --->
	   	<cfset strQuery = "insert into tblEodSummary (Date, StoreID ) ">
		<cfset strQuery = strQuery & "values ('#strTomorrowDate#', #lngStoreID# )">
		<CFQUERY name="AddDateToEODSummary2"  datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>
