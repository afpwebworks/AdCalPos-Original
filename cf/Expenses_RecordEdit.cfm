
<cfset strPageTitle = "Expenses">

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

<cfif isdefined("URL.RecordID")>
	<!--- Make sure that the Supplier is current before going to edit --->
	<cfset strQuery = "SELECT tblSupplierTranDet.SupplierTranDetID, tblSupplier.SupplierID, tblSupplier.SupplierName, tblSupplier.NoLongerUsed ">
	<cfset strQuery = strQuery & "FROM tblSupplier INNER JOIN tblSupplierTranDet ON tblSupplier.SupplierID = tblSupplierTranDet.StoreID ">
	<cfset strQuery = strQuery & "WHERE (((tblSupplierTranDet.SupplierTranDetID)=#URL.RecordID#))">
	<CFQUERY name="CheckSupplierCurrent" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfif #CheckSupplierCurrent.RecordCount# GT 0>
		<cfif #CheckSupplierCurrent.NoLongerUsed# NEQ 0>
			<cfoutput><BR><b>#CheckSupplierCurrent.SupplierName#</b> is no longer used.  You can NOT edit records related to no longer used suppliers.</cfoutput>
			<cfabort>
		</cfif>
	</cfif>	
</cfif>

<cfset strDateToday = "">
<cf_GetTodayDate>

<!--- Get the Tax rate --->

<cfset strQuery = "SELECT tblTax.TaxID, tblTax.TaxRate ">
<cfset strQuery = strQuery & "FROM tblTax ">
<cfset strQuery = strQuery & "WHERE (((tblTax.TaxID)=1))">

<CFQUERY name="GetTaxRate" datasource="#application.dsn#" > 	  
<!--- <CFQUERY  name="GetTaxRate" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Get the Suppliers --->
<cfset strQuery = "SELECT * from tblSupplier ">
<cfset strQuery = strQuery & "WHERE NoLongerUsed = 0 order by SupplierName">
<CFQUERY name="GetSuppliers" datasource="#application.dsn#" > 	  
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<cfset dblTaxRate = 0.1>
<cfif #GetTaxRate.RecordCount# GT 0>
	<cfset dblTaxRate = #GetTaxRate.TaxRate#>
</cfif>

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
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;

<cfoutput>
	<SCRIPT>
		function gettotal()
			{
			var L1=parseFloat(document.orderform.TotalAmountIncGST.value);
			if(isNaN(L1)){L1=0;}
			document.orderform.GST.value=(L1 * #dblTaxRate#)/(1+ #dblTaxRate#) ;
		        window.status=document.orderform.GST.value;	
		     }
	</SCRIPT>
</cfoutput>	  

<CFSET FormFieldList = "PurchaseDate,InvoiceNumber,GST,TotalAmountIncGST,ExpenseCatID, PaymentMethod">

<cfset strQuery = "SELECT tblSupExpenseCat.ExpenseCatID, tblSupExpenseCat.ExpenseCat ">
<cfset strQuery = strQuery & "FROM tblSupExpenseCat ">
<cfset strQuery = strQuery & "ORDER BY tblSupExpenseCat.ExpenseCat">

<CFQUERY name="GetExpenseCats" datasource="#application.dsn#" > 	  
<!--- <CFQUERY  name="GetExpenseCats" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>


<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 	  
	<!--- <CFQUERY name="GetRecord" dataSource="costi" maxRows=1> --->
		SELECT tblSupplierTranDet.PurchaseDate, tblSupplierTranDet.InvoiceNumber, tblSupplierTranDet.GST, tblSupplierTranDet.AmountExGST, tblSupplierTranDet.TotalAmountIncGST, tblSupplierTranDet.ExpenseCatID, tblSupplierTranDet.SupplierID, tblSupplierTranDet.Description, tblSupplierTranDet.PaymentMethod,  tblSupplierTranDet.SupplierTranDetID AS ID_Field
		FROM tblSupplierTranDet
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblSupplierTranDet.SupplierTranDetID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "SupplierTranDetID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "SupplierTranDetID" )>
	</CFIF>

			
			<CFSET PurchaseDate_Value = '#GetRecord.PurchaseDate#'>
				
			<CFSET InvoiceNumber_Value = '#GetRecord.InvoiceNumber#'>
				
			<CFSET GST_Value = #GetRecord.GST#>
				
			<CFSET AmountExGST_Value = #GetRecord.AmountExGST#>
				
			<CFSET TotalAmountIncGST_Value = #GetRecord.TotalAmountIncGST#>
				
			<CFSET ExpenseCatID_Value = #GetRecord.ExpenseCatID#>

			<CFSET SupplierID_Value = #GetRecord.SupplierID#>

			<CFSET Description_Value = #GetRecord.Description#>

			<CFSET PaymentMethod_Value = #GetRecord.PaymentMethod#>		

<CFELSE>

			
			<CFSET PurchaseDate_Value = '#strDateToday#'>
				
			<CFSET InvoiceNumber_Value = ''>
				
			<CFSET GST_Value = 0>
				
			<CFSET AmountExGST_Value = 0>
				
			<CFSET TotalAmountIncGST_Value = 0>
				
			<CFSET ExpenseCatID_Value = ''>

			<CFSET SupplierID_Value = 0>

			<CFSET Description_Value = ''>

			<CFSET PaymentMethod_Value = ''>		
</CFIF>

<CFOUTPUT>
<FORM NAME="orderform" action="Expenses_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<INPUT type="hidden" name="StoreID" value="#session.storeid#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="SupplierTranDetID" value="#URL.RecordID#">
</CFIF>

<TABLE>

	<TR>
	<TD valign="top"> Supplier: </TD>
    <TD>
	<select name="SupplierID">
		<cfloop Query = "GetSuppliers">
		      <cfif #GetSuppliers.SupplierID#  EQ SupplierID_Value>
				  <option value="#GetSuppliers.SupplierID#" selected>#GetSuppliers.SupplierName#</option>
			  <cfelse>
				  <option value="#GetSuppliers.SupplierID#">#GetSuppliers.SupplierName#</option>
			  </cfif>
		</cfloop>
	</select>
	</TD>
	</TR>

	<TR>
	<TD valign="top"> Short Description: </TD>
    <TD>
		<INPUT type="text" name="Description" value="#Description_Value#" size="30" maxLength="50">
	</TD>
	</TR>
	
	<TR>
	<TD valign="top"> Expense Category: </TD>
    <TD>
	<select name="ExpenseCatID">
		<cfloop Query = "GetExpenseCats">
		      <cfif #GetExpenseCats.ExpenseCatID#  EQ ExpenseCatID_Value>
				  <option value="#GetExpenseCats.ExpenseCatID#" selected>#GetExpenseCats.ExpenseCat#</option>
			  <cfelse>
				  <option value="#GetExpenseCats.ExpenseCatID#">#GetExpenseCats.ExpenseCat#</option>
			  </cfif>
		</cfloop>
	</select>
	</TD>
	<!--- field validation --->
	<INPUT type="hidden" name="ExpenseCatID_integer">
	</TR>
	
	<TR>
	<TD valign="top"> Purchase Date: (DDMMYYYY) </TD>
    <TD>
		<INPUT type="text" name="PurchaseDate" value="#PurchaseDate_Value#" maxLength="8">
	</TD>
		<INPUT type="hidden" name="PurchaseDate_required" value="Please type the purchase date">
	</TR>
	
	<TR>
	<TD valign="top"> Invoice Number: </TD>
    <TD>
		<INPUT type="text" name="InvoiceNumber" value="#InvoiceNumber_Value#" maxLength="20">
	</TD>
		<INPUT type="hidden" name="InvoiceNumber_required" value="Please type the invoice number">
	</TR>
	
	<TR>
	<TD valign="top"> Total Amount (Inc GST): </TD>
    <TD>
		<INPUT type="text" name="TotalAmountIncGST" value="#TotalAmountIncGST_Value#" maxLength="8" onBlur="gettotal()">
	</TD>
	<!--- field validation --->
  	    <INPUT type="hidden" name="TotalAmountIncGST_float" value = "Total amount needs to be a number">
		<INPUT type="hidden" name="TotalAmountIncGST_required" value="Please type the total amount">
	</TR>
	
	<TR>
	<TD valign="top"> GST: </TD>
    <TD>
		<INPUT type="text" name="GST" value="#GST_Value#" maxLength="8">
	</TD>
	<!--- field validation --->
		<INPUT type="hidden" name="GST_float" value = "GST needs to be a number">
		<INPUT type="hidden" name="GST_required" value="Please type the GST amount">
	</TR>
	
	<tr>
		<td>Payment Method:</td>
		<td>
		  <select name="PaymentMethod">
 		  		<cfif PaymentMethod_Value EQ 'CSH'><option value="CSH" selected>Cash</option><cfelse><option value="CSH">Cash</option></cfif>
 		  		<cfif PaymentMethod_Value EQ 'CHQ'><option value="CHQ" selected>Cheque</option><cfelse><option value="CHQ">Cheque</option></cfif>
 		  		<cfif PaymentMethod_Value EQ 'DD'><option value="DD" selected>Direct Deposit</option><cfelse><option value="DD">Direct Deposit</option></cfif>
		  </select>
		</td>
	</tr>
	
</TABLE>
	
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

