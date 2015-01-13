
<cfsetting enablecfoutputonly="Yes">
<!--- - WB 09/01/2004 - Setup calendar variables - --->
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmEmpPublicHol">
<cfset local.page="tblEmpPublicHol_RecordEdit.cfm">

<cfset strPageTitle = "Public Holiday Add/Edit">

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

<!--- SELECT tblEmpPublicHol.PublicHolID, tblEmpPublicHol.Date, tblEmpPublicHol.Name, tblEmpPublicHol.Trading, tblEmpPublicHol.DateEntered
FROM tblEmpPublicHol;
 --->

<CFSET FormFieldList = "PublicHolID,Date,Name,Trading">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmpPublicHol.PublicHolID, tblEmpPublicHol.PublicHolID AS ID_Field, *
		FROM tblEmpPublicHol
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmpPublicHol.PublicHolID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "PublicHolID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "PublicHolID" )>
	</CFIF>
			<CFSET PublicHolID_Value = #GetRecord.PublicHolID#>
			<CFSET Date_Value = #GetRecord.Date#>
			<CFSET Name_Value = #GetRecord.Name#>
			<CFSET Trading_Value = #GetRecord.Trading#>
<CFELSE>
			<CFSET PublicHolID_Value = ''>
			<CFSET Date_Value = ''>
			<CFSET Name_Value = ''>
			<CFSET Trading_Value = 0>
</CFIF>
<cfsetting enablecfoutputonly="No">
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
<script language="JavaScript1.2" src="../js/calendar_check1.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar1.js" type="text/javascript"></script>
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
      <div align="right"><a href="tblEmpPublicHol_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<FORM action="tblEmpPublicHol_RecordAction.cfm" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<INPUT type="hidden" name="FieldList" value="<cfoutput>#FormFieldList#</cfoutput>">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="<cfoutput>#URL.RecordID#</cfoutput>">
	<INPUT type="hidden" name="PublicHolID" value="<cfoutput>#URL.RecordID#</cfoutput>">
</CFIF>

            <TABLE width="450" border="1" cellpadding="2">
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  ID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF"><cfoutput>#PublicHolID_Value#</cfoutput></font>&nbsp;
                </TD>
              </TR>

              <TR> 
                <TD align="center" colspan="2" valign="top"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Date: </font></b></TD>
                <!--- <TD> 
                  <INPUT type="text" name="Date" value="#Date_Value#" size="40" maxLength="8">
                </TD>
				                <!--- field validation --->
                <INPUT type="hidden" name="Date_required" value="Please type the date.">				
                <INPUT type="hidden" name="Date_integer"> --->              
			  </TR>
			  <tr><td align="center" colspan="2">
			  	<!--- - WB 09/01/2004 - Display calendar - --->
				<cfinclude template="CalendarDisplay1.cfm">	
			  </td></tr>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Name: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Name" value="<cfoutput>#Name_Value#</cfoutput>" size="40" maxLength="15">
                </TD>
				                <!--- field validation --->
                <INPUT type="hidden" name="Name_required" value="Please type the name.">				
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Trading: </font></b></TD>
                <TD> 
<!---                   <INPUT type="text" name="ShopIsOpen" value="#ShopIsOpen_Value#" size="40" maxLength="21">
 ---> 		
 					<INPUT type="radio" name="Trading" value="1"<CFIF #Trading_Value# is 1> checked</CFIF>> Yes
 					<INPUT type="radio" name="Trading" value="0"<CFIF #Trading_Value# is 0> checked</CFIF>> No
                </TD>
              </TR>

            </TABLE>

<p></p>	
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

