<cfsilent>
<!----
==========================================================================================================
Filename:     jquery.cfm
Description:  jQuery include file for adcalpos demo site
Date:         18/3/2014
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
</cfsilent>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.tablesorter.min.js"></script>
<!--------[  <script src="/js/jquery.daterange.js"></script>  - MK ]------>
<script src="/js/moment.min.js"></script>
<script src="/js/daterangepicker.js"></script>
<script>
  $(document).ready(function() 
   {
	$("table#id2").tablesorter();   
  $("table#id2 tr:even").addClass("even"); 
  $("table#id2 tr:odd").addClass("odd");
  $('table#id2 tr').hover(function ()
	{
	  $(this).toggleClass('rowHighlight');
	});
  $('table#id2 tr').click(function ()
      {
        location.href = $(this).find('td a').attr('href');
	  })
 });	
</script>
<!--------[   $(document).ready(function () {
    $("#datepicker").daterange({
       dateFormat: "dd/mm/yy", //date format
       rangeSeparator: " -to- " // the string between first and last date
    });
 });  - MK ]------>
<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/bootstrap-responsive.min.css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/daterangepicker-bs3.css">