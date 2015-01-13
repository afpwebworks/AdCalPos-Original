
<cfsetting enablecfoutputonly="Yes">
<!--- This example shows the use of DateConvert --->
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmDateConvert">
<cfset local.page="dateconvert.cfm">

<!--- This example shows the use of DateConvert --->
<cfsetting enablecfoutputonly="No">
<HTML>
<HEAD>
<TITLE>DateConvert Example</TITLE>
<link rel="stylesheet" type="text/css" href="css/calendar.css">
</HEAD>

<basefont face="Arial, Helvetica" size=2>
<!--- - wb 06/01/2004 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check1.js" type="text/javascript"></script>
<body  bgcolor="#FFFFD5">

<H3>DateConvert Example</H3>

<!--- This part of the example shows the conversion of the current date
        and time to UTC time and back again. --->

<CFSET curDate = Now()>
<P><CFOUTPUT>The current date and time: #curDate#. </CFOUTPUT></P>
<CFSET utcDate = DateConvert("local2utc", curDate)>
<CFOUTPUT>
    <P>The current date and time converted to UTC time: #utcDate#.</P> 
</CFOUTPUT> 

<!--- This code checks to see if the form was submitted. 
      If it was submitted the code generates the CFML date with the 
CreateDateTime function. --->    

<CFIF IsDefined("FORM.submit")>
    <CFSET yourDate = CreateDateTime(left(form.sDate,4),mid(form.sDate,5,2),right(form.sDate,2), 
form.hour,form.minute,form.second)>
    <P><CFOUTPUT>Your date value, presented as a ColdFusion date-time 
string:#yourdate#.</CFOUTPUT></P>
    <CFSET yourUTC = DateConvert("local2utc", yourDate)>
    <P><CFOUTPUT>Your date and time value, converted into Universal 
Coordinated Time (UTC): #yourUTC#.</CFOUTPUT></P>
    <P><CFOUTPUT>Your UTC date and time, converted back to local date and 
time: #DateConvert("utc2local", yourUTC)#.</CFOUTPUT></P>
<CFELSE>
    Type the date and time, and press Enter to see the conversion.
</CFIF>    
    

<Hr size="2" color="#0000A0">

<FORM ACTION="dateconvert.cfm" id="frmDateConvert" METHOD="POST" name="frmDateConvert" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<P>Please select the date value you would like to view:

<cfinclude template="CalendarDisplay1.cfm">
<br />
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Hour</td>
    <td><INPUT TYPE="Text" NAME="hour" VALUE="16" RANGE="0,23" 
MESSAGE="You must enter an hour (0-23)" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
<tr>
    <td>Minute</td>
    <td><INPUT TYPE="Text" NAME="minute" VALUE="12" RANGE="0,59" 
MESSAGE="You must enter a minute value (0-59)" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
<tr>
    <td>Second</td>
    <td><INPUT TYPE="Text" NAME="second" VALUE="0" RANGE="0,59" 
MESSAGE="You must enter a value for seconds (0-59)" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
<tr>
    <td><INPUT TYPE="Submit" NAME="submit" VALUE="Submit"></td>
    <td><INPUT TYPE="RESET"></td>
</tr>
</table>

</BODY>
</HTML>

