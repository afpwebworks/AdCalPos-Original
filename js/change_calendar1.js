
function changeMonth(f,m){
	var v=eval("document."+f+".calMonth.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?month="+v+"&current="+m;
	}
	else{
		var s=l.slice(0,p)+"?month="+v+"&current="+m;
	}
	location.replace(s);
}
function changeYear(f,y){
	var v=eval("document."+f+".calYear.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?year="+v+"&current="+y;
	}
	else{
		var s=l.slice(0,p)+"?year="+v+"&current="+y;
	}
	location.replace(s);
}
