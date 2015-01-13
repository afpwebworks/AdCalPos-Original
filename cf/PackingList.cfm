
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


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--- Get the date --->
<cfset strDate = #URL.DD#>
<cfset lngStoreID = #URL.ST#>
<CFIF ParameterExists(URL.DPID)>
	<cfset lngDPNO = #URL.DPID#>
<cfelse>
	<cfset lngDPNO = 0>
</cfif>

<!--- Get the comments --->
<CFQUERY name="CheckHeader"      datasource="#application.dsn#" >  
	SELECT 	tblOrderHeader.OrderID, tblOrderHeader.StoreID, tblOrderHeader.OrderDate, tblOrderHeader.Comments 
	FROM 	tblOrderHeader 
	WHERE 	(((tblOrderHeader.StoreID)=#lngStoreID#) AND ((tblOrderHeader.OrderDate)='#strDate#'))
	<cfif url.type EQ 1>
			AND	tblOrderHeader.typeID = 1
	<cfelse>
			AND	tblOrderHeader.typeID <> 1
	</cfif>
</CFQUERY>
<cfset strMemo = URLDecode(CheckHeader.Comments)>


<!--- get the number of lines --->
	<!--- <cfset strQuery = "SELECT qryPackingOrder.StoreID, qryPackingOrder.OrderDate, Count(qryPackingOrder.OrderDetID) AS NumLines ">
	<cfset strQuery = strQuery & "FROM qryPackingOrder ">
	<CFIF #lngDPNO# GT 0>
		<cfset strQuery = strQuery & "Where qryPackingOrder.DeptNo = #lngDPNO# ">
	<cfelse>
		<cfset strQuery = strQuery & "Where (qryPackingOrder.QtyOrdered > 0.0001) or (qryPackingOrder.QtySupplied > 0.0001) ">
	</cfif>
	<cfif url.type EQ 1>
		<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID=1 "><!--- typeID = 1 is for frozen foods ---> 
	<cfelse>
		<cfset strQuery = strQuery & " AND qryPurchaseOrder.typeID<>1 "><!--- typeID <> 1 is for non-frozen foods ---> 
	</cfif> 
	<cfset strQuery = strQuery & "GROUP BY qryPackingOrder.StoreID, qryPackingOrder.OrderDate ">
	<cfset strQuery = strQuery & "HAVING (((qryPackingOrder.StoreID)=#lngStoreID#) AND ((qryPackingOrder.OrderDate)='#strDate#'))"> --->
	<CFQUERY name="GetNumRecordQry" datasource="#application.dsn#" > 
		SELECT 		qryPackingOrder.StoreID, qryPackingOrder.OrderDate, Count(qryPackingOrder.OrderDetID) AS NumLines 
		FROM 		qryPackingOrder 
					<cfif lngDPNO GT 0>
						WHERE qryPackingOrder.DeptNo = #lngDPNO# 
					<cfelse>
						WHERE (qryPackingOrder.QtyOrdered > 0.0001) or (qryPackingOrder.QtySupplied > 0.0001) 
					</cfif>
					
		GROUP BY 	qryPackingOrder.StoreID, qryPackingOrder.OrderDate, qryPackingOrder.typeID
		HAVING 		(((qryPackingOrder.StoreID)=#lngStoreID#) 
		AND 		((qryPackingOrder.OrderDate)='#strDate#')
			 		<cfif url.type EQ 1>
						AND qryPackingOrder.typeID = 1) 
					<cfelse>
						AND qryPackingOrder.typeID <> 1)
					</cfif>
	</CFQUERY>
	<cfif #GetNumRecordQry.RecordCount# GT 0>
		<cfset lngNumRecords = #GetNumRecordQry.NumLines#>
	<cfelse>
		<cfset lngNumRecords = 0>
	</cfif>

<!--- Get number of fillets --->
<CFIF lngDPNO EQ 0>
	<!--- <cfset strQuery = "SELECT Count(qryPackingOrder.OrderDetID) AS Records, qryPackingOrder.StoreID, qryPackingOrder.OrderDate ">
	<cfset strQuery = strQuery & "FROM qryPackingOrder ">
	<cfset strQuery = strQuery & "WHERE (qryPackingOrder.PluType='M') and ( (qryPackingOrder.QtyOrdered > 0.0001) or (qryPackingOrder.QtySupplied > 0.0001) )">
	<cfset strQuery = strQuery & "GROUP BY qryPackingOrder.StoreID, qryPackingOrder.OrderDate ">
	<cfset strQuery = strQuery & "HAVING (((qryPackingOrder.StoreID)=#lngStoreID#) AND ((qryPackingOrder.OrderDate)='#strDate#'))"> --->
	<CFQUERY name="GetNumFilletsQry" datasource="#application.dsn#" > 
		SELECT 		Count(qryPackingOrder.OrderDetID) AS Records, qryPackingOrder.StoreID, qryPackingOrder.OrderDate 
		FROM 		qryPackingOrder 
		WHERE 		(qryPackingOrder.PluType='M') and ( (qryPackingOrder.QtyOrdered > 0.0001) or (qryPackingOrder.QtySupplied > 0.0001) )
		GROUP BY 	qryPackingOrder.StoreID, qryPackingOrder.OrderDate , qryPackingOrder.typeID 
		HAVING 		(((qryPackingOrder.StoreID)=#lngStoreID#) 
		AND 		((qryPackingOrder.OrderDate)='#strDate#')
					<cfif url.type EQ 1>
						AND qryPackingOrder.typeID = 1) 
					<cfelse>
						AND qryPackingOrder.typeID <> 1)
					</cfif>
	</CFQUERY>
	<cfif GetNumFilletsQry.RecordCount GT 0>
		<cfset lngNumFillets = GetNumFilletsQry.Records>
	<cfelse>
		<cfset lngNumFillets = 0>
	</cfif>
<CFelse>
<!--- 	<cfset strQuery = "SELECT Count(qryPackingOrder.OrderDetID) AS Records, qryPackingOrder.StoreID, qryPackingOrder.OrderDate ">
	<cfset strQuery = strQuery & "FROM qryPackingOrder ">
	<cfset strQuery = strQuery & "WHERE (qryPackingOrder.DeptNo = #lngDPNO# ) AND (qryPackingOrder.PluType='M') and ( (qryPackingOrder.QtyOrdered > 0.0001) or (qryPackingOrder.QtySupplied > 0.0001) )">
	<cfset strQuery = strQuery & "GROUP BY qryPackingOrder.StoreID, qryPackingOrder.OrderDate ">
	<cfset strQuery = strQuery & "HAVING (((qryPackingOrder.StoreID)=#lngStoreID#) AND ((qryPackingOrder.OrderDate)='#strDate#'))"> --->
	<CFQUERY name="GetNumFilletsQry" datasource="#application.dsn#" > 
		SELECT 		Count(qryPackingOrder.OrderDetID) AS Records, qryPackingOrder.StoreID, qryPackingOrder.OrderDate 
		FROM 		qryPackingOrder 
		WHERE 		(qryPackingOrder.DeptNo = #lngDPNO# ) 
		AND 		(qryPackingOrder.PluType='M') 
		AND 		((qryPackingOrder.QtyOrdered > 0.0001) OR (qryPackingOrder.QtySupplied > 0.0001) )
		GROUP BY 	qryPackingOrder.StoreID, qryPackingOrder.OrderDate, qryPackingOrder.typeID 
		HAVING 		(((qryPackingOrder.StoreID)=#lngStoreID#) 
		AND 		((qryPackingOrder.OrderDate)='#strDate#')
					<cfif url.type EQ 1>
						AND qryPackingOrder.typeID = 1) 
					<cfelse>
						AND qryPackingOrder.typeID <> 1)
					</cfif>
	</CFQUERY>
	<cfif GetNumFilletsQry.RecordCount GT 0>
		<cfset lngNumFillets = GetNumFilletsQry.Records>
	<cfelse>
		<cfset lngNumFillets = 0>
	</cfif>
</cfif>

<!--- get the Departments --->
<CFQUERY name="GetDepartments" datasource="#application.dsn#" > 
	SELECT 		qryPackingOrder.DeptNo, qryPackingOrder.Dept, qryPackingOrder.BackGroundColor 
	FROM 		qryPackingOrder 
	WHERE		1 = 1
				<CFIF #lngDPNO# GT 0>
					 AND qryPackingOrder.DeptNo = #lngDPNO# 
				</cfif>
	GROUP BY 	qryPackingOrder.DeptNo, qryPackingOrder.Dept, qryPackingOrder.BackGroundColor, qryPackingOrder.StoreID, qryPackingOrder.OrderDate
	<!--- , 
				qryPackingOrder.typeID  --->
	HAVING 		(((qryPackingOrder.StoreID)=#lngStoreID#) 
	AND 		((qryPackingOrder.OrderDate)='#strDate#'))
				<!--- <cfif url.type EQ 1>
					AND qryPackingOrder.typeID = 1) 
				<cfelse>
					AND qryPackingOrder.typeID <> 1)
				</cfif> --->
	ORDER BY 	qryPackingOrder.DeptNo
</CFQUERY>
<cfset lngNumFillets = 0>

<html>
<head>
	<title>Packing Order</title>
</head>
<link rel="stylesheet" type="text/css" href="costi.css">
<body>
<a name="PageTop"></a>
<FORM action="PackingActionEdit.cfm" method="post">
<!--- Write the number of lines here  --->
<cfoutput>
<input type="hidden" name="txtNumLines" value="#lngNumRecords#">
<!--- <input type="hidden" name="txtNumFillets" value="#lngNumFillets#"> --->
<input type="hidden" name="txtstrDate" value="#strDate#">
<input type="hidden" name="txtlngStoreID" value="#lngStoreID#">
<input type="hidden" name="txtlngDPNO" value="#lngDPNO#">
<input type="hidden" name="type" value="#url.type#">

<p align="center"><font color="FFFF00" face="Tahoma" size="5">#strMemo#</font></p>
</cfoutput>

  <table width="960" border="1" bordercolor="CFCDCB" cellpadding="0" cellspacing="0">
    <tr> 
    <!--- <td width="70" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td>
	 --->
	 <td width="70"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td>
	
	<!--- 16/02/04 vishal commented Type column --->
    <!--- <td width="60" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">Type</font></b></div>
    </td> --->
	
    <td width="170"> 
        <div align="center"><b><font size="2" face="Tahoma">Description</font></b></div>
    </td>
    <td width="60"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty Ordered</font></b></div>
    </td>
    <td width="70"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty Supplied</font></b></div>
    </td>
    <td width="50"> 
        <div align="center"><b><font size="2" face="Tahoma">Unit</font></b></div>
    </td>
	<td width="70"> 
        <div align="center"><b><font size="2" face="Tahoma">W/Sale($)</font></b></div>
    </td>
	<td width="50"> 
        <div align="center"><b><font size="2" face="Tahoma">MaxRetail($)</font></b></div>
    </td>
    <!--- <td width="70" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">PLU</font></b></div>
    </td> --->
	
   <!--- 16/02/04 vishal commented Type column --->
   <!---  <td width="60" bgcolor="3366FF"> 
        <div align="center"><b><font size="2" face="Tahoma">Type</font></b></div>
    </td> --->
	
   <!---  <td width="170"> 
        <div align="center"><b><font size="2" face="Tahoma">Description</font></b></div>
    </td>
    <td width="60"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty Ordered</font></b></div>
    </td>
    <td width="70"> 
        <div align="center"><b><font size="2" face="Tahoma">Qty Supplied</font></b></div>
    </td>
    <td width="50"> 
        <div align="center"><b><font size="2" face="Tahoma">Unit</font></b></div>
    </td>
	<td width="70"> 
        <div align="center"><b><font size="2" face="Tahoma">W/Sale($)</font></b></div>
    </td>
	<td width="50"> 
        <div align="center"><b><font size="2" face="Tahoma">MaxRetail($)</font></b></div>
    </td> --->
  </tr>
<cfset lngGlobalRecordNumber = 0>
<cfset lngGlobalFilletNumber = 0>			

  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
	   <tr> 
      		<td height="40" bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4"><a href="##PageTop">Up</a></font></b></div>
      		</td>
      		<td height="40" colspan="5" bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4"><a href="PackingList.cfm?DD=#strDate#&ST=#lngStoreID#&DPID=#GetDepartments.DeptNo#&type=#url.type#">#GetDepartments.Dept#</a></font></b></div>
      		</td>
      		<td height="40"  bgcolor="#GetDepartments.backGroundColor#">
        		<div align="center"><b><font size="4"><a href="##PageBottom">Down</a></font></b></div>
      		</td>
    	</tr>
		</cfoutput>
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
				SELECT 		qryPackingOrder.Description, qryPackingOrder.DeptNo, * 
				FROM 		qryPackingOrder 
				WHERE 		(((qryPackingOrder.DeptNo)=#lngDeptNo#) AND ((qryPackingOrder.StoreID)=#lngStoreID#) AND ((qryPackingOrder.OrderDate)='#strDate#'))
							<CFIF #lngDPNO# LTE 0>
								AND ( ((qryPackingOrder.QtyOrdered) > 0.0001 ) or ((qryPackingOrder.QtySupplied) > 0.0001 ) )  
							</cfif>
							<cfif url.type EQ 1>
								AND (qryPackingOrder.typeID = 1) 
							<cfelse>
								AND (qryPackingOrder.typeID <> 1)
							</cfif>
				ORDER BY 	qryPackingOrder.Description
		
		</CFQUERY>

  <cfoutput query = "GetRecord">
	<!--- <cfif (#GetRecord.CurrentRow # mod 2) EQ 1>   --->
	  	<tr> 
	<!--- </cfif>	 --->
        <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
        <input type="hidden" name="txtID#lngGlobalRecordNumber#" value="#GetRecord.OrderDetID#">
        <input type="hidden" name="txtPartNo#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
      	<input type="hidden" name="txtIdPluType#lngGlobalRecordNumber#" value="#GetRecord.PluType#">
		
        <!--- <td width="70" bgcolor="000099"><font size="2" face="Tahoma"><div align="center">#GetRecord.PartNo#&nbsp;</div></font></td> --->
  <td width="70"><font size="2" face="Tahoma"><div align="center">#GetRecord.PartNo#&nbsp;</div></font></td>
  


<!--- 16/02/04 vishal Commented out Type column values --->
        <!--- <cfif #GetRecord.PluType# EQ "M">
	        <cfset lngNumFillets = #lngNumFillets# + 1>
			<cfset lngGlobalFilletNumber = lngGlobalFilletNumber + 1>			
            <input type="hidden" name="txtFilletPartNo#lngGlobalFilletNumber#" value="#GetRecord.PartNo#">
            <input type="hidden" name="txtFilletID#lngGlobalFilletNumber#" value="#GetRecord.OrderDetID#">
			
			
	        <td width="70"><font size="2" face="Tahoma">
				<div align="center"><input type="text" name="txtFilletQTY#lngGlobalFilletNumber#" maxlength="5" size = "5" value="#GetRecord.PrepCode#"></div></font>
			</td>
		<cfelse>
        	 <td width="60"><font size="2" face="Tahoma"><div align="center">&nbsp;</div></font></td>	 	
		</cfif>  --->
		
		<td width="170"><font size="2" face="Tahoma"><b>#GetRecord.Description#&nbsp;</b></font></td>
        <td width="60"><font size="2" face="Tahoma"><div align="center">#GetRecord.QtyOrderAndUnit#&nbsp;</div></font></td>

		
		
	    <td width="70"><font size="2" face="Tahoma">
			<div align="center"><input type="text" name="txtQTY#lngGlobalRecordNumber#" maxlength="5" size = "5" value="#GetRecord.QtySupplied#"></div></font>
		</td>
    	<td width="50"><font size="2" face="Tahoma"><div align="center">#GetRecord.SupplyUnit#&nbsp;</div></font></td>


<td align="right"><font size="2" face="Tahoma">#numberformat(GetRecord.Wholesale,"_____.00")# </font></td>
<td align="right"><font size="2" face="Tahoma"> #numberformat(GetRecord.MaxRetail,"_____.00")# </font></td>

	<!--- <cfif (#GetRecord.CurrentRow # mod 2) EQ 0>   --->
	  </tr>
    <!--- </cfif> --->
  </cfoutput>

  </CFLOOP>
</table>
<p></p>
<table border="0" width="50%" align="center">
	<tr align="center">
		<td><INPUT type="submit" name="btnEdit_Save" value="  OK - Enter More  "></td>
		<td><INPUT type="submit" name="btnEdit_OK" value="  Finish Packing  "></td>
		<td width="30%" align="left"><INPUT type="submit" name="btnEdit_Cancel" value="Cancel"></td>
	</tr>
	
</table>
<cfoutput>
<input type="hidden" name="txtNumFillets" value="#lngNumFillets#">
</cfoutput>
</FORM>
<a name="PageBottom"></a>
</body>
</html>
