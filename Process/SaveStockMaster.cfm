<cfsilent>
<!----
==========================================================================================================
Filename:     SaveStockMaster.cfm
Description:  Processes the transaction to the tblStockMaster table
Date:         30/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

19/5/2010  Removed some unnecessary comments, and a CFDUMP no longer used. MK

==========================================================================================================
--->
<cfset StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />


<!---[   Only perform this whole page if the tblOptions requires it to happen.   ]---->
<cfif StockmasterDAO.IsUpdateRequired() >


<!---[      Create the struct containing the values   ]---->
       <cfloop from="1" to="#numitems#" index="i">
        <cfscript>
			session.Stockmaster.PosTXID = session.PosTXID;
			fieldname = #mydoc.tables.table[t].fields.field[i].xmlattributes.name# ;
			value=mydoc.tables.table[t].fields.field[i].xmltext;
			session.Stockmaster[fieldname]=value;		
        </cfscript>  
      </cfloop>  


<!---[   Get a stock master bean, initialised with the defaults   ]---->
<cfscript>
StockMaster = application.beanfactory.getBean("stockmaster") ;
stockmaster.setPartNo( PosLineBean.getProductCode()    ) ;
//if the stock item exists in the database already,  read it in
StockmasterDAO.read(  stockmaster );
</cfscript>

<cfif StockmasterDAO.recordexists( stockmaster ) >
      

	 <cfscript>
	 //transfer Session.Line values to the bean
	 Stockmaster.setdescription(Session.Stockmaster.description);
     Stockmaster.setsupplyunit(Session.Stockmaster.supplyunit);
     Stockmaster.setorderingunit(Session.Stockmaster.orderingunit);
     Stockmaster.setlabel(Session.Stockmaster.label);
     Stockmaster.setgroupno(Session.Stockmaster.groupno);
     Stockmaster.settcode(Session.Stockmaster.tcode);
     Stockmaster.setpcode(Session.Stockmaster.pcode);
     Stockmaster.setrcode(Session.Stockmaster.rcode);
     Stockmaster.settolerance(Session.Stockmaster.tolerance);
     Stockmaster.setcost(Session.Stockmaster.cost);
     Stockmaster.setwholesale(Session.Stockmaster.wholesale);
     Stockmaster.setmaxretail(Session.Stockmaster.maxretail);
     Stockmaster.setplutype(Session.Stockmaster.plutype);
     Stockmaster.setlockorderunittype(Session.Stockmaster.lockorderunittype);
     Stockmaster.setminorderqty(Session.Stockmaster.minorderqty);
     Stockmaster.setpicturefile(Session.Stockmaster.picturefile);
     Stockmaster.setnolongerused(Session.Stockmaster.nolongerused);
     Stockmaster.setsuppressorder(Session.Stockmaster.suppressorder);
     Stockmaster.setsuppressstocktake(Session.Stockmaster.suppressstocktake);
     Stockmaster.setdateentered(Session.Stockmaster.dateentered);
     Stockmaster.setid(Session.Stockmaster.id);
     Stockmaster.setpartnobuyingplu(Session.Stockmaster.partnobuyingplu);
     Stockmaster.setpartnosaleplu(Session.Stockmaster.partnosaleplu);
     Stockmaster.setratio(Session.Stockmaster.ratio);
     Stockmaster.setprepcode(Session.Stockmaster.prepcode);
     Stockmaster.setthreehrebate(Session.Stockmaster.threehrebate);
     Stockmaster.setscrebate(Session.Stockmaster.screbate);
     Stockmaster.setthreehrebateval(Session.Stockmaster.threehrebateval);
     Stockmaster.setscrebateval(Session.Stockmaster.screbateval);
     Stockmaster.setparentcost(Session.Stockmaster.parentcost);
     Stockmaster.settypeid(Session.Stockmaster.typeid);
	 Stockmaster.setProductID( poslinebean.getproductid()  );
    </cfscript>
</cfif>

</cfif>
</cfsilent>