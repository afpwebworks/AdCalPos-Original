

<cfset MyRecordID = #ListGetAt(URL.CFGRIDKEY,1)#>

<CFLOCATION url="tblEmployee_RecordView.cfm?RecordID=#MyRecordID#"> 
