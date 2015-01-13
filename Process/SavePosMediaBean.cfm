<cfsilent>
<!----
==========================================================================================================
Filename:     SavePosMediaBean.cfm
Description:  Saves the values of a struct called "session.Transaction.Media" to the PosMediaBean,  then persists the values 
Date:         6/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfif NOT structKeyExists(session, "errorhandler")>
	<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
</cfif>
<cfset PosMediaDAO = application.beanfactory.getbean("PosMediaDAO") />
    
 <!---[      Create the struct containing the values   ]---->
       <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
			session.Transaction.Media.PosTXID = session.PosTXID;
			fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
			value=mydoc.tables.table[t].fields.field[i].xmltext;
			session.Transaction.Media[fieldname]=value;		
        </cfscript>  
      </cfloop>    
       <cfscript>
		 //transfer Session.Line values to the bean
		 if (StructKeyExists(session.Transaction.Media, "mediaid")) PosMediaBean.setmediaid(trim(session.Transaction.Media.mediaid));
		 if (StructKeyExists(session.Transaction.Media, "description")) PosMediaBean.setdescription(trim(session.Transaction.Media.description));
		 if (StructKeyExists(session.Transaction.Media, "allowchange")) PosMediaBean.setallowchange(trim(session.Transaction.Media.allowchange));
		 if (StructKeyExists(session.Transaction.Media, "roundtotal")) PosMediaBean.setroundtotal(trim(session.Transaction.Media.roundtotal));
		 if (StructKeyExists(session.Transaction.Media, "taxexempt")) PosMediaBean.settaxexempt(trim(session.Transaction.Media.taxexempt));
		 if (StructKeyExists(session.Transaction.Media, "referencetype")) PosMediaBean.setreferencetype(trim(session.Transaction.Media.referencetype));
		 if (StructKeyExists(session.Transaction.Media, "referenceid")) PosMediaBean.setreferenceid(trim(session.Transaction.Media.referenceid));
		 if (StructKeyExists(session.Transaction.Media, "mediaunit")) PosMediaBean.setmediaunit(trim(session.Transaction.Media.mediaunit));
		 if (StructKeyExists(session.Transaction.Media, "mediaround")) PosMediaBean.setmediaround(trim(session.Transaction.Media.mediaround));
		 if (StructKeyExists(session.Transaction.Media, "mediachange")) PosMediaBean.setmediachange(trim(session.Transaction.Media.mediachange));
		 if (StructKeyExists(session.Transaction.Media, "mediaext")) PosMediaBean.setmediaext(trim(session.Transaction.Media.mediaext));
		 if (StructKeyExists(session.Transaction.Media, "mediatax")) PosMediaBean.setmediatax(trim(session.Transaction.Media.mediatax));
		</cfscript>
       
   
    <cfset PosMediaBean.validate(session.errorhandler) />   
	<cfif NOT(session.errorhandler.haserrors())>
		<cfset PosMediaDAO.save(PosMediaBean) />
	</cfif>  
    
</cfsilent> 
    
  