
<!--- Wait for specified number of miliseconds --->
<CFSET lngWaitMiliSeconds = Attributes.MiliSeonds>

<CFSET MaxIterationCount = 100000>

<!--- Time an empty loop with this many iterations --->
<CFSET tickBegin = #GetTickCount()#>
<CFSET tickEnd = #tickBegin# + #lngWaitMiliSeconds#>

<CFLOOP Index=i From=1 To= #MaxIterationCount# >
	<CFSET tickRegister = #GetTickCount()#>
	<cfif #tickRegister# GT #tickEnd#>
		<CFBREAK>
	</cfif>
</CFLOOP>



