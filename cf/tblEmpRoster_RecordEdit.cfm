
<cfset strPageTitle = "Roster Add/Edit">
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

<CFSET FormFieldList = "RosterID,EmployeeID,StoreID,WeekEnding, SunStart, SunEnd, MonStart, MonEnd, TueStart, TueEnd, WedStart, WedEnd, ThuStart, ThuEnd, FriStart, FriEnd, SatStart, SatEnd">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmpRoster.RosterID, tblEmpRoster.RosterID AS ID_Field, *
		FROM tblEmpRoster
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmpRoster.RosterID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "RosterID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "RosterID" )>
	</CFIF>
			<CFSET RosterID_Value = #GetRecord.RosterID#>
			<CFSET EmployeeID_Value = #GetRecord.EmployeeID#>
			<CFSET StoreID_Value = #GetRecord.StoreID#>
			<CFSET WeekEnding_Value = #GetRecord.WeekEnding#>
			<CFSET SunStart_Value = #GetRecord.SunStart#>
			<CFSET SunEnd_Value = #GetRecord.SunEnd#>
			<CFSET MonStart_Value = #GetRecord.MonStart#>
			<CFSET MonEnd_Value = #GetRecord.MonEnd#>  
			<CFSET TueStart_Value = #GetRecord.TueStart#>  
			<CFSET TueEnd_Value = #GetRecord.TueEnd#>  
			<CFSET WedStart_Value = #GetRecord.WedStart#>
			<CFSET WedEnd_Value = #GetRecord.WedEnd#>
			<CFSET ThuStart_Value = #GetRecord.ThuStart#>  
			<CFSET ThuEnd_Value = #GetRecord.ThuEnd#>  
			<CFSET FriStart_Value = #GetRecord.FriStart#>  
			<CFSET FriEnd_Value = #GetRecord.FriEnd#>  
			<CFSET SatStart_Value = #GetRecord.SatStart#>  
			<CFSET SatEnd_Value = #GetRecord.SatEnd#>

<CFELSE>
			<CFSET RosterID_Value = ''>
			<CFSET EmployeeID_Value = ''>
			<CFSET StoreID_Value = ''>
			<CFSET WeekEnding_Value = ''>
			<CFSET SunStart_Value = ''>
			<CFSET SunEnd_Value = ''>
			<CFSET MonStart_Value = ''>
			<CFSET MonEnd_Value = ''>
			<CFSET TueStart_Value = ''>
			<CFSET TueEnd_Value = ''>
			<CFSET WedStart_Value = ''>
			<CFSET WedEnd_Value = ''>
			<CFSET ThuStart_Value = ''>
			<CFSET ThuEnd_Value = ''>
			<CFSET FriStart_Value = ''>
			<CFSET FriEnd_Value = ''>
			<CFSET SatStart_Value = ''>
			<CFSET SatEnd_Value = ''>

</CFIF>

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
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="tblEmpRoster_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<CFOUTPUT>
<FORM action="tblEmpRoster_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="RosterID" value="#URL.RecordID#">
</CFIF>

            <TABLE width="550" border="1" cellpadding="2">
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Roster ID: </font></b></TD>
                <TD> 
	             <CFIF not ParameterExists(URL.RecordID)>
	                  <INPUT type="text" name="RosterID" value="#RosterID_Value#" size="25" maxLength="10">
	              <cfelse>
	                  <font face="Tahoma" size="4" color="FFFFFF">#RosterID_Value#</font>
				  </CFIF>
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="RosterID_integer">
                <INPUT type="hidden" name="RosterID_required" value="Please type the roster ID.">				

  			  <TD rowspan="11" width="10"> &nbsp;</td>
			  
<!---               <TD valign="top" width="150"><h2>&nbsp;</h2></TD>
              <TD width="150"> 
                <div align="right"><h2>&nbsp;</h2></div>
              </TD>
 --->				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Employee ID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="EmployeeID" value="#EmployeeID_Value#" size="25" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="EmployeeID_integer">
                <INPUT type="hidden" name="EmployeeID_required" value="Please type the employee ID.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Store ID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="StoreID" value="#StoreID_Value#" size="25" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="StoreID_integer">
                <INPUT type="hidden" name="StoreID_required" value="Please type the store ID.">				
              </TR>

 
 
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Week Ending: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="WeekEnding" value="#WeekEnding_Value#" size="25" maxLength="8">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="WeekEnding_integer">
                <INPUT type="hidden" name="WeekEnding_required" value="Please type the week ending.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sun Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SunStart" value="#SunStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SunStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sun End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SunEnd" value="#SunEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SunEnd_integer">
				
              </TR>

 
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Mon Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="MonStart" value="#MonStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="MonStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Mon End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="MonEnd" value="#MonEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="MonEnd_integer">
				
              </TR>
 
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Tue Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="TueStart" value="#TueStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="TueStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Tue End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="TueEnd" value="#TueEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="TueEnd_integer">
				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Wed Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="WedStart" value="#WedStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="WedStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Wed End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="WedEnd" value="#WedEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="WedEnd_integer">
				
              </TR>
 
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Thu Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="ThuStart" value="#ThuStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="ThuStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Thu End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="ThuEnd" value="#ThuEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="ThuEnd_integer">
				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Fri Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="FriStart" value="#FriStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="FriStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Fri End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="FriEnd" value="#FriEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="FriEnd_integer">
				
              </TR>
 
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sat Start: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SatStart" value="#SatStart_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SatStart_integer">

                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sat End: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SatEnd" value="#SatEnd_Value#" size="25" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SatEnd_integer">
				
              </TR>
            </TABLE>
<p></p>	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

