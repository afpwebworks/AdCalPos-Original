<cfset strPageTitle = "Rosters">

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
<cfset strQuery = "SELECT tblEmpRoster.RosterID , tblEmpRoster.RosterID AS ID_Field, * ">
<cfset strQuery = strQuery & "FROM tblEmpRoster ">
<cfset strQuery = strQuery & "Where WeekEnding = '#strDate#'">
<cfset strQuery = strQuery & "ORDER BY tblEmpRoster.RosterID">
<CFQUERY dataSource="#application.dsn#" name="GetRecord" >
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>
<HTML>
<HEAD>
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
<cfinclude template="/js/jqueryaddin.cfm" >
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1><cfoutput>#strPageTitle#</cfoutput></h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<!--- Write down the date --->
<input type="hidden" name="strDate" value="#strDate#">
<table width="100%" border="0">
  <tr>
    <td><div align="center">
        <table id="id2" class="tablesorter">
          <thead>
            <tr>
              <th>ID</th>
              <th>Staff</th>
              <th>Week End</th>
              <th>Sun Start</th>
              <th>Sun End</th>
              <th>Mon Start</th>
              <th>Mon End</th>
              <th>Tue Start</th>
              <th>Tue End</th>
              <th>Wed Start</th>
              <th>Wed End</th>
              <th>Thu Start</th>
              <th>Thu End</th>
              <th>Fri Sart</th>
              <th>Fri End</th>
              <th>Sat Start</th>
              <th>Sat End</th>
            </tr>
          </thead>
          <tbody>
            <cfloop query="getrecord">
              <cfoutput>
                <tr>
                  <td><a href="tblEmpRoster_RecordActionGrid.cfm?cfgridkey=#getrecord.rosterid#">#getrecord.rosterid#</a></td>
                  <td>#getrecord.EmployeeID#</td>
                  <td>#getrecord.WeekEnding#</td>
                  <td>#numberformat(getrecord.SunStart, "00.00")#</td>
                  <td>#numberformat(getrecord.SunEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.MonStart, "00.00")#</td>
                  <td>#numberformat(getrecord.MonEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.TueStart, "00.00")#</td>
                  <td>#numberformat(getrecord.TueEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.WedStart, "00.00")#</td>
                  <td>#numberformat(getrecord.WedEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.ThuStart, "00.00")#</td>
                  <td>#numberformat(getrecord.ThuEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.FriStart, "00.00")#</td>
                  <td>#numberformat(getrecord.FriEnd, "00.00")#</td>
                  <td>#numberformat(getrecord.SatStart, "00.00")#</td>
                  <td>#numberformat(getrecord.SatEnd, "00.00")#</td>
                </tr>
              </cfoutput>
            </cfloop>
          </tbody>
        </table>
      </div></td>
  </tr>
</table>
</body>
</HTML>
