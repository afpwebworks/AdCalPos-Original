

<cfset MyRecordID = #ListGetAt(URL.CFGRIDKEY,1)#>

<CFLOCATION url="tblEmpStatus_RecordView.cfm?RecordID=#MyRecordID#"> 
