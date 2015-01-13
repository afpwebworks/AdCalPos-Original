<cfsilent>
<!----
==========================================================================================================
Filename:     SavePosLineBean.cfm
Description:  Saves the values of a struct called "Struct" to the PosLinenean,  the persists the values 
Date:         6/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfif NOT structKeyExists(session, "errorhandler")>
<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
</cfif>
<cftry>    
<!---[   Requires a PosLineBean to exist. Created and populated by CreatePosLineBean.cfm.   ]---->
	 
    <cfset PosLineBean.validate(session.errorhandler) />   
	<cfif NOT(session.errorhandler.haserrors())>
    	<cfset application.beanfactory.getbean("PosLinesDAO").save(PosLineBean) />
    </cfif> 
 <cfcatch type="any">
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.PosLine = "Error in SavePosLineBean, PosTXID = #session.PosTXID#, Line: #PosLineBean.getPosLineID()#" />
</cfcatch>
</cftry>   
</cfsilent>    