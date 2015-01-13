<cfsilent>
<!----
==========================================================================================================
Filename:     SavetblStockLocation.cfm
Description:  Processes the transaction to the tblStockLocation table
Date:         30/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

10/7/2010  Only process this page if the tblOptions table requires it.   Added CFIF around the whole process. MK 

==========================================================================================================
--->
<cfset StockLocationDAO =   application.beanfactory.getBean("StockLocationDAO") />
<cfset PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />


<!---[   Only perform this whole page if the tblOptions requires it to happen.   ]---->
<cfif StockLocationDAO.IsUpdateRequired() >

<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
<cfset StockLocationNoError = true />


<!---[   A poslineBean already exists from the previous process   ]---->



<cftry>
<!---[   Get a stock location bean, initialised with the defaults   ]---->
<cfscript>
StockLocation = application.beanfactory.getBean("StockLocation") ;
StockLocation.setStoreID( session.StoreID    ) ;
StockLocation.setPartNo( PosLineBean.getProductCode()    ) ;
StockLocation.setProductID( PosLineBean.getProductID()    ) ;
</cfscript>


<!---[   If this StockLocation doesnt already exist,  create one with the defaults and a few 
		product-line specific changes   ]---->
<cfif NOT(StockLocationDAO.recordexists( StockLocation ) ) >      
	 <!---[   conditional values based on combinations of fields in the product   ]---->
    <cfif PosLineBean.getCostIncludeTax() >
    	<cfset StockLocation.setLastCost( PosLineBean.getCostUnit() / 1.1  )>
    <cfelse>
    	<cfset StockLocation.setLastCost( PosLineBean.getCostUnit() )>
    </cfif>
     
     <cfif PosLineBean.getCostIncludeTax() >
    	<cfset StockLocation.setAverageCost( PosLineBean.getCostUnit() / 1.1  )>
    <cfelse>
    	<cfset StockLocation.setAverageCost( PosLineBean.getCostUnit() )>
    </cfif>
      
      <cfif PosLineBean.getSellIncludeTax() >
    	<cfset StockLocation.setRetailPrice( PosLineBean.getSellUnit() / 1.1  )>
    <cfelse>
    	<cfset StockLocation.setRetailPrice( PosLineBean.getSellUnit() )>
    </cfif>  
     
    <cfif PosLineBean.getSellIncludeTax() >
    	<cfset StockLocation.setMaxRetail( PosLineBean.getSellUnit() / 1.1  )>
    <cfelse>
    	<cfset StockLocation.setMaxRetail( PosLineBean.getSellUnit() )>
    </cfif>  
 
    <cfset StockLocationDAO.save( StockLocation ) />
   
</cfif>


 <cfcatch type="database">
 	<cfset StockLocationNoError = false />
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.StockLocation.ThrowMessage  = "Error in StockLocation, PosTXID = #session.PosTXID#, Type=database Line: #PosLineBean.getPosLineID()#" />
    <cfset session.ProcessErrors.StockLocation.Error.Message = #cfcatch.Message#  />
    <cfset session.ProcessErrors.StockLocation.Error.NativeErrorCode = #cfcatch.NativeErrorCode# />
    <cfset session.ProcessErrors.StockLocation.Error.SQLState =  #cfcatch.SQLState# />
    <cfset session.ProcessErrors.StockLocation.Error.Detail =  #cfcatch.Detail# />
</cfcatch>

 <cfcatch type="any"> 
 <cfset session.ProcessErrors.StockLocation.ThrowMessage  = "Error in StockLocation, PosTXID = #session.PosTXID#, Type=general exception Line: #PosLineBean.getPosLineID()#" />
    <cfset session.ProcessErrors.StockLocation.Error.Message = #cfcatch.Message#  />
    <cfset session.ProcessErrors.StockLocation.Error.Detail =  #cfcatch.Detail# />
   </cfcatch> 
    
</cftry> 



<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif StockLocationNoError is true >
		<cfset PosLinesDAO.setStockLocationPostedFlag( PosLineBean ) />
	</cfif>  

</cfif>
</cfsilent>