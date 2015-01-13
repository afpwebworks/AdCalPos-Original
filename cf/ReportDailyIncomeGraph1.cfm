

<cfset lngStoreID = #form.StoreID#>
<cfoutput>#form.StoreID#</cfoutput>
<!--- <cfoutput><BR>lngStoreID: #lngStoreID#</cfoutput> --->
<cfset local.pageTitle="Summary Daily Income">
<!--- Get the store name --->
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > SELECT *
	FROM tblStores where 1=1
		<CFIF lngStoreID is not "all">
		
			  and storeID in (#lngStoreID#) 
			  
		</cfif>
	</CFQUERY>
	
<cfoutput>#form.date#</cfoutput>
<cfset strDF=right(form.date,2)>
<cfset strMF=mid(form.Date,5,2)>
<cfset strYF=left(form.Date,4)>

<!--- Set graph defaults --->
<cfparam name="width" default="450">
<cfparam name="height" default="400">


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

<!--- Get Previous Week Beginning --->
<cfset lngNumDays = -13>
<cfset strNextDate ="">
<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
<cfset prevWS = "#strNextDate#">

<!--- Get Previous Week End--->
<cfset lngNumDays = -7>
<cfset strNextDate ="">
<cf_GetXDaysFromNow baseDate="#strWE#" numDays=#lngNumDays#>
<cfset prevWE = "#strNextDate#">
<CFSET strValidDate = ''>
<CF_ValidateSaturday strDateValue= "#strWE#">

<cfset prevDF=right(#prevWE#,2)>
<cfset prevMF=mid(#prevWE#,5,2)>
<cfset prevYF=left(#prevWE#,4)>

<cfif #len(prevDF)# LT 2>
	<cfset prevDF = "0" & prevDF>
</cfif>
<cfif #len(prevMF)# LT 2>
	<cfset prevMF = "0" & prevMF>
</cfif>


<!--- Make sure that the date belongs to a Saturday --->
<cfif #strValidDate# NEQ "Y">
	<cflocation URL = "ValidDateMessage.cfm?message=Please select a Saturday">
<!--- 	<cfabort> --->
</cfif>

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

<cfinclude template="navbar_header_small.cfm">
<table width="100%" >
<tr valign="center"> 
  <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	
	<td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
  
</table>

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
	<!--- <cfoutput><BR>#PrevDateArray[lngDayIndex]#</cfoutput>  --->
</cfloop>
<cfloop query="GetStoreDetail">
<cfset lngStoreID = #GetStoreDetail.StoreID#>
<!--- Now get the values --->
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
	<CFQUERY name="GetData"      datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset prevSelectedDate = "#PrevDateArray[lngDayIndex]#">
	<cfset prevDF = "#mid(prevSelectedDate,1,2)#">
	<cfset prevMF = "#mid(prevSelectedDate,3,2)#">
	<cfset prevYF = "#mid(prevSelectedDate,5,4)#">
	<cfset strQuery = "SELECT * ">
	<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE (tblStore_ECRTotals.StoreID=#lngStoreID#) AND (convert(int,day([Date]))= convert(int,#prevDF#)) AND (convert(int,month([Date]))= convert(int,#prevMF#)) AND (convert(int,year([Date]))= convert(int,#prevYF#))">
	<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput><cfabort> --->
	<CFQUERY name="GetPrevData"      datasource="#application.dsn#" > <!--- <CFQUERY  name="GetData"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
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
	<CFSET sales = ArrayNew(1)>
	<cfset INDEX = 1>
	<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<cfset sales[INDEX] = #PrevSalesArray[lngDayIndex]#>
	<cfset INDEX = INDEX+2 >
</cfloop>
<cfset INDEX=2>
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
	<CFSET sales[INDEX] = #SalesArray[lngDayIndex]#>
	<CFSET INDEX = INDEX + 2>
</cfloop>



<CFSET customer = ArrayNew(1)>
<cfset INDEX = 1>
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
		<CFSET customer[INDEX] = #PrevCustomerArray[lngDayIndex]#>
		<CFSET INDEX = INDEX + 2>
</cfloop>
<cfset INDEX=2>
<cfloop INDEX="lngDayIndex" FROM="1" TO="7" step="1">
		<CFSET customer[index] = #CustomerArray[lngDayIndex]#>
		<CFSET INDEX = INDEX + 2>
</cfloop>



<CFSET total_customer=#TotalCustomer#>
<cfset total_sales=#TotalSales#>

<CFSET days = ArrayNew(1)>
<CFSET days[1] = "SunP">
<CFSET days[2] = "Sun">
<CFSET days[3] = "MonP">
<CFSET days[4] = "MON">
<CFSET days[5] = "TUEP">
<CFSET days[6] = "TUE">
<CFSET days[7] = "WEDP">
<CFSET days[8] = "WED">
<CFSET days[9] = "THUP">
<CFSET days[10] = "THU">
<CFSET days[11] = "FRIP">
<CFSET days[12] = "FRI">
<CFSET days[13] = "SATP">
<CFSET days[14] = "SAT">

<CFSET week_label = ArrayNew(1)>
<CFSET week_label[1] ="Total Customers">
<CFSET week_label[2] ="Total Sales">

<!--- <cfset first_round = 0> --->
<br>
<table width="100%">
	<tr valign="center"> 
		<td> 
      		<h1><cfoutput>#GetStoreDetail.StoreName#</CFOUTPUT></h1>
   		 </td>
	</tr>
	<tr> 
   	<td> 
      <h1><cfoutput>W/E #mid(prevWE,1,2)#/#mid(prevWE,3,2)#/#mid(prevWE,5,4)# and #mid(strWE,1,2)#/#mid(strWE,3,2)#/#mid(strWE,5,4)#</CFOUTPUT></h1>
         </h1>
    </td>
  </tr>
	</table>

<table width="100%" cellspacing="4" cellpadding="4" border="0">
<tr>
	<td valign="top">
	 <cfoutput>
	 <cfgraph type="BAR" FILEFORMAT="flash" graphWidth="#width#" graphHeight="#height#"
				 scaleFrom=0 scaleTo=20000 gridLines=9  depth="15" barspacing="15" colorlist="##003399, ##99ccff" showvaluelabel="NO" Title = "Sales">
					<cfloop INDEX="lngDayIndex" FROM="1" TO="14" step="1"> 
					
							<cfgraphdata item="#days[lngDayIndex]#" 
				 				value="#sales[lngDayIndex]#"> 
						
						 </cfloop> 
		</cfgraph> 
		
		<!--- <cfchart  format="flash" chartWidth="#width#" chartHeight="#height#"
				 scaleFrom=0 scaleTo=20000 gridLines=10 >

				 <cfchartseries type = "BAR">
					<cfloop INDEX="lngDayIndex" FROM="1" TO="14" step="1"> 
					
							<cfchartdata item="#days[lngDayIndex]#" 
				 				value="#sales[lngDayIndex]#"> 
						
						 </cfloop> 
				</cfchartseries>
		</cfchart> --->
	</cfoutput>	
	</td>
	<cfset first_roundcust = 0>
	<td valign="top">
	<cfoutput>
		<cfgraph type="BAR" FILEFORMAT="flash" graphWidth="#width#" graphHeight="#height#"
				 scaleFrom=0 scaleTo=1000 gridLines=9 depth="15" barspacing="15" colorlist="##00ffff, ##ff9999"  showvaluelabel="NO" Title = "Customers">
			
						<cfloop INDEX="lngDayIndex" FROM="1" TO="14" step="1">
					
							<cfgraphdata item="#days[lngDayIndex]#" 
				 				value="#customer[lngDayIndex]#"> 
							
						</cfloop>
				
		</cfgraph>
	 </cfoutput>	
	</td>

</tr>

</table>


</cfloop>
</body>
</HTML>

