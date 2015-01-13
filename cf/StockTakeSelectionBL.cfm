
<cfset strPageTitle = "Stocktake Entry">

<CFIF ParameterExists(URL.sid)>
	<cfset lngStoreID = #URL.sid#>
	<cfset lngEmployeeID = #URL.eid#>	
<cfelse>
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
	<cfset lngStoreID = #session.storeid#>
	<cfset lngEmployeeID = #session.employeeID#>		
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
 
<CFSET strStocktakeGoAhead = ''>
<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE ---> 
<!--- <CF_GetStocktakeGoAhead> --->
<CFINCLUDE template="GetStocktakeGoAhead.cfm">

<!--- Check to see if the stocktake has already been applied today --->
<CFSET strStocktakeHasBeenApplied = ''>
<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE ---> 
<!--- <CF_GetStocktakeHasBeenApplied> --->
<CFINCLUDE template="GetStocktakeHasBeenApplied.cfm">


<!--- Check to see if the stocktake has any not posted value --->
<CFSET strStocktakeHasData = ''>

<!--- KF amendment 111203, CF_ can't pass in variables, use CFINCLUDE ---> 
<!--- <CF_GetStocktakeHasData> --->
<CFINCLUDE template="GetStocktakeHasData.cfm">
<!--- 
<cfoutput><BR>strStocktakeGoAhead: #strStocktakeGoAhead#</cfoutput>
<cfoutput><BR>strStocktakeHasBeenApplied: #strStocktakeHasBeenApplied#</cfoutput>
<cfabort>
 --->

<!--- If the store has not applied the initial stock take then do not check for any condition --->
<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StartingStockEntered ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE (((tblStores.StoreID)=#lngStoreID#) AND ((tblStores.StartingStockEntered)=0 Or (tblStores.StartingStockEntered) Is Null))">
<CFQUERY name="CheckInititalStocktake" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strInitialStockTake = 'N'>
<cfif #CheckInititalStocktake.RecordCount# GT 0>
	<cfset strInitialStockTake = 'Y'>
	<cfset strStocktakeGoAhead = 'Y'>
</cfif>

<!--- <cfoutput><br>#strStocktakeHasBeenApplied#</cfoutput> --->

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
<cfif (#strStocktakeGoAhead# EQ 'Y') and (#strStocktakeHasBeenApplied# EQ 'N')>
    <cfif strInitialStockTake EQ 'N'>
		<cfif (#strStocktakeHasData# EQ 'N')>
			<!--- clear the old stocktake values on the location table.  There is not any valid data in them --->
	  	    <cfset strQuery = "UPDATE tblStockLocation SET Freezer_QtyOnHand = 0, CoolRoom_QtyOnHand = 0, Display_QtyOnHand = 0 ">
	        <cfset strQuery = strQuery & "WHERE (((StoreID)= #lngStoreID# ) AND ((Freezer_QtyOnHand) Is Null)) OR (((StoreID)= #lngStoreID# ) AND ((Freezer_QtyOnHand)<>0)) OR (((StoreID)= #lngStoreID# ) AND ((CoolRoom_QtyOnHand) Is Null)) OR (((StoreID)= #lngStoreID# ) AND ((CoolRoom_QtyOnHand)<>0)) OR (((StoreID)= #lngStoreID# ) AND ((Display_QtyOnHand) Is Null)) OR (((StoreID)= #lngStoreID# ) AND ((Display_QtyOnHand)<>0))">
			<CFQUERY name="DeleteOldData" datasource="#application.dsn#" > 
			<!--- <CFQUERY name="DeleteOldData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
	  	    <cfset strQuery = "UPDATE tblStockLocation SET ProcessedStockTake = 0 ">
	        <cfset strQuery = strQuery & "WHERE (StoreID = #lngStoreID#)">
			<CFQUERY name="DeleteOldData2" datasource="#application.dsn#" > 
				#PreserveSingleQuotes(strQuery)#
			</CFQUERY>
		</cfif>
	</cfif>

	<table width="100%" border="0">
	  <tr>
    	<td>
	      <div align="center">
    	    <p><h2>Please select the department</h2>
			<FORM action="StockTakeBL_Act.cfm" method="post">
		        <cfoutput>
		        <input type="hidden" name="StoreID" value="#lngStoreID#">
		        <input type="hidden" name="lngEmployeeID" value="#lngEmployeeID#">				
				</cfoutput>
			
				<select name="cmbDeptNo">
            		<!--- <option value="0" selected>All</option> --->
					<cfoutput query = "GetDepartments">
		    	        <option value="#GetDepartments.DeptNo#">#GetDepartments.Dept#</option>
					</cfoutput>
	        	  </select>
	    	      &nbsp; 
    	    <p>
        	  <input type="submit" name="Submit" value="  Enter Stocktake  ">
	        </p>
    	    <p>&nbsp;</p>
    	    <p>&nbsp;</p>
    	    <p>
	          <input type="submit" name="btnApply_OK" value="Accept & Finish All Departments">
	        </p>
			
			</form>
	      </div>
    	</td>
	  </tr>
	</table>
<cfelseif (#strStocktakeGoAhead# EQ 'Y') and (#strStocktakeHasBeenApplied# EQ 'Y')>
<table width="100%" border="0">
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h3>You have already accepted the stocktake figures for today</h3>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h3>Please use the stocktake adjustment screen to adjust the values.</h3>
	</td>
  </tr>
</table>
<cfelse>
<table width="100%" border="0">
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h3>To perform the stocktake the following conditions must be met:</h3>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h4> A) End of day must have finished</h4>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h4> B) Plu file must have been updated with the information from POS</h4>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h4> C) Transfers must have been applied</h4>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<h4> D) Wastage must have been applied</h4>
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		&nbsp;
	</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">
		<br><h3>Unfortunately some of these conditions are not met and you can not perform the stocktake.</h3>
	</td>
  </tr>
</table>
</cfif>
</body>
</HTML>

