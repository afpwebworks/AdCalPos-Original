
<cfset lngStoreID = #Form.StoreID#>
<cfset lngEmployeeID = #Form.lngEmployeeID#>	

<cfset lngDeptNo = 0 >
<CFIF ParameterExists(Form.cmbDeptNo)>
	<cfset lngDeptNo = #Form.cmbDeptNo# >
</cfif>
<CFIF ParameterExists(Form.Submit)>
	<cflocation URL = "StockTakeBL.cfm?cmbDeptNo=#lngDeptNo#&sid=#lngStoreID#&eid=#lngEmployeeID#">
</cfif>


<cfset lngStoreID = #Form.StoreID#>

	
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
      <cfoutput><h1>Stocktake results processing Confirmation</h1></cfoutput>
    </td>
    <td width="25%"> 
      <cfoutput><div align="right"><a href="StockTakeSelectionBL.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div></cfoutput>	  
    </td>
  </tr>
</table>
<br>
<br>

<!--- timeout set to 900 seconds (15 minutes) --->
<FORM action="StockTakeBL_ActAction.cfm?RequestTimeout=900" method="post">
<cfoutput>

<input type="hidden" name="StoreID" value="#lngStoreID#">
<input type="hidden" name="lngEmployeeID" value="#lngEmployeeID#">						

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="75%" border="0">
  <tr>
    <td colspan="2">     
	  <div align="center"><h2>Would you like to release the stocktake results for all departments ?</h2>
    </td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr><td colspan="2">&nbsp;</td></tr>  
  <tr>
	<td align="center"><input type="submit" name="ProceedWithTask" value="  YES  "></td>
	<td align="center"><input type="submit" name="CancelTask" value="  NO  "></td>
  </tr>
</table>
	  </div>
    </td>
  </tr>
</table>
</cfoutput>
</Form>
</body>
</HTML>




