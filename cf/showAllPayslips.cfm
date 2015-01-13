
<CFOUTPUT>
  <CFLOOP list="#wageIDList#" index="loop">
   <CFSET WID=#loop#>
   <CFINCLUDE template="PayrollSelectPayPagePaySlip.cfm" >
   <DIV style="page-break-after:always"></DIV>
  </cfloop>
</cfoutput>

<!--- <a href="PayrollSelectPayPagePaySlip.cfm?WID=#GetData.WageID#&SID=#lngSID#&WE=#strWE#"> --->
