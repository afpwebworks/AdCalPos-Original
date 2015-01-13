

<cfset MyRecordID = #ListGetAt(URL.CFGRIDKEY,1)#>

'get the ID based on the ID


<CFLOCATION url="tblStockMaster_RecordView.cfm?PartNO=#MyRecordID#" addtoken="no"> 
