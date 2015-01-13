
<cfset strPageTitle = "Product Ratios Add/Edit">

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

<CFSET FormFieldList = "KitID,PartNoSalePLU,PartNoBuyingPLU,PrepCode,Ratio">

<CFIF ParameterExists(URL.RecordID)>
    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1>

		SELECT tblStockKit.KitID, tblStockKit.PartNoSalePLU, tblStockKit.PartNoBuyingPLU, tblStockKit.PrepCode, tblStockKit.Ratio, tblStockKit.KitID AS ID_Field
		FROM tblStockKit
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblStockKit.KitID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "KitID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "KitID" )>
	</CFIF>
			<CFSET KitID_Value = #GetRecord.KitID#>
				
			<CFSET PartNoSalePLU_Value = #GetRecord.PartNoSalePLU#>
				
			<CFSET PartNoBuyingPLU_Value = #GetRecord.PartNoBuyingPLU#>

			<CFSET PrepCode_Value = #GetRecord.PrepCode#>

			<CFSET Ratio_Value = #GetRecord.Ratio#>
<CFELSE>
			<CFSET KitID_Value = ''>
				
			<CFSET PartNoSalePLU_Value = ''>
				
			<CFSET PartNoBuyingPLU_Value = ''>
			
			<CFSET PrepCode_Value = ''>

			<CFSET Ratio_Value = ''>
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
      <div align="right"><a href="tblStockKit_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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
<FORM action="tblStockKit_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="KitID" value="#URL.RecordID#">
</CFIF>


            <TABLE width="400" border="1" cellpadding="2">
              <CFIF not ParameterExists(URL.RecordID)>
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  KitID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="KitID" value="#KitID_Value#" size="15" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="KitID_integer">
              </TR>
              <cfelse>
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF">KitID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF">#KitID_Value#</font>
                </TD>
              </TR>
			  </CFIF>
			  
              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Selling PLU No: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PartNoSalePLU" value="#PartNoSalePLU_Value#" size="15" maxLength="16">
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="PartNoSalePLU_float"> --->
              </TR>

              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Buying PLU No: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PartNoBuyingPLU" value="#PartNoBuyingPLU_Value#" size="15" maxLength="16">
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="PartNoBuyingPLU_float"> --->
              </TR>

              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Preparation Code: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PrepCode" value="#PrepCode_Value#" size="15" maxLength="5">
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="PartNoBuyingPLU_float"> --->
              </TR>

              <TR> 
                <TD valign="top" width="250"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Ratio: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Ratio" value="#Ratio_Value#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="PartNoBuyingPLU_float"> --->
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

