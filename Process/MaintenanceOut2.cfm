 <cfsilent> 
<!----
==========================================================================================================
Filename:     maintenanceout2.cfm
Description:  Rubbish Cleanup file for the maintenance out process.
Date:         10/10/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset DataTransferManager =   application.beanfactory.getBean("DataTransferManager") />
<cfscript>
	TempDBName = application.ftpdsn & ".mdb";
	ftpDirABS = application.approotabs & "\FTP" ;
	ftpDataABS = ftpDirABS & "\Data";
	ftpImagesABS = ftpDirABS & "\Images";
	workingDIRAbs = application.dbabs ;	
</cfscript>
<cfparam name="request.pagename" default="Set Maintenance Broadcast">
 </cfsilent>

<cfinclude template="/includes/header.cfm" />
<h1>Setting broadcast database file ... </h1>
<cfoutput> 
<!---[   Now save the MDB file back to the FTP directory again.   ]----> 
    <!---[   rename the access database back to the name inside the zip file.   ]---->
    <cfif fileexists( "#workingDIRAbs#\#TempDBName#" ) >
      	<cffile action="copy" source="#workingDIRAbs#\#TempDBName#" destination="#workingDIRAbs#\StaticStandalone.spd" />
  		<!---[   zip the mdb file back into Temporary.zip   ]---->
        <cfzip file="#ftpDirABS#\Tempstorage.zip" source="#workingDIRAbs#\StaticStandalone.spd" overwrite="yes" />
        <!---[   rename back to the original  ]---->
        <cffile action="rename" source="#ftpDirABS#\Tempstorage.zip" destination="#ftpDirABS#\#session.originalfilename#" />
    </cfif>
    <!---[   Now increment the version number in the List.dat file, application variables, and the tblOptions record in the database  ]---->
    <cfset newversion = session.ListVersion + 1 />
    <cfset DataTransferManager.setCurrentRevision( newversion  ) />    
    <cfset List_Dat = newversion & "|" & session.DatabaseFile />
    <cffile action="write" file="#ftpDirABS#\list.dat" output="#List_Dat#" addNewLine="no" />
<!---[   
=======================================================================
  Manage the image files.  
=======================================================================  
]---->
  <cffile action="read" file="#ftpImagesABS#\list.dat" variable="ImageList_Dat" />    
<!---[   Query the database to get the list of images to process   ]---->
<cfquery name="qImageToProcess" datasource="#application.dsn#">
	SELECT PictureFileID, PictureFileName, latestversion
    FROM tblpicturefile
    WHERE latestVersion > <cfqueryparam value="#session.ListVersion#" cfsqltype="cf_sql_integer" /> 
</cfquery>
    
<cfif qImageToProcess.recordcount GT '0'> 
<cfset FilePathSource = #application.approotabs# & "\plupics" >   
<!---[   Now we have the list of files to process,  we need to create zip files   ]---->
<cfloop query="qImageToProcess">
	<cfzip file="#ftpImagesABS#\#qImageToProcess.PictureFileName#.zip" source="#FilePathSource#\#qImageToProcess.PictureFileName#" overwrite="yes" />
    <cfset appendstring = newversion & "|" & qImageToProcess.PictureFileName />
    <cffile action="append" file="#ftpImagesABS#\list.dat" output="#appendstring#" />
   	   <!---[    update the version number for the image.   ]---->
       <cfquery name="qUpdatePictureVersion" datasource="#application.dsn#">
        UPDATE tblPictureFile 
        SET latestversion = <cfqueryparam value="#newversion#" cfsqltype="cf_sql_integer" />
        WHERE PictureFileID = <cfqueryparam value="#qImageToProcess.PictureFileID#" cfsqltype="cf_sql_integer" />
       </cfquery>
</cfloop> 
</cfif>
    
  <!---[   Tidy up the rubbish - delete the working files.   ]---->
 <cfif fileexists( "#workingDIRAbs#\#TempDBName#" ) >
    <cffile action="delete" file="#workingDIRAbs#\#TempDBName#" />
    <cfelse>
    <h3>File doesnt exist #workingDIRAbs#\#TempDBName# </h3>
  </cfif>
  <cfif fileexists( "#workingDIRAbs#\StaticStandalone.spd" ) >
    <cffile action="delete" file="#workingDIRAbs#\StaticStandalone.spd" />
    <cfelse>
    <h3>File doesnt exist #workingDIRAbs#\StaticStandalone.spd</h3>
  </cfif>  
  <!---[   Now give the user some feedback.   ]---->
  <div align="center" >
  <h1>Completed!</h1>
  <cfset timetoprocess = getTickcount()-session.starttickcount />
  <h2>2. Process completed at #timeformat(request.austime, "short")# in #numberformat(timetoprocess/1000, "9.9999")# seconds.</h2>
  </div>
  <cfscript>
	  StructDelete(session, "starttickcount");
	  StructDelete(session, "originalfilename");
	  StructDelete(session, "ListVersion");
	  StructDelete(session, "DatabaseFile");  
  </cfscript>
</cfoutput>

</body>
</html>
