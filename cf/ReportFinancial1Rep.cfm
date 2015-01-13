 <cfset Reporting =   application.beanfactory.getBean("Reporting") />
 <cfset StoresDAO =   application.beanfactory.getBean("StoresDAO") />


<!--------[  Parse the dates into the formats used by this processing page:  - MK ]------>
<cfinclude template="/cf/CalendarParse3.cfm" />

<cfset lngStoreID = #form.txtStoreID#>
<!---[   Strip out any reference to "ALL" unless the only requirement is "all"   ]---->
<cfif lngStoreID NEQ "ALL">
    <cfset lngStoreID = replacenocase(form.txtStoreID, "All,","","ALL")>
</cfif>
<cfset GetStoreDetail = StoresDAO.getStoreDetails( lngStoreID  ) />


<cfset strDF=right(form.sDate,2)>
<!--- Start Date --->
<cfset strMF=mid(form.sDate,5,2)>
<cfset strYF=left(form.sDate,4)>

<cfif #len(strDF)# LT 2>
	<cfset strDF = "0" & strDF>
</cfif>
<cfif #len(strMF)# LT 2>
	<cfset strMF = "0" & strMF>
</cfif>
<cfset strWS = "#strDF#" & "#strMF#" & "#strYF#">
<cfset StartDate = createdate(strYF, strMF, strDF ) />
<!--- <cfset strNextDate = #strWS#> --->

<!--- Ending Date --->
<cfset strDF=right(form.eDate,2)>
<cfset strMF=mid(form.eDate,5,2)>
<cfset strYF=left(form.eDate,4)>

<cfif #len(strDF)# LT 2>
	<cfset strDF = "0" & strDF>
</cfif>
<cfif #len(strMF)# LT 2>
	<cfset strMF = "0" & strMF>
</cfif>
<cfset strWE = "#strDF#" & "#strMF#" & "#strYF#">
<cfset EndDate = createdate(strYF, strMF, strDF ) />


<!--- calculate number of days between two dates. --->

<cfset  lngNumDaysToPrint = 1 + #EndDate# - #StartDate#    >

<!---[   <cfoutput><BR>Start #startDate# End #endDate# No Of Days #lngNumDaysToPrint# </CFOUTPUT>   ]---->

<CFSET DateArray = ArrayNew(1)>
<CFSET CashArray = ArrayNew(1)>
<CFSET CreditArray = ArrayNew(1)>
<CFSET CustomerArray = ArrayNew(1)>
<CFSET AvgSalesArray = ArrayNew(1)>
<CFSET GSTArray = ArrayNew(1)>
<CFSET RoundingArray = ArrayNew(1)>
<CFSET CancellationArray = ArrayNew(1)>
<CFSET DiscountArray = ArrayNew(1)>
<CFSET NetCashInDrawArray = ArrayNew(1)>
<CFSET NetCreditInDrawArray = ArrayNew(1)>
<CFSET MoneyInDrawArray = ArrayNew(1)>
<CFSET xTotalArray = ArrayNew(1)>
<CFSET EFTCashoutDArray = ArrayNew(1)>
<CFSET CashExpensesArray = ArrayNew(1)>
<CFSET CashWagesArray = ArrayNew(1)>
<CFSET CashInDrawArray = ArrayNew(1)>
<CFSET CreditInDrawArray = ArrayNew(1)>
<CFSET DifferenceArray = ArrayNew(1)>
<CFSET CashRefundsArray = ArrayNew(1)>
<CFSET CreditRefundsArray = ArrayNew(1)>
<CFSET CashRefundsDArray = ArrayNew(1)>
<CFSET CreditRefundsDArray = ArrayNew(1)>



<!--- Get the dates --->
<cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	<cfset lngNumDays = #lngDayIndex# - #lngNumDaysToPrint#>
	<cfset strNextDate ="">
	<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
	<CFSET DateArray[lngDayIndex] = "#strNextDate#">
<!--- 	<cfoutput><BR>#DateArray[lngDayIndex]#</cfoutput> --->
</cfloop>

<!--- Now get the values --->
<cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">

	<cfset strSelectedDate = "#DateArray[lngDayIndex]#">
	<cfset strDF = "#mid(strSelectedDate,1,2)#">
	<cfset strMF = "#mid(strSelectedDate,3,2)#">
	<cfset strYF = "#mid(strSelectedDate,5,4)#">
    
    <cfset takingsdate = createdate(strYF, strMF, strDF ) />
    
    <cfset getdata = Reporting.getECSTotals( takingsdate, lngStoreID  ) />

	<!--- Get the cash wages --->
	<cfset strQuery = "select (sum(TaxableIncome) + sum(NonTaxableIncome) - sum(Tax)) as dblCashWages ">
	<cfset strQuery = strQuery & "FROM tblEmpPayRollPaid ">
	<cfset strQuery = strQuery & "WHERE ">
	<cfif #lngStoreID# is not "all" >
	<cfset strQuery = strQuery & " (tblEmpPayRollPaid.StoreID IN(#lngStoreID#)) AND ">
	</cfif>
	<cfset strQuery = strQuery & "(tblEmpPayRollPaid.PaymentMethod = 'CSH' ) AND (convert(int,day([DateEntered]))= convert(int,#strDF#)) AND (convert(int,month([DateEntered]))= convert(int,#strMF#)) AND (convert(int,year([DateEntered]))= convert(int,#strYF#))">
	<CFQUERY name="GetCashWages" datasource="#application.dsn#"  maxrows="1"> #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
	
	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_CashInDraw ">
	<cfset strQuery = strQuery & "WHERE ">
	<cfif #lngStoreID# is not "all" >
	<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND ">
	</cfif>
	<cfset strQuery = strQuery & "(convert(int,day([Date]))= convert(int,#strDF#)) AND (convert(int,month([Date]))= convert(int,#strMF#)) AND (convert(int,year([Date]))= convert(int,#strYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetCIDData"      datasource="#application.dsn#"  maxrows="1"> <!--- <CFQUERY  name="GetData"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	<!--- Get the cash expenses --->
	<cfset strQuery = "SELECT SUM(TotalAmountIncGST) AS STotalAmountIncGST1, SUM(GST) AS SGST, SUM(TotalAmountIncGST - GST) AS ExGST ">
	<cfset strQuery = strQuery & "FROM dbo.tblSupplierTranDet ">
	<cfset strQuery = strQuery & "WHERE ">
	<cfif #lngStoreID# is not "all" >
	<cfset strQuery = strQuery & "(StoreID IN(#lngStoreID#)) AND">
	</cfif>
	<cfset strQuery = strQuery & "  (PurchaseDate = '#strSelectedDate#') AND (PaymentMethod = 'CSH')">	
	
	<CFQUERY name="GetCashExpenses"      datasource="#application.dsn#"  maxrows="1"> #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset dblCashExpense = 0>
	<cfif #GetCashExpenses.RecordCount# gt 0>
		<cfif #IsNumeric(GetCashExpenses.STotalAmountIncGST1)#>
			<cfset dblCashExpense = #GetCashExpenses.STotalAmountIncGST1#>
		</cfif>
	</cfif>
	
	
	<CFSET CashArray[lngDayIndex] = 0>
	<CFSET CreditArray[lngDayIndex] = 0>
	<CFSET CustomerArray[lngDayIndex] = 0>
	<CFSET AvgSalesArray[lngDayIndex] = 0>
	<CFSET GSTArray[lngDayIndex] = 0>
	<CFSET RoundingArray[lngDayIndex] = 0>	
	<CFSET CancellationArray[lngDayIndex] = 0>	
	<CFSET DiscountArray[lngDayIndex] = 0>
	<CFSET NetCashInDrawArray[lngDayIndex] = 0>
    <CFSET NetCreditInDrawArray[lngDayIndex] = 0>
    <CFSET MoneyInDrawArray[lngDayIndex] = 0>    
	<CFSET xTotalArray[lngDayIndex] = 0>
    <cfset EFTCashoutDArray[lngDayIndex] = 0>
	<CFSET CashExpensesArray[lngDayIndex] = 0>	
	<CFSET CashWagesArray[lngDayIndex] = 0>
	<CFSET CashInDrawArray[lngDayIndex] = 0>
	<CFSET CreditInDrawArray[lngDayIndex] = 0>
	<CFSET DifferenceArray[lngDayIndex] = 0>
	<CFSET CashRefundsArray[lngDayIndex] = 0>
	<CFSET CashRefundsDArray[lngDayIndex] = 0>
	<CFSET CreditRefundsArray[lngDayIndex] = 0>
	<CFSET CreditRefundsDArray[lngDayIndex] = 0>	
	
	<cfloop query ="GetCashWages">
		<cfif #isnumeric(GetCashWages.dblCashWages)#>
			<CFSET CashWagesArray[lngDayIndex] = CashWagesArray[lngDayIndex] + #GetCashWages.dblCashWages# >
		</cfif>
	</cfloop>
	
	<cfloop query ="GetData">
		<CFSET CashArray[lngDayIndex] = CashArray[lngDayIndex]  + #GetData.CashSalesD# >
		<CFSET CreditArray[lngDayIndex] = CreditArray[lngDayIndex] + #GetData.CreditSalesD#>
		<CFSET CustomerArray[lngDayIndex] = CustomerArray[lngDayIndex] + #GetData.CashSales# + #GetData.CreditSales# >
		<CFSET GSTArray[lngDayIndex] = GSTArray[lngDayIndex] + #GetData.GSTCashSaleD# + #GetData.GSTCreditSaleD#>
		<CFSET RoundingArray[lngDayIndex] = RoundingArray[lngDayIndex] + (#GetData.RoundingsD# / 100 ) >	
		<CFSET CancellationArray[lngDayIndex] = CancellationArray[lngDayIndex] + #GetData.CancellationD# >
		<CFSET DiscountArray[lngDayIndex] = DiscountArray[lngDayIndex] + #GetData.DiscountD#>
        <CFSET EFTCashoutDArray[lngDayIndex] = EFTCashoutDArray[lngDayIndex] + #GetData.EFTCashOutd#>
        <CFSET DiscountArray[lngDayIndex] = DiscountArray[lngDayIndex] + #GetData.DiscountD#>
		<CFSET CashRefundsArray[lngDayIndex] = CashRefundsArray[lngDayIndex] + #GetData.CashRefunds#>
		<CFSET CashRefundsDArray[lngDayIndex] = CashRefundsDArray[lngDayIndex] + #GetData.CashRefundD#>
		<CFSET CreditRefundsArray[lngDayIndex] = CreditRefundsArray[lngDayIndex] + #GetData.CreditRefunds#>
		<CFSET CreditRefundsDArray[lngDayIndex] = CreditRefundsDArray[lngDayIndex] + #GetData.CreditRefundD#>
	</cfloop>
	

<!--- LM 2004-05-26 change dthe condition checking --->
<!--- 	<cfif  #isnumeric(GetData.CashSales)# + #isnumeric(GetData.CreditSales)# NEQ 0> --->
    <cfif  #CustomerArray[lngDayIndex]# NEQ 0>
			<CFSET AvgSalesArray[lngDayIndex] = (#CashArray[lngDayIndex]# + #CreditArray[lngDayIndex]#) / (#CustomerArray[lngDayIndex]#)>
			
	</cfif>
    <cfloop query = "GetCIDData">
		<cfif #isnumeric(GetCIDData.CashInDraw)#>
			<CFSET CashInDrawArray[lngDayIndex] = CashInDrawArray[lngDayIndex] + #GetCIDData.CashInDraw# >
		</cfif>	
		<cfif #isnumeric(GetCIDData.CreditInDraw)#>
			<CFSET CreditInDrawArray[lngDayIndex] = CreditInDrawArray[lngDayIndex] + #GetCIDData.CreditInDraw# >
         </cfif>	
	</cfloop>

	<CFSET CashExpensesArray[lngDayIndex] =  #dblCashExpense# >
	<CFSET NetCashInDrawArray[lngDayIndex] = #CashArray[lngDayIndex]# - #EFTCashoutDArray[lngDayIndex]#  >
    <CFSET NetCreditInDrawArray[lngDayIndex] = #CreditArray[lngDayIndex]# + #EFTCashoutDArray[lngDayIndex]#  >
    <CFSET MoneyInDrawArray[lngDayIndex] = #NetCashInDrawArray[lngDayIndex]# + #NetCreditInDrawArray[lngDayIndex]#  >

	<CFSET xTotalArray[lngDayIndex] = #CashArray[lngDayIndex]# + #CreditArray[lngDayIndex]# + #DiscountArray[lngDayIndex]# >
	<CFSET DifferenceArray[lngDayIndex] = #CashInDrawArray[lngDayIndex]# + #CreditInDrawArray[lngDayIndex]# - #MoneyInDrawArray[lngDayIndex]#  >
</cfloop>


<cfset TotalCash = 0 >
<cfset TotalCredit = 0>
<cfset TotalCustomer = 0>
<cfset TotalAvgSales = 0>
<cfset TotalGST = 0>
<cfset TotalRounding = 0>
<cfset TotalCancellation = 0>
<cfset TotalDiscount = 0>
<cfset TotalNetCashInDraw = 0>
<cfset TotalNetCreditInDraw = 0>
<cfset TotalMoneyInDraw = 0>
<CFSET TotalxTotal = 0>
<CFSET TotalCashExpense = 0>
<CFSET TotalCashWages = 0>
<CFSET TotalCashInDraw = 0>
<CFSET TotalCreditInDraw = 0>
<CFSET TotalDifference = 0>
<CFSET TotalEFTCashoutD = 0 />
<CFSET TotalCashRefunds = 0>
<CFSET TotalCashRefundsD = 0>
<CFSET TotalCreditRefunds = 0>
<CFSET TotalCreditRefundsD = 0>


<cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	<cfset TotalCash = #TotalCash# + #CashArray[lngDayIndex]# >
	<cfset TotalCredit = #TotalCredit# + #CreditArray[lngDayIndex]#>
	<cfset TotalCustomer = #TotalCustomer# + #CustomerArray[lngDayIndex]#>
	<cfset TotalGST = TotalGST + #GSTArray[lngDayIndex]# >
	<cfset TotalRounding = TotalRounding + #RoundingArray[lngDayIndex]#>
	<cfset TotalCancellation = TotalCancellation + #CancellationArray[lngDayIndex]#>
	<cfset TotalDiscount = TotalDiscount + #DiscountArray[lngDayIndex]#>
	<cfset TotalNetCashInDraw = TotalNetCashInDraw + #NetCashInDrawArray[lngDayIndex]# >
    <cfset TotalNetCreditInDraw = TotalNetCreditInDraw + #NetCreditInDrawArray[lngDayIndex]# >
    <cfset TotalMoneyInDraw = TotalMoneyInDraw + #MoneyInDrawArray[lngDayIndex]# >    
 	<CFSET TotalxTotal = TotalxTotal + xTotalArray[lngDayIndex]>
	<cfset TotalCashExpense = TotalCashExpense + #CashExpensesArray[lngDayIndex]#>
	<cfset TotalCashWages = TotalCashWages + #CashWagesArray[lngDayIndex]#>
	<CFSET TotalCashInDraw = TotalCashInDraw + CashInDrawArray[lngDayIndex]>
	<CFSET TotalCreditInDraw = TotalCreditInDraw + CreditInDrawArray[lngDayIndex]>
    <CFSET TotalEFTCashoutD = TotalEFTCashoutD + EFTCashOutdArray[lngDayIndex]>
	<CFSET TotalDifference = TotalDifference + DifferenceArray[lngDayIndex]>
	<cfset TotalCashRefunds = #TotalCashRefunds# + #CashRefundsArray[lngDayIndex]#>
	<cfset TotalCashRefundsD = #TotalCashRefundsD# + #CashRefundsDArray[lngDayIndex]#>
	<cfset TotalCreditRefunds = #TotalCreditRefunds# + #CreditRefundsArray[lngDayIndex]#>
	<cfset TotalCreditRefundsD = #TotalCreditRefundsD# + #CreditRefundsDArray[lngDayIndex]#>
</cfloop>
<cfif TotalCustomer GT 0>
	<cfset TotalAvgSales = (TotalCash + TotalCredit) / TotalCustomer>
<cfelse>
	<cfset TotalAvgSales = 0>
</cfif>


 <cfset strPageTitle = "Daily Takings"> 
 
<!---[    <h1><cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			</h1>   ]---->
            
            

<!---[   <HTML><HEAD>
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
   ]---->
  <cfinclude template="/includes/header.cfm" /> 
<table width="100%">
  <tr valign="center"> 
    <td width="25%">&nbsp;</td>
 	<td> 
      <h1><cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			</h1>
    </td>
    <td width="25%">&nbsp; 
     
    </td>
  </tr>
  <tr valign="center"> 
 	<td colspan="3"> 
      <h1><cfoutput>Dates Included From #mid(strWS,1,2)#/#mid(strWS,3,2)#/#mid(strWS,5,4)# To #mid(strWE,1,2)#/#mid(strWE,3,2)#/#mid(strWE,5,4)#<br />
No Of Days: #lngNumDaysToPrint#</CFOUTPUT></h1>
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

      			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
                    <td align="center" valign="top"><b>#mid(DateArray[lngDayIndex],1,2)#/#mid(DateArray[lngDayIndex],3,2)#/#mid(DateArray[lngDayIndex],5,4)#</b></td>
      			  </cfloop>
                
              <td align="center" valign="top"><b>Total</b></td>
            </tr>
            <tr> 
              <td width="15%"><b>Cash Sales</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCash,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>CC Sales</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CreditArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCredit,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Customers</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CustomerArray[lngDayIndex],"_____")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCustomer,"_____")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Avg Sale</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(AvgSalesArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalAvgSales,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>GST Collect</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(GSTArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalGST,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Rounding</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(RoundingArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalRounding,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Voids</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CancellationArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCancellation,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Discounts</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(DiscountArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalDiscount,"_______.00")#</div>
              </td>
            </tr>
			<tr> 
			  <td width="15%"><b>Refund Qty</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashRefundsArray[lngDayIndex]+CreditRefundsArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashRefunds+TotalCreditRefunds,"_______.00")#</div>
              </td>
            </tr>
			<tr> 
              <td width="15%"><b> Refund Amt</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashRefundsDArray[lngDayIndex]+CreditRefundsDArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashRefundsD+TotalCreditRefundsD,"_______.00")#</div>
              </td>
            </tr>
             <tr> 
              <td colspan="9">&nbsp;</td>
             </tr> 
            <tr> 
              <td width="15%"><b>X Total</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(xTotalArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalxTotal,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Cash Exp.</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashExpensesArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashExpense,"_______.00")#</div>
              </td>
            </tr>
             <tr> 
              <td width="15%"><b>Cash Wages</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashWagesArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashWages,"_______.00")#</div>
              </td>
            </tr>
            
             <tr> 
              <td colspan="9">&nbsp;</td>
             </tr> 
            <tr>
            	<td width="15%"><strong>Cash Out</strong></td>
                <cfloop  INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1"><td><div align="right">#numberformat(EFTCashoutDArray[lngDayIndex],"_______.00")#</div></td>
                </cfloop>
                <td align="right">#numberformat(TotalEFTCashoutD, "_____.00")#</td>
            </tr>
            <tr> 
              <td width="15%"><b>Cash In Draw</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(NetCashInDrawArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalNetCashInDraw,"_______.00")#</div>
              </td>
            </tr>
             <tr> 
              <td width="15%"><b>Cash Counted</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CashInDrawArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCashInDraw,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>CC in Draw</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(NetCreditInDrawArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalNetCreditInDraw,"_______.00")#</div>
              </td>
            </tr>
              <tr> 
              <td width="15%"><b>CC Counted</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(CreditInDrawArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCreditInDraw,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Money in Draw</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(MoneyInDrawArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalMoneyInDraw,"_______.00")#</div>
              </td>
            </tr>
           <tr> 
              <td width="15%"><b>+/-</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO=#lngNumDaysToPrint# step="1">
	              <td> 
    	            <div align="right">#numberformat(DifferenceArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalDifference,"_______.00")#</div>
              </td>
            </tr>
          </cfoutput> 
        </table>
      </div>
    </td>
  </tr>
</table>

</body>
</HTML>

