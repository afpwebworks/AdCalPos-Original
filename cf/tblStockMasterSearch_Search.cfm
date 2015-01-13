
<cfset strPageTitle = "Plu Search">

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
      <div align="center">
	  
<!--- Search form --->
<FORM action="tblStockMasterSearch_Result.cfm" method="post">

<TABLE>


	<!--- Field: tblStockMaster.PartNo=CHAR;32;FALSE --->
	<INPUT type="hidden" name="Crit1_FieldName" value="tblStockMaster.PartNo">
	
	<INPUT type="hidden" name="Crit1_FieldType" value="CHAR">
	<TR>
	<TD>Plu</TD>
	<TD>
	<cfoutput>
	<CFIF ParameterExists(session.Crit1_Operator)>
		<SELECT name="Crit1_Operator">
			<cfif "#session.Crit1_Operator#" EQ "EQUAL"><OPTION value="EQUAL" selected>is<cfelse><OPTION value="EQUAL">is</cfif>
			<cfif "#session.Crit1_Operator#" EQ "NOT_EQUAL"><OPTION value="NOT_EQUAL" selected>is not<cfelse><OPTION value="NOT_EQUAL">is not</cfif>
			<cfif "#session.Crit1_Operator#" EQ "CONTAINS"><OPTION value="CONTAINS" selected>contains<cfelse><OPTION value="CONTAINS">contains</cfif>
			<cfif "#session.Crit1_Operator#" EQ "BEGINS_WITH"><OPTION value="BEGINS_WITH" selected>begins with<cfelse><OPTION value="BEGINS_WITH">begins with</cfif>
			<cfif "#session.Crit1_Operator#" EQ "ENDS_WITH"><OPTION value="ENDS_WITH" selected>ends with<cfelse><OPTION value="ENDS_WITH">ends with</cfif>
		</SELECT>
	<cfelse>
		<SELECT name="Crit1_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
		</SELECT>
	</cfif>
	</TD>
	<TD>
    
	<CFIF ParameterExists(session.Crit1_Value)>
		<INPUT type="text" name="Crit1_Value" value = "#session.Crit1_Value#">
	<cfelse>
		<INPUT type="text" name="Crit1_Value">
	</cfif>

	</TD>
	</TR>



	<!--- Field: tblStockMaster.Description=CHAR;80;FALSE --->
	<INPUT type="hidden" name="Crit2_FieldName" value="tblStockMaster.Description">
	
	<INPUT type="hidden" name="Crit2_FieldType" value="CHAR">
	<TR>
	<TD>Description</TD>
	<TD>
	<CFIF ParameterExists(session.Crit2_Operator)>
		<SELECT name="Crit2_Operator">
			<cfif "#session.Crit2_Operator#" EQ "EQUAL"><OPTION value="EQUAL" selected>is<cfelse><OPTION value="EQUAL">is</cfif>
			<cfif "#session.Crit2_Operator#" EQ "NOT_EQUAL"><OPTION value="NOT_EQUAL" selected>is not<cfelse><OPTION value="NOT_EQUAL">is not</cfif>
			<cfif "#session.Crit2_Operator#" EQ "CONTAINS"><OPTION value="CONTAINS" selected>contains<cfelse><OPTION value="CONTAINS">contains</cfif>
			<cfif "#session.Crit2_Operator#" EQ "BEGINS_WITH"><OPTION value="BEGINS_WITH" selected>begins with<cfelse><OPTION value="BEGINS_WITH">begins with</cfif>
			<cfif "#session.Crit2_Operator#" EQ "ENDS_WITH"><OPTION value="ENDS_WITH" selected>ends with<cfelse><OPTION value="ENDS_WITH">ends with</cfif>
		</SELECT>
	<cfelse>
		<SELECT name="Crit2_Operator">
			<OPTION value="CONTAINS">contains
			<OPTION value="BEGINS_WITH">begins with
			<OPTION value="ENDS_WITH">ends with
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
		</SELECT>
	</cfif>
	</TD>
	<TD>
	<CFIF ParameterExists(session.Crit2_Value)>
		<INPUT type="text" name="Crit2_Value" value = "#session.Crit2_Value#">
	<cfelse>
		<INPUT type="text" name="Crit2_Value">
	</cfif>
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.GroupNo=INT;4;FALSE --->
	<INPUT type="hidden" name="Crit3_FieldName" value="tblStockMaster.GroupNo">
	<INPUT type="hidden" name="Crit3_Value_integer">
	
	<INPUT type="hidden" name="Crit3_FieldType" value="INT">
	<TR>
	<TD>Group</TD>
	<TD>
	<CFIF ParameterExists(session.Crit3_Operator)>
		<SELECT name="Crit3_Operator">
			<cfif "#session.Crit3_Operator#" EQ "EQUAL"><OPTION value="EQUAL" selected>is<cfelse><OPTION value="EQUAL">is</cfif>
			<cfif "#session.Crit3_Operator#" EQ "NOT_EQUAL"><OPTION value="NOT_EQUAL" selected>is not<cfelse><OPTION value="NOT_EQUAL">is not</cfif>
			<cfif "#session.Crit3_Operator#" EQ "GREATER_THAN"><OPTION value="GREATER_THAN" selected>greater than<cfelse><OPTION value="GREATER_THAN">greater than</cfif>
			<cfif "#session.Crit3_Operator#" EQ "SMALLER_THAN"><OPTION value="SMALLER_THAN" selected>smaller than<cfelse><OPTION value="SMALLER_THAN">smaller than</cfif>
		</SELECT>
	<cfelse>
		<SELECT name="Crit3_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		</SELECT>
	</cfif>
	</TD>
	<TD>
	
	<CFIF ParameterExists(session.Crit3_Value)>
		<INPUT type="text" name="Crit3_Value" value = "#session.Crit3_Value#">
	<cfelse>
		<INPUT type="text" name="Crit3_Value">
	</cfif>
	
	</TD>
	</TR>


	<!--- Field: tblStockMaster.RCode=INT;4;FALSE --->
	<INPUT type="hidden" name="Crit4_FieldName" value="tblStockMaster.RCode">
	<INPUT type="hidden" name="Crit4_Value_integer">
	
	<INPUT type="hidden" name="Crit4_FieldType" value="INT">
	<TR>
	<TD>Margin Code</TD>
	<TD>
	<CFIF ParameterExists(session.Crit4_Operator)>
		<SELECT name="Crit4_Operator">
			<cfif "#session.Crit4_Operator#" EQ "EQUAL"><OPTION value="EQUAL" selected>is<cfelse><OPTION value="EQUAL">is</cfif>
			<cfif "#session.Crit4_Operator#" EQ "NOT_EQUAL"><OPTION value="NOT_EQUAL" selected>is not<cfelse><OPTION value="NOT_EQUAL">is not</cfif>
			<cfif "#session.Crit4_Operator#" EQ "GREATER_THAN"><OPTION value="GREATER_THAN" selected>greater than<cfelse><OPTION value="GREATER_THAN">greater than</cfif>
			<cfif "#session.Crit4_Operator#" EQ "SMALLER_THAN"><OPTION value="SMALLER_THAN" selected>smaller than<cfelse><OPTION value="SMALLER_THAN">smaller than</cfif>
		</SELECT>
	<cfelse>
		<SELECT name="Crit4_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
			<OPTION value="GREATER_THAN">greater than
			<OPTION value="SMALLER_THAN">smaller than
		</SELECT>
	</cfif>
	</TD>
	<TD>
	
	<CFIF ParameterExists(session.Crit4_Value)>
		<INPUT type="text" name="Crit4_Value" value = "#session.Crit4_Value#">
	<cfelse>
		<INPUT type="text" name="Crit4_Value">
	</cfif>
	
	</TD>
	</TR>



	<!--- Field: tblStockMaster.PluType=CHAR;2;FALSE --->
	<INPUT type="hidden" name="Crit5_FieldName" value="tblStockMaster.PluType">
	
	<INPUT type="hidden" name="Crit5_FieldType" value="CHAR">
	<TR>
	<TD>Plu Type</TD>
	<TD>
	<CFIF ParameterExists(session.Crit5_Operator)>
		<SELECT name="Crit5_Operator">
			<cfif "#session.Crit5_Operator#" EQ "EQUAL"><OPTION value="EQUAL" selected>is<cfelse><OPTION value="EQUAL">is</cfif>
			<cfif "#session.Crit5_Operator#" EQ "NOT_EQUAL"><OPTION value="NOT_EQUAL" selected>is not<cfelse><OPTION value="NOT_EQUAL">is not</cfif>
		</SELECT>
	<cfelse>
	   <SELECT name="Crit5_Operator">
			<OPTION value="EQUAL">is
			<OPTION value="NOT_EQUAL">is not
		</SELECT>
	</cfif>
	</TD>
	<TD>
	
<!--- 	<INPUT type="text" name="Crit5_Value"> --->
	<CFIF ParameterExists(session.Crit5_Value)>
		<SELECT name="Crit5_Value">
			<cfif "#session.Crit5_Value#" EQ "All"><option value="All" selected>All</option><cfelse><option value="All">All</option></cfif>
			<cfif "#session.Crit5_Value#" EQ "N"><option value="N" selected>Normal</option><cfelse><option value="N">Normal</option></cfif>
			<cfif "#session.Crit5_Value#" EQ "P"><option value="P" selected>Processed</option><cfelse><option value="P">Processed</option></cfif>
			<cfif "#session.Crit5_Value#" EQ "M"><option value="M" selected>Sale PLU</option><cfelse><option value="M">Sale PLU</option></cfif>
		</SELECT>
	<cfelse>
		<select name="Crit5_Value">
		  <option value="All" selected>All</option>
		  <option value="N">Normal</option>
		  <option value="P">Processed</option>
		  <option value="M">Sale PLU</option>
		</select>	
	</cfif>

	</TD>
	</TR>
<script language="JavaScript1.2" type="text/JavaScript1.2">
document.forms[0].Crit1_Value.focus();
</script>

</cfoutput>

</TABLE>
<P>
<INPUT type="submit">
</FORM>

	  
	  
	  
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

