
<!--- Query returning detail information for selected item --->
<CFQUERY name="Detail" dataSource="costi">
    SELECT tblStockMaster.PartNo AS DetailField1, tblStockMaster.Description AS DetailField2, tblStockMaster.SupplyUnit AS DetailField3, tblStockMaster.OrderingUnit AS DetailField4, tblStockMaster.Label AS DetailField5, tblStockMaster.GroupNo AS DetailField6, tblStockMaster.TCode AS DetailField7, tblStockMaster.PCode AS DetailField8, tblStockMaster.RCode AS DetailField9, tblStockMaster.Tolerance AS DetailField10, tblStockMaster.Cost AS DetailField11, tblStockMaster.Wholesale AS DetailField12, tblStockMaster.MaxRetail AS DetailField13, tblStockMaster.PluType AS DetailField14, tblStockMaster.LockOrderUnitType AS DetailField15, tblStockMaster.MinOrderQty AS DetailField16, tblStockMaster.PictureFile AS DetailField17, tblStockMaster.NoLongerUsed AS DetailField18, tblStockMaster.SuppressOrder AS DetailField19, tblStockMaster.SuppressStocktake AS DetailField20, tblStockMaster.ID AS DetailField21, tblStockMaster.PartNoBuyingPlu AS DetailField22, tblStockMaster.PartNoSalePlu AS DetailField23, tblStockMaster.Ratio AS DetailField24, tblStockMaster.PrepCode AS DetailField25, tblStockMaster.ThreeHRebate AS DetailField26, tblStockMaster.SCRebate AS DetailField27, tblStockMaster.ThreeHRebateVal AS DetailField28, tblStockMaster.SCRebateVal AS DetailField29
    FROM tblStockMaster
    WHERE tblStockMaster.PartNo = '#URL.ID#'
</CFQUERY>


<HTML><HEAD>
    <TITLE>TestDrill - Detail</TITLE>
</HEAD><BODY bgcolor="ffffff">


<FONT size="+1">TestDrill</FONT> <BR>
<FONT size="+2"><B>Detail</B></FONT>

<P>

<TABLE>

<CFOUTPUT query="Detail">

<TR>
    <TD valign=top><B>PartNo:</B></TD>
    <TD valign=top>#DetailField1#</TD>
    </TR>
<TR>
    <TD valign=top><B>Description:</B></TD>
    <TD valign=top>#DetailField2#</TD>
    </TR>
<TR>
    <TD valign=top><B>SupplyUnit:</B></TD>
    <TD valign=top>#DetailField3#</TD>
    </TR>
<TR>
    <TD valign=top><B>OrderingUnit:</B></TD>
    <TD valign=top>#DetailField4#</TD>
    </TR>
<TR>
    <TD valign=top><B>Label:</B></TD>
    <TD valign=top>#DetailField5#</TD>
    </TR>
<TR>
    <TD valign=top><B>GroupNo:</B></TD>
    <TD valign=top>#DetailField6#</TD>
    </TR>
<TR>
    <TD valign=top><B>TCode:</B></TD>
    <TD valign=top>#DetailField7#</TD>
    </TR>
<TR>
    <TD valign=top><B>PCode:</B></TD>
    <TD valign=top>#DetailField8#</TD>
    </TR>
<TR>
    <TD valign=top><B>RCode:</B></TD>
    <TD valign=top>#DetailField9#</TD>
    </TR>
<TR>
    <TD valign=top><B>Tolerance:</B></TD>
    <TD valign=top>#DetailField10#</TD>
    </TR>
<TR>
    <TD valign=top><B>Cost:</B></TD>
    <TD valign=top>#DetailField11#</TD>
    </TR>
<TR>
    <TD valign=top><B>Wholesale:</B></TD>
    <TD valign=top>#DetailField12#</TD>
    </TR>
<TR>
    <TD valign=top><B>MaxRetail:</B></TD>
    <TD valign=top>#DetailField13#</TD>
    </TR>
<TR>
    <TD valign=top><B>PluType:</B></TD>
    <TD valign=top>#DetailField14#</TD>
    </TR>
<TR>
    <TD valign=top><B>LockOrderUnitType:</B></TD>
    <TD valign=top>#DetailField15#</TD>
    </TR>
<TR>
    <TD valign=top><B>MinOrderQty:</B></TD>
    <TD valign=top>#DetailField16#</TD>
    </TR>
<TR>
    <TD valign=top><B>PictureFile:</B></TD>
    <TD valign=top>#DetailField17#</TD>
    </TR>
<TR>
    <TD valign=top><B>NoLongerUsed:</B></TD>
    <TD valign=top>#DetailField18#</TD>
    </TR>
<TR>
    <TD valign=top><B>SuppressOrder:</B></TD>
    <TD valign=top>#DetailField19#</TD>
    </TR>
<TR>
    <TD valign=top><B>SuppressStocktake:</B></TD>
    <TD valign=top>#DetailField20#</TD>
    </TR>
<TR>
    <TD valign=top><B>ID:</B></TD>
    <TD valign=top>#DetailField21#</TD>
    </TR>
<TR>
    <TD valign=top><B>PartNoBuyingPlu:</B></TD>
    <TD valign=top>#DetailField22#</TD>
    </TR>
<TR>
    <TD valign=top><B>PartNoSalePlu:</B></TD>
    <TD valign=top>#DetailField23#</TD>
    </TR>
<TR>
    <TD valign=top><B>Ratio:</B></TD>
    <TD valign=top>#DetailField24#</TD>
    </TR>
<TR>
    <TD valign=top><B>PrepCode:</B></TD>
    <TD valign=top>#DetailField25#</TD>
    </TR>
<TR>
    <TD valign=top><B>ThreeHMargin:</B></TD>
    <TD valign=top>#DetailField26#</TD>
    </TR>
<TR>
    <TD valign=top><B>SCMargin:</B></TD>
    <TD valign=top>#DetailField27#</TD>
    </TR>
<TR>
    <TD valign=top><B>ThreeHMarginVal:</B></TD>
    <TD valign=top>#DetailField28#</TD>
    </TR>
<TR>
    <TD valign=top><B>SCMarginVal:</B></TD>
    <TD valign=top>#DetailField29#</TD>
    </TR>


<TR><TD colspan=29><HR></TD></TR>
</CFOUTPUT>

</TABLE>


</BODY></HTML>
