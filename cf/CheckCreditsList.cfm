
<cfset strPageTitle = "Credit List">
<cfset lngStoreID = #form.StoreID#>

<!--- <cfset lngDay = #Form.DF#>
<cfif #len(lngDay)# LT 2>
	<cfset lngDay = "0" & "#lngDay#">
</cfif>
<cfset lngMonth = #Form.MF#>
<cfif #len(lngMonth)# LT 2>
	<cfset lngMonth = "0" & "#lngMonth#">
</cfif>
<cfset lngYear = #Form.YF#>

<cfset lngDayTo = #Form.DT#>
<cfif #len(lngDayTo)# LT 2>
	<cfset lngDayTo = "0" & "#lngDayTo#">
</cfif>
<cfset lngMonthTo = #Form.MT#>
<cfif #len(lngMonthTo)# LT 2>
	<cfset lngMonthTo = "0" & "#lngMonthTo#">
</cfif>
<cfset lngYearTo = #Form.YT#>

<cfset lngDateFrom = #lngYear# & #lngMonth# & #lngDay#>
<cfset lngDateTo = #lngYearTo# & #lngMonthTo# & #lngDayTo#> --->

<!--- - wb 23/12/2003 - Setup dates - --->
<cfset lngDateFrom=form.sDate>
<cfset lngDateTo=form.eDate>

<cfset strQuery = "SELECT tbCreditDetail.StoreID, tbCreditDetail.Status, tbCreditDetail.CreditDate, substring([CreditDate],5,4) + substring([CreditDate],3,2) + substring([CreditDate],1,2) AS CreDate, tbCreditDetail.InvoiceID, tbCreditDetail.PartNo, tbCreditDetail.Description, tbCreditDetail.QtySupplied, tbCreditDetail.Reason, tbCreditDetail.ActionedComment ">
<cfset strQuery = strQuery & "FROM tbCreditDetail ">
<cfset strQuery = strQuery & "WHERE (((tbCreditDetail.StoreID)=#lngStoreID#) AND ((substring([CreditDate],5,4) + substring([CreditDate],3,2) + substring([CreditDate],1,2)) Between #lngDateFrom# And #lngDateTo#)) ">
<cfset strQuery = strQuery & "Order by tbCreditDetail.InvoiceID, tbCreditDetail.PartNo">
<!--- <cfoutput><BR>strQuery: #strQuery#</cfoutput> --->
<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetRecord" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
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
      <div align="right"><a href="CheckCredits.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp; 
        <table width="100%" border="1" cellspacing="0">
          <tr>  
            <td> 
              <h4 align="center">Status</h4>
            </td>
            <td> 
              <h4 align="center">Credit Date</h4>
            </td>
            <td> 
              <h4 align="center">Invoice ID</h4>
            </td>
            <td> 
              <h4 align="center">Part No</h4>
            </td>
            <td> 
              <h4 align="center">Description</h4>
            </td>
            <td> 
              <h4 align="center">Qty Supplied</h4>
            </td>
            <td> 
              <h4 align="center">Reason</h4>
            </td>
            <td> 
              <h4 align="center">Actioned Comment</h4>
            </td>
          </tr>
          <cfoutput query = "GetRecord"> 
            <tr> 
              <td>
                <h4>#GetRecord.Status#&nbsp;</h4>
              </td>
              <td>
                <h4 align="center">#GetRecord.CreDate#&nbsp;</h4>
              </td>
              <td>
                <div align="right">
                  <h4>#GetRecord.InvoiceID#&nbsp;</h4>
                </div>
              </td>
              <td>
                <div align="right">
                  <h4>#GetRecord.PartNo#&nbsp;</h4>
                </div>
              </td>
              <td>
                <div align="left">
                  <h4>#GetRecord.Description#&nbsp;</h4>
                </div>
              </td>
              <td>
                <div align="right">
                  <h4>#GetRecord.QtySupplied#&nbsp;</h4>
                </div>
              </td>
              <td>
                <div align="left">
                  <h4>#GetRecord.Reason#&nbsp;</h4>
                </div>
              </td>
              <td>
                <div align="left">
                  <h4>#GetRecord.ActionedComment#&nbsp;</h4>
                </div>
              </td>
            </tr>
          </cfoutput> 
        </table>
      </div>
    </td>
  </tr>
</table>
</body>
</HTML>
