<cfsilent>
<!---
=============================================================================================================================
File:         forcelogin.cfm
Description:  Requires the user to be logged in before granting access.  Normally included by Application.cfm
Author:	      Michael Kear
Date:        27/1/2006
Revision history: 
=============================================================================================================================
--->
<cfif not(isdefined("UserAccess"))>
	<cfset UserAccess = application.beanfactory.getbean("UserAccess") />	
</cfif>
</cfsilent>
<cfif NOT(session.user.getIsLoggedIn())>

<!--- If the user has submitted login form process it --->
<cfif (IsDefined("FORM.UserLogin") AND IsDefined("FORM.UserPassword"))>
		<cfset session.loginerrormessage = "">

	<cfscript>
		//Remove any spaces in the form values 
		rUserLogin = #Replace(form.UserLogin, " ", "")#;
		rUserPassword = #Replace(form.UserPassword, " ", "")#;
		session.user = UserAccess.loginuser( rUserLogin, rUserPassword, session.user );
	</cfscript>
		<cfif session.user.getIsloggedin()>
       <!---[        For backwards compatibility set other session variables.   This section can be removed after all files updated   ]---->
        <cfset session.logged ="YES">
		<cfset session.employeeID = session.user.getEmployeeID()>
		<cfset session.empfullname = session.user.Getempfullname()>
		<cfset session.usertype = session.user.getUserTypeID()>
		<cfset session.storeid = session.User.getStoreID()>
		<cfset session.storename = session.user.getStoreName()>		

            
			<cflocation url="/cf/mainmenu.cfm" addtoken="no" />
			<!--- Othewise re-prompt for a valid username and password --->	
		<cfelse>
			<cflock scope="session" type="exclusive" timeout="10">
				<cfset session.loginerrormessage = "<li>Sorry that username and password are not recognised.  Please try again.</li>">
			</cflock>
		</cfif>

</cfif>
	<cfinclude template="/includes/form_login.cfm">
	<cfabort>
</cfif>