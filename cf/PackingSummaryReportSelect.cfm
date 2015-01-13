
<cfsetting enablecfoutputonly="yes">
<!--- - wb 04/02/2004 - Setup page title - --->
<cfset local.pageTitle="Packing Summary Report">
<!--- - wb 04/02/2004 - Setup calendar variables - --->
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmPackingSummaryReport">
<cfset local.page="PackingSummaryReportSelect.cfm">
<cfsetting enablecfoutputonly="no">



<!--- <?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> --->

<head>
	<title><cfoutput>#local.pageTitle#</cfoutput></title>
	<link rel="STYLESHEET" type="text/css" href="costi.css">
	<link rel="STYLESHEET" type="text/css" href="css/calendar.css">
	<script language="JavaScript1.2" src="../js/change_calendar1.js" type="text/javascript"></script>	
</head>

<body>

<cfinclude template="navbar_header_small.cfm">



<table width="100%">
  <tr valign="top"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td align="center"><h1><cfoutput>#local.pageTitle#</cfoutput></h1><br /></td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>



<!--- - wb 04/02/2004 - create a date based on the first day of the current month and year - --->
<cfset local.cDate=dateAdd('m',session.monthCal,createDate(year(now()),month(now()),01))>
<cfset local.fromYear=year(now())-10>
<cfset local.toYear=year(now())+5>

<form id="<cfoutput>#local.formName#</cfoutput>" name="<cfoutput>#local.formName#</cfoutput>">


<table align="center" border="0" cellpadding="0" cellspacing="0">
	<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
	
	<tr><td align="center"><h2>Please select a day.</h2></td></tr>
	<tr><td>&nbsp;</td></tr>
	
	<tr>
		<td class="month"><select id="calMonth" name="calMonth" onchange="changeMonth('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"mm")#</cfoutput>');">
			<cfloop from="1" to="12" index="i">
				<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"mm") EQ i> selected="selected"</cfif>><cfoutput>#monthAsString(i)#</cfoutput></option>
			</cfloop>	
		</select>
		<select id="calYear" name="calYear" onchange="changeYear('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"yyyy")#</cfoutput>');">
			<cfloop from="#local.fromYear#" to="#local.toYear#" index="i">
				<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"yyyy") EQ i> selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
			</cfloop>	
		</select></td>
	</tr>
	<tr><td><img src="../images/s.gif" width="1" height="5" alt="spacer" border="0" /></td></tr>
</table>



<!--- - start caledar title - --->
<table align="center" border="0" cellpadding="0" cellspacing="0">
	<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
	
	<tr><td class="month"><cfoutput>#dateFormat(local.cDate,"mmmm yyyy")#</cfoutput></td></tr>
	<tr><td><img src="../images/s.gif" width="1" height="5" alt="spacer" border="0" /></td></tr>
</table>	
<table align="center" border="1" bordercolor="#4B4B4B" cellpadding="2" cellspacing="0">
	<tr>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />S<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />M<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />T<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />W<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />T<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />F<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />S<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
	</tr>
	<!--- - start calendar - --->
	<tr><!--- - create counters for the calendar - --->
		<cfset local.dateCount=1>
		<cfset local.cCount=1>
		<cfset local.count=1>
		<!--- - create the calendar table - --->
		<cfloop from="1" to="42" index="i">
			<!--- - conditions for calendar construction and number placement in conjuction with the day of the week - --->
			<cfif local.dateCount LTE daysInMonth(local.cDate) AND dayOfWeek(createDate(year(local.cDate),month(local.cDate),local.dateCount)) EQ local.cCount>
				<cfset local.dateCheck=createDate(year(local.cDate),month(local.cDate),local.dateCount)>
				<!--- - place the an active number - ---> 
				<!--- <td align="center" class="normal_body"><a<cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="PackingSummaryReport.cfm?date=<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>"><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td> --->
				
				<td align="center" class="normal_body"><a<cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="PackingSummaryReportProdSelect.cfm?date=<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>"><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td> 
				
				<cfset local.dateCount=local.dateCount+1>
			<cfelse>
				<!--- - place a blank - --->
				<td class="normal_body">&nbsp;&nbsp;</td>
			</cfif>
			<cfif i/local.count EQ 7 AND i NEQ 42>
				</tr>
				<tr>
				<cfset local.cCount=0>
				<cfset local.count=local.count+1>
			</cfif>
			<cfset local.cCount=local.cCount+1>
		</cfloop>
	</tr>
	<tr>
		<td class="cal_days"><a href="PackingSummaryReportSelect.cfm?pos=bwd"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&lt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
		<td class="cal_days" colspan="5"><img src="../images/s.gif" width="1" height="1" alt="spacer" border="0" /></td>
		<td class="cal_days"><a href="PackingSummaryReportSelect.cfm?pos=fwd"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&gt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
	</tr>
</table>

</form>
</body>
</html>
