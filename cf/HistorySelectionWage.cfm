
<cfset strPageTitle = "Wage History">

<cfset lngStoreID = #URL.SID#>
<cfset lngFD = #URL.FD#>
<cfset lngTD = #URL.TD#>

<!--- <cfset lngStoreID = #session.storeid#> --->
	<cfset strQuery = "SELECT tblStores.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores ">
	<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngStoreID#">
	<CFQUERY name="GetStore" datasource="#application.dsn#" > 	
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strStoreName = #GetStore.StoreName#>

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
<!---
<cfinclude template="navbar_header_small.cfm">
--->
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td align="CENTER"> 
      <h1><cfoutput>#strPageTitle# for #strStoreName#</cfoutput></h1>
	  	  
	  <!--- KF dec 03 --->  
         <h2><cfoutput>From #MID(url.FD,7,2)#/#MID(url.FD,5,2)#/#MID(url.FD,1,4)# to #MID(url.TD,7,2)#/#MID(url.TD,5,2)#/#MID(url.TD,1,4)#</CFOUTPUT></h2>
	  <!--- end --->
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><a href="HistorySelection.cfm?FD=#lngFD#&TD=#lngTD#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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

<cfset strQuery = "SELECT WageID, EmployeeID, GivenName, Surname, EmpStatusID,  ">
<cfset strQuery = strQuery & "WeekEnding, StoreID, PaymentMethod, ReferenceNumber,  ">
<cfset strQuery = strQuery & "SuperAccumulated, WorkCompAccumulated, ">
<cfset strQuery = strQuery & "TaxableIncome + NonTaxableIncome AS Pay, Tax, ">
<cfset strQuery = strQuery & "TaxableIncome + NonTaxableIncome - Tax AS Net, ">
<cfset strQuery = strQuery & "SUBSTRING(WeekEnding, 5, 4) + SUBSTRING(WeekEnding, 3, 2) + SUBSTRING(WeekEnding, 1, 2) AS SortingDate ">
<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (SUBSTRING(WeekEnding, 5, 4) + SUBSTRING(WeekEnding, 3, 2) + SUBSTRING(WeekEnding, 1, 2) BETWEEN '#lngFD#' AND '#lngTD#') AND (StoreID = #lngStoreID#)">
<CFQUERY name="SearchResult" datasource="#application.dsn#" >
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<P>

<table width="100%" border="1" cellspacing="0" cellpadding="3">

<TR>  <!--- <TR bgcolor="cccccc"> --->
    <td width="100"  align="center">ID</td>
    <td width="100"  align="center">Week Ending</td>
    <td width="100"  align="center">EmployeeID</td>
    <td width="100"  align="center">GivenName</td>	
    <td width="100"  align="center">Surname</td>
    <td width="100"  align="center">Status</td>
    <td width="100"  align="center">Pay Method</td>
    <td width="100"  align="center">Reference</td>
    <td width="100"  align="center">Super</td>
    <td width="100"  align="center">Workers Comp</td>
    <td width="100"  align="center">Pay</td>
    <td width="100"  align="center">Tax</td>
    <td width="100"  align="center">Net</td>
</TR>
  <!--- KF Dec 03, counters for totals --->
<CFSET superTotal = 0><CFSET workCompTotal = 0><CFSET payTotal = 0><CFSET taxTotal = 0><CFSET netTotal = 0>
<CFOUTPUT query="SearchResult">
  <TR bgcolor="#IIf(CurrentRow Mod 2, DE('00006D'), DE('0033FF'))#">
	<TD width="100"  align="center">#WageID#</TD>
	<TD width="100"  align="center">#WeekEnding#&nbsp;</TD>
	<TD width="100"  align="center">#EmployeeID#&nbsp;</TD>
	<TD width="100"  align="left">#GivenName#&nbsp;</TD>
	<TD width="100"  align="left">#Surname#&nbsp;</TD>
	<TD width="100"  align="center">#EmpStatusID#&nbsp;</TD>
	<TD width="100"  align="center">#PaymentMethod#&nbsp;</TD>
	<TD width="100"  align="center">#ReferenceNumber#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(SuperAccumulated,"______.00")#&nbsp;</TD>	
	<TD width="100"  align="right">#NumberFormat(WorkCompAccumulated,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(Pay,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(Tax,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(Net,"______.00")#&nbsp;</TD>
  </TR>
  <!--- KF Dec 03, log for totals --->
    <CFSET superTotal = superTotal + SuperAccumulated>
    <CFSET workCompTotal = workCompTotal + WorkCompAccumulated>
    <CFSET payTotal = payTotal + pay>
    <CFSET taxTotal = taxTotal + tax>
    <CFSET netTotal = netTotal + net>
</CFOUTPUT>
<CFOUTPUT>
<TR bgcolor="##0000002">
	<TD colspan="8" align="RIGHT"><b>Totals</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(SuperTotal,"______.00")#&nbsp;</TD>	
	<TD width="100"  align="right">#NumberFormat(WorkCompTotal,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(PayTotal,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(TaxTotal,"______.00")#&nbsp;</TD>
	<TD width="100"  align="right">#NumberFormat(NetTotal,"______.00")#&nbsp;</TD>
</TR>
</cfoutput>
</TABLE>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

