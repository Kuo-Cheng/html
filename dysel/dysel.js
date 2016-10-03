function jsFuncOne(){
	//alert("jsFuncOne!!!");
	if(jquery3){
            alert($.fn.jquery);
	}else{
            alert("No jquery3");
        }
}

var jquery17;
var jqueryNew3;

function jsFuncTwo(){
    if(jquery3){
        jquery17 = document.createElement('script');
        jquery17.src = "jquery-1.7.js";
        document.documentElement.firstChild.replaceChild(jquery17, jquery3);        
        jquery17.addEventListener('load', postLoadJQueryFunction);
    }
	
}

function jsFuncThree(){
    if(jquery17){
        var jqueryNew3 = document.createElement('script');
        jqueryNew3.src = "jquery-3.0.js";
        document.documentElement.firstChild.replaceChild(jqueryNew3, jquery17);        
        jqueryNew3.addEventListener('load', postLoadJQueryFunction);      
        
        jquery3 = jqueryNew3;
        
    }
}

function postLoadJQueryFunction(){
    alert("postLoadJQueryFunction!!!");
}