<cfsilent>
<!----
==========================================================================================================
Filename:     EditSecurityTaskForms.cfm
Description:  Edit security tasks
Cient: 	      Adcalpos demo
Date:         17/1/2014
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfscript>
TaskFormBean = application.beanfactory.getbean( "TaskFormBean" );
TaskFormsDAO = application.beanfactory.getbean( "TaskFormsDAO" );
</cfscript>


<cfif (isdefined("form") and structKeyExists(form, "submit"))>

<cfscript>

TaskFormBean.settaskformid(form.taskformid);
TaskFormBean.setTaskName(form.TaskName);
TaskFormBean.setFormName(form.FormName);
TaskFormBean.setDateEntered(form.DateEntered);
TaskFormBean.setMainHeading(form.MainHeading);
TaskFormBean.setHeadingOrder(form.HeadingOrder);
TaskFormBean.setFormOrder(form.FormOrder);
TaskFormBean.setTaskType(form.TaskType);
TaskFormsDAO.save( taskformbean );
</cfscript>

<cflocation addtoken="no" url="/securitypermissions/ViewSecurityTaskformsList.cfm" />

</cfif>




<cfscript>
request.pagename = "Edit Security Task Properties";
TaskFormBean.setTaskFormID( url.recordid );
TaskFormsDAO.read( TaskFormBean );
Headings = application.beanfactory.getbean( "Menus" ).getMainMenuHeadings();
</cfscript>
</cfsilent>
<cfinclude template="/includes/header.cfm" />
<table width="100%">
  <tr valign="middle">
    <td width="25%">&nbsp;</td>
    <td><h1>
        <cfoutput>#request.pagename#</cfoutput>
      </h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<cfoutput>
<table width="100%" border="0">
<tr>
<td>
<div align="center">
<table id="id2" >
  <form name="tblSecurityTaskFormsform" id="tblSecurityTaskFormsform"  role="form" action="#cgi.SCRIPT_NAME#" method="post" >
    <input type="hidden" name="TaskFormID" value="#TaskFormBean.getTaskFormID()#" />
    <input type="hidden" id="DateEntered" name="DateEntered"  value="#TaskFormBean.getDateEntered()#" >
    <tbody>
      <tr>
        <td colspan="2"><cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
            <div class="errorhandler"> #errorhandler.MakeErrorDisplay(errorhandler)# </div>
          </cfif></td>
      </tr>
      <tr>
        <td><label for="TaskName">Task Name</label></td>
        <td><input type="text" class="form-control" id="TaskName"  name="TaskName" placeholder="TaskName"  maxlength="25"  value="#TaskFormBean.getTaskName()#" ></td>
      </tr>
      <tr>
        <td><label for="FormName">Form Name</label></td>
        <td><input type="text" class="form-control" id="FormName"  name="FormName" placeholder="FormName"  maxlength="50"  value="#TaskFormBean.getFormName()#" ></td>
      </tr>
      <tr>
        <td><label for="MainHeading" >Main Heading</label></td>
        <td><select name="MainHeading"  id="MainHeading" class="form-control">
            <cfloop query="Headings">
            <option value="#headings.MainHeading#" <cfif #TaskFormBean.getMainHeading()# eq headings.mainheading> selected="selected"</cfif>>#headings.MainHeading#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <td><label for="FormOrder">Form Order</label></td>
        <td><input type="number" class="form-control" id="FormOrder"  name="FormOrder" placeholder="FormOrder"  value="#TaskFormBean.getFormOrder()#" ></td>
      </tr>
      <tr>
        <td><label for="HeadingOrder">Heading Order</label></td>
        <td><input type="number" class="form-control" id="HeadingOrder"  name="HeadingOrder" placeholder="HeadingOrder"  value="#TaskFormBean.getHeadingOrder()#" ></td>
      </tr>
      <tr>
        <td><label for="TaskType">TaskType</label></td>
        <td><input type="number" class="form-control" id="TaskType"  name="TaskType" placeholder="TaskType" required  value="#TaskFormBean.getTaskType()#" ></td>
      </tr>
      <tr>
        <td colspan="2"><input type="submit" name="submit" id="submit" Submit/></td>
       
      </tr>
    </tbody>
  </form>
</table>
</cfoutput>
</td>
</tr>
</table>
</div>
</body>
</HTML>
