<cfset strPageTitle = "Pay Options">
<cfset strQuery = "SELECT tblEmpPayOptions.ID , tblEmpPayOptions.ID AS ID_Field, * ">
<cfset strQuery = strQuery & "FROM tblEmpPayOptions ">
<cfset strQuery = strQuery & "ORDER BY tblEmpPayOptions.ID">
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
              <th>ID</th>
              <th>Super Rate</th>
              <th>Holiday Pay</th>
              <th>Holiday Loading</th>
              <th>Sick Leave Yr1</th>
              <th>Sick Leave</th>
              <th>Workers Comp</th>
            </tr>
          </thead>
          <tbody>
            <cfloop query="getrecord">
              <cfoutput>
                <tr>
                  <td><a href="tblEmpPayOptions_RecordActionGrid.cfm?cfgridkey=#getrecord.id#">#getrecord.id#</a></td>
                  <td>#numberformat(getrecord.SuperRate, "_____.0000")#</td>
                  <td>#numberformat(getrecord.HolidayPay, "_____.0000")#</td>
                  <td>#numberformat(getrecord.HolidayLoading, "_____.0000")#</td>
                  <td>#numberformat(getrecord.SickLeaveYr1, "_____.0000")#</td>
                  <td>#numberformat(getrecord.SickLeave, "_____.0000")#</td>
                  <td>#numberformat(getrecord.WorkersComp, "_____.0000")#</td>
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
