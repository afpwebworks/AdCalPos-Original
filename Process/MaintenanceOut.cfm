<cfsilent> 
<!----
==========================================================================================================
Filename:     MaintenanceOut.cfm
Description:  Outputs tables from the SQLServer database to an Access database for broadcast of updates to the terminals.
Date:         28/7/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfsetting requesttimeout="1500" />
<cfset StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />
<cfset StockbarcodesDAO =   application.beanfactory.getBean("StockbarcodesDAO") />
<cfset DataTransferManager =   application.beanfactory.getBean("DataTransferManager") />

<!---[   Gather necessary data to publish   ]---->
<cfscript>
	session.starttickcount = getTickcount();
	TempDBName = application.ftpdsn & ".mdb";
    
	//set the paths to the relevant folders.
	ftpDirABS = application.approotabs & "\FTP" ;
	ftpDataABS = ftpDirABS & "\Data";
	ftpImagesABS = ftpDirABS & "\Images";
	workingDIRAbs = application.dbabs ;	
</cfscript>

<!---[    read in the version in the list.dat file.   ]---->
<cffile action="read" file="#ftpDirABS#\list.dat" variable="List_Dat" />
<cfscript>
	session.ListVersion = listfirst(List_Dat, "|");
	session.DatabaseFile = listLast(List_Dat, "|");
  </cfscript>
 </cfsilent> 
<!---[   If the our current version in the SQLServer is greater than the current version of the file .....   ]---->
<cfif  DataTransferManager.getCurrentRevision() GT session.ListVersion>
<cfsilent> 
<!---[   Find out the exact name of the zip file.   ]---->
<cfdirectory action="list" filter="*.zip" directory="#ftpDirABS#" name="FileList" />
<cfset session.originalfilename = FileList.Name />
<!---[   Open the zip file   ]---->
<cfzip  action = "unzip" 
    destination = "#workingDIRAbs#" 
    file = "#ftpDirABS#\#session.originalfilename#" 
    overwrite = "yes" />
<!---[    Rename the zip file to prevent someone downloading the file while we're in the process of updating it.   ]---->
<cffile action="rename" source="#ftpDirABS#\#session.originalfilename#" destination="#ftpDirABS#\Tempstorage.zip" />
<!---[   Rename the extracted datafile to mdb.   ]---->
<cfif fileexists( "#workingDIRAbs#\StaticStandalone.spd" ) >
  <cffile action="rename" source="#workingDIRAbs#\StaticStandalone.spd" destination="#workingDIRAbs#\#TempDBName#" />
</cfif>

<!---[   A cftry/cfcatch wrapper to catch any datasource errors and notify webmaster if any found.   ]---->
<cftry>
  <!---[   Test access to the MDB.   ]---->
  <cfquery name="testquery" datasource="#application.ftpdsn#">
        SELECT ProductID from Product
      </cfquery>
      
  <!---[   Insert the prices data into the MDB database.   ]---->
  <cfinclude template="/Process/MaintenanceOutIncludes/tblStockPrice.cfm" />

<!---[   Insert/update into the Product table all the records from the SQLServer database.   ]---->
<cfinclude template="/Process/MaintenanceOutIncludes/tblStockMaster.cfm" />

<!---[   Insert the barcode data into the MDB database.   ]---->
<cfinclude template="/Process/MaintenanceOutIncludes/tblStockBarcode.cfm" />

<!---[   Insert the Productprices data into the MDB database.   ]---->
<cfinclude template="/Process/MaintenanceOutIncludes/tblStockProductPrice.cfm" />
<cfcatch type="any">
  <!---[   There is an error so abort processing now and notify webmaster.   ]---->
  <cfmail to="#application.webmasteremail#" from="#application.webmasteremail#" subject="#application.sitemailindex# Error in #application.applicationName# - MaintenanceOut" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
  <cfoutput>
  <h2>An error occured in AdCalPos maintenance processing for #application.sitemailindex#</h2>
  <p> Page: #cgi.script_name#?#cgi.query_string#<br>
    Time: #dateFormat(request.austime, "d/m/yyyy")# at #lcase(timeFormat(request.austime, "h:mmtt"))#<br>
  </p>
  <ul>
    <li><b>Message:</b> #cfcatch.Message# </li>
    <li><b>Detail:</b> #cfcatch.Detail# </li>
  </ul>
  <cfdump var="#cfcatch#" />
  </cfoutput>
  </cfmail>
</cfcatch>
</cftry>

<!---[   Tidy up the rubbish afterwards.   Delete the temporary database files.   ]---->
<cflocation url="/Process/MaintenanceOut2.cfm" addtoken="no" />
<cfabort />
</cfsilent>
<cfelse>
<cfinclude template="/includes/header.cfm" />
<h1>No changes to make.</h1>
<!-------[  <cfdump var="#application#" label="Application Vars. Line 99 Maintenanceout.cfm" />
<cfdump var="#cgi#" label="cgi Vars. Line 100 Maintenanceout.cfm" />
<cfdump var="#session#" label="session Vars. Line 101 Maintenanceout.cfm" />   ]----MK ----->
</body>
</html>
</cfif>


