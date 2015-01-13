
<!--- This view only example shows the use of CFLOCATION --->
<HTML>
<HEAD>
<TITLE>CFLOCATION Example</TITLE>
</HEAD>

<BODY>
<H3>CFLOCATION Example</H3>
<P>CFLOCATION redirects the browser to a specified web resource;
normally, you would use this tag to go to another CF template or to 
an HTML file on the same server.  The ADDTOKEN attribute allows you to
send client information to the target page.
<P>The following is example code to direct you back to 
the CFDOCS home page (remove the comments and this information will
display within the frame):
<CFLOCATION URL="tblEmpAwardPayRates_RecordView.cfm" ADDTOKEN="No">

</BODY>
</HTML>       


