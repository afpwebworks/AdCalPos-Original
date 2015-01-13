
<cfset strPageTitle = "Tax Detail">

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
 
<cfset lngEid = URL.EID>
<cfset strQuery = "SELECT * from tblEmployee where EmployeeID = #lngEid#" >

<CFQUERY name="GetEmp" maxRows=1 datasource="#application.dsn#" > 
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strEmpName = #GetEmp.GivenName# & " " & #GetEmp.Surname# >


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
	<cfoutput>
    <td width="25%"> 
      <div align="right"><a href="tblEmployee_RecordView.cfm?RecordID=#lngEid#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
	</cfoutput>	
  </tr>
</table>

<cfset TodayMonth = #Month(now())# >
<cfif TodayMonth GT 6 >
	<cfset StartYear = #Year(now())#>
	<cfset NextYear = 1 + #Year(now())#>
	<cfset StartDate = "#StartYear#0701" >
	<cfset EndDate = "#NextYear#0630" >
<cfelse>
	<cfset StartYear = #Year(now())# - 1 >
	<cfset NextYear = #Year(now())#>
	<cfset StartDate = "#StartYear#0701" >
	<cfset EndDate = "#NextYear#0630" >
</cfif>

<P>
<P>

<P>

<table width="100%">
<tr>
	<td width="10%">&nbsp;</td>
	<td width="70%"><cfoutput><font face="Tahoma" color="FFFFFF" size="4">#strEmpName#</font></cfoutput>&nbsp;</td>
	<td width="20%">&nbsp;</td>
</tr>
<tr>
	<td width="10%">&nbsp;</td>
	<td width="70%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
</tr>
<tr>
	<td width="10%">&nbsp;</td>
	<td width="70%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
</tr>

<tr>
	<td width="10%">&nbsp;</td>
	<td width="70%">
		<cfset strQuery = "SELECT (substring(WeekEnding,1,2)) + '/' + (substring(WeekEnding,3,2)) + '/' + (substring(WeekEnding,5,4)) as WeekEndingDate, * from tblEmpPayRollPaid where EmployeeID = #lngEid# and 10000 * (substring(WeekEnding,5,4)) + 100 * (substring(WeekEnding,3,2)) + (substring(WeekEnding,1,2)) between 20020701 and 20040630  order by 10000 * (substring(WeekEnding,5,4)) + 100 * (substring(WeekEnding,3,2)) + (substring(WeekEnding,1,2))">
		
		<CFQUERY name="GetDetail" datasource="#application.dsn#" > 
		        #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset dblTotal = 0>
		<table width="100%">
		  <tr> 
		    <td width="150" align="Left"><font face="Tahoma" color="FFFFFF" size="4">Week Ending</font></td>
		 	<td width="150" align="right"><font face="Tahoma" color="FFFFFF" size="4">Tax</font></td>
		  </tr>
		  <cfoutput query = "GetDetail">
		  	  <cfset dblTemp = #GetDetail.Tax#  >
			  <cfset dblTotal = dblTotal + dblTemp >
		  <tr> 
		    <td width="150" align="Left"><font face="Tahoma" color="FFFFFF" size="3">#GetDetail.WeekEndingDate#</font></td>
		    <td width="150" align="right"><font face="Tahoma" color="FFFFFF" size="3">#NumberFormat(dblTemp,"_____.99")#</font></td>
		  </tr>
		  </cfoutput>	
		  <cfoutput>
		  <tr> 
		    <td width="150" align="Left"><font face="Tahoma" color="FFFFFF" size="4">Total</font></td>
		    <td width="150" align="right"><font face="Tahoma" color="FFFFFF" size="4">#NumberFormat(dblTotal,"_____.99")#</font></td>
		  </tr>
		  </cfoutput>
		</table>

	</td>
	<td width="20%">&nbsp;</td>
</tr>

</table>

<br>
<br>
</body>
</HTML>

