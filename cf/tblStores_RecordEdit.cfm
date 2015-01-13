
<cfset strPageTitle = "Store Details Add/Edit">
<!--- 
StoreID
StoreName
ManagerID
StoreGroupID
Phone
	Mobile
Fax
Email
AcctBalance
CreditLimit
NoLongerUsed
--->

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

<CFSET FormFieldList = "StoreID,StoreName,Manager1Name,Manager2Name
,StoreGroupID
,Phone
,Mobile
,Fax
,Email
,AcctBalance
,NoLongerUsed
,Address
,Suburb
,State
,PostCode
,CreditLimit
">

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblStores.StoreID, *, tblStores.StoreID AS ID_Field
		FROM tblStores
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblStores.StoreID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "StoreID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "StoreID" )>
	</CFIF>
			<CFSET StoreID_Value = #GetRecord.StoreID#>
				
			<CFSET StoreName_Value = #GetRecord.StoreName#>
				
			<CFSET Manager1Name_Value = #GetRecord.Manager1Name#>
			<CFSET Manager2Name_Value = #GetRecord.Manager2Name#>
			
			<CFSET StoreGroupID_Value = #GetRecord.StoreGroupID#>
			<CFSET Phone_Value = #GetRecord.Phone#>			
			<CFSET Mobile_Value = #GetRecord.Mobile#>
			
			<CFSET Fax_Value = #GetRecord.Fax#>
			<CFSET Email_Value = #GetRecord.Email#>
			<CFSET AcctBalance_Value = #GetRecord.AcctBalance#>
			<CFSET CreditLimit_Value = #GetRecord.CreditLimit#>
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>
			<CFSET Address_Value = #GetRecord.Address#>
			<CFSET Suburb_Value = #GetRecord.Suburb#>
			<CFSET State_Value = #GetRecord.State#>
			<CFSET PostCode_Value = #GetRecord.PostCode#>												
			<CFSET ABN_Value = #GetRecord.ABN#>												
<CFELSE>
			<CFSET StoreID_Value = ''>
				
			<CFSET StoreName_Value = ''>
				
			<CFSET Manager1Name_Value = ''>
			<CFSET Manager2Name_Value = ''>
			
			<CFSET StoreGroupID_Value = 1>
			<CFSET Phone_Value = ''>
			<CFSET Mobile_Value = ''>			
			<CFSET Fax_Value = ''>
			<CFSET Email_Value = ''>
			<CFSET AcctBalance_Value = 0>
			<CFSET CreditLimit_Value = 0>
			<CFSET NoLongerUsed_Value = 0>
			<CFSET Address_Value = ''>
			<CFSET Suburb_Value = ''>
			<CFSET State_Value = ''>
			<CFSET PostCode_Value = ''>												
			<CFSET ABN_Value = ''>												
</CFIF>

<cfset MyID = #StoreGroupID_Value#>

<cfset strQuery = "SELECT qryStoreGroup.StoreGroupID, qryStoreGroup.StoreGroupName ">
<cfset strQuery = strQuery & "FROM qryStoreGroup ">
<cfset strQuery = strQuery & "ORDER BY qryStoreGroup.StoreGroupName">

<CFQUERY name="GetData" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetData" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</cfquery>

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
      <div align="right"><a href="tblStores_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
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
<FORM action="tblStores_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="StoreID" value="#URL.RecordID#">
</CFIF>


            <TABLE width="500" border="1" cellpadding="2">
              <CFIF not ParameterExists(URL.RecordID)>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Store ID: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="StoreID" value="#StoreID_Value#" size="50" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="StoreID_integer">
                <INPUT type="hidden" name="StoreID_required" value="Please type store id.">				
              </TR>
              <cfelse>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF">Store ID: </font></b></TD>
                <TD> 
                  <font face="Tahoma" size="4" color="FFFFFF">#StoreID_Value#</font>
                </TD>
              </TR>
			  </CFIF>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Store Name: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="StoreName" value="#StoreName_Value#" size="50" maxLength="50">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="StoreName_required" value="Please type store name.">				
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Address: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Address" value="#Address_Value#" size="50" maxLength="70">
                </TD>
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Suburb: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Suburb" value="#Suburb_Value#" size="50" maxLength="35">
                </TD>
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  State: </font></b></TD>
                <TD> 
				<select name="State">
					<cfif State_Value eq 'NA'>
						<option value="NA" selected>NA</option>
					<cfelse>
						<option value="NA">NA</option>					
					</cfif>
					<cfif State_Value eq 'ACT'>
						<option value="ACT" selected>ACT</option>
					<cfelse>
						<option value="ACT">ACT</option>					
					</cfif>
					<cfif State_Value eq 'NSW'>
						<option value="NSW" selected>NSW</option>
					<cfelse>
						<option value="NSW">NSW</option>					
					</cfif>
					<cfif State_Value eq 'NT'>
						<option value="NT" selected>NT</option>
					<cfelse>
						<option value="NT">NT</option>					
					</cfif>					
					<cfif State_Value eq 'QLD'>
						<option value="QLD" selected>QLD</option>
					<cfelse>
						<option value="QLD">QLD</option>					
					</cfif>
					<cfif State_Value eq 'SA'>
						<option value="SA" selected>SA</option>
					<cfelse>
						<option value="SA">SA</option>					
					</cfif>
					<cfif State_Value eq 'TAS'>
						<option value="TAS" selected>TAS</option>
					<cfelse>
						<option value="TAS">TAS</option>					
					</cfif>
					<cfif State_Value eq 'VIC'>
						<option value="VIC" selected>VIC</option>
					<cfelse>
						<option value="VIC">VIC</option>					
					</cfif>
					<cfif State_Value eq 'WA'>
						<option value="WA" selected>WA</option>
					<cfelse>
						<option value="WA">WA</option>					
					</cfif>
  				</select>					
                  <!--- <INPUT type="text" name="State" value="#State_Value#" size="50" maxLength="3"> --->
                </TD>
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Post Code: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="PostCode" value="#PostCode_Value#" size="50" maxLength="4">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Phone: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Phone" value="#Phone_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Mobile: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Mobile" value="#Mobile_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Fax: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Fax" value="#Fax_Value#" size="50" maxLength="25">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Email: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Email" value="#Email_Value#" size="50" maxLength="70">
                </TD>
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Contact 1: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Manager1Name" value="#Manager1Name_Value#" size="50" maxLength="50">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Contact 2: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="Manager2Name" value="#Manager2Name_Value#" size="50" maxLength="50">
                </TD>
              </TR>
			  
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Store Group ID: </font></b></TD>
                <TD> 
	 			</CFOUTPUT>	
	 			<select name="StoreGroupID">
	    		<cfoutput query="GetData">
	        		<cfif #GetData.StoreGroupID# eq #MyID#>
	     				<option value="#GetData.StoreGroupID#" selected>#GetData.StoreGroupName#</option>
	        		<cfelse>
	     				<option value="#GetData.StoreGroupID#">#GetData.StoreGroupName#</option>
					</cfif>
				</cfoutput>
	  			</select>	
				<cfoutput>			
                 <!---  <INPUT type="text" name="StoreGroupID" value="#StoreGroupID_Value#" size="50" maxLength="21"> --->
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="StoreGroupID_float"> --->
              </TR>
<!--- 
			<CFIF not ParameterExists(URL.RecordID)>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Acct Balance: </font></b></TD>
                <TD><INPUT type="text" name="AcctBalance" value="#AcctBalance_Value#" size="50" maxLength="21">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="AcctBalance_float">
              </TR>
              <cfelse>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Acct Balance: </font></b></TD>
                <TD><font face="Tahoma" size="4" color="FFFFFF">#numberformat(GetRecord.AcctBalance,"999,999,999.99")#&nbsp;</font></TD>
              </TR>	  
			  </CFIF>
			  </cfoutput>			  
			   <cfoutput>
 --->
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  Credit Limit: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="CreditLimit" value="#CreditLimit_Value#" size="50" maxLength="10">
                </TD>
                <!--- field validation --->
                <INPUT type="hidden" name="CreditLimit_float">
                <INPUT type="hidden" name="CreditLimit_required" value="Please type the credit limit.">				
              </TR>
              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  ABN: </font></b></TD>
                <TD> 
                  <INPUT type="text" name="ABN" value="#ABN_Value#" size="50" maxLength="20">
                </TD>
              </TR>

              <TR> 
                <TD valign="top" width="150"><b><font face="Tahoma" size="4" color="FFFFFF"> 
                  No Longer Used: </font></b></TD>
                <TD> 
				<INPUT type="radio" name="NoLongerUsed" value="1"<CFIF #NoLongerUsed_Value# is 1> checked</CFIF>> Yes
				<INPUT type="radio" name="NoLongerUsed" value="0"<CFIF #NoLongerUsed_Value# is 0> checked</CFIF>> No				
                 <!---  <INPUT type="text" name="NoLongerUsed" value="#NoLongerUsed_Value#" size="50" maxLength="5"> --->
                </TD>
                 <!--- field validation ---> 
                <INPUT type="hidden" name="NoLongerUsed_required" value="Please select the answer for no longer used.">
              </TR>
			  
            </TABLE>

<p></p>	
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

