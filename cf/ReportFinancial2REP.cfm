
<cfset lngStoreID = #form.lngStoreID#>
<!--- <cfset lngDF = #form.DF#>
<cfset lngMF = #form.MF#>
<cfset lngYF = #form.YF#>
<cfset lngDT = #form.DT#>
<cfset lngMT = #form.MT#>
<cfset lngYT = #form.YT#> --->

<!--- - 23/12/2003 - setup date parts - --->
<cfset lngDF=right(form.sDate,2)>
<cfset lngMF=mid(form.sDate,5,2)>
<cfset lngYF=left(form.sDate,4)>
<cfset lngDT=right(form.eDate,2)>
<cfset lngMT=mid(form.eDate,5,2)>
<cfset lngYT=left(form.eDate,4)>

<!--- Get the store name --->
<cfset strQuery = "SELECT * from tblStores where StoreID =#lngStoreID#">
<CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>




<cfset strPageTitle = "#GetStoreDetail.StoreName#">

<cfset strQuery = "SELECT Sum(tblStore_ECRTotals.RoundingsD) AS RoundingsD, Sum(tblStore_ECRTotals.DiscountD) AS DiscountD, Sum(tblStore_ECRTotals.CashSalesD) AS CashSalesD, Sum(tblStore_ECRTotals.CreditSalesD) AS CreditSalesD, Sum(tblStore_ECRTotals.EFTCashOutD) AS EFTCashOutD, Sum(tblStore_ECRTotals.CashRefundD) AS CashRefundD, Sum(tblStore_ECRTotals.CreditRefundD) AS CreditRefundD, Sum(tblStore_ECRTotals.CashSalesGSTincD) AS CashSalesGSTincD, Sum(tblStore_ECRTotals.CashSaleGSTfreeD) AS CashSaleGSTfreeD, Sum(tblStore_ECRTotals.CreditSalesGSTincD) AS CreditSalesGSTincD, Sum(tblStore_ECRTotals.CreditSalesGSTfreeD) AS CreditSalesGSTfreeD, Sum(tblStore_ECRTotals.GSTCashSaleD) AS GSTCashSaleD, Sum(tblStore_ECRTotals.GSTCreditSaleD) AS GSTCreditSaleD, Sum(tblStore_ECRTotals.CashInD) AS CashInD, Sum(tblStore_ECRTotals.CashOutD) AS CashOutD, Sum(tblStore_ECRTotals.CancellationD) AS CancellationD ">
<cfset strQuery = strQuery & "FROM tblStore_ECRTotals ">
<cfset strQuery = strQuery & "WHERE (((tblStore_ECRTotals.StoreID)=#lngStoreID#) AND ((tblStore_ECRTotals.Date) Between DateSerial(#lngYF#,#lngMF#,#lngDF#) And DateSerial(#lngYT#,#lngMT#,#lngDT#)))">

<CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
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
	<cfset dblCashSalesD = #GetRecord.CashSalesD#>
	<cfset dblCreditSalesD = #GetRecord.CreditSalesD#>
	<cfset dblGrossTotalSales = (#GetRecord.CashSalesD# + #GetRecord.CreditSalesD#)>
	<cfset dblGST = (#GetRecord.GSTCashSaleD# + #GetRecord.GSTCreditSaleD#)>
	<cfset dblVoids = (#GetRecord.CashRefundD# + #GetRecord.CreditRefundD#)>
	<cfset dblDiscountD = #GetRecord.DiscountD#>
	<cfset dblTotalNetSales = (#dblGrossTotalSales# - #dblGST# - #dblVoids# - #dblDiscountD#)>
</cfif>

<!--- <cfset strQuery = " SELECT tblEodSummary.Date, tblEodSummary.StoreID, tblEodSummary.StartingStockValEx ">
<cfset strQuery = StrQuery & "FROM tblEodSummary ">
<cfset strQuery = StrQuery & "WHERE (((tblEodSummary.Date)="01022003"))">

<CFQUERY name="GetData" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblStartingStock = 0>
<cfif #GetData.RecordCount# GT 0>
	<cfset dblStartingStock = #GetData.#>
</cfif> --->


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
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="Payroll.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
        <table width="80%" border="0" align="left">
          <cfoutput>
		  <tr> 
            <td width="60%">Gross cash sales</td>
            <td>#dblCashSalesD#</td>
          </tr>
          <tr> 
            <td width="60%">Credit cards</td>
            <td>#dblCreditSalesD#</td>
          </tr>
          <tr> 
            <td width="60%">Gross total sales</td>
            <td>#dblGrossTotalSales#</td>
          </tr>
          <tr> 
            <td width="60%">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">GST</td>
            <td>#dblGST#</td>
          </tr>
          <tr> 
            <td width="60%">Voids</td>
            <td>#dblVoids#</td>
          </tr>
          <tr> 
            <td width="60%">Discounts</td>
            <td>#dblDiscountD#</td>
          </tr>
          <tr> 
            <td width="60%">Total net sales</td>
            <td>#dblTotalNetSales#</td>
          </tr>
          <tr> 
            <td width="60%">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Starting stock</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Purchases (ex.GST)</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Closing stock</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Total Stock used</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Computer stock($)</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Stock discrepancy($)</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Gross profit($)</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Gross profit(%)</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="60%">Remuneration gross($)</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="60%">Remuneration gross(%)</td>
            <td>&nbsp;</td>
          </tr>
		  </cfoutput>
        </table>
	   </div>
    </td>
  </tr>
</table>
</body>
</HTML>

