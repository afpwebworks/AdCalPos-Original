

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Stocktake</TITLE>
	
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
      <h1>Stocktake</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PackingRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngError = 0>
<cfset strError = ''>
 
<CFIF (ParameterExists(Form.btnEdit_OK)) or (ParameterExists(Form.btnApply_OK))>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

	<cfset lngStoreID = #Form.storeid#>	  
	<cfset lngDeptNo = #Form.cmbDeptNo#>
    <input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">

<!--- 	
	<cfset strDate = #Form.txtstrDate#>
	<cfset lngStoreID = #Form.txtlngStoreID#>
	<cfif len(#strDate#) EQ 7>
		<cfset strDate = "0" & "#strDate#" >
	</cfif>
 --->
	<!--- Save the quantities --->
	<cfset lngNumDepartments = #Form.NumDepartments#>
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumDepartments#">
		<!--- Get the number of lines per department --->
		<cfset MyIDFieldName = "Form.Dept_#LoopCount#_TotalLines">
		<cfset lngNumLines = #evaluate(MyIDFieldName)#>

		<CFLOOP INDEX="ItemLineCount" FROM="1" TO="#lngNumLines#">	
			<!--- Get ID --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_txtID#ItemLineCount#">
			<cfset lngItemID = #evaluate(MyIDFieldName)#>
			<!--- Get Freezer qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Freezer_Line_#ItemLineCount#">
			<cfset dblFreezerQty = #evaluate(MyIDFieldName)#>
			<!--- Get Cool room qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_CoolRoom_Line_#ItemLineCount#">
			<cfset dblCoolRoomQty = #evaluate(MyIDFieldName)#>
			<!--- Get display qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Display_Line_#ItemLineCount#">
			<cfset dblDisplayQty = #evaluate(MyIDFieldName)#>
			<cfset dblTotalQty = #dblFreezerQty# + #dblCoolRoomQty# + #dblDisplayQty#>
			
            <!--- Save the values --->
			<CFIF ParameterExists(Form.btnEdit_OK)>
				<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Freezer_QtyOnHand = #dblFreezerQty#, tblStockLocation.CoolRoom_QtyOnHand = #dblCoolRoomQty#, tblStockLocation.Display_QtyOnHand = #dblDisplayQty# ">
				<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#lngItemID#))">
			<cfelse>
				<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Freezer_QtyOnHand = #dblFreezerQty#, tblStockLocation.CoolRoom_QtyOnHand = #dblCoolRoomQty#, tblStockLocation.Display_QtyOnHand = #dblDisplayQty#, tblStockLocation.QtyOnHand = #dblTotalQty#, tblStockLocation.Prev_QtyOnHand = [QtyOnHand] ">
				<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#lngItemID#))">
			</cfif>

			<CFQUERY name="SaveData" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="SaveData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
<!--- 	
			<cfoutput><br>lngStoreID: #lngStoreID#</cfoutput>
			<cfoutput><br>lngNumDepartments: #lngNumDepartments#</cfoutput>
			<cfoutput><br>lngNumLines: #lngNumLines#</cfoutput>
			<cfoutput><br>lngItemID: #lngItemID#</cfoutput>
			<cfoutput><br>dblFreezerQty: #dblFreezerQty#</cfoutput>
			<cfoutput><br>dblCoolRoomQty: #dblCoolRoomQty#</cfoutput>
			<cfoutput><br>dblDisplayQty: #dblDisplayQty#</cfoutput>
			<cfabort>
 --->	
		</cfloop>
	</cfloop>
	<cflocation URL = "StockTake.cfm?cmbDeptNo=#lngDeptNo#">
<CFELSE>	
	<cflocation URL = "StockTake.cfm">
</cfif>	
	  
</body>
</HTML>
