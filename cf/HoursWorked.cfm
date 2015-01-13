
<CFIF ParameterExists(Form.cmbDateSelected)>
	<CFSET strDateToday = '#Form.cmbDateSelected#'>
	<CFIF Len(strDateToday) LT 8 >
		<CFSET strDateToday = '0' & '#strDateToday#'>		
	</cfif>
<cfelseif ParameterExists(URL.CDS)>
	<CFSET strDateToday = '#URL.CDS#'>
	<CFIF Len(strDateToday) LT 8 >
		<CFSET strDateToday = '0' & '#strDateToday#'>		
	</cfif>
<cfelse>
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
</cfif>

<!--- <CFSET strDateToday="26012004"> --->
<!--- KF amendment, show report date, not current date --->
<CFSET strDateReport = strDateToday>
<!--- end --->

<cfset strPageTitle = "Hours Worked">

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
		<CFLOCATION url="frmLogin.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="frmLogin.htm">
</CFIF>


<CFSET strDateField = ''>
<CFSET strDateWE = ''>
<CF_GetWeekEnding>



<cfset strDateField="">
<cf_GetWeekDay baseDate="#strDateToday#" >



<!--- 
<BR><cfoutput>strDateToday: #strDateToday#</cfoutput>
<BR><cfoutput>strDateField: #strDateField#</cfoutput>
<BR><cfoutput>strDateWE: #strDateWE#</cfoutput>
 --->
<cfset lngStoreID = #session.storeid#>

	<cfset strQuery = "SELECT tblEmpRoster.RosterID, tblEmpRoster.EmployeeID, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.#strDateField#Start AS RosterStart, tblEmpRoster.#strDateField#End AS RosterEnd ">
	<cfset strQuery = strQuery & "FROM tblEmpRoster ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#strDateWE#' )  AND ((tblEmpRoster.DatePaid)='' Or (tblEmpRoster.DatePaid) Is Null)  )">
	<CFQUERY name="CheckRoster" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="CheckRoster" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfoutput Query = "CheckRoster">
		<CFSET lngEmpID = #CheckRoster.EmployeeID# >
		<CFSET strRosterStart = #CheckRoster.RosterStart# >
		<CFSET strRosterEnd = #CheckRoster.RosterEnd# >			
	    <!--- Check to see if this line exist in the employee hours worked or not ---> 
		<cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster ">
		<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
		<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.EmployeeID)= #lngEmpID# ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ))">
		<CFQUERY name="CheckHoursWorked" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckHoursWorked.RecordCount# LT 1>
			<!--- Add the information from the roster to hours worked --->
			<cfset strQuery = "INSERT INTO tblEmpHoursWorked ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster ) ">
			<cfset strQuery = strQuery & "Values ('#strDateWE#', #lngEmpID# , #lngStoreID# , '#strDateToday#' , '#strRosterStart#' , '#strRosterEnd#'  , '#strRosterStart#' , '#strRosterEnd#' )">
			<CFQUERY name="InsertDataIntoHoursWorked" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="InsertDataIntoHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
	</cfoutput>
	
<cfset strQuery = "SELECT [GivenName] + ' ' + [Surname] AS FullName, tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster, tblEmpHoursWorked.DatePaid, tblEmpHoursWorked.OtherStartTime, tblEmpHoursWorked.OtherEndTime, tblEmpHoursWorked.OtherTimeType, tblEmpHoursWorked.Bonus, tblEmpHoursWorked.Expenses ">
<cfset strQuery = strQuery & ",status ">
<cfset strQuery = strQuery & "FROM tblEmpHoursWorked INNER JOIN tblEmployee ON tblEmpHoursWorked.EmployeeID = tblEmployee.EmployeeID ">
<cfset strQuery = strQuery & "                       INNER JOIN tblEmpStatus ON tblEmpStatus.EmpStatusID = tblEmployee.EmpStatusID ">
<cfset strQuery = strQuery & "WHERE (((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked)= '#strDateToday#' ) AND ((tblEmpHoursWorked.DatePaid) Is Null)) ">
<cfset strQuery = strQuery & "ORDER BY status, [GivenName] + ' ' + [Surname]">
<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>



<!--- If end of day has finished then do not continue --->
<cfset strEODFinished = "">	

<!--- KF, cf_ doesn't pass thru variables, use CFINCLUDE natation instead 
<cf_GetEndOfDayFinished>
--->
<CFINCLUDE template="GetEndOfDayFinished.cfm">


<cfif strEODFinished EQ "Y">
	<BR>End of day process has finished for today.  You can not add or edit any records today.
	<cfabort>
</cfif>

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
 	<td colspan="2"> 
      <h2><cfoutput>
	  #session.storename# #strPageTitle# #mid(strDateReport,1,2)#/#mid(strDateReport,3,2)#/#mid(strDateReport,5,4)# </cfoutput></h2>
	  	  
	  <!--- #session.storename# #strPageTitle# #mid(strDateToday,1,2)#/#mid(strDateToday,3,2)#/#mid(strDateToday,5,4)# </cfoutput></h2> --->
    </td>
    <td width="25%"> 
	  <cfif isdefined("URL.MN")>
	      <div align="right"><a href="HoursWorkedSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
	  <cfelse>
	      <div align="right"><a href="EndOfDay.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
	  </cfif>
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="HoursWorkedActionB.cfm" method="post">
<!--- Write down the date --->
<cfoutput>
<input type="hidden" name="strDateToday" value="#strDateToday#">	
<input type="hidden" name="strDateField" value="#strDateField#">	
<!--- kf amendment, Jan 25 '04, save and reload report date not current date --->
<input type="hidden" name="strDateReport" value="#strDateReport#">	
<!--- end --->
<input type="hidden" name="strDateWE" value="#strDateWE#">	
<input type="hidden" name="lngStoreID" value="#lngStoreID#">		
<input type="hidden" name="strStoreName" value="#session.storename#">		
<input type="hidden" name="lngNumRecords" value="#GetRecord.RecordCount#">	
<cfif isdefined("URL.MN")>
<input type="hidden" name="lngMN" value="#URL.MN#">	
</cfif>
</cfoutput>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="95%" border="1" cellspacing="0">
  <tr> 
  
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Status</font></b></div>
    </td>

  
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Name</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Finish</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Roster Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Roster Finish</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Bonus</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Expense</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitlement</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitle Start</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Entitle Finish</font></b></div>
    </td>
  </tr>
  <cfoutput Query ="GetRecord">
  <CFSET isCasual=false>
  <CFIF FIND('Casual',GetRecord.status,1)>
    <CFSET isCasual=true>
  </cfif>   
  <cfset lngLineNumber = #GetRecord.CurrentRow#>	
  <tr> 
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">#getRecord.Status#</font></b></div>
    </td>

    <td>
		<font face="Tahoma" size="2"><b>#GetRecord.FullName#</b></font>
	</td>
    <td> 
      <INPUT type="hidden" name="RosterID_Line#lngLineNumber#" value = "#GetRecord.HoursWorkedID#">

      <input type="text" name="Time_From_Line#lngLineNumber#" value="#GetRecord.StartTime#" maxlength="4" size="5">    
      <INPUT type="hidden" name="Time_From_Line#lngLineNumber#_required" value = "Please type start time for line #lngLineNumber#">
      <INPUT type="hidden" name="Time_From_Line#lngLineNumber#_integer" value = "Please type start time for line #lngLineNumber#">
      <INPUT type="hidden" name="Time_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    </td>
    <td> 
      <input type="text" name="Time_To_Line#lngLineNumber#" value="#GetRecord.EndTime#" maxlength="4" size="5">    
      <INPUT type="hidden" name="Time_To_Line#lngLineNumber#_required" value = "Please type finish time for line #lngLineNumber#">
      <INPUT type="hidden" name="Time_To_Line#lngLineNumber#_integer" value = "Please type finish time for line #lngLineNumber#">
      <INPUT type="hidden" name="Time_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    </td>	  
    <td>
		<font face="Tahoma" size="2"><b>#GetRecord.StartRoster#</b></font>
	</td>
    <td>
		<font face="Tahoma" size="2"><b>#GetRecord.EndRoster#</b></font>
	</td>
    <td> 
      <input type="text" name="Bonus_Line#lngLineNumber#" value="#GetRecord.Bonus#" maxlength="6" size="6">    
      <INPUT type="hidden" name="Bonus_Line#lngLineNumber#_required" value = "Please type bonus for line #lngLineNumber#">
      <INPUT type="hidden" name="Bonus_Line#lngLineNumber#_float" value = "Please type bonus for line #lngLineNumber#">
      <INPUT type="hidden" name="Bonus_Line#lngLineNumber#_range" Value = "MIN=0 MAX=1000">
    </td>
    <td> 
      <input type="text" name="Expenses_Line#lngLineNumber#" value="#GetRecord.Expenses#" maxlength="6" size="6">    
      <INPUT type="hidden" name="Expenses_Line#lngLineNumber#_required" value = "Please type expense for line #lngLineNumber#">
      <INPUT type="hidden" name="Expenses_Line#lngLineNumber#_float" value = "Please type expense for line #lngLineNumber#">
      <INPUT type="hidden" name="Expenses_Line#lngLineNumber#_range" Value = "MIN=0 MAX=1000">
    </td>	  
	<td align="center" valign="top">
		<select name="EntType_Line#lngLineNumber#">
		   <cfif #GetRecord.OtherTimeType# EQ 'NA'><option value="NA" selected>NA</option><cfelse><option value="NA">NA</option></cfif>
		   <CFIF not isCasual> <!--- casual staff can't be paid sick/holiday pay --->
		  	  <cfif #GetRecord.OtherTimeType# EQ 'SK'><option value="SK" selected>Sick</option><cfelse><option value="SK">Sick</option></cfif>
			  <cfif #GetRecord.OtherTimeType# EQ 'LV'><option value="LV" selected>Leave</option><cfelse><option value="LV">Leave</option></cfif>
		   </cfif>	
		</select>
	</td>	
    <td> 
      <input <CFIF isCasual> onfocus="this.blur()"  </CFIF> type="text" name="Entitlement_Time_From_Line#lngLineNumber#" value="#GetRecord.OtherStartTime#" maxlength="4" size="5">    
      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_required" value = "Please type entitlement start time for line #lngLineNumber#">
      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_integer" value = "Please type entitlement start time for line #lngLineNumber#">
      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    </td>
    <td> 
      <input <CFIF isCasual> onfocus="this.blur()"  </CFIF> type="text" name="Entitlement_Time_To_Line#lngLineNumber#" value="#GetRecord.OtherEndTime#" maxlength="4" size="5">    
      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_required" value = "Please type entitlement finish time for line #lngLineNumber#">
      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_integer" value = "Please type entitlement finish time for line #lngLineNumber#">
      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    </td>	  


  </tr>
  </cfoutput>
</table>
<table width="95%" border="0" cellspacing="0">
  <tr>
  	<TD>&nbsp;</td>
  </tr>  
  
  <cfif #GetRecord.RecordCount# GT 0>
  <tr>
  	<TD><input type="submit" name="Submit" value="  Save  "></td>
  </tr>  
  </cfif>
  <tr>
  	<TD><h3>Please do not forget to save your entries</h3></td>
  </tr>  
</table>

      </div>
    </td>
  </tr>
</table>

</form>
</body>
</HTML>

