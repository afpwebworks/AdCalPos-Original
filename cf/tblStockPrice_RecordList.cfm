<cfset strPageTitle = "Prices Scheme">
<cfif NOT(isdefined("StockPricesDAO"))>
  <cfset StockPricesDAO =   application.beanfactory.getBean("StockPricesDAO") />
</cfif>
<cfset qPrices = StockPricesDAO.GetAllStockPrices() />
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="/css/adcalposnet.css">
<link rel="stylesheet" type="text/css" href="/css/FormStyles.css">
<TITLE>
<cfoutput>#strPageTitle#</cfoutput>
</TITLE>
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
<cfoutput>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle">
    <td><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td width="*"><h1>
        <cfoutput>#strPageTitle#</cfoutput>
      </h1></td>
    <td align="right"><a href="/cf/MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></td>
  </tr>
</table>
<div align="center">
<p><a href="/cf/tblStockPrice_Edit.cfm"><img src="/css/icons/add.gif" width="16" height="16" alt="Add">&nbsp;Add a new price</a></p>
<table id="report">
  <tr>
  	<th>Edit</th>
    <th>PriceID</th>
    <th>Price</th>
    <th>Last Update</th>
   </tr>
  <cfif qPrices.recordcount>
    <cfloop query="qPrices">
    <tr class="#IIf(CurrentRow Mod 2, DE('lite'), DE('dark'))#">
    <td><a href="/cf/tblStockPrice_Edit.cfm?PriceID=#qPrices.PriceID#"><img src="/css/icons/icon_edit.gif" alt="Edit" width="14" height="13" /></a></td>
      <td><a href="/cf/tblStockPrice_Edit.cfm?PriceID=#qPrices.PriceID#">#qPrices.PriceID#</a></td>
      <td><a href="/cf/tblStockPrice_Edit.cfm?PriceID=#qPrices.PriceID#">#qPrices.Description#</a></td>
      <td><a href="/cf/tblStockPrice_Edit.cfm?PriceID=#qPrices.PriceID#">#dateformat(qPrices.DateUPdated, "d\mmm\yyyy")# by #qPrices.UpdatedBY#</a></td>
      
    </tr>
    </cfloop>
    <cfelse>
    <tr>
      <td colspan="3" align="center">There are no prices defined yet</td>
    </tr>
  </cfif>
</table>
</div>
</body>
</cfoutput>
</HTML>
