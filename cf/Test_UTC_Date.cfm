
<!--- This example shows the use of DateConvert --->

<HTML>
<HEAD>
<TITLE>DateConvert Example</TITLE>
</HEAD>

<basefont face="Arial, Helvetica" size=2>

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
    <CFSET yourDate = CreateDateTime(FORM.year, FORM.month, FORM.day, 
FORM.hour,FORM.minute, FORM.second)>
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

<FORM ACTION="dateconvert.cfm" METHOD="POST">
<P>Please enter the year, month and day in integer format for 
the date value you would like to view:


<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Year</td>
    <td><INPUT TYPE="Text" NAME="year" VALUE="1998" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
<tr>
    <td>Month</td>
    <td><INPUT TYPE="Text" NAME="month" VALUE="6" RANGE="1,12" 
MESSAGE="Please enter a month (1-12)" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
<tr>
    <td>Day</td>
    <td><INPUT TYPE="Text" NAME="day" VALUE="8" RANGE="1,31" 
MESSAGE="Please enter a day of the month (1-31)" VALIDATE="integer" 
REQUIRED="Yes"></td>
</tr>
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

