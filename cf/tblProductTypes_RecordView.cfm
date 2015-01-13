
<cfset strPageTitle = "Product Category View">

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

<cfset strQuery = "SELECT tblProductTypes.TypeID , tblProductTypes.TypeDescription">
<cfset strQuery = strQuery & " FROM tblProductTypes ">
<CFIF ParameterExists(URL.RecordID)>
	<cfset strQuery = strQuery & "WHERE tblProductTypes.TypeID = #URL.RecordID#">
</CFIF>

<CFQUERY name="GetRecord" maxRows=1      datasource="#application.dsn#"  > 
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
      <div align="right"><a href="tblProductTypes_ProductCat.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
	  <cfoutput>
<FORM action="tblProductTypes_RecordAction.cfm" method="post">
	<INPUT type="hidden" name="RecordID" value="#GetRecord.TypeID#">

<table width="100%" border="0">
  <tr>
    <td> 
      <div align="center">
        <table width="65%" border="0">
          <tr>
            <td>
              <div align="center">
	          <INPUT type="submit" name="btnView_Add" value="   Add    ">
	          <INPUT type="submit" name="btnView_Edit" value="  Edit  ">
	          <INPUT type="submit" name="btnView_Delete" value="  Delete  ">
			  </div>
            </td>
            <td>
              <div align="center">
	          <INPUT type="submit" name="btnView_First" value="<< First">
	          <INPUT type="submit" name="btnView_Previous" value="< Prev">
	          <INPUT type="submit" name="btnView_Next" value="Next >">
	          <INPUT type="submit" name="btnView_Last" value="Last >>">
			  </div>
            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
</FORM>
</cfoutput>
<CFOUTPUT query="GetRecord">
          <TABLE border="1" width="300" cellpadding="2" align="center">
         <TR> 
              <TD valign="top" ><h2>Category ID:</h2></TD>
              <TD> 
                <div align="left"><h2>#GetRecord.TypeID#</h2>
              </TD>
            </TR>

            <TR> 
              <TD valign="top" ><h2>Category:</h2></TD>
              <TD> 
                <div align="left"><h2>#GetRecord.TypeDescription#</h2>
              </TD>
            </TR>
          </TABLE>
          </CFOUTPUT>
	      </td>
  </tr>
</table>
</body>
</HTML>

