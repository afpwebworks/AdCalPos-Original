<cfsilent>
<!----
==========================================================================================================
Filename:     header.cfm
Description:  Header file for AdCALPos Enterprise
Date:         28/9/2010
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->

<cfparam name="request.pagename" default="">
</cfsilent>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/cf/costi.css">
<cfoutput>
<TITLE>#request.pagename#</TITLE>
</cfoutput>
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
<meta http-equiv="expires" content="mon, 01 jan 1990 00:00:01 gmt">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="cache-control" value="no-cache, no-store, must-revalidate">
<cfheader name="Expires" value="mon, 01 jan 1990 00:00:01 gmt">
<cfheader name="Pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">
</HEAD>
<body>
<cfinclude template="/cf/navbar_header_small.cfm">
<table width="100%">
  <tr>
    <td width="30%"><a href="/index.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','/images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td></td>
    <td width="30%"><cfif (cgi.SCRIPT_NAME contains "/cf/index.cfm") or (cgi.SCRIPT_NAME contains "/cf/MainMenu.cfm") >
        <div align="right"><a href="/logout.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('LogOffImage','','/images/butLogOffDown.gif',1)"><img name="LogOffImage" border="0" src="/images/butLogOffUp.gif" width="115" height="34"></a></div>
        <cfelse>
        <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() onClick="history.go(-1)"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
      </cfif></td>
  </tr>
</table>
