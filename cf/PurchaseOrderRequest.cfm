
<cfsetting enablecfoutputonly="Yes">
<!--- - WB 09/01/2004 - Setup calendar variables - --->
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmPurchaseOrderRequest">
<cfset local.page="PurchaseOrderRequest.cfm">
<cfsetting enablecfoutputonly="No">
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
	<TITLE>sample</TITLE>
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
<script language="JavaScript1.2" src="../js/calendar_check1.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar1.js" type="text/javascript"></script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_self"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Purchase Order</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" target="_self"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
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

<!--- Get the date ---> 
<CFSET strTomorrowDate = ''>
<CF_GetTomorrowDate>

<cfset strDateStringTomorrow = #strTomorrowDate#>

<CFSET strDateToday = ''>
<CF_GetTodayDate>

<CFSET lngCurTime = 0>
<CF_GetCurrentTime>

<CFSET lngCutOffTime = 0>
<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->
<!--- <CF_GetOrderingCutOffTime> --->
<CFINCLUDE template="GetOrderingCutOffTime.cfm">
<cfif lngCurTime GT #lngCutOffTime# >
	<cfoutput>
	<p>It is after #lngCutOffTime# and we can not add or edit any order for today</P>
	<p>Please choose the order date.</P>
	</cfoutput>
	<CFSET strMyDate = strTomorrowDate>
<cfelse>
	<p>Please choose the order date.</P>
	<CFSET strMyDate = strDateToday>
</cfif>
<FORM action="PurchaseOrderAction.cfm" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">

<table border="0">
  <tr><td align="center">Order Date</td></tr>
  <tr><td align="center">
  	<!--- - WB 09/01/2004 - Display calendar - --->
	<cfinclude template="CalendarDisplay1.cfm">
  </td></tr>	
</table>
<p></P>
	<input type="submit" name="frozen" value=" Make/View Early Order " onclick="this.form.action='PurchaseOrderActionFrozen.cfm';">
	<input type="submit" name="notFrozen" value=" Make/View Main Order ">
</Form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

