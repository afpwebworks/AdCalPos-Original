
<!--- This example shows ArrayClear --->
<HTML>
<HEAD>
<TITLE>ArrayClear Example</TITLE>
</HEAD>

<BODY>
<H3>ArrayClear Example</H3>

<!--- create a new array --->
<CFSET MyArray = ArrayNew(1)>
<!--- populate an element or two --->
<CFSET MyArray[1] = "Test">
<CFSET MyArray[2] = "Other Test">
<!--- output the contents of the array --->
<P>Your array contents are:
<CFOUTPUT>#ArrayToList(MyArray)#</CFOUTPUT>
<!--- check if the array is empty --->
<P>Is the array empty?:
<CFOUTPUT>#ArrayIsEmpty(MyArray)#</CFOUTPUT>
<P>Now, clear the array:
<!--- now clear the array --->
<CFSET Temp = ArrayClear(MyArray)>
<!--- check if the array is empty --->
<P>Is the array empty?:
<CFOUTPUT>#ArrayIsEmpty(MyArray)#</CFOUTPUT>

</BODY>
</HTML>      

