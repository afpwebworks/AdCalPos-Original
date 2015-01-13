<cfset lngStoreID = #form.txtStoreId#>

 <cfset local.startDate=createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2))>
<!--- - wb 12/01/2004 - Setup display date - --->
<cfset local.endDate=createDate(left(form.eDate,4),mid(form.eDate,5,2),mid(form.eDate,7,2))>

<CFQUERY name="GetStoreNames" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >  SELECT StoreName
	FROM tblStores where 1=1
		<CFIF NOT listfindNoCase(form.txtStoreId, "all") >
			  and storeID in (#txtStoreId#) 
		</cfif>
	</CFQUERY>
 <CFIF ParameterExists(Form.btnPNLSum)>
	<CFLOCATION url="ReportMenuPNLSummary.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnPNLSumAllStores)>
	<CFLOCATION url="ReportMenuPNLSummaryAllStores.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnInventoryReport)>
	<CFLOCATION url="ReportMenuInventory.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<!--- KF Jan 04, allow inventory movement report --->
<CFIF ParameterExists(Form.btnInventoryMovementReport)>
	<CFLOCATION url="StockMovementReportSelection.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>
<!--- end --->

<CFIF ParameterExists(Form.btnWastageSummary)>
	<CFLOCATION url="ReportMenuWastageReport.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnTransferSummary)>
	<CFLOCATION url="ReportMenuTransferReport.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnShowSalesAll)>
	<CFLOCATION url="ReportMenuSales.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&ALL=1&RequestTimeout=300&pcod=1" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnShowSalesDept)>
	<CFLOCATION url="ReportMenuSales.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnShowSalesGlobal)>
	<CFLOCATION url="ReportMenuSalesGlobal.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnInvoiceSummary)>
	<CFLOCATION url="ReportInvoiceSummaryByInvoice.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnShowPLUSalesGP)>
	<CFLOCATION url="ReportMenuSalesGP.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnSummaryDailyIncome)>
	<CFLOCATION url="ReportDailyIncome.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnStockAdjustments)>
	<CFLOCATION url="StockAdjustmentsReport.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&RequestTimeout=300" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnplusalesrecipes)>
	<CFLOCATION url="ReportMenuSales.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#&ALL=1&RequestTimeout=300&pcod=0" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnSalesReport)>
	<CFLOCATION url="SalesOrderReport.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#" addtoken="no">
</cfif>

<CFIF ParameterExists(Form.btnSalesReportPaymentTypes)>
	<CFLOCATION url="SalesOrderReportPaymentTypes.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#" addtoken="no">
</cfif>
<CFIF ParameterExists(Form.btnSalesReportProductByStore)>
	<CFLOCATION url="SalesReportProductByStore.cfm?FD=#dateFormat(local.startDate,"yyyymmdd")#&TD=#dateFormat(local.endDate,"yyyymmdd")#&SID=#lngStoreID#" addtoken="no">
</cfif>




