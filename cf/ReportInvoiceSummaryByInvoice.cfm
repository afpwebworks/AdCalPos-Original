
<!--Set the Store ID -->
<cfset lngStoreID = #URL.SID#>
<!--- Set the start date and end date --->
<cfset lngFD = #URL.FD#>
<cfset lngTD = #URL.TD#>
<cfset GrandTotal=ArrayNew(1)>
<cfset DateFrom = #CREATEDATE(mid(lngFD,1,4),mid(lngFD,5,2),mid(lngFD,7,2))#>
<cfset DateTo = #CREATEDATE(mid(lngTD,1,4),mid(lngTD,5,2),mid(lngTD,7,2))#>	
<CFSET datesListYYYYMMDD = "">
	<CFLOOP from="#dateFrom#" to="#dateTo#" index="loop">
	      <CFSET datesListYYYYMMDD = listAppend(datesListYYYYMMDD,"'" & #dateFormat(loop,"YYYYMMDD")# & "'")>
	</cfloop>
	<cfset strQuery = "Select *, IsNull(SCSTubsEx,0) AS SCSTubsEx, IsNull(SFMTubsEx,0) AS SFMTubsEx, IsNull(DeliveryEx,0) AS DeliveryEx, isNull(DeliveryTax,0) as DeliveryTax, isNull(SCSTubsTax,0) as SCSTubsTax, isNull(SFMTubsTax,0) as SFMTubsTax, isnull(JCGST,0) as JCGST from qryInvoiceSummaryByInvoice ">
	<cfset strQuery = strQuery & " Where ">
	<cfif lngStoreID is not "all">
		<cfset strQuery = strQuery & " theStoreID IN(#lngStoreID#) and ">
	</cfif>
	<cfset strQuery = strQuery & " InvoiceDate IN(#datesListYYYYMMDD#) ">
	<CFQUERY name="GetData"  datasource="#application.dsn#"  >   
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
<cfset strPageTitle = "Invoice Summary By Invoice">
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
	<STYLE type="text/css">
  <!--
	 .reportData { font-size : 12px; font-family : Arial, Helvetica, sans-serif; font-weight : normal;}
	 .reportHeader { font-size : 14px; font-family : Arial, Helvetica, sans-serif; font-weight : bold;}
	 
	 .headerTable { font-family: Arial, Arial, Helvetica; font-weight: bold; font-style: normal; font-size: 13pt ;}
TD { font-family: Arial, Arial, Helvetica; font-weight: normal; font-style: normal; font-size: 8pt ;}
.TDnoBorder { font-family: Arial, Arial, Helvetica; font-weight: normal; font-style: normal; font-size: 8pt ;border-bottom: 1px  solid FFFFFF;border-left: 0px;border-right: 0px; border-top: 1px  solid FFFFFF;padding-right: 3px;}
  -->
</style>
</HEAD>
<body>
<cfinclude template="navbar_header_small.cfm">
<table width="960">
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle#</h1> </CFOUTPUT>
      <br>
	  <h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and 	
	  					#mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>	
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>  
</table>
	<cfloop index="i" from="1" to="15" step="1">
		<cfset GrandTotal[i] = 0>
	</cfloop>	
	<cfset SubTotalArray = ArrayNew(2)>
	<cfset store_index=1>
	<cfset value_index=1>
	<cfset SubTotalArray[store_index][value_index]=0>
	<cfset TotalInvoiceAmt = 0>
	<cfset TotalSCReb = 0>
	<cfset TotalSupInvoice = 0>
	<cfset TotalStoreGST = 0>
	<cfset TotalstoreExGST = 0>
	<cfset TotalJCReb=0>
	<cfset TotalGSTonSC=0>
	<cfset TotalSCSTubs = 0>
	<cfset TotalSFMTubs = 0>
	<cfset TotalDEliveryCharge = 0>
	<cfset TotalDeliveryEx = 0>
	<cfset TotalstInvGood=0>
	<cfset TotalstInvGoodNet=0>
	<cfset TotalJCTubsTax=0>
	<cfset TotalJCDelTax=0>
	<cfset TotalJCGoodsTax=0>
	<cfset TotalJCTotalTax=0>
	<cfset TotalGSTVar = 0>
	<cfset storID = "">
	<cfset firstround = 1>
	<cfset SumPCodes = 0>
	<cfset ind=0>
	<cfset StoreArray =ArrayNew(1)>
	<cfset StoreArray[store_index]="">
	
	                                
	<cfoutput query="GetData">
		<cfif storID neq theStoreID >
			<cfset ind=ind+1>
			<cfset store_index=ind>
			<cfset value_index=1>
			<cfset SubTotalArray[store_index][value_index]=0>
			<cfset storID = theStoreID>
		
				<cfif firstround eq 1>
	  				<!--- Get the store name --->
					<cfset strQuery = "SELECT StoreName from tblStores" >
					<cfset strQuery = strQuery & " where StoreID=#StorID# ">
					<CFQUERY name="GetStoreDetail" datasource="#application.dsn#"  > 
						#PreserveSingleQuotes(strQuery)#
					</CFQUERY>
					
					<cfset StoreArray[store_index]=#GetStoreDetail.StoreName#>
					<cfset firstround=0>
					<table width="1000" border="1">
					<tr>
						<td colspan = "17" align="center">
						<br>#GetStoreDetail.StoreName#<br><br>
						</td>
					</tr>
					<tr align="center">
						<td width="60">Inv Date</td>
						<td width="50">Inv Number</td>
						<td width="70">Store Inv Amt</td>
						<td width="60">SC Reb</td>
						<td width="80">JC Inv</td>
						<td width="70">JC Reb</td>
						<td width="60">GST on SC Inv</td>
						<td width="70">Store Inv Good Total</td>
						<td width="70">SCS Tubs Ex GST</td>
						<td width="60">SFM Tubs Ex GST</td>
						<td width="60">Delivery Charge Ex GST</td>
						<td width="50">Store Inv Good Total Net</td> 
						<td width="70">JC Tubs Tax</td>
						<td width="50">JC Del Tax</td>
						<td width="50">JC Goods Tax</td>
						<td width="60">JC Total Tax</td>
						<td width="30">GST Var</td>
					</tr>
				</cfif> 
				  <cfif #GetData.currentRow# gt 1>
			<!--- Get the store name --->
					<cfset strQuery = "SELECT StoreName from tblStores" >
					<cfset strQuery = strQuery & " where StoreID=#StorID# ">
					<CFQUERY name="GetStoreDetail" datasource="#application.dsn#"  >   
						#PreserveSingleQuotes(strQuery)#
					</CFQUERY>
					<cfset StoreArray[store_index]=#GetStoreDetail.StoreName#>
					<tr align="right" bgcolor="black">
						<td colspan="2" align="center">Sub Total</td>
						<td width="70">
							#numberformat(TotalInvoiceAmt,"___,__.00")#
							<cfset GrandTotal[1] = GrandTotal[1]+TotalInvoiceAmt>
						</td>
						<td width="60">
							#numberformat(TotalScReb,"___,__.00")#
							<cfset GrandTotal[2] = GrandTotal[2]+TotalScReb>
						</td>
						<td width="80">
							#numberformat(TotalSupInvoice,"___,__.00")#
							<cfset GrandTotal[3] = GrandTotal[3]+TotalSupInvoice>
						</td>
						<td width="70">
							#numberformat(TotalJCReb,"___,__.00")#
							<cfset GrandTotal[4] = GrandTotal[4]+TotalJCReb>
						</td>
						<td width="60">
							#numberformat(TotalstoreGST,"___,__.00")#
							<cfset GrandTotal[5] = GrandTotal[5]+TotalstoreGST>
						</td>
						<td width="70">
							#numberformat(TotalstInvGood,"___,__.00")#
							<cfset GrandTotal[6] = GrandTotal[6]+TotalstInvGood>
						</td>
						<td width="70">
							#numberformat(TotalSCSTubs,"___,__.00")#
							<cfset GrandTotal[7] = GrandTotal[7]+TotalSCSTubs>
						</td>
						<td width="60">
							#numberformat(TotalSFMTubs,"___,__.00")#
							<cfset GrandTotal[8] = GrandTotal[8]+TotalSFMTubs>
						</td>
						<td width="50">
							#numberformat(TotalDeliveryEx,"___,__.00")#
							<cfset GrandTotal[9] = GrandTotal[9]+TotalDeliveryEx>
						</td>
						<td width="70">
							#numberformat(TotalStInvGoodNet,"___,__.00")#
							<cfset GrandTotal[10] = GrandTotal[10]+TotalStInvGoodNet>
						</td>
						<td width="50">
							#numberformat(TotalJCTubsTax,"___,__.00")#
							<cfset GrandTotal[11] = GrandTotal[11]+TotalJCTubsTax>
						</td>
						<td width="50">
							#numberformat(TotalJCDelTax,"___,__.00")#
							<cfset GrandTotal[12] = GrandTotal[12]+TotalJCDelTax>
						</td>
						<td width="50">
							#numberformat(TotalJCGoodsTax,"___,__.00")#
							<cfset GrandTotal[13] = GrandTotal[13]+TotalJCGoodsTax>
						</td>
						<td width="60">
							#numberformat(TotalJCTotalTax,"___,__.00")#
							<cfset GrandTotal[14] = GrandTotal[14]+TotalJCTotalTax>
						</td>
						<td width="30" >
						#numberformat(TotalGSTVar,"___,__.00")#
						<cfset GrandTotal[15] = GrandTotal[15]+TotalGSTVar>
							</td>
						</tr>
							<tr><td colspan = "17" align="center">
							<br>#GetStoreDetail.StoreName#<br><br>
						</td></tr>
						<cfset TotalInvoiceAmt = 0>
						<cfset TotalSCReb = 0>
						<cfset TotalSupInvoice = 0>
						<cfset TotalStoreGST = 0>
						<cfset TotalstoreExGST = 0>
						<cfset TotalJCReb=0>
						<cfset TotalGSTonSC=0>
						<cfset TotalstInvGood=0>
						<cfset TotalstInvGoodNet=0>
						<cfset TotalSCSTubs = 0>
						<cfset TotalSFMTubs = 0>
						<cfset TotalDEliveryCharge = 0>
						<cfset TotalDeliveryEx = 0>
						<cfset TotalJCTubsTax=0>
						<cfset TotalJCDelTax=0>
						<cfset TotalJCGoodsTax=0>
						<cfset TotalJCTotalTax=0>
						<cfset TotalGSTVar = 0>
						<cfset SumPCodes = 0>
					<tr align="center">
						<td width="60">Inv Date</td>
						<td width="50">Inv Number</td>
						<td width="70">Store Inv Amt</td>
						<td width="60">SC Reb</td>
						<td width="80">JC Inv</td>
						<td width="70">JC Reb</td>
						<td width="60">GST on SC Inv</td>
						<td width="70">Store Inv Good Total</td>
						<td width="70">SCS Tubs Ex GST</td>
						<td width="60">SFM Tubs Ex GST</td>
						<td width="60">Delivery Charge Ex GST</td>
						<td width="50">Store Inv Good Total Net</td> 
						<td width="70">JC Tubs Tax</td>
						<td width="50">JC Del Tax</td>
						<td width="50">JC Goods Tax</td>
						<td width="60">JC Total Tax</td>
						<td width="30">GST Var</td>
					</tr>
				</tr>
			</cfif>
	 	</cfif>
		<tr align="right">
			<td>
				#InvoiceDate#
			</td>
			<td>
				#InvoiceID#
			</td>
			<td>
				#numberformat(StoreInvoiceAmtInc,"____,___.00")#
			</td>
				<cfset TotalInvoiceAmt = TotalInvoiceAmt+StoreInvoiceAmtInc>
				<cfset SubTotalArray[store_index][1]=TotalInvoiceAmt>
			<td>
				#numberformat(scRebate,"_____,__.00")# 
			</td>
				<cfset TotalSCReb = TotalSCReb+scRebate>
				<cfset SubTotalArray[store_index][2]=TotalSCReb>
			<td>
				#numberformat(supInvoice,"____,___.00")# 
			</td>
				<cfset TotalSupInvoice = TotalSupInvoice+supInvoice>
				<cfset SubTotalArray[store_index][3]=TotalSupInvoice>
			<td>
				#numberformat(supRebate,"_____,__.00")# 
			</td>
				<cfset TotalJCReb = TotalJCReb+supRebate>
				<cfset SubTotalArray[store_index][4]=TotalJCReb >
			<td>
				#numberformat(storeGST,"_____,__.00")# 
			</td>
				<cfset TotalstoreGST = TotalstoreGST+storeGST>
				<cfset SubTotalArray[store_index][5]=TotalstoreGST>
			<td>
				#numberformat(storeExGST,"____,___.00")# 
			</td>
				<cfset TotalstInvGood=TotalstInvGood+storeExGST>
				<cfset SubTotalArray[store_index][6]=TotalstInvGood>
			<td>
					<cfif #trim(SCSTubsEx)# eq "">
						<cfset SCSTubsEx = 0>
					</cfif>
					#numberformat(SCSTubsEx,"_____,__.00")# 
			</td>
					<cfif #IsNumeric(SCSTubsEx)#>
						<cfset  TotalSCSTubs =  TotalSCSTubs+SCSTubsEx> 
						<cfset SubTotalArray[store_index][7]=TotalSCSTubs>
					<cfelse>
						<cfset SCSTubsEx=0>
						<cfset  TotalSCSTubs =  TotalSCSTubs+#numberformat(SCSTubsEx,"_____,__.00")# > 
						<cfset SubTotalArray[store_index][7]=TotalSCSTubs>		
					</cfif>
			<td>
			
					<cfif #trim(SFMTubsEx)# eq "">
						<cfset SFMTubsEx = 0>
					</cfif>
						#numberformat(SFMTubsEx,"_____,__.00")# 
			</td>
			
				<cfif #IsNumeric(SFMTubsEx)#>
					<cfset  TotalSFMTubs =  TotalSFMTubs+SFMTubsEx>
					<cfset SubTotalArray[store_index][8]=TotalSFMTubs>
				<cfelse>
					<cfset SFMTubsEx=0>
					<cfset  TotalSFMTubs =  TotalSFMTubs +#numberformat(SFMTubsEx,"_____,__.00")# > 
					<cfset SubTotalArray[store_index][8]=TotalSFMTubs>
				</cfif>
			<td>
				<cfif #trim(DeliveryEx)# eq "">
					<cfset DeliveryEx = 0>
				</cfif>
				#numberformat(DeliveryEx,"_____,__.00")#
			</td>
				<cfset TotalDeliveryEx = TotalDeliveryEx+#numberformat(DeliveryEx,"_____,__.00")#>
				<cfset SubTotalArray[store_index][9]=TotalDeliveryEx>
				<cfset value_index=value_index+1>
				
				<cfset SumPCodes = 0>
				 <cfif #IsNumeric(SCSTubsEx)# and #IsNumeric(SFMTubsEx)# and #IsNumeric(DeliveryEx)#>
					<cfset SumPCodes = SCSTubsEx+SFMTubsEx+DeliveryEx>
					 
				</cfif>
				
					<cfset TubsTax=0>
					<cfif #IsNumeric(SFMTubsTax)# and #IsNumeric(SCSTubsTax)#>
						<cfset TubsTax = SFMTubsTax+SCSTubsTax>
						
					</cfif>
					
			<td>
				<cfset StInvGoodNet = storeExGST-SumPCodes>
				#numberformat(StInvGoodNet,"____,___.00")#  
			</td>
			<cfset TotalStInvGoodNet=TotalStInvGoodNet+StInvGoodNet>
			<cfset SubTotalArray[store_index][10]=TotalStInvGoodNet>
			<cfset value_index=value_index+1>
			<td>
				#numberformat(TubsTax,"_____,__.00")# 
			</td>
				<cfset TotalJCTubsTax=TotalJCTubsTax+TubsTax>
				<cfset SubTotalArray[store_index][11]=TotalJCTubsTax>
				<cfset value_index=value_index+1>
			<td>
				#numberformat(DeliveryTax,"____,___.00")# 
			</td>
				<cfset TotalJCDelTax=TotalJCDelTax+#numberformat(DeliveryTax,"____,___.00")# >
				<cfset SubTotalArray[store_index][12]=TotalJCDelTax>
				<cfset value_index=value_index+1>
			<td>
				<Cfset JCGoodsTax = JCGST - #numberformat(DeliveryTax,"____,___.00")#  - TubsTax >
				#numberformat(JCGoodsTax,"_____,__.00")# 
			</td>
				<cfset TotalJCGoodsTax=TotalJCGoodsTax+JCGoodsTax>
				<cfset SubTotalArray[store_index][13]=TotalJCGoodsTax>
				<cfset value_index=value_index+1>
			<td>
				#numberformat(JCGST,"_____,__.00")# 
			</td>
				<cfset TotalJCTotalTax=TotalJCTotalTax+JCGST>
				<cfset SubTotalArray[store_index][14]=TotalJCTotalTax>
				<cfset value_index=value_index+1>
			<td>
				<cfset GSTVar = storeGST - JCGST>
				#numberformat(GSTVar,"_____,__.00")# 
			</td>
				<cfset TotalGSTVar = TotalGSTVar+GSTVar>
				<cfset SubTotalArray[store_index][15]=TotalGSTVar>
		</tr>
</cfoutput>

	<cfoutput>
		<tr align="right" bgcolor="black">
			<td colspan="2" align="center">
				Sub Total
			</td>
			<td width="70">
				#numberformat(TotalInvoiceAmt,"___,__.00")#
				<cfset GrandTotal[1] = GrandTotal[1]+TotalInvoiceAmt>
			</td>
			<td width="60">
				#numberformat(TotalScReb,"___,__.00")#
				<cfset GrandTotal[2] = GrandTotal[2]+TotalScReb>
			</td>
			<td width="80">
				#numberformat(TotalSupInvoice,"___,__.00")#
				<cfset GrandTotal[3] = GrandTotal[3]+TotalSupInvoice>
			</td>
			<td width="70">
				#numberformat(TotalJCReb,"___,__.00")#
				<cfset GrandTotal[4] = GrandTotal[4]+TotalJCReb>
			</td>
			<td width="60">
				#numberformat(TotalstoreGST,"___,__.00")#
				<cfset GrandTotal[5] = GrandTotal[5]+TotalstoreGST>
			</td>
			<td width="70">
				#numberformat(TotalstInvGood,"___,__.00")#
				<cfset GrandTotal[6] = GrandTotal[6]+TotalstInvGood>
			</td>
			<td width="70">
				#numberformat(TotalSCSTubs,"___,__.00")#
				<cfset GrandTotal[7] = GrandTotal[7]+TotalSCSTubs>
			</td>
			<td width="60">
				#numberformat(TotalSFMTubs,"___,__.00")#
				<cfset GrandTotal[8] = GrandTotal[8]+TotalSFMTubs>
			</td>
			<td width="50">
				#numberformat(TotalDeliveryEx,"___,__.00")#
				<cfset GrandTotal[9] = GrandTotal[9]+TotalDeliveryEx>
			</td>
			<td width="70">
				#numberformat(TotalStInvGoodNet,"___,__.00")#
				<cfset GrandTotal[10] = GrandTotal[10]+TotalStInvGoodNet>
			</td>
			<td width="50">
				#numberformat(TotalJCTubsTax,"___,__.00")#
				<cfset GrandTotal[11] = GrandTotal[11]+TotalJCTubsTax>
			</td>
			<td width="50">
				#numberformat(TotalJCDelTax,"___,__.00")#
				<cfset GrandTotal[12] = GrandTotal[12]+TotalJCDelTax>
			</td>
			<td width="50">
				#numberformat(TotalJCGoodsTax,"___,__.00")#
				<cfset GrandTotal[13] = GrandTotal[13]+TotalJCGoodsTax>
			</td>
			<td width="60">
				#numberformat(TotalJCTotalTax,"___,__.00")#
				<cfset GrandTotal[14] = GrandTotal[14]+TotalJCTotalTax>
			</td>
			<td width="30" >
				#numberformat(TotalGSTVar,"___,__.00")#
				<cfset GrandTotal[15] = GrandTotal[15]+TotalGSTVar>
			</td>
		</tr>
	</table>
	</cfoutput>
	<cfoutput>
	<br><table width="100%" border="0">
		<tr>
			<td align="center">
				<h3>Invoice Summary Store Totals</h3>
			</td>
		</tr>
		<tr>
			<td align="center">
	  <h3>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and 	
	  					#mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h3>
			</td>
		</tr>
	</table>
	 <table width="1000" border="1">
		<tr align="center">
			<td colspan="2">Store Name</td>
			<td width="70">Store Inv Amt</td>
			<td width="60">SC Reb</td>
			<td width="80">JC Inv</td>
			<td width="70">JC Reb</td>
			<td width="60">GST on SC Inv</td>
			<td width="70">Store Inv Good Total</td>
			<td width="70">SCS Tubs Ex GST</td>
			<td width="60">SFM Tubs Ex GST</td>
			<td width="60">Delivery Charge Ex GST</td>
			<td width="50">Store Inv Good Total Net</td> 
			<td width="70">JC Tubs Tax</td>
			<td width="50">JC Del Tax</td>
			<td width="50">JC Goods Tax</td>
			<td width="60">JC Total Tax</td>
			<td width="30">GST Var</td>
		</tr>
		<cfloop index="i" from="1" to="#store_index#" step="1">
			<tr align="right">
			<td colspan="2" align="center">#StoreArray[i]#</td>
				
			<cfloop index="j" from="1" to="15" step="1">
				
				<td>
					 #numberformat(SubTotalArray[i][j],"___,__.00")#  
				</td>
				
			</cfloop>
		</cfloop>
		<tr align="right"></td>
			<td colspan="2" align="center">Grand Total </td>
			<cfloop index="i" from="1" to="#ArrayLen(GrandTotal)#" step="1">
			<td align="right">
				#numberformat(GrandTotal[i],"___,_______.00")#
			</td>
			</cfloop>
		</tr>
	</table>
	</cfoutput>



