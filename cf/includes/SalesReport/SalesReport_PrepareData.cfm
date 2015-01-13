<cfsilent>
<!----
==========================================================================================================
Filename:     SalesReport_PrepareData.cfm
Description:  Gathers and Prepares data for the Sales Report
Date:         27/8/2012
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
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
totals.SalesCost = 0;
totals.salesgross = 0;
totals.salesdiscount = 0;
totals.salessurcharge = 0;
totals.salesnet = 0;
totals.gp = 0;
totals.GTSalesCost = 0;
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
	StoreDetail = Reportengine.getStores( storeID, session.employeeid, session.usertype ) ;
</cfscript>
</cfif>


</cfsilent>
