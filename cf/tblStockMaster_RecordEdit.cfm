<cfset strPageTitle = "Product Add/Edit">
<CFSET FormFieldList = "PartNo,GroupNo,Cost,Description,SupplyUnit,OrderingUnit,Label,TCode,PCode, ">
<CFSET FormFieldList = FormFieldList & "RCode,Tolerance,Wholesale,MaxRetail,PluType,LockOrderUnitType, ">
<CFSET FormFieldList = FormFieldList & "MinOrderQty,PictureFile,NoLongerUsed,SuppressOrder, ">
<CFSET FormFieldList = FormFieldList & "SuppressStocktake,PartNoBuyingPlu,PartNoSalePlu,Ratio,PrepCode">
<!---[   Instantiate the objects required for the page.   ]---->
<cfset StockBarcodesDAO = application.beanfactory.getbean("StockBarcodesDAO") />
<cfset StockMasterDAO = application.beanfactory.getbean("StockMasterDAO") />
<cfset StockMaster = application.beanfactory.getbean("StockMaster") />
<!---[   Get info for the barcodes.   ]---->
<cfif structKeyExists(url, "recordID")>
  <cfset theBarcodes = StockBarcodesDAO.GetBarcodesforProduct(  URL.RecordID ) />
  <cfelse>
  <cfset theBarcodes = StockBarcodesDAO.GetBarcodesforProduct(  "0" ) />
</cfif>
<cfset StockPricesDAO = application.beanfactory.getbean("StockPricesDAO") />
<cfset thePriceLevels = StockPricesDAO.GetAllStockPrices() />
<cfset Stockmaster = application.beanfactory.getbean("Stockmaster") />
<cfif structKeyExists(url, "RecordID")>
  <cfset STockmaster.setPartNO( url.recordID   ) />
  <cfset StockMasterDAO.readbyPartNo(Stockmaster) />
</cfif>
<!--- Get the combo values for the Groups --->
<CFQUERY name="GetGroupCombo" datasource="#application.dsn#" > 
	SELECT tblStockGroup.GroupNo, tblStockGroup.[Group]
	FROM tblStockGroup
	ORDER BY tblStockGroup.[Group]
</CFQUERY>

<!--- Get the combo values for the Tax Rates --->
<CFQUERY name="GetTaxCombo" datasource="#application.dsn#" > 
	SELECT tblTax.TaxID, tblTax.TaxName, tblTax.TaxRate
	FROM tblTax
	ORDER BY tblTAx.TaxID
</CFQUERY>

<!--- Get the combo values for the Unit Types for order and supply --->
<CFQUERY name="GetUnit_TypeCombo" datasource="#application.dsn#" > 
	SELECT tblStockUnitType.UnitType
	FROM tblStockUnitType
	ORDER BY tblStockUnitType.UnitType
</CFQUERY>

<!--- Get the combo values for the Picture Files --->
<CFQUERY name="GetPicturesCombo" datasource="#application.dsn#" > 
	SELECT tblPictureFile.PictureFileID, tblPictureFile.PictureFileName
	FROM tblPictureFile
	WHERE (((tblPictureFile.PictureFileName) Like '%.gif')) OR (((tblPictureFile.PictureFileName) Like '%.jpg'))
	ORDER BY tblPictureFile.PictureFileName
</CFQUERY>

<!--- Get the combo values for the Rebate Codes --->
<CFQUERY name="GetRcodeCombo" datasource="#application.dsn#" > 
    SELECT tblStockRebate.RebateCode, (convert(varchar(10),tblStockRebate.RebateCode) + ' = Sup->' + convert(varchar(10), tblStockRebate.ThreeHRebate) + ' , scf-> ' + convert(varchar(10),tblStockRebate.SCRebate)) AS RebateName
	FROM tblStockRebate
	ORDER BY tblStockRebate.RebateCode
</CFQUERY>
<cfif structKeyExists(url,"RecordID")>
  <cfset StockMaster.setPartNo( url.Recordid ) />
  <cfset StockMasterDAO.readbyPartNo( StockMaster ) />
</cfif>
<cfscript>
			 PartNo_Value = Stockmaster.getPartNo() ;
 			 Description_Value = Stockmaster.getDescription() ;
			 PluType_value = Stockmaster.getPluType() ;
			 SupplyUnit_value = Stockmaster.getSupplyUnit() ;
			 OrderingUnit_value = Stockmaster.getOrderingUnit() ;
			 Label_value = Stockmaster.getLabel() ;
			 PictureFile_value = Stockmaster.getPictureFile() ;

			 GroupNo_Value = Stockmaster.getGroupNo() ;
			 Cost_Value = Stockmaster.getCost() ;
			 TCode_value = Stockmaster.getTCode() ;
			 PCode_value = Stockmaster.getPCode() ;
			 RCode_value = Stockmaster.getRCode() ;
			 Tolerance_value = Stockmaster.getTolerance() ;
			 Wholesale_value = Stockmaster.getWholesale() ;
			 MaxRetail_value = Stockmaster.getMaxRetail() ;
			 LockOrderUnitType_value = Stockmaster.getLockOrderUnitType() ;
			 MinOrderQty_value = Stockmaster.getMinOrderQty() ;

			 NoLongerUsed_value = Stockmaster.getNoLongerUsed() ;
			 SuppressOrder_value = Stockmaster.getSuppressOrder() ;
			 SuppressStocktake_value = Stockmaster.getSuppressStocktake() ;

			 PartNoBuyingPlu_value = Stockmaster.getPartNoBuyingPlu() ;
			 PartNoSalePlu_value = Stockmaster.getPartNoSalePlu() ;
			 Ratio_value = Stockmaster.getRatio() ;
			 PrepCode_value = Stockmaster.getPrepCode() ;

</cfscript>

<!---[   Old code,  retained but commented out for safety    ]---->
<!---[   <cfif ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblStockMaster.PartNo,  tblStockMaster.PartNo AS ID_Field, * 
		FROM tblStockMaster
		<cfif ParameterExists(URL.RecordID)>
		WHERE tblStockMaster.PartNo = '#URL.RecordID#'
		</cfif>
	</CFQUERY>

	<cfif not ListFind( FormFieldList, "PartNo" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "PartNo" )>
	</cfif>
			<CFSET PartNo_Value = '#GetRecord.PartNo#'>
 			<CFSET Description_Value = '#GetRecord.Description#'>
			<CFSET PluType_value = '#GetRecord.PluType#'>
			<CFSET SupplyUnit_value = '#GetRecord.SupplyUnit#'>
			<CFSET OrderingUnit_value = '#GetRecord.OrderingUnit#'>
			<CFSET Label_value = '#GetRecord.Label#'>
			<CFSET PictureFile_value = '#GetRecord.PictureFile#'>

			<CFSET GroupNo_Value = #GetRecord.GroupNo#>
			<CFSET Cost_Value = #GetRecord.Cost#>
			<CFSET TCode_value = #GetRecord.TCode#>
			<CFSET PCode_value = #GetRecord.PCode#>
			<CFSET RCode_value = #GetRecord.RCode#>
			<CFSET Tolerance_value = #GetRecord.Tolerance#>
			<CFSET Wholesale_value = #GetRecord.Wholesale#>
			<CFSET MaxRetail_value = #GetRecord.MaxRetail#>
			<CFSET LockOrderUnitType_value = #GetRecord.LockOrderUnitType#>
			<CFSET MinOrderQty_value = #GetRecord.MinOrderQty#>

			<CFSET NoLongerUsed_value = #GetRecord.NoLongerUsed#>
			<CFSET SuppressOrder_value = #GetRecord.SuppressOrder#>
			<CFSET SuppressStocktake_value = #GetRecord.SuppressStocktake#>

			<CFSET PartNoBuyingPlu_value = #GetRecord.PartNoBuyingPlu#>
			<CFSET PartNoSalePlu_value = #GetRecord.PartNoSalePlu#>
			<CFSET Ratio_value = #GetRecord.Ratio#>
			<CFSET PrepCode_value = #GetRecord.PrepCode#>

<CFELSE>
			<CFSET PartNo_Value = ''>
			<CFSET GroupNo_Value = ''>
			<CFSET Cost_Value = 0>
 			<CFSET Description_Value = ''>
			<CFSET SupplyUnit_Value = ''>
			<CFSET OrderingUnit_Value = ''>
			<CFSET Label_Value = ''>
			<CFSET TCode_Value = 0>
			<CFSET PCode_Value = 0>
			<CFSET RCode_Value = 0>
			<CFSET Tolerance_Value = 0>
			<CFSET Wholesale_Value = 0>
			<CFSET MaxRetail_Value = 0>
			<CFSET PluType_Value = 'N'>
			<CFSET LockOrderUnitType_Value = '0'>
			<CFSET MinOrderQty_Value = 0>
			<CFSET PictureFile_Value = 0>
			<CFSET NoLongerUsed_Value = 0>
			<CFSET SuppressOrder_Value = 0>
			<CFSET SuppressStocktake_Value = 0>
			<CFSET PartNoBuyingPlu_value = ''>
			<CFSET PartNoSalePlu_value = ''>
			<CFSET Ratio_value = 1>
			<CFSET PrepCode_value = ''>

</cfif>   ]---->

<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<TITLE>
<cfoutput>#strPageTitle#</cfoutput>
</TITLE>
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
<cfif (isdefined("session.errorhandler") AND  (session.errorhandler.haserrors()))>
  <cfoutput>
  <div class="errorhandler"> #session.errorhandler.MakeErrorDisplay(session.errorhandler)# </div>
  </cfoutput>
</cfif>
<br>
<div align="center">
  <CFOUTPUT>
  <FORM action="tblStockMaster_RecordAction.cfm" method="post">
    <input type="hidden" name="FieldList" value="#FormFieldList#">
    <cfif ParameterExists(URL.RecordID)>
      <input type="hidden" name="RecordID" value="#URL.RecordID#">
      <input type="hidden" name="ProductID" value="#URL.RecordID#">
      <cfelse>
      <input type="hidden" name="RecordID" value="#Stockmaster.getPartNO()#">
      <input type="hidden" name="ProductID" value="#Stockmaster.getProductID()#">
    </cfif>
    
    <!---[            
 Hidden text fields for items not currently being updated by the system.  
 Ensures default values are carried forward through the update processes.   
 ]---->
    <input type="hidden" name="ParentCost" value="#Stockmaster.getParentCost()#">
    <input type="hidden" name="TypeID" value="#Stockmaster.getTypeID()#">
    <input type="hidden" name="ID" value="#Stockmaster.getID()#">
    <input type="hidden" name="Costunit" value="#Stockmaster.getCostunit()#">
    <input type="hidden" name="DateEntered" value="#Stockmaster.getDateEntered()#">
    <TABLE border="1" width="850" cellpadding="2">
      <tr valign="top">
        <td width="110"><h3>PLU</h3></td>
        <td rowspan="14" width="20">&nbsp;</td>
        <td width="100"><!---[   <cfif not ParameterExists(URL.RecordID)>   ]---->
          
          <input type="text" name="PartNo" value="#Stockmaster.getPartNo()#" size="15" maxlength="16">
          
          <!---[   <cfelse>
                  <h3>#PartNo_Value#</h3>
                  </cfif>   ]----></td>
        <td width="80" rowspan="14">&nbsp;</td>
        <td width="130"><cfif Stockmaster.getPartNoSalePlu() EQ "P">
            <input type="text" name="PartNoSalePlu" value="#Stockmaster.getPartNoSalePlu()#" size="15" maxlength="16">
            <cfelse>
            <input type="hidden" name="PartNoSalePlu" value="#Stockmaster.getPartNoSalePlu()#" >
            &nbsp;
          </cfif></td>
        <td rowspan="14" width="20">&nbsp;</td>
        <td width="500" colspan="2"><input type="text" name="Description" value="#Stockmaster.getDescription()#" size="70" maxlength="25"></td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>
            <cfif Stockmaster.getPluType() EQ "P">
              Make From
              <cfelse>
              &nbsp;
            </cfif>
          </h3></td>
        <td width="100"><cfif Stockmaster.getPluType() EQ "P">
            <input type="text" name="PartNoBuyingPlu" value="#Stockmaster.getPartNoBuyingPlu()#" size="15" maxlength="16">
            <cfelse>
            &nbsp;
            <input type="hidden" name="PartNoBuyingPlu" value="#Stockmaster.getPartNoBuyingPlu()#" >
          </cfif></td>
        <td width="130"><h3>POS Label</h3></td>
        <td width="500" colspan="2"><input type="text" name="Label" value="#Stockmaster.getLabel()#" size="70" maxlength="20"></td>
      </tr>
      <!---  ---> 
      
      <!---  ---> 
      
      <!--- new code for groups combo --->
      <TR>
        <TD valign="top"><h3>Group</h3></TD>
        <TD><select name="GroupNo">
            <cfif (stockmaster.getGroupNo() EQ 0) or (stockmaster.getGroupNo() EQ '') >
              <option value="0" selected>None</option>
              <cfelse>
              <option value="0">None</option>
            </cfif>
            <cfloop query = "GetGroupCombo" >
            <option value="#GetGroupCombo.GroupNo#" <cfif (Stockmaster.getGroupNo() eq  GetGroupCombo.GroupNo) >selected="selected"</cfif> >#GetGroupCombo.Group#</option>
            </cfloop>
          </select></TD>
        <!--- field validation --->
        <input type="hidden" name="GroupNo_integer">
      </TR>
      <!--- new code for groups ends here ---> 
      
      <!--- Blank row --->
      <tr valign="top">
        <td width="110">&nbsp;</td>
        <td width="100">&nbsp;</td>
        <td width="130">&nbsp;</td>
        <td width="100">&nbsp;</td>
      </tr>
      <!--- Blank row --->
      
      <tr valign="top">
        <td width="110"><h3>PLU Type</h3></td>
        <td width="100" valign="top"><!--- <input type="text" name="PluType" value="#PluType_Value#" size="15" maxlength="10">  ---> 
          <!--- N: Normal, B: Buying Plu, P:Portion Plu, M:Sale PLU --->
          
          <SELECT NAME="PluType">
            <option value="N" <cfif Stockmaster.getPluType() EQ "N">selected="selected"</cfif> >Normal</option>
            <option value="P" <cfif Stockmaster.getPluType() EQ "P">selected="selected"</cfif> >Processed</option>
            <option value="M" <cfif Stockmaster.getPluType() EQ "M">selected="selected"</cfif> >Sale PLU</option>
          </SELECT></td>
        <td width="130"><h3>PictureFile</h3></td>
        <td width="500" colspan="2"><!---                   <input type="text" name="PictureFile" value="#PictureFile_Value#" size="70" maxlength="30">
GetPicturesCombo  --->
          
          <select name="PictureFile">
            <option value="0" <cfif stockmaster.getPictureFile() EQ "0">selected="selected"</cfif> >NoPic.jpg</option>
            <cfloop query = "GetPicturesCombo" >
            <option value="#GetPicturesCombo.PictureFileID#" <cfif stockmaster.getPictureFile() EQ GetPicturesCombo.PictureFileID>selected="selected"</cfif>>#GetPicturesCombo.PictureFileName#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>
            <cfif Stockmaster.getPluType() EQ "P">
              Prep Code
              <cfelse>
              &nbsp;
            </cfif>
          </h3></td>
        <td width="100"><cfif Stockmaster.getPluType() EQ "P">
            <input type="text" name="PrepCode" value="#Stockmaster.getPluType()#" size="15" maxlength="5">
            <cfelse>
            <input type="hidden" name="PrepCode" value="#Stockmaster.getPluType()#">
            &nbsp;
          </cfif></td>
        <td width="130">&nbsp;</td>
        <td width="500" colspan="2">&nbsp;</td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Ratio</h3></td>
        <td width="100"><input type="text" name="Ratio" value="#numberFormat(stockmaster.getRatio(),"______.0000")#" size="15" maxlength="21"></td>
        <td width="130"><h3>Suppress Stock take</h3></td>
        <td width="100"><input type="radio" name="SuppressStocktake" value="1" <cfif stockmaster.getSuppressStocktake() is 1> checked</cfif>>
          Yes
          <input type="radio" name="SuppressStocktake" value="0"<cfif stockmaster.getSuppressStocktake() is 0> checked</cfif>>
          No </td>
        <td rowspan="9" width="400"><div align="center"><img src="/plupics/#stockmaster.getPictureFileName()#" vspace="12"></div></td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Cost</h3></td>
        <td width="150" align="right"><!---                   <input type="text" name="Cost" value="#Cost_Value#" size="15" maxlength="21">
 --->
          
          <h3>#NumberFormat(Cost_Value,'999,999.00')#</h3>
          <input type="hidden" name="Cost" value="#stockmaster.getCost()#"></td>
        <td width="130"><h3>Suppress Order</h3></td>
        <td width="100"><input type="radio" name="SuppressOrder" value="1"<cfif stockmaster.getSuppressOrder() is 1> checked</cfif>>
          Yes
          <input type="radio" name="SuppressOrder" value="0"<cfif stockmaster.getSuppressOrder() is 0> checked</cfif>>
          No </td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Wholesale</h3></td>
        <td width="100"><input type="text" name="Wholesale" value="#NumberFormat(stockmaster.getWholesale(),'999,999.00')#" size="15" maxlength="21"></td>
        <!--- 
                 <td width="150"  align="right"> <h3>#NumberFormat(Wholesale_Value,'999,999.00')#</h3> </td>
 --->
        <td width="130"><h3>Discontinued Item</h3></td>
        <td width="100"><input type="radio" name="NoLongerUsed" value="1"<cfif stockmaster.getNoLongerUsed() is 1> checked</cfif>>
          Yes
          <input type="radio" name="NoLongerUsed" value="0"<cfif stockmaster.getNoLongerUsed() is 0> checked</cfif>>
          No </td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Max Retail</h3></td>
        <td width="100"><input type="text" name="MaxRetail" value="#numberFormat(stockmaster.getMaxRetail(),"______.00")#" size="15" maxlength="10">
          <input type="hidden" name="MaxRetail_float">
          <input type="hidden" name="MaxRetail_required" value="Please type the max retail."></td>
        <td colspan="3"><cfif len(structKeyList(stockmaster.getPriceLevels() ) )>
            <table border="0" width="100%">
              <cfloop query="thePriceLevels">
              <tr>
                <td>#thePriceLevels.description#:</td>
                <td>#stockmaster.getPriceLevels()["#ThePriceLevels.description#"].SellUnit#</td>
              </tr>
              </cfloop>
            </table>
          </cfif>
          <cfif structKeyExists(url,"recordid") >
            <input type="button" value="Add/Edit Prices" onClick="javascript:document.location.href='editPrices.cfm?PartNo=#url.recordid#';" />
          </cfif></td>
      </tr>
      
      <!--- new code for TAX --->
      <TR>
        <TD valign="top"><h3>Tax</h3></TD>
        <TD><select name="TCode">
            <cfloop query = "GetTaxCombo" >
            <option value="#GetTaxCombo.TaxID#" <cfif Stockmaster.getTCode() EQ GetTaxCombo.TaxID>selected="selected"</cfif>>#GetTaxCombo.TaxName#</option>
            </cfloop>
            <option value="0" <cfif Stockmaster.getTCode() EQ "0">selected="selected"</cfif>>GST Exempt</option>
          </select></TD>
        <!--- field validation --->
        <input type="hidden" name="TCode_integer">
        <td width="130"><h3>Supply Unit</h3></td>
        <td width="100"><select name="SupplyUnit">
            <cfloop query = "GetUnit_TypeCombo" >
            <option value="#GetUnit_TypeCombo.UnitType#" <cfif Stockmaster.getSupplyUnit() EQ GetUnit_TypeCombo.UnitType>selected="selected"</cfif>>#GetUnit_TypeCombo.UnitType#</option>
            </cfloop>
          </select></td>
      </TR>
      <!--- new code for Tax ends here --->
      
      <tr valign="top">
        <td width="110"><h3>Profit Code</h3></td>
        <td width="100"><input type="text" name="PCode" value="#Stockmaster.getPCode()#" size="15" maxlength="10">
          <input type="hidden" name="PCode_integer">
          <input type="hidden" name="PCode_required" value="Please type the profit code."></td>
        <td width="130"><h3>Ordering Unit</h3></td>
        <td width="100"><select name="OrderingUnit">
            <cfloop query = "GetUnit_TypeCombo" >
            <option value="#GetUnit_TypeCombo.UnitType#" <cfif Stockmaster.getOrderingUnit() EQ GetUnit_TypeCombo.UnitType>selected="selected"</cfif>>#GetUnit_TypeCombo.UnitType#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Margin Code</h3></td>
        <td width="100"><!---                   <input type="text" name="RCode" value="#RCode_Value#" size="15" maxlength="1">
 ---> 
          <!--- new code for Rebate Code --->
          
          <select name="RCode">
            <cfloop query = "GetRCodeCombo" >
            <option value="#GetRCodeCombo.RebateCode#" <cfif Stockmaster.getRCode() EQ GetRCodeCombo.RebateCode>selected="selected"</cfif>>#GetRCodeCombo.RebateName#</option>
            </cfloop>
          </select>
          
          <!--- field validation --->
          
          <input type="hidden" name="RCode_integer">
          
          <!--- new code for Tax ends here ---></td>
        <td width="130"><h3>Lock Order Unit Type</h3></td>
        <td width="100"><input type="radio" name="LockOrderUnitType" value="1"<cfif stockmaster.getLockOrderUnitType() is 1> checked</cfif>>
          Yes
          <input type="radio" name="LockOrderUnitType" value="0"<cfif stockmaster.getLockOrderUnitType() is 0> checked</cfif>>
          No </td>
      </tr>
      <tr valign="top">
        <td width="110"><h3>Tolerance</h3></td>
        <td width="100"><input type="text" name="Tolerance" value="#stockmaster.getTolerance()#" size="15" maxlength="10">
          <input type="hidden" name="Tolerance_float">
          <input type="hidden" name="Tolerance_required" value="Please type the tolerance."></td>
        <td width="130"><h3>Min Order Qty</h3></td>
        <td width="100"><input type="text" name="MinOrderQty" value="#stockmaster.getMinOrderQty()#" size="15" maxlength="10">
          <input type="hidden" name="MinOrderQty_float">
          <input type="hidden" name="MinOrderQty_required" value="Please type the min order qty."></td>
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
          
          <!---[       Only offer a button to add barcodes if there is a partno/productID to add them to.   ]---->
          
          <cfif isdefined("Getrecord")>
            <input type="button" value="Add/Edit Barcodes" onClick="javascript:document.location.href='editBarcodes.cfm?PartNo=#GetRecord.PartNo#';" />
          </cfif></td>
      </tr>
      <tr>
        <td>Kitchen Type </td>
        <td>&nbsp;</td>
        <td><input type="text" name="KitchenType" value="#stockmaster.getKitchenType()#"></td>
        <td>&nbsp;</td>
        <td>ModifierID</td>
        <td>&nbsp;</td>
        <td><input type="text" name="ModifierID" value="#stockmaster.getModifierID()#"></td>
        <td>Modifier Type:
          <select name="ModifierType" id="ModifierType">
            <option value="1" <cfif Stockmaster.getModifierType() eq "1">selected="selected"</cfif> >1: Standard</option>
            <option value="2" <cfif Stockmaster.getModifierType() eq "2">selected="selected"</cfif> >2: Auto-Modifier</option>
            <option value="255" <cfif Stockmaster.getModifierType() eq "255">selected="selected"</cfif> >255: No Modifier</option>
          </select></td>
      <tr>
        <td>Is Weighed</td>
        <td>&nbsp;</td>
        <td width="100"><input type="radio" name="IsWeighed" value="1"<cfif stockmaster.getIsWeighed() is 1> checked</cfif>>
          Yes
          <input type="radio" name="IsWeighed" value="0"<cfif stockmaster.getIsWeighed() is 0> checked</cfif>>
          No </td>
        <td>&nbsp;</td>
        <td> Tare </td>
        <td>&nbsp;</td>
        <td><input type="text" name="Tare" value="#stockmaster.getTare()#"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> Allow Zero Price </td>
        <td>&nbsp;</td>
        <td width="100"><input type="radio" name="AllowZeroPrice" value="1"<cfif stockmaster.getAllowZeroPrice() is 1> checked</cfif>>
          Yes
          <input type="radio" name="AllowZeroPrice" value="0"<cfif stockmaster.getAllowZeroPrice() is 0> checked</cfif>>
          No </td>
        <td>&nbsp;</td>
        <td> Discountable </td>
        <td>&nbsp;</td>
        <td width="100"><input type="radio" name="Discountable" value="1"<cfif stockmaster.getDiscountable() is 1> checked</cfif>>
          Yes
          <input type="radio" name="Discountable" value="0"<cfif stockmaster.getDiscountable() is 0> checked</cfif>>
          No </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> Is CountDown </td>
        <td>&nbsp;</td>
        <td width="100"><input type="radio" name="IsCountDown" value="1"<cfif stockmaster.getIsCountDown() is 1> checked</cfif>>
          Yes
          <input type="radio" name="IsCountDown" value="0"<cfif stockmaster.getIsCountDown() is 0> checked</cfif>>
          No </td>
        <td>&nbsp;</td>
        <td> Allow Open Price </td>
        <td>&nbsp;</td>
        <td width="100"><input type="radio" name="AllowOpenPrice" value="1"<cfif stockmaster.getAllowOpenPrice() is 1> checked</cfif>>
          Yes
          <input type="radio" name="AllowOpenPrice" value="0"<cfif stockmaster.getAllowOpenPrice() is 0> checked</cfif>>
          No </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> Discount No </td>
        <td>&nbsp;</td>
        <td><input type="text" name="DiscountNo" value="#stockmaster.getDiscountNo()#"></td>
        <td>&nbsp;</td>
        <td> Kitchen Print </td>
        <td>&nbsp;</td>
        <td><input type="text" name="KitchenPrint" value="#stockmaster.getKitchenPrint()#" size="15" maxlength="9"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td> Points Awarded </td>
        <td>&nbsp;</td>
        <td><input type="text" name="PointsAwarded" value="#stockmaster.getPointsAwarded()#"></td>
        <td>&nbsp;</td>
        <td> Points Required To Buy </td>
        <td>&nbsp;</td>
        <td><input type="text" name="PointsRequiredToBuy" value="#stockmaster.getPointsRequiredToBuy()#"></td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <!--- form buttons --->
    <input type="submit" name="btnEdit_OK" value="    OK    ">
    <input type="submit" name="btnEdit_Cancel" value="Cancel">
  </FORM>
  </CFOUTPUT>
</div>
</body>
</HTML>

<cfif application.siteversion eq "development">
  <cfdump var="#stockmaster.getsnapshot()#" label="line 567" />
   <cfdump var="#application#" label="session line 568" />
  <cfdump var="#session#" label="session line 569" />
  <cfdump var="#session.errorhandler#" label="error Record Edit line 570" />
</cfif>