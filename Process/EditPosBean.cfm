<cfsilent>
<!----
==========================================================================================================
Filename:    EditPosBean.cfm
Description: Page for handling the edit and add of data for PosBean data.  Requires Coldspring 1.0
Date:        4/Apr/2010
Author:      Michael Kear

Revision history: 

==========================================================================================================
--->

<!----[  Initialise the form for adds:  ]----->
  <cfset PosBean = application.beanfactory.getBean("PosBean") />
  <cfset PosDAO =   application.beanfactory.getBean("PosDAO") />

<cfif isdefined("url.PosTXID")>
   <cfset PosBean.setPosTXID(PosTXID) />
   <cfset PosDAO.read(PosBean) />
</cfif>


<!----[  Process the form if it is submitted:  ]----->
<cfif isdefined("form.submit")>
	<cfset errorhandler = application.beanfactory.getBean("ErrorHandler") />
   <cfscript>
     //transfer form values to the bean
     PosBean.setposid(trim(form.posid));
     PosBean.setpostype(trim(form.postype));
     PosBean.setposstatus(trim(form.posstatus));
     PosBean.setposcode(trim(form.poscode));
     PosBean.setstoreid(trim(form.storeid));
     PosBean.setterminalid(trim(form.terminalid));
     PosBean.setlocationid(trim(form.locationid));
     PosBean.settableid(trim(form.tableid));
     PosBean.setpriceid(trim(form.priceid));
     PosBean.setclerkid(trim(form.clerkid));
     PosBean.setdrawerid(trim(form.drawerid));
     PosBean.setmemberid(trim(form.memberid));
     PosBean.setmembername(trim(form.membername));
     PosBean.setdebtorid(trim(form.debtorid));
     PosBean.setdebtorname(trim(form.debtorname));
     PosBean.setcoverquantity(trim(form.coverquantity));
     PosBean.setseatcount(trim(form.seatcount));
     PosBean.setwalletcount(trim(form.walletcount));
     PosBean.setcosttotal(trim(form.costtotal));
     PosBean.setdiscounttotal(trim(form.discounttotal));
     PosBean.setlinetaxtotal(trim(form.linetaxtotal));
     PosBean.setlinesaletotal(trim(form.linesaletotal));
     PosBean.setmediataxtotal(trim(form.mediataxtotal));
     PosBean.setmediaroundtotal(trim(form.mediaroundtotal));
     PosBean.setmediachangetotal(trim(form.mediachangetotal));
     PosBean.setmediatotal(trim(form.mediatotal));
     PosBean.setduetotal(trim(form.duetotal));
     PosBean.settaxtotal(trim(form.taxtotal));
     PosBean.setsaletotal(trim(form.saletotal));
     PosBean.setvoidtotal(trim(form.voidtotal));
     PosBean.settimestamp(trim(form.timestamp));
     PosBean.setitemdiscounttotal(trim(form.itemdiscounttotal));
     PosBean.setitemsurchargetotal(trim(form.itemsurchargetotal));
     PosBean.setsubtotaldiscount(trim(form.subtotaldiscount));
     PosBean.setsubtotaldiscountid(trim(form.subtotaldiscountid));
     PosBean.setsubtotaldiscountdescription(trim(form.subtotaldiscountdescription));
     PosBean.setsubtotaldiscountrate(trim(form.subtotaldiscountrate));
     PosBean.setsubtotaldiscountentrytype(trim(form.subtotaldiscountentrytype));
     PosBean.setsubtotalsurcharge(trim(form.subtotalsurcharge));
     PosBean.setsubtotalsurchargeid(trim(form.subtotalsurchargeid));
     PosBean.setsubtotalsurchargedescription(trim(form.subtotalsurchargedescription));
     PosBean.setsubtotalsurchargerate(trim(form.subtotalsurchargerate));
     PosBean.setsubtotalsurchargeentrytype(trim(form.subtotalsurchargeentrytype));
     PosBean.settips(trim(form.tips));
     
     
   </cfscript>
   <cfset PosBean.validate(errorhandler) />   
	<cfif NOT(errorhandler.haserrors())>
		<cfset PosDAO.save(PosBean) />
		<cflocation addtoken="no"  url="/SalesOrderReport.cfm" />
		<cfabort> 
	</cfif>
</cfif>	
</cfsilent>
<cfinclude template="/Includes/Content/header.cfm" />
<cfinclude template="/Includes/form_PosBean.cfm" />
<cfinclude template="/Includes/Content/footer.cfm" />