
<cfif Attributes.value EQ "" or Attributes.value EQ "All">
<cfelse>

<CFSET Criteria = Attributes.fieldName>
<CFSET Value = Attributes.value>
<CFIF Attributes.FieldType is not 'DATETIME'>
	<!--- escape quotes if field type is not datetime --->
	<CFSET Value = Replace( Value, "'", "''", "ALL" )>
</CFIF>

<CFIF ListFindNoCase( 'CHAR,MEMO', Attributes.FieldType )>
	<CFIF Attributes.operator is 'EQUAL'>       <CFSET Criteria = Criteria & " = '#Value#' ">
	<CFELSEIF Attributes.operator is 'NOT_EQUAL'>   <CFSET Criteria = Criteria & " <> '#Value#' ">
	<CFELSEIF Attributes.operator is 'GREATER_THAN'><CFSET Criteria = Criteria & " > '#Value#' ">
	<CFELSEIF Attributes.operator is 'SMALLER_THAN'><CFSET Criteria = Criteria & " < '#Value#' ">
	<CFELSEIF Attributes.operator is 'CONTAINS'>        <CFSET Criteria = Criteria & " LIKE '%#Value#%' ">
	<CFELSEIF Attributes.operator is 'BEGINS_WITH'> <CFSET Criteria = Criteria & " LIKE '#Value#%' ">
	<CFELSEIF Attributes.operator is 'ENDS_WITH'>   <CFSET Criteria = Criteria & " LIKE '%#Value#' ">
	</CFIF>

<CFELSEIF ListFindNoCase( 'INT,FLOAT,BIT,DATETIME', Attributes.FieldType )>
	<CFIF Attributes.operator is 'EQUAL'>       <CFSET Criteria = Criteria & " = #Value# ">
	<CFELSEIF Attributes.operator is 'NOT_EQUAL'>   <CFSET Criteria = Criteria & " <> #Value# ">
	<CFELSEIF Attributes.operator is 'GREATER_THAN'><CFSET Criteria = Criteria & " > #Value# ">
	<CFELSEIF Attributes.operator is 'SMALLER_THAN'><CFSET Criteria = Criteria & " < #Value# ">
	</CFIF>
</CFIF>

<CFIF Trim( Caller.Criteria ) is ''>
  <CFSET Caller.Criteria = Caller.Criteria & Criteria>
<CFELSE>
  <CFSET Caller.Criteria = Caller.Criteria & " AND " & Criteria>
</CFIF>

</CFIF>
