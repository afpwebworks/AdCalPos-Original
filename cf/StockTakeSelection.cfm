
<cfset strPageTitle = "Stocktake Entry Adjust">

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

<!--- Check to see if the stocktake can go ahead --->
<!--- 
Stocktake can go ahead if and only if
	EOD has been done for this store 
		Eod_PLU_CSV_Updated = yes
		EodWasteUpdated = Yes
		EodTransferUpdated = Yes
		in tblEodSummary table
 --->
<CFSET lngStoreID = #session.storeid#>
 
<!--- Check to see if the stocktake has already been applied today --->
<CFSET strStocktakeHasBeenApplied = ''>
<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE ---> 
<!--- <CF_GetStocktakeHasBeenApplied> --->
<CFINCLUDE template="GetStocktakeHasBeenApplied.cfm">



<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "WHERE (((tblStockMaster.SuppressStocktake)=0) AND ((tblStockMaster.NoLongerUsed)=0) AND ((tblStockMaster.PluType = 'M') or (tblStockMaster.PluType = 'N'))) ">
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
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<cfif (#strStocktakeHasBeenApplied# EQ 'Y')>
	<table width="100%" border="0">
	  <tr>
    	<td>
	      <div align="center">
    	    <p><h2>Please select the department</h2>
			<FORM action="StockTake_Variance.cfm" method="post">
				<select name="cmbDeptNo">
            		<option value="0" selected>All</option>
					<cfoutput query = "GetDepartments">
		    	        <option value="#GetDepartments.DeptNo#">#GetDepartments.Dept#</option>
					</cfoutput>
	        	  </select>
	    	      &nbsp; 
    	    <p>
        	  <input type="submit" name="Submit" value="  Stocktake form  ">
	        </p>
			</form>
	      </div>
    	</td>
	  </tr>
	</table>
<cfelse>
	<table width="100%" border="0">
	  <tr> 
    	<td width="7%">&nbsp;</td>
	    <td width="93%">
			<h3>You have NOT finished the stocktake for today</h3>
		</td>
	  </tr>
	  <tr> 
    	<td width="7%">&nbsp;</td>
	    <td width="93%">
			<h3>Please use the stocktake entry screen to finish the stocktake.</h3>
		</td>
	  </tr>
	</table>
</cfif>

</body>
</HTML>

