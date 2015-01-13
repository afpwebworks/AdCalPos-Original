
<cfset strPageTitle = "Payment (1 / 3)">
<cfset lngUserType = #session.user.getUserType()# >
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

<!--- Write a query to select the stores that have defined an order --->
<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE (((tblStores.StoreID)<>1) AND ((tblStores.NoLongerUsed)=0)) ">
<cfset strQuery = strQuery & "ORDER BY tblStores.StoreName">

<CFQUERY name="GetStores"  datasource="#application.dsn#" >  <!--- <CFQUERY name="GetStores"      dataSource="#AppCostiDB1#"       USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>


	<cfset strQuery = "SELECT s.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores s, tblStoreGroup sg ">
	<cfset strQuery = strQuery & "WHERE s.StoreGroupID=sg.StoreGroupID ">
	<cfset strQuery = strQuery & "AND s.StoreID=#Session.StoreID# ">
	
	<CFQUERY name="GetCurrentStore" datasource="#application.dsn#" > #PreserveSingleQuotes(strQuery)#
	</CFQUERY>
		
<cfset lngNumStores = 1 + #GetStores.RecordCount#>

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
  <tr valign="center"> 
    <td width="25%"><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="MainMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="PaymentB.cfm" method="post">
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
      <TABLE>
        <TR>
          <TD>
            <P align=right>Payment Type: </P></TD>
          <TD>
			<select name="PaymentType" size="4">
			    <option value="Check" selected>Check</option>
			    <option value="Credit Card">Credit Card</option>
			    <option value="Direct Deposit">Direct Deposit</option>
			</select>	
			<input type="hidden" name="PaymentType_required" value="Please select payment type">		
		  </TD>
        </TR>				  
        <TR>
          <TD>
            <P align=right>Store: </P>
		  </TD>
          <!--- <TD>
			<cfoutput><select name="StoreID"  size="#lngNumStores#"></cfoutput>
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
			<input type="hidden" name="StoreID_integer" value="Please select store">
			<input type="hidden" name="StoreID_required" value="Please select store">		
		  </TD> --->
		  <TD>
		  	<cfif #lngUserType# GE 1 AND #lngUserType# LT 6>
				<cfoutput>
					<select name="StoreID" size="5">
				</cfoutput>
				<cfset lngIndex = 0>
				<cfoutput Query = "GetStores">
					<cfset lngIndex = lngIndex + 1>
					<cfif lngIndex EQ 1>
						<option value="#GetStores.StoreID#" >#GetStores.StoreName#</option>
					<cfelse>
					<option value="#GetStores.StoreID#">#GetStores.StoreName#</option>
					</cfif>
				</cfoutput>
				</select>
				<span id="selectMsg"></span></p>
			<cfelseif #lngUserType# GE 6 and #lngUserType# LE 9> 
				<cfoutput><select name="StoreID"  size="1"></cfoutput>
				<cfoutput Query = "GetCurrentStore">
					<option value="#Session.StoreID#" selected>#GetCurrentStore.StoreName#</option>
				</cfoutput>
				</select>
				<input type="hidden" name="StoreID_integer" value="Please select store">
				<input type="hidden" name="StoreID_required" value="Please select store">
			</cfif>
		</td>
		</TR>
		<TR>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		</TR>
		<TR>
    		<td colspan="2"> 
      			<div align="center"><input type="submit" name="Submit" value="  Next  "></div>
    		</td>
		</TR>
	  </TABLE>
	  <p>&nbsp;</p>
	
	  </div>
    </td>
  </tr>
</table>
</form>
</body>
</HTML>

