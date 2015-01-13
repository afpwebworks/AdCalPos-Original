
<!---------------------------------------------------------------------- 
This example illustrates use of the CFEXECUTE tag. 
----------------------------------------------------------------------->
<HTML>
<HEAD>
<TITLE>CFEXECUTE</TITLE>
</HEAD>

<BODY>
<H3>CFEXECUTE</H3>
<P>
This example executes the Windows NT version of the netstat network 
monitoring program, and places its output in a file.

<CFEXECUTE NAME="calc.exe"
    TIMEOUT="10">

</CFEXECUTE>
</BODY>
</HTML>       
