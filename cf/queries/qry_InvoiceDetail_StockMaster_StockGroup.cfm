
<CFQUERY name="get_records" datasource="#application.dsn#" > 
   SELECT qryInvoiceDetail.PCode, tblStockGroup.DeptNo, qryInvoiceDetail.PartNo,qryInvoiceDetail.DESCRIPTION, SUM(qryInvoiceDetail.QtySupplied) AS qty, AVG(qryInvoiceDetail.CostExG) 
               AS AvCostEx, SUM(qryInvoiceDetail.TotalPriceExTax) AS ShopItemTotalEx, SUM(qryInvoiceDetail.TotalTax) AS ShopTax, 
               SUM(qryInvoiceDetail.TotalPriceIncTax) AS ShopIncTax, SUM(qryInvoiceDetail.THinvoiceGoodsTotal) AS Sup2SCSTotalEx, 
               SUM(qryInvoiceDetail.THinvoiceUnitTaxTotal) AS Sup2SCSTotalTax, SUM(qryInvoiceDetail.THinvoiceUnitPriceIncTaxTotal) AS Sup2SCSTotalIncTax, 
               SUM(qryInvoiceDetail.SCRebateUnitExGTotal) AS SCSRebateTotal, SUM(qryInvoiceDetail.THRebateUnitExGTotal) AS SupplierRebateTotal
			   ,DEPT
   FROM  qryInvoiceDetail 
   INNER JOIN tblStockMaster ON qryInvoiceDetail.PartNo = tblStockMaster.PartNo 
   INNER JOIN tblStockGroup ON tblStockMaster.GroupNo = tblStockGroup.GroupNo
   INNER JOIN tblStockDept ON tblStockGroup.Deptno  = tblStockDept.Deptno 
   
   
   WHERE (qryInvoiceDetail.lngDate >= #dateFormat(local.startDate,"yyyymmdd")#) 
   AND (qryInvoiceDetail.lngDate <= #dateFormat(local.endDate,"yyyymmdd")#)
   <CFIF form.r_storeId is not "all">
      and storeID in (#form.r_storeId#) 
   </cfif>
   GROUP BY qryInvoiceDetail.PCode, tblStockGroup.DeptNo, qryInvoiceDetail.DESCRIPTION, qryInvoiceDetail.PartNo ,DEPT
   ORDER BY qryInvoiceDetail.PCode, tblStockGroup.DeptNo, qryInvoiceDetail.DESCRIPTION
</CFQUERY>
