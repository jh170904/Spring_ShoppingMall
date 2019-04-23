var xmlHttp;//변수생성

function createXMLHttpRequest(){
	
	if(window.XMLHttpRequest){
		xmlHttp = new XMLHttpRequest();//non IE
	}else if(window.ActiveXObject){
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");//IE5.0이후			
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE5.0이전	
		}
	}
	return xmlHttp;
}
