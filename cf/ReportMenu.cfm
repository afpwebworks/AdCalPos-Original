<cfsilent>
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<!---[  MK 3/8/2010 -  Added test for usertype 1,2 only to have the "all stores" choice  ]---->

<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmReportMenu">
<cfset local.page="ReportMenu.cfm">
<cfset strPageTitle = "Reports Menu">
<cfset lngUserType = #session.user.getUserType()# >
<cfif NOT(isdefined("StoresDAO"))>
  <cfset StoresDAO =   application.beanfactory.getBean("StoresDAO") />
</cfif>
<cfif NOT(isdefined("ReportEngine"))>
  <cfset ReportEngine =   application.beanfactory.getBean("Reporting") />
</cfif>
<cfscript>
	GetStores = StoresDAO.getAllStores() ;
</cfscript>

<cfset GetCurrentStore = application.beanfactory.getBean("StoreBean") />
<!---[   Set up data for the page   ]---->
<cfscript>
  GetStores = StoresDAO.getAllStores();
  lngUserType = session.user.getusertype() ;
  GetCurrentStore.setStoreID(  session.user.getStoreID()  ) ;
  StoresDAO.read( GetCurrentStore   );
</cfscript>
<!---[   <CFQUERY name="GetStores" datasource="#application.dsn#"  > 
SELECT s.StoreID, s.StoreName, sg.StoreGroupId, sg.StoreGroup
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
ORDER BY sg.StoreGroup, s.StoreName
</CFQUERY>   ]---->
<!---[   <CFQUERY name="GetCurrentStore" datasource="#application.dsn#"  > 
SELECT s.StoreName
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
AND s.StoreID=#Session.StoreID#

</CFQUERY>   ]---->

<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->


</cfsilent>
<HTML>
<HEAD>
<meta http-equiv="expires" content="mon, 01 jan 1990 00:00:01 gmt">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="cache-control" value="no-cache, no-store, must-revalidate">
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
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
<!--- - wb 12/12/2003 - calendar error checking scripts - --->

<script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/validation.js" type="text/javascript"></script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<cfoutput>
<table width="100%" border="0">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1>#strPageTitle#</h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<cfset strDateToday = ''>
<cf_GetTodayDate>
<FORM action="ReportMenuAction.cfm" id="frmReportMenu" method="post" name="frmReportMenu" onSubmit="return submitCheck('frmReportMenu');">
  <!--- - wb 22/12/2003 - Display calendar - --->
  <cfinclude template="CalendarDisplay2.cfm">
  <br />
  <table width="100%" border="0">
    <tr>
      <td align="center"><select name="txtStoreID" multiple="multiple" size="5">
          <!---[   Added test for usertype 1,2 only to have the "all stores" choice  - MK 3/8/2010  ]---->
          <cfif session.user.getUserType() LT 3> 
            <option value="all" selected>All Stores</option>
          </cfif>  
          <cfloop Query = "GetStores">
          <option value="#GetStores.StoreID#">#GetStores.State# - #GetStores.StoreName#</option>
          </cfloop>
        </select></td>
    </tr>
  </table>
  <table  width=100% border="0" >
    <tr>
      <td align="center">
    <tr>
      <td>&nbsp;</td>
      <td align="center"><input id="btnPNLSum"  name="btnPNLSum" type="submit" value="P & L Summary"  class="buttonWidth1" ></td>
     <!---[    <cfif lngUserType LTE application.mgmtreportcutoff >   ]---->
        <td>&nbsp;</td>
        <td align="center"><input id="btnPNLSumAllStores"  name="btnPNLSumAllStores" type="submit" value="Franchise Fees"   class="buttonWidth1" ></td>
     <!---[    </cfif>   ]---->
      <td>&nbsp;</td>
      <td align="center"><input id="btnInventoryReport"  name="btnInventoryReport" type="submit" value="Inventory Variances"   class="buttonWidth1" ></td>
      
      <!--- KF Jan 04, add inventory movement report --->
      
      <td>&nbsp;</td>
      <td align="center"><input id="btnInventoryMovementReport"  name="btnInventoryMovementReport" type="submit" value="Inventory Movement"   class="buttonWidth1" ></td>
    </tr>
    <!--- end --->
    <tr>
      <td>&nbsp;</td>
      <td align="center"><input id="btnWastageSummary"  name="btnWastageSummary" type="submit" value="Wastage Summary"   class="buttonWidth1" ></td>
      <td>&nbsp;</td>
      <td align="center"><input id="btnTransferSummary" name="btnTransferSummary"  type="submit" value="Transfer Summary" class="buttonWidth1"  ></td>
      <td>&nbsp;</td>
      <td align="center"><input id="btnShowSalesAll" name="btnShowSalesAll"  type="submit" value="PLU Sales" class="buttonWidth1"  ></td>
      <td>&nbsp;</td>
      <td align="center"><input id="btnShowPLUSalesGP" name="btnShowPLUSalesGP"  type="submit" value="PLU Sales With GP" class="buttonWidth1"  ></td>
    </tr>
      <tr>
    
    <td>&nbsp;</td>
    <td align="center"><input id="btnShowSalesDept" name="btnShowSalesDept" type="submit"  value="PLU Sales (Dept)"  class="buttonWidth1" ></td>
    <td>&nbsp;</td>
    <td align="center"><input id="btnShowSalesDept" name="btnShowSalesGlobal" type="submit"  value="PLU Sales Global ( Store/Dept)"  class="buttonWidth1" ></td>
   <!---[    <cfif lngUserType LTE application.mgmtreportcutoff >   ]---->
      <td>&nbsp;</td>
      <td align="center"><input id="btnInvoiceSummary" name="btnInvoiceSummary" type="submit"  value= "Invoice Summary By Invoice"  class="buttonWidth1" ></td>
      <td>&nbsp;</td>
      <td align="center"><input id="btnSummaryDailyIncome" name="btnSummaryDailyIncome" type="submit"  value= "Summary Daily Income"  class="buttonWidth1" ></td>
        </tr>
      
      <tr>
        <td>&nbsp;</td>
        <td align="center"><input id="btnStockAdjustments" name="btnStockAdjustments" type="submit"  value= "Stock Adjustments Report"  class="buttonWidth1" ></td>
        <td>&nbsp;</td>
        <td align="center"><input id="btnplusalesrecipes" name="btnplusalesrecipes" type="submit"  value= "PLU Sales Recipes Only "  class="buttonWidth1" ></td>
        <td>&nbsp;</td>
        <td align="center"><input id="btnplusalesrecipes" name="btnSalesReport" type="submit"  value= "Sales Report"  class="buttonWidth1" ></td>
        <td>&nbsp;</td>
        <td align="center"><input id="btnplusalesrecipes" name="btnSalesReportPaymentTypes" type="submit"  value= "Sales Report (Payment Types)"  class="buttonWidth1" ></td>
      </tr>
      
      <!---[    <tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center"><input id="btnplusalesrecipes" name="btnSalesReportProductByStore" type="submit"  value= "Sales Report (Product/Store)"  class="buttonWidth1" ></td>
    </tr>   ]---->
   <!---[    </cfif>   ]---->
  </table>
</FORM>
</cfoutput>
</body>
</HTML>
