<cfsilent>
<!----
==========================================================================================================
Filename:     SalesOrderReportPaymentTypes.cfm
Description:  Sales Order Report for AdCalPos grouped by Payment Types
Date:         1/8/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
18/4/2010  Integrated with existing system.
3/8/2010  MK 

==========================================================================================================
--->
</cfsilent>
<!---[   Check for logged in and bounce out if not allowed entry   ]---->
<cfif session.logged Is not "yes">
  <cflocation url="/index.cfm" />
</cfif>
 <cfset 	ReportEngine =  application.beanfactory.getBean("Reporting") />  
<cfscript>
FromYear = left(url.fd, "4");
FromMonth = mid(url.fd,"5", "2");
FromDay = right(url.fd,"2");
ToYear = left(url.td, "4");
ToMonth = mid(url.td,"5", "2");
ToDay = right(url.td,"2");
Startdate = createdate( FromYear, FromMonth , FromDay );
Enddate = createdate( ToYear, ToMonth , ToDay );
StoreID = url.SID;
//initialise the totals struct
EFTPOSChange=0;
lineChange=0;
Linetotals=0;
TypeTotals =  0;
Daytotals =  0;
Grandtotals = 0;
</cfscript>
<cfif structKeyExists(url, "td" )>
 <cfscript>
	ReportData = Reportengine.SalesReportPaymentType( Startdate, Enddate, StoreID );
	StoreDetail = Reportengine.getStores( storeID, session.employeeid, session.usertype ) ;
	//Initialise the triggers for subtotal changes
	Triggers = StructNew();
	Triggers.transdate = Startdate ;
	Triggers.Mediaid = "1";
	Triggers.locationID = ReportData.locationID["1"];
	Triggers.terminalid = ReportData.terminalid["1"];
</cfscript> 
</cfif>
<cfparam name="strPageTitle" default="Sales Report, Summary by Payment Type">
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="/css/adcalposnet.css">
<TITLE>
<cfoutput>#strPageTitle#</cfoutput>
</TITLE>
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

<table width="90%">
  <tr valign="center">
    <td width><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
    <td align="center" width="*"><h1>
      <cfoutput>#strPageTitle# <br />
      for dates included #dateformat(Startdate, "d / mmm / yyyy")# to #dateformat(Enddate, "d / mmm / yyyy")#
      </h1>
      </CFOUTPUT>
      <cfif isDefined("StoreDetail.recordCount")>
        <CFIF listfindNoCase(StoreID, "all")>
          All Stores
          <CFELSE>
          <cfif StoreDetail.recordCount GT 1>
            <p>
              <cfloop query="StoreDetail">
              <cfoutput>#StoreDetail.StoreName# &nbsp;</cfoutput>
              </cfloop>
            </p>
            <cfelse>
            <cfoutput>#StoreDetail.StoreName#</cfoutput>
          </cfif>
        </cfif>
      </cfif></td>
    <td><cfoutput>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#url.FD#&TD=#url.TD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
      </cfoutput></td>
  </tr>
</table>
<cfif isdefined("Reportdata")>
  <cfsilent> 
  <!---[   query of queries to find out amount of change in media type 2 (EFTPOS)   ]---->
  <cfquery name="qChange" dbtype="query">
SELECT Sum(Change) as EFTPOSChange from reportdata
WHere
MediaID = <cfqueryparam value='2' cfsqltype="cf_sql_integer" />
</cfquery>
  <cfset EFTPOSChange = qChange.EFTPOSChange />
  <!---[   If there is no change, this results in an undefined value for EFTPOSChange, so guarantee it's a numeric value    ]---->
  <cfif not(isnumeric( EFTPOSChange ) )>
    <cfset EFTPOSChange = '0' />
  </cfif>
  </cfsilent>
  <div id="report">
    <table>
      <tr>
        <th >&nbsp;</th>
        <th>Terminal</th>
        <th>Pay Type</th>
        <th>Tendered</th>
        <th>Change</th>
        <th>Sales</th>
        <th>Trans Type</th>
      </tr>
      <cfset storeTotal = 0 >
      <cfset grandTotal = 0 >
      <cfoutput query="ReportData" group="storeid">
      <tr class="dark">
        <th colspan="7">#dateformat(Triggers.TransDate, "d/mmm/yyyy")# Store: #ReportEngine.getStoreName( ReportData.storeID )#</th>
      <cfoutput>
      <cfsilent>
      <cfparam name="reportdata.Change" default="0" />
      <cfif reportdata.MediaID eq '1'>
        <cfset lineChange = reportdata.Change + EFTPOSChange />
        <cfelse>
        <cfset lineChange = reportdata.Change - EFTPOSChange />
      </cfif>
      <cfif  reportdata.postype eq '3'>
        <cfset lineNet =   (ReportData.Salesnet * -1) />
        <cfelse>
        <cfset lineNet = ReportData.Salesnet  />
      </cfif>
      <cfset NetAmountAfterChange = lineNet - lineChange />
      </cfsilent>
      <tr class="lite">
        <td >#dateformat(reportdata.TransDate, "d / mmm / yyyy")#</td>
        <td align="center">#reportdata.terminalid#</td>
        <td align="left">#Reportengine.getMediaType( reportdata.MediaID )#</td>
        <td align="right">#dollarformat( lineNet  )#</td>
        <td align="right"><cfif linechange GT 0 >
            #dollarformat(lineChange)#
            <cfelse>
            &nbsp;
          </cfif></td>
        <td align="right">#dollarformat(NetAmountAfterChange)#</td>
        <td align="center">#reportdata.postype#</td>
       </tr>
      <cfset storeTotal = storeTotal + NetAmountAfterChange />
      <cfset grandTotal = grandTotal + NetAmountAfterChange />
      </cfoutput>
      <tr  class="subtotal">
        <td colspan="5" align="right">Store total: </td>
        <td align="right">#dollarformat(storeTotal)#</td>
        <td>&nbsp;</td>
      </tr>
      <cfset storeTotal = 0 >
        </tr>
      
      </cfoutput>
      <cfoutput>
      <tr class="grandtotal">
        <th colspan="5" align="right">Grand total: </th>
        <th  align="right">#dollarformat(grandTotal)#</th>
        <th>&nbsp;</th>
      </tr>
      </cfoutput>
    </table>
  </div>
</cfif>
<cfif application.siteversion is "development">
  <cfdump var="#ReportData#">
</cfif>
</body>
</html>