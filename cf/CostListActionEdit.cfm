
 <cfif ParameterExists(form.btnEdit_Cancel)>
	<cflocation URL = "CostListSelection.cfm">
	<cfabort>
</cfif>
<cfif ParameterExists(Form.btnEdit_OK)>
	<cfsetting enablecfoutputonly="Yes">
	<cfloop from="1" to="#form.txtNumLines#" index="i">
		<cfset local.plu=evaluate("form.txtID" & i)>
		<cfset local.cost=evaluate("form.txtCost" & i)>
		<cfset local.wholeSale=evaluate("form.txtWholeSale" & i)>
		 <cfset local.suporder=evaluate("form.suporder" & i)> 
		 <cfset local.oldMaxRetail = evaluate("form.txtMaxRetailOld" & i)>
		 <cfset local.maxRetail=evaluate("form.txtMaxRetail" & i)>
		 <cfset local.TypeID=evaluate("form.ID" & i)> 
		<!--- - wb 07/11/2003 - Get the RCodes for the 3H rebate and the SCS rebate --->
		<cfquery name="qGetRCode" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >SELECT DISTINCT master.PartNo, master.RCode, master.ThreeHRebate, master.SCRebate, 
						rebate.RebateCode, rebate.ThreeHRebate, rebate.SCRebate
		FROM tblStockMaster master, tblStockRebate rebate
		WHERE PartNo='#local.plu#' AND master.RCode=rebate.RebateCode
		</cfquery>
		
		<!--- - wb 07/11/2003 - Check the wholesale and cost values --->
		<cfif local.cost LT 0 AND (qGetRCode.RCode NEQ 6 OR qGetRCode.RCode IS "NULL")>
			<cfset local.cost=0>
		</cfif>
		
		<!---15/02/04 Vishal Removed Retail Wholesale comparison--->
		<!--- <cfif local.wholesale LT local.cost>
			<cfset local.wholesale=local.cost>
		</cfif>
		 --->
		<!--- - wb 07/11/2003 - Get the max retail --->
		<!--- <cfquery name="qGetMaxRetail" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >SELECT PriceFrom, PriceTo, MaxRetail
			FROM tblStockPriceFormula
			WHERE PartNo='#local.plu#'
			ORDER BY PriceTo 
		</cfquery> --->
			
		<!--- - wb 10/11/2003 - Get the max retail --->
		<!--- <cfif local.maxRetail EQ local.oldMaxRetail> --->
		
			<!--- <cfif qGetMaxRetail.recordCount GT 0>
				<cfloop query="qGetMaxRetail">
					<!--- only do this, if the maxretail field in the form hasnt been changed --->
					<cfset local.maxRetail=qGetMaxRetail.MaxRetail>
					<cfif local.wholesale LTE qGetMaxRetail.PriceTo>
						<cfbreak>
					</cfif> 
				</cfloop>
			<cfelse>
				<!--- <cfset local.maxRetail=local.wholesale*2> --->
			</cfif>
			<cfif local.wholesale GT local.maxRetail>
				<cfset local.maxRetail=local.wholesale*2>
			</cfif>	 --->
		<!--- </cfif> --->
		
			
		<!--- - wb 07/11/2003 - calculate the profit --->
		<cfset local.profit=local.wholesale-local.cost>
		
		<!--- - wb 07/11/2003 - calculate the 3H rebate amd the SCS rebate --->
		<cfif local.profit GT 0>
			<cfset local.ThreeHRebate=local.profit*qGetRCode.ThreeHRebate>
			<cfset local.SCRebate=local.profit*qGetRCode.SCRebate>
		<cfelse>
			<cfset local.ThreeHRebate=0>
			<cfset local.SCRebate=0>
		</cfif>
		
		<!--- - wb 07/11/2003 - Insert values --->		
		<cfquery name="SaveRecord" MAXROWS="1" dataSource="#Applic_dataSource#" 
		USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >
		UPDATE tblStockMaster 
		SET Cost=#local.cost#, 
			Wholesale=#local.wholeSale#, 
			MaxRetail=#local.maxRetail#, 
			ThreeHRebateVal=#local.ThreeHRebate#, 
			SCRebateVal=#local.SCRebate#, 
			SuppressOrder=#local.suporder#, 
			TypeID=#local.TypeID#
		WHERE PartNo='#local.plu#'
		</cfquery>
	</cfloop>	 
	<cfsetting enablecfoutputonly="No">
	<?xml version="1.0" encoding="iso-8859-1"?>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	
	<head>
		<title>Change Cost</title>
		<link rel="stylesheet" type="text/css" href="costi.css">
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
		<tr valign="middle"> 
	    	<td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
	 		<td><h1>Change Cost</h1></td>
	    	<td width="25%"><div align="right"><a href="CostListSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34" /></a></div></td>
		</tr>
	</table>
	<br />
	<br />
	<table width="100%" border="0">
		<tr><td><div align="center"><p>Finished Saving the Price Changes</p></div></td></tr>
	</table>
<cfelse>	
	<cflocation URL = "PurchaseOrderRequest.cfm">
</body></HTML></cfif>



