

<cfset MyRecordID = #ListGetAt(URL.CFGRIDKEY,1)#>
<cfset sale = #URL.TopRecord#>
<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#MyRecordID#&SaleID=#sale#"> 
