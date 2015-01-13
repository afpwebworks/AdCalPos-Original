
	<!--- Perform the login here --->
    <cfset strQuery = "SELECT UserName, Password, * ">
    <cfset strQuery = strQuery & "FROM tblEmployee ">
	<CFQUERY name="GetRecord" maxRows=1 dataSource="vs277779_1" USERNAME="vs277779_1_dbo" PASSWORD="etxt6S3Tdg"  > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
    
	<cfset strQuery = "SELECT PartNo, Description, * ">
    <cfset strQuery = strQuery & "FROM tblStockMaster ">
	<CFQUERY name="GetLocalRecord"  dataSource="vs277779_2"   > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<cfset strQuery = "SELECT PLUNumber, TotalD, * ">
    <cfset strQuery = strQuery & "FROM C1_PLUTotals ">
	<CFQUERY name="GetStorePLUSales"  dataSource="vs277779_2"   > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
		
</HEAD>
<body >
        <table width="80%" border="1" cellspacing="0">
          <tr> 
            <td><h4>UserName</h4></td>
            <td><h4>Pass</h4></td>
            <td><div align="right"><h4>Other</h4></div></td>
            <td><div align="right"><h4>Other Qty</h4></div></td>
            <td><div align="right"><h4>Other</h4></div></td>
			<td><div align="right"><h4>Other</h4></div></td>
          </tr>
  		<cfoutput query = "GetRecord">
          <tr> 
            <td>
				<h4>#GetRecord.UserName#&nbsp;</h4>
			</td>
            <td><h4>#GetRecord.Password#&nbsp;</h4></td>
            <td><div align="right"><h4>&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
          </tr>
	  </cfoutput>
        </table>
<p>
Part 2
</p>
        <table width="80%" border="1" cellspacing="0">
          <tr> 
            <td><h4>Part No</h4></td>
            <td><h4>description</h4></td>
            <td><div align="right"><h4>Other</h4></div></td>
            <td><div align="right"><h4>Other Qty</h4></div></td>
            <td><div align="right"><h4>Other</h4></div></td>
			<td><div align="right"><h4>Other</h4></div></td>
          </tr>
  		<cfoutput query = "GetLocalRecord">
          <tr> 
            <td>
				<h4>#GetLocalRecord.PartNo#&nbsp;</h4>
			</td>
            <td><h4>#GetLocalRecord.Description#&nbsp;</h4></td>
            <td><div align="right"><h4>&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
          </tr>
	  </cfoutput>
        </table>

</body>

Part 3
</p>
        <table width="80%" border="1" cellspacing="0">
          <tr> 
            <td><h4>PLU No</h4></td>
            <td><h4>Sales</h4></td>
            <td><div align="right"><h4>Other</h4></div></td>
            <td><div align="right"><h4>Other Qty</h4></div></td>
            <td><div align="right"><h4>Other</h4></div></td>
			<td><div align="right"><h4>Other</h4></div></td>
          </tr>
  		<cfoutput query = "GetStorePLUSales">
          <tr> 
            <td>
				<h4>#GetStorePLUSales.PLUNumber#&nbsp;</h4>
			</td>
            <td><h4>#GetStorePLUSales.TotalD#&nbsp;</h4></td>
            <td><div align="right"><h4>&nbsp;</h4></div></td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
			<td>
				<div align="right"><h4>&nbsp;</h4></div>
			</td>
          </tr>
	  </cfoutput>
        </table>

</body>


</HTML>

