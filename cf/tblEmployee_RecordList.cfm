<cfset strPageTitle = "Employee List">

<cfset lngUserTypeID = #session.user.getUserType()#>
<cfset lngStoreID = #session.storeid#>
<cfset strQuery = "SELECT tblEmployee.EmployeeID , tblEmployee.BundyNo , tblEmployee.Surname ,tblEmployee.GivenName, ">
<cfset strQuery = strQuery & "tblEmployee.StoreID, ">
<cfset strQuery = strQuery & "tblEmployee.Phone, ">
<cfset strQuery = strQuery & "tblEmployee.Mobile, ">
<cfset strQuery = strQuery & "tblEmployee.DateEntered, ">
<cfset strQuery = strQuery & "tblEmployee.UserTypeID, ">
<cfset strQuery = strQuery & "tblEmployee.EmployeeID AS ID_Field ">
<cfset strQuery = strQuery & "FROM tblEmployee ">
<cfif #lngUserTypeID# eq 1>
  <cfset strQuery = strQuery & "Where tblEmployee.UserTypeID <> 1 ">
  <cfset strQuery = strQuery & "ORDER BY tblEmployee.EmployeeID">
  <cfelseif #lngUserTypeID# eq 2>
  <cfset strQuery = strQuery & "WHERE (((tblEmployee.UserTypeID)<>1)) ">
  <cfset strQuery = strQuery & "ORDER BY tblEmployee.EmployeeID">
  <cfelseif (#lngUserTypeID# eq 3) or (#lngUserTypeID# eq 4) or (#lngUserTypeID# eq 5)>
  <cfset strQuery = strQuery & "WHERE (((tblEmployee.UserTypeID) > 2)) ">
  <cfset strQuery = strQuery & "ORDER BY tblEmployee.EmployeeID">
  <cfelseif (#lngUserTypeID# GTE 6)>
  <cfset strQuery = strQuery & "WHERE (tblEmployee.UserTypeID > 2) and (tblEmployee.StoreID = #lngStoreID#) ">
  <cfset strQuery = strQuery & "ORDER BY tblEmployee.EmployeeID">
</cfif>
<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>
<HTML>
<HEAD>
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
<cfinclude template="/js/jqueryaddin.cfm" >
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1><cfoutput>#strPageTitle#</cfoutput></h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td><div align="center">
        <table id="id2" class="tablesorter">
          <thead>
            <tr>
              <th>EmployeeID</th>
              <th>BundyNo</th>
              <th>StoreID</th>
              <th>GivenName</th>
              <th>Surname</th>
              <th>Phone</th>
              <th>Mobile</th>
            </tr>
          </thead>
          <tbody>
            <cfloop query="getRecord">
              <cfoutput>
                <tr>
                  <td><a href="tblEmployee_RecordActionGrid.cfm?cfgridkey=#getrecord.EmployeeID#">#getrecord.EmployeeID#</a></td>
                  <td>#getrecord.BundyNo#</td>
                  <td>#getrecord.StoreID#</td>
                  <td>#getrecord.GivenName#</td>
                  <td>#getrecord.Surname#</td>
                  <td>#getrecord.Phone#</td>
                  <td>#getrecord.Mobile#</td>
                </tr>
              </cfoutput>
            </cfloop>
          </tbody>
        </table>
      </div></td>
  </tr>
</table>
</body>
</HTML>
