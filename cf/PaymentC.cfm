
<cfset strPageTitle = "Payment (3 / 3)">
<cfset strPaymentType = "#Form.PaymentType#">
<cfset lngStoreID = #Form.StoreID#>

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
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="Payment.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
	<td>
		<cfset DF=right(form.sDate,2)>
		<cfset MF=mid(form.sDate,5,2)>
		<cfset YF=left(form.sDate,4)>
		<cfif len(DF) LT 2>
			<cfset DF = "0" & #DF#>
		</cfif>
		<cfif len(MF) LT 2>
			<cfset MF = "0" & #MF#>
		</cfif>
		<cfset strDate = "#DF#" & "#MF#" & "#YF#">
		<cfset Amount = #Form.Amount#>

		<cfif "#strPaymentType#" EQ "Check">
			<cfset RefNumber = #Form.CheckNumber#>
			<cfset Name = #Form.Name#>
			<cfset Bank = #Form.Bank#>
			<cfset BSB = #Form.BSB#>

			<!--- Make sure that the payment is not entered already --->

			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.RefNumber, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.RefNumber)='#RefNumber#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			
			<CFQUERY name="CheckPayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPayment.RecordCount# GT 0>
				<p>This payment has already been entered.  It can not be entered again.</p>
				<cfabort>
			</cfif>

			<!--- Save the payment ---> 
			<cfset strQuery = "INSERT INTO tblPayment ( StoreID, PaymentDate, Amount, RefNumber, Name, Bank, BSB, PaymentMethod ) ">
			<cfset strQuery = strQuery & "Values ( #lngStoreID#, '#strDate#', #Amount#, '#RefNumber#', '#Name#', '#Bank#', '#BSB#', '#strPaymentType#' )">

			<CFQUERY name="SavePayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="SavePayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>

			<!--- Check the saved entry --->
			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.RefNumber, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.RefNumber)='#RefNumber#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			<CFQUERY name="CheckPaymentAgain" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPaymentAgain" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPaymentAgain.RecordCount# GT 0>
				<cfoutput>
				<cflocation URL = "Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#CheckPaymentAgain.PymentID#">				
				<p>The payment has been saved.</p>
				<p>Your reference number is #CheckPaymentAgain.PymentID#.</p>
				</cfoutput>
			</cfif>
		<cfelseif "#strPaymentType#" EQ "Credit Card">
			<cfset CreditCard = #Form.CreditCard#>
			<cfset CardNumber = #Form.CardNumber#>
			<cfset ExpiryDate = #Form.ExpiryDate#>

			<!--- Make sure that the payment is not entered already --->

			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.PaymentDate)='#strDate#') AND ((tblPayment.CardNumber)='#CardNumber#') AND ((tblPayment.CreditCard)='#CreditCard#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			<CFQUERY name="CheckPayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPayment.RecordCount# GT 0>
				<p>This payment has already been entered.  It can not be entered again.</p>
				<cfabort>
			</cfif>

			<!--- Save the payment ---> 
			<cfset strQuery = "INSERT INTO tblPayment ( StoreID, PaymentDate, Amount, CreditCard, CardNumber, ExpiryDate, PaymentMethod ) ">
			<cfset strQuery = strQuery & "Values ( #lngStoreID#, '#strDate#', #Amount#, '#CreditCard#', '#CardNumber#', '#ExpiryDate#', '#strPaymentType#' )">

			<CFQUERY name="SavePayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="SavePayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<!--- Check the saved entry --->
			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.PaymentDate)='#strDate#') AND ((tblPayment.CreditCard)='#CreditCard#') AND ((tblPayment.CardNumber)='#CardNumber#') AND ((tblPayment.ExpiryDate)='#ExpiryDate#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			<CFQUERY name="CheckPaymentAgain" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPaymentAgain" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPaymentAgain.RecordCount# GT 0>
				<cfoutput>
				<cflocation URL = "Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#CheckPaymentAgain.PymentID#">				
				<p>The payment has been saved.</p>
				<p>Your reference number is #CheckPaymentAgain.PymentID#.</p>
				</cfoutput>
			</cfif>
		<cfelseif "#strPaymentType#" EQ "Direct Deposit">
			<cfset RefNumber = #Form.RefNumber#>

			<!--- Make sure that the payment is not entered already --->

			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.PaymentDate)='#strDate#') AND ((tblPayment.RefNumber)='#RefNumber#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			<CFQUERY name="CheckPayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPayment.RecordCount# GT 0>
				<p>This payment has already been entered.  It can not be entered again.</p>
				<cfabort>
			</cfif>

			<!--- Save the payment ---> 
			<cfset strQuery = "INSERT INTO tblPayment ( StoreID, PaymentDate, Amount, RefNumber, PaymentMethod ) ">
			<cfset strQuery = strQuery & "Values ( #lngStoreID#, '#strDate#', #Amount#, '#RefNumber#','#strPaymentType#' )">
			<CFQUERY name="SavePayment" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="SavePayment" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>

			<!--- Check the saved entry --->
			<cfset strQuery = "SELECT tblPayment.PymentID, tblPayment.StoreID, tblPayment.Amount, tblPayment.PaymentMethod ">
			<cfset strQuery = strQuery & "FROM tblPayment ">
			<cfset strQuery = strQuery & "WHERE (((tblPayment.StoreID)=#lngStoreID#) AND ((tblPayment.Amount) Between #Amount#-0.001 And #Amount#+0.001) AND ((tblPayment.PaymentDate)='#strDate#') AND ((tblPayment.RefNumber)='#RefNumber#') AND ((tblPayment.PaymentMethod)='#strPaymentType#'))">
			<CFQUERY name="CheckPaymentAgain" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="CheckPaymentAgain" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
			<cfif #CheckPaymentAgain.RecordCount# GT 0>
				<cfoutput>
				<cflocation URL = "Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#CheckPaymentAgain.PymentID#">				
				<p>The payment has been saved.</p>
				<p>Your reference number is #CheckPaymentAgain.PymentID#.</p>
				</cfoutput>
			</cfif>
		</cfif>
  	</TD>
  <TR>
</table>
<p>&nbsp;</p>
<cfoutput>
<a href="Payment_AppC.cfm?lngStoreID=#lngStoreID#&lngPymentID=#CheckPaymentAgain.PymentID#"><h3>Apply invoices to this payment</h3></a>
</cfoutput>
</body>
</HTML>

