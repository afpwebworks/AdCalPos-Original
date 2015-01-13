
<html>
<head>
	<title>Purchase Order</title>
</head>
<link rel="stylesheet" type="text/css" href="costi.css">
<body>
	<cfinclude template="navbar_header_small.cfm">
<table width="100%">
  <tr valign="middle"> 
    <td width="25%"><a href="MainMenu.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/butHomeDown.gif',1)" target="_self">
		<img name="home" border="0" src="../images/butHomeUp.gif" width="114" height="34" align="top"></a></td>
 	<td> 
      <h1>Purchase Order</h1>
    </td>
    <td width="25%"> 
      <div align="right"><a href="PurchaseOrderRequest.cfm.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('backImage','','../images/butBackDown.gif',1)" target="_self"><img name="backImage" border="0" src="../images/butBackUp.gif" width="115" height="34"></a></div>
    </td>
  </tr>
</table>
<a name="PageTop"></a>
<div align="center">
	<h3>Cannot place another Frozen Goods order<br/>(A Frozen Goods order for the date selected has been placed and printed already).</h3>
</div>
<a name="PageBottom"></a>
</body>
</html>
