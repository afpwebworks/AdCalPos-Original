<cfsilent>
<!----
==========================================================================================================
Filename:     StockLocationReport.cfm
Description:  Stock Location Report for AdCalPos
Date:         15/8//2010
Author:       Michael Kear, AFP Webworks

Revision history: 
31/8/2010  Modified to accept alpha-numeric part nos. - MK
31/8/2010  Changed message for no results. - MK
31/8/2010  Changed drop-down to show part number as well as the description.
9/8/2012  manager,email etc details must have content GT 2 to show on the report.

==========================================================================================================
--->
<cfset ReportEngine =    application.beanfactory.getBean("Reporting") />
<cfset PartNOs      =    Reportengine.getPartNos() />
</cfsilent>
<!---[   Check for logged in and bounce out if not allowed entry   ]---->
<cfif session.logged Is not "yes">
  <cflocation url="/index.cfm" />
</cfif>

<cfif structKeyExists(url, "PartNO" )>
  <cfscript>
	Reportdata   =    Reportengine.StockLocationbyPartNO( PartNO ) ;
	
</cfscript>
</cfif>
<cfparam name="strPageTitle" default="Stock Location Report">
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="/css/adcalposnet.css">
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
<cfoutput>
<table width="100%">
  <tr valign="center">
    <td width><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
    <td align="center" width="*"><h1>#strPageTitle#<cfif structKeyExists(url,"partno")> for Part No #url.PartNO#</cfif></h1></td>
    <td>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="MainMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div></td>
  </tr>
</table>
<!---[   If there is reportdata, include the report for the part no list   ]---->
<cfif  isdefined("reportdata")>
<div id="report" style="text-align:center;">
<table>
<tr>
  <th>Part No</th>
  <th>Description</th>
  <th>Quantity On Hand</th>
  <th>Last Cost</th>
  <th>Store ID</th>
  <th>Store</th>
  <th>Contact</th>
</tr>
<cfif ReportData.recordcount>
  <cfloop query="ReportData">
  <tr class="#IIf(CurrentRow Mod 2, DE('lite'), DE('dark'))#">
    <td>#ReportData.PartNo#</td>
    <td>#ReportData.description#</td>
    <td align="center">#ReportData.qtyonhand#</td>
    <td align="right">#dollarformat(ReportData.lastcost)#</td>
    <td align="center">#ReportData.storeid#</td>
    <td>#ReportData.storename#</td>
    <td><cfif len(ReportData.manager1name) GT 2>
        Manager: #ReportData.manager1name#<br />
      </cfif>
      <cfif len(ReportData.phone) GT 2>
        Phone: #ReportData.phone#<br />
      </cfif>
      <cfif len(ReportData.mobile) GT 2>
        Mobile: #ReportData.mobile#<br />
      </cfif>
      <cfif len(ReportData.email) GT 2>
        Email: #ReportData.email#<br />
      </cfif></td>
  </tr>
  </cfloop>
<cfelse>
  <tr class="lite">
    <td colspan="7" align="center"> That is not a valid part number. Please check and retry. </td>
  </tr>
</cfif>
  </table>
  </div>
</cfif>
<!---[   Include the form for part no selection.   ]---->
<fieldset><legend>Choose a part no</legend>
<form action="#cgi.SCRIPT_NAME#" method="get" name="StockLocationForm" id="StockLocationForm">
<select name="partno" id="partno">
<cfloop query="PartNOs">
	<option value="#partnos.PartNO#"  <cfif structKeyExists(url,"PartNO") and (url.partno eq partnos.partno)>selected="selected"</cfif> >#partnos.PartNO# - #PartNOs.description#</option>
</cfloop>
<input type="submit" id="submit" value="  Submit  " />
</form>
</fieldset>
</cfoutput>
</body>
</html>
