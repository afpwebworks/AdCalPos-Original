<cfsilent>
<!----[
==========================================================================================================
Filename:      form_PosBean.cfm
Description:   Form for  handling Pos Requires a bean called PosBean to exist already.
Date:          4/April/2010 
Author:        Michael Kear

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfform name="Posform" action="#cgi.SCRIPT_NAME#" method="post" format="xml" skin="#application.formskin#" scriptsrc="#application.scriptsource#" >
<cfformitem type="html">
<cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
  <cfoutput>
  <div class="errorhandler"> #errorhandler.MakeErrorDisplay(errorhandler)# </div>
  </cfoutput>
</cfif>
</cfformitem>
<cfinput type="text" name="ClerkID" label="ClerkID" required="yes" message="Please provide the ClerkID" validate="integer" style="width:400px;" value="#PosBean.getClerkID()#" />
<cfinput type="text" name="CostTotal" label="CostTotal" required="yes" message="Please provide the CostTotal" validate="float" style="width:400px;" value="#PosBean.getCostTotal()#" />
<cfinput type="text" name="CoverQuantity" label="CoverQuantity" required="yes" message="Please provide the CoverQuantity" validate="integer" style="width:400px;" value="#PosBean.getCoverQuantity()#" />
<cfinput type="text" name="DebtorID" label="DebtorID" required="yes" message="Please provide the DebtorID" validate="integer" style="width:400px;" value="#PosBean.getDebtorID()#" />
<cfinput type="text" name="DebtorName" label="DebtorName" required="yes" message="Please provide the DebtorName"  maxlength="50" style="width:400px;" value="#PosBean.getDebtorName()#" />
<cfinput type="text" name="DiscountTotal" label="DiscountTotal" required="yes" message="Please provide the DiscountTotal" validate="float" style="width:400px;" value="#PosBean.getDiscountTotal()#" />
<cfinput type="text" name="DrawerID" label="DrawerID" required="yes" message="Please provide the DrawerID" validate="integer" style="width:400px;" value="#PosBean.getDrawerID()#" />
<cfinput type="text" name="DueTotal" label="DueTotal" required="yes" message="Please provide the DueTotal" validate="float" style="width:400px;" value="#PosBean.getDueTotal()#" />
<cfinput type="text" name="ItemDiscountTotal" label="ItemDiscountTotal" required="yes" message="Please provide the ItemDiscountTotal" validate="float" style="width:400px;" value="#PosBean.getItemDiscountTotal()#" />
<cfinput type="text" name="ItemSurchargeTotal" label="ItemSurchargeTotal" required="yes" message="Please provide the ItemSurchargeTotal" validate="float" style="width:400px;" value="#PosBean.getItemSurchargeTotal()#" />
<cfinput type="text" name="LineSaleTotal" label="LineSaleTotal" required="yes" message="Please provide the LineSaleTotal" validate="float" style="width:400px;" value="#PosBean.getLineSaleTotal()#" />
<cfinput type="text" name="LineTaxTotal" label="LineTaxTotal" required="yes" message="Please provide the LineTaxTotal" validate="float" style="width:400px;" value="#PosBean.getLineTaxTotal()#" />
<cfinput type="text" name="LocationID" label="LocationID" required="yes" message="Please provide the LocationID" validate="integer" style="width:400px;" value="#PosBean.getLocationID()#" />
<cfinput type="text" name="MediaChangeTotal" label="MediaChangeTotal" required="yes" message="Please provide the MediaChangeTotal" validate="float" style="width:400px;" value="#PosBean.getMediaChangeTotal()#" />
<cfinput type="text" name="MediaRoundTotal" label="MediaRoundTotal" required="yes" message="Please provide the MediaRoundTotal" validate="float" style="width:400px;" value="#PosBean.getMediaRoundTotal()#" />
<cfinput type="text" name="MediaTaxTotal" label="MediaTaxTotal" required="yes" message="Please provide the MediaTaxTotal" validate="float" style="width:400px;" value="#PosBean.getMediaTaxTotal()#" />
<cfinput type="text" name="MediaTotal" label="MediaTotal" required="yes" message="Please provide the MediaTotal" validate="float" style="width:400px;" value="#PosBean.getMediaTotal()#" />
<cfinput type="text" name="MemberID" label="MemberID" required="yes" message="Please provide the MemberID" validate="integer" style="width:400px;" value="#PosBean.getMemberID()#" />
<cfinput type="text" name="MemberName" label="MemberName" required="yes" message="Please provide the MemberName"  maxlength="50" style="width:400px;" value="#PosBean.getMemberName()#" />
<cfinput type="text" name="PosCode" label="PosCode" required="yes" message="Please provide the PosCode"  maxlength="20" style="width:400px;" value="#PosBean.getPosCode()#" />
<cfinput type="text" name="PosID" label="PosID" required="yes" message="Please provide the PosID" validate="integer" style="width:400px;" value="#PosBean.getPosID()#" />
<cfinput type="text" name="PosStatus" label="PosStatus" required="yes" message="Please provide the PosStatus" validate="integer" style="width:400px;" value="#PosBean.getPosStatus()#" />
<cfinput type="hidden" name="PosTXID" value="#PosBean.getPosTXID()#" />
<cfinput type="text" name="PosType" label="PosType" required="yes" message="Please provide the PosType" validate="integer" style="width:400px;" value="#PosBean.getPosType()#" />
<cfinput type="text" name="PriceID" label="PriceID" required="yes" message="Please provide the PriceID" validate="integer" style="width:400px;" value="#PosBean.getPriceID()#" />
<cfinput type="text" name="SaleTotal" label="SaleTotal" required="yes" message="Please provide the SaleTotal" validate="float" style="width:400px;" value="#PosBean.getSaleTotal()#" />
<cfinput type="text" name="SeatCount" label="SeatCount" required="yes" message="Please provide the SeatCount" validate="integer" style="width:400px;" value="#PosBean.getSeatCount()#" />
<cfinput type="text" name="StoreID" label="StoreID" required="yes" message="Please provide the StoreID" validate="integer" style="width:400px;" value="#PosBean.getStoreID()#" />
<cfinput type="text" name="SubTotalDiscount" label="SubTotalDiscount" required="yes" message="Please provide the SubTotalDiscount" validate="float" style="width:400px;" value="#PosBean.getSubTotalDiscount()#" />
<cfinput type="text" name="SubTotalDiscountDescription" label="SubTotalDiscountDescription" required="yes" message="Please provide the SubTotalDiscountDescription"  maxlength="50" style="width:400px;" value="#PosBean.getSubTotalDiscountDescription()#" />
<cfinput type="text" name="SubTotalDiscountEntryType" label="SubTotalDiscountEntryType" required="yes" message="Please provide the SubTotalDiscountEntryType" validate="integer" style="width:400px;" value="#PosBean.getSubTotalDiscountEntryType()#" />
<cfinput type="text" name="SubTotalDiscountID" label="SubTotalDiscountID" required="yes" message="Please provide the SubTotalDiscountID" validate="integer" style="width:400px;" value="#PosBean.getSubTotalDiscountID()#" />
<cfinput type="text" name="SubTotalDiscountRate" label="SubTotalDiscountRate" required="yes" message="Please provide the SubTotalDiscountRate" validate="float" style="width:400px;" value="#PosBean.getSubTotalDiscountRate()#" />
<cfinput type="text" name="SubTotalSurcharge" label="SubTotalSurcharge" required="yes" message="Please provide the SubTotalSurcharge" validate="float" style="width:400px;" value="#PosBean.getSubTotalSurcharge()#" />
<cfinput type="text" name="SubTotalSurchargeDescription" label="SubTotalSurchargeDescription" required="yes" message="Please provide the SubTotalSurchargeDescription"  maxlength="50" style="width:400px;" value="#PosBean.getSubTotalSurchargeDescription()#" />
<cfinput type="text" name="SubTotalSurchargeEntryType" label="SubTotalSurchargeEntryType" required="yes" message="Please provide the SubTotalSurchargeEntryType" validate="integer" style="width:400px;" value="#PosBean.getSubTotalSurchargeEntryType()#" />
<cfinput type="text" name="SubTotalSurchargeID" label="SubTotalSurchargeID" required="yes" message="Please provide the SubTotalSurchargeID" validate="integer" style="width:400px;" value="#PosBean.getSubTotalSurchargeID()#" />
<cfinput type="text" name="SubTotalSurchargeRate" label="SubTotalSurchargeRate" required="yes" message="Please provide the SubTotalSurchargeRate" validate="float" style="width:400px;" value="#PosBean.getSubTotalSurchargeRate()#" />
<cfinput type="text" name="TableID" label="TableID" required="yes" message="Please provide the TableID" validate="integer" style="width:400px;" value="#PosBean.getTableID()#" />
<cfinput type="text" name="TaxTotal" label="TaxTotal" required="yes" message="Please provide the TaxTotal" validate="float" style="width:400px;" value="#PosBean.getTaxTotal()#" />
<cfinput type="text" name="TerminalID" label="TerminalID" required="yes" message="Please provide the TerminalID" validate="integer" style="width:400px;" value="#PosBean.getTerminalID()#" />
<cfformgroup type="horizontal">
<cfselect name="TimestampDay" label="Timestamp">
<cfloop from="1" to="31" index="i">
<cfoutput>
<option value="#i#" <cfif #datepart("d", PosBean.getTimestamp())# eq "#i#">selected="selected"</cfif>>#i#</option>
</cfoutput>
</cfloop>
<br/>
</cfselect>
<cfselect name="TimestampMonth">
<cfloop from="1" to="12" index="i">
<cfoutput>
<option value="#i#" <cfif #datepart("m",PosBean.getTimestamp())# eq "#i#">selected="selected"</cfif>>#monthasstring(i)#</option>
</cfoutput>
</cfloop>
</cfselect>
<cfselect name="TimestampYear">
<cfloop from="#datepart("yyyy",now())#" to="2055" index="i">
<cfoutput>
<option value="#i#" <cfif #datepart("yyyy",PosBean.getTimestamp())# eq "#i#">selected="selected"</cfif>>#i#</option>
</cfoutput>
</cfloop>
</cfselect>
</cfformgroup>
<cfinput type="text" name="Tips" label="Tips" required="yes" message="Please provide the Tips" validate="float" style="width:400px;" value="#PosBean.getTips()#" />
<cfinput type="text" name="VoidTotal" label="VoidTotal" required="yes" message="Please provide the VoidTotal" validate="float" style="width:400px;" value="#PosBean.getVoidTotal()#" />
<cfinput type="text" name="WalletCount" label="WalletCount" required="yes" message="Please provide the WalletCount" validate="integer" style="width:400px;" value="#PosBean.getWalletCount()#" />
<cfinput type="submit" name="submit" value="Submit" class="submitbutton" />
</cfform>
