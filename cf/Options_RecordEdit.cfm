
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
      <div align="right"><a href="Options_RecordView.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">&nbsp;
	  
<CFSET FormFieldList = "CutOffTime, Comments, Comments2, Comments3, Comments4, Comments5, DaysToMakeACredit, FranchiseFeePercentage, MarketingFeePercentage,UpdateStockmaster,UpdateStocklocation ">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#"  >  
<!--- <CFQUERY name="GetRecord" maxRows=1 DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
		SELECT tblOptions.CutOffTime, tblOptions.Comments, tblOptions.Comments2, tblOptions.Comments3, tblOptions.Comments4, tblOptions.Comments5, tblOptions.DaysToMakeACredit, FranchiseFeePercentage , MarketingFeePercentage, tblOptions.OptionID AS ID_Field, tblOptions.GPPriceList,tblOptions.clearancedays,tblOptions.UpdateStockmaster, tblOptions.UpdateStocklocation
		FROM tblOptions
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblOptions.OptionID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "OptionID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "OptionID" )>
	</CFIF>
			<CFSET CutOffTime_Value = '#GetRecord.CutOffTime#'>
			<CFSET Comments_value = '#GetRecord.Comments#'>
			<CFSET Comments2_value = '#GetRecord.Comments2#'>
			<CFSET Comments3_value = '#GetRecord.Comments3#'>
			<CFSET Comments4_value = '#GetRecord.Comments4#'>	
			<CFSET Comments5_value = '#GetRecord.Comments5#'>
			<CFSET DaysToMakeACredit_value = '#GetRecord.DaysToMakeACredit#'>
			<CFSET FranchiseFeePercentage_value = #GetRecord.FranchiseFeePercentage#>
			<CFSET MarketingFeePercentage_value = #GetRecord.MarketingFeePercentage#>	
			<CFSET GPPriceListPercentage_value = #GetRecord.GPPriceList#>
			<CFSET ClearanceDays_value = #GetRecord.clearancedays#>	
            <CFSET UpdateStockMaster = #GetRecord.UpdateStockMaster#>
            <CFSET UpdateStockLocation = #GetRecord.UpdateStockLocation#>
            
					
<CFELSE>
			<CFSET CutOffTime_Value = '1659'>
			<CFSET Comments_value = ''>
			<CFSET Comments2_value = ''>
			<CFSET Comments3_value = ''>
			<CFSET Comments4_value = ''>
			<CFSET Comments5_value = ''>												
			<CFSET DaysToMakeACredit_value = '0'>				
			<CFSET FranchiseFeePercentage_value = 0 >
			<CFSET MarketingFeePercentage_value = 0 >		
			<CFSET GPPriceListPercentage_value  = 0 >
			<CFSET ClearanceDays_value = 0 >	
            <CFSET UpdateStockMaster = 0>
            <CFSET UpdateStockLocation = 0>
</CFIF>

<CFOUTPUT>
<FORM action="Options_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="OptionID" value="#URL.RecordID#">
</CFIF>

<TABLE WIDTH='750' BORDER="1">
	<TR>
	<TD valign="top" WIDTH="150"> Ordering Cut Off Time: </TD>
    <TD>
	
		<INPUT type="text" name="CutOffTime" value="#CutOffTime_Value#" SIZE="5" maxLength="4">
		<INPUT type="hidden" name="CutOffTime_required" value="Please type the ordering cut off time.">
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Comments: </TD>
    <TD>
	
		<INPUT type="MEMO" name="Comments" value="#replace(Comments_Value,"/:/","","ALL")#" size="88" ><br />
		<input<cfif find("/:/",Comments_Value) NEQ 0> checked="checked"</cfif> id="hc" name="hc" type="Checkbox" value="0"> High light comment 
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Comments 2: </TD>
    <TD>
	
		<INPUT type="MEMO" name="Comments2" value="#replace(Comments2_Value,"/:/","","ALL")#" size="88" ><br />
		<input<cfif find("/:/",Comments2_Value) NEQ 0> checked="checked"</cfif> id="hc2" name="hc2" type="Checkbox" value="0"> High light comment
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Comments 3: </TD>
    <TD>
	
		<INPUT type="MEMO" name="Comments3" value="#replace(Comments3_Value,"/:/","","ALL")#" size="88" ><br />
		<input<cfif find("/:/",Comments3_Value) NEQ 0> checked="checked"</cfif> id="hc3" name="hc3" type="Checkbox" value="0"> High light comment
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
	<TD valign="top"> Comments 4: </TD>
    <TD>
	
		<INPUT type="MEMO" name="Comments4" value="#replace(Comments4_Value,"/:/","","ALL")#" size="88" ><br />
		<input<cfif find("/:/",Comments4_Value) NEQ 0> checked="checked"</cfif> id="hc4" name="hc4" type="Checkbox" value="0"> High light comment
	</TD>
	<!--- field validation --->
	</TR>

	<TR>
		<TD valign="top"> Comments 5: </TD>
    	<TD>
			<INPUT type="MEMO" name="Comments5" value="#replace(Comments5_Value,"/:/","","ALL")#" size="88" ><br />
		<input<cfif find("/:/",Comments5_Value) NEQ 0> checked="checked"</cfif> id="hc5" name="hc5" type="Checkbox" value="0"> High light comment
		</TD>
	</TR>
	
	<TR>
		<TD valign="top" WIDTH="150"> Days To Make A Credit: </TD>
    	<TD>
			<INPUT type="text" name="DaysToMakeACredit" value="#DaysToMakeACredit_value#" SIZE="5" maxLength="10">
			<INPUT type="hidden" name="DaysToMakeACredit_required" value="Please type the days to make a credit.">
			<INPUT type="hidden" name="DaysToMakeACredit_integer">		
		</TD>
	</TR>

	<TR>
		<TD valign="top" WIDTH="150"> Franchise Fee %: </TD>
    	<TD>
			<INPUT type="text" name="FranchiseFeePercentage" value="#FranchiseFeePercentage_value#" SIZE="5" maxLength="10">
			<INPUT type="hidden" name="FranchiseFeePercentage_required" value="Please type the Franchise Fee.">
			<INPUT type="hidden" name="FranchiseFeePercentage_float">		
		</TD>
	</TR>

	<TR>
		<TD valign="top" WIDTH="150"> Marketing Fee %: </TD>
    	<TD>
			<INPUT type="text" name="MarketingFeePercentage" value="#MarketingFeePercentage_value#" SIZE="5" maxLength="10">
			<INPUT type="hidden" name="MarketingFeePercentage_required" value="Please type the Marketing Fee.">
			<INPUT type="hidden" name="MarketingFeePercentage_float">		
		</TD>
	</TR>
	
	<TR>
		<TD valign="top" WIDTH="150"> GP Price List %: </TD>
    	<TD>
			<INPUT type="text" name="GPPriceListPercentage" value="#GPPriceListPercentage_value#" SIZE="5" maxLength="10">
			<INPUT type="hidden" name="GPPriceListPercentage_required" value="Please type the GP Price List.">
			<INPUT type="hidden" name="GPPriceListPercentage_float">		
		</TD>
	</TR>
	<TR>
		<TD valign="top" WIDTH="150"> Stock Hist Ending Clearance Days : </TD>
    	<TD>
			<INPUT type="text" name="clearancedays" value="#ClearanceDays_value#" SIZE="5" maxLength="10">
			<INPUT type="hidden" name="ClearanceDays_required" value="Please type the Clearance Days">
			<INPUT type="hidden" name="ClearanceDays_integer">		
		</TD>
	</TR>
		<!---[   Update stock master is no longer to be a user option.  If this flag is to be reset, it must be done by a developer through
        the SQLServer database table tblOptions.  The option in teh form replaced by a hidden field for compatibility with legacy code. - MK.  29/10/2010   ]---->
        
        <input type="hidden" name="UpdateStockMaster" value="0" />
        
    <!---[   <tr>
       <TD valign="top" WIDTH="150"> Update&nbsp;Stock&nbsp;Master&nbsp;: </TD> 
       <td> <select name="UpdateStockMaster">
       			<option value="1" <cfif UpdateStockMaster is true >selected="selected" </cfif> >Yes</option>
                <option value="0" <cfif UpdateStockMaster is false >selected="selected" </cfif> >No</option>
       </select>
       
       </td>
       </tr>     ]---->
       <tr>
       <TD valign="top" WIDTH="150"> Update&nbsp;Stock&nbsp;Location&nbsp;: </TD> 
       <td> <select name="UpdateStockLocation">
       			<option value="1" <cfif UpdateStockLocation is true >selected="selected" </cfif> >Yes</option>
                <option value="0" <cfif UpdateStockLocation is false >selected="selected" </cfif> >No</option>
       </select>
       </td>
       </tr>  
       
       
              
        
</TABLE>

<P>
	
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

