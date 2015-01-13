<cfsilent> 
<!----
==========================================================================================================
Filename:     tblStockProductPrice.cfm
Description:  Exports data from the tblStockProductPrice table in the SQLServer database to the StaticStandalone.mdb
Date:         20/Dec/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

 <cfset DataTransferManager =   application.beanfactory.getBean("DataTransferManager") />

<!---[    Get the data to export.   ]---->
<cfset ProductPriceData = DataTransferManager.getAllProductPriceData() />
<cftry>
  
  <!---[   Clear the exisiting price records.   ]---->
  <cfset DataTransferManager.ClearPriceTableMDB() />
  
  <!---[   Loop through the data query, inserting into the Access database.   ]---->
  <cfloop query="ProductPriceData" >
  <cfset DataTransferManager.SetStockPriceRecordMDB( ProductPriceData.ProductID, ProductPriceData.PriceID,ProductPriceData.SellIncludeTax,ProductPriceData.SellUnit) />
  </cfloop>
<cfcatch type="any">
    <cfmail to="#application.webmasteremail#" from="#application.webmasteremail#" subject="#application.sitemailindex#: Error in #application.applicationName# MaintenanceOut" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
    <cfoutput>
    <h2>An error occured in #application.sitename# Maintenance out routine in the file tblStockProductPrice.cfm.</h2>
    <p> Page: #cgi.script_name#?#cgi.query_string#<br>
      Time: #dateFormat(request.austime, "d/m/yyyy")# at #lcase(timeFormat(request.austime, "h:mmtt"))#<br>
    </p>
    <cfdump var="#error#" label="error">
    <cfdump var="#url#" label="URL">
    <cfdump var="#form#" label="Form">
    <cfdump var="#cgi#" label="CGI">
    </cfoutput>
    </cfmail>
  </cfcatch>
</cftry>
</cfsilent>
