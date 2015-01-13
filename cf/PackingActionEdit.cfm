
<cfparam name="form.type" default="0">
<HTML><HEAD> 
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>sample</TITLE>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Packing Order</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PackingRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngError = 0>
<cfset strError = ''>
 
<CFIF (ParameterExists(Form.btnEdit_OK)) or (ParameterExists(Form.btnEdit_Save))>

	<cfset strDate = #Form.txtstrDate#>
	<cfset lngStoreID = #Form.txtlngStoreID#>
	<cfif len(#strDate#) EQ 7>
		<cfset strDate = "0" & "#strDate#" >
	</cfif>
	<cfset lngDPNO = #Form.txtlngDPNO#>
	
	<!--- Save the quantities --->
	<cfset lngNumRecords = #Form.txtNumLines#>
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumRecords#">
		<!--- 	Read ID Number --->
		<cfset MyIDFieldName = "Form.txtID" & #LoopCount#>
		<!--- <cfoutput><p>#MyIDFieldName#</p></cfoutput> --->	
		<cfset lngOrderLineID = #evaluate(MyIDFieldName)#>
		<!--- <cfoutput><p>#lngOrderLineID#</p></cfoutput> --->
	
		<!--- 	Read Qty --->
		<cfset MyQtyFieldName = "Form.txtQTY" & #LoopCount#>
		<!--- <cfoutput><p>#MyQtyFieldName#</p></cfoutput> --->	
		<cfset dblOrderQTY = #evaluate(MyQtyFieldName)#>
		<!--- <cfoutput><p>#dblOrderQTY#</p></cfoutput> --->

		<CFIF IsNumeric(dblOrderQTY)>	
			<!--- 	Save the value --->
			<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.QtySupplied = #dblOrderQTY# , tblOrderDetail.Status ='Packed' ">
			<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.OrderDetID)=#lngOrderLineID#))">
			<CFQUERY name="SaveRecord" MAXROWS="1" datasource="#application.dsn#" > 
			<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="SaveRecord" MAXROWS="1"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		<cfelse>
			<cfset #lngError# = #lngError# + 1>
			<cfset MyPartNoFieldName = "Form.txtPartNo" & #LoopCount#>
			<cfset strPartNo = #evaluate(MyPartNoFieldName)#>
			<cfset #strError# = "#strError#" & ", " & "#strPartNo#">			
		</cfif>
	</CFLOOP>
	<cfif #lngError# GT 0>
		<cfoutput><p><b><font size="4" color="FFFF33">There were #lngError# errors.  Please check PLU</font></b></p></cfoutput>
		<cfoutput><p><b><font size="4" color="FFFF33">#strError#</font></b></p></cfoutput>
	<cfelse>
		<div align="center"><p>Finished Saving the supplied quantities</p></div>		
	</cfif>

<cfset lngError = 0>
<cfset strError = ''>
	
	<!--- Save the Prep Type items --->
	<cfset lngNumRecords = #Form.txtNumFillets#>
	<cfif #lngNumRecords# GT 0>
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumRecords#" step = "1">
		<!--- 	Read ID Number --->
		<cfset MyIDFieldName = "Form.txtFilletID" & #LoopCount#>
		<!--- <cfoutput><p>#MyIDFieldName#</p></cfoutput> --->	
		<cfset lngOrderLineID = #evaluate(MyIDFieldName)#>
		<!--- <cfoutput><p>#lngOrderLineID#</p></cfoutput> --->
	
		<!--- 	Read Qty --->
		<cfset MyQtyFieldName = "Form.txtFilletQTY" & #LoopCount#>
		<!--- <cfoutput><p>#MyQtyFieldName#</p></cfoutput> --->	
		<cfset dblOrderQTY = #evaluate(MyQtyFieldName)#>
		<!--- <cfoutput><p>#dblOrderQTY#</p></cfoutput> --->

		<!--- 	Read Fillet PLU --->
		<cfset MyFillerPartNoFieldName = "Form.txtFilletPartNo" & #LoopCount#>
		<cfset strFillerPartNo = #evaluate(MyFillerPartNoFieldName)#>
		<cfset strFillerPartNo = "#strFillerPartNo#" & "#dblOrderQTY#">			
        <!--- <cfoutput><BR>dblOrderQTY: #dblOrderQTY#</cfoutput> --->
		<!--- <cfabort> --->
		<!--- <CFIF (len(dblOrderQTY) GT 0) and (dblOrderQTY GT 0) > --->
		<CFIF (len(dblOrderQTY) GT 0) >
		    <!--- <cfoutput><BR>strFillerPartNo: #strFillerPartNo#</cfoutput> --->
		    <!--- <cfoutput><BR>dblOrderQTY: #dblOrderQTY#</cfoutput> --->
		    <!--- <cfoutput><HR></cfoutput> --->
			<!--- Check to make sure that the prep code is valid before svaing it. --->
			<!--- <cfoutput><BR>strFillerPartNo: #strFillerPartNo#___</cfoutput> --->

			<cfset strQuery = "SELECT tblStockMaster.PartNo ">
			<cfset strQuery = strQuery & "FROM tblStockMaster ">
			<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PartNo)= '#strFillerPartNo#' ) AND ((tblStockMaster.PluType)= 'P' ) AND ((tblStockMaster.NoLongerUsed)=0))">
			<CFQUERY name="CheckPrepTypeItem" datasource="#application.dsn#" > 
			<!--- <CFQUERY  name="CheckPrepTypeItem" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		 		#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
			<!--- <cfoutput><BR>CheckPrepTypeItem.RecordCount: #CheckPrepTypeItem.RecordCount#</cfoutput> --->
			
			<cfif #CheckPrepTypeItem.RecordCount# GT 0>
				<!--- 	Save the value --->
				<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.PrepCode = '#dblOrderQTY#' , tblOrderDetail.Status ='Packed' ">
				<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.OrderDetID)=#lngOrderLineID#))">
				<!--- <cfoutput><BR>strQuery Save the value: #strQuery#</cfoutput> --->

				<CFQUERY name="SaveFilletRecord" MAXROWS="1" datasource="#application.dsn#" > 
				<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="SaveFilletRecord" MAXROWS="1"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			    <!--- <cfoutput><BR>PrepCode Saved</cfoutput> --->
				<!--- <cfabort>  --->
				
			<cfelse>
                <!--- Make sure that the qty of the error item is zero --->		
				<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.QtySupplied = 0 , tblOrderDetail.PrepCode = '', tblOrderDetail.Status ='Open Order' ">
				<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.OrderDetID)=#lngOrderLineID#))">
				<CFQUERY name="ChangeSuppliedQtyBack" MAXROWS="1" datasource="#application.dsn#" > 
				<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="ChangeSuppliedQtyBack" MAXROWS="1"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<cfset #lngError# = #lngError# + 1>
				<cfset #strError# = "#strError#" & ", " & "#strFillerPartNo#">			
			</cfif>
		<cfelse>
                <!--- Make sure that the qty of the error item is zero --->		
				<cfset strQuery = "UPDATE tblOrderDetail SET tblOrderDetail.QtySupplied = 0 , tblOrderDetail.PrepCode = '', tblOrderDetail.Status ='Open Order' ">
				<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.OrderDetID)=#lngOrderLineID#))">
				<CFQUERY name="ChangeSuppliedQtyBack2" MAXROWS="1" datasource="#application.dsn#" > 
				<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="ChangeSuppliedQtyBack2" MAXROWS="1"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<!--- Only show error if the qty is above zero				
				<CFIF (ParameterExists(Form.btnEdit_OK)) >
					<cfset #lngError# = #lngError# + 1>
					<cfset #strError# = "#strError#" & ", " & "#strFillerPartNo#">
				</cfif>				
				 --->				
		</cfif>
	</CFLOOP>
	</cfif>	

	<cfif #lngError# GT 0>
		<cfoutput><p><b><font size="4" color="FFFF33">There were #lngError# errors in prep type items.  Please check PLU</font></b></p></cfoutput>
		<cfoutput><p><b><font size="4" color="FFFF33">#strError#</font></b></p></cfoutput>
		<cfoutput><BR></cfoutput>
		<cfoutput><BR></cfoutput>
		<cfoutput><BR><a href="PackingList.cfm?DD=#strDate#&ST=#lngStoreID#&DPID=#lngDPNO#&type=#form.type#"><h2>Continue Entering More Items</h2></a></cfoutput> 
	
	<cfelse>
		<CFIF ParameterExists(Form.btnEdit_Save)>
			<cflocation URL = "PackingList.cfm?DD=#strDate#&ST=#lngStoreID#&type=#form.type#">
		<cfelse>
			<div align="center"><p>Finished Saving the prep codes</p></div>
		</cfif>
	</cfif>
	
	<FORM action="PackingActionCreateInvoice.cfm"	method="post">
		
		<cfoutput>
			<input type="hidden" name="txtstrDate" value="#strDate#">
			<input type="hidden" name="txtlngStoreID" value="#lngStoreID#">
			<input type="hidden" name="type" value="#form.type#">
		</cfoutput>
		<cfif form.type NEQ 1>
			<cfif lngError EQ 0>
				<p align="center">
					<strong>Comments:</strong><br />
					<textarea cols="35" id="comments" name="comments" rows="3"></textarea>
				</p>
			</cfif>
			<CFQUERY name="qGetTotalOrders" datasource="#application.dsn#" > 
				SELECT 		COUNT(OrderID) AS num 
				FROM 		tblorderheader 
				WHERE		tblorderheader.OrderDate='#strDate#'	
			</CFQUERY>
<!---			<cfif qGetTotalOrders.num GT 1>
				<!--- Only show the create invoice button if there has been 2 orders placed
					  for the day - one frozen, one non - frozen --->
--->
			<cfif qGetTotalOrders.num GT 0>
				<!--- Only show the create invoice button if there has been an order placed
					  for the day --->
				<table width="100%" border="0">
				  <tr>
				    <td>
				      <div align="center">
							<!--- <INPUT type="submit" name="btnAllocateMore" value="  Allocate  "> --->
							&nbsp;
				 	  </div>
				    </td>
				  </tr>
				  <tr>
				    <td>&nbsp; 
				    </td>
				  </tr>
				  <tr>
				    <td>
				      
				      	<div align="center">
							<cfoutput>
							<a href="InvoiceLayoutDraft.cfm?SID=#lngStoreID#&DD=#strDate#" target="_blank"><h2>Draft Invoice</h2></a>
							</cfoutput>
			 	  		</div>
				 	  	
				    </td>
				  </tr>
				  <tr>
				    <td>
				      <div align="center">
							&nbsp;
				 	  </div>
				    </td>
				  </tr>
				  <tr>
				    <td>
				      
					      <div align="center">
							<INPUT type="submit" name="btnCreateInvoice_OK" value="  Create Invoice  ">
					 	  </div>
				 	 
				    </td>
				  </tr>
				</table>
			</cfif>
		<cfelse>
			<!--- <!--- Delete Remaining Order Lines --->
			<!--- <cfset strQuery = "DELETE ">
			<cfset strQuery = strQuery & "FROM tblOrderDetail ">
			<cfset strQuery = strQuery & "WHERE (((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#'))">  --->
			<CFQUERY name="QQ5" datasource="#application.dsn#" > 
				<!--- #PreserveSingleQuotes(strQuery)# --->
				 DELETE 
				FROM 	tblOrderDetail 
				WHERE 	(((tblOrderDetail.StoreID)=#lngStoreID#) AND ((tblOrderDetail.OrderDate)='#strDate#'))
				AND		(tblOrderDetail.typeID = 1)
						<!--- <cfif form.type EQ 1>
							AND (tblOrderDetail.typeID = 1) 
						<cfelse>
							AND (tblOrderDetail.typeID <> 1)
						</cfif>	 --->	
			</CFQUERY> --->
		</cfif>
	</form>

<CFELSE>	
	<cflocation URL = "PackingRequest.cfm">
</cfif>	
	  
</body>
</HTML>

