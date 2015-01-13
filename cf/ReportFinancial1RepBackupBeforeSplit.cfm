
<cfset lngStoreID = #form.lngStoreID#>
<!--- <cfoutput><BR>lngStoreID: #lngStoreID#</cfoutput> --->

<cfset strDF = "#form.DF#">
<cfset strMF = "#form.MF#">
<cfset strYF = "#form.YF#">

<cfif #len(strDF)# LT 2>
	<cfset strDF = "0" & strDF>
</cfif>
<cfif #len(strMF)# LT 2>
	<cfset strMF = "0" & strMF>
</cfif>

<cfset strWE = "#strDF#" & "#strMF#" & "#strYF#">

<!--- Get Week Beginning --->
<cfset lngNumDays = -6>
<cfset strNextDate ="">
<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
<cfset strWS = "#strNextDate#">

<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strWE#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# NEQ "Y">
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
<!--- 	<cfabort> --->
</cfif>

<CFSET DateArray = ArrayNew(1)>
<CFSET CashArray = ArrayNew(1)>
<CFSET CreditArray = ArrayNew(1)>
<CFSET CustomerArray = ArrayNew(1)>
<CFSET AvgSalesArray = ArrayNew(1)>
<CFSET GSTArray = ArrayNew(1)>
<CFSET VoidsArray = ArrayNew(1)>
<CFSET DiscountArray = ArrayNew(1)>
<CFSET GrossArray = ArrayNew(1)>
<CFSET NetArray = ArrayNew(1)>
<CFSET CashInDrawArray = ArrayNew(1)>
<CFSET DifferenceArray = ArrayNew(1)>

<!--- Get the dates --->
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset lngNumDays = #lngDayIndex# - 7>
	<cfset strNextDate ="">
	<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
	<CFSET DateArray[lngDayIndex] = "#strNextDate#">
<!--- 	<cfoutput><BR>#DateArray[lngDayIndex]#</cfoutput> --->
</cfloop>

<!--- Now get the values --->
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">

	<cfset strSelectedDate = "#DateArray[lngDayIndex]#">
	<cfset strDF = "#mid(strSelectedDate,1,2)#">
	<cfset strMF = "#mid(strSelectedDate,3,2)#">
	<cfset strYF = "#mid(strSelectedDate,5,4)#">

	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE (tblStore_ECRTotals.StoreID=#lngStoreID#) AND (convert(int,day([Date]))= convert(int,#strDF#)) AND (convert(int,month([Date]))= convert(int,#strMF#)) AND (convert(int,year([Date]))= convert(int,#strYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetData" datasource="#application.dsn#" > 	
	<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_CashInDraw ">
	<cfset strQuery = strQuery & "WHERE (StoreID=#lngStoreID#) AND (convert(int,day([Date]))= convert(int,#strDF#)) AND (convert(int,month([Date]))= convert(int,#strMF#)) AND (convert(int,year([Date]))= convert(int,#strYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetCIDData" datasource="#application.dsn#" > 	
	<!--- <CFQUERY  name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	
	
	<CFSET CashArray[lngDayIndex] = 0>
	<CFSET CreditArray[lngDayIndex] = 0>
	<CFSET CustomerArray[lngDayIndex] = 0>
	<CFSET AvgSalesArray[lngDayIndex] = 0>
	<CFSET GSTArray[lngDayIndex] = 0>
	<CFSET VoidsArray[lngDayIndex] = 0>
	<CFSET DiscountArray[lngDayIndex] = 0>
	<CFSET GrossArray[lngDayIndex] = 0>
	<CFSET NetArray[lngDayIndex] = 0>
	<CFSET CashInDrawArray[lngDayIndex] = 0>
	<CFSET DifferenceArray[lngDayIndex] = 0>
	<!--- <hr>
	<hr>
	<cfoutput><BR>lngDayIndex: #lngDayIndex#</cfoutput>
	<cfoutput><BR>#DateArray[lngDayIndex]#</cfoutput> --->
	<cfif #GetData.RecordCount# GT 0>
		<CFSET CashArray[lngDayIndex] = #GetData.CashSalesD# >
		<CFSET CreditArray[lngDayIndex] = #GetData.CreditSalesD#>
		<CFSET CustomerArray[lngDayIndex] = #GetData.CashSales# + #GetData.CreditSales# >
		<cfif (#GetData.CashSales# + #GetData.CreditSales#) GT 0>
			<CFSET AvgSalesArray[lngDayIndex] = (#GetData.CashSalesD# + #GetData.CreditSalesD#) / (#GetData.CashSales# + #GetData.CreditSales#)>
		</cfif>
		<CFSET GSTArray[lngDayIndex] = #GetData.GSTCashSaleD# + #GetData.GSTCreditSaleD#>
		<CFSET VoidsArray[lngDayIndex] = #GetData.CashRefundS# + #GetData.CreditRefundS#>
		<CFSET DiscountArray[lngDayIndex] = #GetData.DiscountD#>
		<CFSET GrossArray[lngDayIndex] = #CashArray[lngDayIndex]# + #CreditArray[lngDayIndex]# + #GSTArray[lngDayIndex]# + #VoidsArray[lngDayIndex]# + #DiscountArray[lngDayIndex]# >
		<CFSET NetArray[lngDayIndex] = GrossArray[lngDayIndex] - #GSTArray[lngDayIndex]# - #VoidsArray[lngDayIndex]# - #DiscountArray[lngDayIndex]# >
	</cfif>
    <cfif #GetCIDData.RecordCount# GT 0>
		<cfif #isnumeric(GetCIDData.CashInDraw)#>
			<CFSET CashInDrawArray[lngDayIndex] = #GetCIDData.CashInDraw# >
		</cfif>	
	</cfif>
	<CFSET DifferenceArray[lngDayIndex] = #CashInDrawArray[lngDayIndex]# - #NetArray[lngDayIndex]#>
	<!--- <cfoutput><BR>CashArray: #CashArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>CreditArray: #CreditArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>CustomerArray: #CustomerArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>AvgSalesArray: #AvgSalesArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>GSTArray: #GSTArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>VoidsArray: #VoidsArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>DiscountArray: #DiscountArray[lngDayIndex]#</cfoutput>
	<cfoutput><BR>GrossArray: #GrossArray[lngDayIndex]#</cfoutput> --->
</cfloop>

<cfset TotalCash = 0 >
<cfset TotalCredit = 0>
<cfset TotalCustomer = 0>
<cfset TotalCustomer GT 0>
<cfset TotalAvgSales = 0>
<cfset TotalGST = 0>
<cfset TotalVoids = 0>
<cfset TotalDiscount = 0>
<cfset TotalGross = 0>
<CFSET TotalNet = 0>
<CFSET TotalCashInDraw = 0>
<CFSET TotalDifference = 0>

<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset TotalCash = #TotalCash# + #CashArray[lngDayIndex]# >
	<cfset TotalCredit = #TotalCredit# + #CreditArray[lngDayIndex]#>
	<cfset TotalCustomer = #TotalCustomer# + #CustomerArray[lngDayIndex]#>
    <cfif TotalCustomer GT 0>
		<cfset TotalAvgSales = (TotalCash + TotalCredit) / TotalCustomer>
	<cfelse>
		<cfset TotalAvgSales = 0>
	</cfif>
	<cfset TotalGST = TotalGST + #GSTArray[lngDayIndex]# >
	<cfset TotalVoids = TotalVoids + #VoidsArray[lngDayIndex]#>
	<cfset TotalDiscount = TotalDiscount + #DiscountArray[lngDayIndex]#>
	<cfset TotalGross = TotalGross + #GrossArray[lngDayIndex]# >
	<CFSET TotalNet = TotalNet + NetArray[lngDayIndex]>
	<CFSET TotalCashInDraw = TotalCashInDraw + CashInDrawArray[lngDayIndex]>
	<CFSET TotalDifference = TotalDifference + DifferenceArray[lngDayIndex]>
</cfloop>

<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- Now get the data for the second part of this report --->


<cfset lngStoreID = #form.lngStoreID#>
<cfset lngDF = #mid(strWS,1,2)#>
<cfset lngMF = #mid(strWS,3,2)#>
<cfset lngYF = #mid(strWS,5,4)#>
<cfset lngDT = #form.DF#>
<cfset lngMT = #form.MF#>
<cfset lngYT = #form.YF#>

<cfset strPageTitle = "Report">

<cfset strQuery = "SELECT Sum(tblStore_ECRTotals.RoundingsD) AS RoundingsD, Sum(tblStore_ECRTotals.DiscountD) AS DiscountD, Sum(tblStore_ECRTotals.CashSalesD) AS CashSalesD, Sum(tblStore_ECRTotals.CreditSalesD) AS CreditSalesD, Sum(tblStore_ECRTotals.EFTCashOutD) AS EFTCashOutD, Sum(tblStore_ECRTotals.CashRefundD) AS CashRefundD, Sum(tblStore_ECRTotals.CreditRefundD) AS CreditRefundD, Sum(tblStore_ECRTotals.CashSalesGSTincD) AS CashSalesGSTincD, Sum(tblStore_ECRTotals.CashSaleGSTfreeD) AS CashSaleGSTfreeD, Sum(tblStore_ECRTotals.CreditSalesGSTincD) AS CreditSalesGSTincD, Sum(tblStore_ECRTotals.CreditSalesGSTfreeD) AS CreditSalesGSTfreeD, Sum(tblStore_ECRTotals.GSTCashSaleD) AS GSTCashSaleD, Sum(tblStore_ECRTotals.GSTCreditSaleD) AS GSTCreditSaleD, Sum(tblStore_ECRTotals.CashInD) AS CashInD, Sum(tblStore_ECRTotals.CashOutD) AS CashOutD, Sum(tblStore_ECRTotals.CancellationD) AS CancellationD ">
<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
<!--- <cfset strQuery = strQuery & "WHERE (((tblStore_ECRTotals.StoreID)=#lngStoreID#) AND ((tblStore_ECRTotals.Date) Between DateSerial(#lngYF#,#lngMF#,#lngDF#) And DateSerial(#lngYT#,#lngMT#,#lngDT#)))"> --->
<cfset strQuery = strQuery & "WHERE (tblStore_ECRTotals.StoreID=#lngStoreID#) AND ( Convert(int,[Date]) Between convert(int,Convert(datetime, '#lngMF#/#lngDF#/#lngYF#')) and convert(int,Convert(datetime, '#lngMT#/#lngDT#/#lngYT#')) )">
<!--- <cfoutput><BR>#strQuery#</cfoutput><cfabort> --->
<CFQUERY name="GetRecord" datasource="#application.dsn#" > 	
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblCashSalesD = 0>
<cfset dblCreditSalesD = 0>
<cfset dblGrossTotalSales = 0>
<cfset dblGST = 0>
<cfset dblVoids = 0>
<cfset dblDiscountD = 0>
<cfset dblTotalNetSales = 0>

<cfif #GetRecord.RecordCount# GT 0>
    <cfif #isnumeric(GetRecord.CashSalesD)#>
		<cfset dblCashSalesD = #GetRecord.CashSalesD#>
		<cfset dblCreditSalesD = #GetRecord.CreditSalesD#>
		<cfset dblGrossTotalSales = (#GetRecord.CashSalesD# + #GetRecord.CreditSalesD#)>
		<cfset dblGST = (#GetRecord.GSTCashSaleD# + #GetRecord.GSTCreditSaleD#)>
		<cfset dblVoids = (#GetRecord.CashRefundD# + #GetRecord.CreditRefundD#)>
		<cfset dblDiscountD = #GetRecord.DiscountD#>
		<cfset dblTotalNetSales = (#dblGrossTotalSales# - #dblGST# - #dblVoids# - #dblDiscountD#)>
	</cfif>
</cfif>

<!--- Get the starting stock --->
<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID, * ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strWS#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
<CFQUERY name="GetStartingStock" datasource="#application.dsn#" > 	
<!--- <CFQUERY name="GetStartingStock" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset dblStartingStock = 0>
<cfif #GetStartingStock.RecordCount# GT 0>
	<cfif #isnumeric(GetStartingStock.StartingStockValEx)#>
		<cfset dblStartingStock = #GetStartingStock.StartingStockValEx#>
	</cfif>	
</cfif>


<!--- Get the ending stock --->
<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID, * ">
<cfset strQuery = strQuery & "FROM tblEodSummary ">
<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)='#strWE#') AND ((tblEodSummary.StoreID)=#lngStoreID#))">
<CFQUERY name="GetEndinfStock" datasource="#application.dsn#" > 	
<!--- <CFQUERY name="GetEndinfStock" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset dblEndingStock = 0>
<cfif #GetEndinfStock.RecordCount# GT 0>
	<cfif #isnumeric(GetEndinfStock.EndingStockValEx)#>
		<cfset dblEndingStock = #GetEndinfStock.EndingStockValEx#>
	</cfif>	
</cfif>

<cfset dblStockUsed = #dblEndingStock# >



<cfset lngStartDate = "#lngYF#" & "#lngMF#" & "#lngDF#" >
<cfset lngEndDate = "#lngYT#" & "#lngMT#" & "#lngDT#" >

<!--- Get the Purchase amount and the stock variance --->
<cfset strQuery = "SELECT Sum(qryEODSummary.StartingStockValEx) AS SStartingStockValEx, Sum(qryEODSummary.EndingStockValEx) AS SEndingStockValEx, Sum(qryEODSummary.StockVarianceValEx) AS SStockVarianceValEx, Sum(qryEODSummary.PurchaseValEx) AS SPurchaseValEx, Sum(qryEODSummary.WastageValEx) AS SWastageValEx ">
<cfset strQuery = strQuery & "FROM qryEODSummary ">
<cfset strQuery = strQuery & "WHERE (((qryEODSummary.lngDate) Between #lngStartDate# And #lngEndDate#) AND ((qryEODSummary.StoreID)=#lngStoreID#))">
<CFQUERY name="GetAdditionalInfo" datasource="#application.dsn#" > 	
<!--- <CFQUERY name="GetAdditionalInfo" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset dblPurchase = 0>
<cfset dblStockVariance = 0>
<cfset dblWastage = 0>

<cfset dblStockVariance = 0>
<cfif #GetAdditionalInfo.RecordCount# GT 0>
	<cfif #isnumeric(GetAdditionalInfo.SPurchaseValEx)#>
		<cfset dblPurchase = #GetAdditionalInfo.SPurchaseValEx#>
	</cfif>	
	<cfif #isnumeric(GetAdditionalInfo.SStockVarianceValEx)#>
		<cfset dblStockVariance = #GetAdditionalInfo.SStockVarianceValEx#>
	</cfif>	
	<cfif #isnumeric(GetAdditionalInfo.SWastageValEx)#>
		<cfset dblWastage = #GetAdditionalInfo.SWastageValEx#>
	</cfif>	
</cfif>


<!--- Get the wages paid --->
<cfset strQuery = "SELECT Sum([TaxableIncome]+[NonTaxableIncome]+[Tax]) AS PayValue ">
<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
<cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.StoreID)=#lngStoreID#) AND ((substring([WeekEnding],5,4) + substring([WeekEnding],3,2) + substring([WeekEnding],1,2)) Between #lngStartDate# And #lngEndDate#))">
<CFQUERY name="GetWagesPaid" datasource="#application.dsn#" > 	
<!--- <CFQUERY name="GetWagesPaid" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset dblWagesPaid = 0>
<cfif #GetWagesPaid.RecordCount# GT 0>
	<cfif #isnumeric(GetWagesPaid.PayValue)#>
		<cfset dblWagesPaid = #GetWagesPaid.PayValue#>
	</cfif>	
</cfif>

		  <cfset dblStockUsed = #dblStartingStock# + #dblPurchase# - #dblEndingStock# >
		  <cfset dblComputerStock = #dblEndingStock#  - #dblStockVariance# >
		  <cfset dblGrossProfit = #dblCashSalesD#  - #dblStockUsed# >
		  <cfset dblGrossProfitPercentage = 0 >
		  <cfset dblWagesPercentage = 0 >
		  <cfif #dblCashSalesD# NEQ 0>
			  <cfset dblGrossProfitPercentage = #dblGrossProfit# / #dblCashSalesD# >	  
			  <cfset dblWagesPercentage = #dblWagesPaid# / #dblCashSalesD# >
		  </cfif>

<cfset strPageTitle = "Report">


<!--- <cfset lngStoreID = #session.storeid#> --->


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
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="MainMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
  <tr valign="center"> 
 	<td colspan="3"> 
      <h1><cfoutput>Week Ending #mid(strWE,1,2)#/#mid(strWE,3,2)#/#mid(strWE,5,4)#</CFOUTPUT></h1>
    </td>
  </tr>
</table>
<br>
<br>

<table align="center" width="90%" border="0">
  <tr>
    <td>
      <div align="left">
	    <table align="left" width="95%" cellspacing="2" cellpadding="0" border="1">
          <cfoutput> 
            <tr> 
              <td width="15%">&nbsp;</td>
              <td align="center" valign="top"><b>Sunday</b><br>
                #mid(DateArray[1],1,2)#/#mid(DateArray[1],3,2)#</td>
              <td align="center" valign="top"><b>Monday</b><br>
                #mid(DateArray[2],1,2)#/#mid(DateArray[2],3,2)#</td>
              <td align="center" valign="top"><b>Tuesday</b><br>
                #mid(DateArray[3],1,2)#/#mid(DateArray[3],3,2)#</td>
              <td align="center" valign="top"><b>Wednesday</b><br>
                #mid(DateArray[4],1,2)#/#mid(DateArray[4],3,2)#</td>
              <td align="center" valign="top"><b>Thursday</b><br>
                #mid(DateArray[5],1,2)#/#mid(DateArray[5],3,2)#</td>
              <td align="center" valign="top"><b>Friday</b><br>
                #mid(DateArray[6],1,2)#/#mid(DateArray[6],3,2)#</td>
              <td align="center" valign="top"><b>Saturday</b><br>
                #mid(DateArray[7],1,2)#/#mid(DateArray[7],3,2)#</td>
              <td align="center" valign="top"><b>Total</b></td>
            </tr>
            <tr> 
              <td width="15%"><b>Cash</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(CashArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCash,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Credits</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(CreditArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCredit,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Customers</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(CustomerArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCustomer,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Average sale</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(AvgSalesArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalAvgSales,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>GST</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(GSTArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalGST,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Voids</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(VoidsArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalVoids,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Discounts</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(DiscountArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalDiscount,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Gross Total</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(GrossArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalGross,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>X Total</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(NetArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalNet,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>CID</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(CashInDrawArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashInDraw,"_____.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>+/-</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(DifferenceArray[lngDayIndex],"_____.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalDifference,"_____.00")#</div>
              </td>
            </tr>
          </cfoutput> 
        </table>
      </div>
    </td>
  </tr>
  <tr>
  	  <td>
	  	&nbsp;
	  </td>
  </tr>  
  <tr>
    <td>
      <div align="left">
        <table align="left" width="40%" border="0">
          <cfoutput>
		  <tr> 
            <td>Gross cash sales</td>
            <td>#numberformat(TotalCash,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Credit cards</td>
            <td>#numberformat(TotalCredit,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Gross total sales</td>
            <td>#numberformat(TotalGross,"_______.00")#</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>GST</td>
            <td>#numberformat(TotalGST,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Voids</td>
            <td>#numberformat(TotalVoids,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Discounts</td>
            <td>#numberformat(TotalDiscount,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Total net sales</td>
            <td>#numberformat(TotalNet,"_______.00")#</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>Starting stock</td>
            <td>#numberformat(dblStartingStock,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Purchases (ex.GST)</td>
            <td>#numberformat(dblPurchase,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Closing stock</td>
            <td>#numberformat(dblEndingStock,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Total Stock used</td>
            <td>#numberformat(dblStockUsed,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Computer stock($)</td>
            <td>#numberformat(dblComputerStock,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Stock discrepancy($)</td>
            <td>#numberformat(dblStockVariance,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Wastage</td>
            <td>#numberformat(dblWastage,"_______.00")#</td>
          </tr>

          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>Gross profit($)</td>
            <td>#numberformat(dblGrossProfit,"_______.00")#</td>
          </tr>
          <tr> 
            <td>Gross profit(%)</td>
            <td>#numberformat(dblGrossProfitPercentage,"_______.00")#</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>Remuneration gross($)</td>
            <td>#numberformat(dblWagesPaid,"_______.00")#</td>
          </tr>
          <tr>
            <td>Remuneration gross(%)</td>
            <td>#numberformat(dblWagesPercentage,"_______.00")#</td>
          </tr>
		  </cfoutput>
        </table>
	  </div>
    </td>
  </tr>
</table>

</body>
</HTML>

