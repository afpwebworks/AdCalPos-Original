<cfcomponent displayname="Users DAO" output="false" hint="DAO Component Handles all Database access for the table Users.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    UsersDAO.cfc
Description: DAO Component Handles all Database access for the table Users.  Requires Coldspring v1.0
Date:        16/Sep/2008
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="UsersDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="any" />
	<cfset var config  = arguments.argsConfiguration />
	<cfset variables.config = arguments.argsConfiguration />
	<cfset variables.dsn = config.getDSN() />
	<cfset variables.austime = config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


	<cffunction name="GetSiteContacts" access="public" returntype="query" output="false" hint="Returns a query of teh site's contacts, and email addresses for use throughout the site's contact us forms "> 
		<cfset var sitecontacts = 0 />
		<cfquery name="Sitecontacts" datasource="#variables.dsn#">
			Select s.*, u.Userfirstname + ' ' + u.Userlastname as UserName, u.UserEmail
			FROM SiteContacts s, Users u 
			Where u.IsVisible = '1' AND 
            s.Isvisible = '1' AND
			s.UserID = U.UserId
			ORDER by s.Sortcode, S.UserID		
		</cfquery>
		<cfreturn Sitecontacts />
	</cffunction>


<cffunction name="save" access="public" returntype="User" output="false" hint="DAO method">
<cfargument name="User" type="User" required="yes" />
<!-----[  If a UserID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.User.getUserID() neq "0")>	
		<cfset User = update(arguments.User)/>
	<cfelse>
		<cfset User = create(arguments.User)/>
	</cfif>
	<cfreturn User />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="User" type="User" required="true" /> 
	<cfset var qUserDelete = 0 >
<!-----[  to delete, set 'IsVisible' flag to zero  ]--->
		<cfquery name="qUserDelete" datasource="#variables.dsn#" >
		UPDATE Users
		Set IsVisible = '0'
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>


<cffunction name="UnDelete" returntype="void" output="false" hint="DAO method" >
<cfargument name="User" type="User" required="true" /> 
	<cfset var qUserUnDelete = 0 >
<!-----[  to UnDelete, set 'IsVisible' flag to 1 (true)  ]--->
		<cfquery name="qUserDelete" datasource="#variables.dsn#" >
		UPDATE Users
		Set IsVisible = '1'
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>	
</cffunction>



<cffunction name="read" access="public" returntype="User" output="false" hint="DAO Method. - Reads a User into the bean">
<cfargument name="argsUser" type="User" required="true" />
	<cfset var User  =  arguments.argsUser />
	<cfset var QUsersselect = "" />
	<cfquery name="QUsersselect" datasource="#variables.dsn#">
		SELECT 
		addedby, address1, address2, city, country, dateadded, dateupdated, isvisible, phone, postcode, state, title, updatedby, useraccesslevel, useractive, useremail, userfirstname, userid, userip, userlastlogin, userlastname, userlogin, userpassword, usertotallogins
		FROM Users 
		WHERE 
		IsVisible = '1' AND
		UserID = <cfqueryparam value="#User.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<cfif QUsersselect.recordCount >
		<cfscript>
		
                     User.setaddedby(QUsersselect.addedby);
                     User.setaddress1(QUsersselect.address1);
                     User.setaddress2(QUsersselect.address2);
                     User.setcity(QUsersselect.city);
                     User.setcountry(QUsersselect.country);
                     User.setdateadded(QUsersselect.dateadded);
                     User.setdateupdated(QUsersselect.dateupdated);
                     User.setisvisible(QUsersselect.isvisible);
                     User.setphone(QUsersselect.phone);
                     User.setpostcode(QUsersselect.postcode);
                     User.setstate(QUsersselect.state);
                     User.settitle(QUsersselect.title);
                     User.setupdatedby(QUsersselect.updatedby);
                     User.setuseraccesslevel(QUsersselect.useraccesslevel);
                     User.setuseractive(QUsersselect.useractive);
                     User.setuseremail(QUsersselect.useremail);
                     User.setuserfirstname(QUsersselect.userfirstname);
                     User.setuserid(QUsersselect.userid);
                     User.setuserip(QUsersselect.userip);
                     User.setuserlastlogin(QUsersselect.userlastlogin);
                     User.setuserlastname(QUsersselect.userlastname);
                     User.setuserlogin(QUsersselect.userlogin);
                     User.setuserpassword(QUsersselect.userpassword);
                     User.setusertotallogins(QUsersselect.usertotallogins);
		</cfscript>
        <cfset ReadPermissions(user) />
        <cfset ReadUserGroups(user) />  
        
	</cfif>
	<cfreturn User />
</cffunction>
		

<cffunction name="GetAllUsers" access="public" output="false" returntype="query" hint="Returns a query of all Users in our Database">
<cfset var QgetallUsers = 0 />
	<cfquery name="QgetallUsers" datasource="#variables.dsn#">
		SELECT addedby, address1, address2, city, country, dateadded, dateupdated, isvisible, phone, postcode, state, title, updatedby, useraccesslevel, useractive, useremail, userfirstname, userid, userip, userlastlogin, userlastname, userlogin, userpassword, usertotallogins,
		Userfirstname + ' ' + Userlastname as UserName
		FROM Users		
		WHERE IsVisible = '1'
		
		ORDER BY userlastname, userfirstname, UserID
	</cfquery>
	<cfreturn QgetallUsers />
</cffunction>


	<cffunction name="getAccessLevels" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
    <cfargument name="argsMinLevel" required="no" type="numeric" default="99999" />
		<cfset var accesslevels = 0 />
        <cfset var MinLevel = arguments.argsMinLevel />
        
        
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
            <cfif MinLevel neq "99999" >
            WHERE
			UserAccessLevel >= <cfqueryparam value="#MinLevel#" cfsqltype="cf_sql_numeric" />
            </cfif>
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>
	
<!---[   	<cffunction name="getAccessLevelsEdit" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
			WHERE
			UserAccessLevel >= '#variables.MinEditLevel#'
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>   ]---->
	
<!---[   	<cffunction name="getAccessLevelsApprove" access="public" returntype="query" output="false" hint="Returns a query containing the available User Access levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserAccessLevel, UserAccessLevelDesc
			From UserAccesslevels
			WHERE
			UserAccessLevel >= '#variables.MinApproveLevel#'
			ORDER BY UserAccessLevel
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>   ]---->
	
	<cffunction name="getAllUserGroups" access="public" returntype="query" output="false" hint="Returns a query containing the available User Special Interest Groups levels in the User Manager">
		<cfset var accesslevels = 0 />
		<cfquery name="accesslevels" datasource="#variables.dsn#">
			SELECT UserGroupID, UserGroupName
			From UserGroups
			ORDER BY UserGroupName
		</cfquery>
		<cfreturn accesslevels />
	</cffunction>

<cffunction name="getApprovedUsers" access="public" returntype="query" output="false" hint="Returns a query containing the users details of people who ">
	<cfset var USerList = 0 />
	<cfquery name="UserList" datasource="#variables.dsn#">
	    SELECT UserFirstName + ' ' + UserLastName as Username
		,* 
		from Users 
		WHERE Useraccesslevel > '20'	
	</cfquery>
	<cfreturn USerList />
</cffunction>




<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" displayname="create" />
	<cfset var qUserInsert = 0 />
	<cfset var User = arguments.argsUser />
	
	<cfquery name="qUserInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into Users
		( addedby, address1, address2, city, country, dateadded, dateupdated, isvisible, phone, postcode, state, title, updatedby, useraccesslevel, useractive, useremail, userfirstname, userip, userlastlogin, userlastname, userlogin, userpassword, usertotallogins ) VALUES
		(
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getaddress1()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getaddress2()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getcity()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getcountry()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#variables.config.getAustime()#" cfsqltype="cf_sql_timestamp" />,
		<cfqueryparam value="#User.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getphone()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getpostcode()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getstate()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.gettitle()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuseraccesslevel()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuseractive()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuseremail()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserfirstname()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserip()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserlastlogin()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserlastname()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserlogin()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getuserpassword()#" cfsqltype="cf_sql_varchar"/>,
		<cfqueryparam value="#User.getusertotallogins()#" cfsqltype="cf_sql_varchar"/>
		   ) 
		SELECT Ident_Current('Users') as UserID
		SET NOCOUNT OFF
	</cfquery>
	<cfset User.setUserID(qUserInsert.UserID)>
	
		
<!----[  	update the permissions set  ]---->
	<cfset UpdatePermissions( user ) />
	<cfset UpdateUserGroups ( user ) />
			
			

	<cfreturn User />
</cffunction>

<cffunction name="update" access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" />
	<cfset var User = arguments.argsUser />
	<cfset var UserUpdate = 0 >
	<cfquery name="UserUpdate" datasource="#variables.dsn#" >
		UPDATE Users SET
		
		 
		 address1  = <cfqueryparam value="#User.getaddress1()#" cfsqltype="cf_sql_varchar"/>,
		 address2  = <cfqueryparam value="#User.getaddress2()#" cfsqltype="cf_sql_varchar"/>,
		 city  = <cfqueryparam value="#User.getcity()#" cfsqltype="cf_sql_varchar"/>,
		 country  = <cfqueryparam value="#User.getcountry()#" cfsqltype="cf_sql_varchar"/>,
		 dateupdated  = <cfqueryparam value="#variables.config.getAusTime()#" cfsqltype="cf_sql_timestamp" />,
		 isvisible  = <cfqueryparam value="#User.getisvisible()#" cfsqltype="cf_sql_varchar"/>,
		 phone  = <cfqueryparam value="#User.getphone()#" cfsqltype="cf_sql_varchar"/>,
		 postcode  = <cfqueryparam value="#User.getpostcode()#" cfsqltype="cf_sql_varchar"/>,
		 state  = <cfqueryparam value="#User.getstate()#" cfsqltype="cf_sql_varchar"/>,
		 title  = <cfqueryparam value="#User.gettitle()#" cfsqltype="cf_sql_varchar"/>,
		 updatedby  = <cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>,
		 useraccesslevel  = <cfqueryparam value="#User.getuseraccesslevel()#" cfsqltype="cf_sql_varchar"/>,
		 useractive  = <cfqueryparam value="#User.getuseractive()#" cfsqltype="cf_sql_varchar"/>,
		 useremail  = <cfqueryparam value="#User.getuseremail()#" cfsqltype="cf_sql_varchar"/>,
		 userfirstname  = <cfqueryparam value="#User.getuserfirstname()#" cfsqltype="cf_sql_varchar"/>,
		 userip  = <cfqueryparam value="#User.getuserip()#" cfsqltype="cf_sql_varchar"/>,
		 userlastlogin  = <cfqueryparam value="#User.getuserlastlogin()#" cfsqltype="cf_sql_varchar"/>,
		 userlastname  = <cfqueryparam value="#User.getuserlastname()#" cfsqltype="cf_sql_varchar"/>,
		 userlogin  = <cfqueryparam value="#User.getuserlogin()#" cfsqltype="cf_sql_varchar"/>,
		 userpassword  = <cfqueryparam value="#User.getuserpassword()#" cfsqltype="cf_sql_varchar"/>,
		 usertotallogins  = <cfqueryparam value="#User.getusertotallogins()#" cfsqltype="cf_sql_varchar"/>
						
		WHERE 
		UserID = <cfqueryparam value="#User.getUserID()#" />
	</cfquery>
		
<!----[  update the permissions set  ]---->
	<cfset UpdatePermissions( user ) />
	<cfset UpdateUserGroups ( user ) />
	
	<cfreturn User />
</cffunction>

<cffunction name="ReadPermissions" access="private" returntype="user" output="false" hint="Gets and sets the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />
<!----[  Get permissions  ]---->
	<cfquery name="qGetPermissions" datasource="#variables.dsn#">
		SELECT PermissionID from  userspermissions   		
		WHERE
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
		ORDER BY  permissionID
	</cfquery>
	<cfset user.setPermissions(valuelist(qGetPermissions.PermissionID, ",")) />

<cfreturn user />

</cffunction>

<cffunction name="UpdatePermissions" access="private" returntype="user" output="false" hint="persists the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />

<!----[  Remove the existing permissions from the permissions mapping table  ]---->
	<cfquery name="RemovePermissions" datasource="#variables.dsn#">
		DELETE from userspermissions 
		WHERE 
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<!----[  Set the permissions into the permissions mapping table  ]---->
	<cfloop list="#user.getPermissions()#" index="i">
		<cfquery name="InsertPermission" datasource="#variables.dsn#">
			INSERT into userspermissions (PermissionID, UserID) values (
			<cfqueryparam value="#i#" />,
			<cfqueryparam value="#user.getUserID()#" />
			)
		</cfquery>
	</cfloop>
<cfreturn user />
</cffunction>


<cffunction name="ReadUserGroups" access="private" returntype="user" output="false" hint="Gets and sets the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />
<!----[  Get permissions  ]---->
	<cfquery name="qGetGroups" datasource="#variables.dsn#">
		SELECT UserGroupID from  usersgroups  		
		WHERE
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
		ORDER BY  UserGroupID
	</cfquery>
	<cfset user.setUserGroups(valuelist(qGetGroups.UserGroupID, ",")) />
<cfreturn user />

</cffunction>


<cffunction name="UpdateUserGroups" access="private" returntype="user" output="false" hint="persists the permission set for a user">
<cfargument name="argsuser" required="yes" type="user" />
<cfset var user = arguments.argsuser />

<!----[  Remove the existing permissions from the permissions mapping table  ]---->
	<cfquery name="RemovePermissions" datasource="#variables.dsn#">
		DELETE from UsersGroups 
		WHERE 
		UserID = <cfqueryparam value="#user.getUserID()#" cfsqltype="cf_sql_varchar"/>
	</cfquery>
	<!----[  Set the permissions into the permissions mapping table  ]---->
	<cfloop list="#user.getUserGroups()#" index="i">
		<cfquery name="InsertGroup" datasource="#variables.dsn#">
			INSERT into UsersGroups (UserGroupID, UserID,dateUpdated,dateadded,UpdatedBy) values (
			<cfqueryparam value="#i#" />,
			<cfqueryparam value="#user.getUserID()#" />,
			<cfqueryparam value="#createodbcdatetime(variables.austime)#" cfsqltype="cf_sql_timestamp" />,
            <cfqueryparam value="#createodbcdatetime(variables.austime)#" cfsqltype="cf_sql_timestamp" />,
			<cfqueryparam value="#variables.userService.getUser().getUserId()#" cfsqltype="cf_sql_varchar"/>			
			)
		</cfquery>
	</cfloop>
<cfreturn user />
</cffunction>



</cfcomponent>