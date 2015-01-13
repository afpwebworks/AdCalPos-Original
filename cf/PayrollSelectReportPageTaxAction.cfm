
<cfset strPageTitle = "Tax Payment">

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
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="Payroll.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngSID = #Form.SID#>
<cfset strDF = "#Form.strDF#">
<cfset strDT = "#Form.strDT#">
<cfset strDFSort = "#Form.strDFSort#">
<cfset strDTSort = "#Form.strDTSort#">

<cfif #len(strDF)# LT 8>
	<cfset strDF = "0" & "#strDF#">
</cfif>
<cfif #len(strDT)# LT 8>
	<cfset strDT = "0" & "#strDT#">
</cfif>
<cfif #len(strDFSort)# LT 8>
	<cfset strDFSort = "0" & "#strDFSort#">
</cfif>
<cfif #len(strDTSort)# LT 8>
	<cfset strDTSort = "0" & "#strDTSort#">
</cfif>

<cfset strPaymentType = "#Form.cmbPaymentMethod#">
<cfset strRefNumber = "#Form.RefNumber#">
<cfset dblTax = "#Form.dblTax#">

	<!--- Get UUID to have a unique identifier --->
	<cfset UUID = CreateUUID()>

	<!--- add a record to the tax paid directory --->
	<cfset strQuery = "INSERT INTO tblEmpTaxPaid ( StoreID, TaxAmount, ReferenceNumber, StartDate, EndDate, RecordUUID ) ">
	<cfset strQuery = strQuery & "Values( #lngSID#, #dblTax#, '#strRefNumber#', '#strDF#', '#strDT#', '#UUID#') ">
	<CFQUERY name="AddTaxPaid" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	<!--- Get the record ID --->
	<cfset strQuery = "select TaxPaidID from tblEmpTaxPaid Where RecordUUID = '#UUID#' ">
	<CFQUERY name="GetID" datasource="#application.dsn#" > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	<cfset NewID = 0>
	<cfif #GetID.RecordCount# GT 0>
		<cfif #isnumeric(GetID.TaxPaidID)#>
			<cfset NewID = #GetID.TaxPaidID# >
		</cfif>
	</cfif>
	
	<!--- Mark all of the related records --->
	<cfset strQuery = "UPDATE tblEmpPayRollPaid SET tblEmpPayRollPaid.TaxPaidID = #NewID#, tblEmpPayRollPaid.TaxPaid = 1, tblEmpPayRollPaid.TaxChequeNo = '#strRefNumber#', tblEmpPayRollPaid.TaxPaidDate = replace(str(datepart(dd, getdate()),2),' ','0') + replace(str(datepart(mm, getdate()),2),' ','0') + str(datepart(yyyy, getdate()),4) ">
    <cfset strQuery = strQuery & "WHERE (((tblEmpPayRollPaid.StoreID)=#lngSID#) AND ((10000*substring([WeekEnding],5,4)+100*substring([WeekEnding],3,2)+substring([WeekEnding],1,2)) Between #strDFSort# And #strDTSort#) AND ((tblEmpPayRollPaid.TaxPaidDate)='' Or (tblEmpPayRollPaid.TaxPaidDate) Is Null)) ">	
	<CFQUERY name="MarkTaxPaid" datasource="#application.dsn#" > 
	<!--- <CFQUERY name="MarkTaxPaid" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
	
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
        <table width="80%" border="0">
			<tr>
				<td>
					<cfoutput>Successfully saved the tax payment.</cfoutput>
				</td>
			</tr>
        </table>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

