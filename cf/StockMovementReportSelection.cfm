
<cfset lngStoreID = #URL.SID#>
<cfset lngFD = #URL.FD#>
<cfset lngTD = #URL.TD#>

<cfset strDateFrom = '#mid(lngFD,7,2)#' & '#mid(lngFD,5,2)#' & '#mid(lngFD,1,4)#'>
<cfset strDateTo = '#mid(lngTD,7,2)#' & '#mid(lngTD,5,2)#' & '#mid(lngTD,1,4)#'>	

<!--- Get the store name --->
<cfset strQuery = "SELECT * from tblStores" >
	<cfif lngStoreID is not "all">
	<cfset strQuery = strQuery & " where StoreID IN(#lngStoreID#)">
	</cfif>
<CFQUERY name="GetStoreDetail" datasource="#application.dsn#" > <!--- <CFQUERY name="GetStoreDetail" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- get the Departments --->
<cfset strQuery = "SELECT tblStockDept.Dept, tblStockDept.DeptNo, Count(tblStockMaster.PartNo) AS CountOfPartNo ">
<cfset strQuery = strQuery & "FROM (tblStockGroup INNER JOIN tblStockMaster ON tblStockGroup.GroupNo = tblStockMaster.GroupNo) INNER JOIN tblStockDept ON tblStockGroup.DeptNo = tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "WHERE  (tblStockMaster.PCode = 0) AND ( (tblStockMaster.PluType= 'M') or (tblStockMaster.PluType= 'N') ) ">
<cfset strQuery = strQuery & "GROUP BY tblStockDept.Dept, tblStockDept.DeptNo ">
<cfset strQuery = strQuery & "ORDER BY tblStockDept.DeptNo">

<CFQUERY name="GetDepartments" datasource="#application.dsn#" > <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetDepartments"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>
	
<cfset strPageTitle = "Stock Movement Report" >

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE><cfoutput>#strPageTitle# Selection</cfoutput></TITLE>
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
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center"> 
      <h1><cfoutput>#strPageTitle# Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</h1> </CFOUTPUT>
		
       		
	  
	  <cfif isDefined("GetStoreDetail.recordCount")>
								 
				 <CFIF lngStoreID is "all"> All Stores
				 <CFELSE>				 
					<cfif GetStoreDetail.recordCount GT 1> 
						<p><cfloop query="GetStoreDetail">
								<cfoutput>#GetStoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#GetStoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td width="25%"> 
	  <cfoutput>
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href=ReportMenu.cfm?FD=#lngFD#&TD=#lngTD#"><IMG height=34 src="/images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
  <!--- <tr valign="center"> 
 	<td colspan="3"> 
      <h1><cfoutput>Between #mid(lngFD,7,2)#/#mid(lngFD,5,2)#/#mid(lngFD,1,4)# and #mid(lngTD,7,2)#/#mid(lngTD,5,2)#/#mid(lngTD,1,4)#</CFOUTPUT></h1>
    </td>
  </tr> --->
</table>
<br>
<br>
<!--- 
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
        <p><h2>Please select the department - OLD STYLE</h2>
		 <cfoutput>
		   <FORM action="StockMovementReport.cfm?RequestTimeout=300" method="post">
			<INPUT type="HIDDEN" name="SID" value="#URL.SID#">
			<INPUT type="HIDDEN" name="FD" value="#URL.FD#">
			<INPUT type="HIDDEN" name="TD" value="#URL.TD#">
		 </cfoutput>
			<select name="cmbDeptNo">
            	<option value="0" selected>All</option>
				<cfoutput query = "GetDepartments">
	    	        <option value="#GetDepartments.DeptNo#">#GetDepartments.Dept#</option>
				</cfoutput>
	          </select>
    	      &nbsp; 
        <p>
          <input type="submit" name="Submit" value="  Stock Movement  ">
        </p>
		</form>
      </div>
    </td>
  </tr>
</table>

<br><br><br><br>
 --->
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
        <p><h2>Please select the department</h2>
		 <cfoutput>
		   <FORM action="StockMovementReport.cfm?RequestTimeout=300" method="post">
			<INPUT type="HIDDEN" name="SID" value="#URL.SID#">
			<INPUT type="HIDDEN" name="FD" value="#URL.FD#">
			<INPUT type="HIDDEN" name="TD" value="#URL.TD#">
		 </cfoutput>
			<select name="cmbDeptNo">
            	<option value="0" selected>All</option>
				<cfoutput query = "GetDepartments">
	    	        <option value="#GetDepartments.DeptNo#">#GetDepartments.Dept#</option>
				</cfoutput>
	          </select>
    	      &nbsp; 
        <p>
          <input type="submit" name="Submit" value="  Stock Movement  ">
        </p>
		</form>
      </div>
    </td>
  </tr>
</table>






</body>
</HTML>
