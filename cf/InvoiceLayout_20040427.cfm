
<cfset lngInvoiceID = #Form.selInvoiceID#>
<CFIF ParameterExists(Form.Submit3H)>
	<CFLOCATION url="InvoiceLayout3H.cfm?VV=#lngInvoiceID#">
</cfif>
<CFIF ParameterExists(Form.SubmitRebate)>
	<CFLOCATION url="InvoiceLayoutRebate.cfm?VV=#lngInvoiceID#">
</cfif>

<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Invoice</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<!--- - wb 08/01/2004 - Moved within the body tags <p><img src="../images/lanscapeBWSmall.jpg" width="400" height="70"></p> - --->


<body bgcolor="#FFFFFF" text="#000000">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="50%"><img src="../images/lanscapeBWSmall.jpg" width="400" height="70"></td>
		<td align="right" width="50%" valign="top"><strong>Tax Invoice</strong>&nbsp;</td>
	</tr>
</table>
    <!--- Get the store name --->
	<cfset strQuery = "SELECT * from qryInvoiceHeaders where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetHeader" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetHeader" datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetHeader" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get P codes--->
	<cfset strQuery = "SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "FROM qryInvoiceDetail ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "HAVING (((qryInvoiceDetail.InvoiceID)= #lngInvoiceID#))">
	<CFQUERY name="GetPCodes" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetPCodes" datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetPCodes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get the Total --->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotal where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetTotals" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetTotals" datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetTotals" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get the Total Profit--->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCodeProfit where (InvoiceID = #lngInvoiceID#) and (PCode = 0)">
	<CFQUERY name="GetTotalProfit" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetTotalProfit" datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetTotalProfit" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <cfif #GetTotalProfit.RecordCount# GT 0>
	    <cfset dblMaxProfit = #GetTotalProfit.GrandTotalProfit#>
	    <cfset dblProfitGP = #GetTotalProfit.GranProfitGP#>
	<cfelse>
	    <cfset dblMaxProfit = 0>
	    <cfset dblProfitGP = 0>
	</cfif>
<table width="100%" border="0">
<tr>
  <cfoutput>
  <td><div align="right"><a href="InvoiceRequest.cfm?IID=#lngInvoiceID#">back</a>&nbsp;</div></td>
  </cfoutput>
</tr>
<tr>
  <td>
<cfoutput Query ="GetHeader">
<table width="100%" border="0">
  <tr> 
    <td> 
      <div align="left">ABN: <b>#GetHeader.ChainABN#</b>&nbsp;</div>
    </td>
    <td> 
      <div align="left">Store No:</div>
    </td>
    <td> 
      <div align="left"><b>#GetHeader.StoreID#&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
	<td>
      <div align="left"><b>Invoice No:&nbsp;&nbsp;&nbsp; #GetHeader.InvoiceID# &nbsp;</b></div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="left">Phone: <b>#GetHeader.ChainPhone#</b>&nbsp;</b></div>
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
	    #GetHeader.InvoiceDate# </b></div>
    </td>
	
  </tr>
  
  <tr> 
    <td> 
      <div align="left">Fax: <b>#GetHeader.ChainFax#</b>&nbsp;</div>
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
      <div align="left"><b>#GetHeader.Manager1Name#&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
    <td> 
      <div align="left">Store Phone: &nbsp;&nbsp;#GetHeader.Phone#</div>
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
      <div align="left"><b>#GetHeader.Manager2Name#&nbsp;</b></div>
    </td>

<!--- ************************ --->	
    <td>&nbsp;  </td>
    <td> 
      <div align="left">Store Fax: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#GetHeader.Fax#&nbsp;</div>
    </td>
  </tr>
  <cfif GetHeader.Comments NEQ ''>
  	<tr><td colspan="5"><br /><strong>Comments:</strong> #GetHeader.Comments#</td></tr>
  </cfif>	
</table>
</cfoutput>
    </td>
  </tr>	
</table>	
<p>&nbsp;</p>

<table width="100%" border="0" cellspacing="0" bordercolor="000000">
  <tr> 
    <td bgcolor="99CCFF"> 
      <div align="left"><b><font size="2">PLU</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="left"><b><font size="2">Product</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">Units</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">Price INC GST</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">GST per unit</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">Total</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">GST Total</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">Max Sell</font></b></div>
    </td>
    <td bgcolor="99CCFF"> 
      <div align="right"><b><font size="2">GP %</font></b></div>
    </td>
  </tr>

  <CFLOOP QUERY="GetPCodes"> 
    <cfset lngPCode = #GetPCodes.PCode# >
		<!--- get the lines --->
		<cfset strQuery = "SELECT * from qryInvoiceDetail where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#) order by Description">
		<CFQUERY name="GetDetail_A" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetDetail_A" datasource="#application.dsn#" >  --->
		<!--- <CFQUERY name="GetDetail_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	    <!--- Get the Total --->
		<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCode where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#)">
		<CFQUERY name="GetTotals_A" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetTotals_A" datasource="#application.dsn#" >  --->
		<!--- <CFQUERY name="GetTotals_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
<cfoutput Query = "GetDetail_A">
  <tr> 
    <td> 
      <div align="left"><font size="2">#GetDetail_A.PartNo#&nbsp;</font></div>
    </td>
    <td><font size="2">#GetDetail_A.Description#&nbsp;</font></td>
    <td> 
      <div align="right"><font size="2">#GetDetail_A.QtySup#&nbsp;</font></div>
    </td>
    <td><div align="right"><font size="2">#numberformat(GetDetail_A.UnitPriceIncTax,"$______.00")#&nbsp;</font></div></td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.UnitTax,"$______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.TotalPriceIncTax,"$______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.TotalTax,"$______.00")#&nbsp;</font></div>
    </td>
<cfif #lngPCode# EQ 0>	
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.MaxRetailIncGST,"$______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.GP,"______.00")#&nbsp;</font></div>
    </td>
<cfelse>	
    <td>&nbsp;</td>
    <td>&nbsp;</td>	
</cfif> 	
  </tr>
</cfoutput>  
<cfoutput Query = "GetTotals_A">
<!--- - wb 29/02/2004 - get PCode Descriptions - --->
<CFQUERY name="qGetPCodeDescription" datasource="#application.dsn#"  maxrows="1">
SELECT PCodeDescription
FROM tblPCodes
WHERE PCodeID=#lngPCode#	
</CFQUERY>
  <tr> 
 
    <td colspan="5"><font size="2"><b>Sub Total #lngPCode# <cfif qGetPCodeDescription.recordCount GT 0>#qGetPCodeDescription.PCodeDescription#</cfif></b></font></td>
 
	<td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalIncGST,"$______.00")#&nbsp;<b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalGST,"$______.00")#&nbsp;<b></font></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2">&nbsp;</font></div>
    </td>
  </tr>
  <tr> 
  	<td colspan="9">&nbsp;</td>
  </tr>  
</cfoutput>  
  </cfloop>

<cfoutput Query = "GetTotals">
  <tr> 
    <td colspan="2">
		<div align="right"><font size="2"><b>Profit</b></div>
	</td>
    <td colspan="2">
		<div align="right"><font size="2"><b>#numberformat(dblMaxProfit,"$______.00")#&nbsp;</b></font></div>
	</td>
    <td colspan="3"> 
      <div align="right"><font size="2"><b>GST Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalGST,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2">
		<div align="right"><font size="2"><b>Profit GP%</b></div>
	</td>
    <td colspan="2">
		<div align="right"><font size="2"><b>#numberformat(dblProfitGP,"______.00")#&nbsp;</b></font></div>
	</td>
    <td colspan="3"> 
      <div align="right"><font size="2"><b>Goods Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalGoods,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="7"> 
      <div align="right"><font size="2"><b>GST Inc Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalIncGST,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  
  <!--- Delivery signatures --->
  	<tr>
	 <td height="100" colspan="2" valign="bottom"> 
	 	 <div align="left"><font size="2"><b>
		 	<hr color="##000000"> 
		  <div>
    </td>
	<td colspan="4">&nbsp; 
		 
    </td>
	<td colspan="2" valign="bottom"> 
	 	 <div align="left"><font size="2"><b>
		 	<hr color="##000000"> 
		  <div>
    </td>
	</tr>
  <td height="4"></tr>
  <tr>
	 <td colspan="2" > 
	 	 <div align="left"><font size="2"><b>
		 	Store Signature 
		  <div>
    </td>
	<td colspan="4">&nbsp; 
		 
    </td>
	<td colspan="2" valign="bottom"> 
	 	 <div align="left"><font size="2"><b>
		 	Driver Signature 
		  <div>
    </td>
	</tr>
  <td height="4"></tr>

</cfoutput>  
</table>
</body>
</html>
