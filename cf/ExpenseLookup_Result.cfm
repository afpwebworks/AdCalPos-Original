
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

<cfset lngStoreID = #session.storeid#>

<!--- Vlidate the dates --->
<!--- <cfif #len(Form.FromDate)# neq 8>
	<cfoutput><BR>#Form.FromDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif>
<cfif #len(Form.ToDate)# neq 8>
	<cfoutput><BR>#Form.ToDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<cfset strDateFrom=right(form.sDate,2) & mid(form.sDate,5,2) & left(form.sDate,4)>
<!--- <cfif #len(strDateFrom)# eq 7>
	<cfset strDateFrom = "0#strDateFrom#">
</cfif>	
<cfif len(strDateFrom) neq 8>
	<cfoutput><BR>#Form.FromDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<!--- <cfoutput>#len(strDateFrom)# strDateFrom: #strDateFrom#</cfoutput> --->
<cf_ValidateDate strDateValue ='#strDateFrom#' lngWeekDay = 0>

<cfset strDateTo=right(form.eDate,2) & mid(form.eDate,5,2) & left(form.eDate,4)>
<!--- <cfif #len(strDateTo)# eq 7>
	<cfset strDateTo = "0#strDateTo#">
</cfif>	
<cfif len(strDateTo) neq 8>
	<cfoutput><BR>#Form.ToDate# is not a valid date.  Please type a date in ddmmyyyy format.</cfoutput>
	<cfabort>
</cfif> --->
<cf_ValidateDate strDateValue ='#strDateTo#' lngWeekDay = 0>

<cfset strDateToSQL = '#mid(strDateTo,5,4)#' & '#mid(strDateTo,3,2)#' & '#mid(strDateTo,1,2)#'>
<cfset strDateFromSQL = '#mid(strDateFrom,5,4)#' & '#mid(strDateFrom,3,2)#' & '#mid(strDateFrom,1,2)#'>



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
      <div align="right"><a href="ExpenseLookup_Search.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;
<!--- Create Criteria string for query from data entered thru search form --->
<CFSET Criteria = ''>
<CF_ExpenseLookup_AppendCriteria
    FieldName="#Form.Crit2_FieldName#"
    FieldType="#Form.Crit2_FieldType#"
    Operator="#Form.Crit2_Operator#"
    Value="#Form.Crit2_Value#">
<CF_ExpenseLookup_AppendCriteria
    FieldName="#Form.Crit3_FieldName#"
    FieldType="#Form.Crit3_FieldType#"
    Operator="#Form.Crit3_Operator#"
    Value="#Form.Crit3_Value#">
<CF_ExpenseLookup_AppendCriteria
    FieldName="#Form.Crit4_FieldName#"
    FieldType="#Form.Crit4_FieldType#"
    Operator="#Form.Crit4_Operator#"
    Value="#Form.Crit4_Value#">

<cfset strQuery = "SELECT tblSupplier.SupplierName, tblSupExpenseCat.ExpenseCat, tblSupplierTranDet.SupplierTranDetID AS ResultField1, tblSupplierTranDet.StoreID AS ResultField2, tblSupplierTranDet.PurchaseDate AS ResultField3, tblSupplierTranDet.InvoiceNumber AS ResultField4, tblSupplierTranDet.GST AS ResultField5, tblSupplierTranDet.TotalAmountIncGST AS ResultField6, tblSupplierTranDet.ExpenseCatID AS ResultField7, tblSupplierTranDet.SupplierTranDetID AS ID_Field, ">
<cfset strQuery=strQuery & "substring(tblSupplierTranDet.PurchaseDate,5,4)+substring(tblSupplierTranDet.PurchaseDate,3,2)+substring(tblSupplierTranDet.PurchaseDate,1,2) AS PurchaseDateFormatted ">
<cfset strQuery = strQuery & "FROM tblSupplier INNER JOIN (tblSupplierTranDet INNER JOIN tblSupExpenseCat ON tblSupplierTranDet.ExpenseCatID = tblSupExpenseCat.ExpenseCatID) ON tblSupplier.SupplierID = tblSupplierTranDet.SupplierID ">
<cfset strQuery = strQuery & "WHERE tblSupplierTranDet.StoreID = #lngStoreID# AND (SUBSTRING(PurchaseDate, 5, 4) + SUBSTRING(PurchaseDate, 3, 2) + SUBSTRING(PurchaseDate, 1, 2) BETWEEN '#strDateFromSQL#' AND '#strDateToSQL#') ">
<cfif #len(Criteria)# GT 0>
	<cfset strQuery = strQuery & "and #PreserveSingleQuotes(Criteria)# ">
</cfif>
<cfset strQuery=strQuery & "ORDER BY PurchaseDateFormatted ">

<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="SearchResult" maxrows=200 datasource="#application.dsn#" >
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<!--- 
<!--- Query returning search results --->
<CFQUERY name="SearchResult" maxrows=100 datasource="#application.dsn#" > 
<!--- <cfquery name="SearchResult" datasource="costi" maxrows=100 > --->
    SELECT tblSupplierTranDet.SupplierTranDetID AS ResultField1, tblSupplierTranDet.StoreID AS ResultField2, tblSupplierTranDet.PurchaseDate AS ResultField3, tblSupplierTranDet.InvoiceNumber AS ResultField4, tblSupplierTranDet.GST AS ResultField5, tblSupplierTranDet.TotalAmountIncGST AS ResultField6, tblSupplierTranDet.ExpenseCatID AS ResultField7, tblSupplierTranDet.SupplierTranDetID AS ID_Field 
    FROM tblSupplierTranDet 
	WHERE tblSupplierTranDet.StoreID = #lngStoreID# 
    <cfif #len(Criteria)# GT 0>
		and #PreserveSingleQuotes(Criteria)#
	</cfif>
</cfquery>
 --->
<P>
<table width="850" border="0" cellspacing="0" cellpadding="3">

<TR>  <!--- <TR bgcolor="cccccc"> --->
    <TD>&nbsp;</TD>
    <td width="100" align="left">ID</td>
    <td width="50"  align="left">Store</td>
    <td width="100" align="left">Supplier</td>	
    <td width="100"  align="left">Date</td>
    <td width="100"  align="left">Invoice N0</td>
    <td width="100"  align="left">GST</td>
    <td width="100"  align="left">Total</td>
    <td width="100"  align="left">Category</td>
</TR>
<CFOUTPUT query="SearchResult">
<TR bgcolor="#IIf(CurrentRow Mod 2, DE('00006D'), DE('0033FF'))#">
    <TD><A href="Expenses_RecordEdit.cfm?RecordID=#URLEncodedFormat(ID_Field)#"><h3>[detail]</h3></A></TD>
    <TD>#ResultField1#</TD>
<TD>#ResultField2#</TD>
<TD>#SearchResult.SupplierName#</TD>
<TD>#ResultField3#</TD>
<TD>#ResultField4#</TD>
<TD>#NumberFormat(ResultField5,"______.00")#</TD>
<TD>#NumberFormat(ResultField6,"______.00")#</TD>
<TD>#SearchResult.ExpenseCat#</TD>
</TR>
</CFOUTPUT>
	<tr>
		<td colspan="8" align="left">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="8">This screen only displays up to 200 results.</td>
	</tr>
	<tr>
		<td colspan="8">Please refine your search to limit the number of lines.</td>
	</tr>

</TABLE>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

