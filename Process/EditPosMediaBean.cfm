<cfsilent>
<!----
==========================================================================================================
Filename:    EditPosMediaBean.cfm
Description: Page for handling the edit and add of data for PosMediaBean data.  Requires Coldspring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
 <cfset PosMediaBean = application.beanfactory.getBean("PosMediaBean") />
 <cfset PosMediaDAO =   application.beanfactory.getBean("PosMediaDAO") />

<cfif isdefined("url.SequenceID")>
   <cfset PosMediaBean.setSequenceID(SequenceID) />
   <cfset PosMediaDAO.read(PosMediaBean) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
    PosMediaBean.setpostxid(trim(form.postxid));
     PosMediaBean.setmediaid(trim(form.mediaid));
     PosMediaBean.setdescription(trim(form.description));
     PosMediaBean.setallowchange(trim(form.allowchange));
     PosMediaBean.setroundtotal(trim(form.roundtotal));
     PosMediaBean.settaxexempt(trim(form.taxexempt));
     PosMediaBean.setreferencetype(trim(form.referencetype));
     PosMediaBean.setreferenceid(trim(form.referenceid));
     PosMediaBean.setmediaunit(trim(form.mediaunit));
     PosMediaBean.setmediaround(trim(form.mediaround));
     PosMediaBean.setmediachange(trim(form.mediachange));
     PosMediaBean.setmediaext(trim(form.mediaext));
     PosMediaBean.setmediatax(trim(form.mediatax));
     
     
   </cfscript>
   <cfset PosMediaBean.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset PosMediaDAO.save(PosMediaBean) />
		<cflocation addtoken="no"  url="/SalesOrderReport.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/Content/header.cfm" />
<cfinclude template="/Includes/form_PosMediaBean.cfm" />
<cfinclude template="/Includes/Content/footer.cfm" />