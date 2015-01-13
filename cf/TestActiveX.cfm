
<HTML>
<HEAD>
<TITLE>CFOBJECT (com) Example</TITLE>
</HEAD>

<BODY>
<H3>CFOBJECT (com) Example</H3>
<!---
Create a com object as an inproc server (DLL).
(CLASS= prog-id)
--->
<cfset lngStart = gettickcount()>
<CFOBJECT ACTION="Create"
    TYPE="com"
    CLASS=Pay.Payroll
    NAME="obj"> 

<!---
Call a method.
Note that methods that expect no arguments should 
be called using empty parenthesis.
--->
<CFSET dblPayVal = obj.AmountDue("03052003" , 2)>

<cfset lngFinish = gettickcount()>
<cfset lngTimeTaken = lngFinish - lngStart >
<!---
This object is a collection object, and should 
support at a minimum:
Property : Count
Method : Item(inarg, outarg)
and a special property called _NewEnum 
--->
<CFOUTPUT>
  <br>#dblPayVal#
  <br>Time taken is #lngTimeTaken# miliseconds.
  <BR>
  <HR>
</CFOUTPUT>


</BODY>
</HTML>

