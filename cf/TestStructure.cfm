
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

   <CFScript>
     employee=StructNew();
     StructInsert(employee, "firstname", "Mohammad");
     StructInsert(employee, "lastname", "Haghdoosti");
     StructInsert(employee, "email", "mh@mpsw.com.au");
     StructInsert(employee, "phone", "9415 1121");
     StructInsert(employee, "department", "Programming"); 
   </CFScript> 
  <cfoutput>employee: #employee#</cfoutput>


</body>
</html>
