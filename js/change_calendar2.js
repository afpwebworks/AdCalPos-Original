
function changeMonth1(f,m){
	var v=eval("document."+f+".calMonth1.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?month1="+v+"&current="+m;
	}
	else{
		var s=l.slice(0,p)+"?month1="+v+"&current="+m;
	}
	location.replace(s);
}
function changeMonth2(f,m){
	var v=eval("document."+f+".calMonth2.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?month2="+v+"&current="+m;
	}
	else{
		var s=l.slice(0,p)+"?month2="+v+"&current="+m;
	}
	location.replace(s);
}
function changeYear1(f,y){
	var v=eval("document."+f+".calYear1.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?year1="+v+"&current="+y;
	}
	else{
		var s=l.slice(0,p)+"?year1="+v+"&current="+y;
	}
	location.replace(s);
}
function changeYear2(f,y){
	var v=eval("document."+f+".calYear2.options.value");
	var l=location.href;
	var p=l.indexOf('?');
	if(p==-1){
		var s=l+"?year2="+v+"&current="+y;
	}
	else{
		var s=l.slice(0,p)+"?year2="+v+"&current="+y;
	}
	location.replace(s);
}
