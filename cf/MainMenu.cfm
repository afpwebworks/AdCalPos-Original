<cfset Menus = application.beanfactory.getbean("Menus") />
<cfset getMainHeading = Menus.getMainMenuHeadings( session.user ) />
<!---[   Initialise the dates for the reporting   ]---->
<cfif not( structKeyExists(session, "startdate") )>
 <cfset session.startDate= datepart("yyyy", request.austime) & datepart("m",request.austime) & datepart("d", request.austime) />
</cfif> 
<cfif not( structKeyExists(session, "enddate") )>
 <cfset session.enddate= datepart("yyyy", request.austime) & datepart("m",request.austime) & datepart("d", request.austime) />
</cfif> 
<!--- - wb 12/01/2004 - Setup display date - --->


<cfinclude template="/includes/header.cfm" />


<!--- Get the comment --->
<cfset strQuery = "">
<CFQUERY name="GetComment" datasource="#application.dsn#" > 
 SELECT * from tblOptions
</CFQUERY>
<cfset strComment = "">
<cfset strComment2 = "">
<cfset strComment3 = "">
<cfset strComment4 = "">
<cfset strComment5 = "">
<cfif #GetComment.recordCount# GT 0>
  <cfif #len(GetComment.Comments)# GT 0>
    <cfif find("/:",GetComment.Comments) EQ 0>
      <cfset strComment = "<div align=""center""><font face=""Tahoma"" color=""FFFFFF"" size=""2""><b>"&GetComment.Comments&"</b></font></div>">
      <cfelse>
      <cfset strComment = "<div align=""center""><font face=""Tahoma"" color=""red"" size=""2""><b>"&replace(GetComment.Comments,"/:/","","ALL")&"</b></font></div>">
    </cfif>
  </cfif>
  <cfif #len(GetComment.Comments2)# GT 0>
    <cfif find("/:",GetComment.Comments2) EQ 0>
      <cfset strComment2 = "<div align=""center""><font face=""Tahoma"" color=""FFFFFF""><b><font size=""2"">"&GetComment.Comments2&"</font></b></font></div>">
      <cfelse>
      <cfset strComment2 = "<div align=""center""><font face=""Tahoma"" color=""Red""><b><font size=""2""> "&replace(GetComment.Comments2,"/:/","","ALL")&"</font></b></font></div>">
    </cfif>
  </cfif>
  <cfif #len(GetComment.Comments3)# GT 0>
    <cfif find("/:",GetComment.Comments3) EQ 0>
      <cfset strComment3 = "<div align=""center""><font face=""Tahoma"" color=""FFFFFF""><b><font size=""2"">"&GetComment.Comments3&"</font></b></font></div>">
      <cfelse>
      <cfset strComment3 = "<div align=""center""><font face=""Tahoma"" color=""red""><b><font size=""2"">"&replace(GetComment.Comments3,"/:/","","ALL")&"</font></b></font></div>">
    </cfif>
  </cfif>
  <cfif #len(GetComment.Comments4)# GT 0>
    <cfif find("/:",GetComment.Comments4) EQ 0>
      <cfset strComment4 = "<div align=""center""><font face=""Tahoma"" color=""FFFFFF""><b><font size=""2"">"&GetComment.Comments4&"</font></b></font></div>">
      <cfelse>
      <cfset strComment4 = "<div align=""center""><font face=""Tahoma"" color=""red""><b><font size=""2"">"&replace(GetComment.Comments4,"/:/","","ALL")&"</font></b></font></div>">
    </cfif>
  </cfif>
  <cfif #len(GetComment.Comments5)# GT 0>
    <cfif find("/:",GetComment.Comments5) EQ 0>
      <cfset strComment5 = "<div align=""center""><font face=""Tahoma"" color=""FFFFFF""><b><font size=""2"">"&GetComment.Comments5&"</font></b></font></div>">
      <cfelse>
      <cfset strComment5 = "<div align=""center""><font face=""Tahoma"" color=""red""><b><font size=""2"">"&replace(GetComment.Comments5,"/:/","","ALL")&"</font></b></font></div>">
    </cfif>
  </cfif>
</cfif>
<table width="90%">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <cfoutput>
  <cfif #len(strComment)# GT 0>
    <tr>
      <td colspan="2">#strComment#</td>
    </tr>
  </cfif>
  <cfif #len(strComment2)# GT 0>
    <tr>
      <td colspan="2">#strComment2#</td>
    </tr>
  </cfif>
  <cfif #len(strComment3)# GT 0>
    <tr>
      <td colspan="2">#strComment3#</td>
    </tr>
  </cfif>
  <cfif #len(strComment4)# GT 0>
    <tr>
      <td colspan="2">#strComment4#</td>
    </tr>
  </cfif>
  <cfif #len(strComment5)# GT 0>
    <tr>
      <td colspan="2">#strComment5#</td>
    </tr>
  </cfif>
  </cfoutput>
</table>
<table width="100%" border="0" align="center">
  <tr>
  
  <td width="90%" align="center" ><table width="60%" border="0" align="center" >
      <CFLOOP QUERY="GetMainHeading">
      <cfoutput>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td class="MenuHead" colspan="5">#GetMainHeading.MainHeading#</td>
      </tr>
      </cfoutput>
      <cfset GetMenuItems =    Menus.getMenuItems( GetMainHeading.MainHeading  ) />
      <cfoutput query = "GetMenuItems">
      <cfif (#GetMenuItems.CurrentRow# mod 2) EQ 1>
        <tr>
        
      </cfif>
      <cfif (#GetMenuItems.CurrentRow# mod 2) EQ 1>
        <tr  >
        <td class="MenuItemLeft"><a href="#GetMenuItems.FormName#"> #GetMenuItems.TaskName#</a></td>
        <cfelse>
        <td class="MenuItemRight"><a href="#GetMenuItems.FormName#">#GetMenuItems.TaskName#</a></td>
      </cfif>
      <cfif ((#GetMenuItems.CurrentRow# mod 2) EQ 0) or (#GetMenuItems.CurrentRow# EQ #GetMenuItems.RecordCount#)>
        </tr>
        
      </cfif>
      </cfoutput>
      </CFLOOP>
      <!--- ************************** --->
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table></td>
  
    <td width="40" valign="top"><table width="100%" border="0" align="top">
        <tr>
          <td width="40">&nbsp;</td>
        </tr>
        <tr>
          <td width="40">&nbsp;</td>
        </tr>
        <tr>
          <td width="40">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
 <cfif (application.siteversion eq "development") > 
  <cfdump var="#session#" label="session vars mainmenu line 147" />
    <cfdump var="#cgi#" label="cgi vars" />
  <cfdump var="#session.user.getsnapshot()#" label="session vars" />
  <cfdump var="#application#" label="application vars">
</cfif>
</BODY>
</HTML>
