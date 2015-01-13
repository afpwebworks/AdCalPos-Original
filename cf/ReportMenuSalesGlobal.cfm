
   	<cfset local.formname = "PLU Sales Global ( Store/Dept)">
	<cfset thisTotalArray = ArrayNew(1)>
	<cfset valueArray = ArrayNew(1)>
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>
	<cfset DateFrom = #CREATEDATE(mid(lngFD,1,4),mid(lngFD,5,2),mid(lngFD,7,2))#>
	<cfset DateTo = #CREATEDATE(mid(lngTD,1,4),mid(lngTD,5,2),mid(lngTD,7,2))#>	
	<CFSET datesListYYYYMMDD = "">
	<CFLOOP from="#dateFrom#" to="#dateTo#" index="loop">
	 <CFSET datesListYYYYMMDD = listAppend(datesListYYYYMMDD,"'" & #dateFormat(loop,"YYYYMMDD")# & "'")>
	</cfloop>
	<cfset strQuery = "SELECT  c.storeID, e.storeName,a.DeptNo,  d.dept ">
	<cfset strQuery = strQuery & ", sum(c.Quantity) as ssQuantity ">  
		<cfset strQuery = strQuery & ", sum(c.TotalKg) as ssTotalKg "> 
		<cfset strQuery = strQuery & ", sum(c.TotalD) as ssTotalD  ">
		<cfset strQuery = strQuery & "FROM tblStockGroup a ">
		<cfset strQuery = strQuery & ",tblStockMaster b    ">
		<cfset strQuery = strQuery & ",tblStore_PLUTotals c  "> 
		<cfset strQuery = strQuery & ",tblStockDept d ">
		<cfset strQuery = strQuery & ",tblStores e ">
		<cfset strQuery = strQuery & "where a.groupNo = b.groupNo           ">
		<cfset strQuery = strQuery & "   and b.PartNo = CONVERT(varchar(20), c.PLUNumber)           ">									
		<cfset strQuery = strQuery & "   and c.Date in (#datesListYYYYMMDD#)">
		<cfset strQuery = strQuery & "    and a.deptNo = d.deptNo          ">
		<cfif lngStoreID is not "all"> 
			<cfset strQuery = strQuery & "  and c.storeID IN(#lngStoreID#)  ">
		</cfif>
		<cfset strQuery = strQuery & "  and c.storeID = e.StoreID  ">
		<cfset strQuery = strQuery & "  GROUP BY  c.storeID,  a.DeptNo,e.storeName,  d.dept         ">
		<cfset strQuery = strQuery & " Order by  e.storeName,a.deptNo          ">
	<CFQUERY name="GetData" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >#PreserveSingleQuotes(strQuery)#
	</CFQUERY>	
	<CFSET thisStoreID=0>
	<CFSET storesInRow=0>
	<CFSET thisTotal=0>			
	<CFSET index = 1>
	<cfset thisStoreName = " ">
	<cfset valueArray[index] = 0>
	  <CFLOOP QUERY ="GETDATA">
		  <CFIF thisStoreID is not StoreID  and thisStoreID NEQ 0 > 			
 		<cfset index=index+1> 
			<cfset valueArray[index] = 0>
		</cfif>
	 	<cfset valueArray[index] = valueArray[index] + #ssTotalD# >
		<CFSET thisStoreID=storeID> 
	 </cfloop>
	<cfset strPageTitle = "Plu Sales Report">
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
	<TABLE border="0" width="90%" align="CENTER">
	  <TR>
	  	<TD valign="TOP">
		<CFSET thisStoreID=0>
		<CFSET storesInRow=0>
		<cfset rowCount = 1>
		<CFOUTPUT query="getData">
		  <CFIF thisStoreID is not StoreID >  
			   <CFIF getData.currentRow gt 1>
				   <TR>
				   		<TD colspan="3"><HR size="1" width="100%"></td>
					</tr>
 					
				    <TR>
						<TD><b>Grand Total</b></td><TD><b>#numberformat(valueArray[rowcount],"_______.00")#</b></td>
					</tr> 
					<CFSET thisTotal=0>	
					<cfset rowcount=rowcount+1>
	</TABLE>
				      </TD>
			   </cfif>	   
			<CFIF storesInRow mod 3 is 0></TR>
			   <TR>
			   </cfif>			   
			   <CFSET storesInRow=storesInRow+1>
			   <TD valign="TOP" align="LEFT"><br><br>
			    <TABLE border="1" class="reportData" align="CENTER" cellpadding="4">
			      <TR><td colspan="4" align="CENTER"><b>#StoreName#</b></td></tr>
	  			  <TR>
				  	<TD><b>Department</b></td>
				    <td><b>Value</b></td>
					<td><b>% to StoreTotal</b></td>
				</tr>
		</cfif>   
			<TR>
				<TD>
				<a href ="ReportMenuDept.cfm?DN=#GetData.DeptNo#&SID=#StoreID#&FD=#lngFD#&TD=#lngTD#">
					<h4>#Dept#</h4>
				</a>
				</TD>
			    <td align="RIGHT">
					#numberformat(ssTotalD,"_______.00")#
				</td>

				<td align="right">
						#numberformat(100*ssTotalD/valueArray[rowcount],"_______.00")#  
				</td>
				
				 <CFSET thisStoreID=storeID> 
			</TR>
		</cfoutput>
		<cfoutput>
		   <TR>
		   		<TD colspan="3"><HR size="1" width="100%"></td>
			</tr>
		    <TR>
				<TD><b>Grand Total</b></td><TD><b>#numberformat(valueArray[rowcount],"_______.00")#</b></td>
			</tr> 
		</cfoutput>
		</TABLE>
	  </td></tr> 	
	</table>
</body>
</HTML>

