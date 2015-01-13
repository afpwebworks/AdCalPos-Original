<cfset strPageTitle = "Security Tasks - Assign Employees to Stores">
<cfscript>
UsersDAO = application.beanfactory.getbean("UsersDAO");
StoresDAO =  application.beanfactory.getbean("StoresDAO");
Employee = application.beanfactory.getBean("User");
</cfscript>
<!--- 
TaskID
TaskFormID
UserType
 --->
<cfif isdefined("form") and StructKeyExists(form,"Submit")>
	<!---[   If the employee has no stores, form.storeid is not defined. So set a value in that case   ]---->
	<cfparam name="form.storeID" default="" />
	<cfscript>
        Employee.setEmployeeID(  form.EmployeeID  );
        Employee.setUserID(  form.EmployeeID  );
        // get the current details for this employee
        UsersDAO.read( employee );
        //set the stores to the ones submitted on the form
        Employee.setStoresToSee( form.StoreID  );
        //now persist it to the database
        UsersDAO.save( employee );
    </cfscript>
	<cflocation addtoken="no" url="/cf/tblEmployee_storesList.cfm" />
	<cfabort />
</cfif>

<cfscript>
	AllStores = StoresDAO.getAllStores();
	UserStores = UsersDAO.getstoresforEmployee( url.cfgridkey  );
	Employee.setEmployeeID( url.cfgridkey );
	UsersDAO.read(  Employee );
</cfscript>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<TITLE>
<cfoutput>#strPageTitle#</cfoutput>
</TITLE>
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
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle">
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1>
        <cfoutput>#strPageTitle#</cfoutput>
      </h1></td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<cfoutput>
<div align="center">
<h3>Employee: #url.cfgridkey# - #employee.getempfullname()#</h3>
<table border="0">
  <tr>
    <td><FORM ACTION="#cgi.SCRIPT_NAME#" NAME = "Employee_StoresAssignAction" METHOD="post" >
        <cfloop query="AllStores">
        <input type="checkbox" name="StoreID" id="StoreID" <cfif listFind(UserStores,AllStores.StoreID)>checked="checked"</cfif> value="#allstores.StoreID#" >
        #allstores.storegroup# - #allstores.storename#<br />
        </cfloop>
        <br />
        <input type="hidden" name="EmployeeID" value="#Employee.getEmployeeID()#" />
        <input type="submit" name="Submit" value="Submit" />
      </FORM>
  </div>
  
  </td>
  
  </tr>
  
</table>
</div>
</cfoutput>
</body>
</HTML>
