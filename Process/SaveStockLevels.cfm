<cfsilent>
<!----
==========================================================================================================
Filename:     SaveStockLevels.cfm
Description:  Maintain stock levels in the database based on the transaction type.
Date:         5/5/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfset StockLocationDAO =   application.beanfactory.getBean("StockLocationDAO") />
<cfset PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />


<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
<cfset StockLevelsNoError = true />
<!---[   Ensure any existing session error structs are removed.   ]---->
<cfif structKeyExists(session, "ProcessErrors")>
	<cfif structKeyExists(session.ProcessErrors, "StockLevels")>
        <cfset structDelete(session.ProcessErrors, "StockLevels") />
    </cfif>
</cfif>


 <cftry> 
 

 <!---[   The exception to all these possibilities is if the PosType is 12 - set the quantity on hand to be equal to the quantity in this transaction.   ]---->
<cfif (PosBean.getPosType() is "12")> 
<cfset StockLocationDAO.SetStockQuantity( session.storeID, PosLineBean.getProductID(), PosLineBean.getQuantity() ) />

<!---[   A PosLineBean already exists from previous processing.   ]---->
<cfelseif (PosLineBean.getProductType() is "1") >
	<cfif (PosBean.getPosType() is "1")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	<cfelseif (PosBean.getPosType() is "3")>
		<cfset quantity = (PosLineBean.getQuantity() ) />   
	<cfelseif (PosBean.getPosType() is "11")>
		<cfset quantity = (PosLineBean.getQuantity() ) />   
    <cfelseif (PosBean.getPosType() is "13")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	<cfelseif (PosBean.getPosType() is "14")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	</cfif>
    

    <cfset StockLocationDAO.UpdateStockQuantity( session.storeID, PosLineBean.getProductID(), Quantity ) />
  

    
<cfelseif  (PosLineBean.getProductType() is "4") >   
	<cfif (PosBean.getPosType() is "1")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	<cfelseif (PosBean.getPosType() is "3")>
		<cfset quantity = (PosLineBean.getQuantity() ) />   
	<cfelseif (PosBean.getPosType() is "11")>
		<cfset quantity = (PosLineBean.getQuantity() ) />   
    <cfelseif (PosBean.getPosType() is "13")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	<cfelseif (PosBean.getPosType() is "14")>
		<cfset quantity = (PosLineBean.getQuantity() * -1 ) />
	</cfif>
    

     
    <cfset StockLocationDAO.UpdateStockQuantity( session.storeID, PosLineBean.getProductID(), Quantity ) />
   
  
    
</cfif>


  
<cfcatch type="Database">
	<cfset StockLevelsNoError = false />
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.StockLevels.ThrowMessage = "Error in SaveStockLevels, Type = Database, PosTXID = #session.PosTXID#, Line: #PosLineBean.getPosLineID()#" />
    <cfset session.ProcessErrors.StockLevels.Error.Message = #cfcatch.Message#  />
    <cfset session.ProcessErrors.StockLevels.Error.NativeErrorCode = #cfcatch.NativeErrorCode# />
    <cfset session.ProcessErrors.StockLevels.Error.SQLState =  #cfcatch.SQLState# />
    <cfset session.ProcessErrors.StockLevels.Error.Detail =  #cfcatch.Detail# />
    
   
    
 </cfcatch> 

 <cfcatch type="any">
 	<cfset StockLevelsNoError = false />
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.StockLevels.ThrowMessage = "Error in SaveStockLevels, Type = General Exception, PosTXID = #session.PosTXID#, Line: #PosLineBean.getPosLineID()#" />
    <cfset session.ProcessErrors.StockLevels.Error.Message = #cfcatch.Message#  />
    <cfset session.ProcessErrors.StockLevels.Error.Detail =  #cfcatch.Detail# />
</cfcatch>
</cftry>  


<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif StockLevelsNoError is true >
		<cfset PosLinesDAO.setStockLevelsPostedFlag( PosLineBean ) />
	</cfif>  


</cfsilent>
