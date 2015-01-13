
<cfset strPageTitle = "Product Add/Edit">

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

<CFSET FormFieldList = "PartNo,GroupNo,Cost,Description,SupplyUnit,OrderingUnit,Label,TCode,PCode,RCode,Tolerance,Wholesale,MaxRetail,PluType,LockOrderUnitType,MinOrderQty,PictureFile,NoLongerUsed,SuppressOrder,SuppressStocktake">

<CFIF ParameterExists(URL.RecordID)>
    <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1>
		SELECT tblStockMaster.PartNo,  tblStockMaster.PartNo AS ID_Field, * 
		FROM tblStockMaster
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblStockMaster.PartNo = '#URL.RecordID#'
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "PartNo" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "PartNo" )>
	</CFIF>
			<CFSET PartNo_Value = '#GetRecord.PartNo#'>
 			<CFSET Description_Value = '#GetRecord.Description#'>
			<CFSET PluType_value = '#GetRecord.PluType#'>
			<CFSET SupplyUnit_value = '#GetRecord.SupplyUnit#'>
			<CFSET OrderingUnit_value = '#GetRecord.OrderingUnit#'>
			<CFSET Label_value = '#GetRecord.Label#'>
			<CFSET PictureFile_value = '#GetRecord.PictureFile#'>

			<CFSET GroupNo_Value = #GetRecord.GroupNo#>
			<CFSET Cost_Value = #GetRecord.Cost#>
			<CFSET TCode_value = #GetRecord.TCode#>
			<CFSET PCode_value = #GetRecord.PCode#>
			<CFSET RCode_value = #GetRecord.RCode#>
			<CFSET Tolerance_value = #GetRecord.Tolerance#>
			<CFSET Wholesale_value = #GetRecord.Wholesale#>
			<CFSET MaxRetail_value = #GetRecord.MaxRetail#>
			<CFSET LockOrderUnitType_value = #GetRecord.LockOrderUnitType#>
			<CFSET MinOrderQty_value = #GetRecord.MinOrderQty#>

			<CFSET NoLongerUsed_value = #GetRecord.NoLongerUsed#>
			<CFSET SuppressOrder_value = #GetRecord.SuppressOrder#>
			<CFSET SuppressStocktake_value = #GetRecord.SuppressStocktake#>

<CFELSE>
			<CFSET PartNo_Value = ''>
			<CFSET GroupNo_Value = ''>
			<CFSET Cost_Value = ''>
 			<CFSET Description_Value = ''>
			<CFSET SupplyUnit_Value = ''>
			<CFSET OrderingUnit_Value = ''>
			<CFSET Label_Value = ''>
			<CFSET TCode_Value = ''>
			<CFSET PCode_Value = ''>
			<CFSET RCode_Value = ''>
			<CFSET Tolerance_Value = ''>
			<CFSET Wholesale_Value = ''>
			<CFSET MaxRetail_Value = ''>
			<CFSET PluType_Value = ''>
			<CFSET LockOrderUnitType_Value = ''>
			<CFSET MinOrderQty_Value = ''>
			<CFSET PictureFile_Value = ''>
			<CFSET NoLongerUsed_Value = ''>
			<CFSET SuppressOrder_Value = ''>
			<CFSET SuppressStocktake_Value = ''>

</CFIF>

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
      <div align="right"><a href="tblStockMaster_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center"> 
 		
        <CFOUTPUT>
<FORM action="tblStockMaster_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="PartNo" value="#URL.RecordID#">
</CFIF>

<!--- $$$$$$$$$$$$$$$$$$$$$$$$  --->          	
            <table border="1" bordercolor="FFFFFF" width="850" cellspacing="0" >
              <tr valign="top"> 
                <td width="110">PLU:</td>
                <td rowspan="14" width="20">&nbsp;</td>
                <td width="100"> 
                  <cfif not ParameterExists(URL.RecordID)>
                  <input type="text" name="PartNo" value="#PartNo_Value#" size="15" maxlength="4">
                  <cfelse>
                  #PartNo_Value#
                  </cfif>
                </td>
                <td width="80" rowspan="14">&nbsp; </td>
                <td width="130">&nbsp; </td>
                <td rowspan="14" width="20">&nbsp;</td>
                <td width="500" colspan="2"> 
                  <input type="text" name="Description" value="#Description_Value#" size="70" maxlength="25">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110">&nbsp; </td>
                <td width="100">&nbsp; </td>
                <td width="130"> POS Label: </td>
                <td width="500" colspan="2"> 
                  <input type="text" name="Label" value="#Label_Value#" size="70" maxlength="20">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Group.: </td>
                <td width="100"> 
                  <input type="text" name="GroupNo" value="#GroupNo_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> Group Name </td>
                <td width="500" colspan="2">&nbsp; </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> PLU Type: </td>
                <td width="100" valign="top"> 
                  <input type="text" name="PluType" value="#PluType_Value#" size="15" maxlength="10">
                </td>
                <td width="130"> PictureFile </td>
                <td width="500" colspan="2"> 
                  <input type="text" name="PictureFile" value="#PictureFile_Value#" size="70" maxlength="30">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110">&nbsp; </td>
                <td width="100">&nbsp; </td>
                <td width="130">&nbsp; </td>
                <td width="500" colspan="2">&nbsp; </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Cost Price: </td>
                <td width="100"> 
                  <input type="text" name="Cost" value="#Cost_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> SuppressStocktake </td>
                <td width="100"> 
                  <input type="text" name="SuppressStocktake" value="#SuppressStocktake_Value#" size="15" maxlength="21">
                </td>
                <td rowspan="9" width="400">&nbsp; </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Wholesale: </td>
                <td width="100"> 
                  <input type="text" name="Wholesale" value="#Wholesale_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> SuppressOrder </td>
                <td width="100"> 
                  <input type="text" name="SuppressOrder" value="#SuppressOrder_Value#" size="15" maxlength="21">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Max Retail: </td>
                <td width="100"> 
                  <input type="text" name="MaxRetail" value="#MaxRetail_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> NoLongerUsed </td>
                <td width="100"> 
                  <input type="text" name="NoLongerUsed" value="#NoLongerUsed_Value#" size="15" maxlength="21">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110">&nbsp; </td>
                <td width="100">&nbsp; </td>
                <td width="130">&nbsp; </td>
                <td width="100">&nbsp; </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Tax Code: </td>
                <td width="100"> 
                  <input type="text" name="TCode" value="#TCode_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> SupplyUnit </td>
                <td width="100"> 
                  <input type="text" name="SupplyUnit" value="#SupplyUnit_Value#" size="15" maxlength="21">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> ProfitCode: </td>
                <td width="100"> 
                  <input type="text" name="PCode" value="#PCode_Value#" size="15" maxlength="21">
                </td>
                <td width="130"> OrderingUnit </td>
                <td width="100"> 
                  <input type="text" name="OrderingUnit" value="#OrderingUnit_Value#" size="15" maxlength="21">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> MarginCode: </td>
                <td width="100"> 
                  <input type="text" name="RCode" value="#RCode_Value#" size="15" maxlength="1">
                </td>
                <td width="130"> LockOrderUnitType </td>
                <td width="100"> 
                  <input type="text" name="LockOrderUnitType" value="#LockOrderUnitType_Value#" size="15" maxlength="10">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110"> Tolerance: </td>
                <td width="100"> 
                  <input type="text" name="Tolerance" value="#Tolerance_Value#" size="15" maxlength="5">
                </td>
                <td width="130"> MinOrderQty </td>
                <td width="100"> 
                  <input type="text" name="MinOrderQty" value="#MinOrderQty_Value#" size="15" maxlength="21">
                </td>
              </tr>
              <tr valign="top"> 
                <td width="110">&nbsp;</td>
                <td width="100">&nbsp;</td>
                <td width="130">&nbsp;</td>
                <td width="100">&nbsp;</td>
              </tr>
            </table>






<!--- $$$$$$$$$$$$$$$$$$$$$$$$  --->  
<!--- form buttons --->
<INPUT type="submit" name="btnEdit_OK" value="    OK    ">
<INPUT type="submit" name="btnEdit_Cancel" value="Cancel">

</FORM>
</CFOUTPUT>
	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

