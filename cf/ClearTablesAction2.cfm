
<cfif isdefined("Form.ProceedWithTask")>
<cfset lngStoreID = #Form.lngStoreID#>
<cfset strDate = #Form.strDate#>
<cfset strDateTo = #Form.strDateTo#>
<cfset strTaskName = #Form.strTaskName#>
<cfset strTableName = #Form.strTableName#>

<cfif #len(strDate)# LT 8>
	<cfset strDate = "0" & "#strDate#">
</cfif>
<cfif #len(strDateTo)# LT 8>
	<cfset strDateTo = "0" & "#strDateTo#">
</cfif>

<cfset strQuery = "">
<cfif strTableName EQ "tblStore_CashInDraw">
	<cfset strQuery = "DELETE tblStore_CashInDraw ">
	<cfset strQuery = strQuery & "WHERE (StoreID=#lngStoreID#) AND (Convert(int,[Date]) Between  convert(int,convert(datetime,'#mid(strDate,3,2)#/#mid(strDate,1,2)#/#mid(strDate,5,4)#') ) and convert(int,convert(datetime,'#mid(strDateTo,3,2)#/#mid(strDateTo,1,2)#/#mid(strDateTo,5,4)#') ) )">
<cfelseif strTableName EQ "tblStore_PLUTotals">
	<cfset strQuery = "DELETE tblStore_PLUTotals ">
	<cfset strQuery = strQuery & "WHERE (StoreID=#lngStoreID#) AND (Convert(int,[Date]) Between  convert(int,convert(datetime,'#mid(strDate,3,2)#/#mid(strDate,1,2)#/#mid(strDate,5,4)#') ) and convert(int,convert(datetime,'#mid(strDateTo,3,2)#/#mid(strDateTo,1,2)#/#mid(strDateTo,5,4)#') ) )">
<cfelseif strTableName EQ "tblStore_ECRTotals">
	<cfset strQuery = "DELETE tblStore_ECRTotals ">
	<cfset strQuery = strQuery & "WHERE (StoreID=#lngStoreID#) AND (Convert(int,[Date]) Between  convert(int,convert(datetime,'#mid(strDate,3,2)#/#mid(strDate,1,2)#/#mid(strDate,5,4)#') ) and convert(int,convert(datetime,'#mid(strDateTo,3,2)#/#mid(strDateTo,1,2)#/#mid(strDateTo,5,4)#') ) )">
<cfelseif strTableName EQ "tblStore_OperatorTotals">
	<cfset strQuery = "DELETE tblStore_OperatorTotals ">
	<cfset strQuery = strQuery & "WHERE (StoreID=#lngStoreID#) AND (Convert(int,[Date]) Between  convert(int,convert(datetime,'#mid(strDate,3,2)#/#mid(strDate,1,2)#/#mid(strDate,5,4)#') ) and convert(int,convert(datetime,'#mid(strDateTo,3,2)#/#mid(strDateTo,1,2)#/#mid(strDateTo,5,4)#') ) )">
<cfelseif strTableName EQ "tblStore_StockHistory">
	<cfset strQuery = "DELETE tblStockHistStart ">
	<cfset strQuery = strQuery & "WHERE StoreID=#lngStoreID# AND DDate BETWEEN #mid(strDate,5,4)##mid(strDate,3,2)##mid(strDate,1,2)# AND #mid(strDateTo,5,4)##mid(strDateTo,3,2)##mid(strDateTo,1,2)#">
	<cfset strQuery = strQuery & " DELETE tblStockHistEnding ">
	<cfset strQuery = strQuery & "WHERE StoreID=#lngStoreID# AND DDate BETWEEN #mid(strDate,5,4)##mid(strDate,3,2)##mid(strDate,1,2)# AND #mid(strDateTo,5,4)##mid(strDateTo,3,2)##mid(strDateTo,1,2)#">
</cfif>
<CFQUERY name="DeleteData" datasource="#application.dsn#" > 
<!--- <CFQUERY name="DeleteData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>




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
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="75%" border="0">
  <tr>
    <td colspan="2">     
	  <div align="center"><cfoutput><h3><b>#strTaskName# between #mid(strDate,1,2)#/#mid(strDate,3,2)#/#mid(strDate,5,4)# and #mid(strDateTo,1,2)#/#mid(strDateTo,3,2)#/#mid(strDateTo,5,4)# is applied and finished.</b></h3></cfoutput>
    </td>
  </tr>
</table>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>
<cfelse>
	<CFLOCATION url="MainMenu.cfm">
</cfif>

