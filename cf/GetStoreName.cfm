
<cfstoredproc procedure = "GetStoreName" datasource="#application.dsn#"  >

	<cfprocresult name = "rs1"  > 
	<cfprocparam type = "IN" CFSQLType = CF_SQL_INTEGER 
     value="#qGetRecords.StoreID#" dbVarName = @StoreID>

</cfstoredproc>
