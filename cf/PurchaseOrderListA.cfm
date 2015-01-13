
<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->
<!--- Get the date --->
<cfset strDate = #URL.DD#>
<cfset lngStoreID = #session.storeid#>
<!--- get the number of lines --->
<cfset strQuery = "SELECT qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate, Count(qryPurchaseOrder.OrderDetID) AS NumLines ">
<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING (((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#'))">
<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNumRecordQry">
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfif #GetNumRecordQry.RecordCount# GT 0>
	<cfset lngNumRecords = #GetNumRecordQry.NumLines#>
<cfelse>
	<cfset lngNumRecords = 0>
</cfif>
<!--- get the Departments --->
<cfset strQuery = "SELECT qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.BackGroundColor ">
<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.BackGroundColor, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING (((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#')) ">
<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.DeptNo">

<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments">
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strQuery = "SELECT tblOrderHeader.OrderID, tblOrderHeader.Comments ">
<cfset strQuery = strQuery & "FROM tblOrderHeader">

<CFQUERY name="GetComments" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>



<html>
<head>
	<title>Purchase Order</title>
</head>
<link rel="stylesheet" type="text/css" href="costi.css">
<body>
<a name="PageTop"></a>
<FORM action="PurchaseOrderActionEdit.cfm" method="post">
<!--- Write the number of lines here  --->
<cfoutput>
<input type="hidden" name="txtNumLines" value="#lngNumRecords#">
</cfoutput>
  <table width="960" border="0" bordercolor="CFCDCB" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="117" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td>
      <td width="163"> 
        <div align="center"><b><font size="2" face="Tahoma">Description</font></b></div>
    </td>
      <td width="35"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty</font></b></div>
    </td>
      <td width="153"> 
        <div align="center"><b><font size="2" face="Tahoma">Unit (Min)</font></b></div>
    </td>

<!---     <td width="100"> 
      <div align="center"><b><font size="2" face="Tahoma">Dept</font></b></div>
    </td>
 ---> 
 
      <td width="119" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td>

      <td width="163"> 
        <div align="center"><b><font size="2" face="Tahoma">Description</font></b></div>
    </td>
      <td width="35"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty</font></b></div>
    </td>
      <td width="153"> 
        <div align="center"><b><font size="2" face="Tahoma">Unit (Min)</font></b></div>
    </td>

      <td width="119" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td>

      <td width="163"> 
        <div align="center"><b><font size="2" face="Tahoma">Description</font></b></div>
    </td>
      <td width="35"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty</font></b></div>
    </td>
      <td width="153"> 
        <div align="center"><b><font size="2" face="Tahoma">Unit (Min)</font></b></div>

  </tr>
<cfset lngGlobalRecordNumber = 0>
<cfset lngGlobalLineNumber = 0>

  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
	   <tr> 
      		<td height="40" bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4"><a href="##PageTop">Up</a></font></b></div>
      		</td>
      		<td height="40" colspan="10" bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4">#GetDepartments.Dept#</font></b></div>
      		</td>
      		<td height="40" bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4"><a href="##PageBottom">Down</a></font></b></div>
      		</td>
    	</tr>
		</cfoutput>
		<!--- get the lines --->
		<cfset strQuery = "SELECT qryPurchaseOrder.Description, qryPurchaseOrder.DeptNo, * ">
		<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
		<cfset strQuery = strQuery & "WHERE (((qryPurchaseOrder.DeptNo)=#lngDeptNo#) AND ((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#')) ">
		<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.Description">
		<CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord">
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

  <cfoutput query = "GetRecord">
	<cfif (#GetRecord.CurrentRow# mod 3) EQ 1>
		<cfset lngGlobalLineNumber = lngGlobalLineNumber + 1>  
	  	<cfif (#lngGlobalLineNumber# mod 2) EQ 1>
            <cfset strFontColor = "FFFFFF">
			<tr bgcolor="3366FF">
		<cfelse>
            <cfset strFontColor = "FFFFFF">
			<tr> 	
		</cfif>	
	</cfif>	
        <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
        <input type="hidden" name="txtID#lngGlobalRecordNumber#" value="#GetRecord.OrderDetID#">
        <input type="hidden" name="txtPartNo#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
        <input type="hidden" name="txtMinQty#lngGlobalRecordNumber#" value="#GetRecord.MinQty#">
						
<!--- 	    <td width="117" bgcolor="3366FF"><font size="2" face="Tahoma"> 
          <div align="center">#GetRecord.PartNo#</div>

          </font></td>
 --->	    <td width="117"><font size="2" face="Tahoma" font color="#strFontColor#"> 
          <div align="center">#GetRecord.PartNo#</div>
          </font></td>
    	<td width="163"><font size="2" face="Tahoma" font color="#strFontColor#"><b>#GetRecord.Description#</b></font></td>
	    <td width="35"><font size="2" face="Tahoma" font color="#strFontColor#">
		<div align="center"><input type="text" name="txtQTY#lngGlobalRecordNumber#" maxlength="5" size = "5" value="#GetRecord.QtyOrdered#"></div></font>
<!--- 
        <!--- Field Validation will cause the form to loose its contents when we press back.  therefore it is disabled --->
		<!--- field validation --->
		<input type="hidden" name="txtQTY#lngGlobalRecordNumber#_integer" value="#GetRecord.Description# - Please type quantity">
		<input type="hidden" name="txtQTY#lngGlobalRecordNumber#_required" value="#GetRecord.Description# - Please type quantity">		
 --->
		</td>
    	<td width="153"><font size="2" face="Tahoma" font color="#strFontColor#">
		<div align="center">#GetRecord.SupplyUnitMinOrder#</div></font></td>
	<cfif (#GetRecord.CurrentRow # mod 3) EQ 0>  
	  </tr>
    </cfif>
  </cfoutput>
  </CFLOOP>
</table>
<p></p>
<table width="100%" border="0" cellspacing="0">
  <tr valign="top"> 
	<td><INPUT type="submit" name="btnEdit_OK" value="    OK    "></td>
	<td><INPUT type="submit" name="btnEdit_Cancel" value="Cancel"></td>  
    <td>Comments</td>
    <td> 
      <cfoutput><textarea name="#GetComments.Comments#" cols="50" rows="3"></textarea></cfoutput>
    </td>
  </tr>
</table>
<!--- <INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel"> --->
<p></p>
</FORM>
<a name="PageBottom"></a>
</body>
</html>
