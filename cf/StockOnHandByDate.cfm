
<cfset lngStoreID = #form.lngStoreID#>
<cfset local.startDate=createDate(left(form.sDate,4),mid(form.sDate,5,2),mid(form.sDate,7,2))>
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

<cfset lngSelectedDeptNo = #Form.cmbDeptNo#>
<cfset lngDeptNo = #Form.cmbDeptNo#>

<cfset strPageTitle = "Stock on Hand for #dateFormat(local.startDate,"dd/mm/yyyy")#">

<!--- Get the store name --->
<cfset strQuery = "Select * from tblStores ">
<cfset strQuery = strQuery & "Where StoreID = #lngStoreID#">
<CFQUERY name="GetStoreName" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStoreName" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
<cfset strStoreName = "#GetStoreName.StoreName#">

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
      <div align="right"><a href="StockOnHandDateSelection.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
  <tr> 
 	<td colspan="3"> 
      <div align="center"><h3><cfoutput>#strStoreName#</cfoutput></h3></div>
    </td>
  </tr>
</table>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="1">

 
 	   <cfoutput>
          <tr> 
            <td><h4>Plu</h4></td>
            <td><h4>Description</h4></td>
            <td><div align="right"><h4>On Hand</h4></div></td>
            <td><div align="right"><h4>Unit</h4></div></td>
            <td><div align="right"><h4>Last Paid</h4></div></td>
            <td><div align="right"><h4>Value</h4></div></td>
          </tr>

		</cfoutput>
	
		<!--- get the lines --->
		 
		<cfset strQuery = "SELECT    tblStockMaster.SupplyUnit ,tblStockMaster.Description, tblStockDept.Dept, ">
		<cfset strQuery = strQuery & "tblStockDept.DeptNo, ">
		<cfset strQuery = strQuery & "qryStockEnding.ClosingStock * qryStockEnding.Wholesale AS Cost, ">
		<cfset strQuery = strQuery & "qryStockEnding.PartNo, qryStockEnding.ClosingStock, qryStockEnding.Wholesale ">
		<cfset strQuery = strQuery & "FROM tblStockGroup INNER JOIN tblStockDept ON ">
		<cfset strQuery = strQuery & "tblStockGroup.DeptNo = tblStockDept.DeptNo INNER JOIN ">
		<cfset strQuery = strQuery & "tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo ">
		<cfset strQuery = strQuery & "RIGHT OUTER JOIN qryStockEnding ON tblStockMaster.PartNo = qryStockEnding.PartNo ">
		<cfset strQuery = strQuery & "WHERE (qryStockEnding.StoreID = #form.lngStoreID#) AND ">
		<cfset strQuery = strQuery & "(qryStockEnding.lngDate = #dateFormat(local.startDate,"yyyymmdd")#) ">
		<cfif #lngDeptNo# NEQ 0 >
			<cfset strQuery = strQuery & "AND ((tblStockDept.DeptNo)=#lngDeptNo#) ">
		</cfif>
		<cfset strQuery = strQuery & "AND (dbo.tblStockMaster.PCode = 0) ">
		<cfset strQuery = strQuery & "and qryStockEnding.ClosingStock <> 0 ">
		<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo,tblStockMaster.Description ">		
		<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>

		
		
	<CFOUTPUT> 		  
		  <cfset dblTotalValue = 0>
		  <cfset dblTotalQty = 0>
		  <cfset dblMyGrandTotalValue = 0>
		  <cfset CurrentDept = 0>
		  <cfset CurrentDeptName = " ">
		  <cfset CheckFirst = "Yes">

		  <cfloop query = "GetRecord">
			<cfif CurrentDept IS NOT DeptNo>
				<cfif CheckFirst is "Yes">
					<cfset CheckFirst = "No">
				<cfelse>
					<tr bgcolor="black">
						<td colspan="2">Total #CurrentDeptName#</td>
						<td align="right"> #numberformat(dblTotalQty,"________.000")# </td>
						<td colspan="2">&nbsp;</td>
						<td align="right">#numberformat(dblTotalValue,"________.00")#</td>
					</tr>
				</cfif>
				<tr>
					<td colspan="6">#Dept#</td>
				</tr>

				<cfset dblTotalValue = 0>
		  	    <cfset dblTotalQty = 0>
				<cfset	CurrentDept = Deptno>
				<cfset	CurrentDeptName = Dept>
				
			</cfif>		  
			
			  <cfset dblTotalValue = #dblTotalValue# + #GetRecord.Cost# >
			  <cfset dblTotalQty = #dblTotalQty# + #GetRecord.ClosingStock#>
			  <cfset dblMyGrandTotalValue = #dblMyGrandTotalValue# + #GetRecord.Cost# >		  
			  
	          <tr> 
	            <td><h4>#GetRecord.PartNo#&nbsp;</h4></td>
	            <td><h4>#GetRecord.Description#&nbsp;</h4></td>
	             <td><div align="right"><h4> #numberformat(GetRecord.ClosingStock,"_________.000")#&nbsp; </h4></div></td> 
	            <td><div align="right"><h4>#GetRecord.SupplyUnit#&nbsp;</h4></div></td>
	            <td><div align="right"><h4>#numberformat(GetRecord.Wholesale,"$_________.00")#&nbsp;</h4></div></td>
	            <td><div align="right"><h4>#numberformat(GetRecord.Cost,"$_________.00")#&nbsp;</h4></div></td>
	          </tr>
 			
		</cfloop>
		<tr bgcolor="black">
			<td colspan="2">Total #CurrentDeptName#</td>
			<td align="right"> #numberformat(dblTotalQty,"________.000")# </td>
			<td colspan="2">&nbsp;</td>
			<td align="right">#numberformat(dblTotalValue,"________.00")#</td>
		</tr>

		<tr bgcolor="black">
			<td colspan="2">Grand Total</td>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
			<td align="right">#numberformat(dblMyGrandTotalValue,"________.00")#</td>
		</tr>
		
		
	</CFOUTPUT> 	
         </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>

