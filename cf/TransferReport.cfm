
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

<CFIF ParameterExists(URL.cmbDeptNo)>
	<cfset lngDeptNo = #URL.cmbDeptNo#>
<cfelse>
	<cfset lngDeptNo = #Form.cmbDeptNo#>
</cfif>

<cfset lngStoreID = #session.storeid#>

<cfset strPageTitle = "Transfer Report">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))) ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))  AND ((tblStockDept.DeptNo)= #lngDeptNo# ) ) ">
</cfif>
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

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
      <div align="right"><a href="TransferSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
  <tr> 
 	<td colspan="3"> 
      <div align="center"><h3><cfoutput>#strStoreName#</cfoutput></h3></div>
    </td>
  </tr>
</table>
<FORM action="TransferActionBL.cfm" method="post">
<table width="85%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="0">
        <cfoutput>
		
        <input type="hidden" name="StoreID" value="#lngStoreID#">
        <input type="hidden" name="employeeID" value="#session.employeeID#">
        <input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">
        <input type="hidden" name="NumDepartments" value="#GetDepartments.recordcount#">
		</cfoutput>
        <cfset lngGlobalDepartment = 0 >
		
  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngGlobalDepartment = lngGlobalDepartment + 1 >

    <cfset lngDeptNo = #GetDepartments.DeptNo# >
		<!--- get the lines --->
		<cfset strQuery = "SELECT qryStockValuationForStocktake.ID, qryStockValuationForStocktake.Freezer_QtyOnHand, qryStockValuationForStocktake.CoolRoom_QtyOnHand, qryStockValuationForStocktake.Display_QtyOnHand, qryStockValuationForStocktake.Variance, qryStockValuationForStocktake.PartNo, qryStockValuationForStocktake.Description, qryStockValuationForStocktake.QtyOnHand, qryStockValuationForStocktake.SupplyUnit, qryStockValuationForStocktake.LastCost, qryStockValuationForStocktake.ValueExTax, qryStockValuationForStocktake.StoreID, qryStockValuationForStocktake.DeptNo, qryStockValuationForStocktake.FCD_Qty, ">
		<cfset strQuery = strQuery & "qryStockValuationForStocktake.Wastage, qryStockValuationForStocktake.TeansferQty, qryStockValuationForStocktake.TransferToPlu ">
		<cfset strQuery = strQuery & "FROM qryStockValuationForStocktake ">
<!--- 		<cfset strQuery = strQuery & "WHERE (((qryStockValuationForStocktake.StoreID)=#lngStoreID#) AND ((qryStockValuationForStocktake.DeptNo)=#lngDeptNo#)) ">
 --->
 		<cfset strQuery = strQuery & "WHERE (((qryStockValuationForStocktake.StoreID)=#lngStoreID#) AND ((qryStockValuationForStocktake.DeptNo)=#lngDeptNo#) ">
		<cfset strQuery = strQuery & "AND ((qryStockValuationForStocktake.TeansferQty) > 0)) ">
		<cfset strQuery = strQuery & "ORDER BY qryStockValuationForStocktake.Description">
		
		<!--- <cfoutput><br>#strQuery#</cfoutput> --->
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetDepartments" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<cfif #GetRecord.recordcount# GT 0>
	   <cfoutput>
          <tr> 
            <td colspan="6"><h3>#GetDepartments.Dept#</h3></td>
          </tr>
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="right"><h4>Unit</h4></div></td>
<!---             <td><div align="right"><h4>On Hand</h4></div></td>
 --->
            <td><div align="right"><h4>Transfer Qty</h4></div></td>
            <td><div align="right"><h4>To Plu</h4></div></td>
          </tr>

		</cfoutput>

        <cfoutput>
        <input type="hidden" name="Dept_#lngGlobalDepartment#_TotalLines" value="#GetRecord.recordcount#">
		</cfoutput>
  		<cfset lngGlobalRecordNumber = 0>
  		<cfoutput query = "GetRecord">
           <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
          <tr> 
            <td>
				<h4>#GetRecord.PartNo#&nbsp;</h4>
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_txtID#lngGlobalRecordNumber#" value="#GetRecord.ID#">
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_PartNo#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
			</td>
            <td><h4>#GetRecord.Description#&nbsp;</h4></td>
            <td><div align="right"><h4>#GetRecord.SupplyUnit#&nbsp;</h4></div></td>
<!---             <td><div align="right"><h4>#numberformat(GetRecord.QtyOnHand,"_____.00")#&nbsp;</h4></div></td>			
 --->			<td>
				<div align="right">#NumberFormat(GetRecord.TeansferQty,"_____.00")#&nbsp;</div></font>
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_required" value="Please type Transfer qty on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_float" value="Please type Transfer qty on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
		        <cfif #GetRecord.QtyOnHand# GT -0.0001>
					<input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_range" value="MIN=-0.001 MAX=#GetRecord.QtyOnHand#">
				<cfelse>
					<input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_range" value="MIN=-0.001 MAX=10000">
				</cfif>
			</td>
			<td>
				<div align="right">#GetRecord.TransferToPlu#</div></font>
			</td>
          </tr>
	  </cfoutput>
		</cfif>
  </CFLOOP>

        </table>
      </div>
    </td>
  </tr>
</table>
  <p>&nbsp;</p>
</form>
</body>
</HTML>

