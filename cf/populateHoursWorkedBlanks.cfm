
<CFOUTPUT>
<PRE>
#allIDs#
<br>
#allWeekdates#
<br>
#WeekEndingDate#
<br>
#lngStoreID#
<br>
#strStoreName#
<br>
#lngNumRecords#
</pre>
	<CFLOOP list="#allIDs#" index="userLoop">
	 <CFLOOP list="#allWeekDates#" index="dateLoop">
	  <CFQUERY name="insertsNeeded" datasource="#application.dsn#" > 
	   select * from tblEmpHoursWorked
	    where WeekEnding = #WeekEndingDate# 
		  and storeID    = #lngStoreID#
		  and dateWorked = #dateLoop#
		  and employeeID = #userLoop#  
	  </CFQUERY>
	  <CFIF insertsNeeded.recordCount is 0>
	      <CFQUERY name="insertsNeeded" datasource="#application.dsn#" > 
	   INSERT INTO tblEmpHoursWorked 
	   ( WeekEnding, EmployeeID, StoreID, DateWorked, StartTime, EndTime, StartRoster, EndRoster )
	   Values 
	   ('#WeekEndingDate# ', #userLoop# , #lngStoreID# , '#dateLoop#' , '0000' , '0000'  , '0000' , '0000' )
	  </CFQUERY>
	  </cfif>
	 </cfloop>
	</cfloop>

  <CFSET outputdate = "#MID(WeekEndingDate,5,4)#-#MID(WeekEndingDate,3,2)#-#MID(WeekEndingDate,1,2)#">
  <cflocation url="HoursWorkedMultiple.cfm?weekEndingDate=#outputDate#">
</cfoutput>
