<cfsilent>
<!----
==========================================================================================================
Filename:    DeletePosBean.cfm
Description: Deletes a PosBean from the database and returns the user to the originating page. Works with ColdSpring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfif NOT(isdefined("url.PosTXID")) AND NOT(isdefined("form.submitpage"))>
	<cflocation addtoken="no" url="index.cfm" />
</cfif>
<cfset PosBean =  application.beanfactory.getBean("PosBean") />
<cfset PosBean.setPosTXID(PosTXID) />
<cfset PosDAO = application.beanfactory.getBean("PosDAO") />
<cfset PosDAO.delete(PosBean) />
<cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfsilent>