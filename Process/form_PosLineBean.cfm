<cfsilent>
<!----[
==========================================================================================================
Filename:      form_PosLineBean.cfm
Description:   Form for  handling PosLine Requires a bean called PosLineBean to exist already.
Date:          4/April/2010 
Author:        Michael Kear

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfform name="PosLineform" action="#cgi.SCRIPT_NAME#" method="post" format="xml" skin="#application.formskin#" scriptsrc="#application.scriptsource#" >
<cfformitem type="html">
<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
  <cfoutput>
  <div class="errorhandler"> #errorhandler.MakeErrorDisplay(errorhandler)# </div>
  </cfoutput>
</cfif>
</cfformitem>
<cfinput type="text" name="CostExt" label="CostExt" required="yes" message="Please provide the CostExt" validate="float" style="width:400px;" value="#PosLineBean.getCostExt()#" />
<cfselect name="CostIncludeTax" label="CostIncludeTax">
<option value="1" <cfif #PosLineBean.getCostIncludeTax()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosLineBean.getCostIncludeTax()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="CostUnit" label="CostUnit" required="yes" message="Please provide the CostUnit" validate="float" style="width:400px;" value="#PosLineBean.getCostUnit()#" />
<cfinput type="text" name="DepartmentID" label="DepartmentID" required="yes" message="Please provide the DepartmentID" validate="integer" style="width:400px;" value="#PosLineBean.getDepartmentID()#" />
<cfinput type="text" name="Description" label="Description" required="yes" message="Please provide the Description"  maxlength="50" style="width:400px;" value="#PosLineBean.getDescription()#" />
<cfinput type="text" name="DiscountDescription" label="DiscountDescription" required="yes" message="Please provide the DiscountDescription"  maxlength="50" style="width:400px;" value="#PosLineBean.getDiscountDescription()#" />
<cfinput type="text" name="DiscountEntryType" label="DiscountEntryType" required="yes" message="Please provide the DiscountEntryType" validate="integer" style="width:400px;" value="#PosLineBean.getDiscountEntryType()#" />
<cfinput type="text" name="DiscountExt" label="DiscountExt" required="yes" message="Please provide the DiscountExt" validate="float" style="width:400px;" value="#PosLineBean.getDiscountExt()#" />
<cfinput type="text" name="DiscountID" label="DiscountID" required="yes" message="Please provide the DiscountID" validate="integer" style="width:400px;" value="#PosLineBean.getDiscountID()#" />
<cfinput type="text" name="DiscountMaxLimit" label="DiscountMaxLimit" required="yes" message="Please provide the DiscountMaxLimit" validate="integer" style="width:400px;" value="#PosLineBean.getDiscountMaxLimit()#" />
<cfinput type="text" name="DiscountRate" label="DiscountRate" required="yes" message="Please provide the DiscountRate" validate="float" style="width:400px;" value="#PosLineBean.getDiscountRate()#" />
<cfinput type="text" name="DiscountType" label="DiscountType" required="yes" message="Please provide the DiscountType" validate="integer" style="width:400px;" value="#PosLineBean.getDiscountType()#" />
<cfinput type="text" name="DiscountUnit" label="DiscountUnit" required="yes" message="Please provide the DiscountUnit" validate="float" style="width:400px;" value="#PosLineBean.getDiscountUnit()#" />
<cfinput type="text" name="ExtaxExt" label="ExtaxExt" required="yes" message="Please provide the ExtaxExt" validate="float" style="width:400px;" value="#PosLineBean.getExtaxExt()#" />
<cfinput type="text" name="ExtaxUnit" label="ExtaxUnit" required="yes" message="Please provide the ExtaxUnit" validate="float" style="width:400px;" value="#PosLineBean.getExtaxUnit()#" />
<cfinput type="text" name="KitchenPrint" label="KitchenPrint" required="yes" message="Please provide the KitchenPrint"  maxlength="9" style="width:400px;" value="#PosLineBean.getKitchenPrint()#" />
<cfselect name="KitchenPrinted" label="KitchenPrinted">
<option value="1" <cfif #PosLineBean.getKitchenPrinted()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosLineBean.getKitchenPrinted()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="KitchenType" label="KitchenType" required="yes" message="Please provide the KitchenType" validate="integer" style="width:400px;" value="#PosLineBean.getKitchenType()#" />
<cfinput type="text" name="MixMatchDescription" label="MixMatchDescription" required="yes" message="Please provide the MixMatchDescription"  maxlength="50" style="width:400px;" value="#PosLineBean.getMixMatchDescription()#" />
<cfinput type="text" name="MixMatchExt" label="MixMatchExt" required="yes" message="Please provide the MixMatchExt" validate="float" style="width:400px;" value="#PosLineBean.getMixMatchExt()#" />
<cfselect name="MixMatchGiveAwayItem" label="MixMatchGiveAwayItem">
<option value="1" <cfif #PosLineBean.getMixMatchGiveAwayItem()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosLineBean.getMixMatchGiveAwayItem()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="MixMatchGiveAwayType" label="MixMatchGiveAwayType" required="yes" message="Please provide the MixMatchGiveAwayType" validate="integer" style="width:400px;" value="#PosLineBean.getMixMatchGiveAwayType()#" />
<cfinput type="text" name="MixMatchGiveAwayValue" label="MixMatchGiveAwayValue" required="yes" message="Please provide the MixMatchGiveAwayValue" validate="float" style="width:400px;" value="#PosLineBean.getMixMatchGiveAwayValue()#" />
<cfinput type="text" name="MixMatchID" label="MixMatchID" required="yes" message="Please provide the MixMatchID" validate="integer" style="width:400px;" value="#PosLineBean.getMixMatchID()#" />
<cfselect name="MixMatchResetTrigger" label="MixMatchResetTrigger">
<option value="1" <cfif #PosLineBean.getMixMatchResetTrigger()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosLineBean.getMixMatchResetTrigger()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="MixMatchTriggerType" label="MixMatchTriggerType" required="yes" message="Please provide the MixMatchTriggerType" validate="integer" style="width:400px;" value="#PosLineBean.getMixMatchTriggerType()#" />
<cfinput type="text" name="MixMatchTriggerValue" label="MixMatchTriggerValue" required="yes" message="Please provide the MixMatchTriggerValue" validate="float" style="width:400px;" value="#PosLineBean.getMixMatchTriggerValue()#" />
<cfinput type="text" name="MixMatchUnit" label="MixMatchUnit" required="yes" message="Please provide the MixMatchUnit" validate="float" style="width:400px;" value="#PosLineBean.getMixMatchUnit()#" />
<cfinput type="text" name="ModifierExt" label="ModifierExt" required="yes" message="Please provide the ModifierExt" validate="float" style="width:400px;" value="#PosLineBean.getModifierExt()#" />
<cfinput type="text" name="ModifierID" label="ModifierID" required="yes" message="Please provide the ModifierID" validate="integer" style="width:400px;" value="#PosLineBean.getModifierID()#" />
<cfinput type="text" name="ModifierType" label="ModifierType" required="yes" message="Please provide the ModifierType" validate="integer" style="width:400px;" value="#PosLineBean.getModifierType()#" />
<cfinput type="text" name="ModifierUnit" label="ModifierUnit" required="yes" message="Please provide the ModifierUnit" validate="float" style="width:400px;" value="#PosLineBean.getModifierUnit()#" />
<cfinput type="text" name="PosLineID" label="PosLineID" required="yes" message="Please provide the PosLineID" validate="integer" style="width:400px;" value="#PosLineBean.getPosLineID()#" />
<cfinput type="text" name="PosTXID" label="PosTXID" required="yes" message="Please provide the PosTXID" validate="integer" style="width:400px;" value="#PosLineBean.getPosTXID()#" />
<cfinput type="text" name="PriceSource" label="PriceSource" required="yes" message="Please provide the PriceSource" validate="integer" style="width:400px;" value="#PosLineBean.getPriceSource()#" />
<cfinput type="text" name="ProductCode" label="ProductCode" required="yes" message="Please provide the ProductCode"  maxlength="20" style="width:400px;" value="#PosLineBean.getProductCode()#" />
<cfinput type="text" name="ProductID" label="ProductID" required="yes" message="Please provide the ProductID" validate="integer" style="width:400px;" value="#PosLineBean.getProductID()#" />
<cfinput type="text" name="ProductType" label="ProductType" required="yes" message="Please provide the ProductType" validate="integer" style="width:400px;" value="#PosLineBean.getProductType()#" />
<cfinput type="text" name="Quantity" label="Quantity" required="yes" message="Please provide the Quantity" validate="float" style="width:400px;" value="#PosLineBean.getQuantity()#" />
<cfinput type="text" name="QuantityVoid" label="QuantityVoid" required="yes" message="Please provide the QuantityVoid" validate="float" style="width:400px;" value="#PosLineBean.getQuantityVoid()#" />
<cfinput type="text" name="SaleExt" label="SaleExt" required="yes" message="Please provide the SaleExt" validate="float" style="width:400px;" value="#PosLineBean.getSaleExt()#" />
<cfinput type="text" name="SaleUnit" label="SaleUnit" required="yes" message="Please provide the SaleUnit" validate="float" style="width:400px;" value="#PosLineBean.getSaleUnit()#" />
<cfinput type="text" name="SeatID" label="SeatID" required="yes" message="Please provide the SeatID" validate="integer" style="width:400px;" value="#PosLineBean.getSeatID()#" />
<cfinput type="text" name="SellExt" label="SellExt" required="yes" message="Please provide the SellExt" validate="float" style="width:400px;" value="#PosLineBean.getSellExt()#" />
<cfselect name="SellIncludeTax" label="SellIncludeTax">
<option value="1" <cfif #PosLineBean.getSellIncludeTax()# eq "1">selected="selected"</cfif>>Yes</option>
<option value="0" <cfif #PosLineBean.getSellIncludeTax()# eq "0">selected="selected"</cfif>>No</option>
</cfselect>
<cfinput type="text" name="SellUnit" label="SellUnit" required="yes" message="Please provide the SellUnit" validate="float" style="width:400px;" value="#PosLineBean.getSellUnit()#" />
<cfinput type="text" name="SpecialID" label="SpecialID" required="yes" message="Please provide the SpecialID" validate="integer" style="width:400px;" value="#PosLineBean.getSpecialID()#" />
<cfinput type="text" name="SubTotalDiscountExt" label="SubTotalDiscountExt" required="yes" message="Please provide the SubTotalDiscountExt" validate="float" style="width:400px;" value="#PosLineBean.getSubTotalDiscountExt()#" />
<cfinput type="text" name="SubTotalDiscountUnit" label="SubTotalDiscountUnit" required="yes" message="Please provide the SubTotalDiscountUnit" validate="float" style="width:400px;" value="#PosLineBean.getSubTotalDiscountUnit()#" />
<cfinput type="text" name="SubTotalSurchargeExt" label="SubTotalSurchargeExt" required="yes" message="Please provide the SubTotalSurchargeExt" validate="float" style="width:400px;" value="#PosLineBean.getSubTotalSurchargeExt()#" />
<cfinput type="text" name="SubTotalSurchargeUnit" label="SubTotalSurchargeUnit" required="yes" message="Please provide the SubTotalSurchargeUnit" validate="float" style="width:400px;" value="#PosLineBean.getSubTotalSurchargeUnit()#" />
<cfinput type="text" name="TaxExt" label="TaxExt" required="yes" message="Please provide the TaxExt" validate="float" style="width:400px;" value="#PosLineBean.getTaxExt()#" />
<cfinput type="text" name="TaxID" label="TaxID" required="yes" message="Please provide the TaxID" validate="integer" style="width:400px;" value="#PosLineBean.getTaxID()#" />
<cfinput type="text" name="TaxRate" label="TaxRate" required="yes" message="Please provide the TaxRate" validate="float" style="width:400px;" value="#PosLineBean.getTaxRate()#" />
<cfinput type="text" name="TaxUnit" label="TaxUnit" required="yes" message="Please provide the TaxUnit" validate="float" style="width:400px;" value="#PosLineBean.getTaxUnit()#" />
<cfinput type="text" name="VoidExt" label="VoidExt" required="yes" message="Please provide the VoidExt" validate="float" style="width:400px;" value="#PosLineBean.getVoidExt()#" />
<cfinput type="text" name="WalletID" label="WalletID" required="yes" message="Please provide the WalletID" validate="integer" style="width:400px;" value="#PosLineBean.getWalletID()#" />
<cfinput type="text" name="WalletStatus" label="WalletStatus" required="yes" message="Please provide the WalletStatus" validate="integer" style="width:400px;" value="#PosLineBean.getWalletStatus()#" />
<cfinput type="submit" name="submit" value="Submit" class="submitbutton" />
</cfform>
