<cfsilent>
<!----
==========================================================================================================
Filename:     SavePosBean.cfm
Description:  Saves the values of a struct called "Struct" to the POSBEan,  the persists the values 
Date:         6/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfif NOT structKeyExists(session, "errorhandler")>
<cfset session.errorhandler = application.beanfactory.getBean("ErrorHandler") />
</cfif>
<cfset PosDAO =   application.beanfactory.getBean("PosDAO") />
    <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
        fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
        value=mydoc.tables.table[t].fields.field[i].xmltext;
        struct[fieldname]=value;		
        </cfscript>    
    </cfloop>
        
  <cfscript>
	//transfer struct values to the bean
		if (structKeyExists(struct, "PosID")) PosBean.setposid(trim(struct.posid));
		if (structKeyExists(struct, "postype"))  PosBean.setpostype(trim(struct.postype));
		if (structKeyExists(struct, "posstatus"))  PosBean.setposstatus(trim(struct.posstatus));
		if (structKeyExists(struct, "poscode")) PosBean.setposcode(trim(struct.poscode));
		if (structKeyExists(struct, "storeid"))  PosBean.setstoreid(trim(struct.storeid));
		if (structKeyExists(struct, "terminalid"))  PosBean.setterminalid(trim(struct.terminalid));
		if (structKeyExists(struct, "locationid"))  PosBean.setlocationid(trim(struct.locationid));
		if (structKeyExists(struct, "tableid"))  PosBean.settableid(trim(struct.tableid));
		if (structKeyExists(struct, "priceid"))  PosBean.setpriceid(trim(struct.priceid));
		if (structKeyExists(struct, "clerkid"))  PosBean.setclerkid(trim(struct.clerkid));
		if (structKeyExists(struct, "drawerid"))  PosBean.setdrawerid(trim(struct.drawerid));
		if (structKeyExists(struct, "memberid"))  PosBean.setmemberid(trim(struct.memberid));
		if (structKeyExists(struct, "membername"))  PosBean.setmembername(trim(struct.membername));
		if (structKeyExists(struct, "debtorid"))  PosBean.setdebtorid(trim(struct.debtorid));
		if (structKeyExists(struct, "debtorname"))  PosBean.setdebtorname(trim(struct.debtorname));
		if (structKeyExists(struct, "coverquantity"))  PosBean.setcoverquantity(trim(struct.coverquantity));
		if (structKeyExists(struct, "seatcount")) PosBean.setseatcount(trim(struct.seatcount));
		if (structKeyExists(struct, "walletcount")) PosBean.setwalletcount(trim(struct.walletcount));
		if (structKeyExists(struct, "costtotal")) PosBean.setcosttotal(trim(struct.costtotal));
		if (structKeyExists(struct, "discounttotal")) PosBean.setdiscounttotal(trim(struct.discounttotal));
		if (structKeyExists(struct, "linetaxtotal")) PosBean.setlinetaxtotal(trim(struct.linetaxtotal));
		if (structKeyExists(struct, "linesaletotal")) PosBean.setlinesaletotal(trim(struct.linesaletotal));
		if (structKeyExists(struct, "mediataxtotal")) PosBean.setmediataxtotal(trim(struct.mediataxtotal));
		if (structKeyExists(struct, "mediaroundtotal")) PosBean.setmediaroundtotal(trim(struct.mediaroundtotal));
		if (structKeyExists(struct, "mediachangetotal")) PosBean.setmediachangetotal(trim(struct.mediachangetotal));
		if (structKeyExists(struct, "mediatotal")) PosBean.setmediatotal(trim(struct.mediatotal));
		if (structKeyExists(struct, "duetotal")) PosBean.setduetotal(trim(struct.duetotal));
		if (structKeyExists(struct, "taxtotal")) PosBean.settaxtotal(trim(struct.taxtotal));
		if (structKeyExists(struct, "saletotal")) PosBean.setsaletotal(trim(struct.saletotal));
		if (structKeyExists(struct, "voidtotal")) PosBean.setvoidtotal(trim(struct.voidtotal));
		if (structKeyExists(struct, "timestamp")) PosBean.settimestamp(request.austime);
		if (structKeyExists(struct, "TimeStamp")) PosBean.setTransDate( struct.TimeStamp );
	    if (structKeyExists(struct, "itemdiscounttotal")) PosBean.setitemdiscounttotal(trim(struct.itemdiscounttotal));
		if (structKeyExists(struct, "itemsurchargetotal")) PosBean.setitemsurchargetotal(trim(struct.itemsurchargetotal));
		if (structKeyExists(struct, "subtotaldiscount")) PosBean.setsubtotaldiscount(trim(struct.subtotaldiscount));
		if (structKeyExists(struct, "subtotaldiscountid")) PosBean.setsubtotaldiscountid(trim(struct.subtotaldiscountid));
		if (structKeyExists(struct, "subtotaldiscountdescription")) PosBean.setsubtotaldiscountdescription(trim(struct.subtotaldiscountdescription));

         if (structKeyExists(struct, "subtotaldiscountrate")) PosBean.setsubtotaldiscountrate(trim(struct.subtotaldiscountrate));
		if (structKeyExists(struct, "subtotaldiscountentrytype")) PosBean.setsubtotaldiscountentrytype(trim(struct.subtotaldiscountentrytype));
		if (structKeyExists(struct, "subtotalsurcharge")) PosBean.setsubtotalsurcharge(trim(struct.subtotalsurcharge));
		if (structKeyExists(struct, "subtotalsurchargeid")) PosBean.setsubtotalsurchargeid(trim(struct.subtotalsurchargeid));
		if (structKeyExists(struct, "subtotalsurchargedescription")) PosBean.setsubtotalsurchargedescription(trim(struct.subtotalsurchargedescription));
		if (structKeyExists(struct, "subtotalsurchargerate")) PosBean.setsubtotalsurchargerate(trim(struct.subtotalsurchargerate));
		if (structKeyExists(struct, "subtotalsurchargeentrytype")) PosBean.setsubtotalsurchargeentrytype(trim(struct.subtotalsurchargeentrytype));
		if (structKeyExists(struct, "tips")) PosBean.settips(trim(struct.tips));
	</cfscript> 
    <cfset PosBean.validate(session.errorhandler) /> 
	<cfif NOT(session.errorhandler.haserrors())>
 		<cfset PosDAO.save(PosBean) />
   	</cfif>
</cfsilent> 