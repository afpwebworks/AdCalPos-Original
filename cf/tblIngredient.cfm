
  
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
<cfset lngDeptNo = 0>
<cfset lngStoreID = #session.storeid#>

<cfset strQuery = "Select Description from tblStockMaster ">
<cfset strQuery = strQuery & "Where PartNo = '#URL.RecordID#'" >
<CFQUERY name="GetDescription"      datasource="#application.dsn#"  maxrows="1"      > <!--- <CFQUERY name="GetStoreName"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset strPageTitle = "Add Ingredients "  >

 <!--- Get the store name --->
<!--- <cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName"      dataSource="#Applic_dataSource#" username="#Applic_USERNAME#" password="#Applic_PASSWORD#"        > <!--- <CFQUERY name="GetStoreName"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">  --->

<!--- get the Departments --->
<cfset strQuery = " SELECT tblStockDept.Dept, tblStockDept.DeptNo">
<cfset strQuery = strQuery & " FROM tblStockDept">
<!--- <cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))) ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType ='M') or (tblStockMaster.PluType ='N'))   AND ((tblStockDept.DeptNo)= #lngDeptNo# ) )  ">
</cfif> 
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept , tblStockDept.DeptNo  ">--->
<cfset strQuery = strQuery & " ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments"  datasource="#application.dsn#"     > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

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
      <h1><cfoutput>#strPageTitle# to #GetDescription.Description#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="javascript:history.go(-1);" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
 <!---  <tr> 
 	<td colspan="3"> 
      <div align="center"><h3><cfoutput>#strStoreName#</cfoutput></h3></div>
    </td>
  </tr> --->
</table>
<FORM action="tblIngredients_Action.cfm" method="post">
<table width="65%" border="0" align="center">
  <tr>
    <td>
      <div align="center">&nbsp; 
      <table width="100%" border="1" cellspacing="0">
      	<cfoutput>
       <!---  <input type="hidden" name="StoreID" value="#lngStoreID#"> --->
		<input type="hidden" name="RecordID" value="#RecordID#">
        <input type="hidden" name="employeeID" value="#session.employeeID#">
        <input type="hidden" name="cmbDeptNo" value="#lngDeptNo#">
        <input type="hidden" name="NumDepartments" value="#GetDepartments.recordcount#">
		</cfoutput>
        <cfset lngGlobalDepartment = 0 >
  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngGlobalDepartment = lngGlobalDepartment + 1 >
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	<cfoutput>
         <tr> 
            <td colspan="5"><h3>#GetDepartments.Dept#</h3></td>
         </tr>
         <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><h4>Unit</h4></td>
            <td><div align="center"><h4>Quantity</h4></div></td>
         </tr>
	</cfoutput>
	
	<cfset strQuery = "SELECT distinct tblStockMaster.PartNo, tblStockMaster.Description, tblStockMaster.SupplyUnit">
	<cfset strQuery = strQuery & " FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
	<cfset strQuery = strQuery & " WHERE ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType)<>'P') AND ((tblStockDept.DeptNo)='#lngDeptNo#') AND
tblStockMaster.SuppressStocktake = 0 and
tblStockMaster.PCode=0" >
	<cfset strQuery = strQuery & " ORDER BY tblStockMaster.PartNo">
	<CFQUERY name="GetRecord" datasource="#application.dsn#"   > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
      <cfoutput>  
	  	<input type="hidden" name="Dept_#lngGlobalDepartment#_TotalLines" value="#GetRecord.recordcount#">
	</cfoutput>
	<cfset lngGlobalRecordNumber = 0>
    <cfoutput query = "GetRecord">
  	     <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>
         <tr> 
            <td>
				<h4>#GetRecord.PartNo#&nbsp;</h4>
		        <!--- <input type="hidden" name="Dept_#lngGlobalDepartment#_txtID#lngGlobalRecordNumber#" value="#GetRecord.ID#"> --->
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_PartNo#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
			</td>			
				<!---
				<cfstoredproc procedure = "procGetIngQty" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" >

		<cfprocresult name = "qty"  > 
		<cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR 
     		value="#GetRecord.PartNo#" dbVarName = @PartNo>
	 
		<cfprocparam type = "IN" CFSQLType = CF_SQL_VARCHAR 
     		value="'#URL.RecordID#'" dbVarName = @RecordID>

	</cfstoredproc>
	--->
	<cfset strQuery = "select tblIngredient.qtyIngredient 
		from tblIngredient
		where tblIngredient.ingredientPLU=#GetRecord.PartNo#
		and tblIngredient.SalePLU='#URL.RecordID#'">
    <CFQUERY name="qty" datasource="#application.dsn#"   > 
		#PreserveSingleQuotes(strQuery)#
	</CFQUERY>
            <td>
				<h4>#GetRecord.Description#&nbsp;</h4>
			</td>
            <td>
				<div align="right"><h4>#GetRecord.SupplyUnit#&nbsp;</h4></div>
			</td>
			<cfif #qty.qtyIngredient# GT 0>
				
			<td bgcolor="blue">
				<div align="center">
				<!--<input type="text" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#" maxlength="10" size = "10" value=" #numberformat(0,"_____.000")# "></div></font>-->

				<input type="text" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#" maxlength="10" size = "10" value=" #numberformat(qty.qtyIngredient,"_____.000")# "></div></font>
		        <!--- <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_required" value="Please type quantity on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_float" value="Please type quantity on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
			 --->
			 </td>
			 <cfelse>
			 <td>
				<div align="center">
				<!--<input type="text" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#" maxlength="10" size = "10" value=" #numberformat(0,"_____.000")# "></div></font>-->

				<input type="text" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#" maxlength="10" size = "10" value=" #numberformat(qty.qtyIngredient,"_____.00000")# "></div></font>
		        <!--- <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_required" value="Please type quantity on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
		        <input type="hidden" name="Dept_#lngGlobalDepartment#_Value_Line_#lngGlobalRecordNumber#_float" value="Please type quantity on line #lngGlobalRecordNumber# of department #lngGlobalDepartment#">
			 --->
			 </td>
			</cfif>
         </tr>
	 </cfoutput>
	</CFLOOP>
    </table>
    </div>
   </td>
  </tr>
  <tr>
 	<td align="center">
		  <input type="submit" name="btnApply_OK" value="  Accept Changes ">
		  <input type="button" name="cancel" value="  Cancel " onClick="javascript:history.go(-1)" >	
	</td>
  </tr>
 </table>

</form>
</body>
</HTML>

