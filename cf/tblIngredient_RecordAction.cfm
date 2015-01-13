
    <!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->   
	
	<CFIF 
	ParameterExists(Form.btnView_Previous) or 
	ParameterExists(Form.btnView_Next) or
	ParameterExists(Form.btnView_First) or
	ParameterExists(Form.btnView_Last)
	>

	<CFQUERY name="GetRecord" maxRows=1      datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT DISTINCT tblStockMaster.PartNo as ID_Field, tblStockMaster.Description, tblIngredient.ingredientPLU, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit
		FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)
		INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo 
		WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') 
		
		
		<CFIF ParameterExists(Form.btnView_Previous)>
			AND tblIngredient.SalePLU = '#Form.PartNum#' 
			AND tblIngredient.ingredientPLU < '#Form.RecordID#'
			ORDER BY tblIngredient.ingredientPLU DESC

		<CFELSEIF ParameterExists(Form.btnView_Next)>
			AND tblIngredient.SalePLU =  '#Form.PartNum#' 
			AND tblIngredient.ingredientPLU > '#Form.RecordID#'
			ORDER BY tblIngredient.ingredientPLU

		<CFELSEIF ParameterExists(Form.btnView_First)>
			AND tblIngredient.SalePLU = '#Form.PartNum#' 
			ORDER BY tblIngredient.ingredientPLU

		<CFELSEIF ParameterExists(Form.btnView_Last)>
			AND tblIngredient.SalePLU = '#Form.PartNum#' 
			ORDER BY tblIngredient.ingredientPLU DESC

		</CFIF>

	</CFQUERY>
 <CFIF GetRecord.RecordCount is 1>
		
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#GetRecord.ID_Field#&SaleID=#Form.PartNum#">
	<CFELSE>
		<CFQUERY name="GetNext" maxRows=1      datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
			SELECT DISTINCT tblStockMaster.PartNo as ID_Field, tblStockMaster.Description, tblIngredient.ingredientPLU, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit, tblIngredient.SalePLU
			FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)
			INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo 
			WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') 
			AND tblIngredient.SalePLU = '#Form.PartNum#' 
			ORDER BY tblIngredient.ingredientPLU
		</CFQUERY>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#GetNext.ingredientPLU#&SaleID=#GetNext.SalePLU#">
					
	</CFIF> 

	
<!---			EDIT BUTTON (view page)			--->
<CFELSEIF ParameterExists(Form.btnView_Edit)>

	<CFLOCATION url="tblIngredient_RecordEdit.cfm?RecordID=#Form.RecordID#&SaleID=#Form.PartNum#">


<!---			ADD BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Add)>

	<CFLOCATION url="tblIngredient.cfm?RecordID=#Form.PartNum#">


<!---			DELETE BUTTON (view page)			--->

<CFELSEIF ParameterExists(Form.btnView_Delete)>

	<CFQUERY name="GetNext" maxRows=1      datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT DISTINCT tblStockMaster.PartNo as ID_Field, tblStockMaster.Description, tblIngredient.ingredientPLU, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit, tblIngredient.SalePLU
		FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)
		INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo 
		WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') 
		AND tblIngredient.SalePLU =  '#Form.PartNum#' 
		AND tblIngredient.ingredientPLU > '#Form.RecordID#'
		ORDER BY tblIngredient.ingredientPLU
	</CFQUERY>
	
	<CFQUERY name="DeleteRecord" maxRows=1      datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblIngredient
		WHERE tblIngredient.SalePLU = #Form.PartNum#
		AND tblIngredient.ingredientPLU = #Form.RecordID#
	</CFQUERY>
	<CFIF #GetNext.RecordCount# EQ 1>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#GetNext.ingredientPLU#&SaleID=#GetNext.SalePLU#">
	<CFELSE>
		<CFQUERY name="GetFirst" maxRows=1      datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
			SELECT DISTINCT tblStockMaster.PartNo as ID_Field, tblStockMaster.Description, tblIngredient.ingredientPLU, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit, tblIngredient.SalePLU
			FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)
			INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo 
			WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') 
			AND tblIngredient.SalePLU = '#Form.PartNum#' 
			ORDER BY tblIngredient.ingredientPLU
		</CFQUERY>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#GetFirst.ingredientPLU#&SaleID=#GetFirst.SalePLU#">
	</CFIF>
<!---			OK BUTTON (edit page)				--->
 <CFELSEIF ParameterExists(Form.btnEdit_OK)>
 
 
		<cfset strQuery = "UPDATE tblIngredient SET tblIngredient.qtyIngredient = #form.Quantity#">
		<cfset strQuery = strQuery & " where tblIngredient.SalePLU=#form.SaleID# ">
		<cfset strQuery = strQuery & " and tblIngredient.ingredientPLU=#form.RecordID#"> 
					
		<CFQUERY name="UpdateData"  datasource="#application.dsn#"   > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#Form.RecordID#&SaleID=#form.SaleID#">
	
<!---			CANCEL BUTTON (edit page)			--->

<CFELSEIF ParameterExists(Form.btnEdit_Cancel)>

	<CFIF ParameterExists(Form.RecordID)>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=#Form.RecordID#&SaleID=#form.SaleID#">
	<CFELSE>
		<CFLOCATION url="tblIngredients_RecordView.cfm?RecordID=0&SaleID=0">
	</CFIF> 

</CFIF>
