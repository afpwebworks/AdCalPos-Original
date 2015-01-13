<cfsilent>
<!----
==========================================================================================================
Filename:     Maintenance.cfm
Description:  Maintenance page to process automatic product updates
Date:         28/7/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfif not isdefined("Maintenance")>
	<cfset maintenance = application.beanfactory.getbean("maintenance") />
</cfif>
<cfif NOT(isdefined("application.StockmasterDAO"))> 
   <cfset application.StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />
</cfif>
<cfif NOT(isdefined("application.StockbarcodesDAO"))> 
   <cfset application.StockbarcodesDAO =   application.beanfactory.getBean("StockbarcodesDAO") />
</cfif>
<cfscript>
	ftpDirABS = application.approotabs & "\FTP" ;
	ftpDataABS = ftpDirABS & "\Data";
	ftpImagesABS = ftpDirABS & "\Images";
	workingDIRAbs = application.approotabs & "\Working" ;
</cfscript>
<cfparam name="request.pagename" default="Processing product maintenance">
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfoutput>
<title>#application.sitename#<cfif len(request.pagename)>-#request.pagename#</cfif></title>
</cfoutput>
</head>
<body>
<cfoutput>
<cfdump var="#application#">
<cfdump var="#maintenance.getCurrentRevision()#">
<p>#ftpDirABS#<br />
#ftpDataABS#<br />
#ftpImagesABS#</p>
<!---[    read in the version in the list.dat file.   ]---->
<cffile action="read" file="#ftpDataABS#\list.dat" variable="List_Dat" />
<cfscript>
ListVersion = listfirst(List_Dat, "|");
DatabaseFile = listLast(List_Dat, "|");
</cfscript>
<!---[   If the version of the file is greater than our current version .....   ]---->
<cfif ListVersion GT maintenance.getCurrentRevision() >
<!---[   Find out the exact name of the zip file.   ]---->
<cfdirectory action="list" filter="*.zip" directory="#ftpDataABS#" name="FileList" />
<cfdump var="#FileList#">
<!---[   Open the zip file   ]---->
<cfzip  action = "unzip" 
    destination = "#workingDIRAbs#" 
    file = "#ftpDataABS#\#FileList.Name#" 
    overwrite = "yes" />
<!---[    Rename the zip file to allow a check later to see if a new version has been uploaded while we're busy.   ]---->   
<cffile action="rename" source="#ftpDataABS#\#FileList.Name#" destination="#ftpDataABS#\Tempstorage.zip" />
<!---[   Rename the extracted datafile to mdb.   ]---->
<cfif fileexists( "#workingDIRAbs#\StaticStandalone.spd" ) >
	<cffile action="rename" source="#workingDIRAbs#\StaticStandalone.spd" destination="#workingDIRAbs#\StaticStandalone.mdb" />
</cfif>
<!---[   Run a query to verify connection to the data and collect the data from the access database   ]---->
    <cfquery name="qtestquery" datasource="StaticStandalone">
    	SELECT p.description, p.productid, p.costunit, p.picturefile, p.timestamp, b.barcode, r.sellunit, r.priceid, z.description as pricetype
        from Product p, productbarcode b,productprice r, price z
        where
        p.productid=b.productid AND
        p.productid=r.productid AND
        r.priceid=z.priceid
        order by p.description
    </cfquery>
  <!---[     Loop through the query, and update the tblStockMaster file with the data in the StaticStandalone Product table.   ]---->
  <cfloop query="qtestquery">
   <cfscript>
		 stockMaster = application.beanfactory.getbean("stockMaster") ;
		 // Populate the bean with the current values sqlserver database  ]---->
		stockmaster.setPartNO( qtestquery.productid  ) ;
		StockmasterDAO.read(stockmaster) ;
		//  Now update the stockmaster bean with the values in the access database.   ]---->
		stockmaster.setdescription(  qtestquery.description  ) ;    
		//stockmaster.setpicturefile(  qtestquery.picturefile  ) ;   
		stockmaster.setmaxRetail(  qtestquery.sellunit  ) ; 
		StockmasterDAO.save(stockmaster) ;
		//Stockbarcode = application.beanfactory.getbean("Stockbarcode") ;
		//Stockbarcode.setPartNO( qtestquery.productid ) ;
		//barcodelist = application.StockbarcodesDAO.GetBarcodesforProduct(  qtestquery.productid  );
		// append this barcode to the existing barcodes and save ]---->
		
    </cfscript>
 </cfloop>   
    
<!---[   Extract the database to the working directory.   ]---->
<!---[   copy the database file to the working directory.   ]---->
<!---[  
		 <cffile action="copy" 
				source="#ftpDataABS#\#DatabaseFile#" 
				destination="#workingDIRAbs#\#workingDatabase#" />   
	]---->
<!---[   Open the database file and process the contents   ]---->


<!---[   Check there has been no upload while we're processing the contents. Do this by looking to see if there is a file called #FileList.Name# in the ftp data directory.   If there isnt a file by that name, restore the name of the zip file. ]---->
<cfif NOT( fileexists("#ftpDataABS#\#FileList.Name#") )>
	<!---[   Tidyup = return the zip file name to StaticStandalone.spd.zip   ]---->
	<cffile action="rename" source="#ftpDataABS#\Tempstorage.zip" destination="#ftpDataABS#\#FileList.Name#" />
</cfif>






</cfif>


</cfoutput>
</body>
</html>
