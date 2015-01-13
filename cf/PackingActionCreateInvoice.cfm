
<cfparam name="form.name" default="0">
<cfparam name="form.type" default="0">
<CFIF ParameterExists(Form.btnAllocateMore)>
	<cflocation URL = "PackingRequest.cfm">
	<cfabort>
</cfif>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Saving Invoice</TITLE>
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
      <h1>Saving Invoice</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PackingRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>

 
<CFIF ParameterExists(Form.btnCreateInvoice_OK)>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

	<cfset strDate = #Form.txtstrDate#>
	<cfset lngStoreID = #Form.txtlngStoreID#>
	<cfif len(#strDate#) EQ 7>
		<cfset strDate = "0" & "#strDate#" >
	</cfif>

	<!--- Is there any line to invoice ? --->
	<cfset strQuery = "select tblOrderDetail.OrderDetID ">
    <cfset strQuery = strQuery & "FROM tblOrderDetail ">	
	<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#') AND ((tblOrderDetail.QtySupplied)>0) AND ((tblOrderDetail.Status)='Packed'))">
	<CFQUERY name="QQ_Check" datasource="#application.dsn#" > 
	<!--- <CFQUERY  name="QQ_Check" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
		<cfif #QQ_Check.RecordCount# GT 0>
	
	
		<CFSET lngDateTimeToday = 0>
		<CF_GetTodayDateTimeLong>
		<CFSET strSearchIndex = "#lngDateTimeToday#" & "_#strDate#" & "_#lngStoreID#" >

		<CFSET strDateToday = ''>
		<CF_GetTodayDate>

		<!--- Save a record into the invoice header tabel --->
		<cfset strQuery = "INSERT INTO tblOrderInvoiceHeader ( StoreID, InvoiceDate, OrderDate, Status, SearchIndex, Comments ) ">
		<cfset strQuery = strQuery & "Values (#lngStoreID#, '#strDateToday#', '#strDate#', 'Open Invc', '#strSearchIndex#', '#form.comments#' ) ">
		<CFQUERY name="QQ1" datasource="#application.dsn#" > 
		<!--- <CFQUERY  name="QQ1" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<!--- Get the Invoice ID --->
		<cfset strQuery = "SELECT tblOrderInvoiceHeader.InvoiceID ">
		<cfset strQuery = strQuery & "FROM tblOrderInvoiceHeader ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.SearchIndex)='#strSearchIndex#'))">
		<CFQUERY name="QQ2" datasource="#application.dsn#" > 
		<!--- <CFQUERY  name="QQ2" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		<cfset lngInvoiceID = #QQ2.InvoiceID#>
		
		<!--- Mark the order lines as invoiced --->
		<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.Invoiced = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#') AND ((tblOrderDetail.QtySupplied)>0) AND ((tblOrderDetail.Status)='Packed'))">
		<CFQUERY name="QQ3" datasource="#application.dsn#" > 
		<!--- <CFQUERY  name="QQ3" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	
		<!--- Copy the order lines into the invoice table --->
		<cfset strQuery = "INSERT INTO tblOrderInvoiceDetail ( InvoiceID, OrderDetID, StoreID, OrderDate, PartNo, Description, QtyOrdered, QtySupplied, OrderingUnit, SupplyUnit, PrepCode, typeID ) ">
		<cfset strQuery = strQuery & "SELECT #lngInvoiceID# AS InvoiceID, tblOrderDetail.OrderDetID, tblOrderDetail.StoreID, tblOrderDetail.OrderDate, tblOrderDetail.PartNo, tblOrderDetail.Description, tblOrderDetail.QtyOrdered, tblOrderDetail.QtySupplied, tblOrderDetail.OrderingUnit, tblOrderDetail.SupplyUnit, tblOrderDetail.PrepCode, tblOrderDetail.typeID ">
		<cfset strQuery = strQuery & "FROM tblOrderDetail ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#') AND ((tblOrderDetail.QtySupplied)>0) AND ((tblOrderDetail.Invoiced)=1) AND ((tblOrderDetail.Status)='Packed'))">
		 
		 <CFQUERY name="QQ4" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- INSERT INTO tblOrderInvoiceDetail ( 
						InvoiceID, 
						OrderDetID, 
						StoreID, 
						OrderDate, 
						PartNo, 
						Description, 
						QtyOrdered, 
						QtySupplied, 
						OrderingUnit, 
						SupplyUnit, 
						PrepCode, 
						typeID ) 
			SELECT 		lngInvoiceID AS InvoiceID, 
						tblOrderDetail.OrderDetID, 
						tblOrderDetail.StoreID, 
						tblOrderDetail.OrderDate, 
						tblOrderDetail.PartNo, 
						tblOrderDetail.Description, 
						tblOrderDetail.QtyOrdered, 
						tblOrderDetail.QtySupplied, 
						tblOrderDetail.OrderingUnit, 
						tblOrderDetail.SupplyUnit, 
						tblOrderDetail.PrepCode, 
						type
			FROM 		tblOrderDetail 
			WHERE 		(((tblOrderDetail.StoreID)=#lngStoreID#) 
			AND 		((tblOrderDetail.OrderDate)='#strDate#') 
			AND 		((tblOrderDetail.QtySupplied)>0) 
			AND 		((tblOrderDetail.Invoiced)=1) 
			AND 		((tblOrderDetail.Status)='Packed')) --->
		</CFQUERY>
<!--- 		
		<!--- Delete the lines from the order detail table --->
		<cfset strQuery = "DELETE tblOrderDetail.OrderDetID, tblOrderDetail.StoreID, tblOrderDetail.OrderDate, tblOrderDetail.QtySupplied, tblOrderDetail.Invoiced, tblOrderDetail.Status ">
		<cfset strQuery = strQuery & "FROM tblOrderDetail ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#') AND ((tblOrderDetail.QtySupplied)>0) AND ((tblOrderDetail.Invoiced)=Yes) AND ((tblOrderDetail.Status)='Packed'))">
		<CFQUERY  name="QQ5" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
				#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
 --->
		<!--- Delete Remaining Order Lines --->
		<cfset strQuery = "DELETE ">
		<cfset strQuery = strQuery & "FROM tblOrderDetail ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#'))"> 
		<CFQUERY name="QQ5" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- DELETE 
			FROM 	tblOrderDetail 
			WHERE 	(((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#'))
			 --->		<!--- <cfif form.type EQ 1>
						AND (tblOrderDetail.typeID = 1) 
					<cfelse>
						AND (tblOrderDetail.typeID <> 1)
					</cfif>	 --->	
		</CFQUERY>
		
		<!--- Add the costs and rebates from Stock Master for the Normal items--->
		 <cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.Ratio = [tblStockMaster].[Ratio], tblOrderInvoiceDetail.MaxRetailExGST = [tblStockMaster].[MaxRetail], tblOrderInvoiceDetail.SCtoStoreUnitPriceExG = [tblStockMaster].[Wholesale], tblOrderInvoiceDetail.SCRebateUnitExG = [tblStockMaster].[SCRebateVal], tblOrderInvoiceDetail.THRebateUnitExG = [tblStockMaster].[ThreeHRebateVal], tblOrderInvoiceDetail.CostExG = [tblStockMaster].[Cost], tblOrderInvoiceDetail.PluType = [tblStockMaster].[PluType], tblOrderInvoiceDetail.TCode = [tblStockMaster].[TCode], tblOrderInvoiceDetail.PCode = [tblStockMaster].[PCode], tblOrderInvoiceDetail.RCode = [tblStockMaster].[RCode], tblOrderInvoiceDetail.ThreeHRebate = [tblStockMaster].[ThreeHRebate], tblOrderInvoiceDetail.SCRebate = [tblStockMaster].[SCRebate] ">
		<cfset strQuery = strQuery & "From tblOrderInvoiceDetail, tblStockMaster ">
		<cfset strQuery = strQuery & "Where (tblOrderInvoiceDetail.PartNo = tblStockMaster.PartNo) AND (tblOrderInvoiceDetail.InvoiceID=#lngInvoiceID#) AND (tblStockMaster.PluType='N')">
		 <!--- <cfoutput><BR>strQuery1: #strQuery#</cfoutput> --->
		<CFQUERY name="QQ6" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.Ratio 				= [tblStockMaster].[Ratio], 
					tblOrderInvoiceDetail.MaxRetailExGST 		= [tblStockMaster].[MaxRetail], 
					tblOrderInvoiceDetail.SCtoStoreUnitPriceExG = [tblStockMaster].[Wholesale], 
					tblOrderInvoiceDetail.SCRebateUnitExG 		= [tblStockMaster].[SCRebateVal], 
					tblOrderInvoiceDetail.THRebateUnitExG 		= [tblStockMaster].[ThreeHRebateVal], 
					tblOrderInvoiceDetail.CostExG 				= [tblStockMaster].[Cost], 
					tblOrderInvoiceDetail.PluType 				= [tblStockMaster].[PluType], 
					tblOrderInvoiceDetail.TCode 				= [tblStockMaster].[TCode], 
					tblOrderInvoiceDetail.PCode 				= [tblStockMaster].[PCode], 
					tblOrderInvoiceDetail.RCode 				= [tblStockMaster].[RCode], 
					tblOrderInvoiceDetail.ThreeHRebate 			= [tblStockMaster].[ThreeHRebate], 
					tblOrderInvoiceDetail.SCRebate 				= [tblStockMaster].[SCRebate] 
			FROM 	tblOrderInvoiceDetail, 
					tblStockMaster 
			WHERE 	(tblOrderInvoiceDetail.PartNo 				= tblStockMaster.PartNo) 
			AND 	(tblOrderInvoiceDetail.InvoiceID			= lngInvoiceID) 
			AND 	(tblStockMaster.PluType						= 'N') --->
			
		</CFQUERY>

		<!--- Add the costs and rebates from Stock Master for the Sale PLU items--->
		 <cfset strQuery = strQuery & "UPDATE qrytblOrderInvoiceDetail SET qrytblOrderInvoiceDetail.Ratio = [tblStockMaster].[Ratio], qrytblOrderInvoiceDetail.MaxRetailExGST = [tblStockMaster].[MaxRetail], qrytblOrderInvoiceDetail.SCtoStoreUnitPriceExG = [tblStockMaster].[Wholesale], qrytblOrderInvoiceDetail.SCRebateUnitExG = [tblStockMaster].[SCRebateVal], qrytblOrderInvoiceDetail.THRebateUnitExG = [tblStockMaster].[ThreeHRebateVal], qrytblOrderInvoiceDetail.CostExG = [tblStockMaster].[Cost], qrytblOrderInvoiceDetail.PluType = [tblStockMaster].[PluType], qrytblOrderInvoiceDetail.TCode = [tblStockMaster].[TCode], qrytblOrderInvoiceDetail.PCode = [tblStockMaster].[PCode], qrytblOrderInvoiceDetail.RCode = [tblStockMaster].[RCode], qrytblOrderInvoiceDetail.ThreeHRebate = [tblStockMaster].[ThreeHRebate], qrytblOrderInvoiceDetail.SCRebate = [tblStockMaster].[SCRebate] ">
		<cfset strQuery = strQuery & "From tblStockMaster, qrytblOrderInvoiceDetail ">
		<cfset strQuery = strQuery & "WHERE (tblStockMaster.PartNo = qrytblOrderInvoiceDetail.NewPartNo) and (qrytblOrderInvoiceDetail.InvoiceID=#lngInvoiceID#)">
		 <!--- <cfoutput><BR>strQuery2: #strQuery#</cfoutput> --->
		<CFQUERY name="QQ6B" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	qrytblOrderInvoiceDetail 
			SET 	qrytblOrderInvoiceDetail.Ratio = [tblStockMaster].[Ratio], 
					qrytblOrderInvoiceDetail.MaxRetailExGST = [tblStockMaster].[MaxRetail], 
					qrytblOrderInvoiceDetail.SCtoStoreUnitPriceExG = [tblStockMaster].[Wholesale], 
					qrytblOrderInvoiceDetail.SCRebateUnitExG = [tblStockMaster].[SCRebateVal], 
					qrytblOrderInvoiceDetail.THRebateUnitExG = [tblStockMaster].[ThreeHRebateVal], 
					qrytblOrderInvoiceDetail.CostExG = [tblStockMaster].[Cost], 
					qrytblOrderInvoiceDetail.PluType = [tblStockMaster].[PluType], 
					qrytblOrderInvoiceDetail.TCode = [tblStockMaster].[TCode], 
					qrytblOrderInvoiceDetail.PCode = [tblStockMaster].[PCode], 
					qrytblOrderInvoiceDetail.RCode = [tblStockMaster].[RCode], 
					qrytblOrderInvoiceDetail.ThreeHRebate = [tblStockMaster].[ThreeHRebate], 
					qrytblOrderInvoiceDetail.SCRebate = [tblStockMaster].[SCRebate] 
			From 	tblStockMaster, qrytblOrderInvoiceDetail 
			WHERE 	(tblStockMaster.PartNo = qrytblOrderInvoiceDetail.NewPartNo) 
			and 	(qrytblOrderInvoiceDetail.InvoiceID=#lngInvoiceID#)
			 --->
		</CFQUERY>

		<!--- Check Qty Ordered --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.QtyOrdered = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.QtyOrdered) Is Null))">
		 <!--- <cfoutput><BR><BR>strQuery3: #strQuery#</cfoutput> --->
		<CFQUERY name="QQ7" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.QtyOrdered = 0 
			WHERE 	(((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) 
			AND 	((tblOrderInvoiceDetail.QtyOrdered) Is Null)) --->
		</CFQUERY>
		
		<!--- Check Qty Supplied --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.QtySupplied = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.QtySupplied) Is Null))">
		 <!--- <cfoutput><BR><BR>strQuery4: #strQuery#</cfoutput> --->
		<CFQUERY name="QQ8" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.QtySupplied = 0 
			WHERE 	(((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) 
			AND 	((tblOrderInvoiceDetail.QtySupplied) Is Null)) --->
		</CFQUERY>

		<!--- Check MaxRetailExGST --->
		 <cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.MaxRetailExGST = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.MaxRetailExGST) Is Null))">
		
		 <CFQUERY name="QQ9" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.MaxRetailExGST = 0 
			WHERE 	(((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) 
			AND 	((tblOrderInvoiceDetail.MaxRetailExGST) Is Null --->
		</CFQUERY>

		<!--- Check SCtoStoreUnitPriceExG --->
		 <cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.SCtoStoreUnitPriceExG = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.SCtoStoreUnitPriceExG) Is Null))">
		 
		 <CFQUERY name="QQ10" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.SCtoStoreUnitPriceExG = 0 
			WHERE 	(((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) 
			AND 	((tblOrderInvoiceDetail.SCtoStoreUnitPriceExG) Is Null)) --->
		</CFQUERY>

		<!--- Check SCRebateUnitExG --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.SCRebateUnitExG = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.SCRebateUnitExG) Is Null))">
		 
		<CFQUERY name="QQ11" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE 	tblOrderInvoiceDetail 
			SET 	tblOrderInvoiceDetail.SCRebateUnitExG = 0 
			WHERE 	(((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) 
			AND 	((tblOrderInvoiceDetail.SCRebateUnitExG) Is Null))		 --->	
		</CFQUERY>
		
		<!--- Check THRebateUnitExG --->
		 <cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.THRebateUnitExG = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.THRebateUnitExG) Is Null))">
		
		<CFQUERY name="QQ12" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.THRebateUnitExG = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.THRebateUnitExG) Is Null))
			 --->
		</CFQUERY>

		<!--- Check CostExG --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.CostExG = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.CostExG) Is Null))">
		
		<CFQUERY name="QQ13" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.CostExG = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.CostExG) Is Null))
			 --->
		</CFQUERY>

		<!--- Check TCode --->
		 <cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.TCode = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.TCode) Is Null))">
		 
		 <CFQUERY name="QQ14" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.TCode = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.TCode) Is Null))
		 --->
		</CFQUERY>

		<!--- Check PCode --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.PCode = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.PCode) Is Null))">
		
		<CFQUERY name="QQ15" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.PCode = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.PCode) Is Null))
			 --->
		</CFQUERY>

		<!--- Check ThreeHRebate --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.ThreeHRebate = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.ThreeHRebate) Is Null))">
		 
		 <CFQUERY name="QQ16" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.ThreeHRebate = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.ThreeHRebate) Is Null))
			 --->
		</CFQUERY>

		<!--- Check SCRebate --->
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.SCRebate = 0 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.SCRebate) Is Null))">
		
		<CFQUERY name="QQ17" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.SCRebate = 0 
			WHERE (((tblOrderInvoiceDetail.InvoiceID)=#lngInvoiceID#) AND ((tblOrderInvoiceDetail.SCRebate) Is Null))
		 --->
		</CFQUERY>
<!--- 
		SQL Server is unable to perform this.  Do this as soon as you add a new Product.
		<!--- Check items in the stock location --->
		<cfset strQuery = "Select * from qryLocation_AllItems MissingItems">
		<cfoutput><BR>strQuery QQ19: #strQuery#</cfoutput>
		<cfoutput><BR>&nbsp;</cfoutput>
		<CFQUERY name="QQ19" datasource="#application.dsn#" > 
		<!--- <CFQUERY  name="QQ19" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfif #QQ19.recordcount# GT 0>
			<cfset strQuery = "INSERT INTO tblStockLocation ( StoreID, PartNo ) ">
			<cfset strQuery = strQuery & "SELECT [qryLocation_AllItems MissingItems].StoreID, [qryLocation_AllItems MissingItems].PartNo ">
			<cfset strQuery = strQuery & "FROM [qryLocation_AllItems MissingItems]">
			<cfoutput><BR>strQuery QQ20: #strQuery#</cfoutput>
			<cfoutput><BR>&nbsp;</cfoutput>
			<CFQUERY name="QQ20" datasource="#application.dsn#" > 
			<!--- <CFQUERY  name="QQ20" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
 --->
		<!--- Adjust Inventory Levels --->
		<cfset strQuery = "UPDATE tblStockLocation SET tblStockLocation.LastCost = [SCtoStoreUnitPriceExG], tblStockLocation.RetailPrice = [SCtoStoreUnitPriceExG], tblStockLocation.MaxRetail = [MaxRetailExGST], tblStockLocation.QtyOnHand = [QtyOnHand]+[QtySupplied] , tblStockLocation.AverageCost = ([AverageCost] * [QtyOnHand] + [SCtoStoreUnitPriceExG] * [QtySupplied]) / ([QtyOnHand]+[QtySupplied]) ">
		<cfset strQuery = strQuery & "From tblStockLocation, qryInvoiceDetail ">
		<cfset strQuery = strQuery & "WHERE (qryInvoiceDetail.StoreID = tblStockLocation.StoreID) AND (qryInvoiceDetail.PartNo = tblStockLocation.PartNo) AND (qryInvoiceDetail.InvoiceID=#lngInvoiceID#)">
		 <!--- <cfoutput><BR>strQuery QQ21: #strQuery#</cfoutput> --->
		<cfoutput><BR>&nbsp;</cfoutput>
		<CFQUERY name="QQ21" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
			<!--- UPDATE tblStockLocation SET tblStockLocation.LastCost = [SCtoStoreUnitPriceExG], tblStockLocation.RetailPrice = [SCtoStoreUnitPriceExG], tblStockLocation.MaxRetail = [MaxRetailExGST], tblStockLocation.QtyOnHand = [QtyOnHand]+[QtySupplied] , tblStockLocation.AverageCost = ([AverageCost] * [QtyOnHand] + [SCtoStoreUnitPriceExG] * [QtySupplied]) / ([QtyOnHand]+[QtySupplied]) 
			From tblStockLocation, qryInvoiceDetail 
			WHERE (qryInvoiceDetail.StoreID = tblStockLocation.StoreID) AND (qryInvoiceDetail.PartNo = tblStockLocation.PartNo) AND (qryInvoiceDetail.InvoiceID=#lngInvoiceID#)
			 --->
		</CFQUERY>
		
		<p>Finished Saving Invoice</p>
   
    <cfelse>
	
		<p>There is no line to be invoiced.  Please pack some items and try again</p>
	
	</cfif>


	</div>
    </td>
  </tr>
</table>

<CFELSE>	
	<cflocation URL = "PackingRequest.cfm">
</cfif>	
	  
</body>
</HTML>

