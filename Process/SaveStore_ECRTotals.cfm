<cfsilent>
<!----
==========================================================================================================
Filename:     SaveStore_ECRTotals.cfm
Description:  Manipulates data to add to the daily store totals, and persists them to the database.
Date:         12/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

notes:   Requires PosBean and PosMediaBean to exist already and populated 

==========================================================================================================
--->
<cfset StoreECRTTotalsDAO =   application.beanfactory.getBean("StoreECRTTotalsDAO") />
<cfset PosDAO =   application.beanfactory.getBean("PosDAO") />
<cfset ECRTTotal  =   application.beanfactory.getBean("ECRTTotal") />

</cfsilent>
<cftry>
   <!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
   <cfset ECRTTotalNoError = true />

   <!---[     transfer  values to the bean   ]---->
     <cfset ECRTTotal.setstoreid( PosBean.getStoreID() ) />
     <cfset ECRTTotal.setfilename("0")/>
     <cfset ECRTTotal.setlocation( PosBean.getStoreID() )/>
     <cfset ECRTTotal.setscaleidcode(PosBean.getTerminalID())/>
     <cfscript>
		 //Componentise the date.
		thisyear   = datepart("yyyy",PosBean.getTransdate()) ;
		thismonth  = datepart("m",PosBean.getTransdate()) ;
		thisday    = datepart("d",PosBean.getTransdate()) ;
		thishour   = datepart("h",PosBean.getTransdate()) ;
		thisminute = datepart("n",PosBean.getTransdate()) ;
		thissecond = datepart("s",PosBean.getTransdate()) ;
		//create temporary objects for date and time
		thisdate   = createdate( thisyear, thismonth, thisday  ) ;
		thistime   = "#thishour#:#thisminute#:#thissecond#" ;
		ECRTTotal.setDate(thisdate);
		ECRTTotal.setTime(thistime);
 </cfscript>
 
    
    <cfif PosBean.getPosType() eq "1" >
    	 <cfset ECRTTotal.setroundingsd( PosBean.getMediaRoundTotal() )/>
    <cfelse>
     	 <cfset ECRTTotal.setroundingsd( PosBean.getMediaRoundTotal() * -1 )/>
    </cfif>  

    <cfif PosBean.getPosType() eq "1" >
     	 <cfif ( PosBean.getItemDiscountTotal() + PosBean.getSubTotalDiscount() )>
     			 <cfset ECRTTotal.setdiscounts("1")/>
       <cfelse>
           <cfset ECRTTotal.setdiscounts("0")/>
       </cfif>
    
    <cfelse>

		   <cfif ( PosBean.getItemDiscountTotal() + PosBean.getSubTotalDiscount() )>
			    <cfset ECRTTotal.setdiscounts("-1")/>
       <cfelse>
           <cfset ECRTTotal.setdiscounts("0")/>
       </cfif>
     
    </cfif>
     
	  <cfif PosBean.getPosType() eq "1" >
   	   <cfset ECRTTotal.setdiscountd(  PosBean.getItemDiscountTotal() + PosBean.getSubTotalDiscount()  )/>
    <cfelse>
      	<cfset ECRTTotal.setdiscountd(  (PosBean.getItemDiscountTotal() + PosBean.getSubTotalDiscount()) * -1  )/>
    </cfif>
     
    <cfif PosBean.getPosType() eq "1" >
    	<cfif PosMediaBean.getMediaID() eq "1">
		 <cfset ECRTTotal.setcashsales("1")/>
         <cfset ECRTTotal.setcashsalesd( PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange()  )/>
         <cfset ECRTTotal.setcreditsales("0")/>
         <cfset ECRTTotal.setcreditsalesd("0")/>
      <cfelse>
		 <cfset ECRTTotal.setcashsales("0")/>
         <cfset ECRTTotal.setcashsalesd("0")/>
         <cfset ECRTTotal.setcreditsales("1")/>
         <cfset ECRTTotal.setcreditsalesd( PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange()  )/>
         <cfif PosmediaBean.getMediaChange()  NEQ 0 >
			 <cfset ECRTTotal.seteftcashout("1")/>
             <cfset ECRTTotal.seteftcashoutd( PosmediaBean.getMediaChange() )/>
         </cfif>
      </cfif>
    <cfelse>
    	<cfif PosMediaBean.getMediaID() eq "1">
		 <cfset ECRTTotal.setcashsales("-1")/>
         <cfset ECRTTotal.setcashsalesd( ( PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange()) *-1 )/>
         <cfset ECRTTotal.setcreditsales("0")/>
         <cfset ECRTTotal.setcreditsalesd("0")/>
      <cfelse>
		 <cfset ECRTTotal.setcashsales("0")/>
         <cfset ECRTTotal.setcashsalesd("0")/>
         <cfset ECRTTotal.setcreditsales("-1")/>
         <cfset ECRTTotal.setcreditsalesd( ( PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange()) *-1 )/>
         <cfif PosmediaBean.getMediaChange()  NEQ 0 >
			 <cfset ECRTTotal.seteftcashout("-1")/>
             <cfset ECRTTotal.seteftcashoutd( PosmediaBean.getMediaChange() *-1 )/>
  		 </cfif>
      </cfif>
    
    
    </cfif>
    
    
    
    <cfif PosBean.getPosType() eq "3" >
    	 <cfif PosMediaBean.getMediaID() eq "1">
    		  <cfset ECRTTotal.setcashrefunds("1")/>
			    <cfset ECRTTotal.setcashrefundd(  PosMediaBean.getMediaExt() )/>
          <cfset ECRTTotal.setcreditrefunds("0")/>
          <cfset ECRTTotal.setcreditrefundd("0")/>
       <cfelse>
    		  <cfset ECRTTotal.setcashrefunds("0")/>
			    <cfset ECRTTotal.setcashrefundd( "0" )/>
          <cfset ECRTTotal.setcreditrefunds("1")/>
          <cfset ECRTTotal.setcreditrefundd(   PosMediaBean.getMediaExt()  )/>        
        
       </cfif>
    </cfif>
        
	<!---[   If PosBean.getPosType() is 1 (i.e. not '3'    ]---->
  <cfif PosBean.getPosType() eq "1" >
  	 
     <cfif PosMediaBean.getMediaID() eq "1">
    	<cfset ECRTTotal.setcashsalesgstincd( PosMediaBean.getMediaExt()  - PosmediaBean.getMediaChange()  )/>
    	<cfset ECRTTotal.setcashsalegstfreed( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstincd( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstfreed( "0"  )/>
        <cfset ECRTTotal.setgstcashsaled(PosBean.getTaxTotal() )/>
        <cfset ECRTTotal.setgstcreditsaled( "0" )/>
     <cfelse>
      	<cfset ECRTTotal.setcashsalesgstincd( "0" )/>
    	<cfset ECRTTotal.setcashsalegstfreed( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstincd( PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange()   )/>
        <cfset ECRTTotal.setcreditsalesgstfreed( "0"  )/>
        <cfset ECRTTotal.setgstcashsaled( "0" )/>
        <cfset ECRTTotal.setgstcreditsaled( PosBean.getTaxTotal() )/>
     </cfif>  
<cfelse>
<!---[   IF it's not a sale (i.e. the postype is not '1' (usually 3)   ]---->
    <cfif PosMediaBean.getMediaID() eq "1">
    	<cfset ECRTTotal.setcashsalesgstincd( (PosMediaBean.getMediaExt()  - PosmediaBean.getMediaChange() )*-1 )/>
    	<cfset ECRTTotal.setcashsalegstfreed( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstincd( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstfreed( "0"  )/>
        <cfset ECRTTotal.setgstcashsaled(PosBean.getTaxTotal()*-1 )/>
        <cfset ECRTTotal.setgstcreditsaled( "0" )/>
     <cfelse>
      	<cfset ECRTTotal.setcashsalesgstincd( "0" )/>
    	<cfset ECRTTotal.setcashsalegstfreed( "0" )/>
        <cfset ECRTTotal.setcreditsalesgstincd( (PosMediaBean.getMediaExt() - PosmediaBean.getMediaChange() )*-1  )/>
        <cfset ECRTTotal.setcreditsalesgstfreed( "0"  )/>
        <cfset ECRTTotal.setgstcashsaled( "0" )/>
        <cfset ECRTTotal.setgstcreditsaled( PosBean.getTaxTotal()*-1 )/>
     </cfif>  

  </cfif>        

 <!---[    
 <cfset ECRTTotal.setcashin("0")/>
  <cfset ECRTTotal.setcashind("0")/>
  <cfset ECRTTotal.setcashout("0")/>
  <cfset ECRTTotal.setcashoutd("0")/>   ]---->
      
<cfif PosBean.getPosType() eq "1" >
		 <cfif PosBean.getVoidTotal() eq "0">
            <cfset ECRTTotal.setcancellations("0")/>
            <cfset ECRTTotal.setcancellationd("0")/>
     <cfelse>
            <cfset ECRTTotal.setcancellations("1")/>
            <cfset ECRTTotal.setcancellationd(PosBean.getVoidTotal() )/>     
     </cfif>
<cfelse>
     <cfif PosBean.getVoidTotal() eq "0">
            <cfset ECRTTotal.setcancellations("0")/>
            <cfset ECRTTotal.setcancellationd("0")/>
     <cfelse>
            <cfset ECRTTotal.setcancellations("-1")/>
            <cfset ECRTTotal.setcancellationd(PosBean.getVoidTotal() * -1 )/>     
     </cfif>
</cfif>     
    
   <!---
    <cfset ECRTTotal.setcashrefunds("0")/>
  	<cfset ECRTTotal.setcashrefundd( "0" )/>
    <cfset ECRTTotal.setcreditrefunds("0")/>
    <cfset ECRTTotal.setcreditrefundd("0")/>
   --->  
      
  <cfif PosBean.getPosType() eq "1" >
      	<cfset ECRTTotal.setsales( "1" )/>
  <cfelseif PosBean.getPosType() eq "3" >     
      	<cfset ECRTTotal.setsales( "-1" )/>
  <cfelse>
      	<cfset ECRTTotal.setsales( "0" )/>
  </cfif>

  <cfif PosBean.getPosType() eq "1" >
     	<cfset ECRTTotal.setposted( "1" )/>
  <cfelse>
     	<cfset ECRTTotal.setposted( "0" )/>
  </cfif>



  
  <cfcatch type="any">
	   <cfset ECRTTotalNoError = false />
	   <cfset session.ProcessNoErrors = false />
       <cfset session.ProcessErrors.ECRTTotal = "Error in ECRTTotal, PosTXID = #session.PosTXID#" />
     
  </cfcatch>
</cftry>
<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif ECRTTotalNoError is true >
		<cfset PosDAO.setECRTTotalPostedFlag(session.PosTXID) />
	</cfif>  
    
     <cfset StoreECRTTotalsDAO.save(  ECRTTotal  ) />

