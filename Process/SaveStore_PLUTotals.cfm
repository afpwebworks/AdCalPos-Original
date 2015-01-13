<cfsilent>
<!----
==========================================================================================================
Filename:     SaveStore_PLUTotals.cfm
Description:  Manipulates data to add to the daily store totals, and persists them to the database.
Date:         12/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
09/6/2010  Les: Please add the check into the processing into tblStore_PLUTotals to only include PosType = 1 or 3. 

==========================================================================================================
--->
<cfset StorePLUTotalsDAO =   application.beanfactory.getBean("StorePLUTotalsDAO") />
<cfset PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />

<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
<cfset PLUTotalsNoError = true />
<!---[   Only run this page if PosTYpe is 1 or 3   ]---->
<cfif (posbean.getPostype() eq "1") OR (posbean.getPostype() eq "3")>

<cftry> 
<cfset PLUTotal  =   application.beanfactory.getBean("PLUTotal") />



 <!---[     transfer  values to the bean   ]---->
 <cfset PLUTotal.setstoreid( PosBean.getStoreID() ) />
 <cfset PLUTotal.setfilename("0") />
 <cfset PLUTotal.setlocation( PosBean.getStoreID() ) />
 <cfset PLUTotal.setscaleidcode(PosBean.getTerminalID() ) />
 <cfset PLUTotal.setplunumber(PosLineBean.getproductcode() ) />
 <cfif PosBean.getPosType() eq "1">
 		<cfset PLUTotal.settotald( PosLineBean.getSaleExt()  ) />
 <cfelse>
 		<cfset PLUTotal.settotald( PosLineBean.getSaleExt() * -1 ) />
 </cfif>
 <cfscript>
		 //Componentise the date.
		//thisyear   = Listlast(PosBean.getTransdate(), "/") ;
		//next two values swapped around because of the strange way coldfusion reads its own date objects
		//thismonth  = ListGetAt(PosBean.getTransdate(),"2","/") ;
		//thisday    = listfirst(PosBean.getTransdate(),"/") ;
		thisyear   =  year(PosBean.getTransdate());
		thismonth  =  month(PosBean.getTransdate());
		thisday    =  day(PosBean.getTransdate());
		thishour   = hour(PosBean.getTransdate()) ;
		thisminute = minute(PosBean.getTransdate()) ;
		thissecond = second(PosBean.getTransdate()) ;
		
		//create temporary objects for date and time
		thisdate   = createdate( thisyear, thismonth, thisday  ) ;
		thistime   = "#thishour#:#thisminute#:#thissecond#" ;
		PLUTotal.setDate(thisdate);
		PLUTotal.setTime(thistime);
 </cfscript>
 <cfset PLUTotal.setquantity(PosLineBean.getquantity() ) />
 <cfset PLUTotal.settotalkg( "0" ) />
 <cfset PLUTotal.setprepacktotald("0" ) />
 <cfset PLUTotal.setprepackquantity("0" ) />
 <cfset PLUTotal.setprepacktotalkg("0" ) />
 <cfset PLUTotal.setposted( false ) />
 <cfset PLUTotal.setcogs("0") />
      <cfset StorePLUTotalsDAO.save(  PLUTotal  ) />
    <cfcatch type="any">
        <cfset PLUTotalsNoError = false />
    </cfcatch>
</cftry>  

<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif PLUTotalsNoError is true >
		<cfset PosLinesDAO.setPLUTotalsPostedFlag( PosLineBean ) />
	</cfif>  
    
 </cfif>   
</cfsilent>
