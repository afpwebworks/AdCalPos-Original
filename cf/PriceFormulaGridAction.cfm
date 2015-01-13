
<cfset strPartNo = #Form.PartNo#> 
<CFIF ParameterExists(Form.btnEdit_OK)>
	<cfset lngNumRecords = #Form.txNumLines#>
	<!--- Save the quantities --->
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumRecords#">
		<!--- 	Read ID Number --->
		<cfset MyIDFieldName = "Form.PriceFormulaID_" & #LoopCount#>
		<cfset lngID = #evaluate(MyIDFieldName)#>
	
		<!--- 	Read From Price --->
		<cfset MyQtyFieldName = "Form.PriceFrom_" & #LoopCount#>
		<cfset dblPriceFrom = #evaluate(MyQtyFieldName)#>

		<!--- 	Read To Price --->
		<cfset MyQtyFieldName = "Form.PriceTo_" & #LoopCount#>
		<cfset dblPriceTo = #evaluate(MyQtyFieldName)#>

		<!--- 	Read Max Retail --->
		<cfset MyQtyFieldName = "Form.MaxRetail_" & #LoopCount#>
		<cfset dblMaxRetail = #evaluate(MyQtyFieldName)#>
		
		<CFIF IsNumeric(lngID)>	
			<CFIF lngID GT 0 >	
		        <!--- An existing line --->
				<!--- 	Save the value --->
				
				<CFQUERY name="UpdateRecord" MAXROWS="1" datasource="#application.dsn#" > 
                    UPDATE tblStockPriceFormula 
                    SET tblStockPriceFormula.PriceFrom = #dblPriceFrom#, 
                        tblStockPriceFormula.PriceTo = #dblPriceTo#, 
                        tblStockPriceFormula.MaxRetail = #dblMaxRetail# 
                    WHERE (((tblStockPriceFormula.PriceFormulaID)=#lngID#))
				</CFQUERY>
			<cfelse>
				<CFIF IsNumeric(dblPriceFrom) and IsNumeric(dblPriceTo) and IsNumeric(dblMaxRetail) >					
					<CFIF dblPriceFrom + dblPriceTo + dblMaxRetail GT 0 >					
				        <!--- New line --->
						<CFQUERY name="InsertNewRecord" MAXROWS="1" datasource="#application.dsn#" > 
						insert into tblStockPriceFormula (PartNo, PriceFrom, PriceTo, MaxRetail ) 
						Values ( '#strPartNo#', #dblPriceFrom# , #dblPriceTo# , #dblMaxRetail# )
						</CFQUERY>
					</cfif>			
				</cfif>			
			</cfif>
		</cfif>
	</CFLOOP>
	<cflocation URL = "tblStockMaster_RecordView.cfm?PartNo=#strPartNo#">
<CFELSE>	
	<cflocation URL = "tblStockMaster_RecordView.cfm?PartNo=#strPartNo#">
</cfif>	

