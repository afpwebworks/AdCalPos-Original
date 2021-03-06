
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmExpenseLookup">
<cfset local.page="ExpenseLookup_Search.cfm">

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

<cfset strDateToday = "">
<cf_GetTodayDate>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
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
<!--- - wb 12/12/2003 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
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
    <td align="center">
		<a href="Expenses_RecordEdit.cfm" target="_self"><b><font size="3" color="FFFFFF" face="Tahoma"><img src="addExpense.jpg"></font></b></a> 
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">&nbsp;
	  
<!--- Search form --->
<FORM action="ExpenseLookup_Result.cfm" id="frmExpenseLookup" method="post" name="frmExpenseLookup" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<table align="center" border="0" cellpadding="0" cellspacing="0">
	<tr><td><strong>Purchase Date</strong></td></tr>
</table>
<!--- - wb 22/12/2003 - Display calendar - --->
<cfinclude template="CalendarDisplay2.cfm">
<br />
<TABLE>
		
	<!--- Field: tblSupplierTranDet.InvoiceNumber=CHAR;40;FALSE --->
	<INPUT type="hidden" name="Crit2_FieldName" value="tblSupplierTranDet.InvoiceNumber">
	<INPUT type="hidden" name="Crit2_FieldType" value="CHAR">
	<TR>
	<TD>Invoice Number</TD>
	<TD><SELECT name="Crit2_Operator">
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="SMALLER_THAN">before
			<OPTION value="GREATER_THAN">after
		</SELECT>
	</TD>
	<TD>
	<INPUT type="text" name="Crit2_Value">
	</TD>
	</TR>
	<!--- Field: tblSupplierTranDet.TotalAmountIncGST=FLOAT;8;FALSE --->
	<INPUT type="hidden" name="Crit3_FieldName" value="tblSupplierTranDet.TotalAmountIncGST">
	<INPUT type="hidden" name="Crit3_Value_float">
	
	<INPUT type="hidden" name="Crit3_FieldType" value="FLOAT">
	<TR>
	<TD>Total Amount (Inc GST)</TD>
	<TD><SELECT name="Crit3_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		</SELECT>
	</TD>
	<TD>
	<INPUT type="text" name="Crit3_Value">
	</TD>
	</TR>
	<!--- Field: tblSupplierTranDet.ExpenseCatID=INT;4;FALSE --->
	<INPUT type="hidden" name="Crit4_FieldName" value="tblSupplierTranDet.ExpenseCatID">
	<INPUT type="hidden" name="Crit4_Value_integer">
	<INPUT type="hidden" name="Crit4_FieldType" value="INT">
	<TR>
	<TD>Category</TD>
	<TD><SELECT name="Crit4_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		</SELECT>
	</TD>
	<TD>
	<INPUT type="text" name="Crit4_Value">
	</TD>
	</TR>
</TABLE>
<P>
<INPUT type="submit">

</FORM>


	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

