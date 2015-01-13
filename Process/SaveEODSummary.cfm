<cfsilent>
<!----
==========================================================================================================
Filename:     SaveEODSummary.cfm
Description:  Processes the updates to the tblEODSummaryc flags table
Date:         18/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset EoDSummaryDAO =   application.beanfactory.getBean("EoDSummaryDAO") />
<cfset PosDAO = application.beanfactory.getbean("PosDAO") />
<cftry>
<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
<cfset EODTotalNoError = true />


<!---[   Create a EoDSummary bean, initialised with the defaults   ]---->
<cfscript>
EoDSummary = application.beanfactory.getBean("EoDSummary") ;
daystring = datepart("d", request.austime);
monthstring = datepart("m", request.austime);
yearstring = datepart("yyyy", request.austime);
if (len(daystring) == "1" ) daystring = ( "0" & daystring ) ; 
if (len(monthstring) == "1" ) monthstring = ("0" & monthstring );
datestring = daystring & monthstring & yearstring;
EoDSummary.setdate( datestring );
EoDSummary.setStoreID( PosBean.getstoreID()  );
EoDSummary.setdateentered( request.austime ) ;

//if the EoDSummary item exists in the database already,  read it in
EoDSummaryDAO.read(  EoDSummary );
//update with the flags we want to set this time
EoDSummary.setEod_ECR_CSV_Updated( true );
EoDSummary.setEod_PLU_CSV_Updated( true );  
EoDSummaryDAO.save(  EoDSummary ) ;
</cfscript>




<cfcatch type="any">
	<cfset EODTotalNoError = false />
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.EODTotal = "Error in EODTotal, PosTXID = #session.PosTXID#" />
</cfcatch>
</cftry>
<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif EODTotalNoError is true >
		<cfset PosDAO.setEODSummaryPostedFlag(session.PosTXID) />
	</cfif>  

</cfsilent>


