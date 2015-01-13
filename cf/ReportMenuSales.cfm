<cfsetting showdebugoutput="yes" />
	<!--- <cfset lngStoreID = #URL.SID#> --->
	<cfset lngPC = 1>
	<cfset local.formname = "PLU Sales">
	<cfset lngStoreID = #URL.SID#>
	<cfset lngFD = #URL.FD#>
	<cfset lngTD = #URL.TD#>
	<cfset lngPC = #URL.pcod#>
	<cfset strPageTitle = #local.formname#>    
	<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
	<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	
			
	<CFQUERY name="GetStoreDetail" datasource="#application.dsn#"  >SELECT *
	FROM tblStores where 1=1
		<CFIF lngStoreID is not "all">
			  and storeID in (#lngStoreID#) 
		</cfif>
	</CFQUERY>

<cfstoredproc procedure = "procReportMenuSales" datasource="#application.dsn#"  >
	<cfprocresult name = "GetWholesale"  > 
	<cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR value="'#lngFD#'" dbVarName = @startlngdate>
	 <cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR value="'#lngTD#'" dbVarName = @endlngdate>
	 <cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR value="#lngStoreID#" dbVarName = @storeid>
	 <cfprocparam type = "IN" CFSQLType = CF_SQL_INTEGER value="#lngPC#" dbVarName = @PC>

</cfstoredproc>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
 <table width="100%">
  <tr valign="center"> 
    <td width="25%"><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
	  
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
</table>
<br>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="80%" border="1" cellspacing="0">
<cfset GrandTotal = 0>
              <tr> 
    	        <td colspan="7"><h3><b>Department</b></h3></td>
        	  </tr>
			  <tr> 
	            <td><h4>Plu</h4></td>
	            <td><h4>Description</h4></td>
	            <td align="right"><h4>Qty</h4></td>
				<td align="right"><h4>COGS</h4></td> 
	           <!--- <td align="right"><h4>Total Wholesale</h4></td> --->
		        <td align="right"><h4>Total $ Sales</h4></td> 
	            <td align="right"><h4>Avg Sale Price</h4></td>
				<td align="right"><h4>GP%</h4></td>
				<!--- <td align="right"><h4>Max Retail</h4></td>---> 
				 		
	          </tr>
		
	 <cfset DeptTotal = 0>
 	<cfset CostTotal = 0>
	<cfset qtyTotal = 0>
	<cfset cogsTotal = 0>
	<cfset GrandTotal_COGS = 0 >
	 <cfset GrandTotal_Dollar = 0 >
	 <cfset GrandTotal_Wholesale = 0>
	<cfset check_currDept = 1>	 
	<cfset dep = #GetWholesale.dept#> 
	<CFLOOP QUERY = "GetWholesale">
		    <cfif check_currDept EQ 1>
		   		<cfset deptnum = #GetWholesale.deptNo#>		
				<cfset dep = #GetWholesale.dept#>		
				<cfset partnum = #GetWholesale.PartNo#>
				<cfset desc = #GetWholesale.Description#>
				<cfset tquantity= #GetWholesale.totalqty#>
				<cfset totalwholesale = #GetWholesale.Cost#>
				<cfset totalCOGS = #GetWholesale.COGS#>
				<cfset totaldollar = #GetWholesale.DollarSales#>
				<cfif tquantity NEQ 0>
						<cfset dblAveragePrice = (totaldollar/ tquantity )>  
					<cfelse>
						<cfset dblAveragePrice = totaldollar>
				</cfif>
				<cfoutput>
				<tr colspan="8"><td>#dep#</td></tr>
				<tr> 
	            		<td><h4>#partnum#&nbsp;</h4></td>
	            		<td><h4>#desc#&nbsp;</h4></td>
	            		<td><div align="right"><h4>#numberformat(tquantity,"________.000")#&nbsp;</h4></div></td>
				 		<!--- <td><div align="right"><h4>#numberformat(totalwholesale,"________.00")#&nbsp;</h4></div></td> --->
						<td><div align="right"><h4>#numberformat(GetWholesale.COGS,"________.00")#&nbsp;</h4></div>
						<td><div align="right"><h4>#numberformat(totaldollar,"________.00")#&nbsp;</h4></div></td>
						</td><td><div align="right"><h4>#numberformat(dblAveragePrice,"________.00")#&nbsp;</h4></div></td>
	              		<cfif totaldollar NEQ 0>
						<td><div align="right"><h4>#numberformat(((totaldollar-GetWholesale.COGS)/ totaldollar)*100,
							 "________.00")#&nbsp;</h4></div></td>
						</cfif>		
	          	</tr>
				</cfoutput> 
				<cfset DeptTotal = DeptTotal + totaldollar >
				<cfset CostTotal = CostTotal + totalwholesale>
				<cfset qtyTotal = qtyTotal + tquantity >
				<cfset cogsTotal = cogsTotal+totalCOGS>
				<cfset check_currDept = 0>
			<cfelse>
				<cfif deptnum is not #GetWholesale.deptNo#>
					 	<cfoutput>
							<tr>
								<td colspan="2">Sub Total #dep#</td>
								<td><div align="right"><h4>#numberformat(qtyTotal,"________.000")#&nbsp;</h4></div></td>
								<!--- <td><div align="right"><h4>#numberformat(CostTotal,"________.00")#&nbsp;</h4></div></td> --->
								<td><div align="right"><h4>#numberformat(cogsTotal,"________.00")#&nbsp;</h4></div></td>
								<td colspan="1"><div align="right"><h4>#numberformat(DeptTotal,"________.00")#&nbsp;</h4></div></td>
								<td>&nbsp;</td>
								<td colspan="1"><div align="right"><h4>#numberformat(((DeptTotal - cogsTotal)/DeptTotal)*100,"________.00")#&nbsp;</h4></div></td>
								<cfset deptnum = #GetWholesale.deptNo#>
								<cfset dep = #GetWholesale.dept#>
								<cfset count = 1>
						
							</tr>
						</cfoutput> 
					        <cfoutput><tr colspan="8"><td>#dep#</td></tr></cfoutput>
							<cfset GrandTotal_Dollar = GrandTotal_Dollar + #DeptTotal# >
							<cfset GrandTotal_Wholesale = GrandTotal_Wholesale + #CostTotal# >
							<cfset GrandTotal_COGS = GrandTotal_COGS + #cogsTotal#>
							<cfset DeptTotal = 0 >
			            	<cfset CostTotal = 0>
							<cfset qtyTotal = 0>
							<cfset cogsTotal = 0>
					 
				</cfif>
			<!--- 	<cfset tquantity= #GetWholesale.totalqty#>
				<cfset totalwholesale = #GetWholesale.Cost#>
				<cfset totaldollar = #GetWholesale.DollarSales#>
				<cfset DeptTotal = DeptTotal + totaldollar >
				<cfset CostTotal = CostTotal + totalwholesale>
				<cfset qtyTotal = qtyTotal + tquantity > --->
				
				<cfset deptnum = #GetWholesale.deptNo#>		
				<cfset dep = #GetWholesale.dept#>		
				<cfset partnum = #GetWholesale.PartNo#>
				<cfset desc = #GetWholesale.Description#>
				<cfset tquantity= #GetWholesale.totalqty#>
				<cfset totalwholesale = #GetWholesale.Cost#>
				<cfset totalCOGS = #GetWholesale.COGS#>
				<cfset totaldollar = #GetWholesale.DollarSales#>
					<cfset check_currDept = 0>
					<cfif tquantity NEQ 0>
						<cfset dblAveragePrice = (totaldollar/ tquantity )>  
					<cfelse>
						<cfset dblAveragePrice = totaldollar>
					</cfif>
					
					<cfset DeptTotal = DeptTotal + totaldollar >
					<cfset CostTotal = CostTotal + totalwholesale>
					<cfset qtyTotal = qtyTotal + tquantity >
					<cfset cogsTotal = cogsTotal + totalCOGS>
					<cfoutput>
					<tr> 
	            		<td><h4>#partnum#&nbsp;</h4></td>
	            		<td><h4>#desc#&nbsp;</h4></td>
	            		<td><div align="right"><h4>#numberformat(tquantity,"________.000")#&nbsp;</h4></div></td>
				 		<!--- <td><div align="right"><h4>#numberformat(totalwholesale,"________.00")#&nbsp;</h4></div></td> --->
						<td><div align="right"><h4>#numberformat(GetWholesale.COGS,"________.00")#&nbsp;</h4></div>
						<td><div align="right"><h4>#numberformat(totaldollar,"________.00")#&nbsp;</h4></div></td>
								<td><div align="right"><h4>#numberformat(dblAveragePrice,"________.00")#&nbsp;</h4></div></td>
	              		<cfif totaldollar NEQ 0>
							<td><div align="right"><h4>#numberformat(((totaldollar-GetWholesale.COGS)/ totaldollar)*100,
							 "________.00")#&nbsp;</h4></div></td>
						</cfif>		
	          		</tr>
					</cfoutput>
					<cfif deptnum is not #GetWholesale.deptNo#>
					 	<cfoutput>
							<tr>
								<td colspan="2">Sub Total #dep#</td>
								<td><div align="right"><h4>#numberformat(qtyTotal,"________.000")#&nbsp;</h4></div></td>
								<!--- <td><div align="right"><h4>#numberformat(CostTotal,"________.00")#&nbsp;</h4></div></td> --->
								<td><div align="right"><h4>#numberformat(cogsTotal,"________.00")#&nbsp;</h4></div></td>
								<td colspan="1"><div align="right"><h4>#numberformat(DeptTotal,"________.00")#&nbsp;</h4></div></td>
								<td>&nbsp;</td>
								<td colspan="1"><div align="right"><h4>#numberformat(((DeptTotal - cogsTotal)/DeptTotal)*100,"________.00")#&nbsp;</h4></div></td>
								<cfset deptnum = #GetWholesale.deptNo#>
								<cfset dep = #GetWholesale.dept#>
								<cfset count = 1>
						
							</tr>
						</cfoutput> 
					        <cfoutput><tr colspan="8"><td>#dep#</td></tr></cfoutput>
							<cfset GrandTotal_Dollar = GrandTotal_Dollar + #DeptTotal# >
							<cfset GrandTotal_Wholesale = GrandTotal_Wholesale + #CostTotal# >
							<cfset DeptTotal = 0 >
			            	<cfset CostTotal = 0>
							<cfset qtyTotal = 0>
							<cfset cogsTotal=0>
					 
					</cfif>
					<cfset deptnum = #GetWholesale.deptNo#>
					<cfset dep = #GetWholesale.dept#> 
					<cfset partnum = #GetWholesale.PartNo#>
					<cfset desc = #GetWholesale.Description#>
					<cfset totalwholesale = #GetWholesale.Cost#>
					<cfset totalCOGS = #GetWholesale.COGS#>
					<cfset totaldollar = #GetWholesale.DollarSales#>
					<cfset tquantity = #GetWholesale.totalqty#>
				
		   </cfif>
 	</CFLOOP>	
	 	<cfoutput>
		<tr>
						<td colspan="2">Sub Total #dep#</td>
						<td><div align="right"><h4>#numberformat(qtyTotal,"________.000")#&nbsp;</h4></div></td>
						<!--- <td><div align="right"><h4>#numberformat(CostTotal,"________.00")#&nbsp;</h4></div></td> --->
						<td><div align="right"><h4>#numberformat(cogsTotal,"________.00")#&nbsp;</h4></div></td>
						<td colspan="1"><div align="right"><h4>#numberformat(DeptTotal,"________.00")#&nbsp;</h4></div></td>
						<td>&nbsp;</td> 
						<cfif DeptTotal NEQ 0>
						<td colspan="1"><div align="right"><h4>#numberformat(((DeptTotal - cogsTotal)/DeptTotal)*100,"________.00")#&nbsp;</h4></div></td>
						
						</cfif>
						
						
					</tr>
		<tr>
				<cfset GrandTotal_Dollar = GrandTotal_Dollar + #DeptTotal# >
				<cfset GrandTotal_COGS = GrandTotal_COGS + #cogsTotal# >
				<td> Grand Total</td>
				<!--- <td colspan="3"><div align="right"><h4>#numberformat(GrandTotal_Wholesale,"________.00")#&nbsp;</h4></div></td> --->
				<td colspan="2"><div align="right">&nbsp;</div></td>
				<td colspan="1"><div align="right"><h4>#numberformat(GrandTotal_COGS,"________.00")#&nbsp;</h4></div></td>
			<td colspan="1"><div align="right"><h4>#numberformat(GrandTotal_Dollar,"________.00")#&nbsp;</h4></div></td>
			<td >&nbsp;</td>
			<cfif GrandTotal_Dollar NEQ 0>		
			<td colspan="1"><div align="right"><h4>#numberformat(((GrandTotal_Dollar - GrandTotal_COGS)/GrandTotal_Dollar)*100,"________.00")#&nbsp;</h4></div></td>
			</cfif>

			
		</tr>
	 </cfoutput>
        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>


