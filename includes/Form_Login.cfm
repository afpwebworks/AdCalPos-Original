<cfsilent>
<!----
==========================================================================================================
Filename:     Form_Login.cfm
Description:  Login form for AFP Cms v3.0
Date:         27/1/2006
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<cfparam name="session.loginerrormessage" default="" />
<cfparam name="request.pagename" default="Please Log in">
</cfsilent>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Please Log in</title>
<link rel="stylesheet" type="text/css" href="/css/CMSStyles.css">
<link rel="stylesheet" type="text/css" href="/css/FormStyles.css"/>
<link rel="stylesheet" type="text/css" href="/css/CMSColours.css"/>
<link rel="stylesheet" type="text/css" href="/cf/costi.css">
<script language="JavaScript">
  <!--
	 function SetTheFocus(){
	  document.frmLogin.UserLogin.focus();	
     }
  -->
</script>
</head>
<body id="cms">
<cfoutput>
<div align="center"> <img src="/images/LogoSignOnTop.png" width="714" height="145">
  <fieldset class="CMSForm" style="width:350px;min-width:350px;">
    <legend>Please log in</legend>
    <cfif len(session.loginerrormessage) Gt "1">
      <ul>
        #session.loginerrormessage#
      </ul>
    </cfif>
    <form name="frmLogin" method="post" action="/cf/frmLogin_Action.cfm">
      <!--- KF 020103<form name="frmLogin" method="post" action="cf/frmLogin_Action.cfm"> --->
      <div class="form-row">
        <label for="UserLogin">User Name</label>
        <input type="text" name="UserLogin" id="UserLogin">
      </div>
      <div class="form-row">
        <label for="UserPassword">Password</label>
        <input type="password" id="UserPassword" name="UserPassword">
      </div>
      <div class="form-row">
        <input type="submit" name="submit" value="            Enter.          ">
        <input type="reset" name="cancel" value="         Cancel         ">
      </div>
    </form>
  </fieldset>
  <img src="/images/Login1.jpg" width="714" height="389" style="border:2px solid red;"> </div>
</cfoutput>
</body>
</html>
<cfif application.siteversion eq "development">
  <cfdump var="#session.user.getsnapshot()#">
  <cfdump var="#session#">
</cfif>
