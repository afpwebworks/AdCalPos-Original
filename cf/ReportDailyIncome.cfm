
<cfset lngStoreID = #URL.SID#>
<!--- <cfset local.pageTitle="Summary Daily Income"> --->
<cfset local.formname="Summary Daily Income">
<cfset sDate = #URL.FD#>
<cfset prevDate = #URL.TD#>
<!--- Get the store name --->
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > SELECT *
	FROM tblStores where 1=1
		<CFIF lngStoreID is not "all">  
			  and storeID in (#lngStoreID#) 
		</cfif>
	</CFQUERY>
<cfset strDF=right(sDate,2)>
<cfset strMF=mid(sDate,5,2)>
<cfset strYF=left(sDate,4)>
<cfif #len(strDF)# LT 2>
	<cfset strDF = "0" & strDF>
</cfif>
<cfif #len(strMF)# LT 2>
	<cfset strMF = "0" & strMF>
</cfif>
<cfset strWE = "#strDF#" & "#strMF#" & "#strYF#">
<!--- Get Current Week Beginning --->
<cfset lngNumDays = -6>
<cfset strNextDate ="">
<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
<cfset strWS = "#strNextDate#">
<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strWE#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# NEQ "Y">
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
</cfif>
<cfset prevDF=right(prevDate,2)>
<cfset prevMF=mid(prevDate,5,2)>
<cfset prevYF=left(prevDate,4)>
<cfif #len(prevDF)# LT 2>
	<cfset prevDF = "0" & prevDF>
</cfif>
<cfif #len(prevMF)# LT 2>
	<cfset prevMF = "0" & prevMF>
</cfif>
<cfset prevWE = "#prevDF#" & "#prevMF#" & "#prevYF#">

<!--- Get Previous Week Beginning --->
<cfset lngNumDays = -6>
<cfset strNextDate ="">
<cf_GetXDaysFromNow baseDate="#prevWE#" numDays=#lngNumDays#>
<cfset prevWS = "#strNextDate#">
<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#prevWE#">

<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# NEQ "Y">
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
</cfif>

<CFSET DateArray = ArrayNew(1)>
<CFSET PrevDateArray = ArrayNew(1)>
<CFSET CashArray = ArrayNew(1)>
<CFSET SalesArray = ArrayNew(1)>
<CFSET CreditArray = ArrayNew(1)>
<CFSET CustomerArray = ArrayNew(1)>
<CFSET PrevCashArray = ArrayNew(1)>
<CFSET PrevCreditArray = ArrayNew(1)>
<CFSET PrevCustomerArray = ArrayNew(1)>
<CFSET PrevSalesArray = ArrayNew(1)>
<!--- Get the dates --->
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset lngNumDays = #lngDayIndex# - 7>
	<cfset strNextDate ="">
	<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
	<CFSET DateArray[lngDayIndex] = "#strNextDate#">
	<!--- <cfoutput><BR>#DateArray[lngDayIndex]#</cfoutput>  --->
</cfloop>
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset lngNumDays = #lngDayIndex# - 7>
	<cfset strNextDate ="">
	<cf_GetXDaysFromNow baseDate="#prevWE#" numDays=#lngNumDays#>
	<CFSET PrevDateArray[lngDayIndex] = "#strNextDate#">
</cfloop>
<form action="ReportDailyIncomeGraph1.cfm" method="post">
	<cfoutput>
		<input type="hidden" name="date" value="#sDate#" >
		<input type="hidden" name="StoreID" value="#lngStoreID#" >
	</cfoutput>
	<cfinclude template="navbar_header_small.cfm">
	
	<table width="100%" >
	<tr valign="center"> 
		 <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
</table>

	<table align="center" width="90%" border="0">
<tr>
 	<td align="center">
		<input type="submit" name="graphBtn" value="View Graph">
		
	</td>
 </tr>
 	</table>
</form>
<cfloop query="GetStoreDetail">
<cfset lngStoreID = #GetStoreDetail.StoreID#> 
<!--- Now get the values --->
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset strSelectedDate = "#DateArray[lngDayIndex]#">
	<cfset strDF = "#mid(strSelectedDate,1,2)#">
	<cfset strMF = "#mid(strSelectedDate,3,2)#">
	<cfset strYF = "#mid(strSelectedDate,5,4)#">
	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE ">
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & "(tblStore_ECRTotals.StoreID IN(#lngStoreID#)) and ">
	</cfif>
	 <cfset strQuery = strQuery & " (convert(int,day([Date]))= convert(int,#strDF#))  ">
	 <cfset strQuery = strQuery & "AND (convert(int,month([Date]))= convert(int,#strMF#)) ">
	 <cfset strQuery = strQuery & "AND (convert(int,year([Date]))= convert(int,#strYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetData" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset prevSelectedDate = "#PrevDateArray[lngDayIndex]#">
	<cfset prevDF = "#mid(prevSelectedDate,1,2)#">
	<cfset prevMF = "#mid(prevSelectedDate,3,2)#">
	<cfset prevYF = "#mid(prevSelectedDate,5,4)#">
	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE ">
	<cfif #lngStoreID# is not "all" >
	<cfset strQuery = strQuery & " (tblStore_ECRTotals.StoreID IN(#lngStoreID#)) AND ">
	</cfif>
	<cfset strQuery = strQuery & " (convert(int,day([Date]))= convert(int,#prevDF#)) AND (convert(int,month([Date]))= convert(int,#prevMF#)) AND (convert(int,year([Date]))= convert(int,#prevYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetPrevData"   datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<CFSET CashArray[lngDayIndex] = 0>
	<CFSET CreditArray[lngDayIndex] = 0>
	<CFSET SalesArray[lngDayIndex] = 0>
	<CFSET CustomerArray[lngDayIndex] = 0>
	<CFSET PrevCashArray[lngDayIndex] = 0>
	<CFSET PrevCreditArray[lngDayIndex] = 0>
	<CFSET PrevCustomerArray[lngDayIndex] = 0>
	<CFSET PrevSalesArray[lngDayIndex] = 0>
	<cfif #GetData.RecordCount# GT 0>
		<CFSET CashArray[lngDayIndex] = #GetData.CashSalesD# >
		<CFSET CreditArray[lngDayIndex] = #GetData.CreditSalesD#>
		<CFSET SalesArray[lngDayIndex] = CashArray[lngDayIndex] + CreditArray[lngDayIndex]>
		<CFSET CustomerArray[lngDayIndex] = #GetData.CashSales# + #GetData.CreditSales# >
	</cfif>
	<cfif #GetPrevData.RecordCount# GT 0>
		<CFSET PrevCashArray[lngDayIndex] = #GetPrevData.CashSalesD# >
		<CFSET PrevCreditArray[lngDayIndex] = #GetPrevData.CreditSalesD#>
		<CFSET PrevSalesArray[lngDayIndex] = PrevCashArray[lngDayIndex] + PrevCreditArray[lngDayIndex]>
		<CFSET PrevCustomerArray[lngDayIndex] = #GetPrevData.CashSales# + #GetPrevData.CreditSales# >
	</cfif>
</cfloop>
	<cfset TotalCash = 0 >
	<cfset TotalCredit = 0>
	<cfset TotalSales = 0>
	<cfset TotalCustomer = 0>
	<cfset TotalPrevCash = 0 >
	<cfset TotalPrevCredit = 0>
	<cfset TotalPrevSales = 0>
	<cfset TotalPrevCustomer = 0>
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset TotalCash = #TotalCash# + #CashArray[lngDayIndex]# >
	<cfset TotalCredit = #TotalCredit# + #CreditArray[lngDayIndex]#>
	<cfset TotalSales = #TotalSales# + #SalesArray[lngDayIndex]#>
	<cfset TotalCustomer = #TotalCustomer# + #CustomerArray[lngDayIndex]#>
	<cfset TotalPrevCash = #TotalPrevCash# + #PrevCashArray[lngDayIndex]# >
	<cfset TotalPrevCredit = #TotalPrevCredit# + #PrevCreditArray[lngDayIndex]#>
	<cfset TotalPrevSales = #TotalPrevSales# + #PrevSalesArray[lngDayIndex]#>
	<cfset TotalPrevCustomer = #TotalPrevCustomer# + #PrevCustomerArray[lngDayIndex]#>
</cfloop>

<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- --------------------------------------------------- --->
<!--- Now get the data for the second part of this report --->
 <cfset strPageTitle = "#GetStoreDetail.StoreName# Daily Income"> 
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
<table width="100%" >
<tr><td>&nbsp;</td></tr>
<tr valign="center"> 
 	<td > 
      <h1><cfoutput>#strPageTitle#</font></CFOUTPUT></h1>
    </td>
</tr>
<tr valign="center"> 
   <td colspan="3"> 
      <h1><cfoutput>Week Ending #mid(prevWE,1,2)#/#mid(prevWE,3,2)#/#mid(prevWE,5,4)#</CFOUTPUT></h1>
   </td>
</tr>
</table>
<table align="center" width="90%" border="0">
  <tr>
    <td>
      <div align="left">
	    <table align="left" width="95%" cellspacing="2" cellpadding="0" border="1">
          <cfoutput> 
            <tr> 
              <td width="15%">&nbsp;</td>
              <td align="center" valign="top"><b>Sunday</b><br>
                #mid(PrevDateArray[1],1,2)#/#mid(PrevDateArray[1],3,2)#</td>
              <td align="center" valign="top"><b>Monday</b><br>
                #mid(PrevDateArray[2],1,2)#/#mid(PrevDateArray[2],3,2)#</td>
              <td align="center" valign="top"><b>Tuesday</b><br>
                #mid(PrevDateArray[3],1,2)#/#mid(PrevDateArray[3],3,2)#</td>
              <td align="center" valign="top"><b>Wednesday</b><br>
                #mid(PrevDateArray[4],1,2)#/#mid(PrevDateArray[4],3,2)#</td>
              <td align="center" valign="top"><b>Thursday</b><br>
                #mid(PrevDateArray[5],1,2)#/#mid(PrevDateArray[5],3,2)#</td>
              <td align="center" valign="top"><b>Friday</b><br>
                #mid(PrevDateArray[6],1,2)#/#mid(PrevDateArray[6],3,2)#</td>
              <td align="center" valign="top"><b>Saturday</b><br>
                #mid(PrevDateArray[7],1,2)#/#mid(PrevDateArray[7],3,2)#</td>
              <td align="center" valign="top"><b>Total</b></td>
            </tr>
            <tr> 
              <td width="15%"><b>Sales</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(PrevSalesArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalPrevSales,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Customers</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(PrevCustomerArray[lngDayIndex],"_____")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalPrevCustomer,"_____")#</div>
              </td>
            </tr>
         
          </cfoutput>
		   </table>
        </div>
		</td>
	</tr>
</table>
<br><br>
<table width="100%">
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
              <td width="15%"><b>Sales</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(SalesArray[lngDayIndex],"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalSales,"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Customers</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">#numberformat(CustomerArray[lngDayIndex],"_____")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat(TotalCustomer,"_____")#</div>
              </td>
            </tr>
          </cfoutput> 
        </table>
      </div>
    </td>
  </tr>
</table>
<br><br>
<table width="100%" >
  <tr valign="center"> 
 	<td colspan="3"> 
     <h1>Comparison New - Older Week</h1>
    </td>
  </tr>
</table>
<table align="center" width="90%" border="0">
  <tr>
    <td>
      <div align="left">
	    <table align="left" width="95%" cellspacing="2" cellpadding="0" border="1">
          <cfoutput> 
            <tr> 
              <td width="15%">&nbsp;</td>
              <td align="center" valign="top"><b>Sunday</b><br></td>
              <td align="center" valign="top"><b>Monday</b><br></td>
              <td align="center" valign="top"><b>Tuesday</b><br></td>
              <td align="center" valign="top"><b>Wednesday</b><br></td>
              <td align="center" valign="top"><b>Thursday</b><br></td>
              <td align="center" valign="top"><b>Friday</b><br></td>
              <td align="center" valign="top"><b>Saturday</b><br></td>
              <td align="center" valign="top"><b>Total</b></td>
            </tr>
            <tr> 
              <td width="15%"><b>Sales +/-</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">
					#numberformat((PrevSalesArray[lngDayIndex]-SalesArray[lngDayIndex]),"_______.00")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat((TotalPrevSales-TotalSales),"_______.00")#</div>
              </td>
            </tr>
            <tr> 
              <td width="15%"><b>Customers +/-</b></td>
			  <cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	              <td> 
    	            <div align="right">
					#numberformat((PrevCustomerArray[lngDayIndex]-CustomerArray[lngDayIndex]),"_____")#</div>
        	      </td>
			  </cfloop>
              <td> 
                <div align="right">#numberformat((TotalPrevCustomer-TotalCustomer),"_____")#</div>
              </td>
            </tr>
			
          </cfoutput> 
        </table>
		</div>
		</td>
	</tr>
</table>

</cfloop>
</body>
</HTML>

