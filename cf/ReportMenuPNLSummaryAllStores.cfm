
 <cfset lngStoreID = #URL.SID#> 
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>

	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	
	
	<cfset strQuery = "SELECT * from tblOptions ">
	<CFQUERY name="GetOptions" datasource="#application.dsn#" > <!--- <CFQUERY name="GetOptions" datasource="#application.dsn#" > --->
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

<cfset strPageTitle = "Franchise & Marketing Fees">

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
      <!--- <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1> --->
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> <h1>All Stores</h1>
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
							<cfset strPageTitle = #GetStoreDetail.StoreName#>
							<h1><cfoutput>#strPageTitle#</cfoutput></h1><br />
						</cfloop></p>
					<cfelse>
						<h1><cfoutput>#GetStoreDetail.StoreName#</cfoutput></h1>
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
  <tr valign="center"> 
 	<td colspan="3"> 
      <h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</CFOUTPUT></h1>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center">

<table width="90%" border="1" cellspacing="0" cellpadding="0">
  <tr> 
    <td><b><font size="2">Store</font></b></td>
    <td><b><font size="2">Total net sales ex GST</font></b></td>
	<td><b><font size="2">Franchise Fee</font></b></td>
    <td><b><font size="2">Marketing Fee</font></b></td>
  </tr>

	<!--- Get the store name --->
	<cfset strQuery = "SELECT * from tblStores where" >
	 <cfset strQuery = strQuery  & "(NoLongerUsed = 0)">
	 <CFIF lngStoreID is not "all" >
	 <cfset strQuery = strQuery  & "and StoreId IN(#lngStoreId#)">
	 </cfif> 
	 <cfset strQuery = strQuery  & "order by StoreName" >
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset dblTotalFranchiseFee = 0>
	<cfset dblTotalMarketingFee = 0>
		
<cfoutput query = "GetStoreDetail">
    <cfset lngStoreID = #GetStoreDetail.StoreID#> 
    <cfset strStoreName = #GetStoreDetail.StoreName#> 
	    
	<cfset strQuery = "SELECT Sum(RoundingsD) AS SSRoundingsD, Sum(Discounts) AS SSDiscounts, Sum(DiscountD) AS SSDiscountD, Sum(CashSales) AS SSCashSales, Sum(CashSalesD) AS SSCashSalesD, Sum(CreditSales) AS SSCreditSales, Sum(CreditSalesD) AS SSCreditSalesD, Sum(EFTCashOut) AS SSEFTCashOut, Sum(EFTCashOutD) AS SSEFTCashOutD, Sum(CashRefunds) AS SSCashRefunds, Sum(CashRefundD) AS SSCashRefundD, Sum(CreditRefunds) AS SSCreditRefunds, Sum(CreditRefundD) AS SSCreditRefundD, Sum(CashSalesGSTincD) AS SSCashSalesGSTincD, Sum(CashSaleGSTfreeD) AS SSCashSaleGSTfreeD, Sum(CreditSalesGSTincD) AS SSCreditSalesGSTincD, Sum(CreditSalesGSTfreeD) AS SSCreditSalesGSTfreeD, Sum(GSTCashSaleD) AS SSGSTCashSaleD, Sum(GSTCreditSaleD) AS SSGSTCreditSaleD, Sum(CashIn) AS SSCashIn, Sum(CashInD) AS SSCashInD, Sum(CashOut) AS SSCashOut, Sum(CashOutD) AS SSCashOutD, Sum(Cancellations) AS SSCancellations, Sum(CancellationD) AS SSCancellationD, Sum(Sales) AS SSSales ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "where">
	<CFIF #lngStoreID# is not "all" >
	 <cfset strQuery = strQuery & " (StoreID IN (#lngStoreID#)) and " > 
	 </cfif>
	 <cfset strQuery = strQuery & " ((year([date]) * 10000) + (month([date]) * 100) + (day([date])) between #lngFD# and #lngTD#) ">
	<CFQUERY name="GetData" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "SELECT Sum(CashInDraw) AS SSCashInDraw ">
	<cfset strQuery = strQuery & "FROM tblStore_CashInDraw ">
	<cfset strQuery = strQuery & "where ">
	<CFIF #lngStoreID# is not "all" >
	<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID# )) and">
	</cfif>
	 <cfset strQuery = strQuery & "((year([date]) * 10000) + (month([date]) * 100) + (day([date])) between #lngFD# and #lngTD#) ">
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
	
	
	<cfif #isnumeric(GetData.SSCancellationD)#>
		<cfset TotalSSCancellationD = #GetData.SSCancellationD# >
	</cfif>
	
	<cfif #isnumeric(GetData.SSGSTCashSaleD)#>
		<cfset TotalSSGSTCashSaleD = #GetData.SSGSTCashSaleD# >
	</cfif>
	<cfif #isnumeric(GetData.SSGSTCreditSaleD)#>
		<cfset TotalSSGSTCreditSaleD = #GetData.SSGSTCreditSaleD# >
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
	<CFSET TotalNet = TotalGross - #TotalGST# - #TotalVoids# - #TotalDiscount#>
    <cfif #GetCIDData.RecordCount# GT 0>
		<cfif #isnumeric(GetCIDData.SSCashInDraw)#>
			<CFSET TotalCashInDraw = #GetCIDData.SSCashInDraw# >
		</cfif>	
	</cfif>
	<CFSET TotalDifference = #TotalCashInDraw# - #TotalNet#>

	<CFSET dblGrossTotalSales = #TotalCash# + #TotalCredit#>
	
	<CFSET dblTotalNetSalesExGST = #dblGrossTotalSales# - #TotalSSGSTCashSaleD# - #TotalSSGSTCreditSaleD# >

	
	<!--- Now get the data for the second part of this report --->

	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	

	<cfset FranchiseFee = FranchiseFeePercentage * (dblTotalNetSalesExGST) / 100 >
	<cfset MarketingFee = MarketingFeePercentage * (dblTotalNetSalesExGST) / 100 >

	<cfset dblTotalFranchiseFee = dblTotalFranchiseFee + FranchiseFee >
	<cfset dblTotalMarketingFee = dblTotalMarketingFee + MarketingFee >
	
  <tr> 
    <td><font size="2"><a href="ReportMenuPNLSummary.cfm?FD=#lngFD#&TD=#lngTD#&SID=#lngStoreID#"><h3>#strStoreName#</h3></a></font></td>
    <td><div align="right"><font size="2">#numberformat(dblTotalNetSalesExGST,"_______.00")#</font></div></td>
    <td><div align="right"><font size="2">#numberformat(FranchiseFee,"_______.00")#</font></div></td>
    <td><div align="right"><font size="2">#numberformat(MarketingFee,"_______.00")#</font></div></td>
  </tr>
</cfoutput>	  
<cfoutput>
  <tr> 
    <td colspan="2"><b><font size="2">Total</font></b></td>
	<td><div align="right"><b><font size="2">#numberformat(dblTotalFranchiseFee,"_______.00")#</font></b></div></td>
    <td><div align="right"><b><font size="2">#numberformat(dblTotalMarketingFee,"_______.00")#</font></b></div></td>
  </tr>
</cfoutput>

</table>
	  </div>
    </td>
  </tr>
</table>

</body>
</HTML>
