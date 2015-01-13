
<cfsetting enablecfoutputonly="Yes">
<!--- 

theDateTo is from the calendar box
theDate From is calculated as 7 days before theDateTo
These are currently in date format and are treated as date fields as an ODBC date 
eg ODBC Date: {ts '2003-01-09 00:00:00'} 

our query needs to convert the InvoiceDate from the table tblOrderInvoiceHeader into a date format.

so our comparison should use dateFormatting.cfm to return the date in the table as an ODBC date eg ODBC Date: {ts '2003-01-09 00:00:00'} 

In the SQL statement the compare would be:

	DateFormatting(InvoiceDate) >= theDateFrom AND
	dateFormatting(InvoiceDate) <= theDateTo
 --->


<!--- - wb 06/11/2003 - setup page title - --->
<cfset local.pageTitle="Weekly Depot Invoice">

<!--- - wb 21/11/2003 - Setup display date - --->
<cfset local.displayDate=createDate(left(url.date,4),mid(url.date,5,2),mid(url.date,7,2))>

<!--- - wb 21/11/2003 - setup from date - --->
<cfset local.fromDate=dateFormat(dateAdd("d",-6,local.displayDate),"yyyymmdd")>

<!--- - wb 06/11/2003 - Get invoice ids - --->
<CFQUERY name="qGetInvoices" datasource="#application.dsn#" >
SELECT DISTINCT InvoiceID
FROM qryInvoiceDetail
WHERE CONVERT(int, SUBSTRING(InvoiceDate, 5, 4) + SUBSTRING(InvoiceDate, 3, 2) + SUBSTRING(InvoiceDate, 1, 2)) BETWEEN #local.fromDate# AND #url.date#
ORDER BY InvoiceID
</CFQUERY>

<!--- - 26/11/2003 - Get PCode list - --->
<CFQUERY name="qGetPCodes" datasource="#application.dsn#" >
SELECT DISTINCT PCode
FROM qryInvoiceDetail
WHERE CONVERT(int, SUBSTRING(InvoiceDate, 5, 4) + SUBSTRING(InvoiceDate, 3, 2) + SUBSTRING(InvoiceDate, 1, 2)) BETWEEN #local.fromDate# AND #url.date#
ORDER BY PCode
</CFQUERY>

<cfif qGetInvoices.recordCount GT 0>
	<!--- - wb 06/11/2003 - Setup product lists - --->
	<cfset local.lsPCode="">
	<cfset local.lsPLU="">
	<cfset local.lsDescription="">
	<cfset local.lsQty="">
	<cfset local.lsPrice="">
	<cfset local.lsPiceIncGST="">
	<cfset local.lsGST="">
	<cfset local.lsTotal="">
	<cfset local.lsGSTTotal="">
	
	<!--- - wb 06/11/2003 - Setup sub total lists - --->
	<cfset local.lsSubPCode="">
	<cfset local.lsSubPriceIncGST="">
	<cfset local.lsSubGST="">
	
	<!--- - wb 21/11/2003 - testing - --->
	<cfset local.lstotals="">
	
	<!--- - wb 06/11/2003 - Setup totals - --->
	<cfset local.totalGST=0>
	<cfset local.totalProduct=0>
	<cfset local.totalProductIncGST=0>
	
	<cfloop query="qGetInvoices">
		<cfset lngInvoiceId=qGetInvoices.InvoiceId>
	    <!--- Get the store name --->
		<cfset strQuery = "SELECT * from qryInvoiceHeaders where InvoiceID = #lngInvoiceID#">
		<CFQUERY name="GetHeader" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
	    <!--- Get P codes--->
		<cfset strQuery = "SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
		<cfset strQuery = strQuery & "FROM qryInvoiceDetail ">
		<cfset strQuery = strQuery & "GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
		<cfset strQuery = strQuery & "HAVING (((qryInvoiceDetail.InvoiceID)= #lngInvoiceID#))">
		<CFQUERY name="GetPCodes" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
	  	<cfloop query="GetPCodes"> 
	    	<cfset lngPCode=GetPCodes.PCode>
			
			<!--- get the lines --->
			<cfset strQuery = "SELECT * from qryInvoiceDetail where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#) order by Description">
			<CFQUERY name="GetDetail_A" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		    
			<!--- Get the sub Total --->
			<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCode where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#)">
			<CFQUERY name="GetTotals_A" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
	  
			<!--- - wb 21/11/2003 - setup product rows - --->
			<cfloop query="GetDetail_A">
			  <cfif listFind(local.lsPLU,GetDetail_A.PartNo,",") EQ 0>
				  <cfset local.lsPCode=listAppend(local.lsPCode,lngPCode,",")>
				  <cfset local.lsPLU=listAppend(local.lsPLU,GetDetail_A.PartNo,",")>
				  <cfset local.lsDescription=listAppend(local.lsDescription,GetDetail_A.Description,",")>
				  <cfset local.lsQty=listAppend(local.lsQty,numberFormat(REReplaceNoCase(GetDetail_A.QtySup,"[^0-9.]","","ALL"),"__________.000"),",")>
				  <cfset local.lsPiceIncGST=listAppend(local.lsPiceIncGST,numberformat(GetDetail_A.THinvoiceUnitPriceIncTax,"______.00"),",")>
				  <cfset local.lsGST=listAppend(local.lsGST,numberformat(GetDetail_A.THinvoiceUnitTax,"______.00"),",")>
				  <!--- - wb 21/11/2003 - testing - --->
				  <cfset local.lsTest=listAppend(local.lsPiceIncGST,numberformat(GetDetail_A.THinvoiceUnitPriceIncTax,"______.00"),",")>
				  
				  <cfset local.lsTotal=listAppend(local.lsTotal,numberformat(GetDetail_A.THinvoiceUnitPriceIncTaxTotal,"______.00"),",")>
				  <cfset local.lsGSTTotal=listAppend(local.lsGSTTotal,numberformat(GetDetail_A.THinvoiceUnitTaxTotal,"______.00"),",")>
			  <cfelse>
			  	  <cfset local.pos=listFind(local.lsPLU,GetDetail_A.PartNo,",")>
				  	
			  	  <cfset local.qty=listGetAt(local.lsQty,local.pos,",")+numberFormat(REReplaceNoCase(GetDetail_A.QtySup,"[^0-9.]","","ALL"),"__________.000")>
				  <cfset local.lsQty=listSetAt(local.lsQty,local.pos,local.qty,",")>
				  
				  <!--- - wb 21/11/2003 - <cfset local.priceIncGST=listGetAt(local.lsPiceIncGST,local.pos,",")+numberformat(GetDetail_A.THinvoiceUnitPriceIncTax,"______.00")>
				  <cfset local.lsPiceIncGST=listSetAt(local.lsPiceIncGST,local.pos,local.priceIncGST,",")> --->
				  
				  <cfset local.gst=listGetAt(local.lsGST,local.pos,",")+numberformat(GetDetail_A.THinvoiceUnitTax,"______.00")>
				  <cfset local.lsGST=listSetAt(local.lsGST,local.pos,local.gst,",")>
				  
				  <!--- - wb 21/11/2003 - testing - --->
				  <cfset local.lsTest=listAppend(local.lsPiceIncGST,numberformat(GetDetail_A.THinvoiceUnitPriceIncTax,"______.00"),",")>
				  
				  <cfset local.total=listGetAt(local.lsTotal,local.pos,",")+numberformat(GetDetail_A.THinvoiceUnitPriceIncTaxTotal,"______.00")>
				  <cfset local.lsTotal=listSetAt(local.lsTotal,local.pos,local.total,",")>
				  
				  <cfset local.gstTotal=listGetAt(local.lsGSTTotal,local.pos,",")+numberformat(GetDetail_A.THinvoiceUnitTaxTotal,"______.00")>
				  <cfset local.lsGSTTotal=listSetAt(local.lsGSTTotal,local.pos,local.gstTotal,",")>	
			  </cfif>
			</cfloop>  
			
			<!--- - wb 21/11/2003 - setup sub totals - --->
			<cfloop query="GetTotals_A">
				<cfif listFind(local.lsSubPCode,lngPCode,",") EQ 0>
					<cfset local.lsSubPCode=listAppend(local.lsSubPCode,lngPCode,",")>
					
					<cfset local.lsSubPriceIncGST=listAppend(local.lsSubPriceIncGST,numberformat(GetTotals_A.GrandTotalTHinvoiceUnitPriceIncTaxTotal,"______.00"),",")>
					
					<cfset local.lsSubGST=listAppend(local.lsSubGST,numberformat(GetTotals_A.GrandTotalTHinvoiceUnitTaxTotal,"______.00"),",")>		
				<cfelse>
					<cfset local.pos=listFind(local.lsSubPCode,lngPCode,",")>
					
					<cfset local.subPriceIncGST=listGetAt(local.lsSubPriceIncGST,local.pos,",")+numberformat(GetTotals_A.GrandTotalTHinvoiceUnitPriceIncTaxTotal,"______.00")>
				  	<cfset local.lsSubPriceIncGST=listSetAt(local.lsSubPriceIncGST,local.pos,local.subPriceIncGST,",")>
					
					<cfset local.subGST=listGetAt(local.lsSubGST,local.pos,",")+numberformat(GetTotals_A.GrandTotalTHinvoiceUnitTaxTotal,"______.00")>
				  	<cfset local.lsSubGST=listSetAt(local.lsSubGST,local.pos,local.subGST,",")>
				</cfif>	
			</cfloop>
			  
		</cfloop>
		
		<!--- Get the Total --->
		<cfset strQuery = "SELECT * from qryInvoiceDetailTotal where InvoiceID = #lngInvoiceID#">
		<CFQUERY name="GetTotals" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<!--- - wb 21/11/2003 - setup totals - --->
		<cfloop query="GetTotals">
			<!--- - wb 21/11/2003 - testing - --->
			<cfset local.lstotals=listAppend(local.lstotals,numberformat(GetTotals.GrandTotalTHinvoiceGoodsTotal,"______.00"),",")>
			<cfset local.totalGST=local.totalGST+numberformat(GetTotals.GrandTotalTHinvoiceUnitTaxTotal,"______.00")>
			<cfset local.totalProduct=local.totalProduct+numberformat(GetTotals.GrandTotalTHinvoiceGoodsTotal,"______.00")>
			<cfset local.totalProductIncGST=local.totalProductIncGST+numberformat(GetTotals.GrandTotalTHinvoiceUnitPriceIncTaxTotal,"______.00")>
		</cfloop>
	
	</cfloop>
	
</cfif>	
<cfsetting enablecfoutputonly="No">
<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title><cfoutput>#local.pageTitle#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000">
<cfif qGetInvoices.recordCount GT 0>
	<!--- - wb 21/11/2003 - Output page title - --->
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr valign="top">
			<td colspan="3" class="heading">&nbsp;<cfoutput>#local.pageTitle#</cfoutput> for <cfoutput>#dateFormat(local.displayDate,"dddd, dd mmmm yyyy")#</cfoutput><br />
			&nbsp;<span class="normal_body_th">Printed <cfoutput>#timeFormat(now(),"HH:mm")#</cfoutput> <cfoutput>#dateFormat(now(),"dddd, dd mmmm yyyy")#</cfoutput></span></td>
			<td colspan="2" align="right"><a href="InvoiceReport3HWeeklySelect.cfm">back</a>&nbsp;<br />
			<img src="../images/s.gif" width="1" height="50" alt="Spacer" border="0" /></td>	
		</tr> 
	<!--- - wb 21/11/2003 - Output header information - --->	
	<cfoutput Query ="GetHeader">
		<tr valign="top"> 
	    	<td><div align="left"><b>#GetHeader.SupplierName#&nbsp;</b></div></td>
	      	<td><div align="left"><b>Sold To:</b></div></td>
	      	<td><div align="left"><b>#GetHeader.ChainName#&nbsp;</b></div></td>
	      	<td><div align="left"><b>Date From:</b></div></td>
	      	<td><div align="right"><b>#dateFormat(createDate(left(local.fromDate,4),mid(local.fromDate,5,2),mid(local.fromDate,7,2)),"dddd, dd mmmm yyyy")#&nbsp;</b></div></td>
		</tr>
	    <tr valign="top"> 
	      	<td><div align="left"><b>#GetHeader.SupplierAddress1#&nbsp;</b></div></td>
	      	<td><div align="left">&nbsp;</div></td>
	      	<td><div align="left"><b>&nbsp;</b></div></td>
	    	<td><div align="left"><b>Date To:</b></div></td>
	      	<td><div align="right"><b>#dateFormat(createDate(left(url.date,4),mid(url.date,5,2),mid(url.date,7,2)),"dddd, dd mmmm yyyy")#&nbsp;</b></div></td>  	
	    </tr>
	    <tr valign="top"> 
	      	<td><div align="left">ABN: <b>#GetHeader.SupplierABN#&nbsp;</b></div></td>
	      	<td><div align="left">&nbsp;</div></td>
	      	<td><div align="left"><b>&nbsp;</b></div></td>
	      	<td><div align="left">&nbsp;</div></td>
	      	<td><div align="right"><b>&nbsp;</b></div></td>
	    </tr>
	    <tr valign="top"> 
	      	<td><div align="left">Phone: <b>#GetHeader.SupplierPhone#&nbsp;</b></div></td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
	      	<td><div align="left">&nbsp;</div></td>
	      	<td><div align="right"><b>&nbsp;</b></div></td>
	    </tr>
	    <tr valign="top"> 
	      	<td><div align="left">Fax: <b>#GetHeader.SupplierFax#&nbsp;</b></div></td>
	      	<td>&nbsp;</td>
	      	<td>&nbsp;</td>
	      	<td><div align="left">&nbsp;</div></td>
	      	<td><div align="right"><b>&nbsp;</b></div></td>
	    </tr>
	</table>
	</cfoutput>
	<p>&nbsp;</p>
	<!--- - wb 21/11/2003 - row header - --->
	<table width="100%" border="0" cellspacing="0" bordercolor="000000">
		<tr> 
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">PLU</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">Product</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">Units</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">Price INC GST</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">GST per unit</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">Total</font></b></div></td>
			<td bgcolor="99CCFF"><div align="center"><b><font size="2">GST Total</font></b></div></td>
		</tr>
	<!--- - wb 21/11/2003 - Output product rows  - --->	
	<cfloop query="qGetPCodes">
		<cfloop from="1" to="#listLen(local.lsPCode,",")#" index="i">	
			<cfif listGetAt(local.lsPCode,i,",") EQ qGetPCodes.PCode>
				<tr>
					<td><div align="center"><font size="2"><cfoutput>#listGetAt(local.lsPLU,i,",")#</cfoutput></font></div></td>
					<td><font size="2"><cfoutput>#listGetAt(local.lsDescription,i,",")#</cfoutput></font></td>
					<td><div align="center"><font size="2"><cfoutput>#numberFormat(listGetAt(local.lsQty,i,","),"__________.000")#</cfoutput></font></div></td>
					<td><div align="right"><font size="2"><cfoutput>#numberFormat(listGetAt(local.lsPiceIncGST,i,","),"$__________.00")#</cfoutput></font></div></td>
					<td><div align="right"><font size="2"><cfoutput>#numberFormat(listGetAt(local.lsGST,i,","),"$__________.00")#</cfoutput></font></div></td>
					<td><div align="right"><font size="2"><cfoutput>#numberFormat(listGetAt(local.lsTotal,i,","),"$__________.00")#</cfoutput></font></div></td>
					<td><div align="right"><font size="2"><cfoutput>#numberFormat(listGetAt(local.lsGSTTotal,i,","),"$__________.00")#</cfoutput>&nbsp;</font></div></td>
				</tr>
			</cfif>	
		</cfloop>
		<!--- - wb 21/11/2003 - Output sub totals  - --->	
		<cfloop from="1" to="#listLen(local.lsSubPCode,",")#" index="i">
			<cfif listGetAt(local.lsSubPCode,i,",") EQ qGetPCodes.PCode>
				<tr> 
					<td colspan="5"><font size="2"><strong>Sub Total (P Code = <cfoutput>#listGetAt(local.lsSubPCode,i,",")#</cfoutput>)</strong></font></td>
					<td><div align="right"><font size="2"><strong><cfoutput>#numberFormat(listGetAt(local.lsSubPriceIncGST,i,","),"$__________.00")#</cfoutput></strong></font></div></td>
					<td><div align="right"><font size="2"><strong><cfoutput>#numberFormat(listGetAt(local.lsSubGST,i,","),"$__________.00")#</cfoutput>&nbsp;</strong></font></div></td>
				</tr>
				<tr><td colspan="7">&nbsp;</td></tr>
			</cfif>
		</cfloop>
	</cfloop>
		<!--- - wb 21/11/2003 - Output totals  - --->	
		<tr> 
			<td colspan="5"><div align="right"><font size="2"><strong>GST Total:</strong></div></td>
			<td colspan="2"><div align="right"><font size="2"><strong><cfoutput>#numberformat(local.totalGST,"$______.00")#</cfoutput>&nbsp;</strong></font></div></td>
		</tr>
		<tr> 
			<td colspan="5"><div align="right"><font size="2"><strong>Goods Total:</strong></div></td>
			<td colspan="2"><div align="right"><font size="2"><strong><cfoutput>#numberformat(local.totalProduct,"$______.00")#</cfoutput>&nbsp;</strong></font></div></td>
		</tr>
		<tr> 
			<td colspan="5"><div align="right"><font size="2"><strong>GST Inc Total:</strong></div></td>
			<td colspan="2"><div align="right"><font size="2"><strong><cfoutput>#numberformat(local.totalProductIncGST,"$______.00")#</cfoutput>&nbsp;</strong></font></div></td>
		</tr>
	</table>
<cfelse>
<!--- - wb 21/11/2003 - Output messege when no invoices are found - --->	
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td colspan="3"><img src="../images/s.gif" width="1" height="20" alt="Spacer" border="0" /></td></tr>
	<tr valign="top">
		<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
		<td><span class="error">Sorry, No invoices found for <cfoutput>#dateFormat(local.displayDate,"dddd, dd, mmmm yyyy")#</cfoutput></span></td>
		<td align="right"><a href="InvoiceReport3HWeeklySelect.cfm">back</a>&nbsp;</td>
	</tr>
</table>
</cfif>
</body>
</html>
