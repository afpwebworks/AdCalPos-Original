<cfsilent>
<!----
==========================================================================================================
Filename:     ReportFinancial2.cfm
Description:  Form Page for daily takings report.
Date:         5/Jan/2011
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<!--- - WB 09/01/2004 - Setup calendar variables - --->

<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmFinancialReport">
<cfset local.page="ReportFinancial1.cfm"> 
<cfset strPageTitle = "Daily Takings Report">

<cfif NOT(isdefined("StoresDAO"))> 
   <cfset StoresDAO =   application.beanfactory.getBean("StoresDAO") />
</cfif>
<cfset currentstore = application.beanfactory.getBean("StoreBean") />
<!--- Setting graph width and height  --->
<cfparam name="width" default="475">
<cfparam name="height" default="300">

<!---[   Set up data for the page   ]---->
<cfscript>
  GetStores = StoresDAO.getAllStores();
  lngUserType = session.user.getusertype() ;
  currentStore.setStoreID(  session.user.getStoreID()  ) ;
  StoresDAO.read( currentStore   );
</cfscript>  


<!---[   <CFQUERY name="GetStores" datasource="#application.dsn#" > 
SELECT s.StoreID, s.StoreName, sg.StoreGroupId, sg.StoreGroup
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
ORDER BY sg.StoreGroup, s.StoreName
</CFQUERY>   ]---->


<!---[   <CFQUERY name="GetCurrentStore" datasource="#application.dsn#" > 
SELECT s.StoreName
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
AND s.StoreID=<cfqueryparam value="#Session.StoreID#" cfsqltype="cf_sql_integer" />
</CFQUERY>   ]---->


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


<!--- <cfset lngStoreID = #session.storeid#> --->

<cfset lngToday = #DayOfWeek(now())#>
<cfif #lngToday# eq 1>
	<cfset lngD1 = 6>
<cfelseif #lngToday# eq 2>
	<cfset lngD1 = 5>
<cfelseif #lngToday# eq 3>
	<cfset lngD1 = 4>
<cfelseif #lngToday# eq 4>
	<cfset lngD1 = 3>
<cfelseif #lngToday# eq 5>
	<cfset lngD1 = 2>
<cfelseif #lngToday# eq 6>
	<cfset lngD1 = 1>
<cfelseif #lngToday# eq 7>
	<cfset lngD1 = 0>
</cfif>
<cfset dd1 = #dateadd('d',lngD1,now())#>
</cfsilent>
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
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
<!--------[  <script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/validation.js" type="text/javascript"></script>  - MK ]------>

<cfinclude template="/js/jqueryaddin.cfm" >


</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">

<table width="100%">
  <tr valign="center"> 
    <!----[  <td width="25%"><a  onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0></a></td>  ]----MK ---->
    <td><a href="/cf/mainmenu.cfm"><img src="/images/butHomeUp.gif"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="MainMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>

<FORM action="ReportFinancial1Rep.cfm?RequestTimeout=300" id="frmFinancialReport" method="post" name="frmFinancialReport" onSubmit="return submitCheck('frmFinancialReport');" >

<table width="100%" border="1">
  <tr>
   	<td width =30%>&nbsp;</td>
    <td width="40%" align="center">
         <!--- - WB 09/01/2004 - Display calendar - --->
		<cfinclude template="CalendarDisplay3.cfm">
	 </td>
	<td width="30%">&nbsp;</td>
  </tr>
  <tr>	
	 <td width = "30%">&nbsp;</td>
	 <td width="40%" align="center">
			<!---[   <cfif session.user.getusertype() LE application.mgmtreportcutoff>   ]---->
			<select name="txtStoreID" multiple="multiple" >
			<option value="all" selected>All Stores</option>
			<cfloop Query="GetStores"><cfoutput>
				<option value="#GetStores.StoreID#">#GetStores.State# - #GetStores.StoreName#</option>
			</cfoutput></cfloop>
			</select>
  
		</td>
	 	<td width="30%">&nbsp;</td>
	</tr>
	<tr>
		<td width = "30%">&nbsp;</td>
		<td width = "40%" align = "center">
	 
	   	<input id="buttonSubmit" name="buttonSubmit" type="submit"
		value="Daily Takings" class="buttonWidth">
	    </td>
		<td width="30%">&nbsp;</td>
   </tr>
</table>
</form> 

</body>
</HTML>

