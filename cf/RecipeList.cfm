
<cfset strPageTitle = "Recipe List">
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
		<CFLOCATION url="frmLogin.htm">
	</CFIF>
<CFELSE>
		<cfset session.logged ="NO">
		<cfset session.employeeID =0>
		<cfset session.empfullname = "NA">		
		<cfset session.usertype ="NONE">
		<CFLOCATION url="frmLogin.htm">
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
  </tr>
 		<td align="center"> 
      		<h1><cfoutput>#strPageTitle#</cfoutput></h1>
    	</td>
</table>
<br>
	 <cfset strQuery = "SELECT 	tblStockMaster.Description , tblStockMaster.MaxRetail, tblIngredient.SalePLU , 	SalePLUDesc=(select tblStockmaster.Description from 
		tblStockmaster 
		where tblStockmaster.partno=tblIngredient.SalePLU),tblIngredient.ingredientPLU,
		wholesale=(select tblstocklocation.LastCost
				from tblstocklocation
				where tblIngredient.ingredientPLU = tblstocklocation.partno and tblstocklocation.storeid='#session.storeid#'),
		tblIngredient.qtyIngredient, tblStockMaster.SupplyUnit 
FROM tblIngredient, tblStockGroup , tblStockMaster,tblStockDept
where tblStockGroup.GroupNo = tblStockMaster.GroupNo 
and tblStockGroup.DeptNo = tblStockDept.DeptNo  
and tblStockMaster.PartNo = tblIngredient.ingredientPLU 
and tblStockMaster.PluType<>'P'  
ORDER BY tblIngredient.SalePLU, tblIngredient.ingredientPLU ">
<CFQUERY name="GetRecord"  datasource="#application.dsn#" >  <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>
 <cfset tempSalePLU = " ">
 <cfset tempSalePLUMaxRetail=0>
 <cfset tempSalePLUDesc = " ">
 <cfset totalretail=0>
 <cfset totalwholesale=0>
 <cfset firstloop=1>
 <cfset GP = 0>
 <cfset GPP = 0>
          
<TABLE width="100%" border="1" cellpadding="2" align="center">
  <TR> 
    <TD width="8%">Sale PLU</TD>
    <TD width="20%">Desc</TD>
    <TD width="5%">Ingredient</TD>
    <TD width="20%">Desc</TD>
    <TD width="10%">Quantity</TD>
    <TD width="10%">Total Wholesale</TD>
    <TD width="10%">Retail</TD>
    <TD width="10%">GP$</TD>
    <TD width="10%">GP%</TD>
  </TR>
 
  <CFoutput query="GetRecord"> 
    <cfif firstloop is 1>
      <cfset tempSalePLU=#GetRecord.SalePLU#>
      <cfset tempSalePLUDesc = #GetRecord.SalePLUDesc#>
      <cfset firstloop=2>
	  <CFQUERY name="PLUMaxRetail"  datasource="#application.dsn#"  maxrows="1">  
        select tblstockMaster.MaxRetail
		from tblstockMaster
		where  tblstockMaster.PartNo='#GetRecord.SalePLU#' 
</CFQUERY>
 
  <TR> 
        <TD>#GetRecord.SalePLU#</TD>
        <TD>#GetRecord.SalePLUDesc#</TD>
		
		<TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		<!---  <TD align="right">#numberformat(tempSalePLUMaxRetail,"_____.00")#</TD> --->
		 <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	  </TR>
	  <TR>
	  	 <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
        <TD>#GetRecord.ingredientPLU#</TD>
        <TD>#GetRecord.Description#</TD>
        <TD>#numberformat(GetRecord.qtyIngredient,"______.000")# </TD>
        <TD align="right">#numberformat(GetRecord.wholesale*GetRecord.qtyIngredient,"___.00")#</TD>
        <cfset totalwholesale=totalwholesale+#GetRecord.wholesale#*#GetRecord.qtyIngredient#>
        <!--- <TD align="right">#numberformat(GetRecord.MaxRetail*GetRecord.qtyIngredient,"___.00")#</TD> --->
		<TD>&nbsp;</TD>
        <cfset totalretail=totalretail+#GetRecord.MaxRetail#*#GetRecord.qtyIngredient#>
		<cfset tempSalePLUMaxRetail=#PLUMaxRetail.MaxRetail#>
        <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
      </TR>
      <cfelseif tempSalePLU is #GetRecord.SalePLU# or tempSalePLUDesc is #GetRecord.SalePLUDesc#>
      <TR> 
        <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
        <TD>#GetRecord.ingredientPLU#</TD>
        <TD>#GetRecord.Description#</TD>
        <TD>#numberformat(GetRecord.qtyIngredient,"______.000")#  </TD>
        <TD align="right">#numberformat(GetRecord.wholesale*GetRecord.qtyIngredient,"___.00")#</TD>
        <cfset totalwholesale=totalwholesale+#GetRecord.wholesale#*#GetRecord.qtyIngredient#>
        <!--- <TD align="right">#numberformat(GetRecord.MaxRetail*GetRecord.qtyIngredient,"___.00")#</TD> --->
<TD>&nbsp;</TD>
        <cfset totalretail=totalretail+#GetRecord.MaxRetail#*#GetRecord.qtyIngredient#>
		<cfset tempSalePLUMaxRetail=#PLUMaxRetail.MaxRetail#>
        <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
      </TR>
	   
      <cfelseif tempSalePLU is not #GetRecord.SalePLU# or tempSalePLUDesc is not #GetRecord.SalePLUDesc#>
	  <TR> 
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD align="right"><strong>#numberformat(totalwholesale,"___.00")#</strong></TD>
     <!---  <TD align="right"><strong>#numberformat(totalretail,"___.00")#</strong></TD> --->
	 <TD align="right"><strong>#numberformat(tempSalePLUMaxRetail,"___.00")#</strong></TD>
	  <!--- <cfset GP = #totalretail#-#totalwholesale#> --->
	  <cfset GP = #tempSalePLUMaxRetail#-#totalwholesale#>
	  <TD align="right"><strong>#numberformat(GP,"___.00")#</strong></TD>
	  <cfif #tempSalePLUMaxRetail# NEQ 0>
    	<!--- <cfset GPP = 100*(#totalretail#-#totalwholesale#)/#totalretail#>  --->    
		<cfset GPP = 100*(#tempSalePLUMaxRetail#-#totalwholesale#)/#tempSalePLUMaxRetail#> 
	  </cfif>
	   <TD align="right"><strong>#numberformat(GPP,"___.00")#</strong></TD>
	  </TR>
	<!---   <tr>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <TD align="right"><strong>#numberformat(totalwholesale,"___.00")#</strong></TD> 
	  <TD align="right">#numberformat(PLUMaxRetail.MaxRetail,'__,__.00')#</TD> 
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  </tr> --->
	  <cfset GP = 0>
    <cfset GPP = 0>
	<cfset totalretail=0>
  <cfset totalwholesale=0>
  <cfset tempSalePLUMaxRetail=0>
            <TR> 
        <TD>#GetRecord.SalePLU#</TD>
        <TD>#GetRecord.SalePLUDesc#</TD>
		<CFQUERY name="PLUMaxRetail"  datasource="#application.dsn#"  maxrows="1">  
         select tblstockMaster.MaxRetail
		from tblstockMaster
		where  tblstockMaster.PartNo='#GetRecord.SalePLU#' 
</CFQUERY>
		<TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		 <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	  </TR>
	  <TR>
	  	 <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
        <TD>#GetRecord.ingredientPLU#</TD>
        <TD>#GetRecord.Description#</TD>
        <TD>#numberformat(GetRecord.qtyIngredient,"______.000")# </TD>
        <TD align="right">#numberformat(GetRecord.wholesale*GetRecord.qtyIngredient,"___.00")#</TD>
        <cfset totalwholesale=totalwholesale+#GetRecord.wholesale#*#GetRecord.qtyIngredient#>
       <!---  <TD align="right">#numberformat(GetRecord.MaxRetail*GetRecord.qtyIngredient,"___.00")#</TD> --->
 <TD>&nbsp;</TD>
        <!--- <cfset totalretail=totalretail+#GetRecord.MaxRetail#*#GetRecord.qtyIngredient#> --->
<cfset tempSalePLUMaxRetail=#PLUMaxRetail.MaxRetail#>
        <TD>&nbsp;</TD>
        <TD>&nbsp;</TD>
        <cfset tempSalePLU=#GetRecord.SalePLU#>
        <cfset tempSalePLUDesc = #GetRecord.SalePLUDesc#>
      </TR>
    </cfif>
  </CFoutput> <cfoutput> 
    <cfset GP = #tempSalePLUMaxRetail#-#totalwholesale#>
	<cfif #tempSalePLUMaxRetail# NEQ 0>
    <cfset GPP = 100*(#tempSalePLUMaxRetail#-#totalwholesale#)/#tempSalePLUMaxRetail#>
	</cfif>
    <TR> 
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD>&nbsp;</TD>
      <TD align="right"><strong>#numberformat(totalwholesale,"___.00")#</strong></TD>
      <!--- <TD align="right"><strong>#numberformat(totalretail,"___.00")#</strong></TD> --->
 <TD align="right"><strong>#numberformat(tempSalePLUMaxRetail,"___.00")#</strong></TD>

      <TD align="right"><strong>#numberformat(GP,"___.00")#</strong></TD>
      <TD align="right"><strong>#numberformat(GPP,"___.00")#</strong></TD>
	  
    </TR>
	  <!--- <tr>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <TD align="right"><strong>#numberformat(totalwholesale,"___.00")#</strong></TD>
	 <TD align="right">#numberformat(tempSalePLUMaxRetail,'__,__.00')#</TD>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  </tr> --->
	  <cfset GP = 0>
    <cfset GPP = 0>
	<cfset totalretail=0>
  <cfset totalwholesale=0>
   <cfset tempSalePLUMaxRetail=0>
  </cfoutput> 
</TABLE>
</body>
</HTML>

