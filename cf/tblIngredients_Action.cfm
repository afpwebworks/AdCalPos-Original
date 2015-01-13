
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
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
	<TITLE>Ingredients</TITLE>
	
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
      <h1>Ingredients</h1>
    </td>
    <td width="25%"> 
		<cfoutput>
      <div align="right"><a href="tblStockMaster_RecordView.cfm?RecordID=#form.RecordID#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
	  </cfoutput>
    </td>
  </tr>
</table>
<br>
<br>

<cfset lngError = 0>
<cfset strError = ''>
 
<CFIF (ParameterExists(Form.btnApply_OK))>
 <table width="100%" border="0">
  <tr>
    <td>
      <div align="center"> 

	<cfset lngDeptNo = #Form.cmbDeptNo#>
	<cfset lngEmployeeID = #Form.employeeID#>
    <!--- Save the quantities --->
	<cfset lngNumDepartments = #Form.NumDepartments#>
	<CFLOOP INDEX="LoopCount" FROM="1" TO="#lngNumDepartments#" >
		<!--- Get the number of lines per department --->
		<cfset MyIDFieldName = "Form.Dept_#LoopCount#_TotalLines">
		<cfset lngNumLines = #evaluate(MyIDFieldName)#>
		<CFLOOP INDEX="ItemLineCount" FROM="1" TO="#lngNumLines#" step="1">	
			<!---  Get Part No --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_PartNo#ItemLineCount#">
			<cfset strPartNo = #evaluate(MyIDFieldName)#>
			<!--- Get Freezer qty --->
			<cfset MyIDFieldName = "Form.Dept_#LoopCount#_Value_Line_#ItemLineCount#">
			<cfset quantity = #evaluate(MyIDFieldName)#>
			
			<cfif #quantity# NEQ 0>
				<cfset strQuery= "Select tblIngredient.qtyIngredient from tblIngredient where  tblIngredient.SalePLU=#form.RecordID# and tblIngredient.ingredientPLU='#strPartNo#'">
				<CFQUERY name="getQty"      datasource="#application.dsn#"  >
						#PreserveSingleQuotes(strQuery)#
				</CFQUERY>
				<cfif #getQty.RecordCount# GT 0>
	         		  <!--- Save the values --->
						<cfset strQuery = "UPDATE tblIngredient SET tblIngredient.qtyIngredient = #quantity# where tblIngredient.SalePLU=#form.RecordID# and tblIngredient.ingredientPLU=#strPartNo#"> 
					
						<CFQUERY name="UpdateData"  datasource="#application.dsn#"   > 
							#PreserveSingleQuotes(strQuery)#
						</CFQUERY>
				<cfelse>
					<cfif #getQty.RecordCount# EQ 0 and #quantity# GT 0>
						<cfset strQuery = "INSERT INTO tblIngredient (SalePLU,ingredientPLU,qtyIngredient) values(#form.RecordID#,#strPartNo#,#quantity#) ">
						<CFQUERY name="InsertData"      datasource="#application.dsn#"    > 
						#PreserveSingleQuotes(strQuery)#
						</CFQUERY>
					
					</cfif>
				</cfif> 
			<cfelse>
				<cfif #quantity# LTE 0>
					<CFQUERY name="DeleteRecord" maxRows=1 datasource="#application.dsn#"
					 > <!--- <CFQUERY       dataSource="#AppCostiDB1#"       USERNAME="admin" name="DeleteRecord"  maxRows=1> --->
						DELETE 	FROM tblIngredient
						WHERE tblIngredient.SalePLU=#form.RecordID# and 
						tblIngredient.ingredientPLU='#strPartNo#'
					</CFQUERY>
				</cfif>
			</cfif>
		</cfloop> 
	</cfloop>
	<cfoutput><h2><b> Ingredients added successfully.</b></h2></cfoutput>
	<!--<CFLOCATION url="tblStockMaster_RecordView.cfm?RecordID=#Form.RecordID#">-->
<CFELSE>	
	<cflocation URL = "tblIngredient.cfm">
</cfif>	
	  
</body>
</HTML>
