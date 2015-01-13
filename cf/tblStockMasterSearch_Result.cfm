
<cfset strPageTitle = "Product List (Filtered)">

<!--- Create Criteria string for query from data entered thru search form --->
<CFSET Criteria = ''>
<CF_tblStockMasterSearch_AppendCriteria
    FieldName="#Form.Crit1_FieldName#"
    FieldType="#Form.Crit1_FieldType#"
    Operator="#Form.Crit1_Operator#"
    Value="#Form.Crit1_Value#">
<CF_tblStockMasterSearch_AppendCriteria
    FieldName="#Form.Crit2_FieldName#"
    FieldType="#Form.Crit2_FieldType#"
    Operator="#Form.Crit2_Operator#"
    Value="#Form.Crit2_Value#">
<CF_tblStockMasterSearch_AppendCriteria
    FieldName="#Form.Crit3_FieldName#"
    FieldType="#Form.Crit3_FieldType#"
    Operator="#Form.Crit3_Operator#"
    Value="#Form.Crit3_Value#">
<CF_tblStockMasterSearch_AppendCriteria
    FieldName="#Form.Crit4_FieldName#"
    FieldType="#Form.Crit4_FieldType#"
    Operator="#Form.Crit4_Operator#"
    Value="#Form.Crit4_Value#">
<CF_tblStockMasterSearch_AppendCriteria
    FieldName="#Form.Crit5_FieldName#"
    FieldType="#Form.Crit5_FieldType#"
    Operator="#Form.Crit5_Operator#"
    Value="#Form.Crit5_Value#">

<!--- Memorize the items --->	
	<cfset session.Crit1_Operator ="#Form.Crit1_Operator#">	
	<cfset session.Crit1_Value ="#Form.Crit1_Value#">	

	<cfset session.Crit2_Operator ="#Form.Crit2_Operator#">	
	<cfset session.Crit2_Value ="#Form.Crit2_Value#">	
		
	<cfset session.Crit3_Operator ="#Form.Crit3_Operator#">	
	<cfset session.Crit3_Value ="#Form.Crit3_Value#">	
		
	<cfset session.Crit4_Operator ="#Form.Crit4_Operator#">	
	<cfset session.Crit4_Value ="#Form.Crit4_Value#">	
		
	<cfset session.Crit5_Operator ="#Form.Crit5_Operator#">	
	<cfset session.Crit5_Value ="#Form.Crit5_Value#">		
	
	
	<Cfset strQuery = "SELECT * ">
	<Cfset strQuery = strQuery & "FROM tblStockMaster ">
    <cfif #len(Criteria)# GT 0>
		<Cfset strQuery = strQuery & "WHERE #Criteria#">
	</cfif>	

<CFQUERY name="GetRecord" datasource="#application.dsn#" > 	
<!--- <CFQUERY  DBTYPE="OLEDB" PROVIDER="#AppProvider#" dataSource="#AppCostiDB1#" PROVIDERDSN="#AppCostiDB1#" USERNAME="admin" name="GetRecord" > --->
        #PreserveSingleQuotes(strQuery)#
</CFQUERY>

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
<cfinclude template="/js/jqueryaddin.cfm" >
</HEAD>
<body onLoad="MM_preloadImages('../images/butHomeDown.gif','../images/butHomeDown.gif','../images/butBackDown.gif')">
<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_top"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1><cfoutput>#strPageTitle#</cfoutput></h1>
    </td>
    <td width="25%">&nbsp; 
      
    </td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center">
      <table id="id2" class="tablesorter">
      	<thead>
        	<tr>
            	<th>PLU</th>
            	<th>Description</th>
            	<th>Cost</th>
            	<th>Wholesale</th>
            	<th>Max Retail</th>
            	<th>Buy PLU</th>
            </tr>
        </thead>
        <tbody>
        	<cfloop query="getRecord"><cfoutput>
            	<tr>
                	<td><a href="tblStockMaster_RecordActionGrid.cfm?cfgridkey=#getrecord.PartNo#">#getrecord.PartNo#</a></td>
                	<td>#getrecord.Description#</td>
                	<td>#getrecord.Cost#</td>
                	<td>#getrecord.Wholesale#</td>
                	<td>#getrecord.MaxRetail#</td>
                    <td>#getrecord.PartNoBuyingPlu#</td>
                </tr>
            </cfoutput></cfloop>
        </tbody>
      </table>
	  </div>
    </td>
  </tr>
</table>
</body>
</HTML>

