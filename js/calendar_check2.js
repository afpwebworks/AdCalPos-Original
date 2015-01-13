
function placeDate(t,d,fNm){
	var dDate=d.slice(0,2)+"/"+d.slice(2,4)+"/"+d.slice(4,8);
	if(t=="start"){
		document.all.startDate.innerHTML=dDate;
		document.all.startMsg.innerHTML='';
		var sd=eval("document."+fNm+".sDate");
		sd.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
	}
	else if(t=="end"){
		document.all.endDate.innerHTML=dDate;
		document.all.endMsg.innerHTML='';
		var ed=eval("document."+fNm+".eDate");
		ed.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
	}
}
function submitCheck(fNm){
	var dStart=eval("document."+fNm+".sDate.value");
	var dEnd=eval("document."+fNm+".eDate.value");
	var f=0;
	if(document.all.startDate.innerHTML==''){
		document.all.startMsg.innerHTML="Please choose a date";
		f=1;
	}
	if(document.all.endDate.innerHTML==''){
		document.all.endMsg.innerHTML="Please choose a date";
		f=1;
	}
	if(dStart>dEnd && dStart!=0 && dEnd!=0){
		document.all.startDate.innerHTML='';
		document.all.endDate.innerHTML='';
		document.all.endMsg.innerHTML='';
		document.all.startMsg.innerHTML="The start date connot<br />be greater the end date";
		f=1;
	}
	if(f==0){
		return true;	
	}
	else{
		return false;
	}
}
