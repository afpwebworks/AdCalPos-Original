<cfset strPageTitle = "Product View">
<cfset btnsetVisible = 1>
<!---[   <cfset strQuery = "SELECT tblStockGroup.[Group], tblPictureFile.PictureFileName, ">
<cfset strQuery = strQuery & "CASE WHEN NoLongerUsed=0 then 'No' else 'Yes' end AS NLU, ">
<cfset strQuery = strQuery & "CASE WHEN SuppressOrder=0 then 'No' else 'Yes' end AS SupOrd, ">
<cfset strQuery = strQuery & "CASE WHEN SuppressStockTake=0 then 'No' else 'Yes' end AS SupStTake, ">
<cfset strQuery = strQuery & "CASE WHEN LockOrderUnitType=0 then 'No' else 'Yes' end AS LOUT, ">
<cfset strQuery = strQuery & "tblStockMaster.PartNo AS ID_Field, tblStockMaster.* ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) LEFT JOIN tblPictureFile ON tblStockMaster.PictureFile = tblPictureFile.PictureFileID ">
<CFIF ParameterExists(URL.RecordID)>
  <cfset strQuery = strQuery & "WHERE tblStockMaster.PartNo = '#URL.RecordID#'">
</CFIF>   ]---->
<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
SELECT tblStockGroup.[Group], tblPictureFile.PictureFileName, 
    CASE WHEN NoLongerUsed=0 then 'No' else 'Yes' end AS NLU,
    CASE WHEN SuppressOrder=0 then 'No' else 'Yes' end AS SupOrd, 
    CASE WHEN SuppressStockTake=0 then 'No' else 'Yes' end AS SupStTake,
    CASE WHEN LockOrderUnitType=0 then 'No' else 'Yes' end AS LOUT, 
	tblStockMaster.PartNo AS ID_Field, tblStockMaster.* 
    FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) 
    LEFT JOIN tblPictureFile ON tblStockMaster.PictureFile = tblPictureFile.PictureFileID
	<CFIF StructKeyExists(URL, "RecordID")>
      WHERE tblStockMaster.ProductID = '#URL.RecordID#'
    <cfelseif structKeyExists(URL, "PartNO")>  
      WHERE tblStockMaster.PartNO = '#URL.PartNO#'
    </CFIF>
</CFQUERY>
<cfset StockBarcodesDAO = application.beanfactory.getbean("StockBarcodesDAO") />
<cfset StockMasterDAO = application.beanfactory.getbean("StockMasterDAO") />
<cfset theBarcodes = StockBarcodesDAO.GetBarcodesforProduct(  GetRecord.PartNo ) />
<cfset StockPricesDAO = application.beanfactory.getbean("StockPricesDAO") />

<cfset thePriceLevels = StockPricesDAO.GetAllStockPrices() />
<cfset Stockmaster = application.beanfactory.getbean("Stockmaster") />
<cfset Stockmaster.setPartNO( GetRecord.PartNo   ) />
<cfset StockMasterDAO.readbyPartNo(Stockmaster) />

<!---[   <cfset strQuery = "SELECT DISTINCT tblStockMaster.PartNo, tblStockMaster.Description, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit">
<cfset strQuery = strQuery & " FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)">
<cfset strQuery = strQuery & " INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfset strQuery = strQuery & " WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') ">
<cfset strQuery = strQuery & " AND tblIngredient.SalePLU = '#URL.RecordID#' ">
<cfset strQuery = strQuery & " ORDER BY tblStockMaster.PartNo ">   ]---->

<CFQUERY name="GetIngredients"  datasource="#application.dsn#" > 
	SELECT DISTINCT tblStockMaster.PartNo, tblStockMaster.Description, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit
         FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)
         INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo 
         WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') 
         AND tblIngredient.SalePLU = '#Stockmaster.getPartNO()#' 
         ORDER BY tblStockMaster.PartNo 
</CFQUERY>
<cfif #GetRecord.PCode# eq 90>
  <cfset btnsetVisible=0>
</cfif>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<cfoutput>
<TITLE>#strPageTitle#</TITLE>
</cfoutput>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1>
        <cfoutput>#strPageTitle#</cfoutput>
      </h1></td>
    <td width="25%"><div align="right"><a href="tblStockMasterSearch_Search.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div></td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
    <tr>
  
    <td>
  
    <div align="center">
  
  <cfoutput>
  <FORM action="tblStockMaster_RecordAction.cfm" method="post">
    <INPUT type="hidden" name="RecordID" value="#GetRecord.ID_Field#">
    <table width="100%" border="0">
      <tr>
        <td><div align="center">
            <table width="100%" border="0">
              <tr>
                <td><div align="center">
                    <cfif btnsetVisible eq 0>
                      <INPUT type="submit" name="btnAdd_Ingredient" value="Add/Edit Ingredients">
                      <!--<INPUT type="submit" name="btnEdit_Ingredient" value="Edit Ingredients ">-->
                    </cfif>
                    <INPUT type="submit" name="btnView_Add" value="   Add   ">
                    <INPUT type="submit" name="btnView_Edit" value="   Edit   ">
                    <INPUT type="submit" name="btnView_PriceFormula" value="Price Formula">
                  </div></td>
                <td><div align="center">
                    <INPUT type="submit" name="btnView_First" value="<< First">
                    <INPUT type="submit" name="btnView_Previous" value="< Prev">
                    <INPUT type="submit" name="btnView_Next" value="Next >">
                    <INPUT type="submit" name="btnView_Last" value="Last >>">
                  </div></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
  </FORM>
  </cfoutput>
  <CFOUTPUT query="GetRecord">
  <TABLE border="1" width="960" cellpadding="0">
    
    <!--- Partno --->
    <tr valign="top">
      <td width="110"><h3>PLU:</h3></td>
      <td rowspan="17" width="20">&nbsp;</td>
      <td width="100"><div align="Left">
          <h3>#GetRecord.PartNo#</h3>
        </div></td>
      <td width="80" rowspan="17"><h3>&nbsp;</h3></td>
      <td width="130"><cfif #GetRecord.PluType# EQ "P">
          <h3>#GetRecord.PartNoSalePlu#&nbsp;</h3>
          <cfelse>
          &nbsp;
        </cfif></td>
      <td rowspan="17" width="20">&nbsp;</td>
      <td width="500" colspan="2"><div align="Left">
          <h3>#GetRecord.Description#</h3>
        </div></td>
    </tr>
    <!---  --->
    <tr valign="top">
      <td width="110"><h3>
          <cfif #GetRecord.PluType# EQ "P">
            Make From
            <cfelse>
            &nbsp;
          </cfif>
        </h3></td>
      <td width="100"><div align="left">
          <h3>
            <cfif #GetRecord.PluType# EQ "P">
              #GetRecord.PartNoBuyingPlu#
              <cfelse>
              &nbsp;
            </cfif>
          </h3>
        </div></td>
      <td width="130"><h3>POS Label:</h3></td>
      <td width="500" colspan="2"><h3>#GetRecord.Label#</h3></td>
    </tr>
    <!---  --->
    <tr valign="top">
      <td width="110"><h3>Group.:</h3></td>
      <td width="100"><div align="left">
          <h3>#GetRecord.GroupNo#</h3>
        </div></td>
      <td width="130"><h3>Group Name</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>#GetRecord.Group#</h3>
        </div></td>
    </tr>
    
    <!---  --->
    <tr valign="top">
      <td width="110"><h3>&nbsp;</h3></td>
      <td width="100"><div align="left">
          <h3>&nbsp;</h3>
        </div></td>
      <td width="130"><h3>&nbsp;</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>&nbsp;</h3>
        </div></td>
    </tr>
    <!---  --->
    
    <tr valign="top">
      <td width="110"><h3>PLU Type:</h3></td>
      <td width="100" valign="top"><div align="left">
          <h3>
            <cfif #GetRecord.PluType# EQ "N">
              Normal
              <cfelseif #GetRecord.PluType# EQ "P">
              Prepared
              <cfelseif #GetRecord.PluType# EQ "M">
              Manufactur
            </cfif>
          </h3>
        </div></td>
      <td width="130"><h3>PictureFile</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>#GetRecord.PictureFileName#&nbsp;</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>
          <cfif #GetRecord.PluType# EQ "P">
            PrepCode&nbsp;
            <cfelse>
            &nbsp;
          </cfif>
        </h3></td>
      <td width="100"><div align="width">
          <h3>
            <cfif #GetRecord.PluType# EQ "P">
              #GetRecord.PrepCode#&nbsp;
              <cfelse>
              &nbsp;
            </cfif>
          </h3>
        </div></td>
      <td width="130"><h3>&nbsp;</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>&nbsp;</h3>
        </div></td>
    </tr>
    <!---  --->
    <tr valign="top">
      <td width="110"><h3>SupMargin$</h3></td>
      <td width="100"><div align="left">
          <h3>#NumberFormat(GetRecord.ThreeHRebateVal,"__.99")#</h3>
        </div></td>
      <td width="130"><h3>Type ID &nbsp;</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>Type ID Desc &nbsp;</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>SCMargin$</h3></td>
      <td width="100"><div align="left">
          <h3>#NumberFormat(GetRecord.SCRebateVal,"__.99")#</h3>
        </div></td>
      <td width="130"><h3>&nbsp;</h3></td>
      <td width="500" colspan="2"><div align="Left">
          <h3>&nbsp;</h3>
        </div></td>
    </tr>
    
    <!---  --->
    
    <tr valign="top">
      <td width="110"><h3>Ratio</h3></td>
      <td width="100"><div align="right">
          <h3>#NumberFormat(GetRecord.Ratio,"__.99")#</h3>
        </div></td>
      <td width="130"><h3>SuppressStocktake</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.SupStTake#</h3>
        </div></td>
      <cfif #GetRecord.PictureFile# GT 0>
        <td rowspan="9" width="400"><h2 align="center">
          <img src="../plupics/#GetRecord.PictureFileName#" width="240" height="220" vspace="12">
          </h3></td>
        <cfelseif btnsetVisible EQ 0>
        <td rowspan="9" width="400"><table width="100%" border="1">
            <tr>
              <td><font size="2" style="Tahoma">Ingredient PLU</font></td>
              <td><font size="2" style="Tahoma">Ingredient Desc</font></td>
              <td><font size="2" style="Tahoma">Ingredient Quantity</font></td>
            </tr>
            <cfloop query="GetIngredients">
            <tr>
              <td><font size="1" style="Tahoma">#GetIngredients.PartNo#</font></td>
              <td><font size="1" style="Tahoma">#GetIngredients.Description#</font></td>
              <td><font size="1" style="Tahoma">#numberformat(GetIngredients.qtyIngredient,"______.00000")# #GetIngredients.SupplyUnit#</font></td>
            </tr>
            </cfloop>
          </table></td>
        <cfelse>
        <td rowspan="9" width="400"><h2 align="center">
          <img src="../plupics/NoPic.jpg" width="240" height="220" vspace="12">
          </h3></td>
      </cfif>
    </tr>
    <tr valign="top">
      <td width="110"><h3>Cost:</h3></td>
      <td width="100"><div align="right">
          <h3>#NumberFormat(GetRecord.Cost,'99,999.00')#</h3>
        </div></td>
      <td width="130"><h3>SuppressOrder</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.SupOrd#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>Wholesale:</h3></td>
      <td width="100"><div align="right">
          <h3>#NumberFormat(GetRecord.Wholesale,'99,999.00')#</h3>
        </div></td>
      <td width="130"><h3>DiscontinuedItem</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.NLU#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>Max Retail:</h3></td>
      <td width="100"><div align="right">
          <h3>#NumberFormat(GetRecord.MaxRetail,'9,999.00')#</h3>
        </div></td>
      <!---[    Display multiple price levels   ]---->
      <td width="130" colspan="3"><table border="0" width="100%">
          <cfloop query="thePriceLevels">
          <tr>
            <td>#thePriceLevels.description#:</td>
            <td>#numberformat(stockmaster.getPriceLevels()["#ThePriceLevels.description#"].SellUnit, "_,__9.99")#</td>
          </tr>
          </cfloop>
        </table>
        <input type="button" value="Add/Edit Prices" onClick="javascript:document.location.href='editPrices.cfm?PartNo=#stockmaster.getPartno()#';" />
        </td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>Tax Code:</h3></td>
      <td width="100"><div align="right">
          <h3>#GetRecord.TCode#</h3>
        </div></td>
      <td width="130"><h3>SupplyUnit</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.SupplyUnit#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>ProfitCode:</h3></td>
      <td width="100"><div align="right">
          <h3>#GetRecord.PCode#</h3>
        </div></td>
      <td width="130"><h3>OrderingUnit</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.OrderingUnit#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>MarginCode:</h3></td>
      <td width="100"><div align="right">
          <h3>#GetRecord.RCode#</h3>
        </div></td>
      <td width="130"><h3>LockOrderUnitType</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.LOUT#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>Tolerance:</h3></td>
      <td width="100"><div align="right">
          <h3>#numberformat(GetRecord.Tolerance,'99.99')#</h3>
        </div></td>
      <td width="130"><h3>MinOrderQty</h3></td>
      <td width="100"><div align="center">
          <h3>#GetRecord.MinOrderQty#</h3>
        </div></td>
    </tr>
    <tr valign="top">
      <td width="110"><h3>DateEntered:</h3></td>
      <td width="100"><div align="left">
          <h3>#dateformat(GetRecord.DateEntered,"dd/mm/yyyy")#</h3>
        </div></td>
      <td width="130"><h3>&nbsp;</h3></td>
      <td width="100"><div align="left">
          <h3>&nbsp;</h3>
        </div></td>
    </tr>
    <tr>
      <td>Barcodes:</td>
      <td colspan="7"><cfif theBarcodes.recordcount>
          <cfloop query="theBarcodes">#theBarcodes.barcode#<br />
          </cfloop>
          &nbsp;&nbsp;&nbsp;
          <cfelse>
          No barcodes defined for this item &nbsp;&nbsp;&nbsp;
        </cfif>
        <input type="button" value="Add/Edit Barcodes" onClick="javascript:document.location.href='editBarcodes.cfm?PartNo=#GetRecord.PartNo#';" /></td>
    </tr>
    <tr>
      <td>Kitchen Type </td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.KitchenType#</h3></td>
      <td>&nbsp;</td>
      <td>ModifierID</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.ModifierID#</h3></td>
      <td>Modifier Type:
        <cfswitch expression="#GetRecord.Modifiertype#">
        <cfcase value="1">1: Standard</cfcase>
        <cfcase value="2">2: Auto-Modifier</cfcase>
        <cfcase value="255">255: No Modifier</cfcase>
        <cfdefaultcase>
        #GetRecord.Modifiertype#
        </cfdefaultcase>
        </cfswitch></td>
    <tr>
      <td>Is Weighed</td>
      <td>&nbsp;</td>
      <td align="center"><h3>
          <cfif getREcord.IsWeighed>
            Yes
            <cfelse>
            No
          </cfif>
        </h3></td>
      <td>&nbsp;</td>
      <td>Tare</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.MinOrderQty#</h3></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Allow Zero Price</td>
      <td>&nbsp;</td>
      <td align="center"><h3>
          <cfif getREcord.AllowZeroPrice>
            Yes
            <cfelse>
            No
          </cfif>
        </h3></td>
      <td>&nbsp;</td>
      <td>Discountable</td>
      <td>&nbsp;</td>
      <td align="center"><h3>
          <cfif getREcord.Discountable>
            Yes
            <cfelse>
            No
          </cfif>
        </h3></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Is CountDown</td>
      <td>&nbsp;</td>
      <td align="center"><h3>
          <cfif getREcord.IsCountDown>
            Yes
            <cfelse>
            No
          </cfif>
        </h3></td>
      <td>&nbsp;</td>
      <td>Allow Open Price</td>
      <td>&nbsp;</td>
      <td align="center"><h3>
          <cfif getREcord.AllowOpenPrice>
            Yes
            <cfelse>
            No
          </cfif>
        </h3></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Discount No</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.DiscountNo#</h3></td>
      <td>&nbsp;</td>
      <td>Kitchen Print</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.KitchenPrint#</h3></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Points Awarded</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.PointsAwarded#</h3></td>
      <td>&nbsp;</td>
      <td>Points Required To Buy</td>
      <td>&nbsp;</td>
      <td><h3>#GetRecord.PointsRequiredToBuy#</h3></td>
      <td>&nbsp;</td>
    </tr>
  </table>
    </div>
  
    </td>
  
    </tr>
  
  </CFOUTPUT>
</table>
<cfset Stockmaster = application.beanfactory.getbean("Stockmaster") />
<cfset STockmaster.setPartNO( GetRecord.PartNo   ) />
<cfset StockMasterDAO.readbyPartNo(Stockmaster) />
<!-------[  <cfdump var="#stockmaster.getSnapshot()#" />   ]----MK ----->
</body>
</HTML>
