<cfsilent>
<!----
==========================================================================================================
Filename:     tblStockBarcode.cfm
Description:  Exports data from the tblStockBarcode table in the SQLServer database to the StaticStandalone.mdb
Date:         20/Dec/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset StockbarcodesDAO =   application.beanfactory.getBean("StockbarcodesDAO") />
<cfset DataTransferManager = application.beanfactory.getbean("DataTransferManager") />

<!---[    Get the data to export.   ]---->
<cfset BarcodeData = DataTransferManager.getAllBarcodesSQL() />
<cftry>
  <!---[   Clear the exisiting barcode records.   ]---->
  <cfset DataTransferManager.ClearBarcodeTableMDB() />
  <cfdump var="#BarcodeData#" label="BarcodeData" />
  
  <!---[   Loop through the data query, inserting into the Access database.   ]---->
  <cfloop query="BarcodeData" >
  <cfset DataTransferManager.saveBarcodetoMDB( BarcodeData.PartNo, BarcodeData.Barcode, BarcodeData.ProductID ) />
  </cfloop>
<cfcatch type="any">
    <cfmail to="#application.webmasteremail#" from="#application.webmasteremail#" subject="#application.sitemailindex#: Error in #application.applicationName# MaintenanceOut" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
    <cfoutput>
    <h2>An error occured in #application.sitename# Maintenance out routine in the file tblStockBarcode.cfm.</h2>
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
