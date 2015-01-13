<cfsilent>
<!----[
==========================================================================================================
Filename:      tblStockPrice_form.cfm
Description:   Form for  handling tblStockPrice Requires a bean called StockPrice to exist already.
Date:          8/December/2010 
Author:        Michael Kear

Revision history:

==========================================================================================================
]--->
</cfsilent>

<cfoutput>
<div align="center">
<fieldset class="CMSForm">
  <legend>Price description</legend>
  <form name="tblStockPriceform" action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="post">
    <cfif (isdefined("errorhandler") AND  (errorhandler.haserrors()))>
      <div class="errorhandler"> #errorhandler.MakeErrorDisplay(errorhandler)# </div>
    </cfif>
    <input type="hidden" name="AddedBy" value="#StockPrice.getAddedBy()#" />
    <input type="hidden" name="DateAdded" value="#StockPrice.getDateAdded()#" />
    <input type="hidden" name="DateUpdated" value="#StockPrice.getDateUpdated()#" />
    <input type="hidden" name="IsVisible" value="#StockPrice.getIsVisible()#" />
    <input type="hidden" name="PriceID" value="#StockPrice.getPriceID()#" />
    <input type="hidden" name="UpdatedBy" value="#StockPrice.getUpdatedBy()#" />
    <div class="form-row">
      <label for="Description">The name of the price: </label>
      <input type="text" name="Description" id="Description" required="no"  maxlength="50" style="width:400px;" value="#StockPrice.getDescription()#" />
    </div>
    <div class="form-row">
      <input type="submit" name="submit" value="Submit" class="submitbutton" />
    </div>
  </form>
</fieldset>
</div>
</cfoutput>
