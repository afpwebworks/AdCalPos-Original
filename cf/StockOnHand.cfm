
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

<cfset lngSelectedDeptNo = #Form.cmbDeptNo#>
<cfset lngDeptNo = #Form.cmbDeptNo#>
<cfset lngStoreID = #session.storeid#>

<cfset strPageTitle = "Stock on Hand">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">

<!--- get the Departments --->

<!--- 
<cfset strQuery = "SELECT qryStockValuationTotal.DeptNo, qryStockValuationTotal.Dept, qryStockValuationTotal.TotalValue, qryStockValuationTotal.StoreID, qryStockValuationTotal.TotalQtyOnHand ">
<cfset strQuery = strQuery & "FROM qryStockValuationTotal ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (qryStockValuationTotal.StoreID = #lngStoreID#) and (qryStockValuationTotal.TotalValue <> 0)">
<cfelse>	
	<cfset strQuery = strQuery & "WHERE (qryStockValuationTotal.StoreID = #lngStoreID#) and (qryStockValuationTotal.DeptNo = #lngDeptNo#) and (qryStockValuationTotal.TotalValue <> 0)">
</cfif>
 --->

<cfset strQuery = "SELECT * from tblStockDept ">
<cfif lngDeptNo LT 1>
<cfelse>	
	<cfset strQuery = strQuery & "WHERE DeptNo = #lngDeptNo#">
</cfif>

<CFQUERY name="GetDepartments" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetDepartments" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset dblMyGrandTotalValue = 0>		

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
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="StockOnHandSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
  <tr> 
 	<td colspan="3"> 
      <div align="center"><h3><cfoutput>#strStoreName#</cfoutput></h3></div>
    </td>
  </tr>
</table>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="0">

  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
          <tr> 
            <td colspan="6"><h3>#GetDepartments.Dept#</h3></td>
          </tr>
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="right"><h4>On Hand</h4></div></td>
            <td><div align="right"><h4>Unit</h4></div></td>
            <td><div align="right"><h4>Last Paid</h4></div></td>
            <td><div align="right"><h4>Value</h4></div></td>
          </tr>

		</cfoutput>
		<!--- get the lines --->
		<!--- 
		<cfset strQuery = "SELECT qryStockValuation.PartNo, qryStockValuation.Description, qryStockValuation.QtyOnHand, qryStockValuation.SupplyUnit, qryStockValuation.Wholesale, qryStockValuation.ValueExTax, qryStockValuation.StoreID, qryStockValuation.DeptNo ">
		<cfset strQuery = strQuery & "FROM qryStockValuation ">
		<cfset strQuery = strQuery & "WHERE (((qryStockValuation.StoreID)=#lngStoreID#) AND ((qryStockValuation.DeptNo)=#lngDeptNo#) AND ((qryStockValuation.PCode)=0) AND (Abs([QtyOnHand])>0.0001)) ">
		<cfset strQuery = strQuery & "ORDER BY qryStockValuation.Description">
		 --->		
		<cfset strQuery = "SELECT qryStockValuationLastCost.PartNo, qryStockValuationLastCost.Description, qryStockValuationLastCost.QtyOnHand, qryStockValuationLastCost.SupplyUnit, qryStockValuationLastCost.Wholesale, qryStockValuationLastCost.ValueExTax, qryStockValuationLastCost.StoreID, qryStockValuationLastCost.DeptNo, qryStockValuationLastCost.LastCost ">
		<cfset strQuery = strQuery & "FROM qryStockValuationLastCost ">
		<cfset strQuery = strQuery & "WHERE (((qryStockValuationLastCost.StoreID)=#lngStoreID#) AND ((qryStockValuationLastCost.DeptNo)=#lngDeptNo#) AND ((qryStockValuationLastCost.PCode)=0) AND (Abs([QtyOnHand])>0.0001)) ">
		<cfset strQuery = strQuery & "ORDER BY qryStockValuationLastCost.Description">

		<!--- <cfoutput>strQuery: #strQuery#</cfoutput><cfabort> --->
		
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

  <cfset dblTotalValue = 0>
  <cfoutput query = "GetRecord">
		  <cfset dblTotalValue = #dblTotalValue# + #GetRecord.ValueExTax# >
		  <cfset dblMyGrandTotalValue = #dblMyGrandTotalValue# + #GetRecord.ValueExTax# >		  
          <tr> 
            <td><h4>#GetRecord.PartNo#&nbsp;</h4></td>
            <td><h4>#GetRecord.Description#&nbsp;</h4></td>
            <td><div align="right"><h4>#numberformat(GetRecord.QtyOnHand,"_________.000")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#GetRecord.SupplyUnit#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.LastCost,"$_________.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.ValueExTax,"$_________.00")#&nbsp;</h4></div></td>
          </tr>
	</cfoutput>
          <tr> 
			<cfoutput>
	            <td colspan="6"><div align="right"><h4>Total: #numberformat(dblTotalValue,"$_________.00")#&nbsp;</h4></div></td>
			</cfoutput>
          </tr>
  </CFLOOP>

<!---   define the total --->
		  <cfif #lngSelectedDeptNo# EQ 0>
          <tr> 
	            <cfoutput>
	            <td colspan="6"><div align="right"><h4>Grand Total: #numberformat(dblMyGrandTotalValue,"$_________.00")#&nbsp;</h4></div></td>
                </cfoutput>
          </tr>
		  </cfif>	
        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>

