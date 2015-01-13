
<!--- This example shows the CFGRID, CFGRIDCOLUMN, CFGRIDROW,
and CFGRIDUPDATE tags in action --->

<!--- use a query to show the useful qualities of CFGRID --->


<!--- query the database to fill up the grid --->
<CFQUERY NAME="GetCourses" DATASOURCE="costi">
	SELECT  Age, FullTimeHourlyPay, CasualHourlyPay,  MyLinkView from tblEmpAwardPayRates
</CFQUERY>

<HTML>
<HEAD>
<TITLE>
	Employee Award Pay Rates
</TITLE>
</HEAD>

<BODY>
<H3>Employee Award Pay Rates</H3>

<!--- call the CFFORM to allow us to use CFGRID controls --->
<CFFORM ACTION="TGridSubmit3.cfm" NAME = "TEST" METHOD="GET" >
<CFGRID NAME="FirstGrid" QUERY="GetCourses" SELECTMODE="SINGLE" SORT = "YES" BGCOLOR="white" WIDTH="400" FONT="Tahoma" selectcolor="3366FF" ROWHEADERS="No">
	<CFGRIDCOLUMN NAME="Age" HREF="MyLinkView" SELECT="Yes" FONTSIZE="16" DATAALIGN ="Right" HEADERFONT="Tahoma" HEADERFONTSIZE="16" HEADERBOLD="Yes" BOLD="Yes">
	
    <CFGRIDCOLUMN NAME="FullTimeHourlyPay" HEADER="Full Time Hourly Pay"
        HEADERALIGN="LEFT" DATAALIGN="RIGHT" 
        BOLD="Yes" 
		FONTSIZE="16" FONT="Tahoma"
        SELECT="Yes" DISPLAY="Yes" 
        HEADERBOLD="Yes" HEADERFONT="Tahoma" HEADERFONTSIZE="16">
    <CFGRIDCOLUMN NAME="CasualHourlyPay" HEADER="Casual Hourly Pay"
        HEADERALIGN="LEFT" DATAALIGN="RIGHT" 
        BOLD="Yes" 
		FONTSIZE="16" FONT="Tahoma" 
        SELECT="Yes" DISPLAY="Yes" 
        HEADERBOLD="Yes"  HEADERFONT="Tahoma" HEADERFONTSIZE="16">

</CFGRID>
</CFFORM>


</BODY>
</HTML>
