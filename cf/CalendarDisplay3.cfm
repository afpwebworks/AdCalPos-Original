
<cfsilent> 
<!--------[   Create defaults for the date range.  use session variables if they are set,  otherwise create defaults from now() - MK ]------>
<cfoutput>
<cfif structKeyExists(session, "startdate") and isdate(session.startdate) >
	<cfset startdate = session.startdate >
 <cfelse>
	<cfscript>
		createstartdate = createdate( datepart("yyyy", now()), datepart("m", now()), "1");
		startdate = dateformat(createstartdate, "dd/mm/yyyy");
    </cfscript>
</cfif>
<cfif structKeyExists(session, "enddate")  and isdate(session.enddate)>
	<cfset enddate = session.enddate >
<cfelse>
	<cfset enddate = dateformat(now(), "dd/mm/yyyy") >
</cfif> 
</cfoutput>   
</cfsilent>  

<cfoutput> 
 Date Range:  <input type="text" id="daterange" name="daterange" style="width: 350px;" value="#startdate# -to- #enddate#" autofocus >
</cfoutput>  


<script>
// function for displaying date range picker	  
 $(document).ready(function() {
		  $('#daterange').daterangepicker({
			showDropdowns: true,
			separator: ' -to- ', 
			format: 'DD/MM/YYYY',
			ranges: {
				 'Today': [moment(), moment()],
				 'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
				 'Last 7 Days': [moment().subtract('days', 6), moment()],
				 'Last 30 Days': [moment().subtract('days', 29), moment()],
				 'This Month': [moment().startOf('month'), moment().endOf('month')],
				 'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
			  }
			
		  });
	   });
</script>
