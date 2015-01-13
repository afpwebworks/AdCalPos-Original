
<cfset lngDeptNo = #Form.cmbDeptNo#>

<cfset strPageTitle = "Change Cost">

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE  tblStockMaster.PluType ='N' ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (tblStockMaster.PluType ='N' )  AND (tblStockDept.DeptNo = #lngDeptNo# ) ">
</cfif>

<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" ><!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
 
<cfif #GetDepartments.RecordCount# LT 1>
	<cfoutput>There are no PLU to be changed.</cfoutput>
	<cfabort>
</cfif>

<!--- get number of lines --->
<cfset strQuery = "SELECT tblStockMaster.PartNo, tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='N') AND ((tblStockMaster.NoLongerUsed)=0))">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.PluType)='N') AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockDept.DeptNo)= #lngDeptNo# ))">
</cfif>

<CFQUERY name="GetNumLines" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" ><!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetNumLines"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfif #GetNumLines.RecordCount# LT 1>
	<cfoutput>There are no PLU items to be changed.</cfoutput>
	<cfabort>
</cfif>


<cfif #GetNumLines.RecordCount# GT 0>
	<cfset lngNumRecords = #GetNumLines.RecordCount#>
<cfelse>
	<cfset lngNumRecords = 0>
</cfif>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle#</cfoutput></TITLE>
<script language="JavaScript">

<!--- <cfoutput>"Price Change options include: AutoCalculate Max Retail; Direct Entry All;"</cfoutput> --->

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
      <div align="right"><a href="CostListSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="960" border="1">

<FORM action="CostListActionEdit.cfm" method="post">
<!--- Write the number of lines here  --->
<cfoutput>
<input type="hidden" name="txtNumLines" value="#lngNumRecords#">
</cfoutput>

<cfoutput>
          <tr><td colspan="11"><h2>Price Change options include: AutoCalculate OR Direct Entry</h2></td></tr>
</cfoutput>

  <cfset lngGlobalRecordNumber = 0>		
  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
		  <tr> 
            <td colspan="11"><h3>#GetDepartments.Dept#</h3></td>
          </tr>
          <tr align="center"> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><h4>Market Cost</h4></td>
            <td><h4>WareH $</h4></td>
            <td><h4>Dist $</h4></td>
            <td><h4>Wholesale</h4></td>
			<td><h4>Suppress</h4></td>
			<td><h4>Product Type</h4></td>
            <td><h4>Max Retail</h4></td>
            <td><h4>Ratio</h4></td>
            <td><h4>Rebate Table</h4></td>
          </tr>

		</cfoutput>
		<!--- get the lines --->
		<!--- <cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, tblStockMaster.* ">
		<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockDept.DeptNo)=#lngDeptNo#) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType)='N')) ">
		<cfset strQuery = strQuery & "ORDER BY tblStockMaster.PartNo"> --->
		
		<cfset strQuery = " SELECT tblStockDept.Dept, tblStockDept.DeptNo, tblStockMaster.TypeID,   ">
		<cfset strQuery = strQuery &"tblProductTypes.TypeDescription, tblStockMaster.MaxRetail, ">
		<cfset strQuery = strQuery & " tblStockMaster.* ">
		<cfset strQuery = strQuery & " FROM tblStockGroup, tblStockMaster, tblStockDept, tblProductTypes ">
		<cfset strQuery = strQuery & " WHERE (tblStockGroup.GroupNo = tblStockMaster.GroupNo) ">
		<cfset strQuery = strQuery & " AND (tblStockGroup.DeptNo = tblStockDept.DeptNo) ">
		<cfset strQuery = strQuery & " AND (tblStockMaster.TypeID = tblProductTypes.TypeID) ">
		<cfset strQuery = strQuery & " AND ((tblStockDept.DeptNo)=#lngDeptNo#)  ">
		<cfset strQuery = strQuery & " and ((tblStockMaster.NoLongerUsed)=0) ">
		<cfset strQuery = strQuery & " AND ((tblStockMaster.PluType)='N') ">
		<cfset strQuery = strQuery & " ORDER BY tblStockMaster.PartNo ">
		
		<CFQUERY name="GetRecord" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" ><!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
		<cfset type=#GetRecord.TypeID#>
<!--- 		<cfif type is "">
			<cfset type=1>
		</cfif>
 --->		
		<cfset strQuery ="Select * from tblProductTypes ">
<!--- 		<cfset strQuery = strQuery & " WHERE TypeID <> #type# "> --->
		<CFQUERY name="GetTypes" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#" ><!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

  <cfoutput query = "GetRecord">
		  <cfset lngGlobalRecordNumber = lngGlobalRecordNumber + 1>	
  		<cfset type=#GetRecord.TypeID#>	  
         <tr> 
            <td width="70"><h4>#GetRecord.PartNo#&nbsp;</h4>
			<input type="hidden" name="txtID#lngGlobalRecordNumber#" value="#GetRecord.PartNo#">
			</td>
            <td width="250"><h4>#GetRecord.Description#&nbsp;</h4></td>
            			
			<td width="80"><input type="text" name="txtCost#lngGlobalRecordNumber#" maxlength="10" size = "5" value="#numberformat(GetRecord.Cost,"_____.00")#">

			    <!--- Validate the cost --->
				<INPUT type="hidden" name="txtCost#lngGlobalRecordNumber#_float">
			</td>
			
            <td width="80"><h4>#numberformat(GetRecord.ThreeHRebateVal,"_____.000")#&nbsp;</h4></div></td>
            <td width="80"><h4>#numberformat(GetRecord.SCRebateVal,"_____.000")#&nbsp;</h4></div></td>
						
            <!--- <td><div align="right"><h4><input type="text" name="txtWholeSale#lngGlobalRecordNumber#" maxlength="10" size = "10" value="#numberformat(GetRecord.Wholesale,"_____.000")#">&nbsp;</h4></div></td> --->
		
		<td width="80"><h4><input type="text" name="txtWholeSale#lngGlobalRecordNumber#" maxlength="10" size = "5" value="#numberformat(GetRecord.Wholesale,"_____.000")#">&nbsp;</h4></div></td>
		
		<!---15/02/04 Vishal Added ComboBox for Suppresed Order --->
<!---
 		<INPUT type="radio" name="SuppressOrder" value="1"<CFIF #SuppressOrder_Value# is 1> checked</CFIF>> Yes
		<INPUT type="radio" name="SuppressOrder" value="0"<CFIF #SuppressOrder_Value# is 0> checked</CFIF>> No
 --->	
		<cfset optionval = #GetRecord.SuppressOrder# >
		<td width="80"><select name="suporder#lngGlobalRecordNumber#">
				<cfif #optionval# EQ 0>
			 	<option value="0" selected>NO</option>
				<option value="1">YES</option>
				<cfelseif #optionval# EQ 1>
				<option value="1" selected>YES</option>
				<option value="0">NO</option>
				</cfif>
			</select>
		</td>
		<!---  <cfset typeoptionval = "" >  --->
		<td width="80">
		<select name="ID#lngGlobalRecordNumber#">
			
<!--- 				<option value="#GetRecord.TypeID#" selected>#GetRecord.TypeDescription#</option> --->
				<cfloop query="GetTypes">
				
					<cfif #Type# EQ #GetTypes.TypeID#>
						<option value="#GetTypes.TypeID#" selected>#GetTypes.TypeDescription#</option>
					<cfelse>
						<option value="#GetTypes.TypeID#" >#GetTypes.TypeDescription#</option>					
					</cfif>		
					<!--- <option value="#GetTypes.TypeID#">"#GetTypes.TypeDescription#"</option> --->
				</cfloop>
				 	
		</select>
		</td>
		<td width="80"><h4>
			<input type="hidden" name="txtMaxRetailOld#lngGlobalRecordNumber#" id="txtMaxRetailOld#lngGlobalRecordNumber#" value="#GetRecord.MaxRetail#">
			<input type="text" name="txtMaxRetail#lngGlobalRecordNumber#" maxlength="10" size = "5" value="#numberformat(GetRecord.MaxRetail,"_____.00")#">&nbsp;</h4></div></td>
		
		<!--- <td width="80"><h4>#numberformat(GetRecord.MaxRetail,"_____.00")#&nbsp;</h4></div></td> --->
        <td width="80"><h4>#numberformat(GetRecord.Ratio,"_____.00")#&nbsp;</h4></div></td>
        <td width="80"><h4>#GetRecord.RCode#&nbsp;</h4></div></td>
      </tr>
  </cfoutput>

  </CFLOOP>

    </table>
		<p></p>
		<table>
			<tr>
				<td align="left"><INPUT type="submit" name="btnEdit_OK" value="   Apply Changes   "></td>
				<td align="right"><INPUT type="submit" name="btnEdit_Cancel" value="   Cancel Changes   "></td>
			</tr>
		</table>
</form>		
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>

