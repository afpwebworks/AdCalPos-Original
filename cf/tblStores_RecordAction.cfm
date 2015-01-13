
<CFIF 
	StructKeyExists(Form, "btnView_Previous") or 
	StructKeyExists(Form, "btnView_Next") or
	StructKeyExists(Form, "btnView_First") or
	StructKeyExists(Form, "btnView_Last")>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblStores.StoreID AS ID_Field
		FROM tblStores

		<CFIF StructKeyExists(Form, "btnView_Previous")>
			WHERE tblStores.StoreID < #Form.RecordID#
			ORDER BY tblStores.StoreID DESC

		<CFELSEIF StructKeyExists(Form, "btnView_Next")>
			WHERE tblStores.StoreID > #Form.RecordID#
			ORDER BY tblStores.StoreID

		<CFELSEIF StructKeyExists(Form, "btnView_First")>
			ORDER BY tblStores.StoreID

		<CFELSEIF StructKeyExists(Form, "btnView_Last")>
			WHERE tblStores.StoreID > #Form.RecordID#
			ORDER BY tblStores.StoreID DESC

		</CFIF>

	</CFQUERY>

	<CFIF GetRecord.RecordCount is 1>
		<CFLOCATION url="tblStores_RecordView.cfm?RecordID=#GetRecord.ID_Field#">
	<CFELSE>
		<CFLOCATION url="tblStores_RecordView.cfm?RecordID=#Form.RecordID#">
	</CFIF>


<!---			EDIT BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Edit")>

	<CFLOCATION url="tblStores_RecordEdit.cfm?RecordID=#Form.RecordID#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Add")>

	<CFLOCATION url="tblStores_RecordEdit.cfm">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF StructKeyExists(Form, "btnView_Delete")>

	<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStores
		WHERE tblStores.StoreID = #Form.RecordID#
	</CFQUERY>
	<CFLOCATION url="tblStores_RecordView.cfm">


<!---			OK BUTTON (edit page)				--->

<CFELSEIF StructKeyExists(Form, "btnEdit_OK")>
	<CFIF StructKeyExists(Form, "RecordID")>
		<!--- <CFUPDATE datasource="#application.dsn#"  tableName="tblStores" formFields="#Form.FieldList#"> --->
		
		<CFQUERY name="UpdateTheRecord" datasource="#application.dsn#" > 
			UPDATE tblStores 
            SET 
            tblStores.StoreName = '#Form.StoreName#', 
            tblStores.Manager1Name = '#Form.Manager1Name#', 
            tblStores.Manager2Name = '#Form.Manager2Name#', 
            tblStores.StoreGroupID = convert(int,#Form.StoreGroupID#), 
            tblStores.Phone = '#Form.Phone#', 
            tblStores.Fax = '#Form.Fax#', 
            tblStores.Mobile = '#Form.Mobile#', 
            tblStores.email = '#Form.email#', 
            tblStores.CreditLimit = #Form.CreditLimit#, 
            tblStores.NoLongerUsed = #Form.NoLongerUsed#, 
            tblStores.ABN = '#Form.ABN#', 
            tblStores.Address = '#Form.Address#', 
            tblStores.Suburb = '#Form.Suburb#', 
            tblStores.State = '#Form.State#', 
            tblStores.PostCode = '#Form.PostCode#' 
		WHERE (((tblStores.StoreID)=#Form.StoreID#))
		</CFQUERY>
		<!--- <CFUPDATE DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" tableName="tblStores" formFields="#Form.FieldList#"> --->
		<CFLOCATION url="tblStores_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
	   <!--- Check to see if the store ID is not creating any duplicates --->

		<CFQUERY name="CheckIDofRecord" datasource="#application.dsn#" > 
			Select * from tblStores where StoreID = convert(int,#Form.StoreID#)
		</CFQUERY>
		<cfif #CheckIDofRecord.RecordCount# GT 0>
			<cfoutput><BR>Store ID #Form.StoreID# has already been assigned to another store.  Please use another ID and try again.</cfoutput>
			<cfabort>		
		</cfif>
		<!--- Make sure that the store ID is less or equal 30 --->
		<cfset lngStoreID = #int(Form.StoreID)#>
		<cfif #lngStoreID# GT 50>
			<cfoutput>Store ID should be less than 50.  We can not have a store ID #lngStoreID#</cfoutput>
			<cfabort>		
		</cfif>
		
	
		<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="InsertTheRecord" datasource="#application.dsn#" > 
			Insert into tblStores (StoreID, StoreName, Manager1Name, Manager2Name, StoreGroupID, Phone, Fax, Mobile, email, CreditLimit, NoLongerUsed, ABN, Address, Suburb, State, PostCode) Values 
            (convert(int,#lngStoreID#), '#Form.StoreName#', '#Form.Manager1Name#', '#Form.Manager2Name#', convert(int,#Form.StoreGroupID#), '#Form.Phone#', '#Form.Fax#', '#Form.Mobile#', '#Form.email#', #Form.CreditLimit#, #Form.NoLongerUsed#, '#Form.ABN#', '#Form.Address#', '#Form.Suburb#', '#Form.State#', '#Form.PostCode#') 
		</CFQUERY>
		
		<!--- Add the items into the location table --->
		
		<CFQUERY name="CreateRecordsInLocationTable" datasource="#application.dsn#" > 
			INSERT INTO tblStockLocation ( PartNo, ProductID, StoreID ) 
		SELECT tblStockMaster.PartNo, tblStockMaster.ProductID, #lngStoreID# AS StoreIDNew 
		FROM tblStockMaster LEFT OUTER JOIN 
		qryPLUforStore#lngStoreID# ON tblStockMaster.PartNo = qryPLUforStore#lngStoreID#.PartNo 
		WHERE (qryPLUforStore#lngStoreID#.ID IS NULL)
		</CFQUERY>
		

		<CFQUERY name="GetNewRecord" maxRows=1 datasource="#application.dsn#" > 
			SELECT tblStores.StoreID AS ID_Field
			FROM tblStores
			ORDER BY tblStores.StoreID DESC
		</CFQUERY>
		<CFLOCATION url="tblStores_RecordView.cfm?RecordID=#GetNewRecord.ID_Field#">
	</CFIF>

<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF StructKeyExists(Form, "btnEdit_Cancel")>

	<CFIF StructKeyExists(Form, "RecordID")>
		<CFLOCATION url="tblStores_RecordView.cfm?RecordID=#Form.RecordID#">
	<CFELSE>
		<CFLOCATION url="tblStores_RecordView.cfm">
	</CFIF>

</CFIF>
