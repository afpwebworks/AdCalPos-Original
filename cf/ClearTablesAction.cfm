
<!--- <cfset lngDay = #Form.DF#>
<cfset lngMonth = #Form.MF#>
<cfset lngYear = #Form.YF#>

<cfif #len(lngDay)# LT 2>
	<cfset lngDay = "0" & "#lngDay#">
</cfif>
<cfif #len(lngMonth)# LT 2>
	<cfset lngMonth = "0" & "#lngMonth#">
</cfif>
<cfset strDate = "#lngDay#" & "#lngMonth#" & "#lngYear#">

<cfset lngDayTo = #Form.DT#>
<cfset lngMonthTo = #Form.MT#>
<cfset lngYearTo = #Form.YT#>

<cfif #len(lngDayTo)# LT 2>
	<cfset lngDayTo = "0" & "#lngDayTo#">
</cfif>
<cfif #len(lngMonthTo)# LT 2>
	<cfset lngMonthTo = "0" & "#lngMonthTo#">
</cfif>
<cfset strDateTo = "#lngDayTo#" & "#lngMonthTo#" & "#lngYearTo#"> --->

<cfset strDate=right(form.sDate,2) & mid(form.sDate,5,2) & left(form.sDate,4)>
<cfset strDateTo=right(form.eDate,2) & mid(form.eDate,5,2) & left(form.eDate,4)>


<cfset lngStoreID = #Form.txtStoreID#>

<cfif isdefined("Form.tblStore_Other")>
	<CFLOCATION url="ClearTablesOther.cfm?SID=#lngStoreID#">
</cfif>

<!--- 
<cfoutput><BR>lngStoreID: #lngStoreID#</cfoutput>
<cfoutput><BR>strDate: #strDate#</cfoutput>
<cfoutput><BR>strDateTo: #strDateTo#</cfoutput>
 --->
<cfset strTaskName = "">
<cfset strTableName = "">

<cfif isdefined("Form.tblStore_CashInDraw")>
	<cfset strTaskName = "Clearing Cash in Draw">
	<cfset strTableName = "tblStore_CashInDraw">
<cfelseif isdefined("Form.tblStore_PLUTotals")>
	<cfset strTaskName = "Clearing PLU Totals">
	<cfset strTableName = "tblStore_PLUTotals">
<cfelseif isdefined("Form.tblStore_ECRTotals")>
	<cfset strTaskName = "Clearing ECR Totals">
	<cfset strTableName = "tblStore_ECRTotals">
<cfelseif isdefined("Form.tblStore_OperatorTotals")>
	<cfset strTaskName = "Clearing Operator Totals">
	<cfset strTableName = "tblStore_OperatorTotals">	
<cfelseif isdefined("Form.tblStore_StockHistory")>
	<cfset strTaskName = "Stock History">
	<cfset strTableName = "tblStore_StockHistory">
</cfif>
<!--- 
<cfoutput><BR>strTaskName: #strTaskName#</cfoutput>
<cfoutput><BR>strTableName: #strTableName#</cfoutput>
 --->
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Clear Tables</TITLE>
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
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Clear Tables</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="ClearTables.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="ClearTablesAction2.cfm" method="post">
<cfoutput>
	<INPUT type="hidden" name="lngStoreID" value="#lngStoreID#">
	<INPUT type="hidden" name="strDate" value="#strDate#">
	<INPUT type="hidden" name="strDateTo" value="#strDateTo#">
	<INPUT type="hidden" name="strTaskName" value="#strTaskName#">
	<INPUT type="hidden" name="strTableName" value="#strTableName#">
</cfoutput>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="75%" border="0">
  <tr>
    <td colspan="2">     
	  <div align="center">
	  <cfif isdefined("Form.tblStore_StockHistory")>
	  	<cfoutput><h3><b>You have selected Clear Stock History between #mid(strDate,1,2)#/#mid(strDate,3,2)#/#mid(strDate,5,4)# and #mid(strDateTo,1,2)#/#mid(strDateTo,3,2)#/#mid(strDateTo,5,4)#.<br />
		Please click YES to proceed or NO to abort.</b></h3></cfoutput>
	  <cfelse>
		<cfoutput><h3><b>You have decided to #strTaskName# between #mid(strDate,1,2)#/#mid(strDate,3,2)#/#mid(strDate,5,4)# and #mid(strDateTo,1,2)#/#mid(strDateTo,3,2)#/#mid(strDateTo,5,4)#.  Please click YES to proceed or NO to exit.</b></h3></cfoutput>
      </cfif>	
	</td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr>
	<td align="center"><input type="submit" name="ProceedWithTask" value="  YES  "></td>
	<td align="center"><input type="submit" name="CancelTask" value="  NO  "></td>
  </tr>
</table>

</Form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

