      <link rel="stylesheet" type="text/css" media="all" href="daterangepicker-bs3.css" />
      <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
      <script type="text/javascript" src="daterangepicker.js"></script>
      
      
<table align="center" width="80%" border="0">
      	<tr>
		<td>
			<table width="100%">
			  <tr valign="top"> 
			    <td align="center"><h2>Start Date.</h2></td>
			  </tr>
			</table>
			
			<!--- - create a date based on the first day of the current month and year - --->
			<cfset local.cDate=dateAdd('m',session.monthCal,createDate(year(now()),month(now()),01))>
			<cfset local.fromYear=year(now())-10>
			<cfset local.toYear=year(now())+5>
			<!--- - start caledar title - --->
			<table align="center" border="0" cellpadding="0" cellspacing="0">
				<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
				<tr>
					<td class="month"><select id="calMonth1" name="calMonth1" onchange="changeMonth1('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"mm")#</cfoutput>');">
							<cfloop from="1" to="12" index="i">
								<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"mm") EQ i> selected="selected"</cfif>><cfoutput>#monthAsString(i)#</cfoutput></option>
							</cfloop>	
						</select>
						<select id="calYear1" name="calYear1" onchange="changeYear1('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"yyyy")#</cfoutput>');">
							<cfloop from="#local.fromYear#" to="#local.toYear#" index="i">
								<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"yyyy") EQ i> selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
							</cfloop>	
						</select><br />
					<cfoutput>#dateFormat(local.cDate,"mmmm yyyy")#</cfoutput></td>
				</tr>
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
							<td align="center" class="normal_body"><a<cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="javaScript:void(0);"  onclick="placeDate('start','<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>','<cfoutput>#local.formName#</cfoutput>');"><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td>
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
		</td>
		<td>
			<table width="100%">
			  <tr valign="top"> 
			    <td align="center"><h2>End Date.</h2></td>
			  </tr>
			</table>
			
			<!--- - create a date based on the first day of the current month and year - --->
			<cfset local.cDate=dateAdd('m',session.monthCalTo,createDate(year(now()),month(now()),01))>
			<!--- - start caledar title - --->
			<table align="center" border="0" cellpadding="0" cellspacing="0">
				<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
				<tr>
					<td class="month"><select id="calMonth2" name="calMonth2" onchange="changeMonth2('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"mm")#</cfoutput>');">
							<cfloop from="1" to="12" index="i">
								<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"mm") EQ i> selected="selected"</cfif>><cfoutput>#monthAsString(i)#</cfoutput></option>
							</cfloop>	
						</select>
						<select id="calYear2" name="calYear2" onchange="changeYear2('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"yyyy")#</cfoutput>');">
							<cfloop from="#local.fromYear#" to="#local.toYear#" index="i">
								<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"yyyy") EQ i> selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
							</cfloop>	
						</select><br />
					<cfoutput>#dateFormat(local.cDate,"mmmm yyyy")#</cfoutput></td>
				</tr>
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
							<td align="center" class="normal_body"><a<cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="javaScript:void(0);"  onclick="placeDate('end','<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>','<cfoutput>#local.formName#</cfoutput>');"><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td>
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
					<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?posTo=bwdTo"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&lt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
					<td class="cal_days" colspan="5"><img src="../images/s.gif" width="1" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?posTo=fwdTo"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&gt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center"><span id="startDate"></span>&nbsp;<span class="error" id="startMsg"></span></td>
		<input id="sDate" name="sDate" type="hidden" value="0" />
		<td align="center"><span id="endDate"></span>&nbsp;<span class="error" id="endMsg"></span></td>
		<input id="eDate" name="eDate" type="hidden" value="0" />
	</tr>
</table>
