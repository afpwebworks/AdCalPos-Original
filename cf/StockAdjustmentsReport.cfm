
<cfsetting enablecfoutputonly="Yes">
<!--- - wb 22/03/2004 - setup dates - --->
 <cfset local.startDate=createDate(left(url.FD,4),mid(url.FD,5,2),mid(url.FD,7,2))>
<cfset local.endDate=createDate(left(url.TD,4),mid(url.TD,5,2),mid(url.TD,7,2))>
<cfset lngFD = #URL.FD#>
<cfset lngTD = #URL.TD#>
<cfset local.form = "Stock Adjustments Report">
<!--- - wb 25/03/2004 - set count - --->
<cfset local.count=1>
<!--- - 25/03/2004 - get store names - --->
<!--- <cfquery name="qGetStoreNames" datasource="#application.dsn#"   > --->
<cfquery name="qGetStoreNames" datasource="#application.dsn#"   >
SELECT StoreName
FROM tblStores
<cfif NOT listContains(url.SID,"all",",")>
WHERE
	<cfloop list="#url.SID#" index="i" delimiters=",">
		StoreID=#i#
		<cfif local.count LT listLen(url.SID,",")> 
			OR 
		</cfif>
			
		<cfset local.count=local.count+1>
	</cfloop>
</cfif>
order by StoreID
</cfquery>
<!--- - wb 25/03/2004 - reset count - --->
<cfset local.count=1>
<!--- - wb 22/03/2004 - get records - --->

<!--- <cfquery name="qGetRecords" datasource="#application.dsn#"   > --->
<cfset strQuery ="SELECT stl.DateEntered, stl.EmployeeID, emp.Surname, emp.GivenName, ">
<cfset strQuery =strQuery & " stl.PartNo, sm.Description, stl.B4_Prev_QtyOnhand, "> 
<cfset strQuery =strQuery & " stl.AF_QtyOnHand, stl.storeid, ste.ErrorDesc ">
<cfset strQuery =strQuery & " FROM tblStockTakeLog stl, tblEmployee emp, ">
<cfset strQuery =strQuery & " tblStockMaster sm, tblStockTakeErrors ste  ">
<cfset strQuery =strQuery & " WHERE (10000 * { fn YEAR(stl.DateEntered) } + 100 * { fn MONTH(stl.DateEntered) } + day(stl.DateEntered) BETWEEN #lngFD# AND #lngTD# ) ">
<cfset strQuery =strQuery & " AND stl.EmployeeID=emp.EmployeeID ">
<cfset strQuery =strQuery & " AND stl.ReasonCode=ste.ErrorID AND stl.PartNo=sm.PartNo "> 
<cfif NOT listContains(url.SID,"all",",")>  
	<cfset strQuery =strQuery & "AND (">
	<cfloop list="#url.SID#" index="i" delimiters=","> 
	<cfset strQuery =strQuery & " stl.StoreID=#i#">
	<cfif local.count LT listLen(url.SID,",")> 
		<cfset strQuery =strQuery & " OR ">
	</cfif>
	<cfset local.count=local.count+1></cfloop>
	<cfset strQuery =strQuery & " )">
</cfif>
<cfset strQuery =strQuery & " order by  stl.StoreID, stl.DateEntered ">

<cfquery name="qGetRecords" datasource="#application.dsn#"   >
#PreserveSingleQuotes(strQuery)#
</cfquery>
<!--- - wb 22/03/2004 - setup the page title - --->
<cfset local.pageTitle="Stock Adjustment Reasons">
<cfsetting enablecfoutputonly="No">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><cfoutput>#local.pageTitle#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
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
</head>

<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"><strong><cfif listContains(url.SID,"all",",")>
		All
	<cfelse>
		<!--- - wb 25/03/2004 - reset count - --->
		<cfset local.count=1>
		<cfloop query="qGetStoreNames">
			<cfoutput>#qGetStoreNames.StoreName#</cfoutput>
			<cfif local.count LT qGetStoreNames.recordCount>
				&amp;
			</cfif>	
			<cfset local.count=local.count+1>
		</cfloop>
	</cfif>
	<cfoutput>#local.pageTitle#</cfoutput><br />
	Between <cfoutput>#dateFormat(local.startDate,"dd/mm/yyyy")#</cfoutput> and <cfoutput>#dateFormat(local.endDate,"dd/mm/yyyy")#</cfoutput></strong></td>
    <td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>

<cfset currentStoreID = 0>
<cfif qGetRecords.recordCount GT 0>

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
			
		<tr>
			<td>&nbsp;<strong>Date</strong></td>
			<td><strong>Emp ID</strong></td>
			<td><strong>Employee</strong></td>
			<td><strong>PLU No</strong></td>
			<td><strong>Description</strong></td>
			<td align="right"><strong>Qty Before</strong></td>
			<td align="right"><strong>Qty After</strong></td>
			<td align="right"><strong>Variance</strong></td>
			<td><img src="../images/s.gif" width="10" height="1" alt="Spacer" border="0" />
			<strong>Reason</strong>&nbsp;</td>
		</tr>
		<cfloop query="qGetRecords">
		
			<cfset local.variance=qGetRecords.AF_QtyOnHand-qGetRecords.B4_Prev_QtyOnhand>
			<tr>
				<cfif currentStoreID neq #qGetRecords.StoreID#>
				<cfinclude template="GetStoreName.cfm">
					<tr>
					<tr><td>&nbsp;</td></tr>
						<td>
						<!--- <cfoutput>
							Store  #StoreID#        
						</cfoutput> --->
						
						<cfoutput>
							#rs1.StoreName#       
						</cfoutput>
						
						</td>
						<cfset currentStoreID = #qGetRecords.StoreID#>
					</tr>	
		 		</cfif>
				<td>&nbsp;<cfoutput>#dateFormat(qGetRecords.DateEntered,"dd/mm/yyyy")#</cfoutput></td>
				<td><cfoutput>#qGetRecords.EmployeeID#</cfoutput></td>
				<td><cfoutput>#qGetRecords.GivenName#</cfoutput> <cfoutput>#qGetRecords.Surname#</cfoutput></td>
				<td><cfoutput>#qGetRecords.PartNo#</cfoutput></td>
				<td><cfoutput>#qGetRecords.Description#</cfoutput></td>
				<td align="right"><cfoutput>#numberFormat(qGetRecords.B4_Prev_QtyOnhand,"_________.000")#</cfoutput></td>
				<td align="right"><cfoutput>#numberFormat(qGetRecords.AF_QtyOnHand,"_________.000")#</cfoutput></td>
				<td align="right"><cfoutput>#numberFormat(local.variance,"_________.000")#</cfoutput></td>
				<td><img src="../images/s.gif" width="10" height="1" alt="Spacer" border="0" /><cfoutput>#qGetRecords.ErrorDesc#</cfoutput>&nbsp;</td>
			</tr>
		</cfloop>	
	</table>
<cfelse>
	<div align="center"><strong>Sorry, no results available</strong></div>
</cfif>
</body>
</html>
