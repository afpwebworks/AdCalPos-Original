
<CFQUERY name="GetRecord" datasource="#application.dsn#" > 
<!--- <CFQUERY name="GetRecord" dataSource="costi"> --->
	SELECT * 
	FROM tblEmpCasualRatesSat
</CFQUERY>
<HTML><HEAD>
	<TITLE>tblEmpCasualRatesSat - View Record</TITLE>
</HEAD><BODY bgcolor="ffffff">


<table width="80%" border="1">
  <tr> 
    <td> 
      <div align="center"><b>Edit</b></div>
    </td>
    <td> 
      <div align="center"><b>ID</b></div>
    </td>
    <td> 
      <div align="center"><b>Age From</b></div>
    </td>
    <td> 
      <div align="center"><b>Age To</b></div>
    </td>
    <td> 
      <div align="center"><b>From (minutes)</b></div>
    </td>
    <td> 
      <div align="center"><b>To (minutes)</b></div>
    </td>
    <td> 
      <div align="center"><b>Shift Allowance</b></div>
    </td>
  </tr>
<CFOUTPUT query="GetRecord">
  <tr> 
    <td> 
      <div align="center"><a href="tblEmpCasualRatesSat_RecordView.cfm?RecordID=#GetRecord.ID#">Edit</a></div>
    </td>
    <td> 
      <div align="center">#GetRecord.ID#</div>
    </td>
    <td> 
      <div align="right">#GetRecord.AgeFrom#</div>
    </td>
    <td> 
      <div align="right">#GetRecord.AgeTo#</div>
    </td>
    <td> 
      <div align="right">#GetRecord.ShiftMinsFrom#</div>
    </td>
    <td> 
      <div align="right">#GetRecord.ShiftMinsTo#</div>
    </td>
    <td> 
      <div align="right">#GetRecord.ShiftAllowance#</div>
    </td>
  </tr>
</CFOUTPUT>
</table>

</BODY></HTML>
