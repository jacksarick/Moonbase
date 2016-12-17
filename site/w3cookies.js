/*
 *  Basically a straight copypasta of W3's
 *  http://www.w3schools.com/js/js_cookies.asp
 */

// I think my naming convention is funny
function cookieDough(cname, cvalue, days) {
	var d = new Date();
	d.setTime(d.getTime() + (24*60*60*1000));
	var expires = "expires="+ d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function setCookie(name, value) {
	// We set cookies for one day to keep them fresh!
	cookieDough(name, value, 1)
}

function eatCookie(name) {
	// Set cookie to nothing a day in the past to destroy it
	cookieDough(name, "", -1)
}

function getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for(var i = 0; i <ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
} 