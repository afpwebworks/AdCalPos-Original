
<cfset lngInvoiceID = #URL.VV#>

<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Invoice</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000">
    <!--- Get the store name --->
	<cfset strQuery = "SELECT * from qryInvoiceHeaders where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetHeader" datasource="#application.dsn#"  > 
	<!--- <CFQUERY name="GetHeader" datasource="#application.dsn#"  >  --->
	<!--- <CFQUERY name="GetHeader" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get P codes--->
	<cfset strQuery = "SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "FROM qryInvoiceDetail ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "HAVING (((qryInvoiceDetail.InvoiceID)= #lngInvoiceID#))">
	<CFQUERY name="GetPCodes" datasource="#application.dsn#"  > 
	<!--- <CFQUERY name="GetPCodes" datasource="#application.dsn#"  >  --->
	<!--- <CFQUERY name="GetPCodes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get the Total --->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotal where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetTotals" datasource="#application.dsn#"  > 
	<!--- <CFQUERY name="GetTotals" datasource="#application.dsn#"  >  --->
	<!--- <CFQUERY name="GetTotals" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
<table width="100%" border="0">
<tr><td align="right"><strong>Tax Invoice</strong>&nbsp;</td></tr>
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
        <div align="left"><b>#GetHeader.SupplierName#&nbsp;</b></div>
      </td>
      <td> 
        <div align="left"><b>Sold To:</b></div>
      </td>
      <td> 
        <div align="left"><b>#GetHeader.ChainName#&nbsp;</b></div>
      </td>
      <td> 
        <div align="left"><b>Invoice No:</b></div>
      </td>
      <td> 
        <div align="right"><b>#GetHeader.InvoiceID#&nbsp;</b></div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="left"><b>#GetHeader.SupplierAddress1#&nbsp;</b></div>
      </td>
      <td> 
        <div align="left">Store</div>
      </td>
      <td> 
        <div align="left"><b>#GetHeader.StoreName#&nbsp;</b></div>
      </td>
      <td> 
        <div align="left"><b>Date:</b></div>
      </td>
      <td> 
        <div align="right"><b>#GetHeader.InvoiceDate#&nbsp;</b></div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="left">ABN: <b>#GetHeader.SupplierABN#&nbsp;</b></div>
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
        <div align="left">Phone: <b>#GetHeader.SupplierPhone#&nbsp;</b></div>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td> 
        <div align="left">Store Phone:</div>
      </td>
      <td> 
        <div align="right"><b>#GetHeader.Phone#&nbsp;</b></div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="left">Fax: <b>#GetHeader.SupplierFax#&nbsp;</b></div>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td> 
        <div align="left">Store Fax: </div>
      </td>
      <td> 
        <div align="right"><b>#GetHeader.Fax#&nbsp;</b></div>
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
  </tr>
  <CFLOOP QUERY="GetPCodes"> 
    <cfset lngPCode = #GetPCodes.PCode# >
		<!--- get the lines --->
		<cfset strQuery = "SELECT * from qryInvoiceDetail where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#) order by Description">
		<CFQUERY name="GetDetail_A" datasource="#application.dsn#"  > 
		<!--- <CFQUERY name="GetDetail_A" datasource="#application.dsn#"  >  --->
		<!--- <CFQUERY name="GetDetail_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	    <!--- Get the Total --->
		<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCode where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#)">
		<CFQUERY name="GetTotals_A" datasource="#application.dsn#"  > 
		<!--- <CFQUERY name="GetTotals_A" datasource="#application.dsn#"  >  --->
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
    <td><div align="right"><font size="2">#numberformat(GetDetail_A.THinvoiceUnitPriceIncTax,"$______.00")#&nbsp;</font></div></td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.THinvoiceUnitTax,"$______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.THinvoiceUnitPriceIncTaxTotal,"$______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail_A.THinvoiceUnitTaxTotal,"$______.00")#&nbsp;</font></div>
    </td>
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
    <td colspan="5"><font size="2"><b>Sub Total  #lngPCode# <cfif qGetPCodeDescription.recordCount GT 0>#qGetPCodeDescription.PCodeDescription#</cfif></b></font></td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalTHinvoiceUnitPriceIncTaxTotal,"$______.00")#&nbsp;<b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalTHinvoiceUnitTaxTotal,"$______.00")#&nbsp;<b></font></div>
    </td>
  </tr>
  <tr> 
  	<td colspan="7">&nbsp;</td>
  </tr>  
</cfoutput>  
  </cfloop>

<cfoutput Query = "GetTotals">
  <tr> 
    <td colspan="5"> 
      <div align="right"><font size="2"><b>GST Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalTHinvoiceUnitTaxTotal,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="5"> 
      <div align="right"><font size="2"><b>Goods Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalTHinvoiceGoodsTotal,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="5"> 
      <div align="right"><font size="2"><b>GST Inc Total:</b></div>
    </td>
    <td colspan="2"> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalTHinvoiceUnitPriceIncTaxTotal,"$______.00")#&nbsp;</b></font></div>
    </td>
	
	<tr>
	 <td height="100" colspan="2" valign="bottom"> 
	 	 <div align="left"><font size="2"><b>
		 	<hr color="##000000"> 
		  <div>
    </td>
	<td colspan="3">&nbsp; 
		 
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
	<td colspan="3">&nbsp; 
		 
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
