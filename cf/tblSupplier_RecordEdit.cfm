
<cfset strPageTitle = "Supplier Details Add/Edit">

<!--- 
SupplierID - SupplierID
SupplierName - SupplierName
Phone
	Mobile
Fax
Email
AcctBalance
CreditLimit
NoLongerUsed
--->

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

<CFSET FormFieldList = "SupplierName,
,Phone
.Mobile
,Fax
,Email
,AcctBalance
,CreditLimit
,NoLongerUsed
">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblSupplier.SupplierID, *, tblSupplier.SupplierID AS ID_Field
		FROM tblSupplier
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblSupplier.SupplierID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "SupplierID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "SupplierID" )>
	</CFIF>
			<CFSET SupplierID_Value = #GetRecord.SupplierID#>
				
			<CFSET SupplierName_Value = #GetRecord.SupplierName#>

			<CFSET Phone_Value = #GetRecord.Phone#>
			<CFSET Mobile_Value = #GetRecord.Mobile#>
			<CFSET Fax_Value = #GetRecord.Fax#>
			<CFSET Email_Value = #GetRecord.Email#>
			<CFSET AcctBalance_Value = #GetRecord.AcctBalance#>
			<CFSET CreditLimit_Value = #GetRecord.CreditLimit#>
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>

<CFELSE>
			<CFSET SupplierID_Value = ''>
				
			<CFSET SupplierName_Value = ''>
				
			<CFSET Phone_Value = ''>
			<CFSET Mobile_Value = ''>
			<CFSET Fax_Value = ''>
			<CFSET Email_Value = ''>
			<CFSET AcctBalance_Value = '0'>
			<CFSET CreditLimit_Value = '0'>
			<CFSET NoLongerUsed_Value = '0'>
</CFIF>

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
      <div align="right"><a href="tblSupplier_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<CFOUTPUT>
<FORM action="tblSupplier_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="SupplierID" value="#URL.RecordID#">
</CFIF>
            <TABLE width="500" border="1" cellpadding="2">
              <CFIF not ParameterExists(URL.RecordID)>
              <cfelse>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF">Store ID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF">#SupplierID_Value#</font>
                </TD>
              </TR>
			  </CFIF>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Supplier Name: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SupplierName" value="#SupplierName_Value#" size="50" maxLength="30">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Phone: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Phone" value="#Phone_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Mobile: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Mobile" value="#Mobile_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Fax: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Fax" value="#Fax_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Email: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Email" value="#Email_Value#" size="50" maxLength="70">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Acct Balance: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="AcctBalance" value="#AcctBalance_Value#" size="50" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="AcctBalance_float">
                <INPUT type="hidden" name="AcctBalance_required" value="Please type the account balance.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Credit Limit: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="CreditLimit" value="#CreditLimit_Value#" size="50" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="CreditLimit_float">
                <INPUT type="hidden" name="CreditLimit_required" value="Please type the credit limit.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  No Longer Used: </font></b></TD>
                <TD> 
				<INPUT type="radio" name="NoLongerUsed" value="1"<CFIF #NoLongerUsed_Value# is 1> checked</CFIF>> Yes
				<INPUT type="radio" name="NoLongerUsed" value="0"<CFIF #NoLongerUsed_Value# is 0> checked</CFIF>> No								
               <!---  <INPUT type="text" name="NoLongerUsed" value="#NoLongerUsed_Value#" size="50" maxLength="5"> --->
                </TD>
<!---                 <!--- field validation ---> boolean
                <INPUT type="hidden" name="AcctBalance_float">
 --->              </TR>
            </TABLE>
<p></p>	
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

