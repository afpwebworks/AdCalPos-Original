
<cfset strPageTitle = "Roster">

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
<!--- 
WeekEnding, SunStart, SunEnd, MonStart, MonEnd, TueStart, TueEnd, WedStart, WedEnd, ThuStart, ThuEnd, FriStart, FriEnd, SatStart, SatEnd
--->
<cfset strDate = "#URL.D#">
<cfif #len(strDate)# LT 8>
	<cfset strDate = "0" & #strDate#>
</cfif> 

<cfset strWeekEnding = "#mid(strDate,1,2)#/#mid(strDate,3,2)#/#mid(strDate,5,4)#">

<cfset lngStoreID = #session.storeid#>

<!--- KF dec 03, select employeeId as needed for internal query --->
<cfset strQuery = "SELECT tblEmpRoster.RosterID, [GivenName] + ' ' + [Surname] AS FullName, tblEmpRoster.StoreID, tblEmpRoster.WeekEnding, tblEmpRoster.SunStart, tblEmpRoster.SunEnd, tblEmpRoster.MonStart, tblEmpRoster.MonEnd, tblEmpRoster.TueStart, tblEmpRoster.TueEnd, tblEmpRoster.WedStart, tblEmpRoster.WedEnd, tblEmpRoster.ThuStart, tblEmpRoster.ThuEnd, tblEmpRoster.FriStart, tblEmpRoster.FriEnd, tblEmpRoster.SatStart, tblEmpRoster.SatEnd, tblEmployee.EmployeeID ">
<cfset strQuery = strQuery & "FROM tblEmployee INNER JOIN tblEmpRoster ON tblEmployee.EmployeeID = tblEmpRoster.EmployeeID ">
<cfset strQuery = strQuery & "WHERE (((tblEmpRoster.StoreID)=#lngStoreID#) AND ((tblEmpRoster.WeekEnding)='#strDate#')) ">

<!--- KF dec 03, re-sort by empstatus and given name
<cfset strQuery = strQuery & "ORDER BY [GivenName] + ' ' + [Surname]">
--->
<cfset strQuery = strQuery & "ORDER BY EmpStatusID, [GivenName], [Surname]">


<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord" > --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

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
	<CFINCLUDE template="dsp_landscapePrintHeader.cfm">
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle# week ending #strWeekEnding#</cfoutput></h1>
    </td>
    <td width="25%"> 
      &nbsp;
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="RosterActionB.cfm" method="post">
<!--- Write down the date --->
<cfoutput>
<input type="hidden" name="strDate" value="#strDate#">		
<input type="hidden" name="lngStoreID" value="#lngStoreID#">		
<input type="hidden" name="lngNumRecords" value="#GetRecord.RecordCount#">		
</cfoutput>
<table width="100%" border="1" cellspacing="0">
  <tr> 
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Name</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Sun</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Mon</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Tue</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Wed</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Thur</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Fri</font></b></div>
    </td>
    <td colspan="2"> 
      <div align="center"><b><font face="Tahoma" size="2">Sat</font></b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <div align="center"><b><font size="3" face="Tahoma">&nbsp;</font></b></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>From</b></font></div>
    </td>
    <td> 
      <div align="center"><font size="2" face="Tahoma"><b>To</b></font></div>
    </td>
  </tr>
  <cfoutput Query ="GetRecord">
  <cfset lngLineNumber = #GetRecord.CurrentRow#>	
  <!--- KF dec 03, alternate row colours 
  <tr> 
  --->
  <cfif getRecord.currentRow MOD 2 is 0>
      <tr bgcolor="##0033FF">
	  <CFSET thisTextBox = 'class="textbox"'>
  <CFELSE>
      <tr>
	  <CFSET thisTextBox = ''>	  
  </cfif>
    <td>
		<font face="Tahoma" size="2"><b>#lngLineNumber#</b></font>
	</td>
    <td>
		<font face="Tahoma" size="2"><b>#GetRecord.FullName#</b></font>
	</td>
    <td> 
      <INPUT type="hidden" name="RosterID_Line#lngLineNumber#" value = "#GetRecord.RosterID#">

      <input #thisTextBox# type="text" name="Day_1_From_Line#lngLineNumber#" value="#GetRecord.SunStart#" maxlength="4" size="5">    
      <INPUT type="hidden" name="Day_1_From_Line#lngLineNumber#_required" value = "Please type Sun start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_1_From_Line#lngLineNumber#_integer" value = "Please type Sun start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_1_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    </td>
    <td> 
      <input #thisTextBox# type="text" name="Day_1_To_Line#lngLineNumber#" value="#GetRecord.SunEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_1_To_Line#lngLineNumber#_required" value = "Please type Sun finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_1_To_Line#lngLineNumber#_integer" value = "Please type Sun finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_1_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input #thisTextBox# type="text" name="Day_2_From_Line#lngLineNumber#" value="#GetRecord.MonStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_2_From_Line#lngLineNumber#_required" value = "Please type Mon start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_2_From_Line#lngLineNumber#_integer" value = "Please type Mon start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_2_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox# name="Day_2_To_Line#lngLineNumber#" value="#GetRecord.MonEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_2_To_Line#lngLineNumber#_required" value = "Please type Mon finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_2_To_Line#lngLineNumber#_integer" value = "Please type Mon finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_2_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox# name="Day_3_From_Line#lngLineNumber#" value="#GetRecord.TueStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_3_From_Line#lngLineNumber#_required" value = "Please type Tue start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_3_From_Line#lngLineNumber#_integer" value = "Please type Tue start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_3_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_3_To_Line#lngLineNumber#" value="#GetRecord.TueEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_3_To_Line#lngLineNumber#_required" value = "Please type Tue finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_3_To_Line#lngLineNumber#_integer" value = "Please type Tue finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_3_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_4_From_Line#lngLineNumber#" value="#GetRecord.WedStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_4_From_Line#lngLineNumber#_required" value = "Please type Wed start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_4_From_Line#lngLineNumber#_integer" value = "Please type Wed start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_4_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_4_To_Line#lngLineNumber#" value="#GetRecord.WedEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_4_To_Line#lngLineNumber#_required" value = "Please type Wed finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_4_To_Line#lngLineNumber#_integer" value = "Please type Wed finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_4_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_5_From_Line#lngLineNumber#" value="#GetRecord.ThuStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_5_From_Line#lngLineNumber#_required" value = "Please type Thu start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_5_From_Line#lngLineNumber#_integer" value = "Please type Thu start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_5_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_5_To_Line#lngLineNumber#" value="#GetRecord.ThuEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_5_To_Line#lngLineNumber#_required" value = "Please type Thu finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_5_To_Line#lngLineNumber#_integer" value = "Please type Thu finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_5_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_6_From_Line#lngLineNumber#" value="#GetRecord.FriStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_6_From_Line#lngLineNumber#_required" value = "Please type Fri start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_6_From_Line#lngLineNumber#_integer" value = "Please type Fri start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_6_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_6_To_Line#lngLineNumber#" value="#GetRecord.FriEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_6_To_Line#lngLineNumber#_required" value = "Please type Fri finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_6_To_Line#lngLineNumber#_integer" value = "Please type Fri finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_6_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_7_From_Line#lngLineNumber#" value="#GetRecord.SatStart#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_7_From_Line#lngLineNumber#_required" value = "Please type Sat start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_7_From_Line#lngLineNumber#_integer" value = "Please type Sat start for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_7_From_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
    <td> 
      <input type="text" #thisTextBox#  name="Day_7_To_Line#lngLineNumber#" value="#GetRecord.SatEnd#" maxlength="4" size="5">    </td>
      <INPUT type="hidden" name="Day_7_To_Line#lngLineNumber#_required" value = "Please type Sat finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_7_To_Line#lngLineNumber#_integer" value = "Please type Sat finish for line #lngLineNumber#">
      <INPUT type="hidden" name="Day_7_To_Line#lngLineNumber#_range" Value = "MIN=0 MAX=2400">
	
	<!--- query the hours worked table to find how many actual hours have been completed 
	for this employee/date --->
	<TD>
	   <CFINCLUDE template="getActualHoursWorked.cfm">
	   #sumHours#h #sumMins#m
	</td>  
	<!--- end amendment --->
	
  </tr>
  </cfoutput>
</table>
<p><input type="submit" name="Submit" value="  Save  "></p>
<p><h3>Please do not forget to save your entries</h3></p>
<CFINCLUDE template="dsp_Print.cfm">
</form>
</body>
</HTML>

