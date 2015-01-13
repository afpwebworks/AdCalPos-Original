

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>sample</TITLE>
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
      <h1>Purchase Order</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PurchaseOrderRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
<cfset lngError = 0>
<cfset strError = ''>

<cfset lngStoreID = #Form.lngStoreID#>
<cfset strDate = #Form.strDate#>
<cfif #len(strDate)# LT 8>
	<cfset strDate = "0" & #strDate#>
</cfif>

	  
<CFIF ParameterExists(Form.btnEdit_OK)>
	<cfset lngNumRecords = #Form.txtNumLines#>
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumRecords#">
		<!--- 	Read ID Number --->
		<cfset MyIDFieldName = "Form.txtID" & #LoopCount#>
		<!--- <cfoutput><p>#MyIDFieldName#</p></cfoutput> --->	
		<cfset lngOrderLineID = #evaluate(MyIDFieldName)#>
		<!--- <cfoutput><p>#lngOrderLineID#</p></cfoutput> --->
	
		<!--- 	Read Qty --->
		<cfset MyQtyFieldName = "Form.txtQTY" & #LoopCount#>
		<!--- <cfoutput><p>#MyQtyFieldName#</p></cfoutput> --->	
		<cfset dblOrderQTY = #evaluate(MyQtyFieldName)#>
		<!--- <cfoutput><p>#dblOrderQTY#</p></cfoutput> --->

		<!--- 	Read Min Order Qty --->
		<cfset MyMinOrderQtyFieldName = "Form.txtMinQty" & #LoopCount#>
		<cfset dblMinOrderQTY = #evaluate(MyMinOrderQtyFieldName)#>
	    
		<cfif #dblMinOrderQTY# LT 0.001>
			<cfset dblMinOrderQTY = -0.001>
		</cfif>
		<!--- <cfoutput><br>dblOrderQTY: #dblOrderQTY#</cfoutput> --->
		<!--- <cfoutput><br>dblMinOrderQTY: #dblMinOrderQTY#</cfoutput> --->

		<!--- 	Save the value --->
		<CFIF ((IsNumeric(dblOrderQTY)) AND ((#dblOrderQTY# GE #dblMinOrderQTY#) or (#dblOrderQTY# LE 0.0001 ) ) ) >
			<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.QtyOrdered = #dblOrderQTY# ">
			<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.OrderDetID)=#lngOrderLineID#))">
			<!--- <cfoutput><br>strQuery: #strQuery#</cfoutput> --->
			<CFQUERY name="SaveRecord" MAXROWS="1" datasource="#application.dsn#" > 
			<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="SaveRecord" MAXROWS="1"> --->
					#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		<cfelse>
			<cfset #lngError# = #lngError# + 1>
			<cfset MyPartNoFieldName = "Form.txtPartNo" & #LoopCount#>
			<cfset strPartNo = #evaluate(MyPartNoFieldName)#>
			<cfset #strError# = "#strError#" & ", " & "#strPartNo#">			
		</cfif>
	</CFLOOP>
	<cfif #lngError# GT 0>
		<cfoutput><p><b><font size="4" color="FFFF33">There were #lngError# errors.  Please check PLU</font></b></p></cfoutput>
		<cfoutput><p><b><font size="4" color="FFFF33">#strError#</font></b></p></cfoutput>
	<cfelse>
	    <!--- Save the comments --->
	    <!--- <cfset strComment = #URLEncodedFormat(Form.OrderComments)#>
		<cfset strQuery = "UPDATE tblOrderHeader SET tblOrderHeader.Comments = '#strComment#' ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderHeader.StoreID)=#lngStoreID#) AND ((tblOrderHeader.OrderDate)= '#strDate#' ))"> --->
		<cfset strComment = #URLEncodedFormat(Form.OrderComments)#>
		<CFQUERY name="SaveComments" datasource="#application.dsn#" > 
			UPDATE 	tblOrderHeader 
			SET 	tblOrderHeader.Comments = '#strComment#',
					tblOrderHeader.DateModified = #CreateODBCDateTime(now())#
			WHERE 	(((tblOrderHeader.StoreID)=#lngStoreID#) AND ((tblOrderHeader.OrderDate)= '#strDate#' ))
					<cfif form.type EQ 1>
						AND	tblOrderHeader.typeID = 1
					<cfelse>
						AND	tblOrderHeader.typeID <> 1
					</cfif>
		</CFQUERY>
	
		<p>Finished Saving the order quantities</p>
	</cfif>
<CFELSE>	
	<cflocation URL = "PurchaseOrderRequest.cfm">
</cfif>	
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

