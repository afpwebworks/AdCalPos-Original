
<!--- <CFQUERY NAME="query_name"
    DATASOURCE="ds_name"
    DBTYPE="type"
    DBSERVER="dbms"
    DBNAME="database name"
    USERNAME="username"
    PASSWORD="password"
    MAXROWS="number"
    BLOCKFACTOR="blocksize"
    TIMEOUT="milliseconds"
    CACHEDAFTER="date" 
    CACHEDWITHIN="timespan" 
    PROVIDER="COMProvider" 
    PROVIDERDSN="datasource" 
    DEBUG="Yes/No">
 ---> 
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" dataSource="Sqlserver"  USERNAME="sa" PASSWORD=""> --->

<!---  
<CFQUERY name="GetRecord" DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" PROVIDERDSN="SQLOLEDB" dataSource="Sql server"  USERNAME="mhu" PASSWORD="mhp">
	SELECT * from tblemployee
</CFQUERY>
 --->
<CFQUERY name="GetRecord" DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" PROVIDERDSN="SQLOLEDB" dataSource="Sql server"  USERNAME="mhu" PASSWORD="mhp" DEBUG="Yes" >
	SELECT * from tblStockHistStart where Partno = '10'
</CFQUERY>

<HTML><HEAD>
	<TITLE>TestSQL - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">

<FONT size="+1">TestSQL</FONT> <BR>
<FONT size="+2"><B>View Record</B></FONT>

<cfoutput>
Records: #GetRecord.RecordCount#

</cfoutput>
<table>
<cfoutput query="GetRecord">
	<tr>
		<td>#GetRecord.StockHistoryID#</td>
		<td>#GetRecord.PartNo#</td>
		<td>#GetRecord.Date#</td>
	</tr>
</cfoutput>
</table>
</BODY></HTML>
