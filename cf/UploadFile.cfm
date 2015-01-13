<cfset strPageTitle = "Upload Result">
<cfset updateversion = application.currentversion + 1 />

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
</CFIF>----->   ]---->

<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="costi.css">
<TITLE>
<cfoutput>#strPageTitle#</cfoutput>
</TITLE>
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
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_self"><img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
    <td><h1>
        <cfoutput>#strPageTitle#</cfoutput>
      </h1></td>
    <td width="25%"><div align="right"><a href="Upload.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" target="_self"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div></td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0">
  <tr>
    <td><div align="center">
        <cfparam name="LocalAppCostiDB" default="#Applic_DBRoot#">
        
        <!---[   <cfset FilePathDest = #Replace(LocalAppCostiDB,"database\","plupics")# >   ]---->
        <cfset FilePathDest = #application.approotabs# & "\plupics" >
        <cffile destination = "#FilePathDest#" action = "Upload" nameconflict= "OverWrite" FileField = "MyFile">
        <cfset strFileName = #File.ServerFile#>
        <cfif #len(strFileName)# LT 1>
          <br>
          Please select a file and try again.
          <cfabort>
        </cfif>
        
        <!---[   <!--- Check to see if the file exist in the table --->
<cfset strQuery = "SELECT tblPictureFile.PictureFileID, tblPictureFile.PictureFileName ">
<cfset strQuery = strQuery & "FROM tblPictureFile ">
<cfset strQuery = strQuery & "WHERE (((tblPictureFile.PictureFileName)='#strFileName#'))">   ]---->
        
        <cfquery name="GetData" datasource="#application.dsn#" > 
            SELECT PictureFileID, PictureFileName 
            FROM tblPictureFile 
            WHERE PictureFileName= <cfqueryparam value="#strFileName#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
     <!---[      If there is no current record in the table, it's a new image file.   ]---->
        <cfif #GetData.RecordCount# LT 1>
          <CFQUERY name="PutData" datasource="#application.dsn#" >  
          INSERT INTO tblPictureFile ( PictureFileName, latestversion ) Values ( 
          <cfqueryparam value="#strFileName#" cfsqltype="cf_sql_varchar" />,
          <cfqueryparam value="#updateversion#" cfsqltype="cf_sql_integer" />
              )
            </CFQUERY>
         <cfelse>   
             <!---[        otherwise it's an updated image.   The record in the database needs to be flagged for later broadcast.  ]---->   
             <CFQUERY name="PutData" datasource="#application.dsn#" >  
                  Update tblPictureFile 
                  SET PictureFileName = <cfqueryparam value="#strFileName#" cfsqltype="cf_sql_varchar" />,
                  latestversion = <cfqueryparam value="#updateversion#" cfsqltype="cf_sql_integer" />,
                  dateupdated = <cfqueryparam value="#request.austime#" cfsqltype="cf_sql_timestamp" />
                  
                  WHERE PictureFileID = <cfqueryparam value="#GetData.PictureFileID#" cfsqltype="cf_sql_integer" />
            </CFQUERY>
        </cfif>
        <cfoutput>
        <p>
        <cfif file.FileExisted is "yes">
          #File.ATTEMPTEDSERVERFILE# existed already
          <cfelse>
          #File.ATTEMPTEDSERVERFILE# was not already on the server
        </cfif>
        <cfif (file.FILEWASOVERWRITTEN is "yes")>
          and was overwritten with this file.
          <cfelseif (file.FILEWASRENAMED is "yes")>
          and was renamed to #File.ServerFile#.
          <cfelseif (file.FILEWASSAVED  is "no")>
          and was not uploaded.
          <cfelseif (file.FILEWASSAVED is "yes")>
          and was successfully uploaded.
        </cfif>
        </cfoutput>
        </p>
      </div></td>
  </tr>
</table>
</body>
</HTML>
