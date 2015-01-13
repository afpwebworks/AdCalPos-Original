<cfcomponent displayname="StockMaster" output="false" hint="A bean which models the StockMaster record.">

<cfsilent>
<!----
================================================================
Filename: StockMaster.cfc
Description: A bean which models the StockMaster record.
Author:  Michael Kear, AFP Webworks 
Date: 5/Nov/2010
================================================================
This bean was generated with the following template:
Bean Name: StockMaster
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PartNo string 
	Description string 
	SupplyUnit string 
	OrderingUnit string 
	Label string 
	GroupNo numeric 0
	TCode numeric 1
	PCode numeric 0
	RCode numeric 0
	Tolerance numeric 0
	Cost numeric 0
	Wholesale numeric 0
	MaxRetail numeric 0
	PriceLevels struct #structNew()#
	PluType string N
	LockOrderUnitType boolean false
	MinOrderQty numeric 0
	PictureFile numeric 0
	PictureFileName string 
	NoLongerUsed boolean false
	SuppressOrder boolean false
	SuppressStocktake boolean false
	DateEntered string 
	ID numeric 0
	PartNoBuyingPlu string 
	PartNoSalePlu string 
	Ratio numeric 1
	PrepCode string 
	ThreeHRebate numeric 0
	SCRebate numeric 0
	ThreeHRebateVal numeric 0
	SCRebateVal numeric 0
	ParentCost numeric 0
	TypeID numeric 2
	ProductID numeric 0
	kitchentype numeric 255
	ModifierID numeric 0
	ModifierType numeric 255
	CostUnit numeric 0
	IsWeighed boolean false
	Tare numeric 0
	AllowZeroPrice boolean false
	Discountable boolean false
	IsCountDown boolean false
	AllowOpenPrice boolean false
	DiscountNo numeric 0
	KitchenPrint string 000000000
	PointsAwarded numeric 0
	PointsRequiredToBuy numeric 0
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="StockMaster" output="false">
		<cfargument name="PartNo" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="SupplyUnit" type="string" required="false" default="" />
		<cfargument name="OrderingUnit" type="string" required="false" default="" />
		<cfargument name="Label" type="string" required="false" default="" />
		<cfargument name="GroupNo" type="numeric" required="false" default="0" />
		<cfargument name="TCode" type="numeric" required="false" default="1" />
		<cfargument name="PCode" type="numeric" required="false" default="0" />
		<cfargument name="RCode" type="numeric" required="false" default="0" />
		<cfargument name="Tolerance" type="numeric" required="false" default="0" />
		<cfargument name="Cost" type="numeric" required="false" default="0" />
		<cfargument name="Wholesale" type="numeric" required="false" default="0" />
		<cfargument name="MaxRetail" type="numeric" required="false" default="0" />
        <cfargument name="PriceLevels" type="struct" required="false" default="#structNew()#" />
		<cfargument name="PluType" type="string" required="false" default="N" />
		<cfargument name="LockOrderUnitType" type="boolean" required="false" default="false" />
		<cfargument name="MinOrderQty" type="numeric" required="false" default="0" />
		<cfargument name="PictureFile" type="numeric" required="false" default="0" />
        <cfargument name="PictureFileName" type="string" required="false" default="" />
		<cfargument name="NoLongerUsed" type="boolean" required="false" default="false" />
		<cfargument name="SuppressOrder" type="boolean" required="false" default="false" />
		<cfargument name="SuppressStocktake" type="boolean" required="false" default="false" />
		<cfargument name="DateEntered" type="string" required="false" default="" />
		<cfargument name="ID" type="numeric" required="false" default="0" />
		<cfargument name="PartNoBuyingPlu" type="string" required="false" default="" />
		<cfargument name="PartNoSalePlu" type="string" required="false" default="" />
		<cfargument name="Ratio" type="numeric" required="false" default="1" />
		<cfargument name="PrepCode" type="string" required="false" default="" />
		<cfargument name="ThreeHRebate" type="numeric" required="false" default="0" />
		<cfargument name="SCRebate" type="numeric" required="false" default="0" />
		<cfargument name="ThreeHRebateVal" type="numeric" required="false" default="0" />
		<cfargument name="SCRebateVal" type="numeric" required="false" default="0" />
		<cfargument name="ParentCost" type="numeric" required="false" default="0" />
		<cfargument name="TypeID" type="numeric" required="false" default="2" />
		<cfargument name="ProductID" type="numeric" required="false" default="0" />
		<cfargument name="kitchentype" type="numeric" required="false" default="1" />
		<cfargument name="ModifierID" type="numeric" required="false" default="0" />
        <cfargument name="ModifierType" type="numeric" required="false" default="255" />
		<cfargument name="CostUnit" type="numeric" required="false" default="0" />
		<cfargument name="IsWeighed" type="boolean" required="false" default="false" />
		<cfargument name="Tare" type="numeric" required="false" default="0" />
		<cfargument name="AllowZeroPrice" type="boolean" required="false" default="false" />
		<cfargument name="Discountable" type="boolean" required="false" default="false" />
		<cfargument name="IsCountDown" type="boolean" required="false" default="false" />
		<cfargument name="AllowOpenPrice" type="boolean" required="false" default="false" />
		<cfargument name="DiscountNo" type="numeric" required="false" default="0" />
		<cfargument name="KitchenPrint" type="string" required="false" default="000000000" />
		<cfargument name="PointsAwarded" type="numeric" required="false" default="0" />
		<cfargument name="PointsRequiredToBuy" type="numeric" required="false" default="0" />
		<cfscript>
			// run setters
			setPartNo(arguments.PartNo);
			setDescription(arguments.Description);
			setSupplyUnit(arguments.SupplyUnit);
			setOrderingUnit(arguments.OrderingUnit);
			setLabel(arguments.Label);
			setGroupNo(arguments.GroupNo);
			setTCode(arguments.TCode);
			setPCode(arguments.PCode);
			setRCode(arguments.RCode);
			setTolerance(arguments.Tolerance);
			setCost(arguments.Cost);
			setWholesale(arguments.Wholesale);
			setMaxRetail(arguments.MaxRetail);
			setPriceLevels(arguments.PriceLevels);        
			setPluType(arguments.PluType);
			setLockOrderUnitType(arguments.LockOrderUnitType);
			setMinOrderQty(arguments.MinOrderQty);
			setPictureFile(arguments.PictureFile);
			setPictureFileName(arguments.PictureFileName);
			setNoLongerUsed(arguments.NoLongerUsed);
			setSuppressOrder(arguments.SuppressOrder);
			setSuppressStocktake(arguments.SuppressStocktake);
			setDateEntered(arguments.DateEntered);
			setID(arguments.ID);
			setPartNoBuyingPlu(arguments.PartNoBuyingPlu);
			setPartNoSalePlu(arguments.PartNoSalePlu);
			setRatio(arguments.Ratio);
			setPrepCode(arguments.PrepCode);
			setThreeHRebate(arguments.ThreeHRebate);
			setSCRebate(arguments.SCRebate);
			setThreeHRebateVal(arguments.ThreeHRebateVal);
			setSCRebateVal(arguments.SCRebateVal);
			setParentCost(arguments.ParentCost);
			setTypeID(arguments.TypeID);
			setProductID(arguments.ProductID);
			setKitchentype(arguments.kitchentype);
			setModifierID(arguments.ModifierID);
			setModifierType(arguments.ModifierType);
			setCostUnit(arguments.CostUnit);
			setIsWeighed(arguments.IsWeighed);
			setTare(arguments.Tare);
			setAllowZeroPrice(arguments.AllowZeroPrice);
			setDiscountable(arguments.Discountable);
			setIsCountDown(arguments.IsCountDown);
			setAllowOpenPrice(arguments.AllowOpenPrice);
			setDiscountNo(arguments.DiscountNo);
			setKitchenPrint(arguments.KitchenPrint);
			setPointsAwarded(arguments.PointsAwarded);
			setPointsRequiredToBuy(arguments.PointsRequiredToBuy);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

<cffunction name="validate" access="public" returntype="any" output="false">
     <cfargument name="eH" required="true" type="any" />
            <!-----[ validation parameters  (customise to suit) then remove comments  ]---->
            
               <!----[ PartNo ]---->                                                                   
                <cfif ( len(getPartNo()) LT "1" )>                                                        
                    <cfset arguments.eH.setError("PartNo", "PartNo is required.") />         
                </cfif>
                 <!----[ PartNo ]---->                                                                   
                <cfif ( len(getPartNo()) GT "16" )>                                                        
                    <cfset arguments.eH.setError("PartNo", "PartNo must be maximum of 16 characters long.") />         
                </cfif>
                
                 <!----[ Group ]---->                                                                   
                <cfif ( getGroupNo() eq "0" )>                                                        
                    <cfset arguments.eH.setError("GroupNo", "You must select a group.") />         
                </cfif>

             
		<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
	<cffunction name="setPartNo" access="public" returntype="void" output="false">
		<cfargument name="PartNo" type="string" required="true" />
		<cfset variables.instance.PartNo = arguments.PartNo />
	</cffunction>
	<cffunction name="getPartNo" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PartNo />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setSupplyUnit" access="public" returntype="void" output="false">
		<cfargument name="SupplyUnit" type="string" required="true" />
		<cfset variables.instance.SupplyUnit = arguments.SupplyUnit />
	</cffunction>
	<cffunction name="getSupplyUnit" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SupplyUnit />
	</cffunction>

	<cffunction name="setOrderingUnit" access="public" returntype="void" output="false">
		<cfargument name="OrderingUnit" type="string" required="true" />
		<cfset variables.instance.OrderingUnit = arguments.OrderingUnit />
	</cffunction>
	<cffunction name="getOrderingUnit" access="public" returntype="string" output="false">
		<cfreturn variables.instance.OrderingUnit />
	</cffunction>

	<cffunction name="setLabel" access="public" returntype="void" output="false">
		<cfargument name="Label" type="string" required="true" />
		<cfset variables.instance.Label = arguments.Label />
	</cffunction>
	<cffunction name="getLabel" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Label />
	</cffunction>

	<cffunction name="setGroupNo" access="public" returntype="void" output="false">
		<cfargument name="GroupNo" type="numeric" required="true" />
		<cfset variables.instance.GroupNo = arguments.GroupNo />
	</cffunction>
	<cffunction name="getGroupNo" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.GroupNo />
	</cffunction>

	<cffunction name="setTCode" access="public" returntype="void" output="false">
		<cfargument name="TCode" type="numeric" required="true" />
		<cfset variables.instance.TCode = arguments.TCode />
	</cffunction>
	<cffunction name="getTCode" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TCode />
	</cffunction>

	<cffunction name="setPCode" access="public" returntype="void" output="false">
		<cfargument name="PCode" type="numeric" required="true" />
		<cfset variables.instance.PCode = arguments.PCode />
	</cffunction>
	<cffunction name="getPCode" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PCode />
	</cffunction>

	<cffunction name="setRCode" access="public" returntype="void" output="false">
		<cfargument name="RCode" type="numeric" required="true" />
		<cfset variables.instance.RCode = arguments.RCode />
	</cffunction>
	<cffunction name="getRCode" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.RCode />
	</cffunction>

	<cffunction name="setTolerance" access="public" returntype="void" output="false">
		<cfargument name="Tolerance" type="numeric" required="true" />
		<cfset variables.instance.Tolerance = arguments.Tolerance />
	</cffunction>
	<cffunction name="getTolerance" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Tolerance />
	</cffunction>

	<cffunction name="setCost" access="public" returntype="void" output="false">
		<cfargument name="Cost" type="numeric" required="true" />
		<cfset variables.instance.Cost = arguments.Cost />
	</cffunction>
	<cffunction name="getCost" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Cost />
	</cffunction>

	<cffunction name="setWholesale" access="public" returntype="void" output="false">
		<cfargument name="Wholesale" type="numeric" required="true" />
		<cfset variables.instance.Wholesale = arguments.Wholesale />
	</cffunction>
	<cffunction name="getWholesale" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Wholesale />
	</cffunction>

	<cffunction name="setMaxRetail" access="public" returntype="void" output="false">
		<cfargument name="MaxRetail" type="numeric" required="true" />
		<cfset variables.instance.MaxRetail = arguments.MaxRetail />
	</cffunction>
	<cffunction name="getMaxRetail" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MaxRetail />
	</cffunction>

	<cffunction name="setPriceLevels" access="public" returntype="void" output="false">
		<cfargument name="PriceLevels" type="struct" required="true" />
		<cfset variables.instance.PriceLevels = arguments.PriceLevels />
	</cffunction>
	<cffunction name="getPriceLevels" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.PriceLevels />
	</cffunction>

	<cffunction name="setPluType" access="public" returntype="void" output="false">
		<cfargument name="PluType" type="string" required="true" />
		<cfset variables.instance.PluType = arguments.PluType />
	</cffunction>
	<cffunction name="getPluType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PluType />
	</cffunction>

	<cffunction name="setLockOrderUnitType" access="public" returntype="void" output="false">
		<cfargument name="LockOrderUnitType" type="boolean" required="true" />
		<cfset variables.instance.LockOrderUnitType = arguments.LockOrderUnitType />
	</cffunction>
	<cffunction name="getLockOrderUnitType" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.LockOrderUnitType />
	</cffunction>

	<cffunction name="setMinOrderQty" access="public" returntype="void" output="false">
		<cfargument name="MinOrderQty" type="numeric" required="true" />
		<cfset variables.instance.MinOrderQty = arguments.MinOrderQty />
	</cffunction>
	<cffunction name="getMinOrderQty" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.MinOrderQty />
	</cffunction>

	<cffunction name="setPictureFile" access="public" returntype="void" output="false">
		<cfargument name="PictureFile" type="numeric" required="true" />
		<cfset variables.instance.PictureFile = arguments.PictureFile />
	</cffunction>
	<cffunction name="getPictureFile" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PictureFile />
	</cffunction>
    
    <cffunction name="setPictureFileName" access="public" returntype="void" output="false">
		<cfargument name="PictureFileName" type="string" required="true" />
		<cfset variables.instance.PictureFileName = arguments.PictureFileName />
	</cffunction>
	<cffunction name="getPictureFileName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PictureFileName />
	</cffunction>
    
	<cffunction name="setNoLongerUsed" access="public" returntype="void" output="false">
		<cfargument name="NoLongerUsed" type="boolean" required="true" />
		<cfset variables.instance.NoLongerUsed = arguments.NoLongerUsed />
	</cffunction>
	<cffunction name="getNoLongerUsed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.NoLongerUsed />
	</cffunction>

	<cffunction name="setSuppressOrder" access="public" returntype="void" output="false">
		<cfargument name="SuppressOrder" type="boolean" required="true" />
		<cfset variables.instance.SuppressOrder = arguments.SuppressOrder />
	</cffunction>
	<cffunction name="getSuppressOrder" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.SuppressOrder />
	</cffunction>

	<cffunction name="setSuppressStocktake" access="public" returntype="void" output="false">
		<cfargument name="SuppressStocktake" type="boolean" required="true" />
		<cfset variables.instance.SuppressStocktake = arguments.SuppressStocktake />
	</cffunction>
	<cffunction name="getSuppressStocktake" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.SuppressStocktake />
	</cffunction>

	<cffunction name="setDateEntered" access="public" returntype="void" output="false">
		<cfargument name="DateEntered" type="string" required="true" />
		<cfset variables.instance.DateEntered = arguments.DateEntered />
	</cffunction>
	<cffunction name="getDateEntered" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateEntered />
	</cffunction>

	<cffunction name="setID" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true" />
		<cfset variables.instance.ID = arguments.ID />
	</cffunction>
	<cffunction name="getID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ID />
	</cffunction>

	<cffunction name="setPartNoBuyingPlu" access="public" returntype="void" output="false">
		<cfargument name="PartNoBuyingPlu" type="string" required="true" />
		<cfset variables.instance.PartNoBuyingPlu = arguments.PartNoBuyingPlu />
	</cffunction>
	<cffunction name="getPartNoBuyingPlu" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PartNoBuyingPlu />
	</cffunction>

	<cffunction name="setPartNoSalePlu" access="public" returntype="void" output="false">
		<cfargument name="PartNoSalePlu" type="string" required="true" />
		<cfset variables.instance.PartNoSalePlu = arguments.PartNoSalePlu />
	</cffunction>
	<cffunction name="getPartNoSalePlu" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PartNoSalePlu />
	</cffunction>

	<cffunction name="setRatio" access="public" returntype="void" output="false">
		<cfargument name="Ratio" type="numeric" required="true" />
		<cfset variables.instance.Ratio = arguments.Ratio />
	</cffunction>
	<cffunction name="getRatio" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Ratio />
	</cffunction>

	<cffunction name="setPrepCode" access="public" returntype="void" output="false">
		<cfargument name="PrepCode" type="string" required="true" />
		<cfset variables.instance.PrepCode = arguments.PrepCode />
	</cffunction>
	<cffunction name="getPrepCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PrepCode />
	</cffunction>

	<cffunction name="setThreeHRebate" access="public" returntype="void" output="false">
		<cfargument name="ThreeHRebate" type="numeric" required="true" />
		<cfset variables.instance.ThreeHRebate = arguments.ThreeHRebate />
	</cffunction>
	<cffunction name="getThreeHRebate" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ThreeHRebate />
	</cffunction>

	<cffunction name="setSCRebate" access="public" returntype="void" output="false">
		<cfargument name="SCRebate" type="numeric" required="true" />
		<cfset variables.instance.SCRebate = arguments.SCRebate />
	</cffunction>
	<cffunction name="getSCRebate" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SCRebate />
	</cffunction>

	<cffunction name="setThreeHRebateVal" access="public" returntype="void" output="false">
		<cfargument name="ThreeHRebateVal" type="numeric" required="true" />
		<cfset variables.instance.ThreeHRebateVal = arguments.ThreeHRebateVal />
	</cffunction>
	<cffunction name="getThreeHRebateVal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ThreeHRebateVal />
	</cffunction>

	<cffunction name="setSCRebateVal" access="public" returntype="void" output="false">
		<cfargument name="SCRebateVal" type="numeric" required="true" />
		<cfset variables.instance.SCRebateVal = arguments.SCRebateVal />
	</cffunction>
	<cffunction name="getSCRebateVal" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SCRebateVal />
	</cffunction>

	<cffunction name="setParentCost" access="public" returntype="void" output="false">
		<cfargument name="ParentCost" type="numeric" required="true" />
		<cfset variables.instance.ParentCost = arguments.ParentCost />
	</cffunction>
	<cffunction name="getParentCost" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ParentCost />
	</cffunction>

	<cffunction name="setTypeID" access="public" returntype="void" output="false">
		<cfargument name="TypeID" type="numeric" required="true" />
		<cfset variables.instance.TypeID = arguments.TypeID />
	</cffunction>
	<cffunction name="getTypeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TypeID />
	</cffunction>

	<cffunction name="setProductID" access="public" returntype="void" output="false">
		<cfargument name="ProductID" type="numeric" required="true" />
		<cfset variables.instance.ProductID = arguments.ProductID />
	</cffunction>
	<cffunction name="getProductID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ProductID />
	</cffunction>

	<cffunction name="setKitchentype" access="public" returntype="void" output="false">
		<cfargument name="kitchentype" type="numeric" required="true" />
		<cfset variables.instance.kitchentype = arguments.kitchentype />
	</cffunction>
	<cffunction name="getKitchentype" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.kitchentype />
	</cffunction>

	<cffunction name="setModifierType" access="public" returntype="void" output="false">
		<cfargument name="ModifierType" type="numeric" required="true" />
		<cfset variables.instance.ModifierType = arguments.ModifierType />
	</cffunction>
	<cffunction name="getModifierType" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ModifierType />
	</cffunction>
    
    	<cffunction name="setModifierID" access="public" returntype="void" output="false">
		<cfargument name="ModifierID" type="numeric" required="true" />
		<cfset variables.instance.ModifierID = arguments.ModifierID />
	</cffunction>
	<cffunction name="getModifierID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ModifierID />
	</cffunction>



	<cffunction name="setCostUnit" access="public" returntype="void" output="false">
		<cfargument name="CostUnit" type="numeric" required="true" />
		<cfset variables.instance.CostUnit = arguments.CostUnit />
	</cffunction>
	<cffunction name="getCostUnit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.CostUnit />
	</cffunction>

	<cffunction name="setIsWeighed" access="public" returntype="void" output="false">
		<cfargument name="IsWeighed" type="boolean" required="true" />
		<cfset variables.instance.IsWeighed = arguments.IsWeighed />
	</cffunction>
	<cffunction name="getIsWeighed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsWeighed />
	</cffunction>

	<cffunction name="setTare" access="public" returntype="void" output="false">
		<cfargument name="Tare" type="numeric" required="true" />
		<cfset variables.instance.Tare = arguments.Tare />
	</cffunction>
	<cffunction name="getTare" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Tare />
	</cffunction>

	<cffunction name="setAllowZeroPrice" access="public" returntype="void" output="false">
		<cfargument name="AllowZeroPrice" type="boolean" required="true" />
		<cfset variables.instance.AllowZeroPrice = arguments.AllowZeroPrice />
	</cffunction>
	<cffunction name="getAllowZeroPrice" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.AllowZeroPrice />
	</cffunction>

	<cffunction name="setDiscountable" access="public" returntype="void" output="false">
		<cfargument name="Discountable" type="boolean" required="true" />
		<cfset variables.instance.Discountable = arguments.Discountable />
	</cffunction>
	<cffunction name="getDiscountable" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.Discountable />
	</cffunction>

	<cffunction name="setIsCountDown" access="public" returntype="void" output="false">
		<cfargument name="IsCountDown" type="boolean" required="true" />
		<cfset variables.instance.IsCountDown = arguments.IsCountDown />
	</cffunction>
	<cffunction name="getIsCountDown" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsCountDown />
	</cffunction>

	<cffunction name="setAllowOpenPrice" access="public" returntype="void" output="false">
		<cfargument name="AllowOpenPrice" type="boolean" required="true" />
		<cfset variables.instance.AllowOpenPrice = arguments.AllowOpenPrice />
	</cffunction>
	<cffunction name="getAllowOpenPrice" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.AllowOpenPrice />
	</cffunction>

	<cffunction name="setDiscountNo" access="public" returntype="void" output="false">
		<cfargument name="DiscountNo" type="numeric" required="true" />
		<cfset variables.instance.DiscountNo = arguments.DiscountNo />
	</cffunction>
	<cffunction name="getDiscountNo" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.DiscountNo />
	</cffunction>

	<cffunction name="setKitchenPrint" access="public" returntype="void" output="false">
		<cfargument name="KitchenPrint" type="string" required="true" />
		<cfset variables.instance.KitchenPrint = arguments.KitchenPrint />
	</cffunction>
	<cffunction name="getKitchenPrint" access="public" returntype="string" output="false">
		<cfreturn variables.instance.KitchenPrint />
	</cffunction>

	<cffunction name="setPointsAwarded" access="public" returntype="void" output="false">
		<cfargument name="PointsAwarded" type="numeric" required="true" />
		<cfset variables.instance.PointsAwarded = arguments.PointsAwarded />
	</cffunction>
	<cffunction name="getPointsAwarded" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PointsAwarded />
	</cffunction>

	<cffunction name="setPointsRequiredToBuy" access="public" returntype="void" output="false">
		<cfargument name="PointsRequiredToBuy" type="numeric" required="true" />
		<cfset variables.instance.PointsRequiredToBuy = arguments.PointsRequiredToBuy />
	</cffunction>
	<cffunction name="getPointsRequiredToBuy" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PointsRequiredToBuy />
	</cffunction>

</cfcomponent>