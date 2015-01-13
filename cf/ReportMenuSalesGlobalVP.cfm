
<!--- lm spec 20040305
a loop is required prior to printing which creates an array of "grand totals" for each store. These values are then to 
be used to calculate the % each department line is of the grand total for that store.
e.g. Birkenhead Point
	dept 1 total = $1250.00   % = 100 * 1250/6500 = 19.23
	dept 2 total = $ 900.00   % = 100 *  900/6500 = 13.85
	dept 3 total = $4000.00   % = 100 * 4000/6500 = 61.54
	dept 7 total = $ 350.00   % = 100 *  350/6500 =  5.38
	Grand Total  = $6500.00
--->
	
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
	<cfset strQuery = "SELECT c.StoreID, a.DeptNo, e.storeName, d.dept ">
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
		<cfset strQuery = strQuery & "  and c.storeID = e.StoreID         ">
		<cfset strQuery = strQuery & "  GROUP BY c.StoreID, a.DeptNo, e.storeName, d.dept         ">
		<cfset strQuery = strQuery & " Order by e.storeName, a.deptNo          ">
	<CFQUERY name="GetData" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>	
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
	  <h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
<!--- lm spec 20040305
maybe the gt calculation loop can go in here. 
Simply a new query on the query "getData" for the current storeid --->

						</cfloop></p>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
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
		<CFSET thisStoreID="">
		<CFSET storesInRow=0>
		<CFSET thisTotal=0>			
		<cfset rowCount = 0>
		<cfset depCount = 0>
		
		<CFOUTPUT query="getData">
		    <CFIF thisStoreID is not storeID and thisStoreID is not "">
			
			   <CFIF getData.currentRow gt 1>
				   <TR>
				   		<TD colspan="2"><HR size="1" width="100%"></td>
					</tr>
<!--- lm spec 20040305
the data for this next line's variable is to be taken from a pre-calculated array rather than 
from a dynamic variable calculated as it prints.
			    <TR><TD><b>Grand Total</b></td><TD><b>#numberformat(thisTotal[for thisStoreID],"_______.00")#</b></td></tr>
				then <CFSET thisTotal=thisTotal[for StoreID]>				
Alternatively <cfset thisTotal = thisTotal[for thisStoreID] at the appropriate time				
 --->			 
 					<cfset rowcount=rowcount+1> 
				    <TR>
						<TD><b>Grand Total</b></td><TD><b>#numberformat(thisTotal,"_______.00")#</b></td>
						
					</tr> 
					<cfset thisTotalArray[rowcount]=#numberformat(thisTotal,"_______.00")#>
					<!--- A#rowcount#
					GrandArray[#rowcount#]#thisTotalArray[rowcount]# --->
					<CFSET thisTotal=0>				
	</TABLE>
				      </TD>
			   </cfif>	   
			<CFIF storesInRow mod 3 is 0></TR>
			   <TR>
			   </cfif>			   
			   <CFSET storesInRow=storesInRow+1>
			   <TD valign="TOP" align="LEFT"><br><br>
			    <TABLE border="1" class="reportData" align="CENTER" cellpadding="4">
			      <TR><td colspan="4" align="CENTER"><b>#storeName#</b></td></tr>
	  			  <TR>
				  	<TD><b>Department</b></td>
				    <td><b>Value</b></td>
					<td><b>Percentage</b></td>
				</tr>
		</cfif>   
			<TR>
				<TD>
					#Dept#
					
				</td>
			
				<!--- <td>#numberformat(ssQuantity,"_______.00")#</td>
				<td>#numberformat(ssTotalKg,"_______.00")#</td> --->
			    <td align="RIGHT">
					#numberformat(ssTotalD,"_______.00")#
					<cfset depcount = depCount+1>
					<cfset valueArray[depCount] = #numberformat(ssTotalD,"_______.00")#>
				</td>
				
				<td align="right">
						
					<cfif #numberformat(thisTotal,"_______.00")# NEQ "0"> 
						#numberformat(valueArray[depCount]/thisTotal,"_______.0")# 
					
					 </cfif> 
				</td>
				
				
<!--- lm spec 20040305
% to gt calc is to use the relevant array value 
			    <td align="RIGHT">#numberformat(100*ssTotalD/thisTotal[for thisStoreID],"_______.00")#</td>
--->				
			</tr>
			<!--- valueArray[#depCount#]#valueArray[depCount]# --->
			
			
<!--- lm spec 20040305
this next line needs to be deleted as it will be calculated and put into an array prior to printing the department line. --->
				<CFSET thisTotal=thisTotal + ssTotalD>
			<CFSET thisStoreID=storeID>
			
		</cfoutput>
		<cfoutput>
				<TR>
					<TD><b>Grand Total</b></td><TD><b>#numberformat(thisTotal,"_______.00")#</b></td>
					<cfset rowcount=rowcount+1>
				</tr> 
				<cfset thisTotalArray[rowcount]=#numberformat(thisTotal,"_______.00")#>
					<!--- A#rowcount#
					GrandArray[#rowcount#]#thisTotalArray[rowcount]# --->
		</cfoutput>
		</TABLE>
	  </td></tr> 	
	</table>
</body>
</HTML>

