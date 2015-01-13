

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
      &nbsp;
	  <!--- <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div> --->
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngError = 0>
<cfset strError = ''>
<cfset dblLastCost = 0 >
 
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

   <!--- Check to make sure that the destination PLU is correct --->
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
			<!--- Get Destination PLU --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Plu_Line_#ItemLineCount#">
			<cfset strPluDestination = #evaluate(MyIDFieldName)#>
			
			<cfif (#dblFreezerQty# GT 0.00001) and (len(#strPluDestination#) GT 0)>
			    <!--- Check the existance of the Destination PLU --->
				<cfset strQuery = "SELECT tblStockMaster.PartNo ">
				<cfset strQuery = strQuery & "FROM tblStockMaster ">
				<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PartNo)= '#strPluDestination#' ))">
				<CFQUERY name="CheckDestinationPLU"      datasource="#application.dsn#"               > <!--- <CFQUERY name="CheckDestinationPLU"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->

					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			    <cfif #CheckDestinationPLU.RecordCount# LT 1>
					<cfset lngError = lngError + 1 >
					<cfset strError = '#strError#' & ', #strPluDestination#'>
				</cfif>
			</cfif>	
		</cfloop>
	</cfloop>
    <cfif #lngError# GT 0>
		<cfoutput>
		<br>
		<br>Error
		<br>
		<br>The following destination PLU do not exist.
		<br>#strError#
		<br>
		<br>Your transfer is NOT saved.  Fix the error and try again.
		</cfoutput>
	    <cfabort>
	</cfif>



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
			<!--- Get Destination PLU --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Plu_Line_#ItemLineCount#">
			<cfset strPluDestination = #evaluate(MyIDFieldName)#>

			
			<cfif (#dblFreezerQty# GT 0.00001) and (len(#strPluDestination#) GT 0)>
	            <!--- Save the values --->
					<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.TeansferQty = #dblFreezerQty#, tblStockLocation.TransferToPlu = '#strPluDestination#' ">
					<cfset strQuery = strQuery & "WHERE (((tblStockLocation.ID)=#lngItemID#))">
					<CFQUERY name="SaveData"      datasource="#application.dsn#"        >        <!--- <CFQUERY name="SaveData"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
						#PreserveSingleQuotes(strQuery)#
					</CFQUERY>
			</cfif>	
		</cfloop>
	</cfloop>
	<!--- Update the EOD summary table --->
	<CFSET strDateToday = ''>
	<CF_GetTodayDate>
	
	<CFIF ParameterExists(Form.btnEdit_OK)>
		<cflocation URL = "TransferBL.cfm?cmbDeptNo=#lngDeptNo#">
	<cfelse>

		<cfset strQuery = "select tblStockMaster.PartNo, tblStockMaster.Wholesale, tblStockLocation.TeansferQty, tblStockLocation.TransferToPlu, tblStockLocation.QtyOnHand, tblStockLocation.LastCost ">
  	    <cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
		<cfset strQuery = strQuery & "WHERE (tblStockLocation.StoreID = #lngStoreID#) AND (tblStockLocation.TeansferQty > 0.0001) AND (tblStockLocation.TransferToPlu Is Not Null )">
		<CFQUERY name="GetAlreadySaveData"      datasource="#application.dsn#"   > #PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<CFLOOP QUERY="GetAlreadySaveData" >
				<cfset strPartNo = '#GetAlreadySaveData.PartNo#' >
				<cfset dblFreezerQty = #GetAlreadySaveData.TeansferQty# >
				<cfset strPluDestination = #GetAlreadySaveData.TransferToPlu#>			
				
				<cfif (#dblFreezerQty# GT 0.00001) and (len(#strPluDestination#) GT 0)>
				    <!--- Create the log entry --->
					<cfset dblQtyBefore = 0 >
					<cfset dblWholesale = #GetAlreadySaveData.Wholesale# >
					<cfset dblLastCost = #GetAlreadySaveData.LastCost# >
										
					<cfset strQuery = "INSERT INTO tblTransferLog ( StoreID     , PartNo       , EmployeeID     , TeansferQty    , TransferToPlu        , B4_QtyOnHand  , Wholesale , WholesaleStockMaster ) ">
					<cfset strQuery = strQuery & "values          ( #lngStoreID#, '#strPartNo#', #lngEmployeeID#, #dblFreezerQty#, '#strPluDestination#', #dblQtyBefore#, #dblLastCost# , #dblWholesale# ) ">
					<CFQUERY name="CreateLogEntry"      datasource="#application.dsn#"        >        #PreserveSingleQuotes(strQuery)#
					</CFQUERY>

					<!--- Calculate Average Cost --->
					<cfset strQuery = "select QtyOnHand, LastCost, AverageCost ">
					<cfset strQuery = strQuery & "From tblStockLocation ">
					<cfset strQuery = strQuery & "WHERE (tblStockLocation.StoreID = #lngStoreID#) AND (tblStockLocation.PartNo = '#strPluDestination#' ) ">
					<CFQUERY name="GetLastCost"      datasource="#application.dsn#"               > #PreserveSingleQuotes(strQuery)#
					</CFQUERY>
					<cfset dblLastCostSource = #GetAlreadySaveData.LastCost# >
					<cfset dblLastCostDestination = 0 >
					<cfset dblCurrentQtyOnHandDestination = 0 >
					<cfset dblNewAverageCostDestination = 0 >										
					<cfif #GetLastCost.recordcount# GT 0 >
						<cfset dblLastCostDestination = #GetLastCost.LastCost# >						
						<cfset dblCurrentQtyOnHandDestination = #GetLastCost.QtyOnHand# >											
					</cfif>
                    <cfif abs(#dblCurrentQtyOnHandDestination#  + #dblFreezerQty# ) LT 0.00001 >
						<cfset dblNewAverageCostDestination = dblLastCostSource >  
					<cfelse>
						<cfset dblNewAverageCostDestination = ( (dblLastCostDestination * dblCurrentQtyOnHandDestination) + ( dblLastCostSource * dblFreezerQty ) ) / ( dblCurrentQtyOnHandDestination + dblFreezerQty ) >
					</cfif>
					<!--- MH20030829 The last cost coes negative if the Qty On hand is negative.  Prevent it --->
					<cfif #dblNewAverageCostDestination# LT 0 >
						<cfset dblNewAverageCostDestination=0>
					</cfif>
                    <cfif (#dblCurrentQtyOnHandDestination#  + #dblFreezerQty#)  LT 0 >
						<cfset dblNewAverageCostDestination=0>
					</cfif>
					
					<!--- Increase Qty On Hand --->
					<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = tblStockLocation.QtyOnHand + #dblFreezerQty#, tblStockLocation.AverageCost = #dblNewAverageCostDestination# , tblStockLocation.LastCost = #dblNewAverageCostDestination# ">
					<cfset strQuery = strQuery & "From tblStockLocation ">
					<cfset strQuery = strQuery & "WHERE (tblStockLocation.StoreID = #lngStoreID#) AND (tblStockLocation.PartNo = '#strPluDestination#' ) ">
					<CFQUERY name="IncreaseQtyOnHand"      datasource="#application.dsn#"               > #PreserveSingleQuotes(strQuery)#
					</CFQUERY>
					
					<!--- Decrease Qty On Hand --->
					<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.QtyOnHand = [tblStockLocation].[QtyOnHand]-#dblFreezerQty# ">
					<cfset strQuery = strQuery & "From tblStockLocation ">
					<cfset strQuery = strQuery & "WHERE (tblStockLocation.StoreID = #lngStoreID# ) AND (tblStockLocation.PartNo = '#strPartNo#' ) ">
					<CFQUERY name="DecreaseQtyOnHand"      datasource="#application.dsn#"               > #PreserveSingleQuotes(strQuery)#
					</CFQUERY>
					
				</cfif>	
		</cfloop>
	
		<!--- Mark the EOD summary --->
		<cfset strQuery = "UPDATE tblEodSummary SET tblEodSummary.EodTransferUpdated = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblEodSummary.Date)= '#strDateToday#' ) AND ((tblEodSummary.StoreID)= #lngStoreID# ))">
		<CFQUERY name="UpdateSummaryApply"      datasource="#application.dsn#"               > <!--- <CFQUERY name="UpdateSummaryApply"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- Reset Transfer Qty --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.TeansferQty = 0, tblStockLocation.TransferToPlu = Null ">
		<cfset strQuery = strQuery & "WHERE (((tblStockLocation.StoreID)=#lngStoreID#) AND ((tblStockLocation.TeansferQty)>0.0001)) OR (((tblStockLocation.StoreID)=2) AND ((tblStockLocation.TransferToPlu) Is Not Null))">
		<CFQUERY name="ResetQtyOnHand"      datasource="#application.dsn#"               > <!--- <CFQUERY name="ResetQtyOnHand"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<br>Transfer data successfully saved.
	</cfif>
	<!--- <cflocation URL = "TransferBL.cfm?cmbDeptNo=0"> --->
<CFELSE>	
	<cflocation URL = "TransferBL.cfm">
</cfif>	
	  
</body>
</HTML>
