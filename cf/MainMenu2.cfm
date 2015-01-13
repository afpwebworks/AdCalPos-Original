
<!---[ old security system commented out - MK ]
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
</CFIF>   ]---->

<cfset lngUserTypeID = #session.user.getUserType()# >

<cfif #isnumeric(lngUserTypeID)#>
<cfelse>
	<CFLOCATION url="frmLogin.htm">
</cfif>

<!--- Get the main menu items --->
<cfset strQuery = "SELECT qryMainMenuGroup.UserTypeID, qryMainMenuGroup.MainHeading ">
<cfset strQuery = strQuery & "FROM qryMainMenuGroup ">
<cfset strQuery = strQuery & "WHERE qryMainMenuGroup.UserTypeID = #lngUserTypeID#">

<CFQUERY  name="GetMainHeading" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<HTML>
<HEAD>
	<TITLE>Main Menu</TITLE>
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
<body bgcolor="#00006D" text="#000000" leftmargin="0" topmargin="0" onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr>
    <td width="30%">
	<a href="frmlogin.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
	<td>
      <div align="center"><font face="Tahoma" color="#FFFFFF"><b><font size="4">Main Menu</font></b></font></div>
    </td>
    <td width="30%">&nbsp; 
    </td>
  </tr>
  <cfoutput>
  <tr>
    <td width="30%">&nbsp; 
    </td>
    <td>
      <div align="center"><font face="Tahoma" color="FFFFFF"><b><font size="2">#session.storename# - #session.empfullname#</font></b></font></div>	
    </td>
    <td width="30%">&nbsp; 
    </td>
  </tr>
  </cfoutput>
</table>

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">

<table width="75%" border="0">

  <CFLOOP QUERY="GetMainHeading"> 
    <cfset strMainHeading = #GetMainHeading.MainHeading# >
	    <cfoutput>
	    <tr> 
	  	   <td>&nbsp;</td>
	  	   <td>&nbsp;</td>
		   <td>&nbsp;</td>
	    </tr>
	    <tr> 
		   <td>
	    	   <div align="left"><font face="Tahoma" color="FFFFFF"><i><b></b><font size="6">#strMainHeading#</font></b></i></font></div>
		   </td>
	  	   <td>&nbsp;</td>
		   <td>&nbsp;</td>
	    </tr>
		</cfoutput>
		<!--- get the menu items --->
		<cfset strQuery = "SELECT qryMainMenu.UserTypeID, qryMainMenu.MainHeading, qryMainMenu.TaskName, qryMainMenu.FormName, * ">
		<cfset strQuery = strQuery & "FROM qryMainMenu ">
		<cfset strQuery = strQuery & "WHERE (((qryMainMenu.UserTypeID)= #lngUserTypeID# ) AND ((qryMainMenu.MainHeading)='#strMainHeading#'))">
		<CFQUERY  name="GetMenuItems" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin">
			#PreserveSingleQuotes(strQuery)#
		</CFQUERY>
  		<cfoutput query = "GetMenuItems">
			<cfif (#GetMenuItems.CurrentRow# mod 3) EQ 1>  
	  			<tr> 
			</cfif>	
			<cfif (#GetMenuItems.CurrentRow# mod 3) EQ 1>  
					<td><div align="left"><a href="#GetMenuItems.FormName#" target="_self"><b><font size="3" color="FFFFFF" face="Tahoma">#GetMenuItems.TaskName#</font></b></a></div></td>
			<cfelseif (#GetMenuItems.CurrentRow# mod 3) EQ 2>  
<!--- 					<td><div align="center"><a href="#GetMenuItems.FormName#" target="_self"><b><font size="2" color="FFFFFF" face="Tahoma">#GetMenuItems.TaskName#</font></b></a></div></td>
 --->
					<td><div align="left"><a href="#GetMenuItems.FormName#" target="_self"><b><font size="3" color="FFFFFF" face="Tahoma">#GetMenuItems.TaskName#</font></b></a></div></td>
			<cfelse>  
<!--- 					<td><div align="right"><a href="#GetMenuItems.FormName#" target="_self"><b><font size="2" color="FFFFFF" face="Tahoma">#GetMenuItems.TaskName#</font></b></a></div></td>
 --->
					<td><div align="left"><a href="#GetMenuItems.FormName#" target="_self"><b><font size="3" color="FFFFFF" face="Tahoma">#GetMenuItems.TaskName#</font></b></a></div></td>
			</cfif>	
			<cfif ((#GetMenuItems.CurrentRow# mod 3) EQ 0) or (#GetMenuItems.CurrentRow# EQ #GetMenuItems.RecordCount#)>  
	  			</tr>
    		</cfif>
  		</cfoutput>
<!--- 
	    <tr> 
		   <td colspan="3">
	    	   <div align="center">&nbsp;</div>
		   </td>
	    </tr>
 --->
  </CFLOOP>
</table>
<!--- <p><a href="j2re-1_3_0_01-win.exe" target="_blank"><b><font size="3" color="FFFFFF" face="Tahoma">Java 2 File</font></b></a></p> --->
      </div>
    </td>
  </tr>
</table>

</BODY></HTML>
