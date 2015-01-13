<!---[   Instantiate the objects required for the page.   ]---->
<cfset StockBarcodesDAO = application.beanfactory.getbean("StockBarcodesDAO") />
<cfset StockMasterDAO = application.beanfactory.getbean("StockMasterDAO") />
<cfif not StructKeyExists(session, "errorhandler")>
  <cfset session.errorhandler = application.beanfactory.getbean("errorhandler") />
</cfif>
<cfset StockMaster = application.beanfactory.getbean("StockMaster") />

<!---[   Next-Previous navigation buttons parameters   ]---->

<CFIF 
			StructKeyExists(Form, "btnView_Previous") or 
			StructKeyExists(Form, "btnView_Next" ) or
			StructKeyExists(Form, "btnView_First" ) or
			StructKeyExists(Form, "btnView_Last" )>
  <CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
		SELECT tblStockMaster.PartNo AS ID_Field
		FROM tblStockMaster

		<CFIF StructKeyExists(Form, "btnView_Previous")>
			WHERE tblStockMaster.PartNo < '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo DESC

		<CFELSEIF StructKeyExists(Form, "btnView_Next" )>
			WHERE tblStockMaster.PartNo > '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo

		<CFELSEIF StructKeyExists(Form, "btnView_First" )>
			ORDER BY tblStockMaster.PartNo

		<CFELSEIF StructKeyExists(Form, "btnView_Last" )>
			WHERE tblStockMaster.PartNo > '#Form.RecordID#'
			ORDER BY tblStockMaster.PartNo DESC

		</CFIF>

	</CFQUERY>
  <CFIF GetRecord.RecordCount is 1>
    <CFLOCATION url="tblStockMaster_RecordView.cfm?PartNo=#GetRecord.ID_Field#" addtoken="no">
    <CFELSE>
    <CFLOCATION url="tblStockMaster_RecordView.cfm?PartNo=#Form.RecordID#" addtoken="no">
  </CFIF>

  <!---			Price Formula BUTTON (view page)			--->
<CFELSEIF StructKeyExists(Form, "btnView_PriceFormula" )>
  
  <!--- <cfset session.PriceFormulaItemID ="#Form.RecordID#"> ---> 
  <!--- <CFLOCATION url="tblStockPriceFormula_RecordList.cfm"> --->
  
  	<CFLOCATION url="PriceFormulaGrid.cfm?PN=#Form.RecordID#" addtoken="no">
  <CFELSEIF StructKeyExists(Form, "btnAdd_Ingredient")>
  	<CFLOCATION url="tblIngredient.cfm?RecordID=#Form.RecordID#" addtoken="no">
  <CFELSEIF StructKeyExists(Form, "btnEdit_Ingredient")>
  	<CFLOCATION url="tblIngredientEdit.cfm?RecordID=#Form.RecordID#" addtoken="no">
  
  <!---			EDIT BUTTON (view page)			--->
  <CFELSEIF StructKeyExists(Form, "btnView_Edit")>
  	<CFLOCATION url="tblStockMaster_RecordEdit.cfm?RecordID=#Form.RecordID#" addtoken="no">
  
  <!---			ADD BUTTON (view page)			--->
  
  <CFELSEIF StructKeyExists(Form, "btnView_Add")>
  	<CFLOCATION url="tblStockMaster_RecordEdit.cfm" addtoken="no">
  
  <!---			DELETE BUTTON (view page)			--->
  
  <CFELSEIF StructKeyExists(Form, "btnView_Delete")>
	  <cfscript>
            Stockmaster.setPartNO( form.recordID  );
			StockMasterDAO.delete( Stockmaster ) ;
        </cfscript>
  <!---[   <CFQUERY name="DeleteRecord" maxRows=1      datasource="#application.dsn#"         > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
		DELETE
		FROM tblStockMaster
		WHERE tblStockMaster.PartNo = #Form.RecordID#
	</CFQUERY>   ]----> 
  <!---[   	<CFLOCATION url="tblStockMaster_RecordView.cfm" addtoken="no">   ]---->
  <CFLOCATION url="tblStockMaster_RecordList.cfm" addtoken="no">
  
  <!---			OK BUTTON (edit page)				--->
  <CFELSEIF StructKeyExists(Form, "btnEdit_OK")>
  <!--- check the group no --->
  <cfset MyGroupNo = #Form.GroupNo#>
  <cfif #MyGroupNo# eq 0>
  <cfset session.errorhandler.setError("Group", "Please select a group") /> 
    <!---[   <br>
    Please select the group and try again.
    <cfabort>   ]---->
  </cfif>

  
  <cfif StructKeyExists(Form, "RecordID")>
	<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
    <cfscript>
   		StockMaster.setWholesale(  trim(Form.Wholesale) );
   		StockMaster.setDescription(    trim(Form.Description) );
   		StockMaster.setSupplyUnit(   trim(Form.SupplyUnit) );
   		StockMaster.setOrderingUnit(   trim(Form.OrderingUnit) );
   		StockMaster.setLabel(   trim(Form.Label) );
   		StockMaster.setGroupNo(   val(Form.GroupNo) );
   		StockMaster.setTCode(   val(Form.TCode) );
   		StockMaster.setPCode(   val(Form.PCode) );
   		StockMaster.setRCode(   val(Form.RCode) );
   		StockMaster.setMaxRetail(   trim(Form.MaxRetail) );
		StockMaster.setID(      trim(form.ID)   );
   		StockMaster.setPluType(   trim(Form.PluType) );
   		StockMaster.setLockOrderUnitType(   trim(Form.LockOrderUnitType) );
     	StockMaster.setMinOrderQty(   trim(Form.MinOrderQty) );
   		StockMaster.setPictureFile(   val(Form.PictureFile) );
   		StockMaster.setNoLongerUsed(   trim(Form.NoLongerUsed) );
   		StockMaster.setSuppressOrder(   trim(Form.SuppressOrder) );
   		StockMaster.setSuppressStocktake(   trim(Form.SuppressStocktake) );
   		StockMaster.setPartNoBuyingPlu(   trim(Form.PartNoBuyingPlu) );
   		StockMaster.setPartNoSalePlu(   trim(Form.PartNoSalePlu) );
   		StockMaster.setRatio(   trim(Form.Ratio) );
   		StockMaster.setPrepCode(   trim(Form.PrepCode) );
   		StockMaster.setPartNo(   trim(Form.PartNo) );
     	StockMaster.setTolerance(   trim(Form.Tolerance) );
		StockMaster.setCost(   trim(Form.Cost) );
		StockMaster.setParentCost(   trim(Form.ParentCost) );
		StockMaster.setTypeID(   trim(Form.TypeID) );
		StockMaster.setProductID(   trim(Form.ID) );
		StockMaster.setKitchentype(   trim(Form.kitchentype) );
		StockMaster.setModifierID(   trim(Form.ModifierID) );
		StockMaster.setModifierType(   trim(Form.ModifierType) );
		StockMaster.setCostUnit(   trim(Form.CostUnit) );
		StockMaster.setIsWeighed(   trim(Form.IsWeighed) );
		StockMaster.setTare(   trim(Form.Tare) );
		StockMaster.setAllowZeroPrice(   trim(Form.AllowZeroPrice) );
		StockMaster.setDiscountable(   trim(Form.Discountable) );
		StockMaster.setIsCountDown(   trim(Form.IsCountDown) );
		StockMaster.setAllowOpenPrice(   trim(Form.AllowOpenPrice) );
		StockMaster.setDiscountNo(   trim(Form.DiscountNo) );
		StockMaster.setKitchenPrint(   trim(Form.KitchenPrint) );
		StockMaster.setPointsAwarded(   trim(Form.PointsAwarded) );
		StockMaster.setPointsRequiredToBuy(   trim(Form.PointsRequiredToBuy) );
		StockMasterDAO.setRebateCodes( stockmaster ) ;	

			//StockMaster.setThreeHRebate(   trim(Form.ThreeHRebate) );
			//StockMaster.setSCRebate(   trim(Form.SCRebate) );
			//StockMaster.setThreeHRebateVal(   trim(Form.ThreeHRebateVal) );
			//StockMaster.setSCRebateVal(   trim(Form.SCRebateVal) );
			
		
   </cfscript>
   

    <!---[     Check the partNO and productID are unique.   ]---->
 	<cfset session.errorhandler = StockMasterDAO.CheckUnique( stockmaster, session.errorhandler ) />
	<!---[     Validate the rest of the stock record   ]---->
	<cfset session.errorhandler = StockMaster.validate(session.errorhandler) />  
   <!---[    If it still validates ok, then go ahead and save it,  otherwise, return to the edit form with problems explained.   ]---->    
	<cfif NOT(session.errorhandler.haserrors())>
		      <cfset StockMasterDAO.save(StockMaster) />
		      <cfset structDelete(session, "errorhandler") />
    		 <CFLOCATION url="/cf/tblStockMaster_RecordView.cfm?RecordID=#stockmaster.getProductID()#" addtoken="no">
    		 
    		 <cfabort> 
    <cfelse>    
    	   <CFLOCATION url="/cf/tblStockMaster_RecordEdit.cfm?RecordID=#stockmaster.getProductID()#" addtoken="no">
 	</cfif>
 

    <CFLOCATION url="/cf/tblStockMaster_RecordView.cfm?RecordID=#stockmaster.getProductID()#" addtoken="no">
  </CFIF>
  
  <!---			CANCEL BUTTON (edit page)			--->
  
  <CFELSEIF structKeyExists(Form, "btnEdit_Cancel")>
  	   <cfif isdefined("stockmaster") and ( stockmaster.getProductID() neq '0') >
       		<cflocation url="tblStockMaster_RecordView.cfm?RecordID=#stockmaster.getProductID()#" addtoken="no">
       <cfelseif structKeyExists(Form, "ID") AND (len(form.id) GT 0 )>
            <cflocation url="tblStockMaster_RecordView.cfm?RecordID=#Form.ID#" addtoken="no">
	   <cfelseif structKeyExists(Form, "RecordID") AND (len(form.recordid) GT 0 )>
            <cflocation url="tblStockMaster_RecordView.cfm?RecordID=#Form.RecordID#" addtoken="no">
      <cfelse>
           <cflocation url="tblStockMaster_RecordList.cfm" addtoken="no">
      </cfif>
</CFIF>


