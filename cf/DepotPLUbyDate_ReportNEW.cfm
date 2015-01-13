
<cfsetting enablecfoutputonly="Yes">
<!--- - wb 12/01/2004 - setup page title - --->
<cfset local.pageTitle="Depot PLU Sales Report">

<!--- - wb 12/01/2004 - Setup display date - --->
<cfset local.startDate=createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2))>
<!--- - wb 12/01/2004 - Setup display date - --->
<cfset local.endDate=createDate(left(form.eDate,4),mid(form.eDate,5,2),mid(form.eDate,7,2))>

	<CFQUERY name="qGetStoreNames" datasource="#application.dsn#" >
	SELECT StoreName
	FROM tblStores where 1=1
		<CFIF form.r_storeId is not "all">
			  and storeID in (#form.r_storeId#) 
		</cfif>
	</CFQUERY>


		<!--- Get the DATA --->

<CFINCLUDE template="./queries/qry_InvoiceDetail_StockMaster_StockGroup.cfm">		


<cfsetting enablecfoutputonly="no">

<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Depot PLU Report by Date</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.reportData { font-family: Arial, Arial, Helvetica; font-weight: normal; font-style: normal; font-size: 10pt }
-->
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000">

	<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr valign="top">
			<td width="25%">&nbsp;</td>
			<td align="center" class="heading" width="50%"><strong><cfoutput>#local.pageTitle#</cfoutput><br />
				<cfoutput>#dateFormat(local.startDate,"dd/mm/yyyy")#</cfoutput> to <cfoutput>#dateFormat(local.endDate,"dd/mm/yyyy")#</cfoutput>
			<cfif isDefined("qGetStoreNames.recordCount")>
				 for 
				 
				 <CFIF form.r_storeId is "all"> All Stores
				 <CFELSE>				 
					<cfif qGetStoreNames.recordCount GT 1> 
						the following stores:
						<p><cfloop query="qGetStoreNames">
							<cfoutput>#qGetStoreNames.StoreName#</cfoutput><br />
						</cfloop></p>
					<cfelse>
						<cfoutput>#qGetStoreNames.StoreName#</cfoutput>
					</cfif>
			     </cfif>
			</cfif>
			<p>Printed <cfoutput>#timeFormat(now(),"HH:mm")#</cfoutput> <cfoutput>#dateFormat(now(),"dddd, dd mmmm yyyy")#</cfoutput></strong></p></td>
			<td align="right" width="25%"><a href="DepotPLUbyDate_Select.cfm">back</a>&nbsp;<br />
			<img src="../images/s.gif" width="1" height="50" alt="Spacer" border="0" /></td>	
		</tr>
	</table>
	<br />

<CFOUTPUT>
	<cfif get_records.recordcount gt 0>
	<table border="1" cellpadding="0" align="CENTER" cellspacing="0" width="99%" class="reportData">
	     <tr>
		   <!--- <td><b>PCode</b></td> --->
		   <!--- <td><b>DeptNo</b></td> --->
		   <td><b>PLU</b></td>
		   <td align="CENTER"><b>Description</b></td>
		   <td align="CENTER"><b>Units</b></td>
		   <td align="CENTER"><b>Average<BR>Cost</b></td>
		   <td align="CENTER"><b>Ave W/S<BR>Ext GST</b></td>
		   <td align="CENTER"><b>Total<BR>W/S</b></td>
		   <td align="CENTER"><b>Sup<br> Margin<br> $</b></td>
		   <td align="CENTER"><b>Sup<br> GP%</b></td>
		   <td align="CENTER"><b>SC<br> Margin<br> $</b></td>
		   <td align="CENTER"><b>SC<br> GP%</b></td>
		   <td align="CENTER"><b>Tot<br> GP%</b></td>
		   <!--- <td><b>Supplier Rebate Total</b></td> --->
		 </tr>
		 
<CFSET ave1 = 0><CFSET ave2 = 0><CFSET ave3 = 0><CFSET subave1 = 0><CFSET subave2 = 0><CFSET subave3 = 0><CFSET grandave1 = 0><CFSET grandave2 = 0><CFSET grandave3 = 0>			  	
<CFSET tot1 = 0><CFSET tot2 = 0><CFSET tot3 = 0><CFSET tot4 = 0>

<CFSET thisPCode = "">
<CFSET thisDept = "">
<CFSET thisPCodeCount = 0>
<CFSET thisDeptCount = 0>
	   <CFloop query="get_records">
	     <CFIF ( thisDept is not deptNo or thisPCode is not PCode ) and get_records.currentRow gt 1>
		    <TR height="25" bgcolor="##DDDDDD">
			  <TD colspan="2" align="RIGHT"><b>Department Totals / Averages</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(tot1,"_____.000")#</b></td>
			  <td align="RIGHT" colspan="2">&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(tot2,"______.00")#</b></td>
			  <td align="RIGHT"><b>#numberformat(tot3,"______.00")#</b></td>			  
			    <CFSET totave1 = ave1 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave1,"______.00")#%</b></td>
				<td align="RIGHT"><b>#numberformat(tot4,"______.00")#</b></td>
			    <CFSET totave2 = ave2 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave2,"______.00")#%</b></td>
			    <CFSET totave3 = ave3 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave3,"______.00")#%</b></td>
				<CFSET ave1 = 0><CFSET ave2 = 0><CFSET ave3 = 0><CFSET thisDeptCount = 0>
			  	<CFSET tot1 = 0><CFSET tot2 = 0><CFSET tot3 = 0><CFSET tot4 = 0>
			</tr>
		 </cfif> 
<!--- 	     <CFIF thisPCode is not PCode and get_records.currentRow gt 1>
		   <TR height="25">
			  <TD colspan="7" align="RIGHT"><b> Sub-totals</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			    <CFSET subtotave1 = subave1 / thisPCodeCount>
		        <td align="RIGHT"><b>#numberformat(subtotave1,"__.00")#%</b></td>
				<td>&nbsp;</td>
			    <CFSET subtotave2 = subave2 / thisPCodeCount>
		        <td align="RIGHT"><b>#numberformat(subtotave2,"__.00")#%</b></td>
			    <CFSET subtotave3 = subave3 / thisPCodeCount>
		        <td align="RIGHT"><b>#numberformat(subtotave3,"__.00")#%</b></td>
				<CFSET subave1 = 0><CFSET subave2 = 0><CFSET subave3 = 0><CFSET thisPCodeCount = 0>
			</tr>
		 </cfif> 
 --->	     <tr>
		   <!--- <td><b>#PCode#</b></td>
		   <td><b>#DeptNo#</b></td> --->
		   <td><b>#PartNo#</b></td>
		   <td><b>#DESCRIPTION#</b></td>
		   <td align="RIGHT">#numberformat(QTY,"______.000")#</td>		      
		   <td align="RIGHT">#numberformat(AVCOSTEX,"_____.00")#</td>
		      <CFIF qty gt 0>
			    <CFSET aveWSextGST = ShopItemTotalEx / qty> 
			  <CFELSE>
			  <CFSET aveWSextGST = 0> 	
			  </cfif>		      
		   <td align="RIGHT">#numberformat(aveWSextGST,"_____.00")#</td>
 		   <td align="RIGHT">#numberformat(shopItemTotalEx,"_______.00")#</td>
		   <td align="RIGHT">#numberformat(SupplierRebateTotal,"______.00")#</td>
		     <CFIF ShopItemTotalEx gt 0>
			    <CFSET supGPpercent = 100* SupplierRebateTotal / ShopItemTotalEx> 
			 <CFELSE>
			    <CFSET supGPpercent = 0> 
			 </cfif>
		   <td align="RIGHT">#numberformat(supGPpercent,"__.00")#%</td>
		   <td align="RIGHT">#numberformat(SCSRebateTotal,"___.00")#</td>
		     <CFIF ShopItemTotalEx gt 0>
 			   <CFSET SCGPpercent = 100 * SCSRebateTotal/ ShopItemTotalEx>			 
			 <CFELSE>
 			   <CFSET SCGPpercent = 0>			 
			 </cfif>
		   <td align="RIGHT">#numberformat(SCGPpercent ,"__.00")#%</td>
		     <CFIF ShopItemTotalEx gt 0>		   		   
			   <CFSET totGPpercent = 100*(( SupplierRebateTotal +SCSRebateTotal)/ ShopItemTotalEx  )>
			 <CFELSE>
			   <CFSET totGPpercent = 0>
			 </CFIF>  
		   <td align="RIGHT">#numberformat(totGPpercent,"__.00")#%</td>
		 </tr>
		 <CFSET tot1 = tot1 + qty><CFSET tot2 = tot2 + shopItemTotalEx ><CFSET tot3 = tot3 + SupplierRebateTotal><CFSET tot4 = tot4 + SCSRebateTotal>
		 <CFSET thisDept = deptNo><CFSET thisPCode = Pcode>
		 <CFSET thisDeptCount = thisDeptCount + 1>		 <CFSET thisPCodeCount = thisPCodeCount + 1>
		 <CFSET ave1 = ave1 + supGPpercent><CFSET ave2 = ave2 + SCGPpercent><CFSET ave3 = ave3 + totGPpercent>
		 <CFSET subave1 = subave1 + supGPpercent><CFSET subave2 = subave2 + SCGPpercent><CFSET subave3 = subave3 + totGPpercent>		 
		 <CFSET grandave1 = grandave1 + supGPpercent><CFSET grandave2 = grandave2 + SCGPpercent><CFSET grandave3 = grandave3 + totGPpercent>		 		 
	   </cfloop>


		    <TR height="25" bgcolor="##DDDDDD">
			  <TD colspan="2" align="RIGHT"><b>Department Totals / Averages</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(tot1,"_____.000")#</b></td>
			  <td align="RIGHT" colspan="2">&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(tot2,"______.00")#</b></td>
			  <td align="RIGHT"><b>#numberformat(tot3,"______.00")#</b></td>			  
			    <CFSET totave1 = ave1 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave1,"______.00")#%</b></td>
				<td align="RIGHT"><b>#numberformat(tot4,"______.00")#</b></td>
			    <CFSET totave2 = ave2 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave2,"______.00")#%</b></td>
			    <CFSET totave3 = ave3 / thisDeptCount>
		        <td align="RIGHT"><b>#numberformat(totave3,"______.00")#%</b></td>
			</tr>
			
			<CFSET grandTot1 = #ArraySum(listToArray(valuelist(get_records.QTY)))#>
			<CFSET grandTot2 = #ArraySum(listToArray(valuelist(get_records.shopItemTotalEx )))#>
			<CFSET grandTot3 = #ArraySum(listToArray(valuelist(get_records.SupplierRebateTotal)))#>
			<CFSET grandTot4 = #ArraySum(listToArray(valuelist(get_records.SCSRebateTotal)))#>									
			
		   <TR height="25" bgcolor="##CCCCCC">
			  <TD colspan="2" align="RIGHT"><b> GRAND TOTALS</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(grandtot1,"_____.000")#</b></td>
			  <td align="RIGHT" colspan="2">&nbsp;</td>
			  <td align="RIGHT"><b>#numberformat(grandtot2,"______.00")#</b></td>
			  <td align="RIGHT"><b>#numberformat(grandtot3,"______.00")#</b></td>			  
			  
			    <CFSET grandtotave1 = grandave1 / get_records.recordCount>
		        <td align="RIGHT"><b>#numberformat(grandtotave1,"__.00")#%</b></td>
			  <td align="RIGHT"><b>#numberformat(grandtot4,"______.00")#</b></td>			  
			    <CFSET grandtotave2 = grandave2 / get_records.recordCount>
		        <td align="RIGHT"><b>#numberformat(grandtotave2,"__.00")#%</b></td>
			    <CFSET grandtotave3 = grandave3 / get_records.recordCount>
		        <td align="RIGHT"><b>#numberformat(grandtotave3,"__.00")#%</b></td>
			</tr>
			
			

	</table>
	<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td colspan="3"><img src="../images/s.gif" width="1" height="20" alt="Spacer" border="0" /></td></tr>
		<tr valign="top">
			<td><img src="../images/s.gif" width="15" height="1" alt="Spacer" border="0" /></td>
			<td><span class="error">Sorry, No records found for the dates #dateFormat(local.startDate,"dd/mm/yyyy")# to #dateFormat(local.endDate,"dd/mm/yyyy")#</span>
			<cfif isDefined("qGetStoreNames.recordCount")>
				 for the selected stores				
			</cfif></td>
			<td align="right"><a href="DepotPLUbyDate_Select.cfm">back</a>&nbsp;</td>
		</tr>
	</table>
	</cfif>
</cfoutput>
</body>
</html>
