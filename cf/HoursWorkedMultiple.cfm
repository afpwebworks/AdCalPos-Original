

<CFOUTPUT>
 
<CFSET weekEndingDateDDMMYYYY = '#listGetAt(weekEndingDate,3,"-")##listGetAt(weekEndingDate,2,"-")##listGetAt(weekEndingDate,1,"-")#'>

<CFSET allWeekdates = "">
<CFLOOP from="0" to="6" index="dayLoop">
   <CFSET thisDateBadFormat = #dateAdd('d',-dayLoop,weekEndingDate)#>
<!---    #thisDateBadFormat#<br> --->
   <CFSET thisLoopDate  = #dateFormat(thisDateBadFormat,"ddmmyyyy")#>
   <CFSET allWeekdates = #listAppend(allWeekdates,thisLoopDate)#>
</cfloop>


<!--- #allWeekdates# --->
</cfoutput>

<cfset strPageTitle = "Hours Worked - Historical">

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
<!--- 
<CFSET strDateField = ''>
<CFSET strDateWE = ''>
<CF_GetWeekEnding>

<cfset strDateField="">
<cf_GetWeekDay baseDate="#strDateToday#" >
 --->
 
 <!--- 
<BR><cfoutput>strDateToday: #strDateToday#</cfoutput>
<BR><cfoutput>strDateField: #strDateField#</cfoutput>
<BR><cfoutput>strDateWE: #strDateWE#</cfoutput>
 --->
<cfset lngStoreID = #session.storeid#>


	<cfset strQuery = "SELECT tblEmpRoster.RosterID, tblEmpRoster.EmployeeID, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.*">
	<cfset strQuery = strQuery & "FROM tblEmpRoster ">
<!--- 		
<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#weekEndingDateDDMMYYYY#' ))  "> 
--->

 	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#weekEndingDateDDMMYYYY#' )  ">
 	<cfset strQuery = strQuery & "AND ((tblEmpRoster.DatePaid)='' Or (tblEmpRoster.DatePaid) Is Null)  )"> 

	<CFQUERY name="CheckRoster" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset allIDs = valueList(CheckRoster.employeeID)>

	<CFIF len(allIDs) is 0>
	   There are no employees rostered for this week at this store
	   <cfabort>
	</cfif>
	
<!--- 	<cfoutput Query = "CheckRoster"> --->
		<CFSET lngEmpID = #CheckRoster.EmployeeID# >
		<!--- <CFSET strRosterStart = #CheckRoster.RosterStart# >
		<CFSET strRosterEnd = #CheckRoster.RosterEnd# >			 --->
	    <!--- Check to see if this line exist in the employee hours worked or not ---> 
		<!--- <cfset strQuery = "SELECT tblEmpHoursWorked.HoursWorkedID, tblEmpHoursWorked.WeekEnding, tblEmpHoursWorked.EmployeeID, tblEmpHoursWorked.StoreID, tblEmpHoursWorked.DateWorked, tblEmpHoursWorked.StartTime, tblEmpHoursWorked.EndTime, tblEmpHoursWorked.StartRoster, tblEmpHoursWorked.EndRoster "> --->
	    <cfset strQuery = "SELECT [GivenName] + ' ' + [Surname] AS FullName, CAST(substring([dateworked],5,4)  + '/' + substring([dateworked],3,2)   + '/' +  substring([dateworked],1,2) AS Datetime)  , *">		
		<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
		<cfset strQuery = strQuery & ",    tblEmployee ">		
		<cfset strQuery = strQuery & "where tblEmpHoursWorked.employeeID = tblEmployee.employeeID ">
		<cfset strQuery = strQuery & "and tblEmpHoursWorked.storeID = tblEmployee.storeID ">
		<cfset strQuery = strQuery & "AND (((tblEmpHoursWorked.EmployeeID ) in (#allIDs#) ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked) IN (#preservesinglequotes(allWeekdates)#)   ))">
		<cfset strQuery = strQuery & "ORDER BY [GivenName] + ' ' + [Surname],2">
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CheckHoursWorked" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

<cfset strEODFinished = "">	

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
      <h2><cfoutput>#session.storename# #strPageTitle# <BR>Week ending #dateFormat(weekEndingDate,"dd/mm/YYYY")#</cfoutput></h2>
    </td>
    <td width="25%"> 
       <div align="right"><a href="HoursWorkedMultiSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<!--- 
<!--- Write down the data --->
<cfoutput>


<cfif isdefined("URL.MN")>
  <input type="hidden" name="lngMN" value="#URL.MN#">	
</cfif>
  <FORM action="HoursWorkedActionB.cfm" method="post">
	  <input type="hidden" name="allIDs" value="#allIDs#">	
	  <input type="hidden" name="allWeekdates" value="#allWeekdates#">	
	  <input type="hidden" name="WeekEndingDate" value="#weekEndingDateDDMMYYYY#">	
	  <input type="hidden" name="lngStoreID" value="#lngStoreID#">		  
	  <input type="hidden" name="strStoreName" value="#session.storename#">		
	  <input type="hidden" name="lngNumRecords" value="#GetRecord.RecordCount#">			  
	  <cfif #GetRecord.RecordCount# GT 0>
		  <tr>
		  	<!--- <TD><input type="submit" name="Submit" value="  Save  "></td> --->
		  	<TD COLSPAN="2"><input type="BUTTON" onClick="this.form.action='populateHoursWorkedBlanks.cfm';this.form.submit()" name="AddButton" value="  Add  "></td>	
		  </tr>  
	  </cfif>
  </form>
</cfoutput>
 --->
 
<h3>Employess yet to be paid</h3>
 
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="95%" border="1" cellspacing="0">
  <tr> 
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Name</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Date</font></b></div>
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
  <CFSET thisUser = "">
  
  <FORM action="HoursWorkedMultipleAction.cfm" method="post">
    <CFOUTPUT>
 	  <input type="hidden" name="weekEndingDate" value="#weekEndingDate#">	
	</cfoutput>  
			<!---  <input type="hidden" name="WeekEndingDate" value="#weekEndingDateDDMMYYYY#">	
		  <input type="hidden" name="lngStoreID" value="#lngStoreID#">		  
		  <input type="hidden" name="strStoreName" value="#session.storename#">		 --->
  <cfoutput Query ="GetRecord">    <cfset lngLineNumber = #GetRecord.CurrentRow#>	
	<CFIF employeeId is not thisUser>
	    <CFIF lngLineNumber gt 1>
		  		<TR height="20" bgcolor="##dddddd"><TD colspan ="11">
				   <!--- <INPUT type="SUBMIT" value="Save All"> --->
				</td></tr>	     	
		</cfif>
		<CFIF datePaid is ""><CFSET hasBeenPaid = false><CFELSE><CFSET hasBeenPaid = true></cfif>
	</cfif>	

<!---   <CFIF not hasBeenPaid> --->
    <!--- not been paid yet, so allow edit --->
	  
	  <tr> 
	    <td>
			<CFIF thisUser is not employeeID>	
			   <font face="Tahoma" size="2"><b>#GetRecord.FullName#</b></font>
			</cfif>
		</td>	
	    <td>
			<font face="Tahoma" size="2"><b>#MID(dateWorked,1,2)#/#MID(dateWorked,3,2)#/#MID(dateWorked,5,4)#</b></font>
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
				<cfif #GetRecord.OtherTimeType# EQ 'SK'><option value="SK" selected>Sick</option><cfelse><option value="SK">Sick</option></cfif>
				<cfif #GetRecord.OtherTimeType# EQ 'LV'><option value="LV" selected>Leave</option><cfelse><option value="LV">Leave</option></cfif>
			</select>
		</td>	
	    <td> 
	      <input type="text" name="Entitlement_Time_From_Line#lngLineNumber#" value="#GetRecord.OtherStartTime#" maxlength="4" size="5">    
	      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_required" value = "Please type entitlement start time for line #lngLineNumber#">
	      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_integer" value = "Please type entitlement start time for line #lngLineNumber#">
	      <INPUT type="hidden" name="Entitlement_Time_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
	    </td>
	    <td> 
	      <input type="text" name="Entitlement_Time_To_Line#lngLineNumber#" value="#GetRecord.OtherEndTime#" maxlength="4" size="5">    
	      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_required" value = "Please type entitlement finish time for line #lngLineNumber#">
	      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_integer" value = "Please type entitlement finish time for line #lngLineNumber#">
	      <INPUT type="hidden" name="Entitlement_Time_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
	    </td>	 
	   </tr>
   
  
   <CFSET thisUser = employeeID><CFSET actualName=getRecord.fullName>
  </cfoutput>
  <CFOUTPUT>
    <TR  bgcolor="##dddddd"><TD colspan ="11"><INPUT type="SUBMIT" value="Save All"></td></tr>
   </FORM>
</table>
<table width="95%" border="0" cellspacing="0">
  <tr>
  	<TD>&nbsp;</td>
  </tr>  
	  <FORM action="HoursWorkedActionB.cfm" method="post">
		  <input type="hidden" name="allIDs" value="#allIDs#">	
		  <input type="hidden" name="allWeekdates" value="#allWeekdates#">	
		  <input type="hidden" name="WeekEndingDate" value="#weekEndingDateDDMMYYYY#">	
		  <input type="hidden" name="lngStoreID" value="#lngStoreID#">		  
		  <input type="hidden" name="strStoreName" value="#session.storename#">		
		  <input type="hidden" name="lngNumRecords" value="#GetRecord.RecordCount#">			  
<!--- 		  <cfif #GetRecord.RecordCount# GT 0> --->
			  <tr>
			  	<TD COLSPAN="2"><input type="BUTTON" onClick="this.form.action='populateHoursWorkedBlanks.cfm';this.form.submit()" name="AddButton" value="  Add  "></td>	
			  </tr>  
<!--- 		  </cfif> --->
	  </form>
  <tr>
  	<TD><h3>Please do not forget to save your entries</h3></td>
  </tr>  
</table>
  </cfoutput>		 
      </div>
    </td>
  </tr>
</table>




<h3>Employess paid already</h3>



<cfset strQuery = "SELECT tblEmpRoster.RosterID, tblEmpRoster.EmployeeID, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.*">
<cfset strQuery = strQuery & "FROM tblEmpRoster ">
	<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)= #lngStoreID# ) AND ((tblEmpRoster.WeekEnding)= '#weekEndingDateDDMMYYYY#' )  ">
	<cfset strQuery = strQuery & "AND NOT ((tblEmpRoster.DatePaid)='' Or (tblEmpRoster.DatePaid) Is Null)  )"> 

<CFQUERY name="CheckPaidRoster" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset allPaidIDs = valueList(CheckPaidRoster.employeeID)>

   <CFIF CheckPaidRoster.recordCount is 0>
	<table width="95%" border="1" cellspacing="0" align="CENTER">
	  <tr> 
	    <td> 
	      <div align="center"><b><font face="Tahoma" size="2">No employees have been paid</font></b></div>
	    </td>
	  </tr>
	 </TABLE>     
    </BODY>
   </HTML>
   <cfabort>   
 </cfif>

	<CFSET lngEmpID = #CheckRoster.EmployeeID# >
    <cfset strQuery = "SELECT [GivenName] + ' ' + [Surname] AS FullName, CAST(substring([dateworked],5,4)  + '/' + substring([dateworked],3,2)   + '/' +  substring([dateworked],1,2) AS Datetime)  , *">		
	<cfset strQuery = strQuery & "FROM tblEmpHoursWorked ">
	<cfset strQuery = strQuery & ",    tblEmployee ">		
	<cfset strQuery = strQuery & "where tblEmpHoursWorked.employeeID = tblEmployee.employeeID ">
	<cfset strQuery = strQuery & "and tblEmpHoursWorked.storeID = tblEmployee.storeID ">
	<cfset strQuery = strQuery & "AND (((tblEmpHoursWorked.EmployeeID ) in (#allPaidIDs#) ) AND ((tblEmpHoursWorked.StoreID)= #lngStoreID# ) AND ((tblEmpHoursWorked.DateWorked) IN (#preservesinglequotes(allWeekdates)#)   ))">
	<cfset strQuery = strQuery & "ORDER BY [GivenName] + ' ' + [Surname], 2">
	<CFQUERY name="GetPaidRecord" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

<cfset strEODFinished = "">	

<table width="95%" border="1" cellspacing="0" align="CENTER">
  <tr> 
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Name</font></b></div>
    </td>
    <td> 
      <div align="center"><b><font face="Tahoma" size="2">Date</font></b></div>
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
  <CFSET thisUser = "">
  <cfoutput Query ="GetPaidRecord">    <cfset lngLineNumber = #GetRecord.CurrentRow#>	
	<CFIF employeeId is not thisUser>
	    <CFIF lngLineNumber gt 1>
		  		<TR height="20" bgcolor="##dddddd"><TD colspan ="11">
				</td></tr>	     	
		</cfif>
		<CFIF datePaid is ""><CFSET hasBeenPaid = false><CFELSE><CFSET hasBeenPaid = true></cfif>
	</cfif>	
	  <tr> 
	    <td>
			<CFIF thisUser is not employeeID>	
			   <font face="Tahoma" size="2">#GetPaidRecord.FullName#</font>
			</cfif>
		</td>	
	    <td>
			<font face="Tahoma" size="2">#MID(dateWorked,1,2)#/#MID(dateWorked,3,2)#/#MID(dateWorked,5,4)#</font>
		</td>
	    <td> <font face="Tahoma" size="2">
	      #GetPaidRecord.StartTime#</font>
	    </td>
	    <td> <font face="Tahoma" size="2">
	      #GetPaidRecord.EndTime#</font>
	    </td>	  
	    <td>
			<font face="Tahoma" size="2">#GetPaidRecord.StartRoster#</font>
		</td>
	    <td>
			<font face="Tahoma" size="2">#GetPaidRecord.EndRoster#</font>
		</td>
	    <td> <font face="Tahoma" size="2">
	      #GetPaidRecord.Bonus#</font>
	    </td>
	    <td> <font face="Tahoma" size="2">
	      #GetPaidRecord.Expenses#</font>
	    </td>	  
		<td align="center" valign="top">
		   <font face="Tahoma" size="2">
				<cfif #GetPaidRecord.OtherTimeType# EQ 'NA'>NA</cfif>
				<cfif #GetPaidRecord.OtherTimeType# EQ 'SK'>Sick</cfif>
				<cfif #GetPaidRecord.OtherTimeType# EQ 'LV'>Leave</cfif>
				</font>
		</td>	
	    <td>
		 <font face="Tahoma" size="2">
	      #GetPaidRecord.OtherStartTime#
		 </font> 
	    </td>
	    <td>
		 <font face="Tahoma" size="2">
	      #GetPaidRecord.OtherEndTime#
		 </font>
	    </td>	 
	   </tr>
	   <CFSET thisUser = employeeID>
   </cfoutput>   
</table>

</body>
</HTML>

