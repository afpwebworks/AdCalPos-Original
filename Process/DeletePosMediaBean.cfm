<cfsilent>
<!----
==========================================================================================================
Filename:    DeletePosMediaBean.cfm
Description: Deletes a PosMediaBean from the database and returns the user to the originating page. Works with ColdSpring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfif NOT(isdefined("url.SequenceID")) AND NOT(isdefined("form.submitpage"))>
	<cflocation addtoken="no" url="index.cfm" />
</cfif>
<cfset PosMediaBean =  application.beanfactory.getBean("PosMediaBean") />
<cfset PosMediaBean.setSequenceID(SequenceID) />
<cfset PosMediaDAO = application.beanfactory.getBean("PosMediaDAO") />
<cfset PosMediaDAO.delete(PosMediaBean) />
<cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfsilent>