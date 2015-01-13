
<cfset strPageTitle = "Pay Options Add/Edit">

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

<CFSET FormFieldList = "ID,SuperRate,HolidayPay,HolidayLoading,SickLeaveYr1,SickLeave,WorkersComp">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmpPayOptions.ID, tblEmpPayOptions.ID AS ID_Field, * 
		FROM tblEmpPayOptions
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmpPayOptions.ID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "ID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "ID" )>
	</CFIF>
			<CFSET ID_Value = #GetRecord.ID#>
			<CFSET SuperRate_Value = #GetRecord.SuperRate#>
			<CFSET HolidayPay_Value = #GetRecord.HolidayPay#>
			<CFSET HolidayLoading_Value = #GetRecord.HolidayLoading#>
			<CFSET SickLeaveYr1_Value = #GetRecord.SickLeaveYr1#>
			<CFSET SickLeave_Value = #GetRecord.SickLeave#>
			<CFSET WorkersComp_Value = #GetRecord.WorkersComp#>

<CFELSE>
			<CFSET ID_Value = ''>
			<CFSET SuperRate_Value = 0>
			<CFSET HolidayPay_Value = 0>
			<CFSET HolidayLoading_Value = 0>
			<CFSET SickLeaveYr1_Value = 0>
			<CFSET SickLeave_Value = 0>
			<CFSET WorkersComp_Value = 0>

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
<!---       <div align="right"><a href="tblEmpPayOptions_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
 --->
 		&nbsp; 
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
<FORM action="tblEmpPayOptions_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="ID" value="#URL.RecordID#">
</CFIF>

            <TABLE width="450" border="1" cellpadding="2">
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  ID: </font></b></TD>
                <TD> 
	             <CFIF not ParameterExists(URL.RecordID)>
	                  <INPUT type="text" name="ID" value="#ID_Value#" size="40" maxLength="12">
	              <cfelse>
	                  <font face="Tahoma" size="4" color="FFFFFF">#ID_Value#</font>
				  </CFIF>
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="ID_integer">
                <INPUT type="hidden" name="ID_required" value="Please type ID.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Super Rate: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SuperRate" value="#NumberFormat(SuperRate_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SuperRate_float">
                <INPUT type="hidden" name="SuperRate_required" value="Please type super rate.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Holiday Pay: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="HolidayPay" value="#NumberFormat(HolidayPay_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="HolidayPay_float">
                <INPUT type="hidden" name="HolidayPay_required" value="Please type holiday pay.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Holiday Loading: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="HolidayLoading" value="#NumberFormat(HolidayLoading_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="HolidayLoading_float">
                <INPUT type="hidden" name="HolidayLoading_required" value="Please type holiday loading.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sick Leave Yr1: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SickLeaveYr1" value="#NumberFormat(SickLeaveYr1_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SickLeaveYr1_float">
                <INPUT type="hidden" name="SickLeaveYr1_required" value="Please type sick leave Yr1.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Sick Leave: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="SickLeave" value="#NumberFormat(SickLeave_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="SickLeave_float">
                <INPUT type="hidden" name="SickLeave_required" value="Please type sick leave.">				
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Workers Comp: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="WorkersComp" value="#NumberFormat(WorkersComp_Value,"_____.0000")#" size="40" maxLength="12">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="WorkersComp_float">
                <INPUT type="hidden" name="WorkersComp_required" value="Please type workers comp.">				
              </TR>

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

