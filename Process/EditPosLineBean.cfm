<cfsilent>
<!----
==========================================================================================================
Filename:    EditPosLineBean.cfm
Description: Page for handling the edit and add of data for PosLineBean data.  Requires Coldspring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
 <cfset PosLineBean = application.beanfactory.getBean("PosLineBean") />
 <cfset PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />

<cfif isdefined("url.PosLineID")>
   <cfset PosLineBean.setPosLineID(PosLineID) />
   <cfset PosLinesDAO.read(PosLineBean) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
     PosLineBean.setpostxid(trim(form.postxid));
     PosLineBean.setproductid(trim(form.productid));
     PosLineBean.setdescription(trim(form.description));
     PosLineBean.setwalletid(trim(form.walletid));
     PosLineBean.setseatid(trim(form.seatid));
     PosLineBean.setproductcode(trim(form.productcode));
     PosLineBean.setproducttype(trim(form.producttype));
     PosLineBean.setwalletstatus(trim(form.walletstatus));
     PosLineBean.setdepartmentid(trim(form.departmentid));
     PosLineBean.setkitchentype(trim(form.kitchentype));
     PosLineBean.setkitchenprinted(trim(form.kitchenprinted));
     PosLineBean.setkitchenprint(trim(form.kitchenprint));
     PosLineBean.setmodifiertype(trim(form.modifiertype));
     PosLineBean.setmodifierid(trim(form.modifierid));
     PosLineBean.setquantity(trim(form.quantity));
     PosLineBean.setquantityvoid(trim(form.quantityvoid));
     PosLineBean.setcostincludetax(trim(form.costincludetax));
     PosLineBean.setcostunit(trim(form.costunit));
     PosLineBean.setcostext(trim(form.costext));
     PosLineBean.setsellincludetax(trim(form.sellincludetax));
     PosLineBean.setsellunit(trim(form.sellunit));
     PosLineBean.setsellext(trim(form.sellext));
     PosLineBean.setmodifierunit(trim(form.modifierunit));
     PosLineBean.setmodifierext(trim(form.modifierext));
     PosLineBean.setdiscountid(trim(form.discountid));
     PosLineBean.setdiscountdescription(trim(form.discountdescription));
     PosLineBean.setdiscountrate(trim(form.discountrate));
     PosLineBean.setdiscountunit(trim(form.discountunit));
     PosLineBean.setdiscountext(trim(form.discountext));
     PosLineBean.setextaxunit(trim(form.extaxunit));
     PosLineBean.setdiscountentrytype(trim(form.discountentrytype));
     PosLineBean.setdiscountmaxlimit(trim(form.discountmaxlimit));
     PosLineBean.setdiscounttype(trim(form.discounttype));
     PosLineBean.setextaxext(trim(form.extaxext));
     PosLineBean.settaxid(trim(form.taxid));
     PosLineBean.settaxrate(trim(form.taxrate));
     PosLineBean.settaxunit(trim(form.taxunit));
     PosLineBean.settaxext(trim(form.taxext));
     PosLineBean.setsaleunit(trim(form.saleunit));
     PosLineBean.setsaleext(trim(form.saleext));
     PosLineBean.setvoidext(trim(form.voidext));
     PosLineBean.setspecialid(trim(form.specialid));
     PosLineBean.setpricesource(trim(form.pricesource));
     PosLineBean.setmixmatchext(trim(form.mixmatchext));
     PosLineBean.setsubtotaldiscountunit(trim(form.subtotaldiscountunit));
     PosLineBean.setsubtotaldiscountext(trim(form.subtotaldiscountext));
     PosLineBean.setsubtotalsurchargeunit(trim(form.subtotalsurchargeunit));
     PosLineBean.setsubtotalsurchargeext(trim(form.subtotalsurchargeext));
     PosLineBean.setmixmatchunit(trim(form.mixmatchunit));
     PosLineBean.setmixmatchid(trim(form.mixmatchid));
     PosLineBean.setmixmatchdescription(trim(form.mixmatchdescription));

     PosLineBean.setmixmatchgiveawayitem(trim(form.mixmatchgiveawayitem));
     PosLineBean.setmixmatchtriggertype(trim(form.mixmatchtriggertype));
     PosLineBean.setmixmatchtriggervalue(trim(form.mixmatchtriggervalue));
     PosLineBean.setmixmatchgiveawaytype(trim(form.mixmatchgiveawaytype));
     PosLineBean.setmixmatchgiveawayvalue(trim(form.mixmatchgiveawayvalue));
     PosLineBean.setmixmatchresettrigger(trim(form.mixmatchresettrigger));
     
     
   </cfscript>
   <cfset PosLineBean.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset PosLinesDAO.save(PosLineBean) />
		<cflocation addtoken="no"  url="/SalesOrderReport.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/Content/header.cfm" />
<cfinclude template="/Includes/form_PosLineBean.cfm" />
<cfinclude template="/Includes/Content/footer.cfm" />