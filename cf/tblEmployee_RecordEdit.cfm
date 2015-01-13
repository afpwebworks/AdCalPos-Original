
<cfset strPageTitle = "Employee Add/Edit">

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
<cfset lngUserType = #session.user.getUserType()# >
<cfset lngLoginStoreID = #session.storeid# >

<CFSET FormFieldList = "EmployeeID,BundyNo,StoreID,Surname,GivenName,TaxFileNo,">
<CFSET FormFieldList = FormFieldList & "Street,Address1,Address2,PostCode,State,">
<CFSET FormFieldList = FormFieldList & "Phone,Fax,Mobile,Email,BirthDay,">
<CFSET FormFieldList = FormFieldList & "EmpStatusID,HourlyPayRate,MonthlySalary,Commenced,Finished,">
<CFSET FormFieldList = FormFieldList & "entLeaveAvail,entLeaveTaken,entSickAvail,entSickTaken,">
<CFSET FormFieldList = FormFieldList & "ytdGross,ytdTax,ytdNetPay,ytdSuper,">
<CFSET FormFieldList = FormFieldList & "NoLongerUsed,UserTypeID,UserName,Password">

<!--- Get the combo values for the Employee Status --->
<CFQUERY name="GetStatusCombo" datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetStatusCombo"> --->
	SELECT tblEmpStatus.EmpStatusID, tblEmpStatus.Status
	FROM tblEmpStatus
	ORDER BY tblEmpStatus.Status
</CFQUERY>


<!--- Get the combo values for the User Types --->
<cfif #lngUserType# LTE 4>
	<cfset strQuery = "SELECT tblSecurityUserTypes.UserTypeID, tblSecurityUserTypes.UserType ">
	<cfset strQuery = strQuery & "FROM tblSecurityUserTypes ">
	<cfset strQuery = strQuery & "WHERE (((tblSecurityUserTypes.UserTypeID)<>1)) ">
	<cfset strQuery = strQuery & "ORDER BY tblSecurityUserTypes.UserTypeID">
<cfelse>
	<cfset strQuery = "SELECT tblSecurityUserTypes.UserTypeID, tblSecurityUserTypes.UserType ">
	<cfset strQuery = strQuery & "FROM tblSecurityUserTypes ">
	<cfset strQuery = strQuery & "WHERE (((tblSecurityUserTypes.UserTypeID)>4)) ">
	<cfset strQuery = strQuery & "ORDER BY tblSecurityUserTypes.UserTypeID">
</cfif>

<CFQUERY name="GetUserTypeCombo" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- Get the combo values for the Store --->
<cfif #lngUserType# LTE 4>
	<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores ">
	<cfset strQuery = strQuery & "ORDER BY tblStores.StoreID">
<cfelse>
	<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName ">
	<cfset strQuery = strQuery & "FROM tblStores ">
	<cfset strQuery = strQuery & "where tblStores.StoreID = #lngLoginStoreID#">
</cfif>

<CFQUERY name="GetStoreCombo" datasource="#application.dsn#" > 
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<CFIF ParameterExists(URL.RecordID)>
	<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
    <!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
		SELECT tblEmployee.EmployeeID, tblEmployee.EmployeeID AS ID_Field, *
		FROM tblEmployee
		<CFIF ParameterExists(URL.RecordID)>
		WHERE tblEmployee.EmployeeID = #URL.RecordID#
		</CFIF>
	</CFQUERY>

	<CFIF not ListFind( FormFieldList, "EmployeeID" )>
		<CFSET FormFieldList = ListAppend( FormFieldList, "EmployeeID" )>
	</CFIF>
			<CFSET EmployeeID_Value = #GetRecord.EmployeeID#>
			<CFSET BundyNo_Value = #GetRecord.BundyNo#>
			<CFSET Surname_Value = #GetRecord.Surname#>

			<CFSET StoreID_Value = #GetRecord.StoreID#>
			<CFSET GivenName_Value = #GetRecord.GivenName#>
			<CFSET TaxFileNo_Value = #GetRecord.TaxFileNo#>
			<CFSET Street_Value = #GetRecord.Street#>
			<CFSET Address1_Value = #GetRecord.Address1#>
			<CFSET Address2_Value = #GetRecord.Address2#>
			<CFSET PostCode_Value = #GetRecord.PostCode#>
			<CFSET State_Value = #GetRecord.State#>
			<CFSET Phone_Value = #GetRecord.Phone#>
			<CFSET Fax_Value = #GetRecord.Fax#>
			<CFSET Mobile_Value = #GetRecord.Mobile#>
			<CFSET Email_Value = #GetRecord.Email#>
			<CFSET BirthDay_Value = #GetRecord.BirthDay#>
			<CFSET EmpStatusID_Value = #GetRecord.EmpStatusID#>
			<CFSET HourlyPayRate_Value = #GetRecord.HourlyPayRate#>
			<CFSET MonthlySalary_Value = #GetRecord.MonthlySalary#>
			<CFSET Commenced_Value = #GetRecord.Commenced#>
			<CFSET Finished_Value = #GetRecord.Finished#>
			<CFSET entLeaveAvail_Value = #GetRecord.entLeaveAvail#>
			<CFSET entLeaveTaken_Value = #GetRecord.entLeaveTaken#>
			<CFSET entSickAvail_Value = #GetRecord.entSickAvail#>
			<CFSET entSickTaken_Value = #GetRecord.entSickTaken#>
			<CFSET ytdGross_Value = #GetRecord.ytdGross#>
			<CFSET ytdTax_Value = #GetRecord.ytdTax#>
			<CFSET ytdNetPay_Value = #GetRecord.ytdNetPay#>
			<CFSET ytdSuper_Value = #GetRecord.ytdSuper#>
			<CFSET NoLongerUsed_Value = #GetRecord.NoLongerUsed#>
			<CFSET UserTypeID_Value = #GetRecord.UserTypeID#>
			<CFSET UserName_Value = #GetRecord.UserName#>
			<CFSET Password_Value = #GetRecord.Password#>

<CFELSE>
			<CFSET EmployeeID_Value = ''>
			<CFSET BundyNo_Value = ''>
			<CFSET Surname_Value = ''>
			<CFSET StoreID_Value = ''>
			<CFSET GivenName_Value = ''>
			<CFSET TaxFileNo_Value = ''>
			<CFSET Street_Value = ''>
			<CFSET Address1_Value = ''>
			<CFSET Address2_Value = ''>
			<CFSET PostCode_Value = ''>
			<CFSET State_Value = ''>
			<CFSET Phone_Value = ''>
			<CFSET Fax_Value = ''>
			<CFSET Mobile_Value = ''>
			<CFSET Email_Value = ''>
			<CFSET BirthDay_Value = ''>
			<CFSET EmpStatusID_Value = 2>
			<CFSET HourlyPayRate_Value = 0>
			<CFSET MonthlySalary_Value = 0>
			<CFSET Commenced_Value = ''>
			<CFSET Finished_Value = ''>
			<CFSET entLeaveAvail_Value = 0>
			<CFSET entLeaveTaken_Value = 0>
			<CFSET entSickAvail_Value = 0>
			<CFSET entSickTaken_Value = 0>
			<CFSET ytdGross_Value = 0>
			<CFSET ytdTax_Value = 0>
			<CFSET ytdNetPay_Value = 0>
			<CFSET ytdSuper_Value = 0>
			<CFSET NoLongerUsed_Value = 0>
			<CFSET UserTypeID_Value = 7>
			<CFSET UserName_Value = ''>
			<CFSET Password_Value = ''>

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
      <div align="right"><a href="tblEmployee_RecordList.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<!--- <br> --->
<!--- <br> --->

<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
<CFOUTPUT>
<FORM action="tblEmployee_RecordAction.cfm" method="post">
<INPUT type="hidden" name="FieldList" value="#FormFieldList#">
<CFIF ParameterExists(URL.RecordID)>
	<INPUT type="hidden" name="RecordID" value="#URL.RecordID#">
	<INPUT type="hidden" name="EmployeeID" value="#URL.RecordID#">
</CFIF>

            <TABLE width="960" border="1" cellpadding="0">
              <TR> 
                <TD valign="top" width="110"> Employee ID:  </TD>
				<td>
	             <CFIF not ParameterExists(URL.RecordID)>
	                  &nbsp; <!--- <INPUT type="text" name="EmployeeID" value="#EmployeeID_Value#" size="30" maxLength="10"> --->
        	      <cfelse>
            	       #EmployeeID_Value# 
				  </CFIF>
 					<!--- field validation --->
					<!--- <INPUT type="hidden" name="EmployeeID_integer"> --->
					<!--- <INPUT type="hidden" name="EmployeeID_required" value="Please type the employee ID">	 --->
                </TD>
			
                <td width="10" rowspan="15">&nbsp; </td>
				<td width="130"> Store </td>
                 <td width="130">
                  <!--- <INPUT type="text" name="StoreID" value="#StoreID_Value#" &nbsp; size="30" maxLength="21"> --->
			       </cfoutput>
					<select name="StoreID">
 		    	    	<cfoutput query = "GetStoreCombo" >
				        	<cfif #StoreID_Value# EQ #GetStoreCombo.StoreID#>
    	                		<option value="#GetStoreCombo.StoreID#" selected>#GetStoreCombo.StoreName#</option>
		                    <cfelse>
    	                		<option value="#GetStoreCombo.StoreID#">#GetStoreCombo.StoreName#</option>
        	            	</cfif>
						</cfoutput>
    	      		</select>
    	    	 <cfoutput>
				  
				 </td>
              </TR>
			  
              <TR> 
                <TD colspan="2" valign="top" width="150"><font face="Tahoma" color="FFFFFF"> 
                  <!--- Bundy No: ---> &nbsp;</font>
				<!---</TD>
                <TD> 
                   <INPUT type="text" name="BundyNo" value="#BundyNo_Value#" size="30" maxLength="21"> --->
                </TD>
                <!--- field validation --->
                <!--- <INPUT type="hidden" name="BundyNo_float"> --->
				
				<td width="110"> Status </td>
        
		         <td width="130">
			       </cfoutput>
					<select name="EmpStatusID">
 		    	    	<cfoutput query = "GetStatusCombo" >
				        	<cfif #EmpStatusID_Value# EQ #GetStatusCombo.EmpStatusID#>
    	                		<option value="#GetStatusCombo.EmpStatusID#" selected>#GetStatusCombo.Status#</option>
		                    <cfelse>
    	                		<option value="#GetStatusCombo.EmpStatusID#">#GetStatusCombo.Status#</option>
        	            	</cfif>
						</cfoutput>
    	      		</select>
    	    	 <cfoutput>
				 </td>

              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Surname: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Surname" value="#Surname_Value#" size="30" maxLength="30">
                </TD>
				<td width="110"> Birthday </td>
                 <td width="130">
                  <INPUT type="text" name="BirthDay" value="#BirthDay_Value#" size="30" maxLength="8">
				  <INPUT type="hidden" name="BirthDay_required" value="Please type the birth day.">				 
				  <INPUT type="hidden" name="BirthDay_integer">				 
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Given Name: </font> </TD>
                <TD> 
                  <INPUT type="text" name="GivenName" value="#GivenName_Value#" size="30" maxLength="20">
                </TD>
				<td width="110"> Hourly </td>
                 <td width="130">
                  <INPUT type="text" name="HourlyPayRate" value="#HourlyPayRate_Value#" size="30" maxLength="10">
 					<!--- field validation --->
					<INPUT type="hidden" name="HourlyPayRate_float">
					<INPUT type="hidden" name="HourlyPayRate_required" value="Please type hourly pay rate.">					
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Taxfile No: </font> </TD>
                <TD> 
                  <INPUT type="text" name="TaxFileNo" value="#TaxFileNo_Value#" size="30" maxLength="12">
                </TD>
				<td width="110"> Weekly </td>
                 <td width="130">
                  <INPUT type="text" name="MonthlySalary" value="#MonthlySalary_Value#" size="30" maxLength="10">
				 </td>
 					<!--- field validation --->
					<INPUT type="hidden" name="MonthlySalary_float">
					<INPUT type="hidden" name="MonthlySalary_required" value="Please type monthly salary.">				 
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Street: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Street" value="#Street_Value#" size="30" maxLength="70">
                </TD>
				<td width="110"> Commenced </td>
                 <td width="130">
                  <INPUT type="text" name="Commenced" value="#Commenced_Value#" size="30" maxLength="8">
				  <INPUT type="hidden" name="Commenced_required" value="Please type the commenced.">				 				
				  <INPUT type="hidden" name="Commenced_integer">				 
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Address 1: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Address1" value="#Address1_Value#" size="30" maxLength="50">
                </TD>
				<td width="110"> Finished </td>
                 <td width="130">
                  <INPUT type="text" name="Finished" value="#Finished_Value#" size="30" maxLength="8">
				  <INPUT type="hidden" name="Finished_integer">
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Address 2: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Address2" value="#Address2_Value#" size="30" maxLength="50">				
                </TD>
				<td colspan="2" width="110"> &nbsp;<!--- Leave Available ---> 
				<!---</td>
                <td width="130">
                  <INPUT type="text" name="entLeaveAvail" value="#entLeaveAvail_Value#" size="30" maxLength="10"> --->
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Postcode: </font> </TD>
                <TD> 
                  <INPUT type="text" name="PostCode" value="#PostCode_Value#" size="30" maxLength="4">
                </TD>
				<td colspan="2" width="110"> <!--- Leave Taken --->&nbsp; 
				<!--- </td>
                 <td width="130">
                  <INPUT type="text" name="entLeaveTaken" value="#entLeaveTaken_Value#" size="30" maxLength="10"> --->
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  State: </font> </TD>
                <TD> 
                  <INPUT type="text" name="State" value="#State_Value#" size="30" maxLength="3">
                </TD>
				<td colspan="2" width="110"> <!--- Sick Available --->&nbsp; 
				<!--- </td>
                 <td width="130">
                  <INPUT type="text" name="entSickAvail" value="#entSickAvail_Value#" size="30" maxLength="10"> --->
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Phone: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Phone" value="#Phone_Value#" size="30" maxLength="25">
                </TD>
				<td colspan="2" width="110"> <!--- Sick Taken ---> &nbsp;
				<!--- </td>
                 <td width="130">
                  <INPUT type="text" name="entSickTaken" value="#entSickTaken_Value#" size="30" maxLength="10"> --->
				 </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Fax: </font> </TD>
                <TD> 
                   <INPUT type="text" name="Fax" value="#Fax_Value#" size="30" maxLength="25"> 
                </TD>
				<td colspan="2" width="110"> <!--- YTD Gross --->&nbsp; 
				<!--- </td>
                 <td width="130">
				   <INPUT type="text" name="ytdGross" value="#ytdGross_Value#" size="30" maxLength="10"> --->
				 </td>

			  <TD rowspan="4" width="10">&nbsp; </td>
			  <TD width="130"> Terminated &nbsp;</td>
 			  <TD width="130"> 
 				<INPUT type="radio" name="NoLongerUsed" value="1"<CFIF #NoLongerUsed_Value# is 1> checked</CFIF>> Yes
				<INPUT type="radio" name="NoLongerUsed" value="0"<CFIF #NoLongerUsed_Value# is 0> checked</CFIF>> No
			  </td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Mobile: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Mobile" value="#Mobile_Value#" size="30" maxLength="25">
                </TD>
				<td colspan="2" width="110"> <!--- YTD Tax --->&nbsp; 
				<!--- </td>
                 <td width="130">
                 <INPUT type="text" name="ytdTax" value="#ytdTax_Value#" size="30" maxLength="10"> --->
				 </td>
			  <TD width="130"> User Type ID &nbsp;</td>

    			<TD width="130"> 
		          </cfoutput>
					  <select name="UserTypeID">
 			        	<cfoutput query = "GetUserTypeCombo" >
				        	<cfif #UserTypeID_Value# EQ #GetUserTypeCombo.UserTypeID#>
                	    		<option value="#GetUserTypeCombo.UserTypeID#" selected>#GetUserTypeCombo.UserType#</option>
	                	    <cfelse>
    	                		<option value="#GetUserTypeCombo.UserTypeID#">#GetUserTypeCombo.UserType#</option>
	        	            </cfif>
						</cfoutput>
        			  </select>
				  <cfoutput>
				</td>			  
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                  Email: </font> </TD>
                <TD> 
                  <INPUT type="text" name="Email" value="#Email_Value#" size="30" maxLength="70">
                </TD>
				<td colspan="2" width="110"> <!--- YTD Net ---> &nbsp;
				<!--- </td>
                 <td width="130">
                  <INPUT type="text" name="ytdNetPay" value="#ytdNetPay_Value#" size="30" maxLength="10"> --->
				 </td>
			  <TD width="130"> User Name &nbsp;</td>
			  <TD width="130">
			  	<INPUT TYPE="text" name="UserName" value="#UserName_Value#" size=20 maxlength="10"></td>
              </TR>

              <TR> 
                <TD valign="top" width="150"> <font face="Tahoma" color="FFFFFF"> 
                 &nbsp; </font> </TD>
                <TD>&nbsp;   </TD>
				<td colspan="2" width="110"> <!--- YTD Super --->&nbsp; 
				<!--- </td>
                 <td width="130">
                  <INPUT type="text" name="ytdSuper" value="#ytdSuper_Value#" size="30" maxLength="10"> --->
				 </td>
			  <TD width="130"> Password &nbsp;</td>
			  <TD width="130">
			  	<INPUT TYPE="text" name="Password" value="#Password_Value#" size=20 maxlength="10"></td>
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

