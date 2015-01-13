<cfsilent>
<!----
==========================================================================================================
Filename:     SavePosMixMatchProduct.cfm
Description:  Processes the XML elements relating to the PosMixMatchProduct table to the database
Date:         5/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfif NOT structKeyExists(session, "errorhandler")>
	<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
</cfif>

<cfset PosMixMatchProductDAO = application.beanfactory.getbean("PosMixMatchProductDAO") />
<cfset PosDAO = application.beanfactory.getbean("PosDAO") />

 <!---[      Create the struct containing the values   ]---->
       <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
			session.Transaction.PosMixMatchProduct.PosTXID = session.PosTXID;
			fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
			value=mydoc.tables.table[t].fields.field[i].xmltext;
			session.Transaction.PosMixMatchProduct[fieldname]=value;		
        </cfscript>  
      </cfloop> 
<cfscript>
     //transfer session struct values to the bean
	 if (StructKeyExists(session.Transaction.PosMixMatchProduct, "postxid")) PosMixMatchProduct.setpostxid(trim(session.Transaction.PosMixMatchProduct.postxid));
	 if (StructKeyExists(session.Transaction.PosMixMatchProduct, "MixMatchid")) PosMixMatchProduct.setMixMatchid(trim(session.Transaction.PosMixMatchProduct.MixMatchid));
     if (StructKeyExists(session.Transaction.PosMixMatchProduct, "productid")) PosMixMatchProduct.setproductid(trim(session.Transaction.PosMixMatchProduct.productid));
     if (StructKeyExists(session.Transaction.PosMixMatchProduct, "productcode")) PosMixMatchProduct.setproductcode(trim(session.Transaction.PosMixMatchProduct.productcode));
     if (StructKeyExists(session.Transaction.PosMixMatchProduct, "description")) PosMixMatchProduct.setdescription(trim(session.Transaction.PosMixMatchProduct.description));
     if (StructKeyExists(session.Transaction.PosMixMatchProduct, "productquantity")) PosMixMatchProduct.setproductquantity(trim(session.Transaction.PosMixMatchProduct.productquantity));
     if (StructKeyExists(session.Transaction.PosMixMatchProduct, "productvalue")) PosMixMatchProduct.setproductvalue(trim(session.Transaction.PosMixMatchProduct.productvalue));
</cfscript>	 

   
   <cfset PosMixMatchProduct.validate(session.errorhandler) />   
	<cfif NOT(session.errorhandler.haserrors())>
        <cftry>	
        	<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
			<cfset PosMixMatchProductNoError = true />
             <cfset PosMixMatchProductDAO.save(PosMixMatchProduct) />
             <cfcatch type="any">
                <cfset PosMixMatchProductNoError = false />
              </cfcatch>
            
        </cftry>  
	        <!---[   IF we have successfully got to this point, set the relevant flag    ]---->
            <cfif PosMixMatchProductNoError is true >
                <cfset PosDAO.setPosMixMatchProductFlag(session.PosTXID) />
            </cfif> 
	</cfif>  

</cfsilent>
