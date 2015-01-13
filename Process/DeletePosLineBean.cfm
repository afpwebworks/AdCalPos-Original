<cfsilent>
<!----
==========================================================================================================
Filename:    DeletePosLineBean.cfm
Description: Deletes a PosLineBean from the database and returns the user to the originating page. Works with ColdSpring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->


<cfif NOT(isdefined("url.PosLineID")) AND NOT(isdefined("form.submitpage"))>
	<cflocation addtoken="no" url="../cfcs/PosCore/index.cfm" />
</cfif>
<cfset PosLineBean =  application.beanfactory.getBean("PosLineBean") />
<cfset PosLineBean.setPosLineID(PosLineID) />
<cfset PosLinesDAO = application.beanfactory.getBean("PosLinesDAO") />
<cfset PosLinesDAO.delete(PosLineBean) />
<cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
</cfsilent>