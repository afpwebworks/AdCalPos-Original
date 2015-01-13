
<CFQUERY name="get_records" datasource="#application.dsn#" > 
   
   SELECT tblProductTypes.TypeDescription, tblProductTypes.TypeID,qryInvoiceDetail.PartNo, 		qryInvoiceDetail.DESCRIPTION, SUM(qryInvoiceDetail.QtySupplied) AS qty, AVG(qryInvoiceDetail.CostExG) 
               AS AvCostEx, SUM(qryInvoiceDetail.TotalPriceExTax) AS ShopItemTotalEx, SUM(qryInvoiceDetail.TotalTax) AS ShopTax, 
               SUM(qryInvoiceDetail.TotalPriceIncTax) AS ShopIncTax, SUM(qryInvoiceDetail.THinvoiceGoodsTotal) AS Sup2SCSTotalEx, 
               SUM(qryInvoiceDetail.THinvoiceUnitTaxTotal) AS Sup2SCSTotalTax, SUM(qryInvoiceDetail.THinvoiceUnitPriceIncTaxTotal) AS Sup2SCSTotalIncTax, 
               SUM(qryInvoiceDetail.SCRebateUnitExGTotal) AS SCSRebateTotal, SUM(qryInvoiceDetail.THRebateUnitExGTotal) AS SupplierRebateTotal
			   

   FROM  qryInvoiceDetail 
   INNER JOIN tblStockMaster ON qryInvoiceDetail.PartNo = tblStockMaster.PartNo 
   INNER JOIN tblProductTypes ON tblProductTypes.TypeID=tblStockMaster.TypeID
   
   
   WHERE (qryInvoiceDetail.lngDate >= #dateFormat(local.startDate,"yyyymmdd")#) 
   AND (qryInvoiceDetail.lngDate <=  #dateFormat(local.endDate,"yyyymmdd")#)
  
  		<CFIF form.r_storeId is not "all">
      		and storeID in (#form.r_storeId#)  
		</cfif>
 
   GROUP BY qryInvoiceDetail.DESCRIPTION, qryInvoiceDetail.PartNo,
   			tblProductTypes.TypeDescription, tblProductTypes.TypeID
   ORDER BY  tblProductTypes.TypeDescription, qryInvoiceDetail.DESCRIPTION 


</CFQUERY>
