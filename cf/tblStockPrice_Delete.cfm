<cfsilent>
<!----
==========================================================================================================
Filename:    tblStockPrice_Delete.cfm
Description: Deletes a StockPrice from the database and returns the user to the originating page. Works with ColdSpring 1.0
Date:        8/Dec/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->
<!----[  Initialise the form for deletes:  ]----->
<cfif NOT(isdefined("StockPrice"))>
  <cfset StockPrice = application.beanfactory.getBean("StockPrice") />
</cfif>
<cfif NOT(isdefined("StockPricesDAO"))>
  <cfset StockPricesDAO =   application.beanfactory.getBean("StockPricesDAO") />
</cfif>
<cfif NOT(isdefined("url.PriceID")) AND NOT(isdefined("form.submitpage"))>
  <cflocation addtoken="no" url="index.cfm" />
</cfif>
<cfset StockPrice.setPriceID(PriceID) />
<cfset StockPricesDAO.delete(StockPrice) />
<cflocation addtoken="no" url="/cf/tblStockPrice_RecordList.cfm" />
</cfsilent>