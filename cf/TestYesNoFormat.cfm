
<!--- This example shows the YesNoFormat --->
<HTML>
<HEAD>
<TITLE>YesNoFormat Example</TITLE>
</HEAD>

<BODY>
<H3>YesNoFormat Example</H3>

<P>The YesNoFormat function returns all non-zero values
as "YES" and zero values as "NO".

<CFOUTPUT>
<UL>
    <LI>YesNoFormat(1):    #YesNoFormat(1)#
    <LI>YesNoFormat(0):    #YesNoFormat(0)#
    <LI>YesNoFormat("1123"):    #YesNoFormat("1123")#
    <LI>YesNoFormat("No"):    #YesNoFormat("No")#
    <LI>YesNoFormat(TRUE):    #YesNoFormat(TRUE)#
    <LI>YesNoFormat(-1):    #YesNoFormat(-1)#
    <LI>YesNoFormat(2):    #YesNoFormat(2)#
</UL>
</CFOUTPUT>

</BODY>
</HTML>       

