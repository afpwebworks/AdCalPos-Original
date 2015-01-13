<cfcomponent displayname="tblEmployee DAO" output="false" hint="DAO Component Handles all Database access for the table tblEmployee.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    UsersDAO.cfc
Description: DAO Component Handles all Database access for the table tblEmployee.  Requires Coldspring v1.0
Date:        28/Sep/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( User.getemployeeid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="UsersDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="save" access="public" returntype="User" output="false" hint="DAO method">
<cfargument name="User" type="User" required="yes" />
<!-----[  If a employeeid exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.User.getemployeeid() neq "0")>	
		<cfset User = update(arguments.User)/>
	<cfelse>
		<cfset User = create(arguments.User)/>
	</cfif>
	<cfreturn User />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="User" type="User" required="true" /> 
	<cfset var qUserDelete = 0 >
<cfquery name="UserDelete" datasource="#variables.dsn#" >
		DELETE FROM tblEmployee
		WHERE 
		employeeid = <cfqueryparam value="#User.getemployeeid()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	
</cffunction>


<cffunction name="getAllUsers" access="public" returntype="query" output="no" hint="Returns a query of all users.  If a state is given,  returns users within that state.  If a group is given,  returns users within the group.">
<cfargument name="argsState" required="no" default="All" />
<cfargument name="argsGroup" required="no" default="All" />
<cfset var qUsers = 0 />
<cfset var State = arguments.argsState />
<cfset var Group = arguments.argsGroup />

<cfquery name="qUsers" datasource="#variables.dsn#">
	SELECT u.*, s.storename, g.storegroup, 
    u.GivenName + ' ' + u.Surname as UserFullName  
    FROM tblemployee u, tblstores s, tblstoregroup g
    WHERE
    u.storeid=s.storeid AND
    s.storegroupid = g.storegroupid
    <cfif state neq "All">
    	And u.state = <cfqueryparam value="#state#" cfsqltype="cf_sql_varchar" />
     </cfif>
     <cfif group neq "All">
     	And s.storegroupid =  <cfqueryparam value="#Group#" cfsqltype="cf_sql_integer" />
     </cfif>
     ORDER BY u.surname, u.employeeid
</cfquery>
	<cfreturn qUsers />
</cffunction>


<cffunction name="read" access="public" returntype="User" output="false" hint="DAO Method. - Reads a User into the bean">
<cfargument name="argsUser" type="User" required="true" />
	<cfset var User  =  arguments.argsUser />
	<cfset var QtblEmployeeselect = "" />
	<cfquery name="QtblEmployeeselect" datasource="#variables.dsn#">
		SELECT 
		e.EmployeeID, e.BundyNo, e.StoreID, e.GivenName, e.Surname, e.Street, e.Address1, e.Address2, e.PostCode, e.State, e.Phone, e.Fax, e.Mobile, e.Email, e.BirthDay, e.EmpStatusID, e.Commenced,  e.NoLongerUsed, e.UserTypeID, e.UserName, e.Password, s.Storename
		FROM tblEmployee e, tblStores s
		WHERE 
        e.StoreID = s.StoreID AND
		employeeid = <cfqueryparam value="#User.getemployeeid()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	<cfif QtblEmployeeselect.recordCount >
		<cfscript>
		 User.setEmployeeID(QtblEmployeeselect.EmployeeID);
         User.setBundyNo(QtblEmployeeselect.BundyNo);
         User.setStoreID(QtblEmployeeselect.StoreID);
         User.setGivenName(QtblEmployeeselect.GivenName);
         User.setSurname(QtblEmployeeselect.Surname);
		 User.setempFullName( QtblEmployeeselect.GivenName & " " & QtblEmployeeselect.Surname);
         User.setStreet(QtblEmployeeselect.Street);
         User.setAddress1(QtblEmployeeselect.Address1);
         User.setAddress2(QtblEmployeeselect.Address2);
         User.setPostCode(QtblEmployeeselect.PostCode);
         User.setState(QtblEmployeeselect.State);
         User.setPhone(QtblEmployeeselect.Phone);
         User.setFax(QtblEmployeeselect.Fax);
         User.setMobile(QtblEmployeeselect.Mobile);
         User.setUserEmail(QtblEmployeeselect.Email);
         User.setBirthDay(QtblEmployeeselect.BirthDay);
         User.setEmpStatusID(QtblEmployeeselect.EmpStatusID);
         User.setCommenced(QtblEmployeeselect.Commenced);
         User.setNoLongerUsed(QtblEmployeeselect.NoLongerUsed);
         User.setUserTypeID(QtblEmployeeselect.UserTypeID);
		 User.setUserType(QtblEmployeeselect.UserTypeID);
         User.setUserName(QtblEmployeeselect.UserName);
         User.setPassword(QtblEmployeeselect.Password);
		 User.setStoreName( QtblEmployeeselect.Storename );
 		 //set a userID as well, to keep consistency with other bean format
		 User.setUserID(QtblEmployeeselect.EmployeeID);
		 //now get the stores this employee is allowed to see in reports.
         getstores(  User   );
        </cfscript>
        
	</cfif>
	<cfreturn User />
</cffunction>



		
<cffunction name="getstores" access="public" output="true" returntype="user" hint="Adds the storeIDs of the called user to the User object. Requires a valid user object">
<cfargument name="argsUser" required="yes" type="user"  />
<cfset var user = arguments.argsUser />
	<cfset var getrights = 0 />
	<cfset var EmployeeID = User.getEmployeeID() />
	<!---[   Set the getSToresToSee() parameter of the user object to a comma delimited list of the stores the user has access to.   ]---->
    <cfset user.setStoresToSee(  getstoresforEmployee(EmployeeID)   ) />
    
	<cfreturn user />
</cffunction> 

<cffunction name="setstores" access="public" output="true" returntype="user" hint="Adds the storeIDs of the called user to the User object. Requires a valid user object">
<cfargument name="argsUser" required="yes" type="user"  />
<cfset var user = arguments.argsUser />
	<cfset var setrights = 0 />
	    
    <!---[   First delete the existing store links for this employee   ]---->
    <cfquery name="qDeleteStores" datasource="#variables.dsn#">
    	DELETE from tblEmployees_stores
        WHERE
        EmployeeID = <cfqueryparam value="#User.getEmployeeID()#" cfsqltype="cf_sql_integer" />
    </cfquery>
    
	   <!---[    Now loop through the stores list and insert into the links table.   ]---->
       <cfloop list="#User.getStoresToSee()#" index="StoreID">
        <cfquery name="qInsert" datasource="#variables.dsn#">
            INSERT into tblEmployees_stores ( EmployeeID, StoreID  ) values ( 
            <cfqueryparam value="#User.getEmployeeID()#" cfsqltype="cf_sql_integer" />,
            <cfqueryparam value="#StoreID#" cfsqltype="cf_sql_integer" />
             )
        </cfquery>
       </cfloop>
	<cfreturn user />
</cffunction> 


<cffunction name="getstoresforEmployee" access="public" output="true" returntype="string" hint="Returns a comma delimited list  of the stores associated with a USERID.">
    <cfargument name="argsEmployeeID" required="yes" />
      <cfset var EmployeeID = arguments.argsEmployeeID />
        <cfset var getrights = 0 />
        
        <cfquery name="getrights" datasource="#variables.DSN#">
          SELECT     StoreID 
          FROM  tblEmployees_stores
          WHERE EmployeeID = <cfqueryparam value="#EmployeeID#" cfsqltype="cf_sql_integer" />
        </cfquery>      
	
	<cfreturn valuelist(getrights.STOREid) />
</cffunction> 


<cffunction name="create"  access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" displayname="create" />
	<cfset var qUserInsert = 0 />
	<cfset var User = arguments.argsUser />
	
	<cfquery name="qUserInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblEmployee
		( BundyNo, StoreID, GivenName, Surname, TaxFileNo, Street, Address1, Address2, PostCode, State, Phone, Fax, Mobile, Email, BirthDay, EmpStatusID, HourlyPayRate, MonthlySalary, Commenced, Finished, entLeaveAvail, entLeaveTaken, entSickAvail, entSickTaken, ytdGross, ytdTax, ytdNetPay, ytdSuper, NoLongerUsed, UserTypeID, UserName, Password, DateEntered, CarAllowancePerWeek, OtherAllowancePerWeek, SickMinsAccumultedBy100, LeaveMinsAccumultedBy100 ) VALUES
		(

		<cfqueryparam value="#User.getbundyno()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getstoreid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getgivenname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getsurname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.gettaxfileno()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getstreet()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getaddress1()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getaddress2()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getpostcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getstate()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getphone()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getfax()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getmobile()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getemail()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getbirthday()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getempstatusid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.gethourlypayrate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getmonthlysalary()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getcommenced()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getfinished()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getentleaveavail()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getentleavetaken()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getentsickavail()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getentsicktaken()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getytdgross()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getytdtax()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getytdnetpay()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getytdsuper()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getnolongerused()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#User.getusertypeid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getusername()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getpassword()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#User.getdateentered()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#User.getcarallowanceperweek()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getotherallowanceperweek()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#User.getsickminsaccumultedby100()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#User.getleaveminsaccumultedby100()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
		SELECT Ident_Current('tblEmployee') as employeeid
		SET NOCOUNT OFF
	</cfquery>
	<cfset User.setemployeeid(qUserInsert.employeeid)>

	<cfreturn User />
</cffunction>

<cffunction name="update" access="private" returntype="User" output="false" hint="DAO method">
<cfargument name="argsUser" type="User" required="yes" />
	<cfset var User = arguments.argsUser />
	<cfset var UserUpdate = 0 >
	<cfquery name="UserUpdate" datasource="#variables.dsn#" >
		UPDATE tblEmployee SET
        bundyno  = <cfqueryparam value="#User.getBundyNo()#" cfsqltype="CF_SQL_INTEGER"/>,
        storeid  = <cfqueryparam value="#User.getStoreID()#" cfsqltype="CF_SQL_INTEGER"/>,
        givenname  = <cfqueryparam value="#User.getGivenName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        surname  = <cfqueryparam value="#User.getSurname()#" cfsqltype="CF_SQL_VARCHAR"/>,
        street  = <cfqueryparam value="#User.getStreet()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address1  = <cfqueryparam value="#User.getAddress1()#" cfsqltype="CF_SQL_VARCHAR"/>,
        address2  = <cfqueryparam value="#User.getAddress2()#" cfsqltype="CF_SQL_VARCHAR"/>,
        postcode  = <cfqueryparam value="#User.getPostCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
        state  = <cfqueryparam value="#User.getState()#" cfsqltype="CF_SQL_VARCHAR"/>,
        phone  = <cfqueryparam value="#User.getPhone()#" cfsqltype="CF_SQL_VARCHAR"/>,
        fax  = <cfqueryparam value="#User.getFax()#" cfsqltype="CF_SQL_VARCHAR"/>,
        mobile  = <cfqueryparam value="#User.getMobile()#" cfsqltype="CF_SQL_VARCHAR"/>,
        email  = <cfqueryparam value="#User.getUserEmail()#" cfsqltype="CF_SQL_VARCHAR"/>,
        birthday  = <cfqueryparam value="#User.getBirthDay()#" cfsqltype="CF_SQL_VARCHAR"/>,
        empstatusid  = <cfqueryparam value="#User.getEmpStatusID()#" cfsqltype="CF_SQL_INTEGER"/>,
        commenced  = <cfqueryparam value="#User.getCommenced()#" cfsqltype="CF_SQL_VARCHAR"/>,
        nolongerused  = <cfqueryparam value="#User.getNoLongerUsed()#" cfsqltype="CF_SQL_BIT"/>,
        usertypeid  = <cfqueryparam value="#User.getUserTypeID()#" cfsqltype="CF_SQL_INTEGER"/>,
        username  = <cfqueryparam value="#User.getUserName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        password  = <cfqueryparam value="#User.getPassword()#" cfsqltype="CF_SQL_VARCHAR"/>

						
		WHERE 
		employeeid = <cfqueryparam value="#User.getemployeeid()#"   cfsqltype="CF_SQL_VARCHAR" />
	</cfquery>
		<cfset setstores(   User  ) />
    
	<cfreturn User />
</cffunction>

</cfcomponent>