
<cfset lngInvoiceID = #Form.selInvoiceID#>
<cfparam name="currentTypeID" default="0">
<cfparam name="subTotal" default="0">
<cfparam name="subTotalGST" default="0">
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

    <!--- Get the store name --->
	<cfset strQuery = "SELECT * from qryInvoiceHeaders where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetHeader"  datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetHeader"  datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetHeader" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get P codes--->
	<cfset strQuery = "SELECT qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "FROM qryInvoiceDetail ">
	<cfset strQuery = strQuery & "GROUP BY qryInvoiceDetail.InvoiceID, qryInvoiceDetail.PCode ">
	<cfset strQuery = strQuery & "HAVING (((qryInvoiceDetail.InvoiceID)= #lngInvoiceID#))">
	<CFQUERY name="GetPCodes"  datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetPCodes"  datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetPCodes" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get the Total --->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotal where InvoiceID = #lngInvoiceID#">
	<CFQUERY name="GetTotals"  datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetTotals"  datasource="#application.dsn#" >  --->
	<!--- <CFQUERY name="GetTotals" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

    <!--- Get the Total Profit--->
	<cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCodeProfit where (InvoiceID = #lngInvoiceID#) and (PCode = 0)">
	<CFQUERY name="GetTotalProfit"  datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetTotalProfit"  datasource="#application.dsn#" >  --->
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
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="50%"><b>#GetHeader.SupplierName#</b><br/>
			#GetHeader.SupplierAddress1#<!--<img src="../images/lanscapeBWSmall.jpg" width="400" height="70">--></td>
		
   		 	<td align="right" width="50%" valign="top"><strong>Delivery Docket</strong>&nbsp;</td>
		</tr>
	</table>
</cfoutput>
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
      <!--- <div align="left">ABN: <b>#GetHeader.ChainABN#</b>&nbsp;</div> --->&nbsp;
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
      <div align="left"><b>Delivery No:&nbsp;&nbsp;&nbsp; #GetHeader.InvoiceID# 
                &nbsp;</b></div>
    </td>
  </tr>
  <tr> 
    <td> 
     <!---  <div align="left">Phone: <b>#GetHeader.ChainPhone#</b>&nbsp;</b></div> --->
	  <!--- <div align="left">Phone: <b>9707 4963</b>&nbsp;</b></div>  --->
	  <div align="left">Phone: <b>#GetHeader.SupplierPhone#</b>&nbsp;</b></div>
    </td>
    <td> 
      <div align="left"><b>Delivered To:</b></div>
    </td>
    <td> 
      <div align="left"><b>#GetHeader.StoreMail#</b><br/>#GetHeader.address#<br/>
		<!---  ---></div>
    </td>

<!--- ************************ --->	
    <td><div align="left"></div> </td>
    <td> 
      <div align="left"><b>Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    #GetHeader.InvoiceDate# </b></div>
    </td>
	
  </tr>
  
  <tr> 
    <td> 
      <!--- <div align="left">Fax: <b>#GetHeader.ChainFax#</b>&nbsp;</div> --->
	 <!---  <div align="left">Fax: &nbsp;&nbsp;&nbsp;<b> 9707 3947</b>&nbsp;</div> --->
	 <div align="left">Fax: <b>#GetHeader.SupplierFax#</b>&nbsp;</div>
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
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">PLU</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">Product</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">Units</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">Price INC GST</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">GST per unit</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">Total</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2">GST Total</font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2"> 
        <!---Max Sell--->
        </font></b></div></td>
    <td bgcolor="99CCFF"> <div align="center"><b><font size="2"> 
        <!---GP %--->
        </font></b></div></td>
  </tr>
  <cfloop query="GetPCodes">
    <cfset lngPCode = #GetPCodes.PCode# >
    <!--- get the lines --->
    <cfset strQuery = "SELECT * from qryInvoiceDetail where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#) order by typeID, Description">
    <cfquery name="GetDetail_A"  datasource="#application.dsn#" >
    <!--- <CFQUERY name="GetDetail_A"  datasource="#application.dsn#" >  --->
    <!--- <CFQUERY name="GetDetail_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
    #PreserveSingleQuotes(strQuery)# 
    </cfquery>
    <!--- Get the Total --->
    <cfset strQuery = "SELECT * from qryInvoiceDetailTotalByPCode where (InvoiceID = #lngInvoiceID#) and (PCode = #lngPCode#)">
    <cfquery name="GetTotals_A"  datasource="#application.dsn#" >
    <!--- <CFQUERY name="GetTotals_A"  datasource="#application.dsn#" >  --->
    <!--- <CFQUERY name="GetTotals_A" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" maxrows="1"> --->
    #PreserveSingleQuotes(strQuery)# 
    </cfquery>
    <cfoutput query = "GetDetail_A"> 
      <cfif typeID NEQ "" AND typeID NEQ "NULL" AND currentTypeID NEQ 0>
        <cfif typeID NEQ currentTypeID>
          <tr> 
            <td colspan="5"> <font size="2"> <b>&nbsp;&nbsp;&nbsp; Sub Total 
              <cfif currentTypeID EQ 1>
                (Early Order Items) 
                <cfelse>
                (Main Order Items) 
              </cfif>
              </b></font></td>
            <td> <div align="right"><font size="2"><b>#numberformat(subTotal,"$______.00")#&nbsp;<b></b></b></font></div></td>
            <td> <div align="right"><font size="2"><b>#numberformat(subTotalGST,"$______.00")#&nbsp;<b></b></b></font></div></td>
            <td colspan="2"> <div align="right"><font size="2">&nbsp;</font></div></td>
          </tr>
          <!--- <tr> 
				  		<td colspan="9">&nbsp;</td>
					</tr> --->
          <cfset subTotal = 0>
          <cfset subTotalGST = 0>
          <cfset currentTypeID = typeID>
        </cfif>
        <cfelseif currentTypeID EQ 0>
        <cfset currentTypeID = typeID>
      </cfif>
      <cfset subTotal = subTotal + GetDetail_A.TotalPriceIncTax>
      <cfset subTotalGST = subTotalGST + GetDetail_A.TotalTax>
      <tr> 
        <td> <div align="center"><font size="2">#GetDetail_A.PartNo#&nbsp;</font></div></td>
        <td><font size="2">#GetDetail_A.Description#&nbsp;</font></td>
        <td> <div align="center"><font size="2">#GetDetail_A.QtySup#&nbsp;</font></div></td>
        <td><div align="right"><font size="2">#numberformat(GetDetail_A.UnitPriceIncTax,"$______.00")#&nbsp;</font></div></td>
        <td> <div align="right"><font size="2">#numberformat(GetDetail_A.UnitTax,"$______.00")#&nbsp;</font></div></td>
        <td> <div align="right"><font size="2">#numberformat(GetDetail_A.TotalPriceIncTax,"$______.00")#&nbsp;</font></div></td>
        <td> <div align="right"><font size="2">#numberformat(GetDetail_A.TotalTax,"$______.00")#&nbsp;</font></div></td>
        <cfif #lngPCode# EQ 0>
          <td> <div align="right"><font size="2"> 
            <!---#numberformat(GetDetail_A.MaxRetailIncGST,"$______.00")#&nbsp;</font></div>--->
          </td>
          <td> <div align="right"><font size="2"> 
            <!---#numberformat(GetDetail_A.GP,"______.00")#&nbsp;</font></div>--->
          </td>
          <cfelse>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </cfif>
      </tr>
    </cfoutput> 
    <!--- This is for the last group's sub total, as the looping would be finished without printing out the last group's
		  		sub total, so force printing here --->
    <cfoutput> 
      <cfif currentTypeID NEQ 0>
        <tr> 
          <td colspan="5"> <font size="2"> <b>&nbsp;&nbsp;&nbsp; Sub Total 
            <cfif currentTypeID EQ 1>
              (Early Order Items) 
              <cfelse>
              (Main Order Items) 
            </cfif>
            </b></font></td>
          <td> <div align="right"><font size="2"><b>#numberformat(subTotal,"$______.00")#&nbsp;<b></b></b></font></div></td>
          <td> <div align="right"><font size="2"><b>#numberformat(subTotalGST,"$______.00")#&nbsp;<b></b></b></font></div></td>
          <td colspan="2"> <div align="right"><font size="2">&nbsp;</font></div></td>
        </tr>
        <tr> 
          <td colspan="9">&nbsp;</td>
        </tr>
        <cfset subTotal = 0>
        <cfset subTotalGST = 0>
        <cfset currentTypeID = 0>
      </cfif>
    </cfoutput> <cfoutput query = "GetTotals_A"> 
      <!--- - wb 29/02/2004 - get PCode Descriptions - --->
      <cfquery name="qGetPCodeDescription"  datasource="#application.dsn#" maxrows="1">
      SELECT PCodeDescription FROM tblPCodes WHERE PCodeID=#lngPCode# 
      </cfquery>
      <tr> 
        <td colspan="5"><font size="2"><b>Sub Total #lngPCode# 
          <cfif qGetPCodeDescription.recordCount GT 0>
            #qGetPCodeDescription.PCodeDescription# 
          </cfif>
          </b></font></td>
        <td> <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalIncGST,"$______.00")#&nbsp;<b></b></b></font></div></td>
        <td> <div align="right"><font size="2"><b>#numberformat(GetTotals_A.GrandTotalGST,"$______.00")#&nbsp;<b></b></b></font></div></td>
        <td colspan="2"> <div align="right"><font size="2">&nbsp;</font></div></td>
      </tr>
      <tr> 
        <td colspan="9">&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="9">&nbsp;</td>
      </tr>
    </cfoutput> 
  </cfloop>
  <cfoutput query = "GetTotals"> 
    <tr> 
      <td colspan="2"> <div align="right"><font size="2"><b> 
          <!---Profit--->
          </b></font></div></td>
      <td colspan="2"> <div align="right"><font size="2"><b> 
          <!---#numberformat(dblMaxProfit,"$______.00")#&nbsp;--->
          </b></font></div></td>
      <td colspan="3"> <div align="right"><font size="2"><b>GST Total:</b></font></div></td>
      <td colspan="2"> <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalGST,"$______.00")#&nbsp;</b></font></div></td>
    </tr>
    <tr> 
      <td colspan="2"> <div align="right"><font size="2"><b> 
          <!---Profit GP%--->
          </b></font></div></td>
      <td colspan="2"> <div align="right"><font size="2"><b> 
          <!---#numberformat(dblProfitGP,"______.00")#&nbsp;--->
          </b></font></div></td>
      <td colspan="3"> <div align="right"><font size="2"><b>Goods Total:</b></font></div></td>
      <td colspan="2"> <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalGoods,"$______.00")#&nbsp;</b></font></div></td>
    </tr>
    <tr> 
      <td colspan="7"> <div align="right"><font size="2"><b>GST Inc Total:</b></font></div></td>
      <td colspan="2"> <div align="right"><font size="2"><b>#numberformat(GetTotals.GrandTotalIncGST,"$______.00")#&nbsp;</b></font></div></td>
    </tr>
    <tr>
      <td colspan="2" > <div align="left"><font size="2"><b> Carton qty & weight 
          correct, goods received in good order & condition. Signed:
<div> </div>
          </b></font></div></td>
      <td colspan="3">&nbsp; </td>
      <td colspan="2" valign="bottom"> <div align="left"><font size="2"><b> Driver 
          Signature 
          <div> </div>
          </b></font></div></td>
    </tr>
	    <tr> 
      <td height="92" colspan="2" valign="bottom"> <div align="left"><font size="2"><b> 
          <hr color="##000000">
          <div> </div>
          </b></font></div></td>
      <td colspan="3">&nbsp; </td>
      <td colspan="2" valign="bottom"> <div align="left"><font size="2"><b> 
          <hr color="##000000">
          <div> </div>
          </b></font></div></td>
    </tr>
    </tr>
    <td height="4"></tr>
  </cfoutput> 
</table>
</body>
</html>
