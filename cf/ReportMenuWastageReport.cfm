

	<cfset lngDeptNo = 0 >
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>

	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	

	<!--- Get the store name --->
	<cfset strQuery = "SELECT * from tblStores" >
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & " where StoreID IN(#lngStoreID#)">
	</cfif>
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
	
<!--- <cfset strPageTitle = "#GetStoreDetail.StoreName# Wastage Report"> --->
<cfset strPageTitle = "Wastage Report"> 
<cfset strStoreName = "#GetStoreDetail.StoreName#">

<!--- <!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#"> --->

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

<CFQUERY name="GetDepartments" datasource="#application.dsn#" > <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
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
  <tr valign="center"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a>
	</td>

 <td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
		
       		
	  
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
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
  <!--- <tr> 
 	<td colspan="3"> 
      <div align="center"><h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</CFOUTPUT></h1></div>
    </td>
  </tr> --->
  
</table>
<cfset dblTotalValue = 0>
<FORM action="WastageActionBL.cfm" method="post">
<table width="65%" border="0" align="center">
  <tr valign="center">
    <td align="center">
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
		<cfset strQuery = "SELECT tblStockMaster.Description, tblStockMaster.PartNo, tblStockMaster.SupplyUnit, SUM(tblWastageLog.Wastage) AS TotalWastage, SUM(tblWastageLog.Wastage * tblWastageLog.Wholesale) AS TotalValue ">
		<cfset strQuery = strQuery & "FROM tblStockDept INNER JOIN tblStockGroup ON tblStockDept.DeptNo = tblStockGroup.DeptNo INNER JOIN ">
		<cfset strQuery = strQuery & "tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo INNER JOIN tblWastageLog ON tblStockMaster.PartNo = tblWastageLog.PartNo ">
		<cfset strQuery = strQuery & "WHERE (tblStockDept.DeptNo = #lngDeptNo# )">
		<CFIF lngStoreID is not "all">
		<cfset strQuery = strQuery & "AND (tblWastageLog.StoreID IN(#lngStoreID# ))">
		</CFIF> 
		 <cfset strQuery = strQuery & "AND ({ fn YEAR(tblWastageLog.DateEntered) } * 10000 + { fn MONTH(tblWastageLog.DateEntered) } * 100 + day(tblWastageLog.DateEntered) BETWEEN #lngFD# AND #lngTD# ) ">
		<cfset strQuery = strQuery & "GROUP BY tblStockMaster.Description, tblStockMaster.PartNo, tblStockMaster.SupplyUnit ">
		<cfset strQuery = strQuery & "Order by tblStockMaster.Description ">
			
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
        <cfoutput>
		</cfoutput>
  <cfset lngGlobalRecordNumber = 0>
<cfif #GetRecord.recordcount# GT 0>
	   <cfoutput>
          <tr > 
            <td colspan="5"><h3>#GetDepartments.Dept#</h3></td>
          </tr>
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="center"><h4>Unit</h4></td>
             <td><div align="right"><h4>Wastage</h4></div></td>
             <td><div align="right"><h4>Value</h4></div></td>			 
          </tr>

		</cfoutput>


  <cfoutput query = "GetRecord">
           <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
		   <cfset dblTotalValue = dblTotalValue + #GetRecord.TotalValue# >
          <tr> 
            <td>
				<h4>#GetRecord.PartNo#&nbsp;</h4>
			</td>
            <td><h4>#GetRecord.Description#&nbsp;</h4></td>
            <td><div align="center"><h4>#GetRecord.SupplyUnit#&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>#NumberFormat(GetRecord.TotalWastage,"_______.000")#&nbsp;</h4></div></font>
			</td>
			<td>
				<div align="right"><h4>#NumberFormat(GetRecord.TotalValue,"_______.00")#&nbsp;</h4></div></font>
			</td>
          </tr>
  </cfoutput>
</cfif>
  </CFLOOP>
          <tr> 
            <td colspan="4"><h3>Total</h3></td>		  
			<td>
				<cfoutput><div align="right"><h4>#NumberFormat(dblTotalValue,"_______.00")#&nbsp;</h4></div></font></cfoutput>
			</td>
          </tr>

        </table>
      </div>
    </td>
  </tr>
</table>
  <p>&nbsp;</p>
</form>
</body>
</HTML>

