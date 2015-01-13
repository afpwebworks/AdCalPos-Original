
<cfset lngStoreID = #form.SID#>
<cfset lngFD = #form.FD#>
<cfset lngTD = #form.TD#>
<!--- <CFSET tableSuffix = #INT(RAND() * 100000)#> --->

<CFOUTPUT>

  <CFSET fromDateProperFormat = #createDate(mid(lngFD,1,4),mid(lngFD,5,2),mid(lngFD,7,2))#>
  <CFSET toDateProperFormat = #createDate(mid(lngTD,1,4),mid(lngTD,5,2),mid(lngTD,7,2))#>
  <CFSET allDatesString = "">
  <CFSET allDatesStringDDMMYYYY = "">
  <CFLOOP from="#fromDateProperFormat#" to="#toDateProperFormat#" index="loop">
  
      <CFSET thisDate = #dateFormat(loop,"yyyymmdd")#><CFSET thisDate = "'" & #thisDate# & "'"><CFSET allDatesString = #listAppend(allDatesString,thisDate)#>
	  <CFSET thisDateDDMMYYYY = #dateFormat(loop,"ddmmyyyy")#><CFSET thisDateDDMMYYYY = "'" & #thisDateDDMMYYYY# & "'"><CFSET allDatesStringDDMMYYYY = #listAppend(allDatesStringDDMMYYYY,thisDateDDMMYYYY)#>
      
  </cfloop>
</cfoutput>
<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	
<!--- Get the store name --->
<cfset strQuery = "SELECT * from tblStores" >
	<cfif lngStoreID   is not "all">
	<cfset strQuery = strQuery & " where StoreID IN(#lngStoreID#)">
	</cfif>
<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>



<!--- get the Departments --->
<cfset strQuery = "SELECT * from tblStockDept ">
<CFIF cmbDeptNo is not 0>
   <cfset strQuery = strQuery & "WHERE deptNo in (#cmbDeptNo#) ">
</cfif>
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">
<CFQUERY name="GetDept" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<CFSET deptString = ValueList(GetDept.Dept)>
<cfset strPageTitle = "Stock Movement Report">

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
<STYLE type="text/css">
  <!--
     
	 .reportData { font-size : 12px; font-family : Arial, Helvetica, sans-serif; font-weight : normal;}
	 .reportHeader { font-size : 14px; font-family : Arial, Helvetica, sans-serif; font-weight : bold;}
	 
	 .headerTable { font-family: Arial, Arial, Helvetica; font-weight: bold; font-style: normal; font-size: 13pt ;}
TD { font-family: Arial, Arial, Helvetica; font-weight: normal; font-style: normal; font-size: 8pt ;}
.TDnoBorder { font-family: Arial, Arial, Helvetica; font-weight: normal; font-style: normal; font-size: 8pt ;border-bottom: 1px  solid FFFFFF;border-left: 0px;border-right: 0px; border-top: 1px  solid FFFFFF;padding-right: 3px;}


  -->
</style>
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

<body>> 
<cfinclude template="navbar_header_small.cfm">

<table width="100%">
  <tr valign="center"> 
    
 	
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="StockMovementReportSelection.cfm?FD=#lngFD#&TD=#lngTD#&SID=#lngStoreID#&RequestTimeout=300"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
  <tr valign="center"> 
 	<td colspan="3"> 
      <h1></h1>
    </td>
  </tr>
</table>

<table width="100%">
  <tr valign="center"> 
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> 
		
       		<CFIF cmbDeptNo is not 0>
	       <h1>Department: #deptString#</h1>
		<CFELSE>
		   <h1>All Departments</h1>
		</CFIF>
	  </CFOUTPUT>
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
 </tr>
  <!--- <tr valign="center"> 
 	<td > 
	  <cfoutput>
        <h1>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1>
		<CFIF cmbDeptNo is not 0>
	       <h1>Department: #deptString#</h1>
		<CFELSE>
		   <h1>All Departments</h1>
		</CFIF>
	  </CFOUTPUT>
    </td>
  </tr> --->
</table>
<CFOUTPUT>


<!--- 
<!------------------------------ qryPLUSales ------------------------------------>


<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryPLUSales#tableSuffix#')
   DROP VIEW qryPLUSales#tableSuffix#
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > CREATE view qryPLUSales#tableSuffix# as
SELECT     TOP 100 PERCENT CAST(PLUNumber AS varchar(16)) AS PartNo, 
10000 * { fn YEAR([Date]) } + 
100 * { fn MONTH([Date]) } + 
DAY([Date]) AS lngDate, 
                      	StoreID, TotalD, 
CASE WHEN abs([TotalKg]) > 0.0001 THEN [TotalKG] 
ELSE [Quantity] 
END AS FinalQty

FROM         dbo.tblStore_PLUTotals
WHERE     (PLUNumber <> '0')
ORDER BY partno
</CFQUERY>

<!------------------------------ qryStockStart ------------------------------------>

<!--- <CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryStockStart')
   DROP VIEW qryStockStart
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > create view qryStockStart as 
SELECT     DDate AS lngdate, *
FROM         dbo.tblStockHistStart
</CFQUERY>
 --->
<!------------------------------ qryStockEnding ------------------------------------>

<!--- <CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryStockEnding')
   DROP VIEW qryStockEnding
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > create view  qryStockEnding as
SELECT     TOP 100 PERCENT DDate AS lngdate, *
FROM         dbo.tblStockHistEnding
ORDER BY PartNo
</CFQUERY>
 --->
<!------------------------------ qryWastage ------------------------------------>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryWastage#tableSuffix#')
   DROP VIEW qryWastage#tableSuffix#
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > create view qryWastage#tableSuffix# as
SELECT     10000 * { fn YEAR(DateEntered) } + 
100 * { fn MONTH(DateEntered) } + 
DAY(DateEntered) AS lngDate, 
*
FROM         dbo.tblWastageLog
</CFQUERY>

<!------------------------------ qryTransfers ------------------------------------>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryTransfers#tableSuffix#')
   DROP VIEW qryTransfers#tableSuffix#
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > create view qryTransfers#tableSuffix# as
SELECT      
10000 * { fn YEAR(DateEntered) } + 
100 * { fn MONTH(DateEntered) } + 
DAY(DateEntered) AS lngDate, 
StoreID, 
PartNo, 
TeansferQty AS TransferQty, 
TransferToPlu

FROM         dbo.tblTransferLog
</CFQUERY>

<!------------------------------ qryVariance ------------------------------------>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryVariance#tableSuffix#')
   DROP VIEW qryVariance#tableSuffix#
</CFQUERY>
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > create view qryVariance#tableSuffix# as
SELECT     
top 100 percent CONVERT(int, SUBSTRING(DDate, 5, 4) + SUBSTRING(DDate, 3, 2) + 
SUBSTRING(DDate, 1, 2)) AS lngDate, 
PartNo,
StoreID, 
Wholesale AS WholesaleEx, 
B4_QtyOnHand AS B4_count, 
AF_QtyOnHand AS PhyicalStock, 
AF_QtyOnHand - B4_QtyOnHand AS VarianceQty, 
Wholesale * (AF_QtyOnHand - B4_QtyOnHand) AS VarianceDollar
FROM dbo.tblStocktakeLogVariance
ORDER BY PartNo
</CFQUERY>

<!--- END OF PREP ----_______________________________________________________________________________--->
 --->

<cfset strQuery = "SELECT  ">
<cfset strQuery = strQuery & "a.Description, ">
<cfset strQuery = strQuery & "SS.lngdate AS ssDate, ">
<cfset strQuery = strQuery & "a.PartNo, ">
<cfset strQuery = strQuery & "d.Dept,  g.DeptNo,  ">
<cfset strQuery = strQuery & "IsNull(SS.StartingStock,0) AS StartingStock, ">
<cfset strQuery = strQuery & "IsNull(P.qty,0) AS PurchQty, ">
<cfset strQuery = strQuery & "ROUND(IsNull(S.ItemTotQty,0), 3) AS SoldQty, ">
<cfset strQuery = strQuery & "IsNull(w.ItemTotWastage,0) AS Wastage, ">
<cfset strQuery = strQuery & "IsNull(tf.Transfers,0) AS xferOut, ">
<cfset strQuery = strQuery & "IsNull(tt.Transfers,0) AS xferIn, ">
<!--- <cfset strQuery = strQuery & "ROUND(SS.StartingStock + P.qty - S.ItemTotQty - w.ItemTotWastage - tf.Transfers + tt.Transfers, 3) ">
<cfset strQuery = strQuery & "AS computerstock, "> --->
<cfset strQuery = strQuery & "IsNull(SE.ClosingStock,0) as ClosingStock, ">
<cfset strQuery = strQuery & "SE.lngdate AS seDate,  ">
<cfset strQuery = strQuery & "IsNull(V.VarQty,0) as VarQty, "> 
<cfset strQuery = strQuery & "IsNull(V.VarDollar,0) as VarDollar ">

<cfset strQuery = strQuery & "FROM  dbo.tblStockMaster a INNER JOIN ">
<cfset strQuery = strQuery & "dbo.tblStockGroup g ON a.GroupNo = g.GroupNo INNER JOIN ">
<cfset strQuery = strQuery & "dbo.tblStockDept d ON g.DeptNo = d.DeptNo LEFT OUTER JOIN ">

<!--- dbo.qryStockEndingSummary  --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT ddate as lngDate ,* ">
<cfset strQuery = strQuery & "FROM  dbo.tblStockHistEnding WHERE ">
<cfif lngStoreID is  not "all">
<cfset strQuery = strQuery & "  (StoreID IN (#lngStoreID#)) AND">  
</cfif>
<cfset strQuery = strQuery & "(ddate = #lngTD#)) SE ON a.PartNo = SE.PartNo LEFT OUTER JOIN ">

<!--- <cfset strQuery = strQuery & "dbo.qryPLUSalesSummary S ON a.PartNo = S.PartNo LEFT OUTER JOIN "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT  PartNo, SUM(FinalQty) AS ItemTotQty, ">
<cfset strQuery = strQuery & "SUM(TotalD) AS ItemTotalSales ">
<cfset strQuery = strQuery & "FROM dbo.qryPLUSales WHERE    ">
<cfset strQuery = strQuery & " (lngDate >= #lngFD#) ">
<cfif lngStoreID is  not "all">
<cfset strQuery = strQuery & "AND (StoreID IN(#lngStoreID#))">
</cfif>
<cfset strQuery = strQuery & "AND (lngDate <= #lngTD#) ">
<cfset strQuery = strQuery & "GROUP BY PartNo ">
<cfset strQuery = strQuery & ") S ON a.PartNo = S.PartNo LEFT OUTER JOIN ">


<!--- dbo.qryStockStartSummary  --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT    ddate as lngdate, SUM(StartingStock) AS StartingStock,PartNo ">
<cfset strQuery = strQuery & "FROM  dbo.qryStockStart WHERE   ">
<cfif lngStoreID is   not "all">
<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND ">
</cfif>
<cfset strQuery = strQuery & "(ddate = #lngFD#) ">
<cfset strQuery = strQuery & "GROUP BY PartNo ,ddate ">
<cfset strQuery = strQuery & ")  SS ON a.PartNo = SS.PartNo LEFT OUTER JOIN ">

<!--- <cfset strQuery = strQuery & "dbo.qryInvoiceItemTotals P ON a.PartNo = P.PartNo LEFT OUTER JOIN "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT TOP 100 percent ">
<cfset strQuery = strQuery & "dbo.qryInvoiceDetail.PartNo,  ">
<cfset strQuery = strQuery & "SUM(dbo.qryInvoiceDetail.QtySupplied) AS qty,  ">
<cfset strQuery = strQuery & "AVG(dbo.qryInvoiceDetail.CostExG) AS AvCostEx,  ">
<cfset strQuery = strQuery & "SUM(dbo.qryInvoiceDetail.TotalPriceExTax) AS ShopItemTotalEx, SUM(dbo.qryInvoiceDetail.TotalTax) AS ShopTax,  ">
<cfset strQuery = strQuery & "SUM(dbo.qryInvoiceDetail.TotalPriceIncTax) AS ShopIncTax, SUM(dbo.qryInvoiceDetail.THinvoiceGoodsTotal) AS Sup2SCSTotalEx,  ">
<cfset strQuery = strQuery & "SUM(dbo.qryInvoiceDetail.THinvoiceUnitTaxTotal) AS Sup2SCSTotalTax, SUM(dbo.qryInvoiceDetail.THinvoiceUnitPriceIncTaxTotal)  ">
<cfset strQuery = strQuery & "AS Sup2SCSTotalIncTax,  ">
<cfset strQuery = strQuery & "SUM(dbo.qryInvoiceDetail.SCRebateUnitExGTotal) AS SCSRebateTotal, SUM(dbo.qryInvoiceDetail.THRebateUnitExGTotal)  ">
<cfset strQuery = strQuery & "AS SupplierRebateTotal ">
<cfset strQuery = strQuery & "FROM  dbo.qryInvoiceDetail INNER JOIN ">
<cfset strQuery = strQuery & "                      dbo.tblStockMaster ON dbo.qryInvoiceDetail.PartNo = dbo.tblStockMaster.PartNo INNER JOIN ">
<cfset strQuery = strQuery & "                      dbo.tblStockGroup ON dbo.tblStockMaster.GroupNo = dbo.tblStockGroup.GroupNo ">
<cfset strQuery = strQuery & "WHERE      ">
<cfif lngStoreID  is not "all">
<cfset strQuery = strQuery & "(dbo.qryInvoiceDetail.StoreID IN (#lngStoreID#)) AND">
</cfif>
<cfset strQuery = strQuery & "(dbo.qryInvoiceDetail.lngDate >= #lngFD#) AND  ">
<cfset strQuery = strQuery & "(dbo.qryInvoiceDetail.lngDate <= #lngTD#)">
<cfset strQuery = strQuery & "GROUP BY dbo.qryInvoiceDetail.PartNo ORDER BY  dbo.qryInvoiceDetail.PartNo ">
<cfset strQuery = strQuery & ")  P ON a.PartNo = P.PartNo LEFT OUTER JOIN  ">


<!--- <cfset strQuery = strQuery & "dbo.qryWastageSummary w ON a.PartNo = w.PartNo LEFT OUTER JOIN "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT PartNo,  ">
<cfset strQuery = strQuery & "SUM(Wastage) AS ItemTotWastage ">
<cfset strQuery = strQuery & "FROM         dbo.qryWastage ">
<cfset strQuery = strQuery & "WHERE     ">
<cfif lngStoreID  is not "all">
<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND">
</cfif>
<cfset strQuery = strQuery & "(lngDate >= #lngFD#) AND (lngDate <= #lngTD#) ">
<cfset strQuery = strQuery & "GROUP BY PartNo  ">
<cfset strQuery = strQuery & ")  w ON a.PartNo = w.PartNo LEFT OUTER JOIN  ">

<!--- <cfset strQuery = strQuery & "dbo.qryTransfersFromSummary tf ON a.PartNo = tf.PartNo LEFT OUTER JOIN "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT      ">
<cfset strQuery = strQuery & "PartNo,  ">
<cfset strQuery = strQuery & "SUM(TransferQty) AS Transfers ">
<cfset strQuery = strQuery & "FROM         dbo.qryTransfers ">
<cfset strQuery = strQuery & "WHERE "> 
<cfif lngStoreID  is not "all">
<cfset strQuery = strQuery & " (StoreID IN (#lngStoreID#)) AND">
</cfif>
<cfset strQuery = strQuery & " (lngDate >= #lngFD#) AND (lngDate <= #lngTD#) ">
<cfset strQuery = strQuery & "GROUP BY PartNo  ">
<cfset strQuery = strQuery & ") tf ON a.PartNo = tf.PartNo LEFT OUTER JOIN ">

<!--- <cfset strQuery = strQuery & "dbo.qryVarianceSummary V ON a.PartNo = V.PartNo LEFT OUTER JOIN "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT   ">
<cfset strQuery = strQuery & "PartNo,  ">
<cfset strQuery = strQuery & "ROUND(AVG(WholesaleEx), 2) AS Wholesale,  ">
<cfset strQuery = strQuery & "ROUND(SUM(B4_count), 3) AS B4_Stocktake,  ">
<cfset strQuery = strQuery & "ROUND(SUM(PhysicalStock), 3) AS Physical,  ">
<cfset strQuery = strQuery & "ROUND(SUM(VarianceQty), 3) AS VarQty,  ">
<cfset strQuery = strQuery & "ROUND(SUM(VarianceDollar), 2) AS VarDollar ">
<cfset strQuery = strQuery & "FROM         qryVariance ">
<cfset strQuery = strQuery & "WHERE"> 
<cfif lngStoreID  is not "all">
<cfset strQuery = strQuery & "  (StoreID IN(#lngStoreID#)) AND">
</cfif>
<cfset strQuery = strQuery & " (lngDate >= #lngFD#) AND (lngDate <= #lngTD#) ">
<cfset strQuery = strQuery & "GROUP BY PartNo  ">
<cfset strQuery = strQuery & ")  ">
<cfset strQuery = strQuery & " V ON a.PartNo = V.PartNo LEFT OUTER JOIN ">


<!--- <cfset strQuery = strQuery & "dbo.qryTransfersToSummary tt ON a.PartNo = tt.partno "> --->
<cfset strQuery = strQuery & "( ">
<cfset strQuery = strQuery & "SELECT      ">
<cfset strQuery = strQuery & " TransferToPlu AS partno, ">
<cfset strQuery = strQuery & "SUM(TransferQty) AS Transfers ">
<cfset strQuery = strQuery & "FROM         dbo.qryTransfers ">
<cfset strQuery = strQuery & "WHERE"> 
<cfif lngStoreID  is not "all">
<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND">
</cfif>
<cfset strQuery = strQuery & "  (lngDate >= #lngFD#) AND (lngDate <= #lngTD#) ">
<cfset strQuery = strQuery & "GROUP BY TransferToPlu  ">
<cfset strQuery = strQuery & ") tt ON a.PartNo = tt.partno ">
<cfset strQuery = strQuery & "WHERE a.PCode = 0 AND ">

<!--- 
<CFIF cmbDeptNo is  is not 0>
   <cfset strQuery = strQuery & "g.deptNo in (#cmbDeptNo#) ">
</cfif>
 --->
 
<CFIF cmbDeptNo is  not 0>
   <cfset strQuery = strQuery & "g.deptNo in (#cmbDeptNo#) AND ">
</cfif>

<cfset strQuery = strQuery & "(SS.StartingStock <> 0 or SE.ClosingStock <> 0 ">
<cfset strQuery = strQuery & "or S.ItemTotQty <> 0 or V.VarQty <> 0 or P.qty <> 0 ">
<cfset strQuery = strQuery & "or w.ItemTotWastage <> 0 or tf.Transfers <> 0 or tt.Transfers <> 0) " >

<cfset strQuery = strQuery & "ORDER BY g.DeptNo, a.Description ">

<CFQUERY name="GetReport" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- <CFQUERY name="GetReport" datasource="#application.dsn#" > SELECT     
a.Description,
SS.lngdate AS ssDate,
a.PartNo,
d.Dept, 
SS.StartingStock, 
P.qty AS PurchQty, 
ROUND(S.ItemTotQty, 3) AS SoldQty, 
w.ItemTotWastage,
tf.Transfers AS xferOut, 
tt.Transfers AS xferIn, 
ROUND(SS.StartingStock + P.qty - S.ItemTotQty - w.ItemTotWastage - tf.Transfers + tt.Transfers, 3)
AS computerstock, 
SE.ClosingStock, 
SE.lngdate AS seDate, 
V.VarQty, 
V.VarDollar


FROM         dbo.tblStockMaster a INNER JOIN
                      dbo.tblStockGroup g ON a.GroupNo = g.GroupNo INNER JOIN
                      dbo.tblStockDept d ON g.DeptNo = d.DeptNo LEFT OUTER JOIN
                      dbo.qryStockEndingSummary SE ON a.PartNo = SE.PartNo LEFT OUTER JOIN
                      dbo.qryPLUSalesSummary S ON a.PartNo = S.PartNo LEFT OUTER JOIN
                      dbo.qryStockStartSummary SS ON a.PartNo = SS.PartNo LEFT OUTER JOIN
                      dbo.qryInvoiceItemTotals P ON a.PartNo = P.PartNo LEFT OUTER JOIN
                      dbo.qryWastageSummary w ON a.PartNo = w.PartNo LEFT OUTER JOIN
                      dbo.qryTransfersFromSummary tf ON a.PartNo = tf.PartNo LEFT OUTER JOIN
                      dbo.qryVarianceSummary V ON a.PartNo = V.PartNo LEFT OUTER JOIN
                      dbo.qryTransfersToSummary tt ON a.PartNo = tt.partno
WHERE g.deptNo in (#cmbDeptNo#) and
    
(SS.StartingStock <> 0
or SE.ClosingStock <> 0
or S.ItemTotQty <> 0
or V.VarQty <> 0  
or P.qty <> 0
or w.ItemTotWastage <> 0
or tf.Transfers <> 0 
or tt.Transfers <> 0 
 )

ORDER BY g.DeptNo, a.Description
</CFQUERY>
 --->
 
 </cfoutput>
 
 
<CFOUTPUT> 
<!--- <table class="reportData" width="95%"> --->
<table  border="1" cellpadding="0" align="CENTER" cellspacing="0" width="95%">
<TR>
	<td><b>PartNo</b></td>
	<TD><b>Description</b></td>
<!--- 	<td>ssDate</td> --->

<!--- 	<td><b>Dept</b></td>
 --->	<td align="right"><b>Starting<br>Stock</b></td>
	<td align="right"><b>Purch<br>Qty</b></td>
	<td align="right"><b>Sold<br>Qty</b></td>
	<td align="right"><b>Item<br>Wastage</b></td>
	<td align="right"><b>Transfer<br>Out</b></td>
	<td align="right"><b>Transfer<br>In</b></td>
	<td align="right"><b>Computer<br>Stock</b></td>
	<td align="right"><b>Closing<br>Stock</b></td>
	<td align="right"><b>Variance<br>kg/Qty</b></td>
	<td align="right"><b>Variance<br>($)</b></td>
</tr>   

<CFSET varQtyTot = 0><CFSET varDollarTot = 0>
<CFSET varQtyGTot = 0><CFSET varDollarGTot = 0>
<CFSET thisDept = "">
<CFSET computerstock=0>

<!---   <cfoutput QUERY="getReport"> --->
	   <CFloop query="getReport">
	     <CFIF ( thisDept is NOT DeptNo )  and getReport.currentRow gt 1> 
		    <TR height="25" bgcolor="Black">
			  <CFSET prevDeptRow = getReport.currentRow - 1> 
			 
			  <TD colspan="2" align="RIGHT"><b>#getReport.dept[prevDeptRow]# Totals </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(varQtyTot,"______.000")#</b></td>
			  <td align="RIGHT"><b>#numberformat(varDollarTot,"______.00")#</b></td>			  
				<CFSET varQtyTot = 0>
				<CFSET varDollarTot = 0>
			</tr>
		 </cfif> 


  <TR>	
    <td>#PartNo#</td>
	<TD>#Description#</td>
	<td align="right">#numberformat(StartingStock,"_______.___")#</td>
	<td align="right">#numberformat(PurchQty,"-_______.___")#</td>
	<td align="right">#numberformat(SoldQty,"-_______.___")#</td>
	<td align="right">#numberformat(Wastage,"-_______.___")#</td>
	<td align="right">#numberformat(xferOut,"-_______.___")#</td>
	<td align="right">#numberformat(xferIn,"-_______.___")#</td>
	<CFSET computerStock = StartingStock + 
							PurchQty - 
							SoldQty - 
							Wastage - 
							xferOut + 
							xferIn >
	<td align="right">#numberformat(computerStock,"-_______.___")#</td>
	<td align="right">#numberformat(ClosingStock,"-_______.___")#</td>
	<td align="right">#numberformat(VarQty,"-_______.___")#</td>
	<td align="right">#numberformat(VarDollar,"-_______.__")#</td>
	</tr> 
	<CFSET thisDept = DeptNo>

<cfif  isnumeric(varQty) >
	<CFSET varQtyTot = varQtyTot + varQty>
 	<CFSET varQtyGTot = varQtyGTot + varQty>
</cfif> 
<cfif  isnumeric(varDollar) >	
	<CFSET varDollarTot = varDollarTot + VarDollar>
	<CFSET varDollarGTot = varDollarGTot + VarDollar>	
</cfif> 
	  

	   </cfloop>

		    <TR height="25" bgcolor="black">
				<TD colspan="2" align="RIGHT" ><b>#getreport.dept# Totals </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>

		        <td align="RIGHT"><b>#numberformat(varQtyTot,"______.000")#</b></td>
		        <td align="RIGHT"><b>#numberformat(VarDollarTot,"______.00")#</b></td>
			</tr>
			
			
		   <TR height="25" bgcolor="##009900">
			  <TD colspan="2" align="RIGHT"><b> GRAND TOTALS</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
		        <td align="RIGHT"><b>#numberformat(varQtyGTot,"______.000")#</b></td>
		        <td align="RIGHT"><b>#numberformat(VarDollarGTot,"______.00")#</b></td>
			</tr>
	
  </cfoutput>
  
</TABLE>
</body>
</HTML>

<!--- 
<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryPLUSales#tableSuffix#')
   DROP VIEW qryPLUSales#tableSuffix#
</CFQUERY>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryWastage#tableSuffix#')
   DROP VIEW qryWastage#tableSuffix#
</CFQUERY>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryTransfers#tableSuffix#')
   DROP VIEW qryTransfers#tableSuffix#
</CFQUERY>

<CFQUERY name="GetPLUs" datasource="#application.dsn#" > 
	IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS
         WHERE TABLE_NAME = 'qryVariance#tableSuffix#')
   DROP VIEW qryVariance#tableSuffix#
</CFQUERY>

 --->
