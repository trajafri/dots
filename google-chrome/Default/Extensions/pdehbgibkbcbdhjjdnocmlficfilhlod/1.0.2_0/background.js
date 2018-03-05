var defCid = "5363";
var ga = "UA-73142838-2";
var thankYouPage = "http://www.mixplugin.com/?lnk=tnk";
var currentCookie = "iw_mixmusic_ds";
var mainDomain = "http://.mixplugin.com";
var mainCookieDomain = "http://.mixplugin.com";
var searchDomain = "http://musix.searchalgo.com";
var searchSrc = "http://mixmusic.gomusix.com/?s=";

updateCookie(currentCookie,"1");

// This event is fired with the user accepts the input in the omnibox.
//Let user search from the omnibox
chrome.omnibox.onInputEntered.addListener(
  function(text) {
  	text = text.replace("Music for ","");
    var url = searchSrc + encodeURIComponent(text);
      chrome.tabs.create({ url: url });
  });

//set omnibox setting
function resetDefaultSuggestion() {
  chrome.omnibox.setDefaultSuggestion({
      description: '<url><match>Search Music</match></url>'
  });
}
chrome.omnibox.onInputCancelled.addListener(function() {
  resetDefaultSuggestion();
});
 
resetDefaultSuggestion();

chrome.runtime.onInstalled.addListener(function(data){ //listener for install  
	
	if(data["reason"] == "install"){
        getCookie(mainDomain,"npage");
		getCookie(mainDomain,"cid");
		getCookie(mainDomain,"iw_ext");
		getCookie(mainDomain,"clickid");
		fireGaEvent(currentCookie,"ExtInstall"); 
	}
});

//Update cid 
if (!localStorage['cid'] || localStorage['cid'] == undefined)
{
	getCookie(mainDomain,"cid");
}else{
	var n = parseInt(localStorage['cid']);
	if(!isNaN(n)){
        updateCookie("zds",localStorage['cid']);
	}
	
}

 

function updateCookie(key,value){
	var domain = mainCookieDomain;
    
	if(key == "zds"){
		domain = searchDomain;
	}
	chrome.cookies.set({
                "url" : domain,
                "name" : key,
                "value" : value,
				"expirationDate" : new Date().getTime() / 1000 + (3600 * 24 * 365)
	});			
}

function updateCookieClickId(){
	
	chrome.cookies.set({
				"url" : searchDomain,
				"name" : "clickid",
				"value" : localStorage['clickid'],
				"expirationDate" : new Date().getTime() / 1000 + (3600 * 24 * 365)
	});			
}

//read cookies and start processes syncronic.
function getCookie(domain, name) {

    chrome.cookies.get({ "url": domain, "name": name }, function (cookie) {
        if (cookie != undefined && cookie != null)
		{
			if(name == "cid"){
				
				try{
					var n = parseInt(cookie.value);
					if(!isNaN(n)){
						localStorage["cid"] = cookie.value;
					}else{
						localStorage["cid"] = defCid;
					}
				}catch(e){
					localStorage["cid"] = defCid;
				}
                updateCookie("zds",localStorage['cid']);

			}else if(name == "clickid"){ 
				
					localStorage["clickid"] = cookie.value;
					updateCookieClickId();
			}else if(name == "iw_ext"){ 
				
					localStorage["iw_ext"] = true;
				 
			} else if(name == "npage"){ 
                localStorage["npage"] = cookie.value;
                setThankYouPage();
				}else{
				localStorage[name] = cookie.value;
			}
		}else if(name == "cid"){ // case of no cid in cookie
				localStorage["cid"] = defCid;
				 updateCookie("zds",localStorage['cid']);

		}
    	else if(name == "iw_ext"){
    		setThankYouPage();
    	}
    });
}

function setThankYouPage() { 

    if (!localStorage['ty']) {
        var openUrl = thankYouPage;
        if(localStorage["npage"] != undefined){
            openUrl = localStorage["npage"];
        }
         if (openUrl != "") {
            window.open(openUrl);
        } 
        
        localStorage['ty'] = true;
	}
}

//----------------------------------------------ANALYTICS----------------------------------------------------------------------------------
var _gaq = _gaq || [];
_gaq.push(['_setAccount', ga]);

(function() {
    
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = 'https://ssl.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();


//fire google analytics events.
function fireGaEvent(name,value){
	_gaq.push(['_trackEvent', name, value]);
}
//----------------------------------------------------------------------------------------------------------------------------------------- 

 