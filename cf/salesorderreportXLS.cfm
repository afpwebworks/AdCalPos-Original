<cfsilent>
<!----
==========================================================================================================
Filename:     salesOrderReportXLS.cfm
Description:  Exports an existing Sales Report to a XLS Spreadsheet file
Date:         27/8/2012
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfsetting requesttimeout="1500" />
<cfscript>
	strPageTitle="Export Sales Report to Spreadsheet";
	//Set up for Excel Spreadsheet export  
	//destinationdir = application.approotabs & '\workingdir\' ;
	//destinationFileName = 'report.xls' ;
	//destinationfile = destinationdir & destinationFileName;
</cfscript>

 <cfinclude template="/cf/includes/SalesReport/SalesReport_PrepareData.cfm" /> 
</cfsilent>

<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="/css/adcalposnet.css">
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
    <td width><A onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td align="center" width="*"> 
      <h1><cfoutput>#strPageTitle# for dates included #dateformat(Startdate, "d / mmm / yyyy")# to #dateformat(Enddate, "d / mmm / yyyy")#</h1> </CFOUTPUT>
	  
	  <cfif isDefined("StoreDetail.recordCount")>
								 
				 <CFIF listfindNoCase(StoreID, "all")> All Stores
				 <CFELSE>				 
					<cfif StoreDetail.recordCount GT 1> 
						<p><cfloop query="StoreDetail">
								<cfoutput>#StoreDetail.StoreName# &nbsp;</cfoutput>
						</cfloop></p>
					<cfelse>
						<cfoutput>#StoreDetail.StoreName#</cfoutput>
					</cfif>
			     </cfif>
		</cfif>
			
    </td>
    <td> 
	  <cfoutput>
      <div align="right"><A onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="ReportMenu.cfm?FD=#url.FD#&TD=#url.TD#"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
	  </cfoutput>
    </td>
  </tr>
</table>

<cfinclude template="/cf/includes/SalesReport/SalesReport_CreateSpreadsheet.cfm" />

