<cfsilent>
<!----
==========================================================================================================
Filename:     SavePosMixMatch.cfm
Description:  Processes the XML elements relating to the PosMixMatch table to the database
Date:         5/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfif NOT structKeyExists(session, "errorhandler")>
	<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
</cfif>
<cfset PosMixMatchDAO =   application.beanfactory.getBean("PosMixMatchDAO") />
<cfset PosDAO =   application.beanfactory.getBean("PosDAO") />
 <!---[      Create the struct containing the values   ]---->
       <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
			session.Transaction.PosMixMatch.PosTXID = session.PosTXID;
			fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
			value=mydoc.tables.table[t].fields.field[i].xmltext;
			session.Transaction.PosMixMatch[fieldname]=value;		
        </cfscript>  
      </cfloop>    

<cfscript>
     //transfer session struct values to the bean
     if (StructKeyExists(session.Transaction.PosMixMatch, "postxid")) PosMixMatch.setpostxid(trim(session.Transaction.PosMixMatch.postxid));
	 if (StructKeyExists(session.Transaction.PosMixMatch, "MixMatchid")) PosMixMatch.setMixMatchid(trim(session.Transaction.PosMixMatch.MixMatchid));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchdescription"))PosMixMatch.setmixmatchdescription(trim(session.Transaction.PosMixMatch.mixmatchdescription));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchtriggertype"))PosMixMatch.setmixmatchtriggertype(trim(session.Transaction.PosMixMatch.mixmatchtriggertype));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchtriggervalue"))PosMixMatch.setmixmatchtriggervalue(trim(session.Transaction.PosMixMatch.mixmatchtriggervalue));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchgiveawaytype"))PosMixMatch.setmixmatchgiveawaytype(trim(session.Transaction.PosMixMatch.mixmatchgiveawaytype));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchgiveawayvalue"))PosMixMatch.setmixmatchgiveawayvalue(trim(session.Transaction.PosMixMatch.mixmatchgiveawayvalue));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchresettrigger"))PosMixMatch.setmixmatchresettrigger(trim(session.Transaction.PosMixMatch.mixmatchresettrigger));
     if (StructKeyExists(session.Transaction.PosMixMatch, "productquantity"))PosMixMatch.setproductquantity(trim(session.Transaction.PosMixMatch.productquantity));
     if (StructKeyExists(session.Transaction.PosMixMatch, "productvalue"))PosMixMatch.setproductvalue(trim(session.Transaction.PosMixMatch.productvalue));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchtotal"))PosMixMatch.setmixmatchtotal(trim(session.Transaction.PosMixMatch.mixmatchtotal));
     if (StructKeyExists(session.Transaction.PosMixMatch, "mixmatchquantity"))PosMixMatch.setmixmatchquantity(trim(session.Transaction.PosMixMatch.mixmatchquantity));     
   </cfscript>
   
   <cfset PosMixMatch.validate(session.errorhandler) />   
	<cfif NOT(session.errorhandler.haserrors())>
    	 <cftry>	
        	<!---[   Set an error flag to be used at the end to signify if 
									the process has successfully completed.   ]---->
			<cfset PosMixMatchNoError = true />
            <cfset PosMixMatchDAO.save(PosMixMatch) />
            <cfcatch type="any">
               <cfset PosMixMatchNoError = false />
            </cfcatch>
               
	  </cftry>  
    	    <!---[   IF we have successfully got to this point, set the relevant flag    ]---->
            <cfif PosMixMatchNoError >
				<cfset PosDAO.setPosMixMatchFlag(session.PosTXID) />
            </cfif>
   </cfif>  
</cfsilent>
