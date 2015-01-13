
<cfset strPageTitle = "Stocktake Adjust">


<!----[ comment out old security access check  - MK  ]   
 <CFIF 
	ParameterExists(session.logged) and 
	ParameterExists(session.employeeID)
	>
	<CFIF 
		(session.logged is "YES") and 
		(session.employeeID GT 0) and 
		(session.usertype  NEQ "NONE")
		>
	<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="../index.htm">
</CFIF>----->

<!--- Get the error captions --->
	<cfset strQuery = "SELECT tblStocktakeErrors.ErrorID, tblStocktakeErrors.ErrorDesc ">
	<cfset strQuery = strQuery & "FROM tblStocktakeErrors ">
	<cfset strQuery = strQuery & "ORDER BY tblStocktakeErrors.ErrorDesc">
	<CFQUERY name="GetErrorCaptions" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetErrorCaptions" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</cfquery>		
	

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
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
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="StockTakeSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<CFSET FormFieldList = "Freezer_QtyOnHand,CoolRoom_QtyOnHand,Display_QtyOnHand">

<CFIF ParameterExists(URL.RecordID)>

	<cfset strQuery = "SELECT tblStockLocation.ID, tblStockMaster.PartNo, tblStockMaster.Description, tblStockLocation.StoreID, tblStockLocation.Prev_QtyOnHand, tblStockLocation.Freezer_QtyOnHand, tblStockLocation.CoolRoom_QtyOnHand, tblStockLocation.Display_QtyOnHand ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockLocation ON tblStockMaster.PartNo = tblStockLocation.PartNo ">
	<CFIF ParameterExists(URL.RecordID)>
		<cfset strQuery = strQuery & "WHERE tblStockLocation.ID = #URL.RecordID#">
	</CFIF>

	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
	<!--- <CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
	</cfquery>		

	<CFIF not ListFind( FormFieldList, "ID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "ID" )>
	</CFIF>

			<CFSET Plu_Value = '#GetRecord.PartNo#'>
			
			<CFSET Description_Value = '#GetRecord.Description#'>

			<CFSET Freezer_QtyOnHand_Value = #GetRecord.Freezer_QtyOnHand#>
				
			<CFSET CoolRoom_QtyOnHand_Value = #GetRecord.CoolRoom_QtyOnHand#>
				
			<CFSET Display_QtyOnHand_Value = #GetRecord.Display_QtyOnHand#>
<CFELSE>
			<CFSET Plu_Value = ''>
			
			<CFSET Description_Value = ''>
			
			<CFSET Freezer_QtyOnHand_Value = '0'>
				
			<CFSET CoolRoom_QtyOnHand_Value = '0'>
				
			<CFSET Display_QtyOnHand_Value = '0'>
</CFIF>

<CFOUTPUT>
<FORM action="StocktakeAdjust_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="ID" value="#URL.RecordID#">
</CFIF>

<TABLE>

	<TR>
	<TD valign="top"> Plu: </TD>
    <TD>
		#Plu_Value#
	</TD>
	</TR>
	<TR>
	<TD valign="top"> Description: </TD>
    <TD>
		#Description_Value#
	</TD>
	</TR>
	<TR>
	<TD valign="top"> Freezer Quantity: </TD>
    <TD>
		<INPUT type="text" name="Freezer_QtyOnHand" value="#Freezer_QtyOnHand_Value#" maxLength="10">
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="Freezer_QtyOnHand_float" value = "Please type the freezer quantity">
	<INPUT type="hidden" name="Freezer_QtyOnHand_required" value = "Please type the freezer quantity">
	</TR>

	<TR>
	<TD valign="top"> Coolroom Quantity: </TD>
    <TD>
		<INPUT type="text" name="CoolRoom_QtyOnHand" value="#CoolRoom_QtyOnHand_Value#" maxLength="10">
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="CoolRoom_QtyOnHand_float" value = "Please type the coolroom quantity">
	<INPUT type="hidden" name="CoolRoom_QtyOnHand_required" value = "Please type the coolroom quantity">
	</TR>
	
	<TR>
	<TD valign="top"> Display Quantity: </TD>
    <TD>
		<INPUT type="text" name="Display_QtyOnHand" value="#Display_QtyOnHand_Value#" maxLength="10">
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="Display_QtyOnHand_float" value = "Please type the display quantity">
	<INPUT type="hidden" name="Display_QtyOnHand_required" value = "Please type the display quantity">		
	</TR>

	<TR>
	</CFOUTPUT>
	<TD valign="top"> Reason for adjusting: </TD>
    <TD>
		  <select name="AdjustReason">
		  	<cfset LineIndex = 0>
		    <cfoutput query = "GetErrorCaptions">
			  	<cfset LineIndex = LineIndex + 1>			
				<cfif LineIndex EQ 1>
					<option value="#GetErrorCaptions.ErrorID#" selected>#GetErrorCaptions.ErrorDesc#</option>
				<cfelse>
					<option value="#GetErrorCaptions.ErrorID#">#GetErrorCaptions.ErrorDesc#</option>
				</cfif>
			</cfoutput>
		  </select>
	</TD>
	</TR>
		
</TABLE>
<br>	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">
</FORM>

	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

