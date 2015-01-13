
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

<cfset lngUserType = #session.user.getUserType()# >
<cfset lngStoreID = #session.storeid#>


<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>sample</TITLE>
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
      <h1>Packing Report</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PackingReportRequest.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
	  

<!--- Get the date and validate it. --->
<cfset strDate=right(form.sDate,2)&mid(form.sDate,5,2)&left(form.sDate,4)>
<cfif len(#strDate#) EQ 7>
	<cfset strDate = "0" & "#strDate#" >
</cfif>

<CFSET strValidDate = ''>
<CF_ValidateThisDate strDateValue= "#strDate#">

<cfif strValidDate EQ "N">
<!--- 	Invalid Date --->
	<cflocation URL = "ValidDateMessage.cfm">
</cfif>

<cfif lngUserType LT 6 > 
	<!--- Write a query to select the stores that have defined an order --->
	<cfset strQuery = "SELECT tblStores.StoreName, qryPackingA.StoreID, qryPackingA.OrderDate ">
	<cfset strQuery = strQuery & "FROM tblStores INNER JOIN qryPackingA ON tblStores.StoreID = qryPackingA.StoreID ">
	<cfset strQuery = strQuery & "WHERE (((qryPackingA.OrderDate)='#strDate#')) ">
	<cfset strQuery = strQuery & "ORDER BY tblStores.StoreName">
<cfelse>
	<cfset strQuery = "SELECT tblStores.StoreName, qryPackingA.StoreID, qryPackingA.OrderDate ">
	<cfset strQuery = strQuery & "FROM tblStores INNER JOIN qryPackingA ON tblStores.StoreID = qryPackingA.StoreID ">
	<cfset strQuery = strQuery & "WHERE (qryPackingA.OrderDate = '#strDate#' ) and (qryPackingA.StoreID = #lngStoreID# ) ">
	<cfset strQuery = strQuery & "ORDER BY tblStores.StoreName">
</cfif>
	
<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStores"> --->
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<cfset lngNumStores = 1 + #GetStores.RecordCount#>

        <p><font color="#000000"><h3>Please select the store.</h3></font>
<FORM action="PackingListReport.cfm" method="post">
<cfoutput><INPUT type="hidden" name="txtOrderDate" Value = "#strDate#"></cfoutput>

          <table width="271" border="0">
            <tr> 
              <td width="90">
<h3>Store</h3></td>
              <td width="151"> <cfoutput>
<select name="txtStoreID"  size="#lngNumStores#"></cfoutput>
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
		<INPUT type="hidden" name="type" id="type">
    </td>
  </tr>
</table>
<p></P>
<input type="submit" name="frozen" value=" Show Early Order " onclick="document.getElementById('type').value=1;">
<input type="submit" name="notFrozen" value=" Show Main Order " onclick="document.getElementById('type').value=0;">
</Form>





	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

