
<cfset strPageTitle = "Credit Request">

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
      <div align="right"><a href="InvoiceCreditRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<cfset lngInvocieNumber = #Form.InvoiceNumber#>
<cfset strPartNo = "#Form.Plu#">
<cfset strReason = "#Form.Reason#">

<!--- Check the existance of this line --->
<cfset strQuery = "SELECT tblOrderInvoiceDetail.InvoiceDetailID, tblOrderInvoiceDetail.InvoiceID, tblOrderInvoiceDetail.PartNo, Credited  AS IsCredited, * ">
<cfset strQuery = strQuery & "FROM tblOrderInvoiceDetail ">
<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)= #lngInvocieNumber# ) AND ((tblOrderInvoiceDetail.PartNo)= '#strPartNo#' ))">
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="CheckInvoiceLine" datasource="#application.dsn#" > 
<!--- <CFQUERY name="CheckInvoiceLine" datasource="#application.dsn#" >  --->
<!--- <CFQUERY name="CheckInvoiceLine" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfif #CheckInvoiceLine.RecordCount# EQ 0>
	<cfoutput>
	<p>There is no invoice number #lngInvocieNumber# or there is no plu #strPartNo#, please try again.</p>
	</cfoutput>
<cfelse>
	<cfif #CheckInvoiceLine.IsCredited# EQ 1>
		<p>This invoice line has already been credited and can not be credited again.</p>
	<cfelse>
	    <!--- Check the date of the invoice and make sure that it is not more than (2) days after the invoice --->
			<cfset strQuery = "SELECT * from tblOptions order by OptionID">
			<CFQUERY name="CheckNumDays" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckNumDays" datasource="#application.dsn#" >  --->
			<!--- <CFQUERY name="CheckNumDays" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfset lngNumDays = 0>
			
			<cfif #CheckNumDays.RecordCount# LT 1>
				<p><h3>Number of days to accept the credit is not entered into the option screen.</h3></p>
				<p><h3>Please enter this value and try again.</h3></p>
				<cfabort>
			</cfif>
			<cfset lngNumDays = #CheckNumDays.DaysToMakeACredit#>	

			<!--- Get the invoice date --->
			<cfset strQuery = "SELECT tblOrderInvoiceHeader.InvoiceID, * ">
			<cfset strQuery = strQuery & "FROM tblOrderInvoiceHeader ">
			<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceHeader.InvoiceID)= #lngInvocieNumber# ))">
			<CFQUERY name="GetInvoiceHeader" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="GetIn" datasource="#application.dsn#" >  --->
			<!--- <CFQUERY name="GetInvoiceHeader" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfset strInvoiceDate = #GetInvoiceHeader.InvoiceDate#>		

			
			<cfset strInvoiceSortedDate = "#mid(strInvoiceDate,5,4)#" & "#mid(strInvoiceDate,3,2)#" & "#mid(strInvoiceDate,1,2)#" >				

			<!--- Get todays date --->
			<cfset lngDateToday = "">
			<cf_GetTodayDateLong>

			<!--- Get X days from invoice date --->
			
			<cfset strNextDate = "">
			<cf_GetXDaysFromNow baseDate="#strInvoiceDate#" numDays=#lngNumDays#>

			<cfset strXdaysAfterInvoiceSortedDate = "#mid(strNextDate,5,4)#" & "#mid(strNextDate,3,2)#" & "#mid(strNextDate,1,2)#" >				

            <!--- Check todays date to be in the range --->
			<cfif (lngDateToday GTE strInvoiceSortedDate) and (lngDateToday LTE strXdaysAfterInvoiceSortedDate)>
			<cfelse>
				<cfoutput>
				<p><h3>You can ask for a credit for only #lngNumDays# days after the invoice.</h3></p>
				<p><h3>The date of invoice #lngInvocieNumber# is #strInvoiceDate#.  Therefore you can not request a credit for this invoice.</h3></p>
				</cfoutput>
				<cfabort>
			</cfif>
        <!--- If invoice has been paid then we can not claim a credit --->
			<cfif #GetInvoiceHeader.FullyApplied# EQ 1>
				<cfoutput>
				<p><h3>You can ask for a credit for only if the invoice has not been paid.</h3></p>
				<p><h3>Invoice #lngInvocieNumber# has already been paid.  Therefore you can not request a credit for this invoice.</h3></p>
				</cfoutput>
				<cfabort>
			</cfif>
	
		<!--- Copy the invoice line into the credit table, mark the invoice line  --->
		<cfset strQuery = "INSERT INTO tbCreditDetail ( Reason, Status, CreditDate, InvoiceDetailID, InvoiceID, OrderDetID, StoreID, OrderDate, PartNo, Description,   OrderID, QtyOrdered, QtySupplied, OrderingUnit, SupplyUnit, PrepCode, MaxRetailExGST, SCtoStoreUnitPriceExG, SCRebateUnitExG, THRebateUnitExG, Ratio, DateEntered, CostExG, PluType, TCode, PCode, RCode, ThreeHRebate, SCRebate ) ">
		<cfset strQuery = strQuery & "SELECT '#strReason#' as Reason, 'Credit Request' AS Status, replace(str(datepart(dd, getdate()),2),' ','0') + replace(str(datepart(mm, getdate()),2),' ','0') + str(datepart(yyyy, getdate()),4) AS CreditDate, ">
		<cfset strQuery = strQuery & "tblOrderInvoiceDetail.InvoiceDetailID, tblOrderInvoiceDetail.InvoiceID, tblOrderInvoiceDetail.OrderDetID, tblOrderInvoiceDetail.StoreID, tblOrderInvoiceDetail.OrderDate, tblOrderInvoiceDetail.PartNo, tblOrderInvoiceDetail.Description,  tblOrderInvoiceDetail.OrderID, tblOrderInvoiceDetail.QtyOrdered, tblOrderInvoiceDetail.QtySupplied, tblOrderInvoiceDetail.OrderingUnit, tblOrderInvoiceDetail.SupplyUnit, tblOrderInvoiceDetail.PrepCode, tblOrderInvoiceDetail.MaxRetailExGST, tblOrderInvoiceDetail.SCtoStoreUnitPriceExG, tblOrderInvoiceDetail.SCRebateUnitExG, tblOrderInvoiceDetail.THRebateUnitExG, tblOrderInvoiceDetail.Ratio, tblOrderInvoiceDetail.DateEntered, tblOrderInvoiceDetail.CostExG, tblOrderInvoiceDetail.PluType, tblOrderInvoiceDetail.TCode, tblOrderInvoiceDetail.PCode, tblOrderInvoiceDetail.RCode, tblOrderInvoiceDetail.ThreeHRebate, tblOrderInvoiceDetail.SCRebate ">
		<cfset strQuery = strQuery & "FROM tblOrderInvoiceDetail ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)= #lngInvocieNumber# ) AND ((tblOrderInvoiceDetail.PartNo)='#strPartNo#'))">
		<!--- <cfoutput><BR>StrQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="CreateCreditLine" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="CreateCreditLine" datasource="#application.dsn#" >  --->
		<!--- <CFQUERY name="CreateCreditLine" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<cfset strQuery = "UPDATE tblOrderInvoiceDetail SET tblOrderInvoiceDetail.Credited = 1 ">
		<cfset strQuery = strQuery & "WHERE (((tblOrderInvoiceDetail.InvoiceID)= #lngInvocieNumber# ) AND ((tblOrderInvoiceDetail.PartNo)='#strPartNo#'))">
		<!--- <cfoutput><BR>StrQuery: #strQuery#</cfoutput> --->
		<CFQUERY name="MarkInvoiceLine" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="MarkInvoiceLine" datasource="#application.dsn#" >  --->
		<!--- <CFQUERY name="MarkInvoiceLine" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		
		<!--- Read the credit line again and get the ID --->
		<cfset strQuery = "SELECT tbCreditDetail.InvoiceID, tbCreditDetail.PartNo, tbCreditDetail.CreditDetID ">
		<cfset strQuery = strQuery & "FROM tbCreditDetail ">
		<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.InvoiceID)= #lngInvocieNumber# ) AND ((tbCreditDetail.PartNo)='#strPartNo#'))">

		<CFQUERY name="SavedCreditLine" datasource="#application.dsn#" > 
		<!--- <CFQUERY name="SavedCreditLine" datasource="#application.dsn#" >  --->
		<!--- <CFQUERY name="SavedCreditLine" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfoutput>
		<table width="100%" border="0" cellspacing="0">
  			<tr>
			    <td>The credit request has been saved</td>
	  	    </tr>
  			<tr>
			    <td>&nbsp;</td>
	  	    </tr>
			<tr>
			    <td>Credit Request ID: #SavedCreditLine.CreditDetID#</td>
			</tr>
			<tr>
		    	<td>Invoice Number: #lngInvocieNumber#</td>
			</tr>
			<tr>
		    	<td>Plu: #strPartNo#</td>
			</tr>
		</table>
		</cfoutput>
	</cfif>
</cfif>
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

