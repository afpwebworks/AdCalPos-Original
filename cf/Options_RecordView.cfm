<!---[   Added tblOptions.UpdateStockMaster and tblOptions.UpdateStockLocation fields to tblOptions and added processing code to this file.  MK  10/7/2010   ]---->
<cfset strPageTitle = "Options">

<!---[   <!----[ comment out old security access check  - MK  ]   
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
   ]---->
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
      <div align="right"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;

<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#"  >  
<!--- <CFQUERY  name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	SELECT tblOptions.OptionID AS ViewField1, tblOptions.CutOffTime AS ViewField2, tblOptions.Comments AS ViewField3, tblOptions.Comments2 AS ViewField4, tblOptions.Comments3 AS ViewField5, tblOptions.Comments4 AS ViewField6, tblOptions.Comments5 AS ViewField7, tblOptions.DaysToMakeACredit AS ViewField8, FranchiseFeePercentage, MarketingFeePercentage,  tblOptions.OptionID AS ID_Field, tblOptions.GPPriceList,tblOptions.clearancedays,tblOptions.UpdateStockmaster, tblOptions.UpdateStocklocation 
	FROM tblOptions
	<CFIF ParameterExists(URL.RecordID)>
	WHERE tblOptions.OptionID = #URL.RecordID#
	</CFIF>
</CFQUERY>

<CFOUTPUT query="GetRecord">

<FORM action="Options_RecordAction.cfm" method="post">
	<INPUT type="hidden" name="RecordID" value="#ID_Field#">

	<!--- form buttons --->
<!--- 
	<INPUT type="submit" name="btnView_First" value=" << ">
	<INPUT type="submit" name="btnView_Previous" value="  <  ">
	<INPUT type="submit" name="btnView_Next" value="  >  ">
	<INPUT type="submit" name="btnView_Last" value=" >> ">
	<INPUT type="submit" name="btnView_Add" value="   Add    ">
 --->	
    <INPUT type="submit" name="btnView_Edit" value="  Edit  ">
	<!--- <INPUT type="submit" name="btnView_Delete" value="Delete"> --->

</FORM>


<TABLE BORDER="1" WIDTH="750">

<!--- 	<TR>
	<TD valign="top"> Option ID: </TD>
	<TD> #ViewField1# </TD>
	</TR>
 --->
	<TR>
	<TD valign="top"> Ordering Cut Off Time: </TD>
	<TD> #ViewField2#&nbsp; </TD>
	</TR>
	
	<TR>
	<TD valign="top"> Comments: </TD>
	<TD> #replace(ViewField3,"/:/","","ALL")#&nbsp; </TD>
	</TR>

	<TR>
	<TD valign="top"> Comments 2: </TD>
	<TD> #replace(ViewField4,"/:/","","ALL")#&nbsp; </TD>
	</TR>
	<TR>
	<TD valign="top"> Comments 3: </TD>
	<TD> #replace(ViewField5,"/:/","","ALL")#&nbsp; </TD>
	</TR>
	<TR>
	<TD valign="top"> Comments 4: </TD>
	<TD> #replace(ViewField6,"/:/","","ALL")#&nbsp; </TD>
	</TR>
	<TR>
	<TD valign="top"> Comments 5: </TD>
	<TD> #replace(ViewField7,"/:/","","ALL")#&nbsp; </TD>
	</TR>				
	<TR>
		<TD valign="top"> Days To Make A Credit: </TD>
		<TD> #ViewField8#&nbsp; </TD>
	</TR>				
	<TR>
		<TD valign="top"> Franchise Fee Percentage: </TD>
		<TD> #numberformat(FranchiseFeePercentage,"_____.00")#&nbsp; </TD>
	</TR>				
	<TR>
		<TD valign="top"> Marketing Fee Percentage: </TD>
		<TD> #numberformat(MarketingFeePercentage,"_____.00")#&nbsp; </TD>
	</TR>	
	<TR>
		<TD valign="top"> GP Price List : </TD>
		<TD> #numberformat(GPPriceList,"_____.00")#&nbsp; </TD>
	</TR>
	<TR>
		<TD valign="top"> Stock Hist Ending Clearance Days : </TD>
		<TD> #clearancedays#&nbsp; </TD>
	</TR>
<!---[   
    Removed stock Master Update flag from display because it is no longer to be used in this context.
    If this option is to be enabled it must be done manually in SQLServer tblOptions by developers.     MK.
   ]---->   
   
   <!---[    <TR>
		<TD valign="top"> Update Stock Master : </TD>
		<TD> <cfif updatestockmaster>Yes<cfelse>No</cfif> </TD>
	</TR>   ]---->
    
    <TR>
		<TD valign="top"> Update Stock Location : </TD>
		<TD> <cfif updatestocklocation>Yes<cfelse>No</cfif> </TD>
	</TR>					

</TABLE>

</CFOUTPUT>
	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

