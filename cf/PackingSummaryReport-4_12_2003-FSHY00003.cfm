
<cfsetting enablecfoutputonly="Yes">

<!--- - wb 03/11/2003 - Set page title - --->
<cfset strPageTitle = "Packing Summary Report">

<!--- - wb 20/11/2003 - Setup display date - --->
<cfset local.displayDate=createDate(mid(url.date,5,4),mid(url.date,3,2),left(url.date,2))>

<!--- - wb 05/11/2003 - Get the invoice details - --->
<CFQUERY name="qGetStores" datasource="#application.dsn#" >
SELECT DISTINCT i.StoreId, 
		s.StoreId, s.StoreName
FROM tblOrderDetail i, tblStores s
WHERE i.StoreId = s.StoreId
ORDER BY s.StoreName
</CFQUERY>

<!--- - wb 05/11/2003 - Setup store names and store totals lists - --->
<cfset local.lsStoreNames="">
<cfset local.lsStoreTotalsHolder="">
<cfloop query="qGetStores">
	<cfset local.lsStoreNames=listAppend(local.lsStoreNames,qGetStores.StoreName,",")>
	<cfset local.lsStoreTotalsHolder=listAppend(local.lsStoreTotalsHolder,0,",")>
</cfloop>
<cfset local.lsStoreTotals=local.lsStoreTotalsHolder>

<!--- - wb 02/11/2003 - Get the order details - --->
<CFQUERY name="qGetInvoiceDetails" datasource="#application.dsn#" >
SELECT q.PartNo, q.DeptNo, q.Dept, q.Description, q.SupplyUnit, q.QtyOrdered, s.StoreName
FROM qryPurchaseOrder q, tblStores s
WHERE q.OrderDate = '#url.date#' AND q.StoreId = s.StoreId AND q.QtyOrdered <> 0
ORDER BY q.DeptNo, q.description

<!--- SELECT h.OrderId, h.StoreId,
		d.OrderId, d.PartNo, d.Description, d.QtySupplied, d.SupplyUnit,
		s.StoreId, s.StoreName
FROM tblOrderHeader h, tblOrderDetail d, tblStores s
WHERE h.StoreId = s.StoreId AND h.OrderId = d.OrderId AND h.OrderDate = '#url.date#' 
ORDER BY d.PartNo --->
</CFQUERY>
<cfif qGetInvoiceDetails.recordCount GT 0>
	<!--- - wb 02/11/2003 - Setup invoice variables - --->
	<cfset local.arInvoiceDetails=arrayNew(2)>
	<cfset local.plu="">
	<cfset local.lsStoreQuantity="">
	<cfset local.lsDept="">
	<cfset local.counter=0>
	
	<!--- - wb 02/11/2003 - Setup page content - --->
	<cfloop query="qGetInvoiceDetails">
		<cfif local.plu NEQ qGetInvoiceDetails.PartNo>
			<cfset local.plu=qGetInvoiceDetails.PartNo>
			<cfif isDefined("local.totalQuantity")>
				<!--- - wb 03/11/2003 - Add the part's total quantity - --->
				<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],local.totalQuantity)>
				<!--- - wb 03/11/2003 - Add store name and store quantity lists - --->
				<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],local.lsStoreTotals)>
				<!--- - wb 27/11/2003 - Add the department number - --->
				<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.Dept)>
				<!--- - wb 03/11/2003 - Reset store totals to 0 - --->
				<cfset local.lsStoreTotals=local.lsStoreTotalsHolder>
			</cfif>
			<cfset local.totalQuantity=0>
			<cfset local.counter=local.counter+1>
			<!--- - wb 03/11/2003 - Set part details - --->
			<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.Description)>
			<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.PartNo)>
			<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.SupplyUnit)>
		</cfif>
		<cfif listFindNoCase(local.lsStoreNames,qGetInvoiceDetails.StoreName,",")>
			<!--- - wb 03/11/2003 - Set store quantity - --->
			<cfset local.listPosition=listFindNoCase(local.lsStoreNames,qGetInvoiceDetails.StoreName,",")>
			<cfset local.storeQuantity=listGetAt(local.lsStoreTotals,local.listPosition,",")>
			<cfset local.storeQuantity=local.storeQuantity+qGetInvoiceDetails.QtyOrdered>
			<cfset local.lsStoreTotals=listSetAt(local.lsStoreTotals,local.listPosition,local.storeQuantity,",")>
		</cfif>
		<!--- - wb 03/11/2003 - Add to total quantity for the part - --->
		<cfset local.totalQuantity=local.totalQuantity+qGetInvoiceDetails.QtyOrdered>
	</cfloop>
	<!--- - wb 03/11/2003 - Add the part's total quantity - --->
	<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],local.totalQuantity)>
	<!--- - wb 03/11/2003 - Add store name and store quantity lists - --->
	<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],local.lsStoreTotals)>
	<!--- - wb 27/11/2003 - Add the department number - --->
				<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.Dept)>
	<!--- - wb 03/11/2003 - Reset store totals to 0 - --->
	<cfset local.lsStoreTotals=local.lsStoreTotalsHolder>
</cfif>

<cfsetting enablecfoutputonly="No">
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title><cfoutput>#strPageTitle#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
</head>
<body>
<img src="../images/s.gif" width="1" height="30" alt="Spacer" border="0" /><br />
<cfif qGetInvoiceDetails.recordCount GT 0>
	<!--- - wb 02/11/2003 - Display report - --->
	<table border="0" cellpadding="0" cellspacing="0" width="900">
		<tr valign="top">
			<td width="15"><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td class="heading" colspan="7" width="785"><cfoutput>#strPageTitle#</cfoutput> for <cfoutput>#dateFormat(local.displayDate,"dddd, dd mmmm yyyy")#</cfoutput><br />
			<span class="normal_body_th">Printed <cfoutput>#timeFormat(now(),"HH:mm")#</cfoutput> <cfoutput>#dateFormat(now(),"dddd, dd mmmm yyyy")#</cfoutput></span></td>
			<td width="100"><a href="PackingSummaryReportSelect.cfm">back</a><br />
			<img src="../images/s.gif" width="1" height="50" alt="Spacer" border="0" /><br /></td>
		</tr>
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td class="normal_body_th" width="50">PLU</td>
			<td class="normal_body_th" width="200">Description</td>
			<td align="right" class="normal_body_th" width="75">Total</td>
		<cfset local.counter=0>
		<cfloop list="#local.lsStoreNames#" index="j">
			<cfset local.counter=local.counter+1>
					<td align="right" class="normal_body_th" width="110"><cfoutput>#left(replace(replace(j,"SCS@","","ALL"),"SCS ","","ALL"),3)#</cfoutput></td>
			<cfif local.counter EQ 5>
				</tr>
				<tr>
					<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
					<td class="kl_grey" colspan="8"><img src="../images/s.gif" width="1" height="1" alt="Spacer" border="0" /></td>
				</tr>
				<tr valign="top">
					<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
					<td class="normal_body_th" width="50">&nbsp;</td>
					<td class="normal_body_th" width="200">&nbsp;</td>
					<td class="normal_body_th" width="75">&nbsp;</td>
				<cfset local.counter=0>
			</cfif>	
		</cfloop>
		<cfif local.counter NEQ 0>
			<cfloop from="#local.counter#" to="4" index="i">
				<td class="normal_body_th" width="110">&nbsp;</td>
			</cfloop>
			</tr>
		</cfif>
		<tr>
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td colspan="8"><img src="../images/s.gif" width="1" height="10" alt="Spacer" border="0" /></td>
		</tr>
		<tr>
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td class="kl_grey" colspan="8"><img src="../images/s.gif" width="1" height="1" alt="Spacer" border="0" /></td>
		</tr>
	<cfset local.invoiceDeltailsLength=arrayLen(local.arInvoiceDetails)>	
	<cfset local.dept="">
	<cfloop from="1" to="#local.invoiceDeltailsLength#" index="i">
		<!--- <cfif local.dept NEQ local.arInvoiceDetails[i][6]>
			<tr>
				<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
				<td colspan="8"><cfoutput>#local.arInvoiceDetails[i][6]#</cfoutput></td>
			</tr>
		</cfif> --->
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td class="normal_body_th"><cfoutput>#local.arInvoiceDetails[i][2]#</cfoutput></td>
			<td class="normal_body_th"><cfoutput>#local.arInvoiceDetails[i][1]#</cfoutput></td>
			<td align="right" class="normal_body_th"><cfoutput>#numberFormat(local.arInvoiceDetails[i][4],"__________.000")#</cfoutput><cfoutput>#local.arInvoiceDetails[i][3]#</cfoutput></td>
		<cfset local.counter=0>
		<cfset local.listCounter=0>
		<cfloop list="#local.arInvoiceDetails[i][5]#" index="j">
			<cfset local.counter=local.counter+1>
			<cfset local.listCounter=local.listCounter+1>
			<td align="right" class="normal_body"><cfif listGetAt(local.arInvoiceDetails[i][5],local.listCounter,",") EQ 0>-<cfelse><cfoutput>#numberFormat(listGetAt(local.arInvoiceDetails[i][5],local.listCounter,","),"__________.000")#</cfoutput></cfif></td>
			<cfif local.counter EQ 5>
				</tr>
				<tr valign="top">
					<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
					<td class="normal_body">&nbsp;</td>
					<td class="normal_body">&nbsp;</td>
					<td class="normal_body">&nbsp;</td>
				<cfset local.counter=0>
			</cfif>	
		</cfloop>
		<cfif local.counter NEQ 0>
			<cfloop from="#local.listCounter#" to="5" index="i">
				<td class="normal_body">&nbsp;</td>
			</cfloop>
			</tr>
		</cfif>
		<tr>
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td colspan="8"><img src="../images/s.gif" width="1" height="10" alt="Spacer" border="0" /></td>
		</tr>
		<tr>
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td class="kl_grey" colspan="8"><img src="../images/s.gif" width="1" height="1" alt="Spacer" border="0" /></td>
		</tr>
	</cfloop>
	</table>
<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td colspan="3"><img src="../images/s.gif" width="1" height="10" alt="Spacer" border="0" /></td></tr>
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td><span class="error">Sorry, No invoices found for <cfoutput>#dateFormat(local.displayDate,"dddd, dd, mmmm yyyy")#</cfoutput></span></td>
			<td align="right"><a href="PackingSummaryReportSelect.cfm">back</a>&nbsp;</td>
		</tr>
	</table>
</cfif>
</body>
</html>
