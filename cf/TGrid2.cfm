
<!--- This example shows the CFGRID, CFGRIDCOLUMN, CFGRIDROW,
and CFGRIDUPDATE tags in action --->

<!--- use a query to show the useful qualities of CFGRID --->


<!--- query the database to fill up the grid --->
<CFQUERY NAME="GetCourses" DATASOURCE="costi">
SELECT Course_ID, Dept_ID, CorNumber,
         CorName, CorLevel, CorDesc, 'tblEmpAwardPayRates_RecordList.cfm?RecordID=' & [Course_ID] as MyLink 
FROM   CourseList
ORDER by Dept_ID ASC, CorNumber ASC
</CFQUERY>

<HTML>
<HEAD>
<TITLE>
CFGRID Example
</TITLE>
</HEAD>

<BODY>
<H3>CFGRID Example</H3>

<I>Try adding a course to the database, and then deleting it.</I>
<!--- call the CFFORM to allow us to use CFGRID controls --->
<CFFORM ACTION="TGridSubmit.cfm" NAME = "TEST" METHOD="GET" >

<!--- We include Course_ID in the CFGRID, but do not allow
for its selection or display --->
<!--- CFGRIDCOLUMN tags are used to change the parameters
involved in displaying each data field in the table--->

<!--- This example shows the CFGRID, CFGRIDCOLUMN, CFGRIDROW,
and CFGRIDUPDATE tags in action --->



<CFGRID NAME="FirstGrid" WIDTH="450" 
    QUERY="GetCourses" INSERT="Yes"
    DELETE="Yes" SORT="Yes" 
    FONT="Tahoma" BOLD="No" ITALIC="No"
    APPENDKEY="No" HIGHLIGHTHREF="No" 
    GRIDDATAALIGN="LEFT" GRIDLINES="Yes"
    ROWHEADERS="Yes" ROWHEADERALIGN="LEFT" 
    ROWHEADERITALIC="No" ROWHEADERBOLD="No" 
    COLHEADERS="Yes" COLHEADERALIGN="LEFT"
    COLHEADERITALIC="No" COLHEADERBOLD="No" 
    SELECTCOLOR="Red" SELECTMODE="EDIT" 
    PICTUREBAR="No" INSERTBUTTON="To insert"
    DELETEBUTTON="To delete" SORTASCENDINGBUTTON="Sort ASC"
    SORTDESCENDINGBUTTON="Sort DESC">
    <CFGRIDCOLUMN NAME="Course_ID" HREF="MyLink" DATAALIGN="LEFT" 
        BOLD="No" ITALIC="No"
        SELECT="No" DISPLAY="Yes" 
        HEADERBOLD="No" HEADERITALIC="No"
		>
    <CFGRIDCOLUMN NAME="Dept_ID" HEADER="Department"
        HEADERALIGN="LEFT" DATAALIGN="LEFT" 
        BOLD="Yes" ITALIC="No"
        SELECT="Yes" DISPLAY="Yes" 
        HEADERBOLD="No" HEADERITALIC="Yes">
    <CFGRIDCOLUMN NAME="CorNumber" HEADER="Course ##"
        HEADERALIGN="LEFT" DATAALIGN="LEFT" 
        BOLD="No" ITALIC="No"
        SELECT="Yes" DISPLAY="Yes" 
        HEADERBOLD="No" HEADERITALIC="No">
    <CFGRIDCOLUMN NAME="CorName" HEADER="Name" 
        HEADERALIGN="LEFT" DATAALIGN="LEFT" 
        FONT="Times" BOLD="No" 
        ITALIC="No" SELECT="Yes"
        DISPLAY="Yes" HEADERBOLD="No" 
        HEADERITALIC="No">
    <CFGRIDCOLUMN NAME="CorLevel" HEADER="Level" 
        HEADERALIGN="LEFT" DATAALIGN="LEFT" 
        BOLD="No" ITALIC="No" 
        SELECT="Yes" DISPLAY="Yes"
        HEADERBOLD="No" HEADERITALIC="No">
    <CFGRIDCOLUMN NAME="CorDesc" HEADER="Description"
        HEADERALIGN="LEFT" DATAALIGN="LEFT" 
        BOLD="No" ITALIC="No"
        SELECT="Yes" DISPLAY="Yes" 
        HEADERBOLD="No" HEADERITALIC="No">

</CFGRID>

<!--- If the gridEntered form field has been tripped,
perform the gridupdate on the table specified in the database.
Using the default value keyonly=yes allows us to change only
the information that differs from the previous grid --->
<p><input type="submit" name="Submit" value="Save Changes"></p>
</CFFORM>


</BODY>
</HTML>
