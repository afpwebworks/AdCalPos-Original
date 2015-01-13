
<cfsetting enablecfoutputonly="Yes">
<!--- - WB 09/01/2004 - Setup calendar variables - --->
<cfinclude template="CalendarSetup1.cfm">
<cfset local.formName="frmPayment">
<cfset local.page="PaymentB.cfm">

<cfset strPageTitle = "Payment (2 / 3)">
<!--- - wb 08/02/2004 - setup the payment type - --->
<cfif isDefined("form.PaymentType")>
	<cfset local.paymentType=form.PaymentType>
<cfelse>
	<cfset local.paymentType=url.paymentType>
</cfif>
<cfset strPaymentType=local.paymentType>
<!--- - wb 08/02/2004 - setup the store ID - --->
<cfif isDefined("form.StoreID")>
	<cfset local.storeId=form.StoreID>
<cfelse>
	<cfset local.storeId=url.storeId>
</cfif>
<cfset lngStoreID=local.storeId>

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


<!--- Write a query to select the store --->
<cfset strQuery = "SELECT tblStores.StoreID, tblStores.StoreName ">
<cfset strQuery = strQuery & "FROM tblStores ">
<cfset strQuery = strQuery & "WHERE tblStores.StoreID = #lngStoreID#">

<CFQUERY name="GetStores" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetStores" DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin"> --->
	#PreserveSingleQuotes(strQuery)#
</CFQUERY>

<CFSET strDateToday = ''>
<CF_GetTodayDate>
<cfsetting enablecfoutputonly="no">
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
<!--- - wb 05/02/2004 - change calendar script - --->
function changeMonth(f,m){
	var v=eval("document."+f+".calMonth.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?month="+v+"&current="+m+"&paymentType=<cfoutput>#local.paymentType#</cfoutput>&storeId=<cfoutput>#local.storeId#</cfoutput>";
	}
	else{
		var s=l.slice(0,p)+"?month="+v+"&current="+m+"&paymentType=<cfoutput>#local.paymentType#</cfoutput>&storeId=<cfoutput>#local.storeId#</cfoutput>";
	}
	location.replace(s);
}
function changeYear(f,y){
	var v=eval("document."+f+".calYear.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?year="+v+"&current="+y+"&paymentType=<cfoutput>#local.paymentType#</cfoutput>&storeId=<cfoutput>#local.storeId#</cfoutput>";
	}
	else{
		var s=l.slice(0,p)+"?year="+v+"&current="+y+"&paymentType=<cfoutput>#local.paymentType#</cfoutput>&storeId=<cfoutput>#local.storeId#</cfoutput>";
	}
	location.replace(s);
}
</script>
<script language="JavaScript1.2" src="../js/calendar_check1.js" type="text/javascript"></script>
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
<FORM action="PaymentC.cfm" id="<cfoutput>#local.formName#</cfoutput>" method="post" name="<cfoutput>#local.formName#</cfoutput>" onsubmit="return submitCheck('<cfoutput>#local.formName#</cfoutput>');">
<cfoutput>
<input type="hidden" name="PaymentType" value="#strPaymentType#">
<input type="hidden" name="StoreID" value="#lngStoreID#">
</cfoutput>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
      <TABLE>
        <TR>
          <TD>
            <div align=right>Payment Type: </div>
		  </TD> 	
          <TD>
            <Cfoutput><div align=left>#strPaymentType#</div></cfoutput>
		  </TD>
        </TR>
        <TR>
          <TD>
            <div align=right>Store: </div>
          </TD>
          <TD>
            <cfoutput><div align=left>#GetStores.StoreName#</div></cfoutput>
		  </TD>
        </TR>
        <TR>
   	      <TD colspan="2">
       	    <div align="center">Payment Date: </div>
          </TD>
   	    </TR>
        <tr><td align="center" colspan="2"><!--- - WB 09/01/2004 - display calendar - --->
			<!--- - create a date based on the first day of the current month and year - --->
			<cfset local.cDate=dateAdd('m',session.monthCal,createDate(year(now()),month(now()),01))>
			<cfset local.fromYear=year(now())-10>
			<cfset local.toYear=year(now())+5>
			<!--- - start caledar title - --->
			<table border="0" cellpadding="0" cellspacing="0">
				<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
				<tr>
					<td class="month"><select id="calMonth" name="calMonth" onchange="changeMonth('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"mm")#</cfoutput>');">
						<cfloop from="1" to="12" index="i">
							<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"mm") EQ i> selected="selected"</cfif>><cfoutput>#monthAsString(i)#</cfoutput></option>
						</cfloop>	
					</select>
					<select id="calYear" name="calYear" onchange="changeYear('<cfoutput>#local.formName#</cfoutput>','<cfoutput>#dateFormat(local.cDate,"yyyy")#</cfoutput>');">
						<cfloop from="#local.fromYear#" to="#local.toYear#" index="i">
							<option value="<cfoutput>#i#</cfoutput>"<cfif dateFormat(local.cDate,"yyyy") EQ i> selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
						</cfloop>	
					</select></td>
				</tr>
				<tr><td><img src="../images/s.gif" width="1" height="5" alt="spacer" border="0" /></td></tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
				<tr><td class="month"><cfoutput>#dateFormat(local.cDate,"mmmm yyyy")#</cfoutput></td></tr>
				<tr><td><img src="../images/s.gif" width="1" height="5" alt="spacer" border="0" /></td></tr>
			</table>	
			<table border="1" bordercolor="#4B4B4B" cellpadding="2" cellspacing="0">
				<tr>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />S<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />M<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />T<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />W<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />T<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />F<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />S<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></td>
				</tr>
				<!--- - start calendar - --->
				<tr><!--- - create counters for the calendar - --->
					<cfset local.dateCount=1>
					<cfset local.cCount=1>
					<cfset local.count=1>
					<!--- - create the calendar table - --->
					<cfloop from="1" to="42" index="i">
						<!--- - conditions for calendar construction and number placement in conjuction with the day of the week - --->
						<cfif local.dateCount LTE daysInMonth(local.cDate) AND dayOfWeek(createDate(year(local.cDate),month(local.cDate),local.dateCount)) EQ local.cCount>
							<cfset local.dateCheck=createDate(year(local.cDate),month(local.cDate),local.dateCount)>
							<!--- - place the an active number - ---> 
							<td align="center" class="normal_body"><a<cfif year(local.cDate) EQ year(now()) AND month(local.cDate) EQ month(now()) AND local.dateCount EQ day(now())> class="today"</cfif> href="javaScript:void(0);"  onclick="placeDate('start','<cfoutput>#numberFormat(local.dateCount,00)##numberFormat(month(local.cDate),00)##year(local.cDate)#</cfoutput>','<cfoutput>#local.formName#</cfoutput>');"><cfoutput>#numberFormat(local.dateCount,99)#</cfoutput></a></td>
							<cfset local.dateCount=local.dateCount+1>
						<cfelse>
							<!--- - place a blank - --->
							<td class="normal_body">&nbsp;&nbsp;</td>
						</cfif>
						<cfif i/local.count EQ 7 AND i NEQ 42>
							</tr>
							<tr>
							<cfset local.cCount=0>
							<cfset local.count=local.count+1>
						</cfif>
						<cfset local.cCount=local.cCount+1>
					</cfloop>
				</tr>
				<tr>
					<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?pos=bwd&amp;paymentType=<cfoutput>#local.paymentType#</cfoutput>&amp;storeId=<cfoutput>#local.storeId#</cfoutput>"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&lt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
					<td class="cal_days" colspan="5"><img src="../images/s.gif" width="1" height="1" alt="spacer" border="0" /></td>
					<td class="cal_days"><a href="<cfoutput>#local.page#</cfoutput>?pos=fwd&amp;paymentType=<cfoutput>#local.paymentType#</cfoutput>&amp;storeId=<cfoutput>#local.storeId#</cfoutput>"><img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" />&gt;<img src="../images/s.gif" width="5" height="1" alt="spacer" border="0" /></a></td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr><td><img src="../images/s.gif" width="1" height="10" alt="spacer" border="0" /></td></tr>
				<tr><td align="center" colspan="3"><span id="date"></span>&nbsp;<span class="error" id="msg"></span></td></tr>
				<input id="sDate" name="sDate" type="hidden" value="0" />
			</table>	 
		</td></tr>
		<TR>
   	      <TD>
       	    <div align=right>Amount: </div>
          </TD>
          <TD>
       	    <div align=left><input type="text" name="Amount" size="20" maxlength="10">
			<input type="hidden" name="Amount_float" value="Please type the amount">
			<input type="hidden" name="Amount_required" value="Please type the amount"></div>		
		  </TD>
   	    </TR>
        <cfif "#strPaymentType#" EQ "Check">
	        <TR>
    	      <TD>
        	    <div align=right>Check Number: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="CheckNumber" size="10" maxlength="20">
				<input type="hidden" name="CheckNumber_required" value="Please type the check number"></div>		
			  </TD>
    	    </TR>
	        <TR>
    	      <TD>
        	    <div align=right>Name: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="Name" size="30" maxlength="50">
				<input type="hidden" name="Name_required" value="Please type the name on the check"></div>		
			  </TD>
    	    </TR>
	        <TR>
    	      <TD>
        	    <div align=right>Bank: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="Bank" size="30" maxlength="50">
				<input type="hidden" name="Bank_required" value="Please type the Bank name"></div>		
			  </TD>
    	    </TR>
	        <TR>
    	      <TD>
        	    <div align=right>BSB: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="BSB" size="30" maxlength="50">
				<input type="hidden" name="BSB_required" value="Please type the BSB or the bank location"></div>						
			  </TD>
    	    </TR>
        <cfelseif "#strPaymentType#" EQ "Credit Card">		
	        <TR>
    	      <TD>
        	    <div align=right>Credit Card: </div>
	          </TD>
	          <TD>
				<select name="CreditCard">
				  <option value="Master Card" selected>Master Card</option>
				  <option value="VISA">VISA</option>
				  <option value="AMEX">AMEX</option>
				  <option value="Diners">Diners</option>
				  <option value="Bank Card">Bank Card</option>
				</select>			  
			  </TD>
    	    </TR>
	        <TR>
    	      <TD>
        	    <div align=right>Card Number: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="CardNumber" size="30" maxlength="20">
				<input type="hidden" name="CardNumber_required" value="Please type the card number"></div>		
			  </TD>
    	    </TR>
	        <TR>
    	      <TD>
        	    <div align=right>Expiry Date: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="ExpiryDate" size="20" maxlength="4">
				<input type="hidden" name="ExpiryDate_required" value="Please type the Expiry Date"></div>		
			  </TD>
    	    </TR>
        <cfelseif "#strPaymentType#" EQ "Direct Deposit">		
	        <TR>
    	      <TD>
        	    <div align=right>Reference Number: </div>
	          </TD>
	          <TD>
        	    <div align=left><input type="text" name="RefNumber" size="30" maxlength="25">
				<input type="hidden" name="RefNumber_required" value="Please type the reference number"></div>		
			  </TD>
    	    </TR>
		</cfif>
		<TR>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		</TR>
		<TR>
    		<td colspan="2"> 
      			<div align="center"><input type="submit" name="Submit" value="  Next  "></div>
    		</td>
		</TR>
	  </TABLE>
	  <p>&nbsp;</p>
	  </form>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

