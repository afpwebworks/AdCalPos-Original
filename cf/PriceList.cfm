
<cfset lngDeptNo = #Form.cmbDeptNo#>

<cfset strPageTitle = "Internal Price List">

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfif lngDeptNo LT 1>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressOrder)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType)<>'M')) ">
<cfelse>
	<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressOrder)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType)<>'M')  AND ((tblStockDept.DeptNo)= #lngDeptNo# ) ) ">
</cfif>
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
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
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PriceListSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="0">
		
  <CFLOOP QUERY="GetDepartments"> 
    <cfset lngDeptNo = #GetDepartments.DeptNo# >
	   <cfoutput>
          <tr> 
            <td colspan="10"><h3>#GetDepartments.Dept#</h3></td>
          </tr>
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><h4>Parent Cost</h4></td>
            <td><h4>Cost</h4></td>
            <td><h4>Depot $</h4></td>
            <td><h4>H/O $</h4></td>
            <td><h4>Wholesale</h4></td>
            <td><h4>Max Retail</h4></td>
            <td><h4>Ratio</h4></td>
            <td><h4>R. Code</h4></td>
          </tr>

		</cfoutput>
		<!--- get the lines --->
		<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, tblStockMaster.* ">
		<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
		<cfset strQuery = strQuery & "WHERE (((tblStockDept.DeptNo)=#lngDeptNo#) AND ((tblStockMaster.PCode)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType)<>'M')) ">
		<cfset strQuery = strQuery & "ORDER BY tblStockMaster.PartNo">
		
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
		<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"> --->
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

  <cfoutput query = "GetRecord">
          <tr> 
            <td><h4>#GetRecord.PartNo#&nbsp;</h4></td>
            <td><h4>#GetRecord.Description#&nbsp;</h4></td>
            <td><div align="right"><h4>#numberformat(GetRecord.ParentCost,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.Cost,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.ThreeHRebateVal,"_____.000")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.SCRebateVal,"_____.000")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.Wholesale,"_____.000")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.MaxRetail,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="right"><h4>#numberformat(GetRecord.Ratio,"_____.00")#&nbsp;</h4></div></td>
            <td><div align="center"><h4>#GetRecord.RCode#&nbsp;</h4></div></td>
          </tr>
  </cfoutput>

  </CFLOOP>

        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>

