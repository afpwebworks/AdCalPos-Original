<cfsilent>
<!----
==========================================================================================================
Filename:       logout.cfm
Description:    Logout page 
Date:          22/9/2010
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<cfscript>
	session.user = application.beanfactory.getbean("UserAccess").LogoutUser(session.user);
	 // For backwards compatibility set other session variables.   This section can be removed after all files updated  
     session.logged ="NO";
	 session.employeeID = "";
	 session.empfullname = "";
	 session.usertype = "";
	 session.storeid = "";
	 session.startdate = dateformat( application.beanfactory.getbean("configbean").getaustime(), "yyyymmdd");
	 session.enddate =  dateformat( application.beanfactory.getbean("configbean").getaustime(), "yyyymmdd");
	 session.storename = "";
     session.loginerrormessage = "" ;
</cfscript>
<cflocation url="/index.cfm" addtoken="no">
<cfabort>
</cfsilent>