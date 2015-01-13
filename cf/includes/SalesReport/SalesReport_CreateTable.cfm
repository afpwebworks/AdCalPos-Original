<cfsilent>
<!----
==========================================================================================================
Filename:     SalesReport_CreateTable.cfm
Description:  Generates the output table for the report
Date:         27/8/2012
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
</cfsilent>

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
            ReportData.SalesCost = (ReportData.SalesCost * -1);
            ReportData.salesgross = (ReportData.salesgross * -1);
            ReportData.salesdiscount = (ReportData.salesdiscount * -1);
            ReportData.salessurcharge = (ReportData.salessurcharge * -1);
            ReportData.salesnet = (ReportData.salesnet * -1);
            ReportData.gp = ((ReportData.salesnet - ReportData.SalesCost ) * -1);
        </cfscript>
 </cfif>
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
    <td align="right">#dollarformat(totals.SalesCost)#</td>
    <td align="right">#dollarformat(totals.gp)#</td>
    <td align="center">&nbsp;</td>
  </tr></cfoutput>
 <cfsilent>
 	<cfscript>
		totals.SalesCost = 0;
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
    <td align="right">#dollarformat(ReportData.SalesCost)#</td>
    <td align="right">#dollarformat(ReportData.salesnet - ReportData.SalesCost)#</td>
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
    <td align="right">#dollarformat(totals.SalesCost)#</td>
    <td align="right">#dollarformat(totals.gp)#</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr class="grandtotal">
    <th colspan="4" align="right" >Total for this report: </th>
    <th align="right" >#dollarformat(totals.GTsalesgross)#</th>
    <th align="right" >#dollarformat(totals.GTsalesdiscount)#</th>
    <th align="right" >#dollarformat(totals.GTsalessurcharge)#</th>
    <th align="right" >#dollarformat(totals.GTsalesnet)#</th>
    <th align="right" >#dollarformat(totals.GTSalesCost)#</th>
    <th align="right" >#dollarformat(totals.GTgp)#</th>
    <th align="center" >&nbsp;</th>
  </tr>
  
  </cfoutput>
</table>
</div>
</cfif>