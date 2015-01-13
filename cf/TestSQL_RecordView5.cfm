
<!--- The following example executes a Sybase stored procedure
       that returns three result sets, two of which we want. The
       stored procedure returns the status code and one output
       parameter, which we display. We use named notation
       for the parameters. --->
<!--- CFSTOREDPROC tag --->
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" PROVIDERDSN="SQLOLEDB" dataSource="Sql server"  USERNAME="mhu" PASSWORD="mhp" DEBUG="Yes" > --->
Before Stored Procedre
<!--- <CFSTOREDPROC PROCEDURE="InvtValue2" DBTYPE="OLEDB" DBNAME ="CostiSQL" DBSERVER="w2000s" PROVIDER="SQLOLEDB" PROVIDERDSN="SQLOLEDB" dataSource="Sql server"  USERNAME="mhu" PASSWORD="mhp"> --->

<!--- <CFSTOREDPROC PROCEDURE="InvtValue" dataSource="CostiDSN3"  USERNAME="sa" PASSWORD=""> --->
<CFSTOREDPROC PROCEDURE="InvtValue" DATASOURCE="CostiDSN3"  DEBUG="Yes">
<!--- CFPROCRESULT tags --->
<CFPROCRESULT NAME = RS1>
<!--- 
<!---  CFPROCPARAM tags --->
<CFPROCPARAM TYPE="IN"
    CFSQLTYPE=CF_SQL_INTEGER
        VALUE="1"    DBVARNAME=@param1>
        
<CFPROCPARAM TYPE="OUT"    CFSQLTYPE=CF_SQL_DATE
    VARIABLE=FOO DBVARNAME=@param2>
 --->
<!--- Close the CFSTOREDPROC tag --->
</CFSTOREDPROC>
<CFOUTPUT>
The output param value: 
<br>
</CFOUTPUT>

<h3>The Results Information</h3>
<CFOUTPUT QUERY = RS1>#PartNo#
<br>
</CFOUTPUT>
<P>
<CFOUTPUT>
<hr>
<P>Record Count: #RS1.RecordCount# >p>Columns: #RS1.ColumnList#
<hr>
</CFOUTPUT> 
<P>


