<cfsilent>
<!----
==========================================================================================================
Filename:     CreatePosLineBean.cfm
Description:  Creates a PosLineBean.cfc populated with the current sale record.  Separated out to enable reuse elsewhere in the transaction processing.
Date:         5/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

 <!---[      Create the struct containing the values   ]---->
       <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
			Session.Transaction.Line.PosTXID = session.PosTXID;
			fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
			value=mydoc.tables.table[t].fields.field[i].xmltext;
			session.Transaction.Line[fieldname]=value;		
        </cfscript>  
      </cfloop>    

  <cfscript>
	//transfer Session.Transaction.Line values to the bean
	 if (StructKeyExists(Session.Transaction.Line, "poslineid")) PosLineBean.setposlineid(Session.Transaction.Line.poslineid);
     if (StructKeyExists(Session.Transaction.Line, "productid")) PosLineBean.setproductid(trim(Session.Transaction.Line.productid));
     if (StructKeyExists(Session.Transaction.Line, "description")) PosLineBean.setdescription(trim(Session.Transaction.Line.description));
     if (StructKeyExists(Session.Transaction.Line, "walletid")) PosLineBean.setwalletid(trim(Session.Transaction.Line.walletid));
	 if (StructKeyExists(Session.Transaction.Line, "seatid")) PosLineBean.setseatid(trim(Session.Transaction.Line.seatid));
     if (StructKeyExists(Session.Transaction.Line, "productcode")) PosLineBean.setproductcode(trim(Session.Transaction.Line.productcode));
     if (StructKeyExists(Session.Transaction.Line, "producttype")) PosLineBean.setproducttype(trim(Session.Transaction.Line.producttype));
     if (StructKeyExists(Session.Transaction.Line, "walletstatus")) PosLineBean.setwalletstatus(trim(Session.Transaction.Line.walletstatus));
     if (StructKeyExists(Session.Transaction.Line, "departmentid")) PosLineBean.setdepartmentid(trim(Session.Transaction.Line.departmentid));
     if (StructKeyExists(Session.Transaction.Line, "kitchentype")) PosLineBean.setkitchentype(trim(Session.Transaction.Line.kitchentype));
     if (StructKeyExists(Session.Transaction.Line, "kitchenprinted")) PosLineBean.setkitchenprinted(trim(Session.Transaction.Line.kitchenprinted));
     if (StructKeyExists(Session.Transaction.Line, "kitchenprint")) PosLineBean.setkitchenprint(trim(Session.Transaction.Line.kitchenprint));
     if (StructKeyExists(Session.Transaction.Line, "modifiertype")) PosLineBean.setmodifiertype(trim(Session.Transaction.Line.modifiertype));
     if (StructKeyExists(Session.Transaction.Line, "modifierid")) PosLineBean.setmodifierid(trim(Session.Transaction.Line.modifierid));
     if (StructKeyExists(Session.Transaction.Line, "quantity")) PosLineBean.setquantity(trim(Session.Transaction.Line.quantity));
     if (StructKeyExists(Session.Transaction.Line, "quantityvoid")) PosLineBean.setquantityvoid(trim(Session.Transaction.Line.quantityvoid));
     if (StructKeyExists(Session.Transaction.Line, "costincludetax")) PosLineBean.setcostincludetax(trim(Session.Transaction.Line.costincludetax));
     if (StructKeyExists(Session.Transaction.Line, "costunit")) PosLineBean.setcostunit(trim(Session.Transaction.Line.costunit));
     if (StructKeyExists(Session.Transaction.Line, "costext")) PosLineBean.setcostext(trim(Session.Transaction.Line.costext));
     if (StructKeyExists(Session.Transaction.Line, "sellincludetax")) PosLineBean.setsellincludetax(trim(Session.Transaction.Line.sellincludetax));
     if (StructKeyExists(Session.Transaction.Line, "sellunit")) PosLineBean.setsellunit(trim(Session.Transaction.Line.sellunit));
     if (StructKeyExists(Session.Transaction.Line, "sellext")) PosLineBean.setsellext(trim(Session.Transaction.Line.sellext));
     if (StructKeyExists(Session.Transaction.Line, "modifierunit")) PosLineBean.setmodifierunit(trim(Session.Transaction.Line.modifierunit));	
     if (StructKeyExists(Session.Transaction.Line, "modifierext")) PosLineBean.setmodifierext(trim(Session.Transaction.Line.modifierext));
     if (StructKeyExists(Session.Transaction.Line, "discountid")) PosLineBean.setdiscountid(trim(Session.Transaction.Line.discountid));
     if (StructKeyExists(Session.Transaction.Line, "discountdescription")) PosLineBean.setdiscountdescription(trim(Session.Transaction.Line.discountdescription));
     if (StructKeyExists(Session.Transaction.Line, "discountrate")) PosLineBean.setdiscountrate(trim(Session.Transaction.Line.discountrate));
     if (StructKeyExists(Session.Transaction.Line, "discountunit")) PosLineBean.setdiscountunit(trim(Session.Transaction.Line.discountunit));
     if (StructKeyExists(Session.Transaction.Line, "discountext")) PosLineBean.setdiscountext(trim(Session.Transaction.Line.discountext));
     if (StructKeyExists(Session.Transaction.Line, "extaxunit")) PosLineBean.setextaxunit(trim(Session.Transaction.Line.extaxunit));
     if (StructKeyExists(Session.Transaction.Line, "discountentrytype")) PosLineBean.setdiscountentrytype(trim(Session.Transaction.Line.discountentrytype));
     if (StructKeyExists(Session.Transaction.Line, "discountmaxlimit")) PosLineBean.setdiscountmaxlimit(trim(Session.Transaction.Line.discountmaxlimit));
     if (StructKeyExists(Session.Transaction.Line, "discounttype")) PosLineBean.setdiscounttype(trim(Session.Transaction.Line.discounttype));
     if (StructKeyExists(Session.Transaction.Line, "extaxext")) PosLineBean.setextaxext(trim(Session.Transaction.Line.extaxext));
     if (StructKeyExists(Session.Transaction.Line, "taxid")) PosLineBean.settaxid(trim(Session.Transaction.Line.taxid));
     if (StructKeyExists(Session.Transaction.Line, "taxrate")) PosLineBean.settaxrate(trim(Session.Transaction.Line.taxrate));
     if (StructKeyExists(Session.Transaction.Line, "taxunit")) PosLineBean.settaxunit(trim(Session.Transaction.Line.taxunit));
     if (StructKeyExists(Session.Transaction.Line, "taxext")) PosLineBean.settaxext(trim(Session.Transaction.Line.taxext));
	 if (StructKeyExists(Session.Transaction.Line, "saleunit")) PosLineBean.setsaleunit(trim(Session.Transaction.Line.saleunit));
     if (StructKeyExists(Session.Transaction.Line, "saleext")) PosLineBean.setsaleext(trim(Session.Transaction.Line.saleext));
     if (StructKeyExists(Session.Transaction.Line, "voidext")) PosLineBean.setvoidext(trim(Session.Transaction.Line.voidext));
     if (StructKeyExists(Session.Transaction.Line, "specialid")) PosLineBean.setspecialid(trim(Session.Transaction.Line.specialid));
     if (StructKeyExists(Session.Transaction.Line, "pricesource")) PosLineBean.setpricesource(trim(Session.Transaction.Line.pricesource));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchext")) PosLineBean.setmixmatchext(trim(Session.Transaction.Line.mixmatchext));
     if (StructKeyExists(Session.Transaction.Line, "subtotaldiscountunit")) PosLineBean.setsubtotaldiscountunit(trim(Session.Transaction.Line.subtotaldiscountunit));
     if (StructKeyExists(Session.Transaction.Line, "subtotaldiscountext")) PosLineBean.setsubtotaldiscountext(trim(Session.Transaction.Line.subtotaldiscountext));
     if (StructKeyExists(Session.Transaction.Line, "subtotalsurchargeunit")) PosLineBean.setsubtotalsurchargeunit(trim(Session.Transaction.Line.subtotalsurchargeunit));
     if (StructKeyExists(Session.Transaction.Line, "subtotalsurchargeext")) PosLineBean.setsubtotalsurchargeext(trim(Session.Transaction.Line.subtotalsurchargeext));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchunit")) PosLineBean.setmixmatchunit(trim(Session.Transaction.Line.mixmatchunit));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchid")) PosLineBean.setmixmatchid(trim(Session.Transaction.Line.mixmatchid));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchdescription")) PosLineBean.setmixmatchdescription(trim(Session.Transaction.Line.mixmatchdescription));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchgiveawayitem")) PosLineBean.setmixmatchgiveawayitem(trim(Session.Transaction.Line.mixmatchgiveawayitem));
	 if (StructKeyExists(Session.Transaction.Line, "mixmatchtriggertype")) PosLineBean.setmixmatchtriggertype(trim(Session.Transaction.Line.mixmatchtriggertype));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchtriggervalue")) PosLineBean.setmixmatchtriggervalue(trim(Session.Transaction.Line.mixmatchtriggervalue));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchgiveawaytype")) PosLineBean.setmixmatchgiveawaytype(trim(Session.Transaction.Line.mixmatchgiveawaytype));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchgiveawayvalue")) PosLineBean.setmixmatchgiveawayvalue(trim(Session.Transaction.Line.mixmatchgiveawayvalue));
     if (StructKeyExists(Session.Transaction.Line, "mixmatchresettrigger")) PosLineBean.setmixmatchresettrigger(trim(Session.Transaction.Line.mixmatchresettrigger));
	 
</cfscript> 

</cfsilent>
