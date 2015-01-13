
<!--- - wb 22/12/2003 - Setup calendar variables - --->
<cfinclude template="CalendarSetup2.cfm">
<cfset local.formName="frmDepotPLUReport">
<cfset local.page="DepotPLUbyDate_Select.cfm">
<CFQUERY name="qGetStores" datasource="#application.dsn#" >
SELECT s.StoreID, s.StoreName, sg.StoreGroupId, sg.StoreGroup
FROM tblStores s, tblStoreGroup sg
WHERE s.StoreGroupID=sg.StoreGroupID
ORDER BY sg.StoreGroup, s.StoreName
</CFQUERY>

<cfset strPageTitle = "Depot PLU Sales Report Date Selection">
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
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">

<table width="100%">
  <tr valign="center"> 
    <td width="25%"><A onmouseover="MM_swapImage('home','','../images/butHomeDown.gif',1)" onmouseout=MM_swapImgRestore() target=_top href="MainMenu.cfm"><IMG height=34 src="../images/butHomeUp.gif" width=114 align=top border=0 name=home></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</CFOUTPUT></h1>
    </td>
    <td width="25%"> 
      <div align="right"><A onmouseover="MM_swapImage('backImage','','../images/butBackDown.gif',1)" onmouseout=MM_swapImgRestore() href="MainMenu.cfm"><IMG height=34 src="../images/butBackUp.gif" width=115 border=0 name=backImage></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<FORM action="DepotPLUbyDate_Report.cfm?RequestTimeout=300" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>">
<table width="100%" border="0">
  <tr>
    <td align="center">
        <!--- - wb 22/12/2003 - Display calendar - --->
		<cfinclude template="CalendarDisplay2.cfm">
	    <cfset local.groupId=''>
		<p><select id="r_storeId" multiple="multiple" name="r_storeId" size="10">
			<option value=""> Please select stores </option>
			<option value="">------------------------------------------------------</option>
			<option value=""></option>
			<option value="all">All Stores</option>
			<cfloop query="qGetStores">
				<option value="<cfoutput>#qGetStores.StoreID#</cfoutput>"><cfoutput>#qGetStores.StoreName#</cfoutput></option>
			</cfloop>
		</select><br />
		<span id="selectMsg"></span></p>
		<p><input id="btnSubmit" name="btnSubmit" onclick="checkSelect();" type="button" value="Depot PLU Sales By Dept"  class="buttonWidth"></p>
<p><input id="btnSubmit" name="btnSubmit" onclick="this.form.action='DepotPLUbyDate_ProductTypes.cfm';checkSelect();" type="button" value="Depot PLU Sales By Product Types"  class="buttonWidth"></p>
<!--- 
		<CFLOCK scope="SESSION" type="READONLY" timeout="30">
		   <CFIF listFind("1,2",session.usertype)>
				<p><input id="btnSubmit" name="btnSubmit" onclick="this.form.action='DepotPLUbyDate_ReportNEW.cfm';checkSelect();" type="button" value="Depot PLU Master"  class="buttonWidth"></p>   
		   </cfif>		
		</CFLOCK>
 --->
	  </form>
	</td>
  </tr>
</table>
</body>
</HTML>

