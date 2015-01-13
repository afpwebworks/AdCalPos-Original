
<!--- Query returning detail information for selected item --->
<CFQUERY name="Detail" datasource="#application.dsn#" >
<!--- <CFQUERY name="Detail" dataSource="costi"> --->
    SELECT tblSupplierTranDet.SupplierTranDetID AS DetailField1, tblSupplierTranDet.StoreID AS DetailField2, tblSupplierTranDet.PurchaseDate AS DetailField3
    FROM tblSupplierTranDet
    WHERE tblSupplierTranDet.SupplierTranDetID = #URL.ID#
</CFQUERY>


<HTML><HEAD>
    <TITLE>ExpenseLookup - Detail</TITLE>
</HEAD><BODY bgcolor="ffffff">


<FONT size="+1">ExpenseLookup</FONT> <BR>
<FONT size="+2"><B>Detail</B></FONT>

<P>

<TABLE>

<CFOUTPUT query="Detail">

<TR>
    <TD valign=top><B>SupplierTranDetID:</B></TD>
    <TD valign=top>#DetailField1#</TD>
    </TR>
<TR>
    <TD valign=top><B>StoreID:</B></TD>
    <TD valign=top>#DetailField2#</TD>
    </TR>
<TR>
    <TD valign=top><B>PurchaseDate:</B></TD>
    <TD valign=top>#DetailField3#</TD>
    </TR>


<TR><TD colspan=3><HR></TD></TR>
</CFOUTPUT>

</TABLE>


</BODY></HTML>
