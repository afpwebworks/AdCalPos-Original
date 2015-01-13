
<cfset strPageTitle = "Award Rates Add/Edit">

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

<CFSET FormFieldList = "AwardID,Age,HourlyPay,EmpStatusID">
<!--- Get the combo values for the Employee Status --->
<CFQUERY name="GetStatusCombo" datasource="#application.dsn#" > 	
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStatusCombo"> --->
	SELECT tblEmpStatus.EmpStatusID, tblEmpStatus.Status
	FROM tblEmpStatus
	ORDER BY tblEmpStatus.Status
</CFQUERY>


<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord"  maxRows=1 datasource="#application.dsn#" > 	
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmpAwardPayRates.AwardID, tblEmpAwardPayRates.AwardID AS ID_Field, *
		FROM tblEmpAwardPayRates
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmpAwardPayRates.AwardID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "AwardID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "AwardID" )>
	</CFIF>
			<CFSET AwardID_Value = #GetRecord.AwardID#>
			<CFSET Age_Value = #GetRecord.Age#>
			<CFSET HourlyPay_Value = #GetRecord.HourlyPay#>
			<CFSET EmpStatusID_Value = #GetRecord.EmpStatusID#>
<CFELSE>
			<CFSET AwardID_Value = 0>
			<CFSET Age_Value = 0>
				
			<CFSET HourlyPay_Value = 0>
				
			<CFSET EmpStatusID_Value = 0>
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
      <div align="right"><a href="tblEmpAwardPayRates_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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
<FORM action="tblEmpAwardPayRates_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="AwardID" value="#URL.RecordID#">
</CFIF>


            <TABLE width="400">
          <TABLE border="1" cellpadding="2">
			
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Age: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Age" value="#Age_Value#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="Age_integer">
                <INPUT type="hidden" name="Age_required" value="Please type age.">				
              </TR>
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Hourly Pay: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="HourlyPay" value="#NumberFormat(HourlyPay_Value,"_____.000000")#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="HourlyPay_float">
                <INPUT type="hidden" name="HourlyPay_required" value="Please type hourly pay.">								
              </TR>
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Status: </font></b></TD>

                <TD> 
          </cfoutput>
		<select name="EmpStatusID">
 		        <cfoutput query = "GetStatusCombo" >
			        	<cfif #EmpStatusID_Value# EQ #GetStatusCombo.EmpStatusID#>
                    		<option value="#GetStatusCombo.EmpStatusID#" selected>#GetStatusCombo.Status#</option>
	                    <cfelse>
    	                	<option value="#GetStatusCombo.EmpStatusID#">#GetStatusCombo.Status#</option>
        	            </cfif>
				</cfoutput>
          </select>
         <cfoutput>
  
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="EmpStatusID_float">

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

