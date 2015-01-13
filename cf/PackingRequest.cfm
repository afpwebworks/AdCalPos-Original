
<cfsetting enablecfoutputonly="Yes">
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmPackingRequest">
<cfset local.page="PackingRequest.cfm">
<cfsetting enablecfoutputonly="No">

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
	<TITLE>Packing Request</TITLE>
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
<!--- - wb 23/02/2004 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check1.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar1.js" type="text/javascript"></script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Packing Request</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
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


<CFSET strDateToday = ''>
<CF_GetTodayDate>

<!--- Get the order dates --->
<cfset strQuery = "SELECT OrderDate ">
<cfset strQuery = strQuery & "FROM qryOrderDatesB">

<CFQUERY name="GetOrderDates" datasource="#application.dsn#" > 
<!--- <CFQUERY  name="GetOrderDates" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset local.lsDates="">
<!--- - wb 23/02/2004 - setup date list - --->
<cfloop query="GetOrderDates">
	<cfset local.lsDates=listAppend(local.lsDates,createDate(right(GetOrderDates.OrderDate,4),mid(GetOrderDates.OrderDate,3,2),left(GetOrderDates.OrderDate,2)),",")>
</cfloop>
<!--- <cfoutput>#local.lsDates#</cfoutput> --->
<p><h3>Please select the order date.</h3></P>
<FORM action="PackingActionA.cfm" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
        <!--- - create a date based on the first day of the current month and year - --->
		<cfset local.cDate=dateAdd('m',session.monthCal,createDate(year(now()),month(now()),01))>
		<cfset local.fromYear=year(now())-10>
		<cfset local.toYear=year(now())+5>
		<!--- - start caledar title - --->
		<table border="0" cellpadding="0" cellspacing="0">
			<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
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
		<table border="1" bordercolor="#4B4B4B" cellpadding="2" cellspacing="0">
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
					<cfif local.dateCount LTE daysInMonth(local.cDate) 
							AND dayOfWeek(createDate(year(local.cDate),month(local.cDate),local.dateCount)) EQ local.cCount>
						<cfset local.dateCheck=createDate(year(local.cDate),month(local.cDate),local.dateCount)>
						<!--- - place the an active number - --->
						<td align="center" class="normal_body"><a<cfif listFind(local.lsDates,local.dateCheck,",") EQ 0> <cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())>class="today"<cfelse>class="cal_disabled"</cfif> onclick="javascript:void(0);"<cfelse><cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="javaScript:void(0);"  onclick="placeDate('start','<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>','<cfoutput>#local.formName#</cfoutput>');"</cfif>><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td>
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
				<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?pos=bwd"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&lt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
				<td class="cal_days" colspan="5"><img src="../images/s.gif" width="1" height="1" alt="spacer" border="0" /></td>
				<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?pos=fwd"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&gt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
			</tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
			<tr><td align="center" colspan="3"><span id="date"></span>&nbsp;<span class="error" id="msg"></span></td></tr>
			<input id="sDate" name="sDate" type="hidden" value="0" />
		</table>
<p></P>
<input type="submit" name="Submit" value=" Next ">
</Form>
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

