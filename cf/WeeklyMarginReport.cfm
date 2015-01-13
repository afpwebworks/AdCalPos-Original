
<cfsetting enablecfoutputonly="Yes">
<!--- - wb 12/01/2004 - setup page title - --->
<cfset local.pageTitle="Weekly Margin Report">

<!--- - wb 12/01/2004 - Setup display date - --->
<cfset local.displayDate=createDate(left(url.date,4),mid(url.date,5,2),mid(url.date,7,2))>

<!--- - wb 12/01/2004 - setup from date - --->
<cfset local.fromDate=dateFormat(dateAdd("d",-6,local.displayDate),"yyyymmdd")>

<!--- wb 11/01/2004 - Get the store name --->
<CFQUERY name="qGetHeader" datasource="#application.dsn#" > 
SELECT DISTINCT InvoiceID, InvoiceDate
FROM qryInvoiceHeaders
WHERE CONVERT(int, SUBSTRING(InvoiceDate, 7, 4) + SUBSTRING(InvoiceDate, 4, 2) + SUBSTRING(InvoiceDate, 1, 2)) BETWEEN '#local.fromDate#' AND '#url.date#'
ORDER BY InvoiceDate DESC
</CFQUERY>

<cfif qGetHeader.recordCount GT 0>
	<!--- wb 11/01/2004 -  - --->
	<cfset local.pageContent=''>
	
	<cfset local.lsPartNo=''>
	<cfset local.arContent=arrayNew(2)>
	<cfset local.arSubTotals=arrayNew(2)>
	<cfset local.arTotals=arrayNew(1)>
	<cfset local.arCost=arrayNew(2)>
	
	<cfset local.lspCode=''>
	
	<cfloop query="qGetHeader">	
		<cfset local.invoiceId=qGetHeader.InvoiceID>
	    <!--- wb 11/01/2004 - Get P codes--->
		<CFQUERY name="qGetPCodes" datasource="#application.dsn#" > 
		SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode
		FROM qryInvoiceDetail
		GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode
		HAVING (qryInvoiceDetail.InvoiceID)= #local.invoiceId#
		</CFQUERY>
		
		<cfloop query="qGetPCodes">
			<cfset local.pCode=qGetPCodes.PCode>
			<!--- get the lines --->
			<CFQUERY name="qGetDetail" datasource="#application.dsn#" > 
			SELECT *
			FROM qryInvoiceDetail
			WHERE InvoiceID = #local.invoiceId# AND PCode = #local.pCode#
			ORDER BY Description
			</CFQUERY>
		    
			<cfloop query="qGetDetail">
				<cfif listFind(local.lsPartNo,qGetDetail.PartNo,",") EQ 0>
					<cfset local.cCount=0>
					<cfset local.cCount=local.cCount+1>
					<cfset tmp=arrayAppend(local.arCost[1],qGetDetail.PartNo)>
					<cfset tmp=arrayAppend(local.arCost[2],local.cCount)>
					
					<cfset local.lsPartNo=listAppend(local.lsPartNo,qGetDetail.PartNo,",")>
					<cfset tmp=arrayAppend(local.arContent[1],qGetDetail.Description)>
					<cfset local.regExp="[a-zA-Z]+">
					<cfset tmp=arrayAppend(local.arContent[2],REReplace(qGetDetail.QtySup,"[A-Za-z]+","","ALL"))>
					<cfset tmp=arrayAppend(local.arContent[3],qGetDetail.UnitPriceIncTax)>
					<cfset local.tws=qGetDetail.UnitPriceIncTax*REReplace(qGetDetail.QtySup,"[A-Za-z]+","","ALL")>
					<cfset tmp=arrayAppend(local.arContent[4],numberformat(local.tws,"______.00"))>
					<cfset tmp=arrayAppend(local.arContent[5],numberformat(qGetDetail.THRebateUnitExGTotal,"______.00"))>
					<!--- <cfset tmp=arrayAppend(local.arContent[6],Sup GP%)> --->
					<cfset tmp=arrayAppend(local.arContent[7],numberformat(qGetDetail.SCRebateUnitExGTotal,"______.00"))>
					<!--- <cfset tmp=arrayAppend(local.arContent[8],SC GP%)> --->
					<!--- <cfset tmp=arrayAppend(local.arContent[9],Total GP%)> --->
					<cfset tmp=arrayAppend(local.arContent[10],local.pCode)>
					<cfset tmp=arrayAppend(local.arContent[11],REReplace(qGetDetail.QtySup,"[0-9]+","","ALL"))>
				<cfelse>
					<cfset local.pos=listFind(local.lsPartNo,qGetDetail.PartNo,",")>
					
					<cfset local.cCount=local.arCost[2][local.pos]+1>
					<cfset local.arCost[2][local.pos]=local.cCount>
					
					<cfset local.qty=REReplace(qGetDetail.QtySup,"[A-Za-z]+","","ALL")+local.arContent[2][local.pos]>
					<cfset local.arContent[2][local.pos]=local.qty>
					
					<cfset local.totalWS=qGetDetail.UnitPriceIncTax+local.arContent[3][local.pos]>
					<cfset local.arContent[3][local.pos]=local.totalWS>
					
					<cfset local.tws=local.arContent[4][local.pos]+(qGetDetail.UnitPriceIncTax*REReplace(qGetDetail.QtySup,"[A-Za-z]+","","ALL"))>
					<cfset local.arContent[4][local.pos]=numberformat(local.tws,"______.00")>
					
					<cfset local.THRebateUnitExGTotal=numberformat(qGetDetail.THRebateUnitExGTotal,"______.00")+local.arContent[5][local.pos]>
					<cfset local.arContent[5][local.pos]=local.THRebateUnitExGTotal>
					
					<!--- <cfset tmp=arrayAppend(local.arContent[6],Sup GP%)> --->
					
					<cfset local.SCRebateUnitExGTotal=numberformat(qGetDetail.SCRebateUnitExGTotal,"______.00")+local.arContent[7][local.pos]>
					<cfset local.arContent[7][local.pos]=local.SCRebateUnitExGTotal>
					
					<!--- <cfset tmp=arrayAppend(local.arContent[8],SC GP%)> --->
					<!--- <cfset tmp=arrayAppend(local.arContent[9],Total GP%)> --->
				</cfif>
			</cfloop>
					
			<!--- Get the Total --->
			<CFQUERY name="qGetTotals_A" datasource="#application.dsn#" > 
			SELECT *
			FROM qryInvoiceDetailTotalByPCode
			WHERE InvoiceID = #local.invoiceId# AND PCode = #local.pCode#
			</CFQUERY>
			
			<cfloop query="qGetTotals_A">
				<cfif listFind(local.lspCode,qGetTotals_A.PCode,",") EQ 0>
					<cfset local.lspCode=listAppend(local.lspCode,qGetTotals_A.PCode,",")>
					<cfset tmp=arrayAppend(local.arSubTotals[1],qGetTotals_A.PCode)>
					<cfset tmp=arrayAppend(local.arSubTotals[2],numberformat(qGetTotals_A.GrandTotalTHRebate,"______.00"))>
					<cfset tmp=arrayAppend(local.arSubTotals[3],numberformat(qGetTotals_A.GrandTotalSCRebate,"______.00"))>
				<cfelse>
					<cfset local.pos=listFind(local.lspCode,qGetTotals_A.PCode,",")>
					<cfset local.GrandTotalTHRebate=local.arSubTotals[2][local.pos]+numberformat(qGetTotals_A.GrandTotalTHRebate,"______.00")>
					<cfset local.arSubTotals[2][local.pos]=local.GrandTotalTHRebate>
					<cfset local.GrandTotalSCRebate=local.arSubTotals[3][local.pos]+numberformat(qGetTotals_A.GrandTotalSCRebate,"______.00")>
					<cfset local.arSubTotals[3][local.pos]=local.GrandTotalSCRebate>
				</cfif>
			</cfloop>
			
		</cfloop>
		
		<!--- wb 11/01/2004 - Get the Total - --->
		<CFQUERY name="qGetTotals" datasource="#application.dsn#" > 
		SELECT *
		FROM qryInvoiceDetailTotalRebate
		WHERE InvoiceID = #local.invoiceId#
		</CFQUERY>
		
		<cfloop query="qGetTotals">
			<cfif arrayLen(local.arTotals) EQ 0>
				<!--- Margin (Ex Tax): --->
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GrandTotalTHRebate,"______.00"))>
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GrandTotalSCRebate,"______.00"))>
				<!--- Goods Total (Ex Tax): --->
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GrandTotalTHinvoiceGoodsTotal,"______.00"))>
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GrandTotalGoods,"______.00"))>
				<!--- GP %: --->
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GPTH,"______.00"))>
				<cfset tmp=arrayAppend(local.arTotals,numberformat(qGetTotals.GPSC,"______.00"))>
			<cfelse>
				<!--- Margin (Ex Tax): --->
				<cfset local.grandTotalTHRebate=numberformat(qGetTotals.GrandTotalTHRebate,"______.00")+local.arTotals[1]>
				<cfset local.arTotals[1]=local.grandTotalTHRebate>
				
				<cfset local.grandTotalSCRebate=numberformat(qGetTotals.GrandTotalSCRebate,"______.00")+local.arTotals[2]>
				<cfset local.arTotals[2]=local.grandTotalSCRebate>
				<!--- Goods Total (Ex Tax): --->
				
				<cfset local.grandTotalTHinvoiceGoodsTotal=numberformat(qGetTotals.GrandTotalTHinvoiceGoodsTotal,"______.00")+local.arTotals[3]>
				<cfset local.arTotals[3]=local.grandTotalTHinvoiceGoodsTotal>
				
				<cfset local.grandTotalGoods=numberformat(qGetTotals.GrandTotalGoods,"______.00")+local.arTotals[4]>
				<cfset local.arTotals[4]=local.grandTotalGoods>
				<!--- GP %: --->
				
				<cfset local.GPTH=numberformat(qGetTotals.GPTH,"______.00")+local.arTotals[5]>
				<cfset local.arTotals[5]=local.GPTH>
				
				<cfset local.GPSC=numberformat(qGetTotals.GPSC,"______.00")+local.arTotals[6]>
				<cfset local.arTotals[6]=local.GPSC>
			</cfif>
		</cfloop>
	
	</cfloop>
	
	<cfloop from="1" to="#arrayLen(local.arSubTotals[1])#" index="i">
		<cfset local.pCode=local.arSubTotals[1][i]>
		<cfloop from="1" to="#arrayLen(local.arContent[1])#" index="j">
			<cfif local.arContent[10][j] EQ local.pCode>
				
				<cfset local.aveCost=local.arContent[3][j]/local.arCost[2][j]>
				<cfif local.arContent[4][j] NEQ 0>
					<cfset local.supGp=numberformat(local.arContent[5][j],"______.00")/local.arContent[4][j]>
					<cfset local.scGp=numberformat(local.arContent[7][j],"______.00")/local.arContent[4][j]>
					<cfset local.totalGp=(local.arContent[5][j]+local.arContent[7][j])/local.arContent[4][j]>
				<cfelse>
					<cfset local.supGp=0>
					<cfset local.scGp=0>
					<cfset local.totalGp=0>
				</cfif>
				
							
				<cfset local.pageContent=local.pageContent & "<tr> 
					<td align=""center""><font size=""2"">" & listGetAt(local.lsPartNo,j,",") & "&nbsp;</font></td>
					<td><font size=""2"">" & local.arContent[1][j] & "&nbsp;</font></td>
					<td align=""center""><font size=""2"">" & local.arContent[2][j] & local.arContent[11][j] & "&nbsp;</font></td>
					<td><font size=""2"">" & numberformat(local.aveCost,"$______.00") & "</font></td>
					<td><font size=""2"">" & numberformat(local.arContent[4][j],"$______.00") & "</font></td>
					<td><font size=""2"">" & numberformat(local.arContent[5][j],"______.00") & "&nbsp;</font></td>
					<td><font size=""2"">" & numberformat(local.supGp,"______.00") & "</font></td>
					<td><font size=""2"">" & numberformat(local.arContent[7][j],"______.00") & "&nbsp;</font></td>
					<td><font size=""2"">" & numberformat(local.scGp,"______.00") & "</font></td>
					<td><font size=""2"">" & numberformat(local.totalGp,"______.00") & "</font></td>
				</tr>">
			</cfif>	
		</cfloop>
		
		<cfset local.pageContent=local.pageContent & "<tr> 
			<td colspan=""5"">&nbsp;<font size=""2""><strong>Sub Total (P Code = " & local.pCode & ")</strong></font></td>
			<td colspan=""2""><font size=""2""><strong>" & numberformat(local.arSubTotals[2][i],"$______.00") & "&nbsp;</strong></font></td>
			<td colspan=""3""><font size=""2""><strong>" & numberformat(local.arSubTotals[3][i],"$______.00") & "&nbsp;</strong></font></td>
		</tr>
		<tr><td colspan=""10"">&nbsp;</td></tr>">  
	</cfloop>
</cfif>	
<cfsetting enablecfoutputonly="No">
<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Margin Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<cfif qGetHeader.recordCount GT 0>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr valign="top">
			<td colspan="3" class="heading">&nbsp;<cfoutput>#local.pageTitle#</cfoutput> for Week Ending <cfoutput>#dateFormat(local.displayDate,"dd/mm/yyyy")#</cfoutput><br />
			&nbsp;<span class="normal_body_th">Printed <cfoutput>#timeFormat(now(),"HH:mm")#</cfoutput> <cfoutput>#dateFormat(now(),"dddd, dd mmmm yyyy")#</cfoutput></span></td>
			<td colspan="2" align="right"><a href="WeeklyMarginReportSelect.cfm">back</a>&nbsp;<br />
			<img src="../images/s.gif" width="1" height="50" alt="Spacer" border="0" /></td>	
		</tr>
	</table>
	<br />
	
	<table width="100%" border="0" cellspacing="0" bordercolor="000000">
	  <tr bgcolor="99CCFF"> 
	    <td><div align="center"><strong><font size="2">PLU</font></strong></div></td>
	    <td><div align="center"><strong><font size="2">Product</font></strong></div></td>
	    <td><div align="center"><strong><font size="2">Units</font></strong></div></td>
		<td><strong><font size="2">Ave Cost</font></strong></td>
	    <td><strong><font size="2">Total W/S</font></strong></td>
	    <td><strong><font size="2">Sup Margin</font></strong></td>
		<td><strong><font size="2">Sup GP%</font></strong></td>
	    <td><strong><font size="2">SC Margin</font></strong></td>
		<td><strong><font size="2">SC GP%</font></strong></td>
		<td><strong><font size="2">Total GP%</font></strong></td>
	  </tr>
	
	<cfoutput>#local.pageContent#</cfoutput>
	
	<cfoutput query="qGetTotals">
	  <tr> 
	    <td colspan="10">&nbsp;</td>
	  </tr>
	  <tr> 
	    <td colspan="8"><div align="right"><font size="2"><strong>Margin (Ex Tax):</strong></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[1],"$_________.00")#&nbsp;</strong></font></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[2],"$_________.00")#&nbsp;</strong></font></div></td>
	  </tr>
	  <tr> 
	    <td colspan="8"><div align="right"><font size="2"><strong>Goods Total (Ex Tax):</strong></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[3],"$_________.00")#&nbsp;</strong></font></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[4],"$_________.00")#&nbsp;</strong></font></div></td>
	  </tr>
	  <tr> 
	    <td colspan="8"><div align="right"><font size="2"><strong>GP %:</strong></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[5],"$_________.00")#&nbsp;</strong></font></div></td>
	    <td><div align="right"><font size="2"><strong>#numberFormat(local.arTotals[6],"$_________.00")#&nbsp;</strong></font></div></td>
	  </tr>
	</cfoutput>  
	</table>
<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td colspan="3"><img src="../images/s.gif" width="1" height="20" alt="Spacer" border="0" /></td></tr>
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td><span class="error">Sorry, No records found for <cfoutput>#dateFormat(local.displayDate,"dddd, dd, mmmm yyyy")#</cfoutput></span></td>
			<td align="right"><a href="WeeklyMarginReportSelect.cfm">back</a>&nbsp;</td>
		</tr>
	</table>
</cfif>
</body>
</html>
