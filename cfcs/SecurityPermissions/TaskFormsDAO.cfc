<cfcomponent displayname="tblSecurityTaskForms DAO" output="false" hint="DAO Component Handles all Database access for the table tblSecurityTaskForms.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    TaskFormsDAO.cfc
Description: DAO Component Handles all Database access for the table tblSecurityTaskForms.  Requires Coldspring v1.0
Date:        17/Jan/2014
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( TaskFormBean.gettaskformid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="TaskFormsDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>

<cffunction name="setUserService" access="public" output="false" returntype="void" hint="Dependency: User Service">
	<cfargument name="UserService" type="any" required="true"/>
	<cfset variables.UserService = arguments.UserService/>
</cffunction>


<cffunction name="save" access="public" returntype="TaskFormBean" output="false" hint="DAO method">
<cfargument name="TaskFormBean" type="TaskFormBean" required="yes" />
<!-----[  If a TaskformID exists in the arguments, its an update. Run the update method, otherwise run create.  ]----->
<cfif (arguments.TaskFormBean.getTaskformID() neq "")>	
		<cfset TaskFormBean = update(arguments.TaskFormBean)/>
	<cfelse>
		<cfset TaskFormBean = create(arguments.TaskFormBean)/>
	</cfif>
	<cfreturn TaskFormBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="TaskFormBean" type="TaskFormBean" required="true" /> 
	<cfset var qTaskFormBeanDelete = 0 >
<cfquery name="TaskFormBeanDelete" datasource="#variables.dsn#" >
		DELETE FROM tblSecurityTaskForms
		WHERE 
		TaskformID = <cfqueryparam value="#TaskFormBean.getTaskformID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	
</cffunction>



<cffunction name="read" access="public" returntype="TaskFormBean" output="false" hint="DAO Method. - Reads a TaskFormBean into the bean">
<cfargument name="argsTaskFormBean" type="TaskFormBean" required="true" />
	<cfset var TaskFormBean  =  arguments.argsTaskFormBean />
	<cfset var QtblSecurityTaskFormsselect = "" />
	<cfquery name="QtblSecurityTaskFormsselect" datasource="#variables.dsn#">
		SELECT 
		TaskFormID, TaskName, FormName, DateEntered, MainHeading, HeadingOrder, FormOrder, TaskType
		FROM tblSecurityTaskForms 
		WHERE 
		TaskformID = <cfqueryparam value="#TaskFormBean.getTaskformID()#"  cfsqltype="CF_SQL_VARCHAR"/>
	</cfquery>
	<cfif QtblSecurityTaskFormsselect.recordCount >
		<cfscript>
		TaskFormBean.setTaskFormID(QtblSecurityTaskFormsselect.TaskFormID);
         TaskFormBean.setTaskName(QtblSecurityTaskFormsselect.TaskName);
         TaskFormBean.setFormName(QtblSecurityTaskFormsselect.FormName);
         TaskFormBean.setDateEntered(QtblSecurityTaskFormsselect.DateEntered);
         TaskFormBean.setMainHeading(QtblSecurityTaskFormsselect.MainHeading);
         TaskFormBean.setHeadingOrder(QtblSecurityTaskFormsselect.HeadingOrder);
         TaskFormBean.setFormOrder(QtblSecurityTaskFormsselect.FormOrder);
         TaskFormBean.setTaskType(QtblSecurityTaskFormsselect.TaskType);
         
		</cfscript>
	</cfif>
	<cfreturn TaskFormBean />
</cffunction>
		

<cffunction name="GetAllTaskFormBeans" access="public" output="false" returntype="query" hint="Returns a query of all TaskFormBeans in our Database">
<cfset var QgetallTaskFormBeans = 0 />
	<cfquery name="QgetallTaskFormBeans" datasource="#variables.dsn#">
		SELECT TaskFormID, TaskName, FormName, DateEntered, MainHeading, HeadingOrder, FormOrder, TaskType
		FROM tblSecurityTaskForms 
		ORDER BY TaskformID
	</cfquery>
	<cfreturn QgetallTaskFormBeans />
</cffunction>


<cffunction name="getTasks" access="public" returntype="query" output="no" hint="Returns a query of all tasks">
		<cfset var qResult="0">
        
        <cfquery name="qResult" datasource="#variables.dsn#">
           SELECT F.TaskFormID , F.TaskName, F.FormName, F.DateEntered, F.TaskFormID AS ID_Field 
    		FROM tblSecurityTaskForms F
    		ORDER BY F.TaskFormID
	    </cfquery>
    
		<cfreturn qResult>
	</cffunction>

<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="TaskFormBean" output="false" hint="DAO method">
<cfargument name="argsTaskFormBean" type="TaskFormBean" required="yes" displayname="create" />
	<cfset var qTaskFormBeanInsert = 0 />
	<cfset var TaskFormBean = arguments.argsTaskFormBean />
	
	<cfquery name="qTaskFormBeanInsert" datasource="#variables.dsn#" >
		SET NOCOUNT ON
		INSERT into tblSecurityTaskForms
		( TaskName, FormName, DateEntered, MainHeading, HeadingOrder, FormOrder, TaskType ) VALUES
		(

		<cfqueryparam value="#TaskFormBean.gettaskname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#TaskFormBean.getformname()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#TaskFormBean.getdateentered()#" cfsqltype="CF_SQL_TIMESTAMP" />,
		<cfqueryparam value="#TaskFormBean.getmainheading()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#TaskFormBean.getheadingorder()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#TaskFormBean.getformorder()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#TaskFormBean.gettasktype()#" cfsqltype="CF_SQL_INTEGER" />
		   ) 
		SELECT Ident_Current('tblSecurityTaskForms') as TaskformID
		SET NOCOUNT OFF
	</cfquery>
	<cfset TaskFormBean.setTaskformID(qTaskFormBeanInsert.TaskformID)>

	<cfreturn TaskFormBean />
</cffunction>

<cffunction name="update" access="private" returntype="TaskFormBean" output="false" hint="DAO method">
<cfargument name="argsTaskFormBean" type="TaskFormBean" required="yes" />
	<cfset var TaskFormBean = arguments.argsTaskFormBean />
	<cfset var TaskFormBeanUpdate = 0 >
	<cfquery name="TaskFormBeanUpdate" datasource="#variables.dsn#" >
		UPDATE tblSecurityTaskForms SET
        taskname  = <cfqueryparam value="#TaskFormBean.getTaskName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        formname  = <cfqueryparam value="#TaskFormBean.getFormName()#" cfsqltype="CF_SQL_VARCHAR"/>,
        dateentered  = <cfqueryparam value="#TaskFormBean.getDateEntered()#" cfsqltype="CF_SQL_TIMESTAMP"/>,
        mainheading  = <cfqueryparam value="#TaskFormBean.getMainHeading()#" cfsqltype="CF_SQL_VARCHAR"/>,
        headingorder  = <cfqueryparam value="#TaskFormBean.getHeadingOrder()#" cfsqltype="CF_SQL_INTEGER"/>,
        formorder  = <cfqueryparam value="#TaskFormBean.getFormOrder()#" cfsqltype="CF_SQL_INTEGER"/>,
        tasktype  = <cfqueryparam value="#TaskFormBean.getTaskType()#" cfsqltype="CF_SQL_INTEGER"/>
						
		WHERE 
		TaskformID = <cfqueryparam value="#TaskFormBean.getTaskformID()#"   cfsqltype="CF_SQL_VARCHAR" />
	</cfquery>
	
	<cfreturn TaskFormBean />
</cffunction>

</cfcomponent>