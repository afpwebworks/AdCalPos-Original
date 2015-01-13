
function placeDate(t,d,fNm){
	var dDate=d.slice(0,2)+"/"+d.slice(2,4)+"/"+d.slice(4,8);
	document.all.date.innerHTML=dDate;
	document.all.msg.innerHTML='';
	var sd=eval("document."+fNm+".sDate");
	sd.value=d.slice(4,8)+d.slice(2,4)+d.slice(0,2);
}
function submitCheck(fNm){
	var dStart=eval("document."+fNm+".sDate.value");
	var f=0;
	if(document.all.date.innerHTML==''){
		document.all.msg.innerHTML="Please choose a date";
		f=1;
	}
	if(f==0){
		return true;	
	}
	else{
		return false;
	}
}
