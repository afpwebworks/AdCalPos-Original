

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Transfer</TITLE>
	
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
      <h1>Transfer</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="javascript:history.go(-1);". onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td> 
      &nbsp;
	  
	  <!--- <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div> --->
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngError = 0>
<cfset indicate_error = 0>
<cfset quantity_error =0>
<cfset strError = ''>
<cfset output_error =''>
<cfset output_qty=''>
<cfset dblLastCost = 0 >
<FORM action="TransferActionBL.cfm" method="post">
<CFIF (ParameterExists(Form.btnEdit_OK)) or (ParameterExists(Form.btnApply_OK))>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	
	<cfoutput>
	<cfset MyIDFieldName = "Form.storeid">	
	<cfset lngStoreID = #evaluate(MyIDFieldName)#>  
	<cfset lngDeptNo = #Form.cmbDeptNo#>
	<cfset lngEmployeeID = #Form.employeeID#>

	<input type="hidden" name="storeid" value="#lngStoreID#">
	<input type="hidden" name="employeeID" value="#lngEmployeeID#">
	<input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">


</cfoutput>
<!--- 	
	<cfset strDate = #Form.txtstrDate#>
	<cfset lngStoreID = #Form.txtlngStoreID#>
	<cfif len(#strDate#) EQ 7>
		<cfset strDate = "0" & "#strDate#" >
	</cfif>
 --->
	<!--- Save the quantities --->
	<cfoutput>
	<cfset lngNumDepartments = #Form.NumDepartments#>
	
	<input type="hidden" name="NumDepartments" value="#lngNumDepartments#">
	</cfoutput>
	
   <!--- Check to make sure that the destination PLU is correct --->
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumDepartments#">
		<!--- Get the number of lines per department --->
		
		<cfset MyIDFieldName = "Form.Dept_#LoopCount#_TotalLines">
		
		<cfset lngNumLines = #evaluate(MyIDFieldName)#>
		<cfoutput>
		<input type="hidden" name="Dept_#LoopCount#_TotalLines" value="#lngNumLines#">
		</cfoutput>
		<CFLOOP INDEX="ItemLineCount" FROM="1" TO="#lngNumLines#">	
			<!--- Get ID --->
			<cfoutput>
			
			
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_txtID#ItemLineCount#">
			<cfset lngItemID = #evaluate(MyIDFieldName)#>
			<input type="hidden" name="Dept_#LoopCount#_txtID#ItemLineCount#" value="#lngItemID#">
			<!--- Get Part No --->
			
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_PartNo#ItemLineCount#">
			<cfset strPartNo = #evaluate(MyIDFieldName)#>
		<input type="hidden" name="Dept_#LoopCount#_PartNo#ItemLineCount#" value="#strPartNo#">
			<!--- Get Freezer qty --->
			
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Value_Line_#ItemLineCount#">
			<cfset dblFreezerQty = #evaluate(MyIDFieldName)#>
	<input type="hidden" name="Dept_#LoopCount#_Value_Line_#ItemLineCount#" value="#dblFreezerQty#">
			<!--- Get Destination PLU --->
				
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Plu_Line_#ItemLineCount#">
			<cfset strPluDestination = #evaluate(MyIDFieldName)#>
			<input type="hidden" name="Dept_#LoopCount#_Plu_Line_#ItemLineCount#" value="#strPluDestination#">
			<!-- Pass other variables --->
		</cfoutput>
		<cfoutput>
			
			
			<input type="hidden" name="Dept_#LoopCount#_Value_Line_#ItemLineCount#_required" 		value="Form.Dept_#LoopCount#_Value_Line_#ItemLineCount#_required">
			 
			
		</cfoutput>
			<cfif (#dblFreezerQty# GT 0.00001) and (#strPluDestination# EQ "")>
				<cfif indicate_error EQ 0>
					<cfset output_error = '#strPartNo#'>
				<cfelse>
					<cfset output_error = '#output_error#' & ', #strPartNo#'>
				</cfif>
				<cfset indicate_error = indicate_error + 1>
			<cfelseif (#strPluDestination# NEQ "") and (#dblFreezerQty# EQ 0)>
				<cfif quantity_error EQ 0>
					<cfset output_qty = '#strPartNo#'>
				<cfelse>
					<cfset output_qty ='#output_qty#' & ', #strPartNo#'>
				</cfif>
				<cfset quantity_error = quantity_error + 1>
			<cfelseif (#dblFreezerQty# GT 0.00001) and (#strPluDestination# NEQ "")>
			    <!--- Check the existance of the Destination PLU --->
				<cfset strQuery = "SELECT tblStockMaster.PartNo ">
				<cfset strQuery = strQuery & "FROM tblStockMaster ">
				<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PartNo)= '#strPluDestination#' ))">
				<CFQUERY name="CheckDestinationPLU"      datasource="#application.dsn#"        > <!--- <CFQUERY name="CheckDestinationPLU"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			    <cfif #CheckDestinationPLU.RecordCount# LT 1>
					<cfif #lngError# EQ 0>
						<cfset strError = '#strPluDestination#'>
					<cfelse>
						<cfset strError = '#strError#' & ', #strPluDestination#'>
					</cfif>
					<cfset lngError = lngError + 1 >			
				</cfif>
			</cfif>	
		</cfloop>
	</cfloop>
    <cfif (#lngError# GT 0) OR (#indicate_error# GT 0) OR (quantity_error GT 0)>
		<cfoutput>
			<br>
			<br><b><h2>ERROR</h2></b>
			<br>
		<cfif (#lngError# GT 0)>
			<br><b>The following destination PLU(s) do not exist.</b>
			<br>#strError#
			<br>
		</cfif>
		<cfif (quantity_error GT 0)>
			<br><b>Transfer Quantity for the following Part Number(s) was not entered.</b>
			<br>#output_qty#
			<br>
		</cfif>
		<cfif (#indicate_error# GT 0)>
			<br><b>The Destination PLU(s) for the following Part Number(s) was not entered.</b>
			<br>#output_error#
			<br>
		</cfif>
		<br>Your Transfer Order was NOT saved.  Fix the error and try again.
		</cfoutput>
		<cfabort>
	</cfif>

<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumDepartments#">
		<!--- Get the number of lines per department --->
		<cfset MyIDFieldName = "Form.Dept_#LoopCount#_TotalLines">
		<cfset lngNumLines = #evaluate(MyIDFieldName)#>
		
		<CFLOOP INDEX="ItemLineCount" FROM="1" TO="#lngNumLines#">	
			<!--- Get ID --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_txtID#ItemLineCount#">
			<cfset lngItemID = #evaluate(MyIDFieldName)#>
			<!--- Get Part No --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_PartNo#ItemLineCount#">
			<cfset strPartNo = #evaluate(MyIDFieldName)#>
			<!--- Get Freezer qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Value_Line_#ItemLineCount#">
			<cfset dblFreezerQty = #evaluate(MyIDFieldName)#>
			<!--- Get Destination PLU --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Plu_Line_#ItemLineCount#">
			<cfset strPluDestination = #evaluate(MyIDFieldName)#>
		<cfif (#dblFreezerQty# GT 0.00001) and (len(#strPluDestination#) GT 0)>
			<cfset strQuery = "select QtyOnHand ">
			<cfset strQuery = strQuery & "From tblStockLocation ">
			<cfset strQuery = strQuery & "WHERE (tblStockLocation.StoreID = #lngStoreID# ) AND (tblStockLocation.PartNo = '#strPartNo#' )">
			<CFQUERY name="GetCurrQty"      datasource="#application.dsn#"        > #PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #GetCurrQty.QtyOnHand# LT dblFreezerQty>
				
				<cfif indicate_error EQ 0>
					<cfset output_error ='#strPartNo#'>
				<cfelse>
					<cfset output_error= '#output_error#' & ', #strPartNo#'>
				</cfif>
				<cfset indicate_error = indicate_error + 1>
			</cfif>
		</cfif>	
			

				<cfif (#dblFreezerQty# GT 0.00001) and (len(#strPluDestination#) GT 0)>
			    <!--- Check the existance of the Destination PLU --->
				<cfset strQuery = "SELECT tblStockMaster.PartNo ">
				<cfset strQuery = strQuery & " FROM tblStockMaster ">
				<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PartNo)= '#strPluDestination#' ))">
				<CFQUERY name="CheckDestinationPLU"      datasource="#application.dsn#"        > <!--- <CFQUERY name="CheckDestinationPLU"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
					#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
			    <cfif #CheckDestinationPLU.RecordCount# LT 1>
					<cfset lngError = lngError + 1 >
					<cfset strError = '#strError#' & ', #strPluDestination#'>
				</cfif>
			</cfif>	
		</cfloop>
	</cfloop>
	<br><br><br>
	<cfif indicate_error GT 0>
		<cfoutput><strong>Transfer value(s) for #output_error# more than Stock on hand</strong>
				  </cfoutput><br>
	</cfif>
	<br>
	
	
	<table width="90%" border="0" cellspacing="0">
		<tr>
		  <td align="center"><strong>Proceed or Go back?</strong></td>
		</tr>
		<tr>
		  <td align="center">&nbsp;</td>
		</tr>
		<tr>		
		  <td> 
			<div align="center">
			  <input type="submit" name="btnApply_OK" value=" Proceed & Save Changes ">
			</div>
		  </td>
		</tr>
	</table>
	</FORM> 
		
	<!--- <FORM action="TransferBL.cfm" method="post">
	
		<cfoutput>
			<cfset MyIDFieldName = "Form.storeid">	
			<cfset lngStoreID = #evaluate(MyIDFieldName)#>  
			<cfset lngDeptNo = #Form.cmbDeptNo#>
			<cfset lngEmployeeID = #Form.employeeID#>
		
			<input type="hidden" name="storeid" value="#lngStoreID#">
			<input type="hidden" name="employeeID" value="#lngEmployeeID#">
			<input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">


		</cfoutput>
		<table width="90%" border="0" cellspacing="0">
		<tr>		
		  <td> 
			<div align="center">
			  <input type="submit" name="btnApply_notOK" value=" Go Back & Change Quantity ">
			</div>
		  </td>
		</tr>
	</table>
	</FORM> --->
		
<CFELSE>	
	<cflocation URL = "TransferBL.cfm">
</cfif>	
 
</body>
</HTML>
