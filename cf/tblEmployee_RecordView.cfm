
<cfset strPageTitle = "Employee View">

<!---[   <CFINCLUDE template="act_security_check.cfm">   ]---->

<cfset lngEid = 0 > 


<cfset strQuery = "SELECT tblEmpStatus.Status, tblSecurityUserTypes.UserType, qryEmployeeView.LeaveMinsAccumultedBy100 , qryEmployeeView.SickMinsAccumultedBy100 , ">
<cfset strQuery = strQuery & "case when qryEmployeeView.NoLongerUsed=0 then 'No' else 'Yes' end AS NLU, ">
<cfset strQuery = strQuery & "tblStores.StoreID, tblStores.StoreName, qryEmployeeView.*, qryEmployeeView.EmployeeID AS ID_Field ">
<cfset strQuery = strQuery & "FROM ((qryEmployeeView INNER JOIN tblEmpStatus ON qryEmployeeView.EmpStatusID = tblEmpStatus.EmpStatusID) "> 
<cfset strQuery = strQuery & "INNER JOIN tblSecurityUserTypes ON qryEmployeeView.UserTypeID = tblSecurityUserTypes.UserTypeID) ">
<cfset strQuery = strQuery & "INNER JOIN tblStores ON qryEmployeeView.StoreID = tblStores.StoreID ">

<CFIF ParameterExists(URL.RecordID)>
	<cfset strQuery = strQuery & "WHERE qryEmployeeView.EmployeeID = #URL.RecordID#">
    <cfset lngEid = URL.RecordID > 
</CFIF>

<CFQUERY name="GetRecord" maxRows=1 datasource="#application.dsn#" > 
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord"  maxRows=1> --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>


<CFSET isCasual=false>
<CFIF FIND('Casual',GetRecord.status,1)>
    <CFSET isCasual=true>
</cfif> 


<cfset TodayMonth = #Month(now())# >
<cfif TodayMonth GT 6 >
	<cfset StartYear = #Year(now())#>
	<cfset NextYear = 1 + #Year(now())#>
	<cfset StartDate = "#StartYear#0701" >
	<cfset EndDate = "#NextYear#0630" >
<cfelse>
	<cfset StartYear = #Year(now())# - 1 >
	<cfset NextYear = #Year(now())#>
	<cfset StartDate = "#StartYear#0701" >
	<cfset EndDate = "#NextYear#0630" >
</cfif>

<cfset strQuery = "SELECT (substring(WeekEnding,1,2)) + '/' + (substring(WeekEnding,3,2)) + '/' + (substring(WeekEnding,5,4)) as WeekEndingDate, * from tblEmpPayRollPaid where EmployeeID = #lngEid# and 10000 * (substring(WeekEnding,5,4)) + 100 * (substring(WeekEnding,3,2)) + (substring(WeekEnding,1,2)) between 20020701 and 20040630  order by 10000 * (substring(WeekEnding,5,4)) + 100 * (substring(WeekEnding,3,2)) + (substring(WeekEnding,1,2))">
		
<CFQUERY name="GetPayHistory" datasource="#application.dsn#" > 
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

<!--- KF Feb 04, query global employee pay parameters --->
<CFINCLUDE template="act_getEmployeePayOptions.cfm">

<cfset dblLeaveTaken = 0>
<cfset dblSickTaken = 0>
<cfset dblGross = 0>
<cfset dblTax = 0>
<cfset dblNetPay = 0>
<cfset dblSuper = 0>

<cfloop query = "GetPayHistory">
	<cfset dblLeaveTaken = dblLeaveTaken + #GetPayHistory.HolidayHrsCanBePaid# >
	<cfset dblSickTaken = dblSickTaken + #GetPayHistory.SickHrsCanBePaid# >
	<cfset dblGross = dblGross + #GetPayHistory.TaxableIncome# + #GetPayHistory.NonTaxableIncome# >
	<cfset dblTax = dblTax + #GetPayHistory.Tax# >
	<cfset dblNetPay = dblNetPay + #GetPayHistory.TaxableIncome# + #GetPayHistory.NonTaxableIncome# - #GetPayHistory.Tax# >
	<cfset dblSuper = dblSuper + #GetPayHistory.SuperAccumulated#  >
</cfloop>

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
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
	  
	  <cfoutput>
<FORM action="tblEmployee_RecordAction.cfm" method="post">
	<INPUT type="hidden" name="RecordID" value="#GetRecord.ID_Field#">

<table width="100%" border="0">
  <tr>
    <td> 
      <div align="center">
        <table width="65%" border="0">
          <tr>
            <td>
              <div align="center">
	          <INPUT type="submit" name="btnView_Add" value="   Add    ">
	          <INPUT type="submit" name="btnView_Edit" value="  Edit  ">
	          <INPUT type="submit" name="btnView_Delete" value="  Delete  ">
			  </div>
            </td>
            <td>
				&nbsp;
				<!--- 			
              	<div align="center">
	          	<INPUT type="submit" name="btnView_First" value="<< First">
	          	<INPUT type="submit" name="btnView_Previous" value="< Prev">
	          	<INPUT type="submit" name="btnView_Next" value="Next >">
	          	<INPUT type="submit" name="btnView_Last" value="Last >>">
			  	</div>
				 --->

            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
</FORM>
</cfoutput>
<CFOUTPUT query="GetRecord">
	<cfset dblLeaveAvail = #GetRecord.LeaveMinsAccumultedBy100# / 6000 >
	<cfset dblSickAvail = #GetRecord.SickMinsAccumultedBy100# / 6000 >


          <TABLE border="2" width="950" cellpadding="0">

            <TR> 
              <TD valign="top" width="150"> Employee ID: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.EmployeeID# </div>
              </TD>
			  <TD rowspan="15" width="10">&nbsp; </td>
			  <TD width="150"> Store </td>
 			  <!--- <TD width="200"> #GetRecord.StoreID# &nbsp; </td> --->
 			  <TD width="200"> #GetRecord.StoreName# &nbsp; </td> 
            </TR>

            <TR> 
              <TD colspan="2" valign="top" width="150"> <!--- Bundy No: ---> &nbsp;
			  <!--- </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.BundyNo# &nbsp; </div> --->
              </TD>
			  <TD>Status </td>
			  <TD width="200"> #GetRecord.Status# &nbsp; </td>
            </TR>
            <TR> 
              <TD valign="top" width="150"> Surname: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Surname# &nbsp; </div>
              </TD>
			  <TD width="150"> Birthday </td>
			  <TD width="200"> #GetRecord.BirthDay# &nbsp; </td>
            </TR>
            <TR> 
              <TD valign="top" width="150"> Given Name: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Givenname# &nbsp; </div>
              </TD>
			  <TD width="150"> Hourly Pay Rate </td>
			  <TD width="150"  align="right"><font face="Tahoma" color="FFFFFF" size="2"><b>&nbsp; #NumberFormat(GetRecord.HourlyPayRate,"_____.99")# </b></font> </td>
            </TR>


            <TR> 
              <TD valign="top" width="150"> Taxfile No: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.TaxFileNo# &nbsp; </div>
              </TD>
			  <TD width="150"> Weekly Salary </td>
			  <TD width="150" align="right"> <font face="Tahoma" color="FFFFFF" size="2"><b> &nbsp; #NumberFormat(GetRecord.MonthlySalary,"_____.99")#</b></font></td>
            </TR>

            <TR> 
              <TD valign="top" width="150"> Street: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Street# &nbsp; </div>
              </TD>
			  <TD width="150"> Commenced </td>
			  <TD width="200"> #GetRecord.Commenced# &nbsp; </td>
            </TR>
            <TR> 
              <TD valign="top" width="150"> Address 1: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Address1# &nbsp; </div>
              </TD>
			  <TD width="150"> Finished </td>
			  <TD width="200"> #GetRecord.Finished# &nbsp; </td>
            </TR>
            <TR> 
              <TD valign="top" width="150"> Address 2: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Address2# &nbsp; </div>
              </TD>
<CFIF NOT isCasual>
			  <TD width="150">
			     Leave Avail(hrs) 
				 <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;($)
			  </td>
			  <TD width="150" align="right"><font face="Tahoma" color="FFFFFF" size="2">
			     <CFSET leaveDueMoney = GetRecord.MonthlySalary / variables.standardHoursInWeek * dblLeaveAvail>
				 
			     <b> &nbsp; #NumberFormat(dblLeaveAvail,"_____.99")#
 				 <BR>&nbsp;#DecimalFormat(leaveDueMoney)#$</b>
				 </font> </td>
</cfif>			  			  
            </TR>
            <TR> 
              <TD valign="top" width="150"> Postcode: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.PostCode# &nbsp; </div>
              </TD>
<CFIF NOT isCasual>			  
			  <TD width="150"> YTD Leave Taken </td>
<!--- 			  <TD width="150" align="right"> #NumberFormat(GetRecord.entLeaveTaken,"_____.99")# &nbsp; </td> --->
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Leave.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblLeaveTaken,"_____.99")#</font></b></font></a> </td>
			  
</CFIF>			  
            </TR>
            <TR> 
              <TD valign="top" width="150"> State: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.State# &nbsp; </div>
              </TD>
<CFIF NOT isCasual>			  
			  <TD width="150">Sick Avail(hrs)</td>
			  <TD width="150" align="right"><font face="Tahoma" color="FFFFFF" size="2"><b> &nbsp; #NumberFormat(dblSickAvail,"_____.99")#</b></font> </td>
</CFIF>			  
            </TR>
            <TR> 
              <TD valign="top" width="150"> Phone: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Phone# &nbsp; </div>
              </TD>
<CFIF NOT isCasual>			  
			  <TD width="150"> YTD Sick Taken </td>
<!--- 			  <TD width="150" align="right"> #NumberFormat(GetRecord.entSickTaken,"_____.99")# &nbsp; </td> --->
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Sick.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblSickTaken,"_____.99")#</font></b></font></a> </td>
</CFIF>			  
            </TR>
            <TR> 
              <TD valign="top" width="150"> Fax: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Fax# &nbsp; </div>
              </TD>
			  <TD width="150"> YTD Gross </td>
<!---                <TD width="150"><div align="right"> #NumberFormat(GetRecord.ytdGross,"_____.99")# &nbsp; </div></TD> --->
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Gross.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblGross,"_____.99")#</font></b></font></a> </td>
			  <TD rowspan="4" width="10">&nbsp; </td>
			  <TD width="130"> Terminated &nbsp;</td>
 			  <TD width="130"><div align="center">  #GetRecord.NLU# &nbsp; </div></td>

            </TR>

           <TR> 
              <TD valign="top" width="150"> Mobile: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Mobile# &nbsp; </div>
              </TD>
			  <TD width="150"> YTD Tax </td>
<!--- 			  <TD width="150" align="right"> #NumberFormat(GetRecord.ytdTax,"_____.99")# &nbsp; </td> --->
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Tax.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblTax,"_____.99")#</font></b></font></a> </td>
			  <TD width="130"> User Type ID &nbsp;</td>
			  <TD width="130"> 
			    <div align="center"> #GetRecord.UserType# &nbsp; </div>
			  </td>
            </TR>
            <TR> 
              <TD valign="top" width="150"> Email: </TD>
              <TD width="300"> 
                <div align="left"> #GetRecord.Email# &nbsp; </div>
              </TD>
			  <TD width="150"> YTD Net Pay </td>
<!--- 			  <TD width="150" align="right"> #NumberFormat(GetRecord.ytdNetPay,"_____.99")# &nbsp; </td> --->
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Net.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblNetPay,"_____.99")#</font></b></font></a> </td>
			  <TD width="130"> User Name &nbsp;</td>
			  <TD width="130"> #GetRecord.UserName# &nbsp;</td>
            </TR>
           <TR> 
              <TD valign="top" width="150"> Date Entered: </TD>
              <TD width="300"> 
                <div align="right"> #dateformat(GetRecord.DateEntered,"dd/mm/yyyy")# &nbsp; </div>
              </TD>
			  <TD width="150"> YTD Super </td>
			  <TD width="150" align="right"><a href="tblEmployee_Detail_Super.cfm?eid=#lngEid#"><font face="Tahoma" color="FFFFFF"><b><font size="2">#NumberFormat(dblSuper,"_____.99")#</font></b></font></a> </td>
<!--- 			  <TD width="130"> Password &nbsp;</td>
			  <TD width="130"> #PasswordFormat(GetRecord.Password)# &nbsp;</td>
 --->
            </TR>
          </TABLE>
          </CFOUTPUT>
		  <CFOUTPUT>
		    <FORM name="ALLOCHOLIDAY" action="dsp_holiday_pay_form.cfm" method="POST">
		      <INPUT type="TEXT" name="employee_id" value="#URL.RecordID#">
			  <INPUT type="TEXT" name="Store_ID" value="#GetRecord.StoreID#"> 
			  <INPUT type="SUBMIT" value="Allocate Holiday Pay">
		    </form>
		  </cfoutput>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

