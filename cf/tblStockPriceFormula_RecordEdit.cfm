
<cfset strPageTitle = "Price Formula Add/Edit">

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

<!--- <CFSET FormFieldList = "PartNo,PriceFrom,PriceTo,MaxRetail">
 --->
<CFSET FormFieldList = "PartNo,PriceFrom,PriceTo,MaxRetail,Description,Wholesale">


<CFIF ParameterExists(URL.RecordID)>
<!---
    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1>

        SELECT tblStockPriceFormula.PriceFormulaID , tblStockPriceFormula.PartNo, tblStockPriceFormula.PriceFrom , tblStockPriceFormula.PriceTo , tblStockPriceFormula.MaxRetail, tblStockPriceFormula.DateEntered , tblStockPriceFormula.PriceFormulaID AS ID_Field
		FROM tblStockPriceFormula
 --->
	<cfset strQuery = "SELECT  tblStockMaster.Description, tblStockMaster.Wholesale, ">
	<cfset strQuery = strQuery & "tblStockPriceFormula.PriceFormulaID , tblStockPriceFormula.PartNo, ">
	<cfset strQuery = strQuery & "tblStockPriceFormula.PriceFrom , tblStockPriceFormula.PriceTo , ">
	<cfset strQuery = strQuery & "tblStockPriceFormula.MaxRetail, tblStockPriceFormula.DateEntered , ">
<!---     <cfset strQuery = strQuery & "(100*(tblStockPriceFormula.MaxRetail - tblStockMaster.Wholesale)/tblStockPriceFormula.MaxRetail) as GP , ">
 --->
    <cfset strQuery = strQuery & "(100*(tblStockPriceFormula.MaxRetail - (tblStockPriceFormula.PriceFrom + tblStockPriceFormula.PriceTo)/2)/tblStockPriceFormula.MaxRetail) as GP , ">
	<cfset strQuery = strQuery & "tblStockPriceFormula.PriceFormulaID AS ID_Field ">
	<cfset strQuery = strQuery & "FROM tblStockMaster INNER JOIN tblStockPriceFormula ">
	<cfset strQuery = strQuery & "ON tblStockMaster.Partno = tblStockPriceFormula.partno  ">

<!--- 	<cfset strQuery = strQuery & "ON tblStockMaster.Partno = tblStockPriceFormula.partno ">
 --->	
 	<cfset strQuery = strQuery & "WHERE tblStockPriceFormula.PriceFormulaID = #URL.RecordID#">
 
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
	<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->		
        #PreserveSingleQuotes(strQuery)#
	</CFQUERY>

	
	<CFIF not ListFind( FormFieldList, "PriceFormulaID" )>
		<!--- <CFSET FormFieldList = ListAppend( FormFieldList, "PriceFormulaID" )> --->
	</CFIF>
			<CFSET PriceFormulaID_Value = #GetRecord.PriceFormulaID#>
            <CFSET PartNo_Value = #GetRecord.PartNo#> 
            <CFSET Description_Value = #GetRecord.Description#> 
 			<CFSET PriceFrom_Value = #GetRecord.PriceFrom#>
			<CFSET PriceTo_Value = #GetRecord.PriceTo#>
    		<CFSET MaxRetail_Value = #GetRecord.MaxRetail#>
    		<CFSET GP_Value = #GetRecord.GP#>
    		<CFSET Wholesale_Value = #GetRecord.Wholesale#>

<CFELSE>
	<!--- Check the session for any sign of the Plu --->
	<cfset strPartNo = "">
	<CFif ParameterExists(session.PriceFormulaItemID)>
		<cfif #len(session.PriceFormulaItemID)# GT 0>
			<cfset strPartNo = "#session.PriceFormulaItemID#">
		</cfif>
	</cfif> 

	<cfif #len(strPartNo)# GT 0>
    	<CFSET PartNo_Value = '#strPartNo#'> 
	<cfelse>
    	<CFSET PartNo_Value = ''> 
	</cfif>
			<CFSET PriceFormulaID_Value = ''>
            <CFSET Description_Value = ''>
			<CFSET PriceFrom_Value = 0>
			<CFSET PriceTo_Value = 0>
		    <CFSET MaxRetail_Value = 0>
    		<CFSET GP_Value = 0>
    		<CFSET Wholesale_Value = 0>

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
      <div align="right"><a href="tblStockPriceFormula_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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
<FORM action="tblStockPriceFormula_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="PriceFormulaID" value="#URL.RecordID#">
</CFIF>


            <TABLE width="550" border="1" cellpadding="2">
              <CFIF not ParameterExists(URL.RecordID)>
<!--- 
              <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Formula ID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PriceFormulaID" value="#PriceFormulaID_Value#" size="15" maxLength="4">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="PriceFormulaID_integer">
              </TR>
 --->
              <cfelse>
              <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF">ID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF">#PriceFormulaID_Value#</font>
                </TD>
              </TR>
			  </CFIF>

              <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  PLU: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PartNo" value="#PartNo_Value#" size="15" maxLength="16">
                  <INPUT type="hidden" name="PartNo_required" value="Please type the PLU">				  
                </TD>
              </TR>

  
             <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Description: </font></b></TD>
                <TD> 
                  <b><font face="Tahoma" size="4" color="FFFFFF"> 
                  #Description_Value# &nbsp; </font></b>
                </TD>
				
              </TR>

              <TR> 
                <TD valign="top" width="100"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Wholesale From: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PriceFrom" value="#PriceFrom_Value#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="PriceFrom_float" value="Please type a number">
                <INPUT type="hidden" name="PriceFrom_required" value="Please type the price from">
<!---  --->				
                <TD valign="center" align="right" width="120"><font face="Tahoma" size="4" color="FFFFFF"> 
                  Current W/S #NumberFormat(Wholesale_Value,"____.99")# &nbsp </font>
                <TD> 
				
<!--- Wholesale_Value
 --->
              </TR>

              <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Wholesale To: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PriceTo" value="#PriceTo_Value#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="PriceTo_float" value="Please type the price to">
                <INPUT type="hidden" name="PriceTo_required" value="Please type the price to">
              </TR>

               <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Max Retail: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="MaxRetail" value="#MaxRetail_Value#" size="15" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="MaxRetail_float" value="Please type the max retail">
                <INPUT type="hidden" name="MaxRetail_required" value="Please type the max retail">
              </TR>
			  
               <TR> 
                <TD valign="top" width="200"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  GP %: </font></b></TD>
                <TD> 
                  <b><font face="Tahoma" size="4" color="FFFFFF"> 
                  #NumberFormat(GP_Value,"___.99")# </font></b>
                </TD>

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

