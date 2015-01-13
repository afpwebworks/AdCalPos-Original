<cfsilent>
<!----
==========================================================================================================
Filename:     SavetblStockMaster.cfm
Description:  Processes the transaction to the tblStockMaster table
Date:         30/4/2010
Author:       Michael Kear, AFP Webworks

Revision history: 
10/7/2010  Only process this page if the tblOptions table requires it.   Added CFIF around the whole process. MK 

==========================================================================================================
--->
<cfset StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />
<cfset PosLinesDAO =   application.beanfactory.getBean("PosLinesDAO") />



<!---[   Only perform this whole page if the tblOptions requires it to happen.   ]---->
<cfif StockmasterDAO.IsUpdateRequired() >


<!---[   Set an error flag to be used at the end to signify if the process has successfully completed.   ]---->
<cfset StockmasterNoError = true />

<!---[   A poslineBean already exists from the previous process   ]---->
<cftry> 


<!---[   Get a stock master bean, initialised with the defaults   ]---->
<cfscript>
StockMaster = application.beanfactory.getBean("stockmaster") ;
stockmaster.setPartNo( PosLineBean.getProductCode()    ) ;
</cfscript>

<!---[   If this productcode doesnt already exist,  create one with teh defaults and a few product-line specific changes   ]---->
<cfif NOT(StockmasterDAO.recordexists( stockmaster ) ) >      
	 <cfscript>
	 //transfer Session.Line values to the bean
	Stockmaster.setdescription(PosLineBean.getDescription() );
    Stockmaster.setLabel(PosLineBean.getDescription() );
	Stockmaster.setGroupNo(PosLineBean.getDepartmentID() );
	Stockmaster.setPartNoBuyingPLU(PosLineBean.getProductCode() );
	Stockmaster.setPartNoSalePlu(PosLineBean.getProductCode() );
	</cfscript>   
	<!---[   conditional values based on combinations of fields in the product   ]---->
    <cfif PosLineBean.getCostIncludeTax() >
    	<cfset stockmaster.setCost( PosLineBean.getCostUnit() / 1.1  )>
    <cfelse>
    	<cfset stockmaster.setCost( PosLineBean.getCostUnit() )>
    </cfif> 
     <cfif PosLineBean.getCostIncludeTax() >
    	<cfset stockmaster.setWholesale( PosLineBean.getCostUnit() / 1.1  )>
    <cfelse>
    	<cfset stockmaster.setWholesale( PosLineBean.getCostUnit() )>
    </cfif> 
     <cfif PosLineBean.getSellIncludeTax() >
    	<cfset stockmaster.setMaxRetail( PosLineBean.getSellUnit() / 1.1  )>
    <cfelse>
    	<cfset stockmaster.setMaxRetail( PosLineBean.getSellUnit() )>
    </cfif>  
    <cfswitch expression="#PosLineBean.getProductType()#">
        <cfcase value="1"><cfset stockmaster.setPluType( "N" ) /></cfcase>
        <cfcase value="2"><cfset stockmaster.setPluType( "P" ) /></cfcase>
        <cfcase value="3"><cfset stockmaster.setPluType( "M" ) /></cfcase>
        <cfcase value="4"><cfset stockmaster.setPluType( "N" ) /></cfcase>
    </cfswitch>   
    <cfset StockmasterDAO.save( stockmaster ) />
    
</cfif>


 <cfcatch type="any">
 	<cfset StockmasterNoError = false />
	<cfset session.ProcessNoErrors = false />
    <cfset session.ProcessErrors.stockmaster = "Error in stockmaster, PosTXID = #session.PosTXID#, Line: #PosLineBean.getPosLineID()#" />
</cfcatch>
</cftry> 

<!---[   IF we have successfully got to this point, set the relevant flag    ]---->
	<cfif StockmasterNoError is true >
		<cfset PosLinesDAO.setStockMasterPostedFlag( PosLineBean ) />
	</cfif>  

</cfif>

</cfsilent>