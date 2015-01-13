
function placeDate(t,d,fNm){
	var dDate=d.slice(0,2)+"/"+d.slice(2,4)+"/"+d.slice(4,8);
	if(t=="start"){
		document.all.date.innerHTML=dDate;
		document.all.msg.innerHTML='';
		var sd=eval("document."+fNm+".sDate");
		sd.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
	}
	else if(t=="second"){
		document.all.dDate2.innerHTML=dDate;
		document.all.msg2.innerHTML='';
		var sd=eval("document."+fNm+".date2");
		sd.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
	}
	else if(t=="third"){
		document.all.dDate3.innerHTML=dDate;
		document.all.msg3.innerHTML='';
		var td=eval("document."+fNm+".date3");
		td.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
	}
}
function submitCheck(fNm){
	var dStart=eval("document."+fNm+".sDate.value");
	var dSecond=eval("document."+fNm+".date2.value");
	var dThird=eval("document."+fNm+".date3.value");
	var f=0;
	if(document.all.date.innerHTML==''){
		document.all.msg.innerHTML="Please choose a date";
		f=1;
	}
	if(document.all.dDate2.innerHTML==''){
		document.all.msg2.innerHTML="Please choose a date";
		f=1;
	}
	if(document.all.dDate3.innerHTML==''){
		document.all.msg3.innerHTML="Please choose a date";
		f=1;
	}
	if(f==0){
		return true;	
	}
	else{
		return false;
	}
}
