<cfcomponent displayname="PosLine DAO" output="false" hint="DAO Component Handles all Database access for the table PosLine.  Requires Coldspring v1.0">
<cfsilent>
<!----
==========================================================================================================
Filename:    PosLinesDAO.cfc
Description: DAO Component Handles all Database access for the table PosLine.  Requires Coldspring v1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

If a column needs to enter NULL Instead of nothing, use the following code in that CFQUERYparam:
null="#(NOT len( PosLineBean.getpostxid() ))#"

==========================================================================================================
--->
</cfsilent>
<!--- Constructor / initialisation --->
<cffunction name="init" access="Public" returntype="PosLinesDAO" output="false" hint="Initialises the controller">
<cfargument name="argsConfiguration" required="true" type="cfcs.config.configbean" />
	<cfset variables.config  = arguments.argsConfiguration />
	<cfset variables.dsn = variables.config.getDSN() />
	<cfset variables.austime = variables.config.getAusTime() />
	<cfreturn this />
</cffunction>


<cffunction name="save" access="public" returntype="PosLineBean" output="false" hint="DAO method">
<cfargument name="PosLineBean" type="PosLineBean" required="yes" />
<!---[   Only allow a create by this DAO - update should never be required.   ]---->

	<!---[   <cfset recordexists( arguments.PosLineBean ) > ]---->
	
	<!---[   check if department exists if not change to department 1  ]---->
	<cfset departmentexists( arguments.PosLineBean  ) />


  <!---[   <cfif (arguments.PosLineBean.getPosTXID() neq "0")>	>
		<cfset PosLineBean = update(arguments.PosLineBean)/>
	<cfelse>   ]---->
		<cfset PosLineBean = create(arguments.PosLineBean)/>
	<!---[   </cfif>   ]---->
	<cfreturn PosLineBean />
</cffunction>

<cffunction name="delete" returntype="void" output="false" hint="DAO method" >
<cfargument name="PosLineBean" type="PosLineBean" required="true" /> 
	<cfset var qPosLineBeanDelete = 0 >
<cfquery name="PosLineBeanDelete" datasource="#variables.dsn#" >
		DELETE FROM PosLine
		WHERE 
		PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	
</cffunction>

<cffunction name="recordexists" access="public" returntype="PosLineBean" output="no" hint="Checks if a record already exists in the database">
    <cfargument name="argsPosLineBean" required="yes" type="PosLineBean" />
    <cfset var RecordID = arguments.argsRecordID />
    <cfset var Result = false />
    
    <cfquery name="qPosLineExists" datasource="#variables.dsn#">
        SELECT PosLineID from PosLine 
        WHERE PosLineID = <cfqueryparam value="#recordID#" cfsqltype="cf_sql_integer" /> 
    </cfquery>
    <cfif qPosLineExists.recordcount> <Cfset result=True /></cfif>
    <cfreturn result />
</cffunction>

<cffunction name="departmentexists" access="public" returntype="PosLineBean" output="no" hint="Checks if a department already exists in the database. If not, changes the departmentID in the bean to default of 1">
    <cfargument name="argsPosLineBean" required="yes" type="PosLineBean" />
    <cfset var PosLineBean = arguments.argsPosLineBean />
    <cfset var DepartmentID = PosLineBean.getDepartmentID() />
    <cfset var qdepartmentexists = 0 />
    
    <cfquery name="qdepartmentexists" datasource="#variables.dsn#">
        SELECT DeptNo from tblStockdept
        WHERE DeptNo = <cfqueryparam value="#DepartmentID#" cfsqltype="cf_sql_integer" />
    </cfquery>
     <cfif  (qdepartmentexists.recordcount neq "1" )> 
	    <cfset PosLineBean.setDepartmentID( "1" ) />
	 </cfif>
    <cfreturn PosLineBean />
</cffunction>


<cffunction name="read" access="public" returntype="PosLineBean" output="false" hint="DAO Method. - Reads a PosLineBean into the bean">
<cfargument name="argsPosLineBean" type="PosLineBean" required="true" />
	<cfset var PosLineBean  =  arguments.argsPosLineBean />
	<cfset var QPosLineselect = "" />
	<cfquery name="QPosLineselect" datasource="#variables.dsn#">
		SELECT 
		PosTXID, PosLineID, ProductID, Description, WalletID, SeatID, ProductCode, ProductType, WalletStatus, DepartmentID, KitchenType, KitchenPrinted, KitchenPrint, ModifierType, ModifierID, Quantity, QuantityVoid, CostIncludeTax, CostUnit, CostExt, SellIncludeTax, SellUnit, SellExt, ModifierUnit, ModifierExt, DiscountID, DiscountDescription, DiscountRate, DiscountUnit, DiscountExt, ExtaxUnit, DiscountEntryType, DiscountMaxLimit, DiscountType, ExtaxExt, TaxID, TaxRate, TaxUnit, TaxExt, SaleUnit, SaleExt, VoidExt, SpecialID, PriceSource, MixMatchExt, SubTotalDiscountUnit, SubTotalDiscountExt, SubTotalSurchargeUnit, SubTotalSurchargeExt, MixMatchUnit, MixMatchID, MixMatchDescription, MixMatchGiveAwayItem, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger
		FROM PosLine 
		WHERE 
		PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#"  cfsqltype="CF_SQL_INTEGER"/>
	</cfquery>
	<cfif QPosLineselect.recordCount >
		<cfscript>
		PosLineBean.setPosTXID(QPosLineselect.PosTXID);
         PosLineBean.setPosLineID(QPosLineselect.PosLineID);
         PosLineBean.setProductID(QPosLineselect.ProductID);
         PosLineBean.setDescription(QPosLineselect.Description);
         PosLineBean.setWalletID(QPosLineselect.WalletID);
         PosLineBean.setSeatID(QPosLineselect.SeatID);
         PosLineBean.setProductCode(QPosLineselect.ProductCode);
         PosLineBean.setProductType(QPosLineselect.ProductType);
         PosLineBean.setWalletStatus(QPosLineselect.WalletStatus);
         PosLineBean.setDepartmentID(QPosLineselect.DepartmentID);
         PosLineBean.setKitchenType(QPosLineselect.KitchenType);
         PosLineBean.setKitchenPrinted(QPosLineselect.KitchenPrinted);
         PosLineBean.setKitchenPrint(QPosLineselect.KitchenPrint);
         PosLineBean.setModifierType(QPosLineselect.ModifierType);
         PosLineBean.setModifierID(QPosLineselect.ModifierID);
         PosLineBean.setQuantity(QPosLineselect.Quantity);
         PosLineBean.setQuantityVoid(QPosLineselect.QuantityVoid);
         PosLineBean.setCostIncludeTax(QPosLineselect.CostIncludeTax);
         PosLineBean.setCostUnit(QPosLineselect.CostUnit);
         PosLineBean.setCostExt(QPosLineselect.CostExt);
         PosLineBean.setSellIncludeTax(QPosLineselect.SellIncludeTax);
         PosLineBean.setSellUnit(QPosLineselect.SellUnit);
         PosLineBean.setSellExt(QPosLineselect.SellExt);
         PosLineBean.setModifierUnit(QPosLineselect.ModifierUnit);
         PosLineBean.setModifierExt(QPosLineselect.ModifierExt);
         PosLineBean.setDiscountID(QPosLineselect.DiscountID);
         PosLineBean.setDiscountDescription(QPosLineselect.DiscountDescription);
         PosLineBean.setDiscountRate(QPosLineselect.DiscountRate);
         PosLineBean.setDiscountUnit(QPosLineselect.DiscountUnit);
         PosLineBean.setDiscountExt(QPosLineselect.DiscountExt);
         PosLineBean.setExtaxUnit(QPosLineselect.ExtaxUnit);
         PosLineBean.setDiscountEntryType(QPosLineselect.DiscountEntryType);
         PosLineBean.setDiscountMaxLimit(QPosLineselect.DiscountMaxLimit);
         PosLineBean.setDiscountType(QPosLineselect.DiscountType);
         PosLineBean.setExtaxExt(QPosLineselect.ExtaxExt);
         PosLineBean.setTaxID(QPosLineselect.TaxID);
         PosLineBean.setTaxRate(QPosLineselect.TaxRate);
         PosLineBean.setTaxUnit(QPosLineselect.TaxUnit);
         PosLineBean.setTaxExt(QPosLineselect.TaxExt);
         PosLineBean.setSaleUnit(QPosLineselect.SaleUnit);
         PosLineBean.setSaleExt(QPosLineselect.SaleExt);
         PosLineBean.setVoidExt(QPosLineselect.VoidExt);
         PosLineBean.setSpecialID(QPosLineselect.SpecialID);
         PosLineBean.setPriceSource(QPosLineselect.PriceSource);
         PosLineBean.setMixMatchExt(QPosLineselect.MixMatchExt);
         PosLineBean.setSubTotalDiscountUnit(QPosLineselect.SubTotalDiscountUnit);
         PosLineBean.setSubTotalDiscountExt(QPosLineselect.SubTotalDiscountExt);
         PosLineBean.setSubTotalSurchargeUnit(QPosLineselect.SubTotalSurchargeUnit);
         PosLineBean.setSubTotalSurchargeExt(QPosLineselect.SubTotalSurchargeExt);
         PosLineBean.setMixMatchUnit(QPosLineselect.MixMatchUnit);
         PosLineBean.setMixMatchID(QPosLineselect.MixMatchID);
         PosLineBean.setMixMatchDescription(QPosLineselect.MixMatchDescription);
         PosLineBean.setMixMatchGiveAwayItem(QPosLineselect.MixMatchGiveAwayItem);
         PosLineBean.setMixMatchTriggerType(QPosLineselect.MixMatchTriggerType);
         PosLineBean.setMixMatchTriggerValue(QPosLineselect.MixMatchTriggerValue);
         PosLineBean.setMixMatchGiveAwayType(QPosLineselect.MixMatchGiveAwayType);
         PosLineBean.setMixMatchGiveAwayValue(QPosLineselect.MixMatchGiveAwayValue);
         PosLineBean.setMixMatchResetTrigger(QPosLineselect.MixMatchResetTrigger);
         
		</cfscript>
	</cfif>
	<cfreturn PosLineBean />
</cffunction>
		

<cffunction name="GetAllPosLineBeans" access="public" output="false" returntype="query" hint="Returns a query of all PosLineBeans in our Database">
<cfset var QgetallPosLineBeans = 0 />
	<cfquery name="QgetallPosLineBeans" datasource="#variables.dsn#">
		SELECT PosTXID, PosLineID, ProductID, Description, WalletID, SeatID, ProductCode, ProductType, WalletStatus, DepartmentID, KitchenType, KitchenPrinted, KitchenPrint, ModifierType, ModifierID, Quantity, QuantityVoid, CostIncludeTax, CostUnit, CostExt, SellIncludeTax, SellUnit, SellExt, ModifierUnit, ModifierExt, DiscountID, DiscountDescription, DiscountRate, DiscountUnit, DiscountExt, ExtaxUnit, DiscountEntryType, DiscountMaxLimit, DiscountType, ExtaxExt, TaxID, TaxRate, TaxUnit, TaxExt, SaleUnit, SaleExt, VoidExt, SpecialID, PriceSource, MixMatchExt, SubTotalDiscountUnit, SubTotalDiscountExt, SubTotalSurchargeUnit, SubTotalSurchargeExt, MixMatchUnit, MixMatchID, MixMatchDescription, MixMatchGiveAwayItem, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger
		FROM PosLine 
		ORDER BY PosLineID
	</cfquery>
	<cfreturn QgetallPosLineBeans />
</cffunction>


<!-----[  Private 'helper' methods called by other methods only.  ]----->

<cffunction name="create"  access="private" returntype="PosLineBean" output="false" hint="DAO method">
<cfargument name="argsPosLineBean" type="PosLineBean" required="yes" displayname="create" />
	<cfset var qPosLineBeanInsert = 0 />
	<cfset var PosLineBean = arguments.argsPosLineBean />
	
	<cfquery name="qPosLineBeanInsert" datasource="#variables.dsn#" debug="yes" result="SQLOutput"  >
		SET NOCOUNT ON
		INSERT into PosLine
		( PosTXID, PosLineID, ProductID, Description, WalletID, SeatID, ProductCode, ProductType, WalletStatus, DepartmentID, KitchenType, KitchenPrinted, KitchenPrint, ModifierType, ModifierID, Quantity, QuantityVoid, CostIncludeTax, CostUnit, CostExt, SellIncludeTax, SellUnit, SellExt, ModifierUnit, ModifierExt, DiscountID, DiscountDescription, DiscountRate, DiscountUnit, DiscountExt, ExtaxUnit, DiscountEntryType, DiscountMaxLimit, DiscountType, ExtaxExt, TaxID, TaxRate, TaxUnit, TaxExt, SaleUnit, SaleExt, VoidExt, SpecialID, PriceSource, MixMatchExt, SubTotalDiscountUnit, SubTotalDiscountExt, SubTotalSurchargeUnit, SubTotalSurchargeExt, MixMatchUnit, MixMatchID, MixMatchDescription, MixMatchGiveAwayItem, MixMatchTriggerType, MixMatchTriggerValue, MixMatchGiveAwayType, MixMatchGiveAwayValue, MixMatchResetTrigger ) VALUES
		(

		<cfqueryparam value="#PosLineBean.getpostxid()#" cfsqltype="CF_SQL_INTEGER" />,
        <cfqueryparam value="#PosLineBean.getposlineid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getproductid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosLineBean.getwalletid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getseatid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getproductcode()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosLineBean.getproducttype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosLineBean.getwalletstatus()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getdepartmentid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getkitchentype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosLineBean.getkitchenprinted()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosLineBean.getkitchenprint()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosLineBean.getmodifiertype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosLineBean.getmodifierid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getquantity()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getquantityvoid()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getcostincludetax()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosLineBean.getcostunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getcostext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsellincludetax()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosLineBean.getsellunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsellext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmodifierunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmodifierext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getdiscountid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getdiscountdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosLineBean.getdiscountrate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getdiscountunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getdiscountext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getextaxunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getdiscountentrytype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getdiscountmaxlimit()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getdiscounttype()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getextaxext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.gettaxid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.gettaxrate()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.gettaxunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.gettaxext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsaleunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsaleext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getvoidext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getspecialid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getpricesource()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getmixmatchext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsubtotaldiscountunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsubtotaldiscountext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsubtotalsurchargeunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getsubtotalsurchargeext()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchunit()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchid()#" cfsqltype="CF_SQL_INTEGER" />,
		<cfqueryparam value="#PosLineBean.getmixmatchdescription()#" cfsqltype="CF_SQL_VARCHAR" />,
		<cfqueryparam value="#PosLineBean.getmixmatchgiveawayitem()#" cfsqltype="CF_SQL_BIT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchtriggertype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchtriggervalue()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchgiveawaytype()#" cfsqltype="CF_SQL_TINYINT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchgiveawayvalue()#" cfsqltype="CF_SQL_FLOAT" />,
		<cfqueryparam value="#PosLineBean.getmixmatchresettrigger()#" cfsqltype="CF_SQL_BIT" />
		   ) 
		SELECT Ident_Current('PosLine') as PosLineID
		SET NOCOUNT OFF
	</cfquery>
	<!---[   
	<cfset PosLineBean.setPosLineID(qPosLineBeanInsert.PosLineID)>   
	]---->
	<cfreturn PosLineBean />
</cffunction>

<cffunction name="update" access="private" returntype="PosLineBean" output="false" hint="DAO method">
<cfargument name="argsPosLineBean" type="PosLineBean" required="yes" />
	<cfset var PosLineBean = arguments.argsPosLineBean />
	<cfset var PosLineBeanUpdate = 0 >
	<cfquery name="PosLineBeanUpdate" datasource="#variables.dsn#" >
		UPDATE PosLine SET
postxid  = <cfqueryparam value="#PosLineBean.getPosTXID()#" cfsqltype="CF_SQL_VARCHAR"/>,
productid  = <cfqueryparam value="#PosLineBean.getProductID()#" cfsqltype="CF_SQL_INTEGER"/>,
description  = <cfqueryparam value="#PosLineBean.getDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
walletid  = <cfqueryparam value="#PosLineBean.getWalletID()#" cfsqltype="CF_SQL_INTEGER"/>,
seatid  = <cfqueryparam value="#PosLineBean.getSeatID()#" cfsqltype="CF_SQL_INTEGER"/>,
productcode  = <cfqueryparam value="#PosLineBean.getProductCode()#" cfsqltype="CF_SQL_VARCHAR"/>,
producttype  = <cfqueryparam value="#PosLineBean.getProductType()#" cfsqltype="CF_SQL_TINYINT"/>,
walletstatus  = <cfqueryparam value="#PosLineBean.getWalletStatus()#" cfsqltype="CF_SQL_INTEGER"/>,
departmentid  = <cfqueryparam value="#PosLineBean.getDepartmentID()#" cfsqltype="CF_SQL_INTEGER"/>,
kitchentype  = <cfqueryparam value="#PosLineBean.getKitchenType()#" cfsqltype="CF_SQL_TINYINT"/>,
kitchenprinted  = <cfqueryparam value="#PosLineBean.getKitchenPrinted()#" cfsqltype="CF_SQL_BIT"/>,
kitchenprint  = <cfqueryparam value="#PosLineBean.getKitchenPrint()#" cfsqltype="CF_SQL_VARCHAR"/>,
modifiertype  = <cfqueryparam value="#PosLineBean.getModifierType()#" cfsqltype="CF_SQL_TINYINT"/>,
modifierid  = <cfqueryparam value="#PosLineBean.getModifierID()#" cfsqltype="CF_SQL_INTEGER"/>,
quantity  = <cfqueryparam value="#PosLineBean.getQuantity()#" cfsqltype="CF_SQL_FLOAT"/>,
quantityvoid  = <cfqueryparam value="#PosLineBean.getQuantityVoid()#" cfsqltype="CF_SQL_FLOAT"/>,
costincludetax  = <cfqueryparam value="#PosLineBean.getCostIncludeTax()#" cfsqltype="CF_SQL_BIT"/>,
costunit  = <cfqueryparam value="#PosLineBean.getCostUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
costext  = <cfqueryparam value="#PosLineBean.getCostExt()#" cfsqltype="CF_SQL_FLOAT"/>,
sellincludetax  = <cfqueryparam value="#PosLineBean.getSellIncludeTax()#" cfsqltype="CF_SQL_BIT"/>,
sellunit  = <cfqueryparam value="#PosLineBean.getSellUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
sellext  = <cfqueryparam value="#PosLineBean.getSellExt()#" cfsqltype="CF_SQL_FLOAT"/>,
modifierunit  = <cfqueryparam value="#PosLineBean.getModifierUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
modifierext  = <cfqueryparam value="#PosLineBean.getModifierExt()#" cfsqltype="CF_SQL_FLOAT"/>,
discountid  = <cfqueryparam value="#PosLineBean.getDiscountID()#" cfsqltype="CF_SQL_INTEGER"/>,
discountdescription  = <cfqueryparam value="#PosLineBean.getDiscountDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
discountrate  = <cfqueryparam value="#PosLineBean.getDiscountRate()#" cfsqltype="CF_SQL_FLOAT"/>,
discountunit  = <cfqueryparam value="#PosLineBean.getDiscountUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
discountext  = <cfqueryparam value="#PosLineBean.getDiscountExt()#" cfsqltype="CF_SQL_FLOAT"/>,
extaxunit  = <cfqueryparam value="#PosLineBean.getExtaxUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
discountentrytype  = <cfqueryparam value="#PosLineBean.getDiscountEntryType()#" cfsqltype="CF_SQL_INTEGER"/>,
discountmaxlimit  = <cfqueryparam value="#PosLineBean.getDiscountMaxLimit()#" cfsqltype="CF_SQL_INTEGER"/>,
discounttype  = <cfqueryparam value="#PosLineBean.getDiscountType()#" cfsqltype="CF_SQL_INTEGER"/>,
extaxext  = <cfqueryparam value="#PosLineBean.getExtaxExt()#" cfsqltype="CF_SQL_FLOAT"/>,
taxid  = <cfqueryparam value="#PosLineBean.getTaxID()#" cfsqltype="CF_SQL_INTEGER"/>,
taxrate  = <cfqueryparam value="#PosLineBean.getTaxRate()#" cfsqltype="CF_SQL_FLOAT"/>,
taxunit  = <cfqueryparam value="#PosLineBean.getTaxUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
taxext  = <cfqueryparam value="#PosLineBean.getTaxExt()#" cfsqltype="CF_SQL_FLOAT"/>,
saleunit  = <cfqueryparam value="#PosLineBean.getSaleUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
saleext  = <cfqueryparam value="#PosLineBean.getSaleExt()#" cfsqltype="CF_SQL_FLOAT"/>,
voidext  = <cfqueryparam value="#PosLineBean.getVoidExt()#" cfsqltype="CF_SQL_FLOAT"/>,
specialid  = <cfqueryparam value="#PosLineBean.getSpecialID()#" cfsqltype="CF_SQL_INTEGER"/>,
pricesource  = <cfqueryparam value="#PosLineBean.getPriceSource()#" cfsqltype="CF_SQL_INTEGER"/>,
mixmatchext  = <cfqueryparam value="#PosLineBean.getMixMatchExt()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotaldiscountunit  = <cfqueryparam value="#PosLineBean.getSubTotalDiscountUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotaldiscountext  = <cfqueryparam value="#PosLineBean.getSubTotalDiscountExt()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotalsurchargeunit  = <cfqueryparam value="#PosLineBean.getSubTotalSurchargeUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
subtotalsurchargeext  = <cfqueryparam value="#PosLineBean.getSubTotalSurchargeExt()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchunit  = <cfqueryparam value="#PosLineBean.getMixMatchUnit()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchid  = <cfqueryparam value="#PosLineBean.getMixMatchID()#" cfsqltype="CF_SQL_INTEGER"/>,
mixmatchdescription  = <cfqueryparam value="#PosLineBean.getMixMatchDescription()#" cfsqltype="CF_SQL_VARCHAR"/>,
mixmatchgiveawayitem  = <cfqueryparam value="#PosLineBean.getMixMatchGiveAwayItem()#" cfsqltype="CF_SQL_BIT"/>,
mixmatchtriggertype  = <cfqueryparam value="#PosLineBean.getMixMatchTriggerType()#" cfsqltype="CF_SQL_TINYINT"/>,
mixmatchtriggervalue  = <cfqueryparam value="#PosLineBean.getMixMatchTriggerValue()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchgiveawaytype  = <cfqueryparam value="#PosLineBean.getMixMatchGiveAwayType()#" cfsqltype="CF_SQL_TINYINT"/>,
mixmatchgiveawayvalue  = <cfqueryparam value="#PosLineBean.getMixMatchGiveAwayValue()#" cfsqltype="CF_SQL_FLOAT"/>,
mixmatchresettrigger  = <cfqueryparam value="#PosLineBean.getMixMatchResetTrigger()#" cfsqltype="CF_SQL_BIT"/>
						
		WHERE 
		PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#"   cfsqltype="CF_SQL_INTEGER" />
	</cfquery>
	
	<cfreturn PosLineBean />
</cffunction>

<!---[   
=========================================================================================================
Update status methods - recording progress of the transaction through the system.
=========================================================================================================
   ]---->

<cffunction name="setStockMasterPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the StockMaster subroutines.">
    <cfargument name="argsPosLineBean" required="yes" type="any" />
    <cfset var PosLineBean = arguments.argsPosLineBean />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE posline SET StockMasterPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosLineBean.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#" cfsqltype="cf_sql_integer" /> 
    </cfquery>
</cffunction> 

<cffunction name="setStockLocationPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the StockLocation subroutines.">
    <cfargument name="argsPosLineBean" required="yes" type="any" />
    <cfset var PosLineBean = arguments.argsPosLineBean />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE posline SET StockLocationPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosLineBean.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#" cfsqltype="cf_sql_integer" /> 
    </cfquery>
</cffunction> 

<cffunction name="setStockLevelsPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the StockLevels subroutines.">
    <cfargument name="argsPosLineBean" required="yes" type="any" />
    <cfset var PosLineBean = arguments.argsPosLineBean />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE posline SET StockLevelsPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosLineBean.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#" cfsqltype="cf_sql_integer" /> 
    </cfquery>
</cffunction> 

<cffunction name="setPLUTotalsPostedFlag" access="public" output="no" returntype="void" hint="Sets a flag to indicate successful process of the PLUTotals subroutines.">
    <cfargument name="argsPosLineBean" required="yes" type="any" />
    <cfset var PosLineBean = arguments.argsPosLineBean />
    <cfquery name="qUpdateFlag" datasource="#variables.dsn#">
        UPDATE posline SET PLUTotalsPosted = <cfqueryparam value="true" cfsqltype="cf_sql_bit" />
        WHERE
        PosTXID = <cfqueryparam value="#PosLineBean.getPosTXID()#" cfsqltype="cf_sql_integer" /> AND
        PosLineID = <cfqueryparam value="#PosLineBean.getPosLineID()#" cfsqltype="cf_sql_integer" /> 
    </cfquery>
</cffunction> 

</cfcomponent>