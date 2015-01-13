
<!--- This shows LSDateFormat --->
<HTML>
<HEAD>
<TITLE>LSDateFormat Example</TITLE>
</HEAD>

<BODY>
<H3>LSDateFormat Example</H3>

<P>LSDateFormat formats the date portion of a date/time
value using the locale convention. 

<P>The locale for this system is <CFOUTPUT>#GetLocale()#</CFOUTPUT>

<cfset MyLoc = "#Server.Coldfusion.SupportedLocales#">
<cfoutput><Br>MyLoc: #MyLoc#</cfoutput>

<!--- loop through a list of possible locales and
show date values for Now()--->
<CFLOOP LIST="#Server.Coldfusion.SupportedLocales#"
INDEX="locale" DELIMITERS=",">
    <CFSET oldlocale = SetLocale(locale)> 

    <CFOUTPUT>
	    <P><B><I>#locale#</I></B><BR>
<!---         
		#LSDateFormat(Now(), "mmm-dd-yyyy")#<BR>
        #LSDateFormat(Now(), "mmmm d, yyyy")#<BR>
        #LSDateFormat(Now(), "mm/dd/yyyy")#<BR>
        #LSDateFormat(Now(), "d-mmm-yyyy")#<BR>
        #LSDateFormat(Now(), "ddd, mmmm dd, yyyy")#<BR>
 --->
        #LSDateFormat(Now(), "d/m/yy")#<BR>
        #LSDateFormat(Now())#<BR>     
        <Hr noshade>
    </CFOUTPUT>

</CFLOOP>

</BODY>
</HTML>       
