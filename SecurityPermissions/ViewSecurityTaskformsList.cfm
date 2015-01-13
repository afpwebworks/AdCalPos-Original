<cfsilent>
<!----
==========================================================================================================
Filename:     ViewSecurityTaskformsList.cfm
Description:  Lists Security Task Forms in a table.
Client:       Adcalpos demo
Date:         17/1/2014
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>
strPageTitle = "Security Task Forms List";
tasks = application.beanfactory.getbean("TaskFormsDAO").getTasks() ;
</cfscript>
<cfparam name="request.pagename" default="List Security Task Forms">
</cfsilent>
<cfinclude template="/includes/header.cfm" />

<body>
<cfinclude template="/js/jqueryaddin.cfm" >
<table width="100%">
  <tr valign="middle">
    <td width="25%">&nbsp;</td>
    <td><h1><cfoutput>#strPageTitle#</cfoutput></h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td><div align="center">
<p>Click on a task to edit its properties.</p>

<table id="id2" class="tablesorter">
   <thead>
   	<th>Task Form ID</a></th>
    <th>Task Name</th>
    <th>Form Name</th>
   </thead>
   <tbody>
   	<cfloop query="tasks"><cfoutput>
    <tr>
    	<td><a href="/securitypermissions/EditSecurityTaskForms.cfm?RecordID=#taskformid#">#tasks.taskformid#</a></td>
        <td><a href="/securitypermissions/EditSecurityTaskForms.cfm?RecordID=#taskformid#">#tasks.taskname#</a></td>
        <td><a href="/securitypermissions/EditSecurityTaskForms.cfm?RecordID=#taskformid#">#tasks.formname#</a></td>
    </tr>
    </cfoutput></cfloop>
   </tbody>
</table>
<!----[  <cfdump var="#tasks#" />  ]----MK ---->
<!----[  <cfinclude template="/assets/core/cf/includes/footer.cfm" />  ]----MK ---->
</body>
</HTML>