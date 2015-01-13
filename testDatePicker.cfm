<cfsilent>
<!----
==========================================================================================================
Filename:     testDatePicker.cfm
Description:  test page for setting up date range picker
Date:         20/03/2014
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
</cfsilent>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<!--------[  <script src="/js/moment.min.js"></script>  - MK ]------>
<script src="/js/jquery.daterange.js"></script>
<form>
 <input id="datepicker" class="demo" style="width:250px;">
</form>

<script>
// function for displaying date range picker	  
 $(document).ready(function () {
    $("#datepicker").daterange({
       dateFormat: "dd/mm/yy", //date format
       rangeSeparator: " to " // the string between first and last date
    });
 });
</script>