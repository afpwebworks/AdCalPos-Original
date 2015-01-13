
<cfset lngInvoiceID = #URL.VV#>

<html>
<head>
<link rel="stylesheet" type="text/css" href="costi_BlackFont.css">
<title>Margin Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">

    <!--- Get the store name --->
	<cfset strQuery = "SELECT * from qryInvoiceHeaders where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetHeader" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetHeader" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get P codes--->
	<cfset strQuery = "SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "FROM qryInvoiceDetail ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "HAVING (((qryInvoiceDetail.InvoiceID)= #lngInvoiceID#))">
	<CFQUERY name="GetPCodes" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetPCodes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
    <!--- Get the Total --->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotalRebate where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetTotals" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetTotals" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
<table width="100%" border="0">
<tr>
  <cfoutput>
  <td><div align="right"><a href="InvoiceRequest.cfm?IID=#lngInvoiceID#">back</a></div></td>
  </cfoutput>
</tr>
<tr>
  <td>	
<cfoutput Query ="GetHeader">
  <table width="100%" border="0">
    <tr> 
      <td> 
        <div align="left"><b>Margin Report for Invoice: #GetHeader.InvoiceID#&nbsp;</b></div>
      </td>
      <td> 
        <div align="center"><b>Store: #GetHeader.StoreName#&nbsp;</b></div>
      </td>
      <td> 
        <div align="right"><b>Date: #GetHeader.InvoiceDate#&nbsp;</b></div>
      </td>
    </tr>
  </table>
</cfoutput>	
    </td>
  </tr>	
</table>
<br>

<table width="100%" border="0" cellspacing="0" bordercolor="000000">
  <tr> 
    <td> 
      <div align="left"><b><font size="2">PLU</font></b></div>
    </td>
    <td> 
      <div align="left"><b><font size="2">Product</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Qty/Pk</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Price INC GST</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Margin Code</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">W/H</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Dist</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Ratio</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">W/H Margin</font></b></div>
    </td>
    <td> 
      <div align="right"><b><font size="2">Dist Margin</font></b></div>
    </td>
  </tr>
  <CFLOOP QUERY="GetPCodes"> 
    <cfset lngPCode = #GetPCodes.PCode# >
		<!--- get the lines --->
		<cfset strQuery = "SELECT * from qryInvoiceDetail where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#) order by Description">
		<CFQUERY name="GetDetail" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	    <!--- Get the Total --->
		<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCode where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#)">
		<CFQUERY name="GetTotals_A" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="GetTotals_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
  
<cfoutput Query = "GetDetail">
  <tr> 
    <td> 
      <div align="left"><font size="2">#GetDetail.PartNo#&nbsp;</font></div>
    </td>
    <td><font size="2">#GetDetail.Description#&nbsp;</font></td>
    <td> 
      <div align="right"><font size="2">#GetDetail.QtySup#&nbsp;</font></div>
    </td>
    <td><div align="right"><font size="2">#numberformat(GetDetail.UnitPriceIncTax,"$______.00")#&nbsp;</font></div></td>
    <td> 
      <div align="right"><font size="2">#GetDetail.RCode#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail.ThreeHRebate,"______.000")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail.SCRebate,"______.000")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail.Ratio,"______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail.THRebateUnitExGTotal,"______.00")#&nbsp;</font></div>
    </td>
    <td> 
      <div align="right"><font size="2">#numberformat(GetDetail.SCRebateUnitExGTotal,"______.00")#&nbsp;</font></div>
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
    <td colspan="8"><font size="2"><b>Sub Total #lngPCode#  <cfif qGetPCodeDescription.recordCount GT 0> #qGetPCodeDescription.PCodeDescription#</cfif></b></font></td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalTHRebate,"$______.00")#&nbsp;<b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalSCRebate,"$______.00")#&nbsp;<b></font></div>
    </td>
  </tr>
  <tr> 
  	<td colspan="10">&nbsp;</td>
  </tr>  
</cfoutput>  

  </cfloop>
  
<cfoutput Query = "GetTotals">
  <tr> 
    <td colspan="10">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="8"> 
      <div align="right"><font size="2"><b>Margin (Ex Tax):</b></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalTHRebate,"$______.00")#&nbsp;</b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalSCRebate,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="8"> 
      <div align="right"><font size="2"><b>Goods Total (Ex Tax):</b></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalTHinvoiceGoodsTotal,"$______.00")#&nbsp;</b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalGoods,"$______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="8"> 
      <div align="right"><font size="2"><b>GP %:</b></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GPTH,"______.00")#&nbsp;</b></font></div>
    </td>
    <td> 
      <div align="right"><font size="2"><b>#numberformat(GetTotals.GPSC,"______.00")#&nbsp;</b></font></div>
    </td>
  </tr>
</cfoutput>  
</table>
</body>
</html>
