
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<!--- Get the date and validate it. --->
<cfset lngStoreID = session.storeid>

<cfset strDay=right(form.sDate,2)>
<cfset strMonth=mid(form.sDate,5,2)>
<cfset strYear=left(form.sDate,4)>
<cfif len(#strDay#) EQ 1>
	<cfset strDay = "0" & "#strDay#" >
</cfif>
<cfif len(#strMonth#) EQ 1>
	<cfset strMonth = "0" & "#strMonth#" >
</cfif>

<cfset strDate = "#strDay#" & "#strMonth#" & "#strYear#">
<cfif len(#strDate#) EQ 7>
	<cfset strDate = "0" & "#strDate#" >
</cfif>

<CFSET strValidDate = ''>
<CF_ValidateThisDate strDateValue= "#strDate#">

<cfif strValidDate EQ "N">
<!--- 	Invalid Date --->
	<cflocation URL = "ValidDateMessage.cfm">
</cfif>

<!--- Check for 4:00 pm in the future --->
<CFSET strDateToday = ''>
<CF_GetTodayDate>
<CFSET lngDateToday = "#mid(strDateToday,5,4)#" & "#mid(strDateToday,3,2)#" & "#mid(strDateToday,1,2)#">
<CFSET lngMyDate = "#mid(strDate,5,4)#" & "#mid(strDate,3,2)#" & "#mid(strDate,1,2)#">

<CFSET lngCurTime = 0>
<CF_GetCurrentTime>

<cfif lngMyDate LT lngDateToday>
	<!--- Invalid Date --->
	<cflocation URL = "ValidDateMessage.cfm?Message=Past orders can not be viewed">
</cfif>

<CFSET lngCutOffTime = 0>

<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE --->
<!--- <CF_GetOrderingCutOffTime> --->
<CFINCLUDE template="GetOrderingCutOffTime.cfm">

<cfif lngCurTime GT lngCutOffTime >
	<cfif lngMyDate EQ lngDateToday>
		<!--- 	Invalid Date --->
		<cflocation URL = "ValidDateMessage.cfm?Message=It is after #lngCutOffTime# and today order can not be viewed">
	</cfif>
</cfif>

<!--- Create an order header if it is has not been created already --->
<CFQUERY name="CheckHeader" maxRows=1 datasource="#application.dsn#" > 
	SELECT 	tblOrderHeader.OrderID, tblOrderHeader.StoreID, tblOrderHeader.OrderDate, tblOrderHeader.Comments
	FROM 	tblOrderHeader 
	WHERE 	tblOrderHeader.StoreID =#lngStoreID# 
	AND 	tblOrderHeader.OrderDate='#strDate#'
	AND 	typeID = 1
	AND		isPrinted != 1
</CFQUERY>

<cfif CheckHeader.RecordCount EQ 0>
	<!--- Insert the header --->
	<CFQUERY name="InsertOrderHeader" datasource="#application.dsn#" > 
		INSERT INTO tblOrderHeader (StoreID, OrderDate, typeID)
		VALUES 		(#lngStoreID# , '#strDate#', 1)
	</CFQUERY>
</cfif>

<!--- Get the order ID --->
<CFQUERY name="CheckMyOrderHeader" datasource="#application.dsn#" > 
	SELECT 	tblOrderHeader.OrderID, tblOrderHeader.StoreID, tblOrderHeader.OrderDate, tblOrderHeader.Comments 
	FROM 	tblOrderHeader
	WHERE 	tblOrderHeader.StoreID=#lngStoreID#
	AND 	tblOrderHeader.OrderDate='#strDate#'
	AND 	typeID = 1
	AND		isPrinted != 1
</CFQUERY>
<cfset lngOrderID = CheckMyOrderHeader.OrderID>

<!--- Check to see if this date is already in the order detail table --->
<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
	SELECT 	tblOrderDetail.OrderDetID, tblOrderDetail.StoreID, tblOrderDetail.OrderDate, isPrinted 
	FROM 	tblOrderDetail
	WHERE 	tblOrderDetail.StoreID=#lngStoreID# 
	AND 	tblOrderDetail.OrderDate='#strDate#'
	AND		tblOrderDetail.typeID = 1
			<!--- <cfif session.usertype EQ 6 OR session.usertype EQ 7 OR session.usertype EQ 8 OR session.usertype EQ 9>
				AND		isPrinted != 1
			</cfif> --->
</CFQUERY>
<cfoutput>#GetRecord.RecordCount#</cfoutput>

<cfif GetRecord.RecordCount GT 0>
	<!--- order for that date already exists --->
	<cfif session.usertype EQ 6 OR session.usertype EQ 7 OR session.usertype EQ 8 OR session.usertype EQ 9>
		<cfif GetRecord.isPrinted>
			<!--- Order Exists and has been printed --->
			<cflocation URL = "PurchaseOrderRequestCompleted.cfm">
		<cfelse>
			<!---Order Exists and Hasn't been printed yet.--->
			<cflocation URL = "PurchaseOrderList.cfm?DD=#strDate#&type=1">
		</cfif>
	<cfelse>
			<!--- Order Exists and is by accessible to usertype between 1 and 5 --->
		<cflocation URL = "PurchaseOrderList.cfm?DD=#strDate#&type=1">
	</cfif>
<cfelse>
	<!--- Copy the products into the orders table --->
	<!--- inser both items suppressed from order and not suppressed.  But only show the not suppressed on the purchanse order --->
	<!--- There's no order for that date, create a new order --->	
		<CFQUERY name="CopyRecord" datasource="#application.dsn#" > 
			INSERT INTO tblOrderDetail 
						(OrderID, 
						StoreID, 
						OrderDate, 
						Status, 
						PartNo, 
						Description, 
						OrderingUnit, 
						SupplyUnit, 
						MinOrderQty, 
						SuppressOrder,
						typeID) 
			SELECT 		#lngStoreID# as OrderID, 
						#lngStoreID# AS StoreID, 
						'#strDate#' AS OrderDate, 
						'Open Order' AS Status, 
						tblStockMaster.PartNo, 
						tblStockMaster.Description, 
						tblStockMaster.OrderingUnit, 
						tblStockMaster.SupplyUnit, 
						tblStockMaster.MinOrderQty, 
						tblStockMaster.SuppressOrder,
						tblStockMaster.typeID
			FROM 		tblStockMaster 
			WHERE 		((tblStockMaster.NoLongerUsed=0) 
			AND 		((tblStockMaster.PluType='N') OR (tblStockMaster.PluType='M')) )
			AND			tblStockMaster.typeID = 1
		</CFQUERY>
		<cflocation URL = "PurchaseOrderList.cfm?DD=#strDate#&type=1">
	<!--- </cfif> --->
</cfif>

