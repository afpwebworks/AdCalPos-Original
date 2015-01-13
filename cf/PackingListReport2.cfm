
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<!--- Get the date --->
<cfset strDate = #FORM.txtOrderDate#>
<cfset lngStoreID = #FORM.txtStoreID#>
<cfif len(#strDate#) EQ 7>
	<cfset strDate = "0" & "#strDate#" >
</cfif>

<!--- 
<cfset strDate = "06122002">
<cfset lngStoreID = 2>
 --->
 
<!---  Get the store Name --->
<cfset strQuery = "SELECT StoreID, StoreName, * from tblStores where StoreID = #lngStoreID#">
<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStoreName">
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = '#GetStoreName.StoreName#'>

<CFSET strFormattedDate = ''>
<CF_FormatDateString Value="#strDate#">


<cfoutput>
<table width="700" border="0">
	<td width = "150"><div align="left">Date: #strFormattedDate#</div></td>
	<td width = "450"><div align="center"><b><font size="4">#strStoreName#</font></b></div></td>
	<td width = "100"><div align="right"><a href="PackingReportRequest.cfm">back</a></div></td>
</table> 
</cfoutput> 

<!--- validate the date --->

<CFSET strValidDate = ''>
<CF_ValidateThisDate strDateValue= "#strDate#">

<cfif strValidDate EQ "N">
<!--- 	Invalid Date --->
	<cflocation URL = "ValidDateMessage.cfm"> 
</cfif>

<!--- get the Departments --->
<cfset strQuery = "SELECT qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
<cfset strQuery = strQuery & "WHERE (((qryPurchaseOrder.QtyOrdered)>0.0001)) ">
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING (((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#')) ">
<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.Dept">
<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments">
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<html>
<head>
	<title>Packing Report</title>
</head>
<body>
<table width="700" border="0">
<CFLOOP QUERY="GetDepartments"> 
	<cfset lngDeptNo = #GetDepartments.DeptNo# >
	<!--- Now define the query for the lines --->
	<cfset strQuery = "SELECT qryPurchaseOrder.DeptNo, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate, qryPurchaseOrder.Description, * ">
	<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
	<cfset strQuery = strQuery & "WHERE (((qryPurchaseOrder.DeptNo)=#lngDeptNo#) AND ((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#') AND (qryPurchaseOrder.QtyOrdered > 0.00001) ) ">
	<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.Description">
	<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecords">
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	

  <tr> 
    <td colspan="20"> 
      <cfoutput><div align="center"><font size="4">#GetDepartments.Dept#</font></div></cfoutput>
    </td>
  </tr>
	<cfoutput Query ="GetRecords">

<cfif (#GetRecords.CurrentRow# mod 2) EQ 1>
  <tr> 
</cfif> 
    <td width="35"> 
      <div align="left"><font size="3">#GetRecords.PartNo#</font></div>
    </td>
    <td width="25"> 
	  <cfif #GetRecords.DeptNo# EQ 3>
        <table width="25"  border="1" bordercolor="CCCCCC" cellspacing="0" cellspacing="0" height="8">
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
	  <cfelse>
	  	&nbsp;
	  </cfif>
    </td>
    <td width="91"> 
      <div align="left"><font size="3">#GetRecords.Description#</font></div>
    </td>
    <td width="30"> 
	  <cfif #GetRecords.QtyOrdered# GT 0.00001>	
	      	<div align="right"><font size="3">#GetRecords.QtyOrdered#</font></div>
	  <cfelse>
			&nbsp;
	  </cfif>
    </td>
    <td width="15"> 
      <div align="center"><font size="3">#GetRecords.OrderingUnit#</font></div>
    </td>
    <td width="32"> 
        <table width="32"  border="1" bordercolor="CCCCCC" cellspacing="0"cellspacing="0" height="8">
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
    </td>
<cfif ((#GetRecords.CurrentRow# mod 2) EQ 1) >
    <td width="10"><font size="1">&nbsp;</font></td>
</cfif> 

<cfif (#GetRecords.CurrentRow# mod 2) EQ 0>
  </tr> 
</cfif> 
	</cfoutput>

</CFLOOP>
</table>


</body>
</html>
