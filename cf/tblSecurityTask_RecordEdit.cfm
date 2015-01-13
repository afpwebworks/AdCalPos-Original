
<cfset strPageTitle = "Security Task Add/Edit">

<!--- 
TaskID
TaskFormID
UserType
 --->

<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->

<CFSET FormFieldList = "TaskFormID,UserTypeID">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblSecurityTask.TaskID, tblSecurityTask.TaskFormID, tblSecurityTask.UserTypeID, tblSecurityTask.TaskID AS ID_Field
		FROM tblSecurityTask
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblSecurityTask.TaskID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "TaskID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "TaskID" )>
	</CFIF>
			<CFSET TaskID_Value = #GetRecord.TaskID#>
				
			<CFSET TaskFormID_Value = #GetRecord.TaskFormID#>
				
			<CFSET UserTypeID_Value = #GetRecord.UserTypeID#>
<CFELSE>
			<CFSET TaskID_Value = ''>
				
			<CFSET TaskFormID_Value = 0>
				
			<CFSET UserTypeID_Value = 0>
</CFIF>

<cfset strQuery = "SELECT tblSecurityUserTypes.UserTypeID, tblSecurityUserTypes.UserType ">
<cfset strQuery = strQuery & "FROM tblSecurityUserTypes ">
<cfset strQuery = strQuery & "ORDER BY tblSecurityUserTypes.UserTypeID">

<CFQUERY name="GetUserTypes" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetUserTypes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT tblSecurityTaskForms.TaskFormID, [TaskName] + '   ( ' + [FormName] + ' )' AS Description ">
<cfset strQuery = strQuery & "FROM tblSecurityTaskForms ">
<cfset strQuery = strQuery & "ORDER BY [TaskName] + '   ( ' + [FormName] + ' )'">

<CFQUERY name="GetScreens" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetScreens" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- 
        <select name="JobNo">
      <cfoutput query="GetData"> 
        <cfif '#GetData.JobNumber#' eq '#MyID#'>
        <option value="#GetData.JobNumber#" selected>#GetData.ProductClass#</option>
        <cfelse>
        <option value="#GetData.JobNumber#">#GetData.ProductClass#</option>
        </cfif>
      </cfoutput> 
    </select>
 --->

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="tblSecurityTask_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<CFOUTPUT>
<FORM action="tblSecurityTask_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="TaskID" value="#URL.RecordID#">
</CFIF>


           <TABLE border="1" width="550"  cellpadding="2"> 			
              <CFIF not ParameterExists(URL.RecordID)>
<!---               
			  <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Task ID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="TaskID" value="#TaskID_Value#" size="35" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="TaskID_integer">
              </TR>
 --->              
			  <cfelse>
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF">TaskID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF">#TaskID_Value#</font>
                </TD>
              </TR>
			  </CFIF>

              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Task Form ID: </font></b></TD>
                <TD> 
			      </CFOUTPUT>
			      <select name="TaskFormID">
				      <cfoutput query="GetScreens"> 
					        <cfif '#GetScreens.TaskFormID#' eq #TaskFormID_Value#>
						        <option value="#GetScreens.TaskFormID#" selected>#GetScreens.Description#</option>
					        <cfelse>
						        <option value="#GetScreens.TaskFormID#">#GetScreens.Description#</option>
					        </cfif>
				      </cfoutput> 
				  </select>
			      <CFOUTPUT>
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  User Type: </font></b></TD>
                <TD> 
			      </CFOUTPUT>
				  <select name="UserTypeID">
				      <cfoutput query="GetUserTypes"> 
					        <cfif '#GetUserTypes.UserTypeID#' eq #UserTypeID_Value#>
						        <option value="#GetUserTypes.UserTypeID#" selected>#GetUserTypes.UserType#</option>
					        <cfelse>
						        <option value="#GetUserTypes.UserTypeID#">#GetUserTypes.UserType#</option>
					        </cfif>
				      </cfoutput> 
				  </select>
				  <CFOUTPUT>
                </TD>
              </TR>

            </TABLE>

<p></p>	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>
	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

