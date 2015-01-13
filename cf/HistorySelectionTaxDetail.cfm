
<cfset lngStoreID = #URL.SID#>
<cfset lngRecordID = #URL.RD#>

<cfset lngFD = #URL.FD#>
<cfset lngTD = #URL.TD#>

<!--- Get the store name --->
<cfset strQuery = "SELECT * from tblStores where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Get the records --->
<cfset strQuery = "SELECT CONVERT(int, SUBSTRING(WeekEnding, 5, 4)+ SUBSTRING(WeekEnding, 3, 2) + SUBSTRING(WeekEnding, 1, 2)) AS lngDate, * from tblEmpPayRollPaid where TaxPaidID = #lngRecordID# ">
<cfset strQuery = strQuery & "Order by lngDate">
<CFQUERY name="GetDetail" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblTotal = 0>

<cfset strPageTitle = "#GetStoreDetail.StoreName# Tax History">

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
  	  <cfoutput>
      <div align="right"><a href="HistorySelectionTax.cfm?FD=#lngFD#&TD=#lngTD#&SID=#lngStoreID#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
	  </cfoutput>	
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;
<P>
<table width="500" border="1" cellspacing="0" cellpadding="3">

<TR>  <!--- <TR bgcolor="cccccc"> --->
    <td width="100"  align="center">ID</td>
    <td width="100"  align="center">Week Ending</td>	
    <td width="100"  align="center">Name</td>
    <td width="100"  align="center">Surname</td>
    <td width="100"  align="center">Amount</td>
</TR>
<CFOUTPUT query="GetDetail">
	<cfset dblTotal = dblTotal + #GetDetail.Tax# >
<TR bgcolor="#IIf(CurrentRow Mod 2, DE('00006D'), DE('0033FF'))#">
	<TD width="100"  align="center">#GetDetail.WageID#&nbsp;</TD>
	<TD width="100"  align="center">#GetDetail.WeekEnding#&nbsp;</TD>
	<TD width="100"  align="center">#GetDetail.GivenName#&nbsp;</TD>
	<TD width="100"  align="center">#GetDetail.Surname#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(GetDetail.Tax,"______.00")#&nbsp;</TD>
</TR>
</CFOUTPUT>
<cfoutput>
<TR>
	<td colspan="4">Total</td>
	<TD width="100"  align="right">#NumberFormat(dblTotal,"______.00")#&nbsp;</TD>
</TR>
</cfoutput>
</TABLE>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

