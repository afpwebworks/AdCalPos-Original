
	<cfset strPageTitle = "Department Drill Down">
	<cfset strDeptNo = #URL.DN#>
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>
	<!--- <cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'> --->
	<cfset DateFrom = #CREATEDATE(mid(lngFD,1,4),mid(lngFD,5,2),mid(lngFD,7,2))#>
	<cfset DateTo = #CREATEDATE(mid(lngTD,1,4),mid(lngTD,5,2),mid(lngTD,7,2))#>	
	<CFSET datesListYYYYMMDD = "">
	<CFLOOP from="#dateFrom#" to="#dateTo#" index="loop">
	      <CFSET datesListYYYYMMDD = listAppend(datesListYYYYMMDD,"'" & #dateFormat(loop,"YYYYMMDD")# & "'")>
	</cfloop>
	<cfset strQuery="SELECT StoreName FROM tblStores ">
	<cfset strQuery= strQuery & " WHERE StoreID = #lngStoreID# ">
	<CFQUERY name="GetData" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "SELECT  c.PLUNumber as PartNo, b.description as Description, c.storeID, a.DeptNo,  d.dept ">
	<cfset strQuery = strQuery & ", sum(c.Quantity) as Quantity ">  
		<cfset strQuery = strQuery & ", sum(c.TotalKg) as TotalKg "> 
		<cfset strQuery = strQuery & ", sum(c.TotalD) as Value  ">
		<cfset strQuery = strQuery & "FROM tblStockGroup a ">
		<cfset strQuery = strQuery & ",tblStockMaster b    ">
		<cfset strQuery = strQuery & ",tblStore_PLUTotals c  "> 
		<cfset strQuery = strQuery & ",tblStockDept d ">
		<cfset strQuery = strQuery & ",tblStores e ">
		<cfset strQuery = strQuery & "where a.groupNo = b.groupNo   ">
		<cfset strQuery = strQuery & "   and b.PartNo = CONVERT(varchar(20), c.PLUNumber)   ">
		<cfset strQuery = strQuery & "   and a.deptno = #DN# ">									
		<cfset strQuery = strQuery & "   and c.Date in (#datesListYYYYMMDD#)">
		<cfset strQuery = strQuery & "    and a.deptNo = d.deptNo   ">
		<cfif lngStoreID is not "all"> 
			<cfset strQuery = strQuery & "  and c.storeID IN(#lngStoreID#)  ">
		</cfif>
		<cfset strQuery = strQuery & "  and c.storeID = e.StoreID  ">
		<cfset strQuery = strQuery & " GROUP BY b.description, c.PLUNumber, c.storeID, a.DeptNo, d.dept ">
		<cfset strQuery = strQuery & " ORDER BY b.description, c.PLUNumber  ">
			
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
<table width="100%">
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"> 
<!---       <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT> --->

      <h1><cfoutput>#GetData.StoreName#</h1> </CFOUTPUT>
      <br>
	  <h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and 	
	  					#mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
	
    </td> 
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenuSalesGlobal.cfm?FD=#lngFD#&TD=#lngTD#&SID=#lngStoreID#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>  
</table>
	
	<CFQUERY name="GetData" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >#PreserveSingleQuotes(strQuery)#
	</CFQUERY>	
	<cfset totalQty = 0>
	<cfset totalQtykg = 0>
	<cfset totalValue = 0>
	<table border="1" width="50%" align="center">
		<tr>
			<td align="center">
				PLU Number
			</td>
			<td align="center">
				Description
			</td>
			<td align="center">
				Quantity
			</td>
			<td align="center">
				kg
			</td>
			<td align="center">
				Value ($)
			</td>
		</tr>
		<cfoutput query="GetData">
			<tr>
				<td align="center">
					#PartNo#
				</td>
				<td>
					#Description#
				</td>
				<td align="right">
					#numberformat(Quantity,"_______")#
				</td>
				<td align="right">
					#numberformat(TotalKg,"_______.000")#
				</td>
				<td align="right">
					#numberformat(Value,"_______.00")#
				</td>
			</tr>
			<cfset totalQty=totalQty+Quantity>			
			<cfset totalQtykg=totalQtyKg+totalKg>
			<cfset totalValue=totalValue+Value>
	</cfoutput>
	<cfoutput>
	<tr>
		<td colspan="2" >
			<b>Sub Total</b>
		</td>
		<td align="right">
		#numberformat(totalQty,"_______")#
		</td>
		<td align="right">
		#numberformat(totalQtyKg,"_______.000")#
		</td>
		<td  align="right">
		#numberformat(totalValue,"_______.00")#
		</td>
	</tr>
	</cfoutput>
	</table>
	
	
