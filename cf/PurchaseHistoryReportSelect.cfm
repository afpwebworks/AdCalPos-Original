
<cfsetting enablecfoutputonly="yes">
<!--- - wb 04/02/2004 - Setup page title - --->
<cfset local.pageTitle="Purchase History Report">
<!--- - wb 04/02/2004 - Setup calendar variables - --->
<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmPurchaseHistoryReport">
<cfset local.page="PurchaseHistoryReportSelect.cfm">
<!--- - wb 27/02/2004 - get the store names - ---->
<!--- <CFQUERY name="qGetStoreNames" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  > 
SELECT DISTINCT StoreID, StoreName
FROM tblStores
</CFQUERY> --->

<CFQUERY name="GetStores" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  >  
SELECT s.StoreID, s.StoreName, sg.StoreGroupId, sg.StoreGroup
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
ORDER BY s.StoreName
</CFQUERY>
<CFQUERY name="GetCurrentStore" dataSource="#Applic_dataSource#" USERNAME="#Applic_USERNAME#" PASSWORD="#Applic_PASSWORD#"  >  
SELECT s.StoreName
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
AND s.StoreID=#Session.StoreID#

</CFQUERY>
<cfset lngUserType = #session.user.getUserType()# >
<cfset strPageTitle = "Purchase History Report">

<cfsetting enablecfoutputonly="no">
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HTML><HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<link rel="stylesheet" type="text/css" href="css/calendar.css">
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
<script language="JavaScript1.2" src="../js/validation.js" type="text/javascript"></script>
<script language="JavaScript1.2" src="../js/change_calendar2.js" type="text/javascript"></script>
<script language="JavaScript1.2" type="text/javascript">
function checkSelect(){
	var f=document.<cfoutput>#local.formName#</cfoutput>;
	document.all.selectMsg.innerHTML="";
	if(f.r_storeId.options.value == null || f.r_storeId.options.value == ""){
		document.all.selectMsg.innerHTML="Please select a store";
	}
	else{
		var r=submitCheck('<cfoutput>#local.formName#</cfoutput>');
		if(r==true) f.submit();
	}
}
</script>
<!--- - wb 12/12/2003 - calendar error checking scripts - --->
<script language="JavaScript1.2" src="../js/calendar_check2.js" type="text/javascript"></script>
</HEAD>


<body>

<cfinclude template="navbar_header_small.cfm">

<table width="100%">
  <tr valign="top"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td align="center"><h1><cfoutput>#local.pageTitle#</cfoutput></h1></td>
    <td width="25%"> 
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>

<FORM action="PurchaseHistoryReport.cfm" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<table align="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><!--- - WB 09/01/2004 - Display calendars - --->
			<cfinclude template="CalendarDisplay2.cfm">
		</td>
	</tr>
	<tr><td><img src="../images/s.gif" width="1" height="5" alt="spacer" border="0" /></td></tr>
	<!--- <tr>
		<td align="center">
			<!--- <select id="r_storeId" name="r_storeId">
			 <option value=""> Please select a store</option>
			<cfloop query="qGetStoreNames">
			 <option value="<cfoutput>#qGetStoreNames.StoreID#</cfoutput>"><cfoutput>#qGetStoreNames.StoreName#</cfoutput></option>
			</cfloop>
			</select> --->
		<p><select id="r_storeId" multiple="multiple" name="r_storeId" size="10">
			<option value=""> Please select stores </option>
			<option value="">------------------------------------------------------</option>
			<option value=""></option>
			<option value="all">All Stores</option>
			<cfloop query="GetStores">
				<option value="<cfoutput>#GetStores.StoreID#</cfoutput>"><cfoutput>#GetStores.StoreName#</cfoutput></option>
			</cfloop>
		</select><br />
		<span id="selectMsg"></span></p>
						
		<p><input id="btnSubmit" name="btnSubmit" onclick="checkSelect();" type="button" value="Purchase History Report"  class="buttonWidth"></p>
			
	  </td>
	</tr> --->
	<table width="100%" border="0">
  <tr>
    <td align="center">
      		
		<cfif #lngUserType# GE 1 AND #lngUserType# LE 4>
			<cfoutput><select name="r_storeId" multiple="multiple" size="5"></cfoutput>
			<option value="all" selected>All Stores</option>
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
			<p><input id="btnSubmit" name="btnSubmit" onclick="checkSelect();" type="button" value="Purchase History Report"  class="buttonWidth"></p>
		<cfelseif #lngUserType# GT 4>  
			
			<cfoutput><select name="r_storeId" size="1"></cfoutput>
			<cfoutput Query = "GetCurrentStore">
				<option value="#Session.StoreID#" selected>#GetCurrentStore.StoreName#</option>
			</cfoutput>
						</select>
						<span id="selectMsg"></span></p>
						<p><input id="btnSubmit" name="btnSubmit" onclick="checkSelect();" type="button" value="Purchase History Report"  class="buttonWidth"></p>
						
			
		</cfif>
	</td>
  </tr>	
  </table>
</table>
</form>
</body>
</html>
