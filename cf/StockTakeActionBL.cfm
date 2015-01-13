
<cfset strDateToday ="">
<cf_GetTodayDate>

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
	<cfset lngemployeeID = #Form.lngemployeeID#>


	<CFIF ParameterExists(Form.btnApply_OK) >
		<!--- Put all of the onhand figures in the previous on hand column --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Prev_QtyOnHand = tblStockLocation.QtyOnHand ">
		<cfset strQuery = strQuery & "From tblStockLocation, tblStockMaster "> 
		<cfset strQuery = strQuery & "WHERE ((tblStockMaster.PCode) = 0 ) AND ((tblStockMaster.NoLongerUsed) = 0 ) AND  ((tblStockMaster.SuppressStocktake) = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND (tblStockLocation.PartNo = tblStockMaster.PartNo) AND (tblStockLocation.StoreID=#lngStoreID#) ">
		<CFQUERY name="SaveQtyOnHand" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	</cfif>
	
	
    <input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">

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
			<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.Freezer_QtyOnHand = #dblFreezerQty#, tblStockLocation.CoolRoom_QtyOnHand = #dblCoolRoomQty#, tblStockLocation.Display_QtyOnHand = #dblDisplayQty# ">
			<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#lngItemID#))">
			<CFQUERY name="SaveData" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="SaveData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfloop>
	</cfloop>
	
	<CFIF ParameterExists(Form.btnApply_OK)>	
		<!--- Make sure that EOD Summary has some records --->
		
		<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->
		<!--- <cf_GetMakeSureOfEODSummaryRecords storeid = #lngStoreID# > --->
	    <cfinclude TEMPLATE="GetMakeSureOfEODSummaryRecords.cfm">
	
		<!--- Reset all flags in the tblStocktakeLogVariance --->
		<cfset strQuery = "update tblStocktakeLogVariance set EOD_NeedsAdjusting = 0 ">
		<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID = #lngStoreID#) ">
		<CFQUERY name="ResetFlags" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveLog" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		 
		<cfset strQuery = "INSERT INTO tblStocktakeLogVariance ( StoreID, PartNo, Wholesale, B4_QtyOnHand, AF_QtyOnHand, EmployeeID, DDate , EOD_NeedsAdjusting ) ">
		<cfset strQuery = strQuery & "SELECT tblStockLocation.StoreID, tblStockLocation.PartNo, tblStockLocation.LastCost, tblStockLocation.QtyOnHand, [Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand] AS NewQty, #lngemployeeID# AS EmployeeID , '#strDateToday#' as DDate , 1 ">
		<cfset strQuery = strQuery & "FROM tblStockLocation INNER JOIN tblStockMaster ON tblStockLocation.PartNo = tblStockMaster.PartNo ">
		<cfset strQuery = strQuery & "WHERE (  ((tblStockMaster.PCode) = 0 ) AND ((tblStockMaster.NoLongerUsed) = 0 ) AND  ((tblStockMaster.SuppressStocktake) = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND   ((tblStockLocation.StoreID)=#lngStoreID#) AND ((Abs([Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand]-[QtyOnHand]))>0.0001))">
		<CFQUERY name="SaveLog" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveLog" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = [Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand] ">
		<cfset strQuery = strQuery & "From tblStockLocation, tblStockMaster "> 
		<cfset strQuery = strQuery & "WHERE ((tblStockMaster.PCode) = 0 ) AND ((tblStockMaster.NoLongerUsed) = 0 ) AND  ((tblStockMaster.SuppressStocktake) = 0 ) AND  ( (tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N') ) AND (tblStockLocation.PartNo = tblStockMaster.PartNo) AND (tblStockLocation.StoreID=#lngStoreID#) AND (Abs([Freezer_QtyOnHand]+[Display_QtyOnHand]+[CoolRoom_QtyOnHand]-[QtyOnHand]) > 0.0001)">
		<CFQUERY name="SaveQtyOnHand" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SaveQtyOnHand" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<!--- If the store has not applied the initial stock take then do not check for any condition --->
		<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StartingStockEntered ">
		<cfset strQuery = strQuery & "FROM tblStores ">
		<cfset strQuery = strQuery & "WHERE (tblStores.StoreID=#lngStoreID#) AND (tblStores.StartingStockEntered=0 )">
		<CFQUERY name="CheckInititalStocktake" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #CheckInititalStocktake.RecordCount# GT 0>
			<!--- Change the flag to yes --->
			<cfset strQuery = "UPDATE tblStores SET tblStores.StartingStockEntered = 1 ">
			<cfset strQuery = strQuery & "WHERE (((tblStores.StoreID)=#lngStoreID#) AND ((tblStores.StartingStockEntered)=0))">
			<CFQUERY name="UpdateInititalStocktake" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
	</cfif>
	
	<!--- Update the EOD summary table --->
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
	
	<CFIF ParameterExists(Form.btnEdit_OK)>
		<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodStocktakeEnteredNotUpdated = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#strDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
		<CFQUERY name="UpdateSummaryEdit" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateSummaryEdit" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<!--- <cflocation URL = "StockTakeBL.cfm?cmbDeptNo=#lngDeptNo#&sid=#lngStoreID#&eid=#lngemployeeID#"> --->
		<cflocation URL = "StockTakeSelectionBL.cfm?cmbDeptNo=#lngDeptNo#&sid=#lngStoreID#&eid=#lngemployeeID#">
	<cfelse>
		<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodStocktakeEnteredNotUpdated = 0, tblEodSummary.EodStocktakeUpdated = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#strDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
		<CFQUERY name="UpdateSummaryApply" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="UpdateSummaryApply" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<!--- Make sure that there are 30 more lines in the EodSummary table --->
		<Cfset dteBaseDate = #now()#>        
		<cfloop INDEX="LoopCount" FROM="0" TO="30" STEP="1">
			<Cfset dteSpan = #CreateTimeSpan(LoopCount, 0, 0, 0)#>
			<Cfset dteNewDate = #dteBaseDate# + #dteSpan#>
			<Cfset lngDay = #Day(dteNewDate)#>
			<Cfset lngDay = #numberformat(lngDay , "00")#>
			<Cfset lngMonth = #month(dteNewDate)#>
			<Cfset lngMonth = #numberformat(lngMonth , "00")#>
			<Cfset lngYear = #year(dteNewDate)#>
			<Cfset strDate = "#lngDay##lngMonth##lngYear#" >	
		
			<cfset strQuery = "SELECT tblEodSummary.Date, tblEodSummary.StoreID ">
			<cfset strQuery = strQuery & "FROM tblEodSummary ">
			<cfset strQuery = strQuery & "WHERE (tblEodSummary.Date='#strDate#') AND (tblEodSummary.StoreID= #lngStoreID#)">
			<CFQUERY name="CheckDateIntoSummary" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckDateIntoSummary.RecordCount# LT 1>
				<cfset strQuery = "INSERT INTO tblEodSummary ( [Date], StoreID ) ">
				<cfset strQuery = strQuery & "Values ( '#strDate#' , #lngStoreID# )">
				<CFQUERY name="InsertDateIntoSummary" datasource="#application.dsn#" > 
				<!--- <CFQUERY name="InsertDateIntoSummary" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			</cfif>
		</cfloop>
		
		<!--- Adjust EOD tables --->
		<cfset strQuery = "select * from  tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (StoreID = #lngStoreID# ) AND (EOD_NeedsAdjusting = 1 )">
		<CFQUERY name="UpdatedStockItems" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfloop query = "UpdatedStockItems" >
			<cfset My_strPartNo = #UpdatedStockItems.PartNo# > 
			<cfset My_dblB4_QtyOnHand = #UpdatedStockItems.B4_QtyOnHand# > 
			<cfset My_dblAF_QtyOnHand = #UpdatedStockItems.AF_QtyOnHand# > 
			<cfset My_dblLastCost = #UpdatedStockItems.Wholesale# > 

			
			<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->
			<CFSET PartNo = My_strPartNo>
			<CFSET QtyB4 = My_dblB4_QtyOnHand>
			<CFSET QtyAfter = My_dblAF_QtyOnHand>
			<CFSET Cost = My_dblLastCost>
			<CFSET  storeid = lngStoreID>
			
			<cfINCLUDE TEMPLATE="GetAdjustEODAfterStocktake.CFM">
			
			<!--- <cf_GetAdjustEODAfterStocktake PartNo = '#My_strPartNo#' QtyB4 = #My_dblB4_QtyOnHand# QtyAfter = #My_dblAF_QtyOnHand# Cost = #My_dblLastCost# storeid = #lngStoreID# > --->
			
		</cfloop>

		<!--- Reset all flags in the tblStocktakeLogVariance --->
		<cfset strQuery = "update tblStocktakeLogVariance set EOD_NeedsAdjusting = 0 ">
		<cfset strQuery = strQuery & "FROM tblStocktakeLogVariance ">
		<cfset strQuery = strQuery & "WHERE (tblStocktakeLogVariance.StoreID = #lngStoreID#) ">
		<CFQUERY name="ResetFlagsAgain" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cflocation URL = "StockTakeBL_Variance.cfm?cmbDeptNo=0&sid=#lngStoreID#&eid=#lngemployeeID#">
	</cfif>

<CFELSE>	
	<cflocation URL = "StockTakeBL.cfm">
</cfif>	
	  
</body>
</HTML>
