
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmClearTables">
<cfset local.page="ClearTables.cfm">

<cfset lngToday = #DayOfWeek(now())#>
<cfif #lngToday# eq 1>
	<cfset lngD1 = 6>
<cfelseif #lngToday# eq 2>
	<cfset lngD1 = 5>
<cfelseif #lngToday# eq 3>
	<cfset lngD1 = 4>
<cfelseif #lngToday# eq 4>
	<cfset lngD1 = 3>
<cfelseif #lngToday# eq 5>
	<cfset lngD1 = 2>
<cfelseif #lngToday# eq 6>
	<cfset lngD1 = 1>
<cfelseif #lngToday# eq 7>
	<cfset lngD1 = 0>
</cfif>
<cfset dd1 = #dateadd('d',lngD1,now())#>


<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
	<TITLE>Clear Tables</TITLE>
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
<!--- - wb 12/12/2003 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Clear Tables</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="ClearTablesAction.cfm" id="frmClearTables" method="post" name="frmClearTables" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<!--- - wb 22/12/2003 - Display calendar - --->
<cfinclude template="CalendarDisplay2.cfm">
<br />
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<!--- Write a query to select the stores that have defined an order --->
<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName, tblStores.NoLongerUsed ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE (((tblStores.NoLongerUsed)=0)) ">
<cfset strQuery = strQuery & "ORDER BY tblStores.StoreName">

<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStores"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngNumStores = 1 + #GetStores.RecordCount#>

        <p><font color="#000000"><h3>Please select the store.</h3></font>
          <table width="271" border="0">
            <tr> 
              <td width="90">
<h3>Store</h3></td>
              <td width="151"> <cfoutput>
<!--- <select name="txtStoreID"  size="#lngNumStores#"></cfoutput> --->
<select name="txtStoreID"  size="10"></cfoutput>
			<cfset lngIndex = 0>
			<cfoutput Query = "GetStores">
				<cfset lngIndex = lngIndex + 1>
			    <cfif lngIndex EQ 1>
					<option value="#GetStores.StoreID#" selected>#GetStores.StoreName#</option>
				<cfelse>
					<option value="#GetStores.StoreID#">#GetStores.StoreName#</option>
				</cfif>
			</cfoutput>
		</select>
        <!--- field validation --->
        <INPUT type="hidden" name="txtStoreID_integer">
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
<p></P>
<table align="center">
	<tr>
		<th><td align="center"><input type="submit" name="tblStore_CashInDraw" value="Cash in Draw"></td></th>
		<th><td align="center"><input type="submit" name="tblStore_ECRTotals" value="ECR Totals"></td></th>
		<th><td align="center"><input type="submit" name="tblStore_OperatorTotals" value="Operator Totals"></td></th>
		<th><td align="center"><input type="submit" name="tblStore_PLUTotals" value="PLU Totals"></td></th>
		<th><td align="center"><input type="submit" name="tblStore_StockHistory" value="Stock History" /></td></th>
		<th><td align="center"><input type="submit" name="tblStore_Other" value="Other"></td></th>
	</tr>
</table>
</Form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

