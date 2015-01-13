
<!--- Create Criteria string for query from data entered thru search form --->
<CFSET Criteria = ''>
<CF_TestDrill_AppendCriteria
    FieldName="#Form.Crit1_FieldName#"
    FieldType="#Form.Crit1_FieldType#"
    Operator="#Form.Crit1_Operator#"
    Value="#Form.Crit1_Value#">
<CF_TestDrill_AppendCriteria
    FieldName="#Form.Crit2_FieldName#"
    FieldType="#Form.Crit2_FieldType#"
    Operator="#Form.Crit2_Operator#"
    Value="#Form.Crit2_Value#">
<CF_TestDrill_AppendCriteria
    FieldName="#Form.Crit3_FieldName#"
    FieldType="#Form.Crit3_FieldType#"
    Operator="#Form.Crit3_Operator#"
    Value="#Form.Crit3_Value#">
<CF_TestDrill_AppendCriteria
    FieldName="#Form.Crit4_FieldName#"
    FieldType="#Form.Crit4_FieldType#"
    Operator="#Form.Crit4_Operator#"
    Value="#Form.Crit4_Value#">
<CF_TestDrill_AppendCriteria
    FieldName="#Form.Crit5_FieldName#"
    FieldType="#Form.Crit5_FieldType#"
    Operator="#Form.Crit5_Operator#"
    Value="#Form.Crit5_Value#">


<!--- Query returning search results --->
<CFQUERY name="SearchResult" dataSource="costi">
    SELECT DISTINCT tblStockMaster.PartNo AS ResultField1, tblStockMaster.Description AS ResultField2, tblStockMaster.GroupNo AS ResultField3, tblStockMaster.PluType AS ResultField4, tblStockMaster.PartNo AS ID_Field
    FROM tblStockMaster
    WHERE 
        #PreserveSingleQuotes(Criteria)#
</CFQUERY>


<HTML><HEAD>
    <TITLE>TestDrill - Search Result</TITLE>
</HEAD><BODY bgcolor="ffffff">


<FONT size="+1">TestDrill</FONT> <BR>
<FONT size="+2"><B>Search Result</B></FONT>

<P>

<TABLE border=0 cellpadding=3 cellspacing=0>

<TR bgcolor="cccccc">
    <TD>&nbsp;</TD>
    <TD>PartNo</TD>
    <TD>Description</TD>
    <TD>GroupNo</TD>
    <TD>PluType</TD>

</TR>

<CFOUTPUT query="SearchResult">
<TR bgcolor="#IIf(CurrentRow Mod 2, DE('ffffff'), DE('ffffcf'))#">
    <TD><A href="TestDrill_Detail.cfm?ID=#URLEncodedFormat(ID_Field)#">[detail]</A></TD>
    <TD>#ResultField1#</TD>
<TD>#ResultField2#</TD>
<TD>#ResultField3#</TD>
<TD>#ResultField4#</TD>

</TR>
</CFOUTPUT>

</TABLE>


</BODY></HTML>
