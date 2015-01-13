
<cfparam name="form.type" default="0">
<cfparam name="txtOrderDate" default="">
<cfparam name="txtStoreID" default="">  


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- <cfif isDefined("form.frozen")>
	<cfset form.type = 1>
<cfelse>
	<cfset form.type = 0>
</cfif> --->
<!--- Get the date --->
<cfset strDate = #FORM.txtOrderDate#>
<cfset lngStoreID = #FORM.txtStoreID#>
<cfif len(#strDate#) EQ 7>
	<cfset strDate = "0" & "#strDate#" >
</cfif>

<!---  Get the store Name --->
<cfset strQuery = "SELECT StoreID, StoreName, * from tblStores where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStoreName"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = '#GetStoreName.StoreName#'>

<html>
<head>
	<title><cfoutput>#strStoreName#</cfoutput> Packing Report</title>
</head>
<body>

<!--- 
<cfset strDate = "06122002">
<cfset lngStoreID = 2>
 --->
<cfif isDefined("form.submitted")>
	<CFQUERY name="CheckHeader"      datasource="#application.dsn#" >
		UPDATE 	tblOrderHeader
		SET 	isPrinted = 1
		WHERE 	(((tblOrderHeader.StoreID)=#lngStoreID#) 
		AND 	((tblOrderHeader.OrderDate)='#strDate#'))
		AND		tblOrderHeader.typeID = 1
	</CFQUERY>
	<!--- <CFQUERY name="GetOrder"      datasource="#application.dsn#" >
		SELECT	OrderDetID
		FROM 	tblOrderDetail
		WHERE 	(((tblOrderDetail.OrderID)=#lngStoreID#) 
		AND 	((tblOrderDetail.OrderDate)='#strDate#'))
		AND		tblOrderDetail.typeID = 1
		AND		tblOrderDetail.Status = 'Packed'
	</CFQUERY>
	<cfset orderID = GetOrder.OrderDetID> --->
	<CFQUERY name="CheckHeader"      datasource="#application.dsn#" >
		UPDATE 	tblOrderDetail
		SET 	isPrinted = 1
		WHERE 	(((tblOrderDetail.OrderID)=#lngStoreID#) 
		AND 	((tblOrderDetail.OrderDate)='#strDate#'))
		AND		tblOrderDetail.typeID = 1
	</CFQUERY>
</cfif>
<CFSET strFormattedDate = ''>
<CF_FormatDateString Value="#strDate#">

<!--- Get the comments --->
<!--- Get the comments --->
<CFQUERY name="CheckHeader"      datasource="#application.dsn#" >  
	SELECT 	tblOrderHeader.OrderID, tblOrderHeader.StoreID, tblOrderHeader.OrderDate, tblOrderHeader.DateModified, tblOrderHeader.Comments 
	FROM 	tblOrderHeader 
	WHERE 	(((tblOrderHeader.StoreID)=#lngStoreID#) AND ((tblOrderHeader.OrderDate)='#strDate#'))
	<cfif form.type EQ 1>
			AND	tblOrderHeader.typeID = 1
	<cfelse>
			AND	tblOrderHeader.typeID <> 1
	</cfif>
</CFQUERY>
<cfset strMemo = #URLDecode(CheckHeader.Comments)#>


<cfoutput>
<form name="packingReport" id="packingReport" action="PackingListReport.cfm" method="post"> 
	<table width="750" border="0">
		<cfif session.usertype EQ 1 OR session.usertype EQ 2 OR session.usertype EQ 3 OR session.usertype EQ 4  OR session.usertype EQ  5>
			<tr>
				<td colspan="3">
					<input type="submit" name="print" value="Print" onclick="window.print();">
				</td>
			</tr>
		</cfif>
		<tr>
			<td width = "150"><div align="left">Date: #strFormattedDate#<br/>  </div></td>
			<td width = "450"><div align="center"><b><font size="4"  face="Tahoma">#strStoreName#</font></b></div></td>
			<td width = "150"><div align="right"><a href="PackingReportRequest.cfm">back</a></div></td>
		</tr>
		<cfif Len(CheckHeader.DateModified)>
		<tr>
			<td colspan="3">Date Modified: #DateFormat(CheckHeader.DateModified, "dd/mm/yyyy")# #TimeFormat(CheckHeader.DateModified)#</td>
		</tr>
		</cfif>
	</table>
	<input type="hidden" name="submitted" id="submitted" value="1">
	<input type="hidden" name="type" id="type" value="#type#">
	
	<input type="hidden" name="txtOrderDate" id="txtOrderDate" value="#txtOrderDate#">
	<input type="hidden" name="txtStoreID" id="txtStoreID" value="#txtStoreID#">
 </form>  
<br><font size="3" color="990000"><b>Comments: #strMemo#</b></font>
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
<cfif form.type EQ 1>
	<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID = 1 "> <!--- typeID = 1 is for frozen foods ---> 
<cfelse>
	<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID <> 1 "><!--- typeID <> 1 is for non-frozen foods ---> 
</cfif>
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING (((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#')) ">
<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.DeptNo">
<CFQUERY name="GetDepartments" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<CFQUERY name="qGetBoxes" datasource="#application.dsn#" > 
	SELECT 	* 
	FROM 	tblStockMaster 
	WHERE	tblStockMaster.GroupNo = 68
	AND 	tblStockMaster.MaxRetail >=0
</CFQUERY>
<table width="650" border="0">
<CFLOOP QUERY="GetDepartments"> 
	<cfset lngDeptNo = #GetDepartments.DeptNo# >
	<!--- Now define the query for the lines --->
	<cfset strQuery = "SELECT qryPurchaseOrder.DeptNo, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate, qryPurchaseOrder.Description, * ">
	<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
	<cfset strQuery = strQuery & "WHERE (((qryPurchaseOrder.DeptNo)=#lngDeptNo#) AND ((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#') AND (qryPurchaseOrder.QtyOrdered > 0.00001) ) ">
	<cfif form.type EQ 1>
		<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID = 1 "> <!--- typeID = 1 is for frozen foods ---> 
	<cfelse>
		<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID <> 1 "><!--- typeID <> 1 is for non-frozen foods ---> 
	</cfif>
	<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.Description">
	<CFQUERY name="GetRecords" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	

  <tr> 
    <td colspan="6"> 
      <cfoutput><div align="center"><font size="4"  face="Tahoma">#GetDepartments.Dept#</font></div></cfoutput>
    </td>
  </tr>
  <tr> 
    <td width="75"> 
      <div align="left"><font size="4"  face="Tahoma">PLU</font></div>
    </td>
    <td width="100"> 
      <div align="left"><font size="4"  face="Tahoma">Prep Code</font></div>
    </td>
    <td width="250"> 
      <div align="left"><font size="4"  face="Tahoma">Description</font></div>
    </td>
    <td width="125" colspan="2"> 
      <div align="center"><font size="4"  face="Tahoma">Ordered</font></div>
    </td>
    <td width="100"> 
      <div align="left"><font size="4"  face="Tahoma">Packed</font></div>
    </td>
  </tr> 
	<cfoutput Query ="GetRecords">
  <tr> 
    <td width="75"> 
      <div align="left"><font size="4"  face="Tahoma">#GetRecords.PartNo#</font></div>
    </td>
    <td width="100"> 
	  <cfif #GetRecords.DeptNo# EQ 3>
        <table width="75"  border="1" bordercolor="CCCCCC" cellspacing="0" cellspacing="0" height="8">
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
	  <cfelse>
	  	&nbsp;
	  </cfif>
    </td>
    <td width="250"> 
      <div align="left"><font size="4"  face="Tahoma">#GetRecords.Description#</font></div>
    </td>
    <td width="75"> 
	  <cfif #GetRecords.QtyOrdered# GT 0.00001>	
	      	<div align="right"><font size="4"  face="Tahoma">#GetRecords.QtyOrdered#</font></div>
	  <cfelse>
			&nbsp;
	  </cfif>
    </td>
    <td width="50"> 
      <div align="left"><font size="4"  face="Tahoma">#GetRecords.OrderingUnit#</font></div>
    </td>
    <td width="100"> 
        <table width="75"  border="1" bordercolor="CCCCCC" cellspacing="0"cellspacing="0" height="8">
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
    </td>
  </tr> 
	</cfoutput>

</CFLOOP>
<tr> 
    <td colspan="6"> 
      <cfoutput><div align="center"><font size="4"  face="Tahoma">Boxes</font></div></cfoutput>
    </td>
  </tr>
 <tr> 
    <td width="75"> 
      <div align="left"><font size="4"  face="Tahoma">PLU</font></div>
    </td>
    <td width="100"> 
      <div align="left"><font size="4"  face="Tahoma">Prep Code</font></div>
    </td>
    <td width="250"> 
      <div align="left"><font size="4"  face="Tahoma">Description</font></div>
    </td>
    <td width="125" colspan="2"> 
      <div align="center"><font size="4"  face="Tahoma">Ordered</font></div>
    </td>
    <td width="100"> 
      <div align="left"><font size="4"  face="Tahoma">Packed</font></div>
    </td>
  </tr> 
<cfoutput Query ="qGetBoxes">
  <tr> 
    <td width="75"> 
      <div align="left"><font size="4"  face="Tahoma">#qGetBoxes.PartNo#</font></div>
    </td>
    <td width="100"> 
    </td>
    <td width="250"> 
      <div align="left"><font size="4"  face="Tahoma">#qGetBoxes.Description#</font></div>
    </td>
    <td width="75"> 
	  &nbsp;
    </td>
    <td width="50"> 
      <div align="left"><font size="4"  face="Tahoma">&nbsp;</font></div>
    </td>
    <td width="100"> 
        <table width="75"  border="1" bordercolor="CCCCCC" cellspacing="0"cellspacing="0" height="8">
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
    </td>
  </tr> 
</cfoutput>
	<tr><td colspan="6"><br /><br /></td></tr>
	 <tr>
	 	<td colspan="5"><font size="4" face="Tahoma">Delivery Charge</font></td>
	<td>
	  <table width="75"  border="1" bordercolor="CCCCCC" cellspacing="0" cellspacing="0" height="8">
	    <tr><td>&nbsp;</td></tr>
	     </table>
	   </td>
	 </tr>	
</table>


</body>
</html>
