<cfsilent>
<!----
==========================================================================================================
Filename:     SalesReport_CreateSpreadsheet.cfm
Description:  Generates the output table for the report
Date:         27/8/2012
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfparam name="ReportStoreList" default="" />
  
<cfif isDefined("StoreDetail.recordCount")>
	 <cfif listfindNoCase(StoreID, "all")>
     <cfset ReportStoreList="All Stores" />
	 <cfelse>				 
		<cfif StoreDetail.recordCount GT 1> 
		   <cfloop query="StoreDetail">
				<cfset ReportStoreList = ReportStoreList & #StoreDetail.StoreName# & ' ' />
			</cfloop>
		<cfelse>
				<cfset ReportStoreList = StoreDetail.StoreName/>
		</cfif>
	</cfif>
</cfif>
        
        
</cfsilent>

<cfif isdefined("Reportdata")>
<cfscript>
	ReportTitle = "Sales Report for dates included #dateformat(Startdate, 'd / mmm / yyyy')# to #dateformat(Enddate, 'd / mmm / yyyy')#";
	//initalise the row counter
	Thisrow = '3';	
    Report=spreadsheetnew("Report");
	formatHeader=StructNew(); 
    formatHeader.font="Arial"; 
    formatHeader.fontsize="12"; 
    formatHeader.color="black"; 
    formatHeader.italic="false"; 
    formatHeader.bold="true"; 
    formatHeader.alignment="center"; 
    formatHeader.textwrap="false"; 
    formatHeader.fgcolor="white"; 
	formatHeader.topborder="thin";
	formatHeader.topbordercolor="blue_grey"; 
    formatHeader.bottomborder="thin"; 
    formatHeader.bottombordercolor="blue_grey"; 
    formatHeader.leftborder="thin"; 
    formatHeader.leftbordercolor="blue_grey"; 
    formatHeader.rightborder="thin"; 
    formatHeader.rightbordercolor="blue_grey";
	 
	formatGrandtotal=StructNew();
	formatGrandtotal.font="Arial"; 
    formatGrandtotal.fontsize="14"; 
    formatGrandtotal.color="black"; 
    formatGrandtotal.italic="false"; 
    formatGrandtotal.bold="true"; 
    formatGrandtotal.alignment="center"; 
    formatGrandtotal.textwrap="false"; 
    formatGrandtotal.fgcolor="white"; 
    formatGrandtotal.topborder="thin";
	formatGrandtotal.topbordercolor="blue_grey"; 	
    formatGrandtotal.bottomborder="double"; 
    formatGrandtotal.bottombordercolor="Black"; 
    formatGrandtotal.leftborder="thin"; 
    formatGrandtotal.leftbordercolor="blue_grey"; 
    formatGrandtotal.rightborder="thin"; 
    formatGrandtotal.rightbordercolor="blue_grey"; 
	
	// Define a format for the normal rows. 
    format1=StructNew() ;
    format1.font="Arial"; 
    format1.fontsize="9"; 
    format1.color="black"; 
    format1.italic="false"; 
    format1.bold="false"; 
    format1.alignment="left"; 
    format1.textwrap="true"; 
    format1.fgcolor="grey_25_percent";
	
	format2=StructNew();
	format2.font="Arial"; 
    format2.fontsize="9"; 
    format2.color="black"; 
    format2.italic="false"; 
    format2.bold="false"; 
    format2.alignment="left"; 
    format2.textwrap="true"; 
    format2.fgcolor="white"; 
   	
	formatReportHeader = structNew();
	formatReportHeader.font = "Arial";
	formatReportHeader.fontsize="14";
	formatReportHeader.alignment="center";
	formatReportHeader.bold="true";
	formatReportHeader2 = structNew();
	formatReportHeader.font = "Arial";
	formatReportHeader2.fontsize="11";
	formatReportHeader2.alignment="center";
	formatReportHeader2.bold="true";
    //Insert a header row.
	SpreadsheetMergeCells(Report, 1,1, 1, 11);
	SpreadsheetSetCellValue(Report, "#ReportTitle#", 1, 1);
	SpreadsheetFormatRows(Report,formatReportHeader,"1");
	SpreadsheetMergeCells(Report, 2,2, 1, 11);
	SpreadsheetSetCellValue(Report, "#ReportStoreList#", 2, 1);
	SpreadsheetFormatRows(Report,formatReportHeader2,"2");
   	SpreadsheetAddRow(Report,"Date,Store,  Location ID,Terminal ID,Gross,Discount,Surcharge,Net,Cost,Profit,Type",thisrow,1); 
	SpreadsheetFormatRow(Report,formatHeader, #thisrow#);
	Thisrow = thisrow + 1;
</cfscript>


<cfloop query="ReportData">

 <cfset qgetStoreName.storename = ReportEngine.getStoreName( ReportData.storeID ) />
<!---[   If this is a refund or a credit,  change the sign of the amounts in this record.   Totals will aautomatically reflect the negative in the totals.   ]---->
 <cfif reportdata.postype EQ 3>
		<cfscript>
            ReportData.SalesCost = (ReportData.SalesCost * -1);
            ReportData.salesgross = (ReportData.salesgross * -1);
            ReportData.salesdiscount = (ReportData.salesdiscount * -1);
            ReportData.salessurcharge = (ReportData.salessurcharge * -1);
            ReportData.salesnet = (ReportData.salesnet * -1);
            ReportData.gp = ((ReportData.salesnet - ReportData.SalesCost ) * -1);
        </cfscript>
 </cfif>

   <!---[    Decide if it's a subtotal or grandtotal   ]---->
<cfif (ReportData.transdate GT totals.Transdate) and (reportdata.currentrow GT 1)>

<!---[   If the current record's transdate is greater than the date in the totals struct, it must be a subtotal.   ]---->
<cfoutput>
<cfscript>
	SpreadsheetAddRow(Report, " , , ,Subtotal for #dateformat(totals.TransDate, 'd/mmm/yyyy')#, #totals.salesgross# , #totals.salesdiscount# , #totals.salessurcharge# , #totals.salesnet# , #totals.SalesCost# , #totals.gp# ,  ");
	SpreadsheetFormatRow(Report,formatHeader, #thisrow#);
	Thisrow = thisrow + 1;

	totals.SalesCost = 0;
	totals.salesgross = 0;
	totals.salesdiscount = 0;
	totals.salessurcharge = 0;
	totals.salesnet = 0;
	totals.gp = 0;
	</cfscript>
   </cfoutput> 
</cfif>
 
<!---[   Print a line   ]---->
<!---[    update the subtotals and gttotals with this record.   ]---->


<!---Change the sign of the values here.
LES 2010-05-07 changed that below --->

  <cfscript>
	totals.SalesCost = totals.SalesCost + ReportData.SalesCost;
	totals.salesgross = totals.salesgross + ReportData.salesgross;
	totals.salesdiscount = totals.salesdiscount + ReportData.salesdiscount;
	totals.salessurcharge = totals.salessurcharge + ReportData.salessurcharge;
	totals.salesnet = totals.salesnet + ReportData.salesnet;
	totals.gp = totals.gp + ReportData.salesnet - ReportData.SalesCost;
	totals.GTSalesCost = totals.GTSalesCost + ReportData.SalesCost;
	totals.GTsalesgross =totals.GTsalesgross + ReportData.salesgross;
	totals.GTsalesdiscount = totals.GTsalesdiscount + ReportData.salesdiscount;
	totals.GTsalessurcharge =totals.GTsalessurcharge + ReportData.salessurcharge;
	totals.GTsalesnet = totals.GTsalesnet + ReportData.salesnet;
	totals.GTgp = totals.GTgp + ReportData.salesnet - ReportData.SalesCost;
	//totals.Transdate = ReportData.Transdate;

   </cfscript>
	<cfif ReportData.postype EQ 3 >
          <cfset thisPostType = "Refunds" />
    <cfelseif ReportData.postype EQ 1>
          <cfset thisPostType = " " />
    <cfelse>
          <cfset thisPostType = ReportData.postype />
    </cfif>
	<cfset thisprofit = ReportData.salesnet - ReportData.SalesCost />

	<cfoutput>
     <cfscript>
      
       SpreadsheetAddRow(Report, "#dateformat(ReportData.TransDate, 'd/mmm/yyyy')# , #qgetStoreName.Storename# , #ReportData.locationID# , #ReportData.terminalid# ,  #ReportData.salesgross# , #ReportData.salesdiscount# , #ReportData.salessurcharge# , #ReportData.salesnet# , #ReportData.SalesCost# , #thisprofit# , #thisPostType#");
         if ((thisrow mod 2) eq 1)  {
            SpreadsheetFormatRow(Report,format1, #thisrow#) ;
		 } 
		 else {
			 SpreadsheetFormatRow(Report,format2, #thisrow#) ;
		 }
         totals.Transdate = ReportData.Transdate;
        Thisrow = thisrow + 1;
      </cfscript>  
     </cfoutput> 
	

  </cfloop>
  
<!---[   Now it's the end, so print a subtotal, and a grand total.   ]---->  
 <cfoutput>
 <cfscript>
 	//SpreadsheetMergeCells(Report,#thisrow#,#thisrow#, 1, 4);
	SpreadsheetAddRow(Report, " , , , Subtotal for #dateformat(totals.TransDate, 'd/mmm/yyyy')# , #totals.salesgross# , #totals.salesdiscount# , #totals.salessurcharge# , #totals.salesnet# , #totals.SalesCost# , #totals.gp# , " );
	SpreadsheetFormatRow(Report,formatHeader,#thisrow#);
	Thisrow = thisrow + 1;
	//SpreadsheetMergeCells(Report,#thisrow#,#thisrow#, 1, 4);
	SpreadsheetAddRow( Report, " , , , Total for this report:, #totals.GTsalesgross# , #totals.GTsalesdiscount# , #totals.GTsalessurcharge# , #totals.GTsalesnet# , #totals.GTSalesCost# , #totals.GTgp# ,  " );
	SpreadsheetFormatRow(Report,formatGrandtotal,#thisrow#);
	Thisrow = thisrow + 1; 

 
	format2=structnew();
	format2.alignment="right";
	Spreadsheetformatcolumns(Report,format2,"5-10");
	format3=structNew();
	format3.alignment="center";
	Spreadsheetformatcolumns(Report,format3,"3-4");
</cfscript> 
</cfoutput>

</cfif>

<!-------[  Output the file to the client - no need to write to disk.   ]----MK ----->
<cfheader name="content-disposition" value="attachment; filename=Report.xls">
<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(Report)#" reset="true" />
