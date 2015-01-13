

<cfset strDate = #URL.dd#>
<cfset lngStoreID = #URL.SID#>

    <!--- Get Store Name --->
	<cfset strQuery = "SELECT * from tblStores ">
	<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
	<CFQUERY name="GetHeader" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Invoice</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<p><img src="../images/lanscapeBWSmall.jpg" width="400" height="70"></p>


<body bgcolor="#FFFFFF" text="#000000">

    <!--- Get Lines --->
	<cfset strQuery = "SELECT  tblOrderDetail.PartNo, tblOrderDetail.Description, tblOrderDetail.QtyOrdered,tblOrderDetail.QtySupplied ,  tblStockMaster.Wholesale, convert(varchar, tblOrderDetail.QtyOrdered ) + ' ' + tblOrderDetail.OrderingUnit as QtyOrd, convert(varchar, tblOrderDetail.QtySupplied ) + ' ' + tblOrderDetail.SupplyUnit as QtySup, tblOrderDetail.PrepCode ">
	<cfset strQuery = strQuery & "FROM tblStockDept INNER JOIN tblStockGroup ON tblStockDept.DeptNo = tblStockGroup.DeptNo INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo INNER JOIN tblOrderDetail ON tblStockMaster.PartNo = tblOrderDetail.PartNo ">
	<cfset strQuery = strQuery & "Where StoreID = #lngStoreID# and OrderDate = '#strDate#' and ( (QtyOrdered > 0 ) or (QtySupplied > 0) ) ">
	<cfset strQuery = strQuery & "Order by tblStockDept.DeptNo,  tblOrderDetail.Description">
	<CFQUERY name="GetLines" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

<table width="100%" border="0">
<tr>
  <cfoutput>
  &nbsp;
  <!--- <td><div align="right"><a href="InvoiceRequest.cfm?IID=#lngInvoiceID#">back</a></div></td> --->
  </cfoutput>
</tr>
<tr>
  <td>
<cfoutput>
<table width="100%" border="0">
  <tr> 
    <td> 
      <div align="left">ABN: <b>&nbsp;</b>&nbsp;</div>
    </td>
    <td> 
      <div align="left">Store No:</div>
    </td>
    <td> 
      <div align="left"><b>#lngStoreID#&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
	<td>
      <div align="left"><b>Invoice No:&nbsp;&nbsp;&nbsp;&nbsp;</b></div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="left">Phone: <b></b>&nbsp;</b></div>
    </td>
    <td> 
      <div align="left"><b>Sold To:</b></div>
    </td>
    <td> 
      <div align="left"><b>#GetHeader.StoreName#&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
    <td> 
      <div align="left"><b>Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    #strDate# </b></div>
    </td>
	
  </tr>
  
  <tr> 
    <td> 
      <div align="left">Fax: <b></b>&nbsp;</div>
    </td>
    <td> 
      <div align="left">&nbsp;</div>
    </td>
    <td> 
      <div align="left"><b>&nbsp;</b></div>
    </td>
    <td> 
      <div align="left">&nbsp;</div>
    </td>
    <td> 
      <div align="right"><b>&nbsp;</b></div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="left">&nbsp;</div>
    </td>
    <td> 
      <div align="left">Contact 1:</div>
    </td>
    <td> 
      <div align="left"><b>&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
    <td> 
      <div align="left">Store Phone: &nbsp;&nbsp;</div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="left">&nbsp;</b></div>
    </td>
    <td> 
      <div align="left">Contact 2:</div>
    </td>
    <td> 
      <div align="left"><b>&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
    <td> 
      <div align="left">Store Fax: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </td>
  </tr>
</table>
</cfoutput>
    </td>
  </tr>	
</table>	
<p>&nbsp;</p>

<table width="100%" border="0" cellspacing="0" bordercolor="000000">
  <tr> 
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">PLU</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">Product</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">Qty Ordered</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">Qty Supplied</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">Checking</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="center"><b><font size="2">Unit Wholesale</font></b></div>
    </td>
  </tr>

<cfoutput Query = "GetLines">

  <tr> 
    <td> 
	  <cfif #len(GetLines.PrepCode)# GT 0>
			<!--- Get the wholesale off the prep coded item in the stock master --->
	  		<cfset dblWholeSaleValue = 0 >
	  		<cfset strPrepPartNo = #GetLines.PartNo# & #GetLines.PrepCode# >			
			<cfset strQuery = "SELECT  Wholesale ">
			<cfset strQuery = strQuery & "FROM tblStockMaster ">
			<cfset strQuery = strQuery & "Where PartNo = '#strPrepPartNo#' ">
			<CFQUERY name="GetPrepLine" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #GetPrepLine.RecordCount# GT 0>
	  			<cfset dblWholeSaleValue = #GetPrepLine.Wholesale# >
			</cfif>
	  <cfelse>
	  		<cfset dblWholeSaleValue = #GetLines.Wholesale# >
	  </cfif>
      <div align="center"><font size="2">#GetLines.PartNo#&nbsp;</font></div>
    </td>
    <td><font size="2">#GetLines.Description#&nbsp;</font></td>
    <td> 
      <div align="center"><font size="2">#GetLines.QtyOrd#&nbsp;</font></div>
    </td>
    <td> 
      <div align="center"><font size="2">#GetLines.QtySup#&nbsp;</font></div>
    </td>
    <td> 
		<cfset dblQtyOrdered = #GetLines.QtyOrdered# >
		<cfset dblQtySupplied = #GetLines.QtySupplied# >
		<cfif dblQtySupplied GTE dblQtyOrdered>
			<cfset strMSG = "">
		<cfelse>
			<cfset strMSG = "Short Supplied">
		</cfif>
        <div align="center"><font size="2">#strMSG#&nbsp;</font></div>
    </td>
    <td> 
      <div align="center"><font size="2">#numberformat(dblWholeSaleValue,"$_______.00")#&nbsp;</font></div>
    </td>
  </tr>
</cfoutput>  
</table>
<br>
<hr>
<br>
<br>
<br>
<br>

</body>
</html>
