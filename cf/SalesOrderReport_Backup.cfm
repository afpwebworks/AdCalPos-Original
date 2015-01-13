<cfsilent>
<!----
==========================================================================================================
Filename:     SalesOrderReport.cfm
Description:  Sales Order Report for AdCalPos
Date:         7/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
18/4/2010  Integrated with existing system.

==========================================================================================================
--->
</cfsilent>
<!---[   Check for logged in and bounce out if not allowed entry   ]---->
<cfif session.logged Is not "yes">
	<cflocation url="/index.cfm" />
</cfif>

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
totals = structnew();
totals.salescost = 0;
totals.salesgross = 0;
totals.salesdiscount = 0;
totals.salessurcharge = 0;
totals.salesnet = 0;
totals.gp = 0;
totals.GTsalescost = 0;
totals.GTsalesgross = 0;
totals.GTsalesdiscount = 0;
totals.GTsalessurcharge = 0;
totals.GTsalesnet = 0;
totals.GTgp = 0;
totals.transdate = Startdate ;
</cfscript>
  
    
<cfif structKeyExists(url, "td" )>
<cfscript>
	ReportEngine =    application.beanfactory.getBean("Reporting");
	//thestartdate = createdatetime(form.startdateyear, form.startdatemonth, form.startdateday,"0","0","0");
	//theenddate = createdatetime(form.enddateyear, form.enddatemonth, form.enddateday,"23","59","59");
	ReportData = Reportengine.SalesReport( Startdate, Enddate, StoreID );
	StoreDetail = Reportengine.getStores( storeID ) ;
</cfscript>
</cfif>
<cfparam name="strPageTitle" default="Sales Report">
<HTML><HEAD>
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
<cfif application.siteversion is "development">
	<cfdump var="#url#">
    <cfdump var="#ReportData#" label="91: ReportData ">
    <cfdump var="#StoreDetail#" label="92: StoreDetail">
    
</cfif>
<table width="100%">
  <tr valign="center"> 
    <td width><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center" width="*"> 
      <h1><cfoutput>#strPageTitle# for dates included #dateformat(Startdate, "d / mmm / yyyy")# to #dateformat(Enddate, "d / mmm / yyyy")#</h1> </CFOUTPUT>
	  
	  <cfif isDefined("StoreDetail.recordCount")>
								 
				 <CFIF listfindNoCase(StoreID, "all")> All Stores
				 <CFELSE>				 
					<cfif StoreDetail.recordCount GT 1> 
						<p><cfloop query="StoreDetail">
								<cfoutput>#StoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#StoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td> 
	  <cfoutput>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#url.FD#&TD=#url.TD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
</table>
<cfif application.siteversion is "development">
	<cfdump var="#StoreDetail#" label="storedetail line 124" />
</cfif>   
<cfif isdefined("Reportdata")>
<div id="report" style="text-align:center;">
<table>
  <tr>
    <th>Date</th>
    <th>Store</th>
    <th>Location ID</th>
    <th>Terminal ID</th>
    <th>Gross</th>
    <th>Discount</th>
    <th>Surcharge</th>
    <th>Net</th>
    <th>Cost</th>
    <th>Profit</th>
    <th>Type</th>
  </tr>
  <cfloop query="ReportData">
 <cfsilent>
 
 <cfset qgetStoreName.storename = ReportEngine.getStoreName( ReportData.storeID ) />
<!---[   If this is a refund or a credit,  change the sign of the amounts in this record.   Totals will aautomatically reflect the negative in the totals.   ]---->
 <cfif reportdata.postype EQ 3>
		<cfscript>
            ReportData.salescost = (ReportData.salescost * -1);
            ReportData.salesgross = (ReportData.salesgross * -1);
            ReportData.salesdiscount = (ReportData.salesdiscount * -1);
            ReportData.salessurcharge = (ReportData.salessurcharge * -1);
            ReportData.salesnet = (ReportData.salesnet * -1);
            ReportData.gp = ((ReportData.salesnet - ReportData.salescost ) * -1);
        </cfscript>
 </cfif>

 
 
 
 <!---[   Query of queries to extract the correct storename for the storeID   ]---->
<!---[    <cfquery name="qgetStoreName" dbtype="query">
 	Select storename from StoreDetail where storeID = #ReportData.storeID#
 </cfquery>   ]---->
</cfsilent>

   <!---[    Decide if it's a subtotal or grandtotal   ]---->
<cfif (ReportData.transdate GT totals.Transdate) and (reportdata.currentrow GT 1)>
<!---[   If the current record's transdate is greater than the date in the totals struct, it must be a subtotal.   ]---->
<cfoutput><tr class="subtotal">
    <td colspan="4" align="right">Subtotal for #dateformat(totals.TransDate, "d/mmm/yyyy")#</td>
    <td align="right">#dollarformat(totals.salesgross)#</td>
    <td align="right">#dollarformat(totals.salesdiscount)#</td>
    <td align="right">#dollarformat(totals.salessurcharge)#</td>
    <td align="right">#dollarformat(totals.salesnet)#</td>
    <td align="right">#dollarformat(totals.salescost)#</td>
    <td align="right">#dollarformat(totals.gp)#</td>
    <td align="center">&nbsp;</td>
  </tr></cfoutput>
 <cfsilent>
 	<cfscript>
		totals.salescost = 0;
		totals.salesgross = 0;
		totals.salesdiscount = 0;
		totals.salessurcharge = 0;
		totals.salesnet = 0;
		totals.gp = 0;
	</cfscript>
 </cfsilent> 
</cfif>
 
<!---[   Print a line   ]---->
<cfsilent>
<!---[    update the subtotals and gttotals with this record.   ]---->


<!---Change the sign of the values here.
LES 2010-05-07 changed that below --->




   <cfscript>
	totals.salescost = totals.salescost + ReportData.salescost;
	totals.salesgross = totals.salesgross + ReportData.salesgross;
	totals.salesdiscount = totals.salesdiscount + ReportData.salesdiscount;
	totals.salessurcharge = totals.salessurcharge + ReportData.salessurcharge;
	totals.salesnet = totals.salesnet + ReportData.salesnet;
	totals.gp = totals.gp + ReportData.salesnet - ReportData.salescost;
	totals.GTsalescost = totals.GTsalescost + ReportData.salescost;
	totals.GTsalesgross =totals.GTsalesgross + ReportData.salesgross;
	totals.GTsalesdiscount = totals.GTsalesdiscount + ReportData.salesdiscount;
	totals.GTsalessurcharge =totals.GTsalessurcharge + ReportData.salessurcharge;
	totals.GTsalesnet = totals.GTsalesnet + ReportData.salesnet;
	totals.GTgp = totals.GTgp + ReportData.salesnet - ReportData.salescost;
	//totals.Transdate = ReportData.Transdate;

   </cfscript>


</cfsilent> 
  <cfoutput>
  <tr class="#IIf(CurrentRow Mod 2, DE('lite'), DE('dark'))#">
    <td>#dateformat(ReportData.TransDate, "d/mmm/yyyy")#</td>
    <td align="center">#qgetStoreName.Storename#</td>
    <td align="center">#ReportData.locationID#</td>
    <td align="center">#ReportData.terminalid#</td>
    <td align="right">#dollarformat(ReportData.salesgross)#</td>
    <td align="right">#dollarformat(ReportData.salesdiscount)#</td>
    <td align="right">#dollarformat(ReportData.salessurcharge)#</td>
    <td align="right">#dollarformat(ReportData.salesnet)#</td>
    <td align="right">#dollarformat(ReportData.salescost)#</td>
    <td align="right">#dollarformat(ReportData.salesnet - ReportData.salescost)#</td>
	<cfif ReportData.postype EQ 3 >
	    <td align="center">Refunds</td>
	<cfelse>
		<cfif ReportData.postype EQ 1>
	    		<td align="center">&nbsp;</td>
		<cfelse>
	    		<td align="center">#ReportData.postype#</td>
		</cfif>
	</cfif>
  </tr>
  </cfoutput>

<cfset totals.Transdate = ReportData.Transdate />
  </cfloop>
<!---[   Now it's the end, so print a subtotal, and a grand total.   ]---->  
<cfoutput>
<tr class="subtotal">
    <td colspan="4" align="right">Subtotal for #dateformat(totals.TransDate, "d/mmm/yyyy")#</td>
    <td align="right">#dollarformat(totals.salesgross)#</td>
    <td align="right">#dollarformat(totals.salesdiscount)#</td>
    <td align="right">#dollarformat(totals.salessurcharge)#</td>
    <td align="right">#dollarformat(totals.salesnet)#</td>
    <td align="right">#dollarformat(totals.salescost)#</td>
    <td align="right">#dollarformat(totals.gp)#</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr class="grandtotal">
    <th colspan="4" align="right" >Total for this report: </th>
    <th align="right" >#dollarformat(totals.GTsalesgross)#</th>
    <th align="right" >#dollarformat(totals.GTsalesdiscount)#</th>
    <th align="right" >#dollarformat(totals.GTsalessurcharge)#</th>
    <th align="right" >#dollarformat(totals.GTsalesnet)#</th>
    <th align="right" >#dollarformat(totals.GTsalescost)#</th>
    <th align="right" >#dollarformat(totals.GTgp)#</th>
    <th align="center" >&nbsp;</th>
  </tr>
  
  </cfoutput>
</table>
</div>
</cfif>
</body>
</html>
