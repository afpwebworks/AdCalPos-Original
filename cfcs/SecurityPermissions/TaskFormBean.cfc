<cfcomponent displayname="TaskFormBean" output="false" hint="A bean which models the TaskFormBean record.">
<cfsilent>
<!----
==========================================================================================================
Filename:    TaskFormBean.cfc
Description: A bean which models the TaskFormBean record
Date:        17/Jan/2014
Author:      Michael Kear

Revision history:

==========================================================================================================
This bean was generated by the Beanbuilder Generator with the following template:
Bean Name: TaskFormBean
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
TaskFormID numeric 0 
TaskName string 
FormName string 
DateEntered date #now()#
MainHeading string 
HeadingOrder numeric 0 
FormOrder numeric 0 
TaskType numeric 1 

Create getSnapshot method: true
Create setSnapshot method: true
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="TaskFormBean" output="false">
    
<cfargument name="TaskFormID" type="numeric" required="true" default="0" />
    <cfargument name="TaskName" type="string" required="false" default="" />
    <cfargument name="FormName" type="string" required="false" default="" />
    <cfargument name="DateEntered" type="date" required="false" default="#now()#" />
    <cfargument name="MainHeading" type="string" required="false" default="" />
    <cfargument name="HeadingOrder" type="numeric" required="false" default="0" />
    <cfargument name="FormOrder" type="numeric" required="false" default="0" />
    <cfargument name="TaskType" type="numeric" required="true" default="1" />
      
    <cfscript>
// run setters

     setTaskFormID(arguments.TaskFormID);
     setTaskName(arguments.TaskName);
     setFormName(arguments.FormName);
     setDateEntered(arguments.DateEntered);
     setMainHeading(arguments.MainHeading);
     setHeadingOrder(arguments.HeadingOrder);
     setFormOrder(arguments.FormOrder);
     setTaskType(arguments.TaskType);
     return this;
	</cfscript>
 	</cffunction>
	<!---[ 	PUBLIC FUNCTIONS  ]--->
	<cffunction name="getSnapshot" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
    
            <cffunction name="validate" access="public" returntype="any" output="false">
                    <cfargument name="eH" required="true" type="any" />
            <!-----[ validation parameters  (customise to suit) then remove comments     

 
   ]---->
		<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS  ]--->
    
    <cffunction name="setTaskFormID" access="public" returntype="void" output="false">
            <cfargument name="TaskFormID" type="numeric" required="true" />
            <cfset variables.instance.TaskFormID = arguments.TaskFormID />
	    </cffunction>
    <cffunction name="getTaskFormID" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.TaskFormID />
		</cffunction>
    <cffunction name="setTaskName" access="public" returntype="void" output="false">
            <cfargument name="TaskName" type="string" required="true" />
            <cfset variables.instance.TaskName = arguments.TaskName />
	    </cffunction>
    <cffunction name="getTaskName" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.TaskName />
		</cffunction>
    <cffunction name="setFormName" access="public" returntype="void" output="false">
            <cfargument name="FormName" type="string" required="true" />
            <cfset variables.instance.FormName = arguments.FormName />
	    </cffunction>
    <cffunction name="getFormName" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.FormName />
		</cffunction>
    <cffunction name="setDateEntered" access="public" returntype="void" output="false">
            <cfargument name="DateEntered" type="date" required="true" />
            <cfset variables.instance.DateEntered = arguments.DateEntered />
	    </cffunction>
    <cffunction name="getDateEntered" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateEntered />
		</cffunction>
    <cffunction name="setMainHeading" access="public" returntype="void" output="false">
            <cfargument name="MainHeading" type="string" required="true" />
            <cfset variables.instance.MainHeading = arguments.MainHeading />
	    </cffunction>
    <cffunction name="getMainHeading" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.MainHeading />
		</cffunction>
    <cffunction name="setHeadingOrder" access="public" returntype="void" output="false">
            <cfargument name="HeadingOrder" type="numeric" required="true" />
            <cfset variables.instance.HeadingOrder = arguments.HeadingOrder />
	    </cffunction>
    <cffunction name="getHeadingOrder" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.HeadingOrder />
		</cffunction>
    <cffunction name="setFormOrder" access="public" returntype="void" output="false">
            <cfargument name="FormOrder" type="numeric" required="true" />
            <cfset variables.instance.FormOrder = arguments.FormOrder />
	    </cffunction>
    <cffunction name="getFormOrder" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.FormOrder />
		</cffunction>
    <cffunction name="setTaskType" access="public" returntype="void" output="false">
            <cfargument name="TaskType" type="numeric" required="true" />
            <cfset variables.instance.TaskType = arguments.TaskType />
	    </cffunction>
    <cffunction name="getTaskType" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.TaskType />
		</cffunction>
</cfcomponent>