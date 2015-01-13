
<cfsetting enablecfoutputonly="Yes">

<!--- - wb 03/11/2003 - Set page title - --->
<cfset strPageTitle = "Packing Summary Report">

<!--- - wb 20/11/2003 - Setup display date - --->
<cfset local.displayDate=createDate(mid(form.date,5,4),mid(form.date,3,2),left(form.date,2))>

 <!--- - wb 05/11/2003 - Get the invoice details - --->
<CFQUERY name="qGetStores" dataSource="#Applic_dataSource#"  USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >  
 SELECT  distinct i.StoreId, 
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
<CFQUERY name="qGetInvoiceDetails" dataSource="#Applic_dataSource#"  USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >  
SELECT q.PartNo, q.DeptNo, q.Dept, q.Label,q.Description, q.SupplyUnit, q.QtyOrdered, s.StoreName, q.TypeID
FROM qryPurchaseOrder q, tblStores s
WHERE q.OrderDate = '#form.date#' AND q.TypeID=#prodType# AND q.StoreId = s.StoreId AND q.QtyOrdered <> 0
ORDER BY q.DeptNo, q.Label

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
			<cfset tmp=ArrayAppend(local.arInvoiceDetails[local.counter],qGetInvoiceDetails.Label)>
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
 
<head>
	<title><cfoutput>#strPageTitle#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
</head>
<body>
<img src="../images/s.gif" width="1" height="30" alt="Spacer" border="0" /><br />
<cfif qGetInvoiceDetails.recordCount GT 0>
	<!--- - wb 02/11/2003 - Display report - --->
	<table border="0" cellpadding="0" cellspacing="0" width="900">
	<tr>
			
			<td class="heading" align="center"><cfoutput>#strPageTitle# for <u>#dateFormat(local.displayDate,"dddd, dd mmmm yyyy")#</u></cfoutput> 
			<br>
			<span class="normal_body_th">
			<cfoutput>
				Printed #timeFormat(now(),"HH:mm")# #dateFormat(now(),"dddd, dd mmmm yyyy")#
			</cfoutput> 
			</span>
			</td>
			<td align="left">
				<a href="PackingSummaryReportSelect.cfm">back</a>
			</td>
		</tr>
		</table>
	
	<table border="1" cellpadding="0" cellspacing="0" width="900" >
		
		<tr valign="top">
			<!--- <td>
				<img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" />
			</td> --->
			<td class="normal_body_th_small" width="100"><b>Description</b></td>
			<td align="right" class="normal_body_th_small" width="50">Total</td>
			<cfset local.counter=0>
			<cfloop list="#local.lsStoreNames#" index="j">
				<cfset local.counter=local.counter+1>
			<td align="right" class="normal_body_th_small" width="40">
			<cfoutput>
				<b>#left(replace(replace(j,"SCS@","","ALL"),"SCS ","","ALL"),3)#</b>
			</cfoutput>
			</td>
				<cfif local.counter EQ 23>
		</tr>
				<tr valign="top">
					<!--- <td>
						<img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" />
					</td> --->
					<td class="normal_body_th_small" width="100">&nbsp;</td>
					<td class="normal_body_th_small" width="40">&nbsp;</td>
				<cfset local.counter=0>
			</cfif>	
		</cfloop>
		 <cfif local.counter NEQ 0>
			<cfloop from="#local.counter#" to="4" index="i">
				<td class="normal_body_th_small" width="50">&nbsp;</td>
			</cfloop>
		</tr>
		</cfif> 
		<cfset local.invoiceDeltailsLength=arrayLen(local.arInvoiceDetails)>	
		<cfset local.dept="">
		<cfloop from="1" to="#local.invoiceDeltailsLength#" index="i">
		
		<tr valign="top">
			<!--- <td>
				<img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" />
			</td> --->
			<td class="normal_body_th_small">
				<cfoutput>#local.arInvoiceDetails[i][1]#</cfoutput>
			</td>
		 	<td align="right" class="normal_body_th_small">
				<cfoutput>#numberFormat(local.arInvoiceDetails[i][4])#</cfoutput>
			</td> 
			<cfset local.counter=0>
			<cfset local.listCounter=0>
			<cfloop list="#local.arInvoiceDetails[i][5]#" index="j">
			<cfset local.counter=local.counter+1>
			<cfset local.listCounter=local.listCounter+1>
 			<td align="right" class="normal_body_th_small"><cfif listGetAt(local.arInvoiceDetails[i][5],local.listCounter,",") EQ 0>-<cfelse>
		<cfoutput>#numberFormat(listGetAt(local.arInvoiceDetails[i][5],local.listCounter,","))#					</cfoutput></cfif>
		</td> 
			<cfif local.counter EQ 23>
		</tr>
		<tr valign="top">
			<!--- <td>
				<img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" />
			</td> --->
			<td class="normal_body_th_small">&nbsp;</td>
			<td class="normal_body_th_small">&nbsp;</td>
			<cfset local.counter=0>
		</cfif>	
	</cfloop>
	<cfif local.counter NEQ 0>
	<cfloop from="#local.listCounter#" to="15" index="i">
		<td class="normal_body_th_small">&nbsp;</td>
	</cfloop>
	</tr>
	</cfif>
	</cfloop>
	</table>
<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<!--- <tr><td colspan="3"><img src="../images/s.gif" width="1" height="10" alt="Spacer" border="0" /></td> </tr> --->
		<tr valign="top">
			
			<td>
				<span class="error">Sorry, No invoices found for <cfoutput>#dateFormat(local.displayDate,"dddd, dd, mmmm yyyy")#</cfoutput></span>
			</td>
			<td >
				<a href="PackingSummaryReportSelect.cfm">back</a>&nbsp;
			</td>
		</tr>
	</table>
</cfif>
</body>
</html>
