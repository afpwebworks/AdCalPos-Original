<cfsilent>
<!----
==========================================================================================================
Filename:     CalendarParse3.cfm
Description:  Parses the values from the datepicker into the format used by legacy form processors
Date:         20/03/2014
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
</cfsilent>
<!--------[  parse the form.daterange variable into start and end dates  - MK ]------>
<!--------[  If the user has only selected a single day, correct the form.daterange variable to use a single day  - MK ]------>
<cfif len(form.daterange) lt "12">
  <cfset form.daterange = form.daterange & " -to- " & form.daterange >
</cfif>
<cfscript>
	form.startdate = left( form.daterange, "10");
	form.enddate =   right( form.daterange, "10");
	session.startday = left( form.daterange, "2"); ;
	session.startmonth = mid(form.daterange, "4", "2");
	session.startyear = mid(form.daterange, "7", "4");
	session.endday = mid(form.daterange, "17", "2");;
	session.endmonth = mid(form.daterange, "20", "2");
	session.endyear = mid(form.daterange, "23", "4");
	session.daterange = form.daterange;
	form.calyear1 =  datepart("yyyy", form.startdate);
	form.calyear2 =  datepart("yyyy", form.enddate);
	form.calmonth1 = datepart("m", form.startdate);
	form.calmonth2 = datepart("m", form.enddate);
	form.edate =     session.endyear & session.endmonth & session.endday;
	form.sdate =     session.startyear & session.startmonth & session.startday;
	session.enddate = form.edate;
	session.startdate= form.sdate;
</cfscript>
