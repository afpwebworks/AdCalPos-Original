
<!--- 	
<cfoutput>
	<br>#Form.Dept_1_Value_Line_1#
</cfoutput>
<cfabort>
 ---> 

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Wastage</TITLE>
	
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
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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
	<cfset lngEmployeeID = #Form.employeeID#>
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
			<!--- Get Part No --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_PartNo#ItemLineCount#">
			<cfset strPartNo = #evaluate(MyIDFieldName)#>
			<!--- Get Freezer qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Value_Line_#ItemLineCount#">
			<cfset dblFreezerQty = #evaluate(MyIDFieldName)#>
			
			
			<cfif #dblFreezerQty# GT 0.00001>
	            <!--- Save the values --->
					<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Wastage = #dblFreezerQty# ">
					<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#lngItemID#))">

					<CFQUERY name="SaveData" datasource="#application.dsn#" > 
					<!--- <CFQUERY name="SaveData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
						#PreserveSingleQuotes(strQuery)#
					</CFQUERY>

			</cfif>	
			
		</cfloop>
	</cfloop>
	<!--- Update the EOD summary table --->
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
	
	<CFIF ParameterExists(Form.btnEdit_OK)>
		<cflocation URL = "WastageBL.cfm?cmbDeptNo=#lngDeptNo#">
	<cfelse>
	    <!--- Get the amount of wastage value --->
		<!--- 
		<cfset strQuery = "SELECT Sum([Wastage]*[Wholesale]) AS WastageVal ">
		<cfset strQuery = strQuery & "FROM tblStockLocation INNER JOIN tblStockMaster ON tblStockLocation.PartNo = tblStockMaster.PartNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.0001))">
		 --->
		<cfset strQuery = "SELECT Sum([Wastage] * tblStockLocation.LastCost ) AS WastageVal ">
		<cfset strQuery = strQuery & "FROM tblStockLocation INNER JOIN tblStockMaster ON tblStockLocation.PartNo = tblStockMaster.PartNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.0001))">
		<CFQUERY name="GetWastageValue" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetWastageValue" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset dblWastageVal = 0>
		<cfif #GetWastageValue.RecordCount# GT 0>
			<cfif #isnumeric(GetWastageValue.WastageVal)#>
				<cfset dblWastageVal = #GetWastageValue.WastageVal#>
			</cfif>
		</cfif>
	
	    <!--- Create the log entry --->
		<!--- 
		<cfset strQuery = "INSERT INTO tblWastageLog ( StoreID, PartNo, EmployeeID, Wastage, B4_QtyOnHand, Wholesale ) ">
		<cfset strQuery = strQuery & "SELECT tblStockLocation.StoreID, tblStockLocation.PartNo, #lngEmployeeID# AS EmployeeID, tblStockLocation.Wastage, tblStockLocation.QtyOnHand, tblStockMaster.Wholesale ">
		<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.0001))">
		 --->
		<cfset strQuery = "INSERT INTO tblWastageLog ( StoreID, PartNo, EmployeeID, Wastage, B4_QtyOnHand, Wholesale, WholesaleStockMaster ) ">
		<cfset strQuery = strQuery & "SELECT tblStockLocation.StoreID, tblStockLocation.PartNo, #lngEmployeeID# AS EmployeeID, tblStockLocation.Wastage, tblStockLocation.QtyOnHand, tblStockLocation.LastCost , tblStockMaster.Wholesale ">
		<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.0001))">
		<CFQUERY name="CreateLogEntry" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CreateLogEntry" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodWasteUpdated = 1, tblEodSummary.WastageValEx = #dblWastageVal# ">
		<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#strDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
		<CFQUERY name="UpdateSummaryApply" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateSummaryApply" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

	    <!--- Update qty on hand --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = [QtyOnHand]-[Wastage] ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)>0.0001))">
		<CFQUERY name="UpdateQtyOnHandQry" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateQtyOnHandQry" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

	    <!--- Reset Wastage Qty --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Wastage = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.Wastage)<>0))">
		<CFQUERY name="ResetWastageQty" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="ResetWastageQty" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<br>Wastage data successfully saved.
	</cfif>
	<!--- <cflocation URL = "WastageBL.cfm?cmbDeptNo=0"> --->
<CFELSE>	
	<cflocation URL = "WastageBL.cfm">
</cfif>	
	  
</body>
</HTML>
