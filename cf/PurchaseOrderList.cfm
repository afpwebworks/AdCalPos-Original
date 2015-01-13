
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
<cfif #len(strDate)# LT 8>
	<cfset strDate = "0" & #strDate#>
</cfif>

<cfset lngStoreID = #session.storeid#>

<!--- Get the comments --->
<CFQUERY name="CheckHeader"      datasource="#application.dsn#" >  
	SELECT 	tblOrderHeader.OrderID, tblOrderHeader.StoreID, tblOrderHeader.OrderDate, tblOrderHeader.Comments 
	FROM 	tblOrderHeader 
	WHERE 	(((tblOrderHeader.StoreID)=#lngStoreID#) AND ((tblOrderHeader.OrderDate)='#strDate#'))
	<cfif url.type EQ 1>
			AND	tblOrderHeader.typeID = 1
			<!--- this is to restrict access to printed orders - vishal 06/04/2006 --->
			<cfif session.usertype EQ 6 OR session.usertype EQ 7 OR session.usertype EQ 8 OR session.usertype EQ 9>
				AND		isPrinted != 1
			</cfif>
	<cfelse>
			AND	tblOrderHeader.typeID <> 1
	</cfif>
	
</CFQUERY>
<cfset strMemo = #URLDecode(CheckHeader.Comments)#>
<!--- get the number of lines --->
<cfset strQuery = "SELECT qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate, Count(qryPurchaseOrder.OrderDetID) AS NumLines ">
<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
<cfif url.type EQ 1>
	<cfset strQuery = strQuery & "WHERE qryPurchaseOrder.SuppressOrder = 0  
		AND qryPurchaseOrder.typeID=1 "><!--- typeID = 1 is for frozen foods ---> 
	<cfif session.usertype EQ 6 OR session.usertype EQ 7 OR session.usertype EQ 8 OR session.usertype EQ 9>
		<cfset strQuery = strQuery & " AND isPrinted != 1 ">
	</cfif>
<cfelse>
	<cfset strQuery = strQuery & "WHERE qryPurchaseOrder.SuppressOrder = 0
		AND qryPurchaseOrder.typeID<>1"><!--- typeID <> 1 is for non-frozen foods ---> 
</cfif>
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING ( ((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#'))">
<CFQUERY name="GetNumRecordQry"      datasource="#application.dsn#" >  
<!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetNumRecordQry"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Set GP% Color --->
<cfset strQuery = "SELECT GPPriceList from tblOptions">
<CFQUERY name="GetOptions" dataSource="#Applic_dataSource#"  USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >  
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
<cfif url.type EQ 1>
	<cfset strQuery = strQuery & "WHERE qryPurchaseOrder.SuppressOrder = 0  
		AND qryPurchaseOrder.typeID=1"><!--- typeID = 1 is for frozen foods ---> 
<cfelse>
	<cfset strQuery = strQuery & "WHERE qryPurchaseOrder.SuppressOrder = 0
		AND qryPurchaseOrder.typeID<>1"><!--- typeID <> 1 is for non-frozen foods ---> 
</cfif>
<cfset strQuery = strQuery & "GROUP BY qryPurchaseOrder.DeptNo, qryPurchaseOrder.Dept, qryPurchaseOrder.BackGroundColor, qryPurchaseOrder.StoreID, qryPurchaseOrder.OrderDate ">
<cfset strQuery = strQuery & "HAVING ( ((qryPurchaseOrder.StoreID)=#lngStoreID#) AND ((qryPurchaseOrder.OrderDate)='#strDate#')) ">
<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.DeptNo">
<CFQUERY name="GetDepartments"      datasource="#application.dsn#" >  

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
<input type="hidden" name="lngStoreID" value="#lngStoreID#">
<input type="hidden" name="strDate" value="#strDate#">
<input type="hidden" name="type" value="#url.type#">
</cfoutput>
  <table align = "center" width="630" border="1" bordercolor="CFCDCB" cellpadding="0" cellspacing="0">
    <tr> 
      <td  width="70" > 
        <b><font size="2" face="Tahoma">PLU</font></b> 
    </td>
      <td width="150"> 
        <b><font size="2" face="Tahoma">Product</font></b> 
    </td>
	<td width="70"> 
        <b><font size="2" face="Tahoma">Unit (Min)</font></b> 
    </td>
	<td width="70"> 
        <b><font size="2" face="Tahoma">Min Order Qty</font></b> 
    </td>
	 <td width="100" align="center"> 
        <b><font size="2" face="Tahoma">Cost($)</font></b> 
	</td>
	<td width="100" align="center"> 
        <b><font size="2" face="Tahoma">Sale ($)</font></b> 
	</td>
	<td  width="70"> 
        <b><font size="2" face="Tahoma">GP (%)</font></b> 
    </td>
      <td width="70" align="center"> 
        <b><font size="2" face="Tahoma">Qty</font></b> 
    </td>
  </tr>
<cfset lngGlobalRecordNumber = 0>
<cfset lngGlobalLineNumber = 0>

  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
	   <tr> 	
          <td  align="left"  height="40" bgcolor="#GetDepartments.backGroundColor#" > 
            <b><font size="4"><a href="##PageTop">Up</a></font></b> 
    	  </td>
      		<td  colspan="5" align = "center" height="40" bgcolor="#GetDepartments.backGroundColor#">
        		<b><font size="4">#GetDepartments.Dept#</font></b>
      		</td>
      		
          <td  align="right" height="40" bgcolor="#GetDepartments.backGroundColor#" > 
            <b><font size="4"><a href="##PageBottom">Down</a></font></b> 
      		</td>
    	</tr>
		</cfoutput>
		<!--- get the lines --->
		<cfset strQuery = "SELECT qryPurchaseOrder.Description, qryPurchaseOrder.DeptNo, * ">
		<cfset strQuery = strQuery & "FROM qryPurchaseOrder ">
		<cfif url.type EQ 1>
			<cfset strQuery = strQuery & "WHERE ( ((qryPurchaseOrder.SuppressOrder) = 0 ) 
				AND ((qryPurchaseOrder.DeptNo)=#lngDeptNo#) 
				AND ((qryPurchaseOrder.StoreID)=#lngStoreID#) 
				AND ((qryPurchaseOrder.typeID)=1)
				AND ((qryPurchaseOrder.OrderDate)='#strDate#'))"><!--- typeID = 1 is for frozen foods ---> 
			<cfif session.usertype EQ 6 OR session.usertype EQ 7 OR session.usertype EQ 8 OR session.usertype EQ 9>
				<cfset strQuery = strQuery & " AND isPrinted != 1 ">
			</cfif>
		<cfelse>
			<cfset strQuery = strQuery & "WHERE ( ((qryPurchaseOrder.SuppressOrder) = 0 ) 
				AND ((qryPurchaseOrder.DeptNo)=#lngDeptNo#) 
				AND ((qryPurchaseOrder.StoreID)=#lngStoreID#) 
				AND ((qryPurchaseOrder.typeID)<>1)
				AND ((qryPurchaseOrder.OrderDate)='#strDate#'))"><!--- typeID <> 1 is for non-frozen foods ---> 
		</cfif>
		<cfset strQuery = strQuery & "ORDER BY qryPurchaseOrder.Description">
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="GetRecord"      datasource="#application.dsn#" >  
					#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
	<cfset GP = 0>
	<cfset flag = 0>
  <cfoutput query = "GetRecord">
  	<cfif isnumeric(#GetRecord.MaxRetail#) and ((#GetRecord.MaxRetail#) GT 0) >
			<cfset GP = ((#GetRecord.MaxRetail# - #GetRecord.Wholesale#)/#GetRecord.MaxRetail#)*100> 
				<cfif  #GP# GT #GetOptions.GPPriceList#>
					<cfset flag=1>
				</cfif>
	</cfif>
	<cfif (#GetRecord.CurrentRow# mod 3) EQ 1>
		<cfset lngGlobalLineNumber = lngGlobalLineNumber + 1>  
	  	<cfif (#lngGlobalLineNumber# mod 2) EQ 1>
            <cfset strFontColor = "FFFFFF">
			<!--- <tr bgcolor="00006D"> --->
		<cfelse>
            <cfset strFontColor = "FFFFFF">
			<tr> 	
		<!--- <td height="37"> ---></cfif>	
	</cfif>	
        <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
		<input type="hidden" name="txtID#lngGlobalRecordNumber#" value="#GetRecord.OrderDetID#">
        <input type="hidden" name="txtPartNo#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
        <input type="hidden" name="txtMinQty#lngGlobalRecordNumber#" value="#GetRecord.MinQty#">
      	<td  align="center" >
          <font size="2" face="Tahoma" font color="#strFontColor#"> 
            #GetRecord.PartNo#        
          </font>
		 </td>
    	<td><font size="2" face="Tahoma" font color="#strFontColor#"><b>#GetRecord.Description#</b></font></td>
		<td align="center"><font size="2" face="Tahoma" font color="#strFontColor#"> 
            #GetRecord.OrderingUnitMinOrder#</font>
		</td>
		
		<td align="right"><font size="2" face="Tahoma" font color="#strFontColor#"> 
            #numberformat(GetRecord.MinOrderQty,"_____.000")#</font>
		</td>
		
		<td  align="right"><font size="2" face="Tahoma" font color="#strFontColor#"> 
            #numberformat(GetRecord.Wholesale,"_____.00")#</font>
		</td>
	    <cfif #GetRecord.PCode# EQ 0>
		<td  align="right" ><font size="2" face="Tahoma" font color="#strFontColor#"> 
           #numberformat(GetRecord.MaxRetail,"_____.00")#</font>
		</td>
		<cfif flag eq 1>
		<td  align="right" bgcolor="brown" ><font size="2" face="Tahoma" color="#strFontColor#">
          		#numberformat(GP,"_____.00")#</font> 
		</td>
		<cfelse>
			<td  align="right" ><font size="2" face="Tahoma" color="#strFontColor#">
				#numberformat(GP,"_____.00")#</font> 
		 </td>
	 </cfif>
		<cfelse>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		</cfif>
		 <td align="center"><font size="2" face="Tahoma" font color="#strFontColor#">
			<input type="text" name="txtQTY#lngGlobalRecordNumber#" maxlength="5" size = "5" value="#GetRecord.QtyOrdered#" ></font>
		</td>
		 
	<!--- <cfif ((#GetRecord.CurrentRow# mod 3) EQ 0) OR (#GetRecord.CurrentRow# EQ #GetRecord.RecordCount#)>  --->
	      </tr>
	<cfset GP = 0>
	<cfset flag=0>
  <!---   </cfif> --->
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
      <cfoutput><textarea name="OrderComments" cols="50" rows="3">#strMemo#</textarea></cfoutput>
    </td>
  </tr>
</table>
<p></p>
</FORM>
<a name="PageBottom"></a>
</body>
</html>
