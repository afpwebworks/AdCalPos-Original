
<cfset local.pageTitle="Purchase History Report">
<cfsetting enablecfoutputonly="Yes">
<cfset lngStoreID = #form.r_storeId#>

<!--- - wb 06/11/2003 - setup page title - --->
<cfset local.pageTitle="Purchase History Report">
<!--- - wb 31/01/2004 - Setup display date - --->
<cfset local.displayDate=createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2))>
<!--- - wb 31/01/2004 - setup start date - --->
<cfset local.startDate=createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2))>
<cfset local.endDate=createDate(left(form.eDate,4),mid(form.eDate,5,2),mid(form.eDate,7,2))>
<cfinclude template="queries/qry_InvoiceDetail_StockMaster_StockGroup.cfm">	
<!--- - wb 02/01/2004 - get the header information - --->
<CFQUERY name="GetHeader" datasource="#application.dsn#"  maxrows="1"> 
SELECT * from qryInvoiceHeaders where 1=1
<CFIF lngStoreID is not "all">
			  and storeID in (#lngStoreID#) 
		</cfif>
</CFQUERY>
<!--- Get the store name --->
	<cfset strQuery = "SELECT * from tblStores" >
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & " where StoreID IN(#lngStoreID#)">
	</cfif>
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

<cfsetting enablecfoutputonly="No">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><cfoutput>#local.pageTitle#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
</head>

<body>
<!--- - wb 02/01/2004 - start main body content - --->
<cfif get_records.recordCount GT 0>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr valign="top">
			<td colspan="3" class="heading">&nbsp;<strong><cfoutput>#local.pageTitle#</cfoutput></strong></td>
			<td colspan="2" align="right"><a href="PurchaseHistoryReportSelect.cfm">back</a>&nbsp;</td>	
		</tr> 
		<tr><td colspan="5">&nbsp;<strong>Date From:</strong> <cfoutput>#dateFormat(local.startDate,"dddd, dd mmmm yyyy")#</cfoutput></td></tr>
		<tr><td colspan="5">&nbsp;<strong>Date To:</strong> <cfoutput>#dateFormat(createDate(left(form.eDate,4),mid(form.eDate,5,2),mid(form.eDate,7,2)),"dddd, dd mmmm yyyy")#</cfoutput></td></tr>
		<tr>
			<td colspan="5">&nbsp;<span class="normal_body_th"><strong>Printed:</strong> <cfoutput>#timeFormat(now(),"HH:mm")#</cfoutput> <cfoutput>#dateFormat(now(),"dddd, dd mmmm yyyy")#</cfoutput></span><br />
			<img src="../images/s.gif" width="1" height="25" alt="Spacer" border="0" /></td>
		</tr>
	<!--- - wb 21/11/2003 - Output header information - --->	
	
	<td align="center">
	<cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
		</td>
		
		</table>
	
	<!--- - wb 02/01/2004 - output page content - --->
	<table width="100%" border="0" cellspacing="0" bordercolor="000000">
		<tr> 
			<td bgcolor="99CCFF" width="5%"><b><font size="2">&nbsp;PLU</font></b></td>
			<td bgcolor="99CCFF" width="20%"><b><font size="2">Product</font></b></td>
			<td align="right" bgcolor="99CCFF" width="10%"><b><font size="2">Units</font></b></td>
			<td align="right" bgcolor="99CCFF" width="20%"><b><font size="2">Ave Price INC GST</font></b></td>
			<td align="right" bgcolor="99CCFF" width="20%"><b><font size="2">Ave GST per unit</font></b></td>
			<td align="right" bgcolor="99CCFF" width="10%"><b><font size="2">Total</font></b></td>
			<td align="right" bgcolor="99CCFF" width="15%"><b><font size="2">GST Total&nbsp;</font></b></td>
		</tr>
	<!--- - wb 02/01/2004 - setup sub total values - --->
	<cfset local.subTotalUnits=0>
	<cfset local.subTotalPrice=0>
	<cfset local.subTotalGst=0>
	<!--- - wb 02/01/2004 - setup total values - --->	
	<cfset local.totalPrice=0>
	<cfset local.totalGst=0>
	<!--- - wb 02/01/2004 - setup row counter - --->
	<cfset local.rCount=0>
	<cfloop query="get_records">
		<cfparam name="local.pCode" default="#get_records.PCode#">
		<!--- - wb 29/02/2004 - get PCode Descriptions - --->
		<CFQUERY name="qGetPCodeDescription" datasource="#application.dsn#"  maxrows="1">
			SELECT PCodeDescription
			FROM tblPCodes
			WHERE PCodeID=#local.pCode#	
			</CFQUERY>
		<cfif get_records.PCode NEQ local.pCode>
			
			<!--- - wb 02/01/2004 - output subtotal - --->
			<tr>

				<td colspan="2"><b><font size="2">Sub Total <cfoutput>#local.pCode#</cfoutput> <cfif qGetPCodeDescription.recordCount GT 0><cfoutput>#qGetPCodeDescription.PCodeDescription#</cfoutput></cfif></font></b></td>
				<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalUnits,"__________.000")#</cfoutput></font></b></td>
				<td colspan="2">&nbsp;</td>
				<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalPrice,"$__________.00")#</cfoutput></font></b></td>
				<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalGST,"$__________.00")#</cfoutput></font></b></td>
			</tr>
			<tr><td colspan="7">&nbsp;</td></tr>
			<!--- - wb 02/01/2004 - set PCode - --->
			<cfset local.pCode=get_records.PCode>
			<!--- - wb 02/01/2004 - calculate total - --->
			<cfset local.totalPrice=local.totalPrice+local.subTotalPrice>
			<cfset local.totalGst=local.totalGst+local.subTotalGst>
			<!--- - wb 02/01/2004 - reset sub total values - --->
			<cfset local.subTotalUnits=0>
			<cfset local.subTotalPrice=0>
			<cfset local.subTotalGst=0>
	</cfif>
		<cfif get_records.qty NEQ 0>
			<!--- - wb 02/01/2004 - calculate row values - --->
			<cfset local.price=numberFormat(get_records.ShopIncTax/get_records.qty,"__________.00")>
			<cfset local.gst=numberFormat(get_records.ShopTax/get_records.qty,"__________.00")>
		<cfelse>
			<cfset local.price=0>
			<cfset local.gst=0>
		</cfif>
		<!--- - wb 02/01/2004 - calculate sub total values - --->
		<cfset local.subTotalUnits=local.subTotalUnits+get_records.qty>
		<cfset local.subTotalPrice=numberFormat(local.subTotalPrice+get_records.ShopIncTax,"__________.00")>
		<cfset local.subTotalGst=numberFormat(local.subTotalGst+get_records.ShopTax,"__________.00")>
		<!--- - wb 02/01/2004 - output PLU rows - --->
		<tr>
			<td width="5%"><font size="2">&nbsp;<cfoutput>#get_records.partno#</cfoutput></font></td>
			<td width="20%"><font size="2"><cfoutput>#get_records.DESCRIPTION#</cfoutput></font></td>
			<td align="right" width="10%"><font size="2"><cfoutput>#numberFormat(get_records.qty,"__________.000")#</cfoutput></font></td>
			<td align="right" width="20%"><font size="2"><cfoutput>#numberFormat(local.price,"$__________.00")#</cfoutput></font></td>
			<td align="right" width="20%"><font size="2"><cfoutput>#numberFormat(local.gst,"$__________.00")#</cfoutput></font></td>
			<td align="right" width="10%"><font size="2"><cfoutput>#numberFormat(get_records.ShopIncTax,"$__________.00")#</cfoutput></font></td>
			<td align="right" width="15%"><font size="2"><cfoutput>#numberFormat(get_records.ShopTax,"$__________.00")#&nbsp;</cfoutput></font></td>
		</tr>
		<!--- - wb 02/01/2004 - increase row counter - --->
		
	</cfloop>
	<!--- - wb 02/01/2004 - calculate total - --->
	<cfset local.totalPrice=local.totalPrice+local.subTotalPrice>
	<cfset local.totalGst=local.totalGst+local.subTotalGst>
		<!--- - wb 02/01/2004 - output sub total - --->
		<tr>
  			<!--- <td colspan="2"><b><font size="2">Sub Total (PCode = <cfoutput>#local.pCode#</cfoutput>)</font></b></td> --->
			<td colspan="2"><b><font size="2">Sub Total <cfoutput>#local.pCode#</cfoutput> <cfif qGetPCodeDescription.recordCount GT 0><cfoutput>#qGetPCodeDescription.PCodeDescription#</cfoutput></cfif></font></b></td> 
			
			<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalUnits,"__________.000")#</cfoutput></font></b></td>
			<td colspan="2">&nbsp;</td>
			<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalPrice,"$__________.00")#</cfoutput></font></b></td>
			<td align="right"><b><font size="2"><cfoutput>#numberFormat(local.subTotalGST,"$__________.00")#</cfoutput></font></b></td>
		</tr>
		<tr><td colspan="7">&nbsp;</td></tr>
		<!--- - wb 02/01/2004 - calculate goods total - --->
		<cfset local.totalGoods=local.totalPrice-local.totalGst>
		<!--- - wb 02/01/2004 - output total - --->
		<tr>
			<td align="right" colspan="5"><b><font size="2">GST Total:</font></b></td>
			<td align="right" colspan="2"><b><font size="2"><cfoutput>#numberFormat(local.totalGst,"$_________.00")#</cfoutput></font></b></td>
		</tr>
		<tr>
			<td align="right" colspan="5"><b><font size="2">Goods Total:</font></b></td>
			<td align="right" colspan="2"><b><font size="2"><cfoutput>#numberFormat(local.totalGoods,"$_________.00")#</cfoutput></font></b></td>
		</tr>
		<tr>
			<td align="right" colspan="5"><b><font size="2">Goods Total Inc GST</font></b></td>
			<td align="right" colspan="2"><b><font size="2"><cfoutput>#numberFormat(local.totalPrice,"$_________.00")#</cfoutput></font></b></td>
		</tr>
	</table>
<cfelse>
	<!--- - wb 02/01/2004 - Output messege when no invoices are found - --->	
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td colspan="3"><img src="../images/s.gif" width="1" height="20" alt="Spacer" border="0" /></td></tr>
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td><span class="error">Sorry, No invoices found between <cfoutput>#dateFormat(createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2)),"dddd, dd mmmm yyyy")#</cfoutput> and <cfoutput>#dateFormat(createDate(left(form.eDate,4),mid(form.eDate,5,2),mid(form.eDate,7,2)),"dddd, dd mmmm yyyy")#</cfoutput></span></td>
			<td align="right"><a href="PurchaseHistoryReportSelect.cfm">back</a>&nbsp;</td>
		</tr>
	</table>
</cfif>	
</body>
</html>
