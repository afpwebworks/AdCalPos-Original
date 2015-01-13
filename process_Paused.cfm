<cfsetting showdebugoutput="yes" />
<cfsilent>
<!----
==========================================================================================================
Filename:     process.cfm
Description:  Processing page for adcalpos.net.au
Date:         7/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
19/5/2010 Prevent PLUTotals if Posbean.PosType not equal to '90'. (line 122)  Requested LM 19/5/2010 MK
==========================================================================================================
--->
<cfset request.pagename = "Processing page" />
<cfif NOT(isdefined("application.PosLinesDAO"))> 
   <cfset application.PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />
</cfif> 
<cfif NOT(isdefined("application.PosDAO"))> 
   <cfset application.PosDAO =   application.beanfactory.getBean("PosDAO") />
</cfif> 
<cfif NOT(isdefined("application.PosMediaDAO"))> 
   <cfset application.PosMediaDAO =   application.beanfactory.getBean("PosMediaDAO") />
</cfif> 
<!---[   Initialise the elements required   ]---->
<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
<cfset session.ProcessNoErrors = true />
<cfset structDelete(session, "Transaction")/>
<cfset structDelete(session, "Line")/>
<cfset structDelete(session, "PosMedia")/>
<cfset structDelete(session, "Media")/> 
<cfset structDelete(session, "PosTxID")/>
<cfset structDelete(session, "processerrors")/>




<!---[   Temporarily log the receipt of the data.   ]---->
	<cfinclude template="/Process/LogEntry.cfm" />
<!---[   Receive the XML data   ]---->
<!---[   Parse the XML File as a CF XML variable   ]---->
<cfset mydoc = XmlParse(form.data)>
<cfset numtables = arraylen(mydoc.tables.XMLChildren) />

<!---[   Loop over the tables,  and process each to the database   ]---->
<cfloop from="1" to="#numtables#" index="t" >
	<cfset struct = structnew() />
    <cfset numitems = arraylen(mydoc.tables.table[t].fields.XmlChildren) />
    <cfset tablename = mydoc.tables.table[t].xmlattributes.name />
    
<!---[   First of all for the table POS   ]---->
<cfif #tablename#  is "Pos">
		<cfset PosBean = application.beanfactory.getBean("PosBean") />
       <!---[  Transfer the values to the Posbean, then persist the values in to the database.   ]---->
      <cfinclude template="/Process/SavePosBean.cfm" />
      <!---[   Transfer the new PosTXID to a session variable.   ]---->
      <cfset session.PosTXID = posbean.getPosTXID() />
      <cfset session.StoreID = posbean.getStoreID() />
     <!---[   IF it's not the first table (Pos) it must be one of the other tables.  ]---->
 <cfelseif #tablename#  is "PosLine">
 	    <cfset PosLineBean = application.beanfactory.getBean("PosLineBean") />
        <cfset PosLineBean.setpostxid( session.PosTXID ) />
        <cfset session.Transaction.Line = structnew() />
       <!---[      Transfer the values to the PosLinebean, then persist the values in to the database.   ]---->
       <cfinclude template="/Process/CreatePosLineBean.cfm" /> 
       <cfinclude template="/Process/SavePosLineBean.cfm" /> 
       
 <cfelseif #tablename#  is "PosMedia">
 		<cfset PosMediaBean = application.beanfactory.getBean("PosMediaBean") />
 		<cfset PosMediaBean.setpostxid( session.PosTXID ) />
        <cfset session.Transaction.Media = structnew() />
        <cfinclude template="/Process/SavePosMediaBean.cfm" /> 
 <cfelse>
<!---[        Temporarily comment this test out, to allow ongoing development with new tables.
	 <cfset session.errorhandler.setError("Table", "The Table #tablename# is not handled.  Advise webmaster") />
   ]---->  
  </cfif>
</cfloop>
  
<cfif session.errorhandler.haserrors()>
	<cfset result = session.errorhandler.MakeErrorString( session.errorhandler ) />
  <!---[     Delete any records that have already been inserted into the database   ]---->
  	<cfscript> 
		PosBean = application.beanfactory.getBean("PosBean");
		PosBean.setPosTXID( session.PosTXID );
		application.PosDAO.delete( PosBean );
	</cfscript>    
<cfelse>
	 <cfset result = "OK" />   
</cfif>
</cfsilent> 
<cfcontent reset="yes"/><cfoutput>#result#</cfoutput>
<cfsilent>
<!---[  
==========================================================================================
 Now process again for other tables processed after the POS terminal released.  
==========================================================================================
 ]---->
<cfif result is "OK">
<!---[   Ensure the DAO components are available.   ]---->
	<cfif NOT(isdefined("application.PosMixMatchDAO"))> 
       <cfset application.PosMixMatchDAO =   application.beanfactory.getBean("PosMixMatchDAO") />
    </cfif> 
    <cfif NOT(isdefined("application.PosMixMatchProductDAO"))> 
       <cfset application.PosMixMatchProductDAO =   application.beanfactory.getBean("PosMixMatchProductDAO") />
    </cfif> 
    <cfif NOT(isdefined("application.StockmasterDAO"))> 
       <cfset application.StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />
    </cfif> 
    <cfif NOT(isdefined("application.StoreECRTTotalsDAO"))> 
   <cfset application.StoreECRTTotalsDAO =   application.beanfactory.getBean("StoreECRTTotalsDAO") />
</cfif>

<!---[   Loop through the XML file again to extract the later processing data   ]---->
<cfloop from="1" to="#numtables#" index="t" >
	<cfset numitems = arraylen(mydoc.tables.table[t].fields.XmlChildren) />
    <cfset tablename = mydoc.tables.table[t].xmlattributes.name />
<cfif #tablename#  is "PosMixMatch">
	  <cfset PosMixMatch = application.beanfactory.getBean("PosMixMatch") />
	  <cfinclude template="/Process/SavePosMixMatch.cfm" /> 
<cfelseif   #tablename#  is "PosMixMatchProduct">  
	  <cfset PosMixMatchProduct = application.beanfactory.getBean("PosMixMatchProduct") />
      <cfinclude template="/Process/SavePosMixMatchProduct.cfm" /> 
<cfelseif #tablename#  is "PosLine">  
	  <cfset PosLineBean = application.beanfactory.getBean("PosLineBean") />
      <cfset PosLineBean.setpostxid( session.PosTXID ) />
      <cfset session.Transaction.Line = structnew() />
      <cfinclude template="/Process/CreatePosLineBean.cfm" /> 
      <cfinclude template="/Process/SavetblStockMaster.cfm" />

      <cfinclude template="/Process/SavetblStockLocation.cfm" />
    	<!---[   Only allow PLUTotals updates if PosType is not equal to "90"  
		and if PosType isnt a cancelled sale (255) ]---->
      <cfif (PosBean.getPosType() neq "90") AND (PosBean.getPosType() neq "255")>
      	  <cfinclude template="/Process/SaveStockLevels.cfm" />
	      <cfinclude template="/Process/SaveStore_PLUTotals.cfm" />
      </cfif>
  </cfif>

</cfloop>      
<!---[   Update the store_ECRTotals   ]---->
	<cfscript>
        //Recreate the PosBean
        PosBean = application.beanfactory.getBean("PosBean");
		PosMediaBean = application.beanfactory.getBean("PosMediaBean");
		PosBean.setPosTXID( session.PosTXID );
		PosMediaBean.setpostxid( session.PosTXID );
		application.PosDAO.read( PosBean );
		SequenceList = application.PosMediaDAO.getSequencesforPosTXID( PosMediaBean );
    </cfscript>
    <cfloop list="#SequenceList#" index="seq">
		<cfscript>
            PosMediaBean.setSequenceID( seq ) ;
            application.PosMediaDAO.read(PosMediaBean);
        </cfscript>
    <cfinclude template="/Process/SaveStore_ECRTotals.cfm" />
   </cfloop>


<!---[   Set the flags for EoDSummary   ]---->
<cfinclude template="/Process/SaveEODSummary.cfm" />
<!---[   finally update the status to 255, if we are successful to here.   ]---->
		<cfif session.ProcessNoErrors >
            <cfset application.PosDAO.setPosStatus( session.PosTXID, "255") />
       <cfelse>
			<!---[   If not successful, tell daddy what is wrong.    ]---->
            <!---[   First save the xml packet as a file, so it can be attached.   ]---->
            <cffile action="write" file="#application.uploaddirABS#\XMLPacket#session.PosTXID#.xml" output = "#mydoc#" />
            <cfmail to="#application.webmasteremail#"  from="#application.webmasteremail#" subject="[POS: #PosBean.getPosTXID()#} Error in Shades'n'Style Processing"
            server="#application.mailserver#"  username="#application.mailuser#" password="#application.mailpassword#" type="html">
            <cfmailparam type="text" file="#application.uploaddirABS#\XMLPacket#session.PosTXID#.xml" disposition="attachment" /> 
            <!---[   <cfmailparam name="XMLPacket" value="#mydoc#" />   ]---->
            <html><head><title>[POS: #PosBean.getPosTXID()#} Error in Shard Processing</title></head><body><p>There was an error in processing in the Shades'n'Style  site. </p>
            <cfdump var="#posbean.getsnapshot()#" label="PosBean">
            <cfdump var="#session#" label="session vars">
            <cfdump var="#ECRTTotal.getsnapshot()#" label="ECRTTotal"/>
            
            </body></html>
            </cfmail> 
            <!---[   ... And tidy up after myself.   ]---->
           <cffile action="delete" file="#application.uploaddirABS#\XMLPacket#session.PosTXID#.xml"/>                     
            
        </cfif>
</cfif>
</cfsilent>
