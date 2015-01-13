
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Store Selection</TITLE>
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
      <h1>Select Store</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<!--- Write a query to select the stores that have defined an order --->

<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName, tblStores.NoLongerUsed ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE (((tblStores.NoLongerUsed)=0)) ">
<cfset strQuery = strQuery & "ORDER BY tblStores.StoreName">
<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStores"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngNumStores = 1 + #GetStores.RecordCount#>

<p><h3>Please select the store.</h3></P>
<FORM action="StoreSelectionAction.cfm" method="post">

<table width="250" border="0">
  <tr> 
    <td width="100"><h3>Store</h3></td>
    <td width="150"> 

			<!--- <cfoutput><select name="txtStoreID"  size="#lngNumStores#"></cfoutput> --->
			<cfoutput><select name="txtStoreID"  size="10"></cfoutput>
			<cfset lngIndex = 0>
			<cfoutput Query = "GetStores">
				<cfset lngIndex = lngIndex + 1>
			    <cfif lngIndex EQ 1>
					<option value="#GetStores.StoreID#" selected>#GetStores.StoreName#</option>
				<cfelse>
					<option value="#GetStores.StoreID#">#GetStores.StoreName#</option>
				</cfif>
			</cfoutput>
		</select>
        <!--- field validation --->
        <INPUT type="hidden" name="txtStoreID_integer">
    </td>
  </tr>
</table>
<p></P>
<input type="submit" name="Submit" value=" Change Store ">
</Form>
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

