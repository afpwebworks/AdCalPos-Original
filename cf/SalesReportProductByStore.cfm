<cfsilent>
<!----
==========================================================================================================
Filename:     SalesReportProductByStore.cfm
Description:  Sales Order Report for AdCalPos grouped by Products by Store
Date:         1/8/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
18/4/2010  Integrated with existing system.
3/8/2010  MK 

==========================================================================================================
--->
</cfsilent>
<!---[   Check for logged in and bounce out if not allowed entry   ]---->
<cfif session.logged Is not "yes">
	<cflocation url="/index.cfm" />
</cfif>
<cfset 	ReportEngine =  application.beanfactory.getBean("Reporting") />
<cfscript>
FromYear = left(url.fd, "4");
FromMonth = mid(url.fd,"5", "2");
FromDay = right(url.fd,"2");
ToYear = left(url.td, "4");
ToMonth = mid(url.td,"5", "2");
ToDay = right(url.td,"2");
Startdate = createdate( FromYear, FromMonth , FromDay );
Enddate = createdate( ToYear, ToMonth , ToDay );
StoreID = url.SID;
//initialise the totals struct
ProductTotals = ReportEngine.makeTotalStruct();
StoreTotals =  ReportEngine.makeTotalStruct();
Daytotals =  ReportEngine.makeTotalStruct();
Grandtotals = ReportEngine.makeTotalStruct();
</cfscript>
  
    
<cfif structKeyExists(url, "td" )>
<cfscript>
	ReportData = Reportengine.SalesProductsStores( Startdate, Enddate, StoreID );
	StoreDetail = Reportengine.getStores( storeID, session.employeeid, session.usertype ) ;
	//Initialise the triggers for subtotal changes
	Triggers = StructNew();
	Triggers.transdate = Startdate ;
	Triggers.ProductID  = ReportData.ProductID["1"];
	Triggers.Description  = ReportData.Description["1"];
	Triggers.storeID    = ReportData.storeID["1"];
	Triggers.terminalid = ReportData.terminalid["1"];
</cfscript>
</cfif>
<cfparam name="strPageTitle" default="Sales Report, Summary by Product and Store">
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="/css/adcalposnet.css">
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
<table width="90%">
  <tr valign="center"> 
    <td width><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center" width="*"> 
      <h1><cfoutput>#strPageTitle# <br />for dates included #dateformat(Startdate, "d / mmm / yyyy")# to #dateformat(Enddate, "d / mmm / yyyy")#</h1> </CFOUTPUT>
	  
	  <cfif isDefined("StoreDetail.recordCount")>
								 
				 <CFIF listfindNoCase(StoreID, "all")> All Stores
				 <CFELSE>				 
					<cfif StoreDetail.recordCount GT 1> 
						<p><cfloop query="StoreDetail">
								<cfoutput>#StoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#StoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td> 
	  <cfoutput>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#url.FD#&TD=#url.TD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
</table>
<cfif isdefined("Reportdata")>
<div id="report">
<table>
  <tr>
    <th>Store</th>
    <th>Product</th>
    <th>Gross</th>
    <th>Discount</th>
    <th>Surcharge</th>
    <th>Net</th>
    <th>Cost</th>
    <th>Profit</th>
  </tr>
 <cfoutput>
 <cfloop query="ReportData">
 
<!---[   If the productid is different to the trigger productid its time to print a subtotal for the media type.    ]---->
<cfif (ReportData.storeid neq Triggers.storeid) and (reportdata.currentrow GT 1)>  
<!---[   Print a subtotal for the product   ]---->
<tr class="lite">
	<td align="left" >#ReportEngine.getStoreName( Triggers.storeID )#</td>
    <td align="left">[#triggers.ProductID# ] - #Triggers.Description#</td>
    <td align="right">#dollarformat(ProductTotals.salesgross)#</td>
    <td align="right">#dollarformat(ProductTotals.salesdiscount)#</td>
    <td align="right">#dollarformat(ProductTotals.salessurcharge)#</td>
    <td align="right">#dollarformat(ProductTotals.salesnet)#</td>
    <td align="right">#dollarformat(ProductTotals.SalesCost)#</td>
    <td align="right">#dollarformat(ProductTotals.gp)#</td>
  </tr>  
           
 <tr class="subtotal">
    <td colspan="2" align="right">Subtotal for #ReportEngine.getStoreName( Triggers.storeID )#</td>
    <td align="right">#dollarformat(storetotals.salesgross)#</td>
    <td align="right">#dollarformat(storetotals.salesdiscount)#</td>
    <td align="right">#dollarformat(storetotals.salessurcharge)#</td>
    <td align="right">#dollarformat(storetotals.salesnet)#</td>
    <td align="right">#dollarformat(storetotals.SalesCost)#</td>
    <td align="right">#dollarformat(storetotals.gp)#</td>
  </tr>  
  <!---[    Now reset the totals for the store and product  ]---->
  <cfset ProductTotals = ReportEngine.makeTotalStruct()  /> 
  <cfset storetotals = ReportEngine.makeTotalStruct()  /> 
    
<cfelseif (ReportData.productid neq Triggers.productid) and (reportdata.currentrow GT 1)> 
<!---[   Print a subtotal for the product   ]---->
<tr class="lite">
    <td align="left" >#ReportEngine.getStoreName( Triggers.storeID )#</td>
    <td align="left">[#triggers.ProductID# ] - #Triggers.Description#</td>
    <td align="right">#dollarformat(ProductTotals.salesgross)#</td>
    <td align="right">#dollarformat(ProductTotals.salesdiscount)#</td>
    <td align="right">#dollarformat(ProductTotals.salessurcharge)#</td>
    <td align="right">#dollarformat(ProductTotals.salesnet)#</td>
    <td align="right">#dollarformat(ProductTotals.SalesCost)#</td>
    <td align="right">#dollarformat(ProductTotals.gp)#</td>
  </tr>  
   <!---[    Now reset the totals for the product   ]---->
<cfset ProductTotals = ReportEngine.makeTotalStruct()  />  
</cfif>  
<cfsilent>
<cfscript> 
 ProductTotals=ReportEngine.UpdateTotalStruct( ProductTotals, ReportData, ReportData.currentrow  );
 StoreTotals  = ReportEngine.UpdateTotalStruct( StoreTotals, ReportData, ReportData.currentrow  ) ;
 DayTotals    = ReportEngine.UpdateTotalStruct( DayTotals, ReportData, ReportData.currentrow  ) ;
 Grandtotals  = ReportEngine.UpdateTotalStruct( Grandtotals, ReportData, ReportData.currentrow  ) ;
 </cfscript> 

<!---[     Otherwise print a regular line   ]---->
 <!---[   <tr class="lite">
    <td>[#reportdata.currentrow#] #dateformat(ReportData.TransDate, "d/mmm/yyyy")#</td>
    <td align="center">[ #ReportData.storeID# ]#ReportEngine.getStoreName( ReportData.storeID )#</td>
<!---[       <td align="center">#ReportData.locationID#</td>
    <td align="center">#ReportData.terminalid#</td>   ]---->
    <td align="left">[ #ReportData.ProductID# ] - #ReportData.Description#</td>
    <td align="right">#dollarformat(ProductTotals.salesgross)#</td>
    <td align="right">#dollarformat(ProductTotals.salesdiscount)#</td>
    <td align="right">#dollarformat(ProductTotals.salessurcharge)#</td>
    <td align="right">#dollarformat(ProductTotals.salesnet)#</td>
    <td align="right">#dollarformat(ProductTotals.SalesCost)#</td>
    <td align="right">#dollarformat(ProductTotals.gp)# </td>
    <!---[   <td><cfdump var="#StoreTotals#"></td>   ]---->
  </tr>   ]---->

<cfscript>
      Triggers.transdate  =  ReportData.Transdate ;
      Triggers.ProductID  =  ReportData.ProductID  ;
	  Triggers.Description=  ReportData.Description  ;
      Triggers.StoreID    =  ReportData.StoreID ; 
      Triggers.terminalid =  ReportData.terminalid ;
	  
   </cfscript>  
 </cfsilent>    
</cfloop>
<!---[   Print a subtotal for the last product   ]---->  
<tr class="lite">
    <td align="left" ><cfif len(triggers.storeid) and IsNumeric(triggers.storeid)>#ReportEngine.getStoreName( Triggers.storeID )#<cfelse>Subtotal</cfif></td>
    <td align="left">[#triggers.ProductID# ] - #triggers.Description#</td>
    <td align="right">#dollarformat(ProductTotals.salesgross)#</td>
    <td align="right">#dollarformat(ProductTotals.salesdiscount)#</td>
    <td align="right">#dollarformat(ProductTotals.salessurcharge)#</td>
    <td align="right">#dollarformat(ProductTotals.salesnet)#</td>
    <td align="right">#dollarformat(ProductTotals.SalesCost)#</td>
    <td align="right">#dollarformat(ProductTotals.gp)#</td>
  </tr>  
<!---[   Print a subtotal for the last store   ]---->           
<tr class="subtotal">
    <td colspan="2" align="right"><cfif len(triggers.storeid) and IsNumeric(triggers.storeid)>Subtotal for #ReportEngine.getStoreName( triggers.storeID )#<cfelse>Subtotal</cfif></td>
    <td align="right">#dollarformat(storetotals.salesgross)#</td>
    <td align="right">#dollarformat(storetotals.salesdiscount)#</td>
    <td align="right">#dollarformat(storetotals.salessurcharge)#</td>
    <td align="right">#dollarformat(storetotals.salesnet)#</td>
    <td align="right">#dollarformat(storetotals.SalesCost)#</td>
    <td align="right">#dollarformat(storetotals.gp)#</td>
  </tr>  
<!---[   Print the grand total for the report   ]---->
 <tr class="grandtotal">
    <th colspan="2" align="right" >Total for this report: </th>
    <th align="right">#dollarformat(Grandtotals.salesgross)#</th>
    <th align="right">#dollarformat(Grandtotals.salesdiscount)#</th>
    <th align="right">#dollarformat(Grandtotals.salessurcharge)#</th>
    <th align="right">#dollarformat(Grandtotals.salesnet)#</th>
    <th align="right">#dollarformat(Grandtotals.SalesCost)#</th>
    <th align="right">#dollarformat(Grandtotals.gp)#</th>
  </tr> 
 </cfoutput>
 </table>
</div>
</cfif>
</body>
</html>