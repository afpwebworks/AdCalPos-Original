

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
	<TITLE><cfoutput>Edit Ingredient</cfoutput></TITLE>
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
      <h1><cfoutput>Edit Ingredient</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="javascript:history.go(-1);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
 </table>
<FORM action="tblIngredient_RecordAction.cfm" method="post">
<table width="65%" border="0" align="center">
  <tr>
    <td>
      <div align="center">&nbsp; 
      <table width="100%" border="1" cellspacing="0">
   
	<cfset strQuery = "SELECT DISTINCT tblStockMaster.PartNo as ID_Field, tblStockMaster.PartNo,tblStockMaster.Description, tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit">
<cfset strQuery = strQuery & " FROM tblIngredient, (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo)">
<cfset strQuery = strQuery & " INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfset strQuery = strQuery & " WHERE tblIngredient.ingredientPLU = tblStockMaster.PartNo AND ((tblStockMaster.PluType)<>'P') ">
<cfset strQuery = strQuery & " AND tblIngredient.SalePLU = #URL.SaleID#">
<CFIF ParameterExists(URL.RecordID)>
	<cfset strQuery = strQuery & " AND tblIngredient.IngredientPLU = #URL.RecordID# ">
	
</CFIF>
<cfset strQuery = strQuery & " ORDER BY tblStockMaster.PartNo ">

<CFQUERY name="GetRecord" maxRows=1  DBTYPE="#Applic_DBTYPE#" datasource="#application.dsn#"        > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>
    
	
<CFOUTPUT query="GetRecord">
          <TABLE border="1" width="450" cellpadding="2">
            <TR> 
              <TD valign="top" width="150"><h2>Part No:</h2></TD>
              <TD width="300"> 
			  	<INPUT type="hidden" name="SaleID" value="#URL.SaleID#">
			  	<INPUT type="hidden" name="RecordID" value="#GetRecord.PartNo#">
                <div align="left"><h2>#GetRecord.PartNo# </h2><!--- <a href="tblStockGroup_RecordList.cfm?DID=#GetRecord.DeptNo#"><font color="FFFF00" face="Tahoma" size="3">Show Groups</font></a> ---></div>
              </TD>
            </TR>
            <TR> 
              <TD valign="top" width="150"><h2>Ingredient Desc</h2></TD>
              <TD width="300"> 
		  		<INPUT type="hidden" name="Description" value="#GetRecord.Description#">
                <div align="left"><h2>#GetRecord.Description#</h2></div>
              </TD>
            </TR>
            <TR> 
              <TD valign="top" width="150"><h2>Ingredient Qty</h2></TD>
              <TD width="300" valign="top"> 
			  	<input type="text" name="Quantity" value="#numberformat(GetRecord.qtyIngredient,"______.000")#" size="15" maxlength="16">
                
              </TD>
            </TR>
			<TR> 
              <TD valign="top" width="150"><h2>Supply Unit</h2></TD>
              <TD valign="top" width="300"><h2>#GetRecord.SupplyUnit# </h2></TD>
			  <INPUT type="hidden" name="Unit" value="#GetRecord.SupplyUnit#">
            </TR>
                       
          </TABLE>
          </CFOUTPUT>
  <br><br>
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">
</form>
</body>
</HTML>

