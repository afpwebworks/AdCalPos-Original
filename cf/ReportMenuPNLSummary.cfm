
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>
	<cfset strPageTitle = "">

	<!--- Get the store name --->
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > SELECT *
	FROM tblStores where 1=1
		<CFIF lngStoreID is not "all">
		
			  and storeID in (#lngStoreID#) 
			  
		</cfif>
	</CFQUERY>

	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	
	
	<cfset strQuery = "SELECT * from tblOptions ">
	<CFQUERY name="GetOptions" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset FranchiseFeePercentage = 0>
	<cfif #GetOptions.RecordCount# GT 0>
		<cfif #isnumeric(GetOptions.FranchiseFeePercentage)#>
			<cfset FranchiseFeePercentage = #GetOptions.FranchiseFeePercentage#>
		</cfif>	
	</cfif>
	<cfset MarketingFeePercentage = 0>
	<cfif #GetOptions.RecordCount# GT 0>
		<cfif #isnumeric(GetOptions.MarketingFeePercentage)#>
			<cfset MarketingFeePercentage = #GetOptions.MarketingFeePercentage#>
		</cfif>	
	</cfif>
	
	<cfset strQuery = "SELECT Sum(RoundingsD) AS SSRoundingsD, Sum(Discounts) AS SSDiscounts, ">
	<cfset strQuery = strQuery & "Sum(DiscountD) AS SSDiscountD, Sum(CashSales) AS SSCashSales, ">
	<cfset strQuery = strQuery & "Sum(CashSalesD) AS SSCashSalesD, Sum(CreditSales) AS SSCreditSales, ">
	<cfset strQuery = strQuery & "Sum(CreditSalesD) AS SSCreditSalesD, Sum(EFTCashOut) AS SSEFTCashOut, ">
	<cfset strQuery = strQuery & "Sum(EFTCashOutD) AS SSEFTCashOutD, ">
	<cfset strQuery = strQuery & "Sum(CashRefunds) AS SSCashRefunds, Sum(CashRefundD) AS SSCashRefundD, ">
	<cfset strQuery = strQuery & "Sum(CreditRefunds) AS SSCreditRefunds, Sum(CreditRefundD) AS SSCreditRefundD, ">
	<cfset strQuery = strQuery & "Sum(CashSalesGSTincD) AS SSCashSalesGSTincD, ">
	<cfset strQuery = strQuery & "Sum(CashSaleGSTfreeD) AS SSCashSaleGSTfreeD, Sum(CreditSalesGSTincD) AS SSCreditSalesGSTincD, ">
	<cfset strQuery = strQuery & "Sum(CreditSalesGSTfreeD) AS SSCreditSalesGSTfreeD, Sum(GSTCashSaleD) AS SSGSTCashSaleD, ">
	<cfset strQuery = strQuery & "Sum(GSTCreditSaleD) AS SSGSTCreditSaleD, Sum(CashIn) AS SSCashIn, ">
	<cfset strQuery = strQuery & "Sum(CashInD) AS SSCashInD, Sum(CashOut) AS SSCashOut, Sum(CashOutD) AS SSCashOutD, ">
	<cfset strQuery = strQuery & "Sum(Cancellations) AS SSCancellations, ">
	<cfset strQuery = strQuery & "Sum(CancellationD) AS SSCancellationD, Sum(Sales) AS SSSales ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	
	<cfset strQuery = strQuery & "where" >
	<CFIF lngStoreID is not "all" >
	   <cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) and" >
	 </cfif> 
	 <cfset strQuery = strQuery & " ((year([date]) * 10000) + (month([date]) * 100) + (day([date])) between #lngFD# and #lngTD#) ">
	<CFQUERY name="GetData" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "SELECT Sum(CashInDraw) AS SSCashInDraw ">
	<cfset strQuery = strQuery & "FROM tblStore_CashInDraw ">
	
	<cfset strQuery = strQuery & "where" >
	 <CFIF #lngStoreID# is not "all">
	 <cfset strQuery = strQuery &  "(StoreID IN (#lngStoreID#) )and  ">
	 </cfif>
	  <cfset strQuery = strQuery & " ((year([date]) * 10000) + (month([date]) * 100) + (day([date])) between #lngFD# and #lngTD#) ">
	<CFQUERY name="GetCIDData" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset TotalCash = 0 >
	<cfset TotalCredit = 0>
	<cfset TotalCashAndCredit = 0>	
	<cfset TotalCustomer = 0>
	<cfset TotalAvgSales = 0>
	<cfset TotalGST = 0>
	<cfset TotalVoids = 0>
	<cfset TotalDiscount = 0>
	<cfset TotalGross = 0>
	<CFSET TotalNet = 0>
	<CFSET TotalCashInDraw = 0>
	<CFSET TotalDifference = 0>
	<CFSET TotalSSGSTCashSaleD = 0>
	<CFSET TotalSSGSTCreditSaleD = 0>
	<CFSET TotalSSCancellationD = 0>
	<cfset TotalCashAndCreditEXGST = 0>
	<cfset TotalCashAndCreditGSTFree = 0>
	<cfset TotalGSTVoidDiscount = 0>
	<cfset TotalSSCashSaleGSTfreeD = 0>
	<cfset TotalSSCreditSalesGSTfreeD = 0>
	
	<cfif #isnumeric(GetData.SSCancellationD)#>
		<cfset TotalSSCancellationD = #GetData.SSCancellationD# >
	</cfif>
	
	<cfif #isnumeric(GetData.SSCashSaleGSTfreeD)#>
		<!--- <cfset TotalSSCashSaleGSTfreeD = #GetData.SSCashSaleGSTfreeD# > --->
		<cfset TotalSSCashSaleGSTfreeD = #GetData.SSCashSalesGSTincD# + #GetData.SSCashSaleGSTfreeD# - #GetData.SSGSTCashSaleD#>
	</cfif>
				
	<cfif #isnumeric(GetData.SSGSTCashSaleD)#>
		<cfset TotalSSGSTCashSaleD = #GetData.SSGSTCashSaleD# >
	</cfif>
	
	<cfif #isnumeric(GetData.SSGSTCreditSaleD)#>
		<cfset TotalSSGSTCreditSaleD = #GetData.SSGSTCreditSaleD# >
	</cfif>
	 <cfif #isnumeric(GetData.SSCreditSalesGSTfreeD)#>
		<cfset TotalSSCreditSalesGSTfreeD = #GetData.SSCreditSalesGSTincD# + #GetData.SSCreditSalesGSTfreeD# - #GetData.SSGSTCreditSaleD#>
	</cfif> 
	
	<cfif #isnumeric(GetData.SSCashSalesD)#>
		<cfset TotalCash = #GetData.SSCashSalesD# >
		<cfset TotalCustomer = #GetData.SSCashSales# >
	</cfif>
	<cfif #isnumeric(GetData.SSCreditSalesD)#>
		<cfset TotalCredit = #GetData.SSCreditSalesD#>
		<cfset TotalCustomer = #TotalCustomer# + #GetData.SSCreditSales#>
	</cfif>
	
	<cfset TotalCashAndCredit = #TotalCash# + #TotalCredit#>	
	<cfset TotalCashAndCreditEXGST = #TotalSSGSTCashSaleD# + #TotalSSGSTCreditSaleD#>
	<cfset TotalCashAndCreditGSTFree = #TotalSSCashSaleGSTfreeD# + #TotalSSCreditSalesGSTfreeD#>
    <cfif TotalCustomer GT 0>
		<cfset TotalAvgSales = (TotalCash + TotalCredit) / TotalCustomer>
	<cfelse>
		<cfset TotalAvgSales = 0>
	</cfif>
	<cfif #isnumeric(GetData.SSGSTCashSaleD)#>
		<cfset TotalGST = #GetData.SSGSTCashSaleD# >
	</cfif>
	<cfif #isnumeric(GetData.SSGSTCreditSaleD)#>
		<cfset TotalGST = #TotalGST# + #GetData.SSGSTCreditSaleD# >
	</cfif>
	<cfif #isnumeric(GetData.SSCashRefundS)#>
		<cfset TotalVoids = #GetData.SSCashRefundS# >
	</cfif>
	<cfif #isnumeric(GetData.SSCreditRefundS)#>
		<cfset TotalVoids = #TotalVoids# + #GetData.SSCreditRefundS#>
	</cfif>
	<cfif #isnumeric(GetData.SSDiscountD)#>
		<cfset TotalDiscount = #GetData.SSDiscountD#>
	</cfif>
	<cfset TotalGross = #TotalCash# + #TotalCredit# + #TotalGST# + #TotalVoids# + #TotalDiscount# >
	
	<cfset TotalGSTVoidDiscount = #TotalGST# + #TotalSSCancellationD# + #TotalDiscount# >
	
	<CFSET TotalNet = TotalGross - #TotalGST# - #TotalVoids# - #TotalDiscount#>
    <cfif #GetCIDData.RecordCount# GT 0>
		<cfif #isnumeric(GetCIDData.SSCashInDraw)#>
			<CFSET TotalCashInDraw = #GetCIDData.SSCashInDraw# >
		</cfif>	
	</cfif>
	<CFSET TotalDifference = #TotalCashInDraw# - #TotalNet#>

	<CFSET dblGrossTotalSales = #TotalCash# + #TotalCredit#>
	
	<CFSET dblTotalNetSalesExGST = #dblGrossTotalSales# - #TotalSSGSTCashSaleD# - #TotalSSGSTCreditSaleD# >
	
	<!--- Get the wasttage --->
	<cfset strQuery = "SELECT Sum(Wastage * Wholesale) AS WastageValue ">
	<cfset strQuery = strQuery & "FROM tblWastageLog ">
	<cfset strQuery = strQuery & "where">
	<CFIF #lngStoreID# is not "all">
	<cfset strQuery = strQuery & " (StoreID IN(#lngStoreID#)) and" >
	</cfif>
	<cfset strQuery = strQuery & " ((year([DateEntered]) * 10000) + (month([DateEntered]) * 100) + (day([DateEntered])) between #lngFD# and #lngTD#) ">
	<CFQUERY name="GetWastageValue" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<CFSET dblWastageValue = 0 >
    <cfif #GetWastageValue.RecordCount# GT 0>
		<cfif #isnumeric(GetWastageValue.WastageValue)#>
			<CFSET dblWastageValue = #GetWastageValue.WastageValue# >
		</cfif>	
	</cfif>
	
<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- Now get the data for the second part of this report --->

<!--- Get the starting stock --->

<cfset strQuery = "SELECT tblEodSummary.Date,  SUM(ISNULL(StartingStockValEx,0)) AS StartStock ">
<cfset strQuery = strQuery & " FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE">
 <cfset strQuery = strQuery & " ((tblEodSummary.Date)='#strDateFrom#') ">
 <CFIF #lngStoreID# is not "all">
   <cfset strQuery = strQuery & " AND ((tblEodSummary.StoreID) IN (#lngStoreID#)) ">
 </cfif>
 <cfset strQuery = strQuery & " Group by tblEodSummary.Date ">
<CFQUERY name="GetStartingStock" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>
<!--- <cfset dblStartingStock = #GetStartingStock.StartStock#>--->
<cfset dblStartingStock = 0>
<cfif #GetStartingStock.RecordCount# GT 0>
	<cfif #isnumeric(GetStartingStock.StartStock)#>
		<cfset dblStartingStock = #GetStartingStock.StartStock#>
	</cfif>	
</cfif>

<!--- Get the ending stock --->
<cfset strQuery = "SELECT tblEodSummary.Date, SUM(ISNULL(EndingStockValEx,0)) AS EndingStock ">
<cfset strQuery = strQuery & " FROM tblEodSummary ">
<cfset strQuery = strQuery & " WHERE ((tblEodSummary.Date)='#strDateTo#')  ">
 <CFIF #lngStoreID# is not "all">
 <cfset strQuery = strQuery & " AND ((tblEodSummary.StoreID)IN (#lngStoreID#))">
 
 </cfif>
 <cfset strQuery = strQuery & " Group by tblEodSummary.Date      ">
<CFQUERY name="GetEndinfStock" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>
<!--- <cfset dblEndingStock = ISNULL(#GetEndinfStock.EndingStock#,0)> --->
<cfset dblEndingStock = 0>
<cfif #GetEndinfStock.RecordCount# GT 0>
	<cfif #isnumeric(GetEndinfStock.EndingStock)#>
		<cfset dblEndingStock = #GetEndinfStock.EndingStock#>
	</cfif>	
</cfif>

<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	

<!--- Get the Purchase amount and the stock variance --->
<!--- 
<cfset strQuery = "SELECT SUM(GrandTotalIncGST) AS SSGrandTotalIncGST, SUM(GrandTotalGST) AS SSGrandTotalGST, SUM(GrandTotalGoods) AS SSGrandTotalGoods ">
<cfset strQuery = strQuery & "FROM dbo.qryInvoiceDetailTotal ">
<cfset strQuery = strQuery & "WHERE (SortDate BETWEEN #lngFD# AND #lngTD#) AND (TheStoreID = #lngStoreID#)">
 --->
<cfset strQuery = "SELECT SUM(GrandTotalIncGST) AS SSGrandTotalIncGST, SUM(GrandTotalGST) AS SSGrandTotalGST, SUM(GrandTotalGoods) AS SSGrandTotalGoods ">
<cfset strQuery = strQuery & "FROM qryInvoiceDetailTotalByPCode ">
<cfset strQuery = strQuery & "WHERE (Pcode = 0) AND (SortDate BETWEEN #lngFD# AND #lngTD#) ">
<CFIF #lngStoreID# is not "all">
 <cfset strQuery = strQuery & " AND (TheStoreID IN (#lngStoreID#))">
</cfif>
<CFQUERY name="GetPurchases" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblPurchaseExGST = 0>
<cfif #GetPurchases.RecordCount# GT 0>
	<cfif #isnumeric(GetPurchases.SSGrandTotalGoods)#>
		<cfset dblPurchaseExGST = #GetPurchases.SSGrandTotalGoods#>
	</cfif>
</cfif>

<cfset dblStockUsed = dblStartingStock + dblPurchaseExGST - dblEndingStock >

<cfset strQuery = "SELECT Sum([Wholesale]*([AF_QtyOnHand] - [B4_QtyOnHand])) AS dblValue ">
<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
<cfset strQuery = strQuery & "WHERE (CONVERT(int, SUBSTRING(DDate, 5, 4) + SUBSTRING(DDate, 3, 2) + SUBSTRING(DDate, 1, 2)) BETWEEN #lngFD# AND #lngTD# ) ">
<CFIF #lngStoreID# is not "all">
<cfset strQuery = strQuery & " AND (tblStocktakeLogVariance.StoreID IN (#lngStoreID#))" >
</cfif>
<CFQUERY name="UpdateStocktakeVariance" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblStockVariance = 0>
<cfif #UpdateStocktakeVariance.RecordCount# GT 0>
	<cfif #isnumeric(UpdateStocktakeVariance.dblValue)#>
		<cfset dblStockVariance = #UpdateStocktakeVariance.dblValue#>
	</cfif>
</cfif>

<cfset strQuery = "SELECT Sum( TaxableIncome + NonTaxableIncome ) AS dblValue ">
<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (CONVERT(int, SUBSTRING(WeekEnding, 5, 4) + SUBSTRING(WeekEnding, 3, 2) + SUBSTRING(WeekEnding, 1, 2)) BETWEEN #lngFD# AND #lngTD# ) ">
<CFIF #lngStoreID# is not "all">
<cfset strQuery = strQuery & "AND (StoreID IN (#lngStoreID#))">
</cfif>
<CFQUERY name="GetWages" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblWagesPaid = 0>
<cfif #GetWages.RecordCount# GT 0>
	<cfif #isnumeric(GetWages.dblValue)#>
		<cfset dblWagesPaid = #GetWages.dblValue#>
	</cfif>
</cfif>

<cfif TotalGross GT 0>
	<cfset dblWagesPercentage = 100 * (dblWagesPaid / dblTotalNetSalesExGST) >
<cfelse>
	<cfset dblWagesPercentage = 0>
</cfif>

<cfset strQuery = "SELECT tblSupExpenseCat.ExpenseCat, ">
<cfset strQuery = strQuery & "SUM(tblSupplierTranDet.TotalAmountIncGST - tblSupplierTranDet.GST) AS ExGSTVal , SUM(tblSupplierTranDet.TotalAmountIncGST) AS IncGSTVal , SUM(tblSupplierTranDet.GST) AS GSTVal ">
<cfset strQuery = strQuery & "FROM tblSupplierTranDet INNER JOIN tblSupExpenseCat ON tblSupplierTranDet.ExpenseCatID = tblSupExpenseCat.ExpenseCatID ">
<CFIF #lngStoreID# is not "all">
<cfset strQuery = strQuery & "WHERE (tblSupplierTranDet.StoreID IN(#lngStoreID#)) ">
</cfif> 
<cfset strQuery = strQuery & "AND (CONVERT(int, SUBSTRING(PurchaseDate, 5, 4) + SUBSTRING(PurchaseDate, 3, 2) + SUBSTRING(PurchaseDate, 1, 2)) BETWEEN #lngFD# AND #lngTD# ) ">
<cfset strQuery = strQuery & "GROUP BY tblSupExpenseCat.ExpenseCat">
<CFQUERY name="GetExpenses" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblTotalStockUsed = #dblStartingStock# + #dblPurchaseExGST# - #dblEndingStock# >
<cfset dblGrossProfit = #dblTotalNetSalesExGST# - #dblTotalStockUsed# >			  
<cfset dblGrossProfiPercentage = 0 >
<cfif #abs(dblTotalNetSalesExGST)#  GT 0.000001 >
	<cfset dblGrossProfiPercentage = 100 * #dblGrossProfit# / #dblTotalNetSalesExGST# >
</cfif>

<cfset strQuery = "SELECT  sum([QtySupplied]*[SCtoStoreUnitPriceExG]*[TaxRate]) AS Tax ">
<cfset strQuery = strQuery & "FROM (tblOrderInvoiceDetail INNER JOIN tblOrderInvoiceHeader ON tblOrderInvoiceDetail.InvoiceID = tblOrderInvoiceHeader.InvoiceID) LEFT JOIN tblTax ON tblOrderInvoiceDetail.TCode = tblTax.TaxID ">
<cfset strQuery = strQuery & "where substring(tblOrderInvoiceHeader.InvoiceDate,5,4) + substring(tblOrderInvoiceHeader.InvoiceDate,3,2) + substring(tblOrderInvoiceHeader.InvoiceDate,1,2) between #lngFD# AND #lngTD# ">

<CFIF #lngStoreID# is not "all">
<cfset strQuery = strQuery & "and tblOrderInvoiceDetail.StoreID IN(#lngStoreID#) ">
</cfif>
<CFQUERY name="GetInoiceTax" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset InvoiceTax = 0 >
<cfif #GetInoiceTax.recordcount# GT 0>
	<cfif #isnumeric(GetInoiceTax.Tax)#>
		<cfset InvoiceTax = #GetInoiceTax.Tax# >
	</cfif>
</cfif>

<cfset FranchiseFee = FranchiseFeePercentage * (dblTotalNetSalesExGST) / 100 >
<cfset MarketingFee = MarketingFeePercentage * (dblTotalNetSalesExGST) / 100 >

<!--- <cfset strPageTitle = "#GetStoreDetail.StoreName# Profit & Loss Statement"> --->
 
<!--- Get the invoices grouped by Pcode --->
<cfset strQuery = "SELECT Pcode, SUM(GrandTotalIncGST) AS IncGSTVal, SUM(GrandTotalGST) AS GSTVal, SUM(GrandTotalGoods) AS ExGSTVal ">
<cfset strQuery = strQuery & "FROM qryInvoiceDetailTotalByPCode ">
<cfset strQuery = strQuery & "WHERE (Pcode <> 0 ) and (SortDate BETWEEN #lngFD# AND #lngTD#)">
 <CFIF #lngStoreID# is not "all">
 <cfset strQuery = strQuery & " AND (TheStoreID IN (#lngStoreID#))">
</cfif>
<cfset strQuery = strQuery & "Group by Pcode ">

<CFQUERY name="GetPcodedInvoices" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>


<cfset strPageTitle = "Profit & Loss Statement"> 
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
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
		
       		
	  
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td width="25%"> 
   	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
  </table>
  <cfoutput>
<!---    <table  width="850" border="0" align="center" "cellspacing="0" cellpadding="0">  --->
   <table  width="750" border="0" align="center" "cellspacing="0" cellpadding="0"> 
		<tr> 
            <td width="200" align="left"> &nbsp;</td>				
			 <td width="150"align="right"><b><font size="2">Ex GST</font></b></td>
			 <td width="150"align="right"><b><font size="2">GST Amount</font></b></td>
			 <td width="100" align="right"><b><font size="2">Total ($)</font></b></td>
			 <td>&nbsp;</td>
			 
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="3" align="right"><hr color="black" size="2"></hr></td>
		</tr> 
		<tr>
			<td align="left"><font size="2">Cash Sales</font></td>
			<td align="right"><font size="2">#numberformat(TotalSSCashSaleGSTfreeD,"_______.00")#</font></td>

           	<td align="right"><font size="2">#numberformat(TotalSSGSTCashSaleD,"_______.00")#</font></td>
			<td align="right"><font size="2">#numberformat(TotalCash,"_______.00")#</font></td>
        </tr>
		<tr>
			<td align="left"><font size="2">Credit Cards Sales</font></td>
           <td align="right"><font size="2">#numberformat(TotalSSCreditSalesGSTfreeD,"_______.00")#</font></td>
			<td align="right"><font size="2">#numberformat(TotalSSGSTCreditSaleD,"_______.00")#</font></td>
			<td align="right"><font size="2">#numberformat(TotalCredit,"_______.00")#</font></td>
        </tr>
		<tr>
			<td align="left"> <font size="2">Invoice Sales</font></td>
            <td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right"><font size="2"><!--- #numberformat(invoiceSales,"_______.00")#</font> ---></td>
        </tr>
		<tr>
			<td colspan="4" align="right"><hr color="black" size="2"></hr></td>
		</tr> 
		<tr>
			<td align="left"> <font size="2">Gross Total Sales</font></td>
            <td align="right"><font size="2">#numberformat(TotalCashAndCreditGSTFree ,"_______.00")#</font></td>
			<td align="right"><font size="2">#numberformat(TotalCashAndCreditEXGST ,"_______.00")#</font></td>
			<td align="right"><font size="2">#numberformat(dblGrossTotalSales ,"_______.00")#</font></td>
        </tr>
		
		<tr>
			<td colspan="4" align="right"><hr color="black" size="2"><!--- <hr color="black" size="1"></hr> ---></td>
		</tr> 
<!--- 	     <tr>
			<td>&nbsp;</td> 
		  </tr>
 --->		 <tr> 
            <td align="left"><font size="2">GST Collected</font></td>
			<td> &nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(TotalSSGSTCashSaleD + TotalSSGSTCreditSaleD ,"_______.00")#</font></td>
          </tr>
          <tr> 
            <td align="left"><font size="2">Voids</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(TotalSSCancellationD,"_______.00")#</font></td>
          </tr>
          <tr> 
            <td align="left"><font size="2">Discounts</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(TotalDiscount,"_______.00")#</font></td>
          </tr>
		  <tr>
			<td colspan="4" align="right"><hr color="black" size="2"></hr></td>
		  </tr> 
		  <tr> 
            <td align="left"><font size="2">Total ($)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(TotalGSTVoidDiscount,"_______.00")#</font></td>
          </tr>
		  <tr>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
			<td colspan="2">&nbsp;</td>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
		  </tr>
          <tr> 
            <td align="left"><font size="2">Total net sales ex GST</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><br><font size="2"><b>#numberformat(dblTotalNetSalesExGST,"_______.00")#</b></font></td>
          </tr>
		  <tr>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
			<td colspan="2">&nbsp;</td>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
		  </tr>
          <tr> 
            <td align="left"><font size="2">Starting stock</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblStartingStock,"_______.00")#</font></td>
          </tr>
          <tr> 
            <td align="left"><font size="2">Purchases (ex.GST)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblPurchaseExGST,"_______.00")#</font></td>
          </tr>
          <tr> 
            <td align="left"><font size="2">Closing Stock Actual</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblEndingStock,"_______.00")#</font></td>
          </tr>
		  <tr> 
            <td align="left"><font size="2">Computer Stock($)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblEndingStock - dblStockVariance ,"_______.00")#</font></td>
          </tr>
		  <tr>
			<td  align="right"><hr color="black" size="2"></hr></td>
			<td colspan="2">&nbsp;</td>
			<td  align="right"><hr color="black" size="2"></hr></td>
		  </tr>
          <tr> 
            <td align="left"><font size="2">Total Stock used</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblTotalStockUsed ,"_______.00")#</font></td>
          </tr>
		 
          <tr> 
            <td align="left"><font size="2">Stock Discrepancy($)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblStockVariance,"_______.00")#</font></td>
          </tr>
		     <tr>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
			<td colspan="2">&nbsp;</td>
			<td  align="right"><hr color="black" size="2"><hr color="black" size="1"></hr></td>
		  </tr>
          <tr> 
            <td align="left"><font size="2">Wastage</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2">#numberformat(dblWastageValue,"_______.00")#</font></td>
          </tr>

          <tr> 
            <td>&nbsp;</td>
			<td>&nbsp;</td>
          </tr>
          <tr> 
            <td align="left"><font size="2">Gross Profit($)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2"><hr color="black" size="2"></hr>#numberformat(dblGrossProfit,"_______.00")#<hr color="black" size="2"></hr></font></td>
          </tr>
          <tr> 
            <td align="left"><b><font size="2">Gross Profit(%)</font></b></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2"><hr color="black" size="1"></hr>#numberformat(dblGrossProfiPercentage,"_______.00")#<hr color="black" size="2"></hr></font></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
			<td>&nbsp;</td>
          </tr>

          <tr> 
            <td align="left"><font size="2">Remuneration gross($)</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2"><hr color="black" size="2"></hr>#numberformat(dblWagesPaid,"_______.00")#</font></td>
          </tr>
          <tr>
            <td align="left"><b><font size="2">Remuneration gross(%)</font></b></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td align="right"><font size="2"><hr color="black" size="2"></hr><hr color="black" size="1"></hr>#numberformat(dblWagesPercentage,"_______.00")#<hr color="black" size="2"></hr></font></td>
          </tr>
		  <tr>
            <td align="left"><font size="2">Customer Count</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
           <!---  <td align="right"><font size="2">#numberformat(TotalCustomer,"_______.00")#</font></td> --->
		    <td align="right"><font size="2">#TotalCustomer#<hr color="black" size="2"></hr></font></td>
          </tr>
  </cfoutput>
  <!--- </table>
   <table  width="800" border="0" align="center "cellspacing="0" cellpadding="0">  --->
  		<tr><td colspan="5">&nbsp;</td></tr>
		 <tr align="left">
		    <td align="left" width="200"><b>Shop Expense</b></td>
		    <td align="right" width="150"><b>Ex GST</b></td>
		    <td align="right" width="150"><b>GST Amount</b></td>
		    <td align="right" width="150"><b>Total ($)</b></td>
			<td align="right" width="100"><b>% net sales</b></td>
		  </tr>
		  <tr><td colspan="5"><hr color="black" size="2"></hr></td></tr>
  		  <cfset dblTotalExpense = 0 >		  
  		  <cfset dblTotalExpenseInc = 0 >		  
   		  <cfset dblTotalShopExpenseGST = 0 >		  
		  <cfoutput query = "GetExpenses">
			  <tr> 
			    <td align="left" width="200"><font size="2">#GetExpenses.ExpenseCat#</font></td>
			    <td align="right" width="150"><font size="2">#numberformat(GetExpenses.ExGSTVal,"_______.00")#</font></div></td>
			    <td align="right" width="150"><font size="2">#numberformat(GetExpenses.GSTVal,"_______.00")#</font></div></td>
			    <td align="right" width="150"><font size="2">#numberformat(GetExpenses.IncGSTVal,"_______.00")#</font></div></td>
				
				 <td align="right" width="100">
				 	<cfif dblTotalNetSalesExGST neq 0>
				 		<font size="2">#numberformat(100*GetExpenses.ExGSTVal/dblTotalNetSalesExGST,"_______.00")#%</font></div>
					</cfif>
				 </td>
				
			  </tr>
			  
				<cfif isnumeric(GetExpenses.ExGSTVal)>
					<cfset dblTotalExpense = dblTotalExpense + #GetExpenses.ExGSTVal#>
					<cfset dblTotalExpenseInc = dblTotalExpenseInc + #GetExpenses.IncGSTVal#>
					<cfset dblTotalShopExpenseGST = dblTotalShopExpenseGST + #GetExpenses.GSTVal#>
				</cfif>
		  </cfoutput>
		  <cfoutput>
		     <tr> 
            	<td align="left" width="200"><font size="2">Franchise Fee(#FranchiseFeePercentage# %)</font></td>
           	 	<td align="right" width="150"><font size="2">#numberformat(FranchiseFee,"_______.00")#</font></td>
				<td>&nbsp;</td>
				<td align="right" width="150"><font size="2">#numberformat(FranchiseFee,"_______.00")#</font></td>
				<td align="right" width="100">
					<cfif dblTotalNetSalesExGST neq "0">
						<font size="2">#numberformat(100*FranchiseFee/dblTotalNetSalesExGST,"_______.00")#%</font>
					</cfif>
				</td>
          	  </tr>
          	  <tr>
            	<td align="left" width="200"><font size="2">Marketing Fee(#MarketingFeePercentage# %)</font></td>
            	<td align="right" width="150"><font size="2">#numberformat(MarketingFee,"_______.00")#</font></td>
				<td>&nbsp;</td>
				<td align="right" width="150"><font size="2">#numberformat(MarketingFee,"_______.00")#</font></td>
				<td align="right" width="100">
					<cfif dblTotalNetSalesExGST neq "0">
						<font size="2">#numberformat(100*MarketingFee/dblTotalNetSalesExGST,"_______.00")#%</font>
					</cfif>
				</td>
          	  </tr>
		  </cfoutput>
		  
		  
		  <cfset dblTotalFranMktgExpense = #FranchiseFee# + #MarketingFee#>
		
		  <cfset dblGrandTotalExpense = dblTotalExpense + FranchiseFee + MarketingFee >
		  <cfset dblTotalExpenseGST = dblTotalShopExpenseGST >
		  <tr> 
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		  </tr>
		  	<tr><td colspan="5"><hr color="black" size="2"</hr></td></tr>
		  <tr>
		    <td align="left" width="200">Sub Total Shop Exp.</td>
		   <!---  <td><cfoutput><div align="right"><font size="2">#numberformat(dblTotalExpense,"_______.00")#</font></cfoutput></td> --->
			<td align="right" width="150"><cfoutput><font size="2">#numberformat(dblGrandTotalExpense,"_______.00")#</font></cfoutput></td>
		    <td width="150"><cfoutput><div align="right"><font size="2">#numberformat(dblTotalExpenseGST,"_______.00")#</font></cfoutput></td>
		    <td width="150"><cfoutput><div align="right"><font size="2">#numberformat(dblTotalExpenseInc + dblTotalFranMktgExpense,"_______.00")#</font></cfoutput></td>
			 <td align="right" width="100">
<!---
 			 	<cfoutput>
					<cfif dblTotalNetSalesExGST neq "0">
						<font size="2">
							#numberformat(100*dblTotalExpense/dblTotalNetSalesExGST,"_______.00")#%
						</font>
					</cfif>
				</cfoutput>
 --->
			</td>
		  </tr>
		  <tr><td colspan="5"><hr color="black" size="2"><!--- <hr color="black" size="1"></hr >---></td></tr>
		  <tr> 
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		  </tr>
		 
		  <tr align="left"> 
		    <td align="left" width="200"><b>Invoiced Expenses</b></td>
		    <td align="right" width="150"><b>Ex GST</b></td>
		    <td align="right" width="150"><b>GST Amount</b></td>
		    <td align="right" width="150"><b>Total ($)</b></td>
			<td align="right" width="100"><b>% net sales</b></td>
		  </tr>
		  <tr><td colspan="5"><hr color="black" size="2"></hr></td></tr>
  		  <cfset dblTotalExpense = 0 >		  
  		  <cfset dblTotalExpenseInc = 0 >		  
   		  <cfset dblTotalInvExpenseGST = 0 >		  
		  <cfoutput query = "GetPcodedInvoices">
			  <tr align="left" width="200"> 
				<cfif #GetPcodedInvoices.PCode# eq 1>
				    <td><font size="2">Cleaning</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 2>	
				    <td><font size="2">SCS Boxes</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 3>	
				    <td><font size="2">Freight</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 4>	
				    <td><font size="2">Amenities</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 5>	
				    <td><font size="2">Administration</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 6>	
				    <td><font size="2">FitOut</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 7>	
				    <td><font size="2">F&V Dry Goods</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 8>	
				    <td><font size="2">Dry Goods GST</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 9>	
				    <td><font size="2">Packaging</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 10>	
				    <td><font size="2">SFM Boxes</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 11>	
				    <td><font size="2">Marinades</font></td>
				<cfelseif #GetPcodedInvoices.PCode# eq 12>	
				    <td><font size="2">Dry Goods Non GST</font></td>
				<cfelse>
				    <td><font size="2">#GetPcodedInvoices.PCode#&nbsp;</font></td>
				</cfif>
				
			    <td align="right" width="150"><font size="2">#numberformat(GetPcodedInvoices.ExGSTVal,"_______.00")#</font></div></td>
			    <td align="right" width="150"><font size="2">#numberformat(GetPcodedInvoices.GSTVal,"_______.00")#</font></div></td>
			    <td align="right" width="150"><font size="2">#numberformat(GetPcodedInvoices.IncGSTVal,"_______.00")#</font></div></td>
				<td align="right" width="100">
					<cfif dblTotalNetSalesExGST neq "0">
						<font size="2">#numberformat(100*GetPcodedInvoices.ExGSTVal/dblTotalNetSalesExGST,"_______.00")#%</font></div>
					</cfif>
				</td>
			  </tr>
				<cfif isnumeric(GetPcodedInvoices.ExGSTVal)>
					<cfset dblTotalExpense = dblTotalExpense + #GetPcodedInvoices.ExGSTVal#>
					<cfset dblTotalExpenseInc = dblTotalExpenseInc + #GetPcodedInvoices.IncGSTVal#>
					<cfset dblTotalInvExpenseGST = dblTotalInvExpenseGST + #GetPcodedInvoices.GSTVal#>
				</cfif>
		  </cfoutput>
		  <tr><td colspan="5"><hr color="black" size="2"></hr></td></tr>
		  <tr>
		    <td align="left" width="200">SubTot Inv'cd Expense</td>
		    <td width="150"><cfoutput><div align="right"><font size="2">#numberformat(dblTotalExpense,"_______.00")#</font></cfoutput></td>
		    <td width="150"><cfoutput><div align="right"><font size="2">#numberformat(dblTotalInvExpenseGST,"_______.00")#</font></cfoutput></td>
		    <td width="150"><cfoutput><div align="right"><font size="2">#numberformat(dblTotalExpenseInc,"_______.00")#</font></cfoutput></td>
			<td align="right" width="100">
				<cfoutput>
					<cfif dblTotalNetSalesExGST neq "0">
						<font size="2">#numberformat(100*dblTotalExpense/dblTotalNetSalesExGST,"_______.00")#%</font>
					</cfif>
				</cfoutput></td>
		  </tr>
		  <tr><td colspan="5"><hr color="black" size="2"><!--- <hr color="black" size="1"></hr> ---></td></tr>
		  <cfset dblGrandTotalExpense = dblGrandTotalExpense + dblTotalExpense >
		  <cfset dblTotalExpenseGST = dblTotalExpenseGST + dblTotalInvExpenseGST >
		  <cfset InvoiceTax = InvoiceTax - dblTotalInvExpenseGST >
		  
		</table>
		 <cfoutput>
        <table align="center" width="600" border="0">
          <tr> 
            <td><font size="2">&nbsp;</font></td>
            <td><font size="2">&nbsp;</font></td>
          </tr>
          <tr>
            <td><font size="2">Total Expenses ($)</font></td>
            <td><div align="right"><font size="2">#numberformat(dblGrandTotalExpense,"_______.00")#</font><!--- <hr color="black" size="2"></hr> ---></td>
          </tr>
          <tr>
            <td><font size="2">Total GST Paid on Expenses ($)</font></td>
            <td><div align="right"><font size="2">#numberformat(dblTotalExpenseGST,"_______.00")#</font><!--- <hr color="black" size="2"></hr>---></td>
          </tr>
          <tr>
            <td><font size="2">Total GST Paid on Invoice ($)</font></td>
            <td><div align="right"><font size="2">#numberformat(InvoiceTax,"_______.00")#</font><!--- <hr color="black" size="2"></hr> ---></td>
          </tr>
          <tr> 
            <td><font size="2">&nbsp;</font></td>
            <td><font size="2">&nbsp;</font><hr color="black" size="2"></hr></td>
          </tr>

		  <tr>
            <td><font size="2">Total  ($)</font></td>
            <td><div align="right"><font size="2">#numberformat(dblGrandTotalExpense+dblTotalExpenseGST+InvoiceTax,"_______.00")#</font><hr color="black" size="2"><!--- <hr color="black" size="1"></hr> ---></td>
          </tr>
		  
		  <tr> 
            <td><font size="2">&nbsp;</font></td>
          </tr>
		  <tr> 
            <td><font size="2">&nbsp;</font></td>
          </tr>
		</table>
		<table align="center" width="600" border="0">
          <tr>
    	    <cfset dblProfitLoss = dblGrossProfit - dblWagesPaid - dblGrandTotalExpense >
            <td><b><font size="2">profit / loss ($) EBITDA</font></b></td>
            <td align="right"><b><font size="2">#numberformat(dblProfitLoss,"_______.00")#</b></font><hr color="black" size="2"></hr></td>
          </tr>
          <tr>
			<cfif abs(dblTotalNetSalesExGST) GT 0.00001>
    	    	<cfset dblProfitLossPercentage = 100 * (dblProfitLoss / dblTotalNetSalesExGST) >
			<cfelse>
    	    	<cfset dblProfitLossPercentage = 0 >
			</cfif>
            <td><b><font size="2">profit / loss (%) EBITDA</font></b></td>
            <td align="right"><b><font size="2">#numberformat(dblProfitLossPercentage,"_______.00")#%</font></b><hr color="black" size="2"></hr><!--- <hr color="black" size="1"></hr> ---></td>
          </tr>
        </table>
		</cfoutput>

</table>

</body>
</HTML>

