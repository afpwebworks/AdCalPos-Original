<cfcomponent output="no" displayname="User Access" hint="Functions to manage logins and user access for ADcalpos Enterprise.">
<cfsilent>
<!---
=================================================================================================================
File:           UserAccess.cfc   
Description:    Functions to manage logins and user access for AdCalPos
Author:	        Michael Kear
Date:           27/8/2010
Modification:   

=================================================================================================================
--->
</cfsilent>

   <cffunction name="init" access="public" returntype="UserAccess" output="false" hint="This is called by the framework and automatically maps variables in the current event to the instance variables of this bean.">
    <cfargument name="argsConfiguration" required="true" type="any" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
    <cfset variables.mailserver = variables.config.getmailserver() />
	<cfset variables.mailuser = variables.config.getmailuser() />
	<cfset variables.mailpassword = variables.config.getmailpassword() />
	<cfset variables.webmasteremail = variables.config.getwebmasteremail() />
	<cfset variables.sitename = variables.config.getsitename() />
	<cfset variables.sitemailindex = variables.config.getsitemailindex() />	
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="GetUser" access="public" returntype="string" output="false" hint="Returns the basic infor for CFLOGIN tag.">
		<cfargument name="UserLogin" type="string" required="true">
		<cfargument name="UserPassword" type="string" required="true">
		<cfset var qGetUser = 0 />
		<cfquery name="qGetUser" datasource="#variables.dsn#">
		SELECT UserID,UserFirstName, UserLastName,UserPassword
		From Users
		WHere  (UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "30">
			OR
			UserEmail = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "30">
			)			
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "30">
			AND
			UserActive = '1'
		</cfquery>
			<cfif qGetUser.recordcount eq '1'>
			<cfset myResult = "loggedin">
		<cfelse>		
			<cfset myResult = "NOTloggedin">
		</cfif>
			<cfreturn myResult>
</cffunction>

	

	<cffunction name="loginuser" access="public" returntype="any" hint="checks a user's status and logs him in">
		<cfargument name="argsUserLogin" type="string" required="true">
		<cfargument name="argsUserPassword" type="string" required="true">
		<cfargument name="argsuser" type="any" required="yes" /> 
 		<cfset var qLoginUser = 0 />
		<cfset var vUser = arguments.argsUser />
		<cfset var login = arguments.argsUserLogin />
		<cfset var password = arguments.argsUserPassword />
		<cfquery name="qLoginUser" datasource="#variables.DSN#">
    		SELECT e.EmployeeID, e.UserName, e.Password
			FROM tblEmployee E
 			WHERE
			Username = <cfqueryparam value = "#Login#" cfsqltype = "cf_sql_char" maxLength = "30">
			AND
			Password = <cfqueryparam value = "#Password#" cfsqltype = "cf_sql_char" maxLength = "30">
            AND
            NoLongerUsed = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
		</cfquery>
		<cfif qLoginUser.recordcount>
			<cfscript>
			vUser.setEmployeeID(qLoginUser.EmployeeID);
			UserDAO = application.beanfactory.getbean("UsersDAO").read(vUser);
			vUser.setIsloggedIn(true);
			</cfscript>	
			<cfreturn vUser>
		<!----[  OTherwise it's not a valid user, so just hand back the empty userbean ]---->	
		<cfelse>
		<cfreturn vUser />
		</cfif>
	
	</cffunction>
	
	
<cffunction name="setdefaultlogins" access="public" output="false" hint="sets the default login details and creates the session.auth. struct anew">
		<cfscript>
			session.user = application.beanfactory.getbean("user");
		</cfscript>
	</cffunction>

	
	<cffunction name="checkuserexists"  access="public" output="true" returntype="boolean" hint="Checks to see if a user exists given the UserLogin and UserPassword">
		<cfargument name="UserLogin" type="string" required="true">
		<cfargument name="UserPassword" type="string" required="true">
		<cfquery name="finduser" datasource="#variables.DSN#">
			SELECT Userid from USERS WHERE
			UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "30">
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "30">	
		</cfquery>
		<cfif finduser.recordcount eq "0">
			<cfset userexists = false>
		<cfelse>	
			<cfset userexists = true>		
		</cfif>
		<cfreturn userexists>
	</cffunction>
		
	
	<cffunction name="checkInuse" access="public" output="true" returntype="string" hint="Checks to see if this user/password combination already exists for another user.">
	<cfargument name="UserLogin" type="string" required="true">
	<cfargument name="UserPassword" type="string" required="true">
	<cfset var UserID = 0 />

		<cfquery name="finduser" datasource="#variables.DSN#">
			SELECT Userid from USERS WHERE
			UserLogin = <cfqueryparam value = "#arguments.UserLogin#" cfsqltype = "cf_sql_char" maxLength = "30">
			AND
			UserPassword = <cfqueryparam value = "#arguments.UserPassword#" cfsqltype = "cf_sql_char" maxLength = "30">	
		</cfquery>
		<cfif finduser.recordcount GT "0">
			<cfset Userid = finduser.UserID >
		</cfif>
		<cfreturn Userid>
	</cffunction>
	
	

<cffunction name="LogoutUser" access="public" output="false" returntype="user" hint="Logs the user out and resets all session vars to the defaults">
<cfargument name="argsUser" required="yes" type="user"  />
<cfset var user = arguments.argsUser />

	<!----Kill the cookies and CFID/CFTOKEN ---->
	  <cfcookie name="CFID"  expires="NOW">
	  <cfcookie name="CFTOKEN" expires="NOW">

		<!---- Delete the session vars and return a new, default user object that is not logged in. ---->
	    <cfscript>
			Newuser = application.beanfactory.getbean("user");
		</cfscript>
		<cfreturn Newuser />
</cffunction>
	
	


<cffunction name="SendPassword" access="public" output="true" returntype="void" hint="Emails the users password to them, based on the email address input">
<cfargument name="Useremail" required="yes" default="">
<cfset var thepasswordreturn = getpassword(Useremail=trim(arguments.useremail))>
<cfset var thepassword  = Listlast(thepasswordreturn) />
<cfset var theUserLogin = Listfirst(thepasswordreturn) />
<cfmail to="#arguments.useremail#" from="#variables.webmasteremail#" subject="#variables.sitemailindex# Your lost password" server="#variables.mailserver#" username="#variables.mailuser#" password="#variables.mailpassword#">
Someone, presumably you, came to the #variables.sitename# web site and asked us to send you the password to your account. 
		  
Your userid is: #theUserLogin#
Your password is: #thepassword#
		  
Yours faithfully,
Webmaster,
#variables.sitename#		 	 
</cfmail>  
</cffunction>
	
	<cffunction name="getpassword" access="public" output="true" returntype="string" hint="Retrieves password for a given email address to be sent to the user.  Requires either UserEmail, UserLogin or User's first name and last name">
	<cfargument name="Useremail" required="no" default="">
	<cfargument name="UserLogin" required="no" default="">
	<cfargument name="UserFirstName" required="no" default="">
	<cfargument name="UserLastName" required="no" default="">
	<cfset var thepassword = "" />
	<cfset var 	retrievepassword = 0 />	
	<cfquery name="retrievepassword" datasource="#variables.DSN#">
	SELECT UserPassword,Userlogin from USERS where 	0=1
	<cfif len(arguments.UserEmail) GT 1 >
	OR
	(Useremail = '#trim(arguments.Useremail)#')
	</cfif>
	<cfif len(arguments.UserLogin) GT 1>
	OR
	(UserLogin = '#trim(arguments.UserLogin)#')
	</cfif>
	<cfif len(arguments.UserFirstName) GT 1>	
	OR
	( (UserFirstName='#trim(arguments.UserFirstName)#') AND (UserLastName='#trim(arguments.UserLastName)#') )
	</cfif>
	</cfquery>
	<cfif retrievepassword.recordcount eq '1'>
		<cfset thepassword = "#retrievepassword.Userlogin#,#retrievepassword.Userpassword#">
	<cfelse>	
		<cfset thepassword = "Notknown,NotKnown">
	</cfif>
		<cfreturn thepassword>
	</cffunction>	
 

 
</cfcomponent>