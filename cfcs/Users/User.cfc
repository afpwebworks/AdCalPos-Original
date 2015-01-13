<cfcomponent displayname="User" output="false" hint="A bean which models the User record.">

<cfsilent>
<!----
================================================================
Filename: User.cfc
Description: A bean which models the User record.
Author:  Michael Kear, AFP Webworks 
Date: 28/Sep/2010
================================================================
This bean was generated with the following template:
Bean Name: User
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	Userid numeric 0
	UserName string 
	Password string 
	Givenname string 
	Surname string 
	empfullname string 
	employeeID numeric 0
	usertype numeric 0
	storeid numeric 0
	storename string 
	UserEmail string 
	bundyno numeric 0
	Street string 
	Address1 string 
	Address2 string 
	PostCode string 
	State string 
	Phone string 
	Fax string 
	Mobile string 
	BirthDay string 
	EmpStatusID numeric 0
	Commenced string 
	NoLongerUsed boolean false
	UserTypeID numeric 0
	isLoggedIn boolean false
	StoresToSee string 0
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="User" output="false">
		<cfargument name="Userid" type="numeric" required="false" default="0" />
		<cfargument name="UserName" type="string" required="false" default="" />
		<cfargument name="Password" type="string" required="false" default="" />
		<cfargument name="Givenname" type="string" required="false" default="" />
		<cfargument name="Surname" type="string" required="false" default="" />
		<cfargument name="empfullname" type="string" required="false" default="" />
		<cfargument name="employeeID" type="numeric" required="false" default="0" />
		<cfargument name="usertype" type="numeric" required="false" default="0" />
		<cfargument name="storeid" type="numeric" required="false" default="0" />
		<cfargument name="storename" type="string" required="false" default="" />
		<cfargument name="UserEmail" type="string" required="false" default="" />
		<cfargument name="bundyno" type="numeric" required="false" default="0" />
		<cfargument name="Street" type="string" required="false" default="" />
		<cfargument name="Address1" type="string" required="false" default="" />
		<cfargument name="Address2" type="string" required="false" default="" />
		<cfargument name="PostCode" type="string" required="false" default="" />
		<cfargument name="State" type="string" required="false" default="" />
		<cfargument name="Phone" type="string" required="false" default="" />
		<cfargument name="Fax" type="string" required="false" default="" />
		<cfargument name="Mobile" type="string" required="false" default="" />
		<cfargument name="BirthDay" type="string" required="false" default="" />
		<cfargument name="EmpStatusID" type="numeric" required="false" default="0" />
		<cfargument name="Commenced" type="string" required="false" default="" />
		<cfargument name="NoLongerUsed" type="boolean" required="false" default="false" />
		<cfargument name="UserTypeID" type="numeric" required="false" default="0" />
		<cfargument name="isLoggedIn" type="boolean" required="false" default="false" />
		<cfargument name="StoresToSee" type="string" required="false" default="0" />
		<cfscript>
			// run setters
			setUserid(arguments.Userid);
			setUserName(arguments.UserName);
			setPassword(arguments.Password);
			setGivenname(arguments.Givenname);
			setSurname(arguments.Surname);
			setEmpfullname(arguments.empfullname);
			setEmployeeID(arguments.employeeID);
			setUsertype(arguments.usertype);
			setStoreid(arguments.storeid);
			setStorename(arguments.storename);
			setUserEmail(arguments.UserEmail);
			setBundyno(arguments.bundyno);
			setStreet(arguments.Street);
			setAddress1(arguments.Address1);
			setAddress2(arguments.Address2);
			setPostCode(arguments.PostCode);
			setState(arguments.State);
			setPhone(arguments.Phone);
			setFax(arguments.Fax);
			setMobile(arguments.Mobile);
			setBirthDay(arguments.BirthDay);
			setEmpStatusID(arguments.EmpStatusID);
			setCommenced(arguments.Commenced);
			setNoLongerUsed(arguments.NoLongerUsed);
			setUserTypeID(arguments.UserTypeID);
			setIsLoggedIn(arguments.isLoggedIn);
			setStoresToSee(arguments.StoresToSee);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="eH" required="true" type="any" />
<!-----[ validation parameters  (customise to suit) then remove comments 
			<!----[ Userid ]---->
			<cfif ( getUserid() eq whatever )>
				<cfset arguments.eH.setError("Userid", "Userid This is the error message") />
			</cfif>
			<!----[ UserName ]---->
			<cfif ( getUserName() eq whatever )>
				<cfset arguments.eH.setError("UserName", "UserName This is the error message") />
			</cfif>
			<!----[ Password ]---->
			<cfif ( getPassword() eq whatever )>
				<cfset arguments.eH.setError("Password", "Password This is the error message") />
			</cfif>
			<!----[ Givenname ]---->
			<cfif ( getGivenname() eq whatever )>
				<cfset arguments.eH.setError("Givenname", "Givenname This is the error message") />
			</cfif>
			<!----[ Surname ]---->
			<cfif ( getSurname() eq whatever )>
				<cfset arguments.eH.setError("Surname", "Surname This is the error message") />
			</cfif>
			<!----[ empfullname ]---->
			<cfif ( getEmpfullname() eq whatever )>
				<cfset arguments.eH.setError("empfullname", "empfullname This is the error message") />
			</cfif>
			<!----[ employeeID ]---->
			<cfif ( getEmployeeID() eq whatever )>
				<cfset arguments.eH.setError("employeeID", "employeeID This is the error message") />
			</cfif>
			<!----[ usertype ]---->
			<cfif ( getUsertype() eq whatever )>
				<cfset arguments.eH.setError("usertype", "usertype This is the error message") />
			</cfif>
			<!----[ storeid ]---->
			<cfif ( getStoreid() eq whatever )>
				<cfset arguments.eH.setError("storeid", "storeid This is the error message") />
			</cfif>
			<!----[ storename ]---->
			<cfif ( getStorename() eq whatever )>
				<cfset arguments.eH.setError("storename", "storename This is the error message") />
			</cfif>
			<!----[ UserEmail ]---->
			<cfif ( getUserEmail() eq whatever )>
				<cfset arguments.eH.setError("UserEmail", "UserEmail This is the error message") />
			</cfif>
			<!----[ bundyno ]---->
			<cfif ( getBundyno() eq whatever )>
				<cfset arguments.eH.setError("bundyno", "bundyno This is the error message") />
			</cfif>
			<!----[ Street ]---->
			<cfif ( getStreet() eq whatever )>
				<cfset arguments.eH.setError("Street", "Street This is the error message") />
			</cfif>
			<!----[ Address1 ]---->
			<cfif ( getAddress1() eq whatever )>
				<cfset arguments.eH.setError("Address1", "Address1 This is the error message") />
			</cfif>
			<!----[ Address2 ]---->
			<cfif ( getAddress2() eq whatever )>
				<cfset arguments.eH.setError("Address2", "Address2 This is the error message") />
			</cfif>
			<!----[ PostCode ]---->
			<cfif ( getPostCode() eq whatever )>
				<cfset arguments.eH.setError("PostCode", "PostCode This is the error message") />
			</cfif>
			<!----[ State ]---->
			<cfif ( getState() eq whatever )>
				<cfset arguments.eH.setError("State", "State This is the error message") />
			</cfif>
			<!----[ Phone ]---->
			<cfif ( getPhone() eq whatever )>
				<cfset arguments.eH.setError("Phone", "Phone This is the error message") />
			</cfif>
			<!----[ Fax ]---->
			<cfif ( getFax() eq whatever )>
				<cfset arguments.eH.setError("Fax", "Fax This is the error message") />
			</cfif>
			<!----[ Mobile ]---->
			<cfif ( getMobile() eq whatever )>
				<cfset arguments.eH.setError("Mobile", "Mobile This is the error message") />
			</cfif>
			<!----[ BirthDay ]---->
			<cfif ( getBirthDay() eq whatever )>
				<cfset arguments.eH.setError("BirthDay", "BirthDay This is the error message") />
			</cfif>
			<!----[ EmpStatusID ]---->
			<cfif ( getEmpStatusID() eq whatever )>
				<cfset arguments.eH.setError("EmpStatusID", "EmpStatusID This is the error message") />
			</cfif>
			<!----[ Commenced ]---->
			<cfif ( getCommenced() eq whatever )>
				<cfset arguments.eH.setError("Commenced", "Commenced This is the error message") />
			</cfif>
			<!----[ NoLongerUsed ]---->
			<cfif ( getNoLongerUsed() eq whatever )>
				<cfset arguments.eH.setError("NoLongerUsed", "NoLongerUsed This is the error message") />
			</cfif>
			<!----[ UserTypeID ]---->
			<cfif ( getUserTypeID() eq whatever )>
				<cfset arguments.eH.setError("UserTypeID", "UserTypeID This is the error message") />
			</cfif>
			<!----[ isLoggedIn ]---->
			<cfif ( getIsLoggedIn() eq whatever )>
				<cfset arguments.eH.setError("isLoggedIn", "isLoggedIn This is the error message") />
			</cfif>
			<!----[ StoresToSee ]---->
			<cfif ( getStoresToSee() eq whatever )>
				<cfset arguments.eH.setError("StoresToSee", "StoresToSee This is the error message") />
			</cfif>
 ]---->
			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setUserid" access="public" returntype="void" output="false">
		<cfargument name="Userid" type="numeric" required="true" />
		<cfset variables.instance.Userid = arguments.Userid />
	</cffunction>
	<cffunction name="getUserid" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Userid />
	</cffunction>

	<cffunction name="setUserName" access="public" returntype="void" output="false">
		<cfargument name="UserName" type="string" required="true" />
		<cfset variables.instance.UserName = arguments.UserName />
	</cffunction>
	<cffunction name="getUserName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserName />
	</cffunction>

	<cffunction name="setPassword" access="public" returntype="void" output="false">
		<cfargument name="Password" type="string" required="true" />
		<cfset variables.instance.Password = arguments.Password />
	</cffunction>
	<cffunction name="getPassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Password />
	</cffunction>

	<cffunction name="setGivenname" access="public" returntype="void" output="false">
		<cfargument name="Givenname" type="string" required="true" />
		<cfset variables.instance.Givenname = arguments.Givenname />
	</cffunction>
	<cffunction name="getGivenname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Givenname />
	</cffunction>

	<cffunction name="setSurname" access="public" returntype="void" output="false">
		<cfargument name="Surname" type="string" required="true" />
		<cfset variables.instance.Surname = arguments.Surname />
	</cffunction>
	<cffunction name="getSurname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Surname />
	</cffunction>

	<cffunction name="setEmpfullname" access="public" returntype="void" output="false">
		<cfargument name="empfullname" type="string" required="true" />
		<cfset variables.instance.empfullname = arguments.empfullname />
	</cffunction>
	<cffunction name="getEmpfullname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.empfullname />
	</cffunction>

	<cffunction name="setEmployeeID" access="public" returntype="void" output="false">
		<cfargument name="employeeID" type="numeric" required="true" />
		<cfset variables.instance.employeeID = arguments.employeeID />
	</cffunction>
	<cffunction name="getEmployeeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.employeeID />
	</cffunction>

	<cffunction name="setUsertype" access="public" returntype="void" output="false">
		<cfargument name="usertype" type="numeric" required="true" />
		<cfset variables.instance.usertype = arguments.usertype />
	</cffunction>
	<cffunction name="getUsertype" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.usertype />
	</cffunction>

	<cffunction name="setStoreid" access="public" returntype="void" output="false">
		<cfargument name="storeid" type="numeric" required="true" />
		<cfset variables.instance.storeid = arguments.storeid />
	</cffunction>
	<cffunction name="getStoreid" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.storeid />
	</cffunction>

	<cffunction name="setStorename" access="public" returntype="void" output="false">
		<cfargument name="storename" type="string" required="true" />
		<cfset variables.instance.storename = arguments.storename />
	</cffunction>
	<cffunction name="getStorename" access="public" returntype="string" output="false">
		<cfreturn variables.instance.storename />
	</cffunction>

	<cffunction name="setUserEmail" access="public" returntype="void" output="false">
		<cfargument name="UserEmail" type="string" required="true" />
		<cfset variables.instance.UserEmail = arguments.UserEmail />
	</cffunction>
	<cffunction name="getUserEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserEmail />
	</cffunction>

	<cffunction name="setBundyno" access="public" returntype="void" output="false">
		<cfargument name="bundyno" type="numeric" required="true" />
		<cfset variables.instance.bundyno = arguments.bundyno />
	</cffunction>
	<cffunction name="getBundyno" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.bundyno />
	</cffunction>

	<cffunction name="setStreet" access="public" returntype="void" output="false">
		<cfargument name="Street" type="string" required="true" />
		<cfset variables.instance.Street = arguments.Street />
	</cffunction>
	<cffunction name="getStreet" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Street />
	</cffunction>

	<cffunction name="setAddress1" access="public" returntype="void" output="false">
		<cfargument name="Address1" type="string" required="true" />
		<cfset variables.instance.Address1 = arguments.Address1 />
	</cffunction>
	<cffunction name="getAddress1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address1 />
	</cffunction>

	<cffunction name="setAddress2" access="public" returntype="void" output="false">
		<cfargument name="Address2" type="string" required="true" />
		<cfset variables.instance.Address2 = arguments.Address2 />
	</cffunction>
	<cffunction name="getAddress2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address2 />
	</cffunction>

	<cffunction name="setPostCode" access="public" returntype="void" output="false">
		<cfargument name="PostCode" type="string" required="true" />
		<cfset variables.instance.PostCode = arguments.PostCode />
	</cffunction>
	<cffunction name="getPostCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostCode />
	</cffunction>

	<cffunction name="setState" access="public" returntype="void" output="false">
		<cfargument name="State" type="string" required="true" />
		<cfset variables.instance.State = arguments.State />
	</cffunction>
	<cffunction name="getState" access="public" returntype="string" output="false">
		<cfreturn variables.instance.State />
	</cffunction>

	<cffunction name="setPhone" access="public" returntype="void" output="false">
		<cfargument name="Phone" type="string" required="true" />
		<cfset variables.instance.Phone = arguments.Phone />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Phone />
	</cffunction>

	<cffunction name="setFax" access="public" returntype="void" output="false">
		<cfargument name="Fax" type="string" required="true" />
		<cfset variables.instance.Fax = arguments.Fax />
	</cffunction>
	<cffunction name="getFax" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Fax />
	</cffunction>

	<cffunction name="setMobile" access="public" returntype="void" output="false">
		<cfargument name="Mobile" type="string" required="true" />
		<cfset variables.instance.Mobile = arguments.Mobile />
	</cffunction>
	<cffunction name="getMobile" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Mobile />
	</cffunction>

	<cffunction name="setBirthDay" access="public" returntype="void" output="false">
		<cfargument name="BirthDay" type="string" required="true" />
		<cfset variables.instance.BirthDay = arguments.BirthDay />
	</cffunction>
	<cffunction name="getBirthDay" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BirthDay />
	</cffunction>

	<cffunction name="setEmpStatusID" access="public" returntype="void" output="false">
		<cfargument name="EmpStatusID" type="numeric" required="true" />
		<cfset variables.instance.EmpStatusID = arguments.EmpStatusID />
	</cffunction>
	<cffunction name="getEmpStatusID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.EmpStatusID />
	</cffunction>

	<cffunction name="setCommenced" access="public" returntype="void" output="false">
		<cfargument name="Commenced" type="string" required="true" />
		<cfset variables.instance.Commenced = arguments.Commenced />
	</cffunction>
	<cffunction name="getCommenced" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Commenced />
	</cffunction>

	<cffunction name="setNoLongerUsed" access="public" returntype="void" output="false">
		<cfargument name="NoLongerUsed" type="boolean" required="true" />
		<cfset variables.instance.NoLongerUsed = arguments.NoLongerUsed />
	</cffunction>
	<cffunction name="getNoLongerUsed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.NoLongerUsed />
	</cffunction>

	<cffunction name="setUserTypeID" access="public" returntype="void" output="false">
		<cfargument name="UserTypeID" type="numeric" required="true" />
		<cfset variables.instance.UserTypeID = arguments.UserTypeID />
	</cffunction>
	<cffunction name="getUserTypeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserTypeID />
	</cffunction>

	<cffunction name="setIsLoggedIn" access="public" returntype="void" output="false">
		<cfargument name="isLoggedIn" type="boolean" required="true" />
		<cfset variables.instance.isLoggedIn = arguments.isLoggedIn />
	</cffunction>
	<cffunction name="getIsLoggedIn" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.isLoggedIn />
	</cffunction>

	<cffunction name="setStoresToSee" access="public" returntype="void" output="false">
		<cfargument name="StoresToSee" type="string" required="true" />
		<cfset variables.instance.StoresToSee = arguments.StoresToSee />
	</cffunction>
	<cffunction name="getStoresToSee" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StoresToSee />
	</cffunction>

</cfcomponent>