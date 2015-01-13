<cfsilent> 
<!----
==========================================================================================================
Filename:     tblStockMaster.cfm
Description:  Exports data from the tblStockMaster table in the SQLServer database to the StaticStandalone.mdb
Date:         20/Dec/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfif NOT(isdefined("DataTransferManager"))>
  <cfset DataTransferManager =   application.beanfactory.getBean("DataTransferManager") />
</cfif>
<cfset StockmasterDAO =   application.beanfactory.getBean("StockmasterDAO") />
  
<!---[    Get the data to export.   ]---->
<cfset SQLData = DataTransferManager.getAllProductSQL() />
<cftry> 
     
     <cfloop query="SQLData">
        <!---[   For each record in SQLData, do an insert into the PRODUCT table in the MDF database.   ]---->
        <cfscript>
		MDBProduct = structnew();
		MDBProduct.ProductID            = SQLData.ProductID;
		MDBProduct.Description          = SQLData.Description;
		MDBProduct.ProductCode          = SQLData.PartNo;
		MDBProduct.ProductType          = DataTransferManager.SQLPlutypetoMDB( SQLData.PLUType );  
		MDBProduct.DepartmentID         = SQLData.GroupNo;
		MDBProduct.ModifierType         = 0;
		
		MDBProduct.TaxID                = SQLData.Tcode + 1 ;
		MDBProduct.CostIncludeTax       = true;
		MDBProduct.CostUnit             = SQLData.Wholesale ;
		MDBProduct.IsWeighed            = SQLData.IsWeighed;
		MDBProduct.AllowZeroPrice       = SQLData.AllowZeroPrice;
		if ( isnumeric(SQLData.DiscountNo) )
		{ MDBProduct.DiscountNumber     = SQLData.DiscountNo; }
		else
		 { MDBProduct.DiscountNumber    = 0;}
		if ( isnumeric(SQLData.Tare) )
		{ MDBProduct.Tare               = SQLData.Tare; }
		else
		 { MDBProduct.Tare               = 0;}
		MDBProduct.OnHand               = 0;
		if ( len(SQLData.KitchenPrint) )
		{ MDBProduct.KitchenPrint     = SQLData.KitchenPrint; }
		else
		 { MDBProduct.KitchenPrint    = "000000000";} // Each KP can be printed to x times from 0 to 9. One digit per KP
		if ( isnumeric(SQLData.kitchentype) )
		{ MDBProduct.kitchentype     = SQLData.kitchentype; }
		else
		 { MDBProduct.kitchentype    = 0;}
 		if ( isnumeric(SQLData.ModifierID) )
		{ MDBProduct.ModifierID     = SQLData.ModifierID; }
		else
		 { MDBProduct.ModifierID    = 0;}
		if ( isnumeric(SQLData.PointsAwarded) )
		{ MDBProduct.PointsAwarded     = SQLData.PointsAwarded; }
		else
		 { MDBProduct.PointsAwarded    = 0;}
		 if ( isnumeric(SQLData.PointsRequiredToBuy) )
		{ MDBProduct.PointsRequiredToBuy     = SQLData.PointsRequiredToBuy; }
		else
		 { MDBProduct.PointsRequiredToBuy    = 0;}
		MDBProduct.Timestamp            = application.beanfactory.getbean("configbean").getAustime();
		MDBProduct.ExternalID           = 0;
		//MDBProduct.PictureFile          = SQLData.PictureFile;/
		MDBProduct.PictureFile          = "";
		MDBProduct.Status               = SQLData.NoLongerUsed ;      //  0:Active;1:Deleted
    	MDBProduct.SellUnit             = SQLData.MaxRetail ;
     	MDBProduct.Discountable         = SQLData.Discountable;       
    	MDBProduct.IsCountDown          = SQLData.IsCountDown;        
    	MDBProduct.AllowOpenPrice       = SQLData.AllowOpenPrice;     
 		
		if (SQLData.tCode eq 0) { MDBProduct.sellINC = false; }
		else {  MDBProduct.sellINC = true;   }
	   </cfscript>

        <!---[    Now save the struct to the Access database   ]---->
        <cfset DataTransferManager.savetoMDB(  MDBProduct ) />
       <!---[   <cfset DataTransferManager.SetPriceRecordMDB(  MDBProduct ) />   ]---->
      </cfloop>
      

<cfcatch type="any">
    <cfmail to="#application.webmasteremail#" from="#application.webmasteremail#" subject="#application.sitemailindex#: Error in #application.applicationName# MaintenanceOut" type="html" server="#application.mailserver#" username="#application.mailuser#" password="#application.mailpassword#">
    <cfoutput>
    <h2>An error occured in #application.sitename# Maintenance out routine in the file tblStockMaster.cfm.</h2>
    <p> Page: #cgi.script_name#?#cgi.query_string#<br>
      Time: #dateFormat(request.austime, "d/m/yyyy")# at #lcase(timeFormat(request.austime, "h:mmtt"))#<br>
    </p>
     <cfdump var="#error#" label="error">
    <cfdump var="#url#" label="URL">
    <cfdump var="#form#" label="Form">
    <cfdump var="#cgi#" label="CGI">
    </cfoutput>
    </cfmail>
  </cfcatch>
</cftry>   
</cfsilent> 
