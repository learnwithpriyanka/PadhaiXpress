Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
		if (typeof usi_commons === 'undefined') {
			usi_commons = {
				
				debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
				
				log:function(msg) {
					if (usi_commons.debug) {
						try {
							if (msg instanceof Error) {
								console.log(msg.name + ': ' + msg.message);
							} else {
								console.log.apply(console, arguments);
							}
						} catch(err) {
							usi_commons.report_error_no_console(err);
						}
					}
				},
				log_error: function(msg) {
					if (usi_commons.debug) {
						try {
							if (msg instanceof Error) {
								console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
							} else {
								console.log('%c USI Error:', usi_commons.log_styles.error, msg);
							}
						} catch(err) {
							usi_commons.report_error_no_console(err);
						}
					}
				},
				log_success: function(msg) {
					if (usi_commons.debug) {
						try {
							console.log('%c USI Success:', usi_commons.log_styles.success, msg);
						} catch(err) {
							usi_commons.report_error_no_console(err);
						}
					}
				},
				dir:function(obj) {
					if (usi_commons.debug) {
						try {
							console.dir(obj);
						} catch(err) {
							usi_commons.report_error_no_console(err);
						}
					}
				},
				log_styles: {
					error: 'color: red; font-weight: bold;',
					success: 'color: green; font-weight: bold;'
				},
				domain: "https://app.upsellit.com",
				cdn: "https://www.upsellit.com",
				is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
				device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
				gup:function(name) {
					try {
						name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
						var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
						var regex = new RegExp(regexS);
						var results = regex.exec(window.location.href);
						if (results == null) return "";
						else return results[1];
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load_script:function(source, callback, nocache) {
					try {
						if (source.indexOf("//") == 0) source = "https:"+source;
						if (source.indexOf("/pixel.jsp") != -1 || source.indexOf("/blank.jsp") != -1 || source.indexOf("/customer_ip.jsp") != -1) {
							source = source.replace(usi_commons.cdn, usi_commons.domain);
						}
						var docHead = document.getElementsByTagName("head")[0];
						//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
						var newScript = document.createElement('script');
						newScript.type = 'text/javascript';
						var usi_appender = "";
						if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
							usi_appender = (source.indexOf("?")==-1?"?":"&");
							if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
							usi_appender += "si=" + usi_commons.get_sess();
						}
						newScript.src = source + usi_appender;
						if (typeof callback == "function") {
							newScript.onload = function() {
								try {
									callback();
								} catch (e) {
									usi_commons.report_error(e);
								}
							};
						}
						docHead.appendChild(newScript);
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load_view:function(usiHash, usiSiteID, usiKey, callback) {
					try {
						if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
							usiKey = usiKey || "";
							var usi_append = "";
							if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
							else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
							if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
							var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
							if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
							usi_commons.last_view = usiSiteID+"_"+usiKey;
							if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
							usi_commons.load_script(source, callback);
						}
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				remove_loads:function() {
					try {
						if (document.getElementById("usi_obj") != null) {
							document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
						}
						if (typeof(usi_commons.usi_loads) !== "undefined") {
							for (var i in usi_commons.usi_loads) {
								if (document.getElementById("usi_"+i) != null) {
									document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
								}
							}
						}
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load:function(usiHash, usiSiteID, usiKey, callback){
					try {
						if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
						usiKey = usiKey || "";
						var usi_append = "";
						if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
						else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
						if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
						var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
						usi_commons.load_script(source, callback);
						if (typeof(usi_commons.usi_loads) === "undefined") {
							usi_commons.usi_loads = {};
						}
						usi_commons.usi_loads[usiSiteID] = usiSiteID;
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load_precapture:function(usiQS, usiSiteID, callback) {
					try {
						if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
						usi_commons.last_precapture_siteID = usiSiteID;
						var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
						usi_commons.load_script(source, callback);
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load_mail:function(qs, siteID, callback) {
					try {
						var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
						usi_commons.load_script(source, callback);
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				load_products:function(options) {
					try {
						if (!options.siteID || !options.pid) return;
						var queryStr = "";
						var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name', 'ordersID', 'cartsID', 'viewsID', 'companyID', 'order_by'];
						params.forEach(function(name, index){
							if (options[name]) {
								queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
							}
						});
						if (options.filters) {
							queryStr += "&filters=" + encodeURIComponent(options.filters.map(function(filter){
								return encodeURIComponent(filter);
							}).join("&"));
						}
						usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter_v3.jsp' + queryStr, function(){
							if (typeof options.callback === 'function') {
								options.callback();
							}
						});
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				send_prod_rec:function(siteID, info, real_time) {
					var result = false;
					try {
						if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
							//Ignore translated pages
							return false;
						}
						var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
						if (data.indexOf(undefined) == -1) {
							var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
							if (info.extra) queryString += info.extra + "|";
							var filetype = real_time ? "jsp" : "js";
							usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
							result = true;
						}
					} catch (e) {
						usi_commons.report_error(e);
						result = false;
					}
					return result;
				},
				report_error:function(err) {
					if (err == null) return;
					if (typeof err === 'string') err = new Error(err);
					if (!(err instanceof Error)) return;
					if (typeof(usi_commons.error_reported) !== "undefined") {
						return;
					}
					usi_commons.error_reported = true;
					if (location.href.indexOf('usishowerrors') !== -1) throw err;
					else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
					usi_commons.log_error(err.message);
					usi_commons.dir(err);
				},
				report_error_no_console:function(err) {
					if (err == null) return;
					if (typeof err === 'string') err = new Error(err);
					if (!(err instanceof Error)) return;
					if (typeof(usi_commons.error_reported) !== "undefined") {
						return;
					}
					usi_commons.error_reported = true;
					if (location.href.indexOf('usishowerrors') !== -1) throw err;
					else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
				},
				gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
					try {
						if (typeof usi_cookies === 'undefined') {
							usi_commons.log_error('usi_cookies is not defined');
							return;
						}
						expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
						if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
						var value = null;
						var qsValue = usi_commons.gup(name);
						if (qsValue !== '') {
							value = qsValue;
							usi_cookies.set(name, value, expireSeconds, forceCookie);
						} else {
							value = usi_cookies.get(name);
						}
						return (value || '');
					} catch (e) {
						usi_commons.report_error(e);
					}
				},
				get_sess: function() {
					var usi_si = null;
					if (typeof(usi_cookies) === "undefined") return "";
					try {
						if (usi_cookies.get('usi_si') == null) {
							var usi_rand_str = Math.random().toString(36).substring(2);
							if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
							usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
							usi_cookies.set('usi_si', usi_si, 24*60*60);
							return usi_si;
						}
						if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
						usi_cookies.set('usi_si', usi_si, 24*60*60);
					} catch(err) {
						usi_commons.report_error(err);
					}
					return usi_si;
				},
				get_id: function(usi_append) {
					if (!usi_append) usi_append = "";
					var usi_id = null;
					try {
						if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
							var usi_rand_str = Math.random().toString(36).substring(2);
							if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
							usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
							usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
							return usi_id;
						}
						if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
						if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
						usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					} catch(err) {
						usi_commons.report_error(err);
					}
					return usi_id;
				},
				load_session_data: function(extended) {
					try {
						if (usi_cookies.get_json("usi_session_data") == null) {
							usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
						} else {
							usi_app.session_data = usi_cookies.get_json("usi_session_data");
							if (typeof(usi_app.session_data_callback) !== "undefined") {
								usi_app.session_data_callback();
							}
						}
					} catch(err) {
						usi_commons.report_error(err);
					}
				},
				customer_ip:function(last_purchase) {
					try {
						if (last_purchase != -1) {
							usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.never);
						} else {
							usi_app.main();
						}
					} catch(err) {
						usi_commons.report_error(err);
					}
				},
				customer_check:function(company_id) {
					try {
						if (!usi_app.is_enabled && !usi_cookies.value_exists("usi_ip_checked")) {
							usi_cookies.set("usi_ip_checked", "1", usi_cookies.expire_time.day);
							usi_commons.load_script(usi_commons.domain + "/utility/customer_ip2.jsp?companyID=" + company_id);
							return false;
						}
						return true;
					} catch(err) {
						usi_commons.report_error(err);
					}
				}
			};
			setTimeout(function() {
				try {
					if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
					if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
						usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
					}
				} catch(err) {
					usi_commons.report_error(err);
				}
			}, 1000);
		}

if (typeof usi_app === 'undefined' && location.href.indexOf("http") === 0) {
	try {
		if("undefined"==typeof usi_cookies){if(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,i,n){try{var t=-1;if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t=r.getTime()}var o=window.top||window,l=0;null!=i&&-1!=i.indexOf("=")&&(i=i.replace(RegExp("=","g"),"USIEQLS")),null!=i&&-1!=i.indexOf(";")&&(i=i.replace(RegExp(";","g"),"USIPRNS"));for(var a=o.name.split(";"),u="",f=0;f<a.length;f++){var c=a[f].split("=");3==c.length?(c[0]==e&&(c[1]=i,c[2]=t,l=1),null!=c[1]&&"null"!=c[1]&&(u+=c[0]+"="+c[1]+"="+c[2]+";")):""!=a[f]&&(u+=a[f]+";")}0==l&&(u+=e+"="+i+"="+t+";"),o.name=u}catch(s){}},flush_window_name:function(e){try{for(var i=window.top||window,n=i.name.split(";"),t="",r=0;r<n.length;r++){var o=n[r].split("=");3==o.length&&(0==o[0].indexOf(e)||(t+=n[r]+";"))}i.name=t}catch(l){}},get_from_window_name:function(e){try{for(var i,n,t=(window.top||window).name.split(";"),r=0;r<t.length;r++){var o=t[r].split("=");if(3==o.length){if(o[0]==e&&(n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),!("-1"!=o[2]&&0>usi_cookies.datediff(o[2]))))return i=[n,o[2]]}else if(2==o.length&&o[0]==e)return n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),i=[n,new Date().getTime()+6048e5]}}catch(l){}return null},datediff:function(e){return e-new Date().getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),i=e[e.length-1];if("com"==i||"net"==i||"org"==i||"us"==i||"co"==i||"ca"==i)return e[e.length-2]+"."+e[e.length-1]}catch(n){}return 0==document.domain.indexOf("www.")?document.domain.replace("www.",""):document.domain},create_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(i)+t+"; path=/;domain="+l+"; "+o}},create_nonencoded_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();document.cookie=e+"="+i+t+"; path=/;domain="+location.host+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain="+l+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain=; "+o}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var i=e+"=",n=[];try{n=document.cookie.split(";")}catch(t){}for(var r=0;r<n.length;r++){for(var o=n[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(i))return decodeURIComponent(o.substring(i.length,o.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(i){}},get_ls:function(e){try{var i=localStorage.getItem(e);if(null!=i){if(0==i.indexOf("{")&&-1!=i.indexOf("usi_expires")){var n=JSON.parse(i);if(new Date().getTime()>n.usi_expires)return localStorage.removeItem(e),null;i=n.value}return decodeURIComponent(i)}}catch(t){}return null},get:function(e){var i=usi_cookies.read_cookie(e);if(null!=i)return i;try{if(null!=localStorage&&(i=usi_cookies.get_ls(e),null!=i))return i;if(null!=sessionStorage&&(i=sessionStorage.getItem(e),void 0===i&&(i=null),null!=i))return decodeURIComponent(i)}catch(n){}var t=usi_cookies.get_from_window_name(e);if(null!=t&&t.length>1)try{i=decodeURIComponent(t[0])}catch(r){return t[0]}return i},get_json:function(e){var i=null,n=usi_cookies.get(e);if(null==n)return null;try{i=JSON.parse(n)}catch(t){n=n.replace(/\\"/g,'"');try{i=JSON.parse(JSON.parse(n))}catch(r){try{i=JSON.parse(n)}catch(o){}}}return i},search_cookies:function(e){e=e||"";var i=[];return document.cookie.split(";").forEach(function(n){var t=n.split("=")[0].trim();(""===e||0===t.indexOf(e))&&i.push(t)}),i},set:function(e,i,n,t){"undefined"!=typeof usi_nevercookie&&!0==usi_nevercookie&&(t=!1),void 0===n&&(n=-1);try{i=i.replace(/(\r\n|\n|\r)/gm,"")}catch(r){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",i+"",n);try{if(n>0&&null!=localStorage){var o=new Date,l={value:i,usi_expires:o.getTime()+1e3*n};localStorage.setItem(e,JSON.stringify(l))}else null!=sessionStorage&&sessionStorage.setItem(e,i)}catch(a){}if(t||null==i){if(null!=i){if(null==usi_cookies.read_cookie(e)&&!t&&usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count){usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);return}if(i.length>usi_cookies.max_cookie_length){usi_cookies.report_error('Cookie "'+e+'" truncated ('+i.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length);return}}usi_cookies.create_cookie(e,i,n)}},set_json:function(e,i,n,t){var r=JSON.stringify(i).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,r,n,t)},flush:function(e){e=e||"usi_";var i,n,t,r=document.cookie.split(";");for(i=0;i<r.length;i++)0==(n=r[i]).trim().toLowerCase().indexOf(e)&&(t=n.trim().split("=")[0],usi_cookies.del(t));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var o in localStorage)0==o.indexOf(e)&&localStorage.removeItem(o);if(null!=sessionStorage)for(var o in sessionStorage)0==o.indexOf(e)&&sessionStorage.removeItem(o)}catch(l){}},print:function(){for(var e=document.cookie.split(";"),i="",n=0;n<e.length;n++){var t=e[n];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(t.trim())+" (cookie)"),i+=","+t.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&"string"==typeof localStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+usi_cookies.get_ls(r)+" (localStorage)"),i+=","+r+",");if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&"string"==typeof sessionStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+sessionStorage[r]+" (sessionStorage)"),i+=","+r+",")}catch(o){}for(var l=(window.top||window).name.split(";"),a=0;a<l.length;a++){var u=l[a].split("=");if(3==u.length&&0==u[0].indexOf("usi_")&&-1==i.indexOf(","+u[0]+",")){var f=u[1];-1!=f.indexOf("USIEQLS")&&(f=f.replace(/USIEQLS/g,"=")),-1!=f.indexOf("USIPRNS")&&(f=f.replace(/USIPRNS/g,";")),console.log(u[0]+"="+f+" (window.name)"),i+=","+t.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,i;for(e=0;e<arguments.length;e++)if(i=usi_cookies.get(arguments[e]),""===i||null===i||"null"===i||"undefined"===i)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie)try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-new Date().getTime())/1e3,!0),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}-1!=location.href.indexOf("usi_clearcookies")&&usi_cookies.flush()}
"undefined"==typeof usi_dom&&((usi_dom={}).get_elements=function(e,t){var n=[];return t=t||document,n=Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"!==Object.prototype.toString.call(e))return t.querySelector(e);for(var n=null,r=0;r<e.length;r++){var i=e[r];if(null!=(n=usi_dom.get_first_element(i,t)))break}return n},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var r=0;r<e.childNodes.length;++r)3===e.childNodes[r].nodeType&&(n+=e.childNodes[r].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){return"string"!=typeof e?void 0:(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(r){usi_commons.log("Error: "+r.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(r){usi_commons.log("Error: "+r.message)}return t},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_currency=function(e,t,n){var r="";return isNaN(e)&&(e=usi_dom.currency_to_decimal(e)),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},r=Number(e).toLocaleString(t,n)):r=e),r},usi_dom.currency_to_decimal=function(e){return 0==e.indexOf("&")&&-1!=e.indexOf(";")?e=e.substring(e.indexOf(";")+1):-1!=e.indexOf("&")&&-1!=e.indexOf(";")&&(e=e.substring(0,e.indexOf("&"))),isNaN(e)&&(e=e.replace(/[^0-9,.]/g,"")),e.indexOf(",")==e.length-3&&(-1!=e.indexOf(".")&&(e=e.replace(".","")),e=e.replace(",",".")),e=e.replace(/[^0-9.]/g,"")},usi_dom.to_decimal_places=function(e,t){if(null==e||"number"!=typeof e||null==t||"number"!=typeof t)return null;if(0==t)return parseFloat(Math.round(e));for(var n=10,r=1;r<t;r++)n*=10;return parseFloat(Math.round(e*n)/n)},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var r=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,r),r.addEventListener?r.addEventListener(e,t,!1):r.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var r=usi_dom.find_supported_element(e,n);r.removeEventListener?r.removeEventListener(e,t,!1):r.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e||""===(t||""))return!1;var n=!0,r=e;return t.split(".").forEach(function(e){!0===n&&(null==r||"object"!=typeof r||!1===r.hasOwnProperty(e)?n=!1:r=r[e])}),n},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},r={};for(var i in n)t.hasOwnProperty(i)?r[i]=t[i]:r[i]=n[i];var l=Object.prototype.toString.call(e);function o(e,t){a=e.innerHTML,d=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),c=(n=e,r=window.getComputedStyle(n,null),(n.clientWidth-parseInt(r.getPropertyValue("padding-left"),10)-parseInt(r.getPropertyValue("padding-right"),10))/d),u=(i=e,l=window.getComputedStyle(i,null),(i.clientHeight-parseInt(l.getPropertyValue("padding-top"),10)-parseInt(l.getPropertyValue("padding-bottom"),10))/d),c&&(t.widthOnly||u)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===a.indexOf("textFitted")?((o=document.createElement("span")).className="textFitted",o.style.display="inline-block",o.innerHTML=a,e.innerHTML="",e.appendChild(o)):o=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),f=t.minFontSize,s=t.maxFontSize;for(var n,r,i,l,o,u,a,c,d,f,p,s,$=f,g=1e3;f<=s&&g>0;)g--,p=s+f-.1,o.style.fontSize=p+"em",o.scrollWidth/d<=c&&(t.widthOnly||o.scrollHeight/d<=u)?($=p,f=p+.1):s=p-.1;o.style.fontSize!==$+"em"&&(o.style.fontSize=$+"em")}"[object Array]"!==l&&"[object NodeList]"!==l&&"[object HTMLCollection]"!==l&&(e=[e]);for(var u=0;u<e.length;u++)o(e[u],r)});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});
"undefined"==typeof usi_ajax&&((usi_ajax={}).get=function(e,t){try{return usi_ajax.get_with_options({url:e},t)}catch(r){usi_commons.report_error(r)}},usi_ajax.get_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.withCredentials=!0,a.open("GET",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(n){return usi_commons.report_error(n),t(n,r)}},usi_ajax.post=function(e,t,r){try{return usi_ajax.post_with_options({url:e,params:t},r)}catch(a){usi_commons.report_error(a)}},usi_ajax.post_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],e.paramsDataType=e.paramsDataType||"string",e.params=e.params||"",null==XMLHttpRequest)return t(Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("POST",e.url,!0),"formData"===e.paramsDataType||("object"===e.paramsDataType?(a.setRequestHeader("Content-type","application/json; charset=utf-8"),e.params=JSON.stringify(e.params)):a.setRequestHeader("Content-type","application/x-www-form-urlencoded")),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"",r.responseURL=a.responseURL||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=Error("http.status: "+a.status)),t(e,r)}},a.send(e.params)}catch(n){return usi_commons.report_error(n),t(n,r)}},usi_ajax.form_post=function(e,t,r){try{r=r||"post";var a=document.createElement("form");a.setAttribute("method",r),a.setAttribute("action",e),null!=t&&"object"==typeof t&&Object.keys(t).forEach(function(e){var r=document.createElement("input");r.setAttribute("type","hidden"),r.setAttribute("name",e),r.setAttribute("value",t[e]),a.appendChild(r)}),document.body.appendChild(a),a.submit()}catch(n){usi_commons.report_error(n)}},usi_ajax.put_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("PUT",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(n){return usi_commons.report_error(n),t(n,r)}},usi_ajax.listener=function e(t){if(null==t&&(t=!1),null!=XMLHttpRequest){var e=this;e.ajax={},e.clear=function(){e.ajax.requests=[],e.ajax.registeredRequests=[],e.ajax.scriptLoads=[],e.ajax.registeredScriptLoads=[]},e.clear(),e.register=function(t,r,a){try{t=(t||"*").toUpperCase(),r=r||"*",a=a||function(){};var n={method:t,url:r,callback:a};e.ajax.registeredRequests.push(n)}catch(s){usi_commons.report_error(s)}},e.registerScriptLoad=function(t,r){try{t=t||"*",r=r||function(){};var a={url:t,callback:r};e.ajax.registeredScriptLoads.push(a)}catch(n){usi_commons.report_error(n)}},e.registerFormSubmit=function(e,r){try{null!=e&&usi_dom.attach_event("submit",function(a){if(!0===t&&usi_commons.log("USI AJAX: form submit"),null!=a&&!0===a.returnValue){a.preventDefault();var n={action:e.action,data:{},e:a},s=["submit"];if(Array.prototype.slice.call(e.elements).forEach(function(e){try{-1===s.indexOf(e.type)&&("checkbox"===e.type?!0===e.checked&&(n.data[e.name]=e.value):n.data[e.name]=e.value)}catch(t){usi_commons.report_error(t)}}),null!=r)return r(null,n);a.returnValue=!0}},e)}catch(a){usi_commons.report_error(a)}},e.listen=function(){try{e.ajax.originalOpen=XMLHttpRequest.prototype.open,e.ajax.originalSend=XMLHttpRequest.prototype.send,XMLHttpRequest.prototype.open=function(r,a){var n=this;r=(r||"").toUpperCase(),a=a||"",a=usi_dom.get_absolute_url(a),!0===t&&usi_commons.log("USI AJAX: open["+r+"]: "+a);var s={method:r,url:a,openDate:new Date};e.ajax.requests.push(s);var u=null;e.ajax.registeredRequests.forEach(function(e){(e.method==r||"*"==e.method)&&(a.indexOf(e.url)>-1||"*"==e.url)&&(u=e)}),null!=u&&(!0===t&&usi_commons.log("USI AJAX: Registered URL["+r+"]: "+a),n.requestObj=s,n.requestObj.callback=u.callback),e.ajax.originalOpen.apply(n,arguments)},XMLHttpRequest.prototype.send=function(r){var a=this;null!=a.requestObj&&(!0===t&&usi_commons.log("USI AJAX: Send Registered URL["+a.requestObj.method+"]: "+a.requestObj.url),""!=(r||"")&&(a.requestObj.params=r),a.addEventListener?a.addEventListener("readystatechange",function(){e.ajax.readyStateChanged(a)},!1):e.ajax.proxifyOnReadyStateChange(a)),e.ajax.originalSend.apply(a,arguments)},e.ajax.readyStateChanged=function(e){if(4===e.readyState&&null!=e.requestObj&&(e.requestObj.completedDate=new Date,!0===t&&usi_commons.log("Completed: "+e.requestObj.url),null!=e.requestObj.callback)){var r={requestObj:e.requestObj,responseText:e.responseText};return e.requestObj.callback(null,r)}},e.ajax.proxifyOnReadyStateChange=function(t){var r=t.onreadystatechange;null!=r&&(t.onreadystatechange=function(){e.ajax.readyStateChanged(t),r()})},document.head.addEventListener("load",function(t){if(null!=t&&null!=t.target&&""!=(t.target.src||"")){var r=t.target.src,a={url:r=usi_dom.get_absolute_url(r),completedDate:new Date};e.ajax.scriptLoads.push(a);var n=null;if(e.ajax.registeredScriptLoads.forEach(function(e){(r.indexOf(e.url)>-1||"*"==e.url)&&(n=e)}),null!=n&&null!=n.callback)return n.callback(null,a)}},!0),usi_commons.log("USI AJAX: listening ...")}catch(r){usi_commons.report_error(r),usi_commons.log("usi_ajax.listener ERROR: "+r.message)}},e.unregisterAll=function(){e.ajax.registeredRequests=[],e.ajax.registeredScriptLoads=[]}}});
"undefined"==typeof usi_date&&((usi_date={}).add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+36e5*t)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+6e4*t)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()>r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()<r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.string_to_date=function(e,t){t=t||!1;var r=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),n=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(r=new Date(e),""===(s[1]||"")&&!0===t){var a=new Date;r=usi_date.add_hours(r,a.getHours()),r=usi_date.add_minutes(r,a.getMinutes()),r=usi_date.add_seconds(r,a.getSeconds())}}else if(3===(n||[]).length){var c=n[1].split(/\-/g),i=c[1]+"/"+c[2]+"/"+c[0];return i+=n[2]||"",usi_date.string_to_date(i,t)}return r},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var r=usi_date.string_to_date(t,!0);null!=r?(e=r,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,r,s){null==s&&(s=1),""!=(r||"")&&(r=usi_date.get_units(r));var n=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var a=Math.abs(t-e);switch(r){case"ms":n=a;break;case"seconds":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3),s);break;case"minutes":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(c){n=null}return n},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});
"undefined"==typeof usi_split_test&&(usi_split_test={split_test_name:"usi_dice_roll",split_group:"-1",split_siteID:"-1",split_test_cookie_length:2,get_split_var:function(t){if(t=t||"",null==usi_cookies.get("usi_visitor_id"+t)){var i=Math.random().toString(36).substring(2);i.length>6&&(i=i.substring(0,6));var s="v_"+i+"_"+Math.round(new Date().getTime()/1e3)+"_"+t;return usi_cookies.set("usi_visitor_id"+t,s,86400*this.split_test_cookie_length,!0),s}return usi_cookies.get("usi_visitor_id"+t)},report_test:function(t,i){usi_commons.load_script(usi_commons.domain+"/utility/split_test.jsp?siteID="+t+"&group="+i+"&usi_visitor_id="+this.get_split_var(t)),void 0!==usi_split_test.set_verification&&setTimeout("usi_split_test.set_verification("+i+");",1e3)},get_group:function(t){return usi_cookies.get(this.split_test_name+t)},instantiate_callback:function(t,i){usi_cookies.get("usi_force_group")?i(usi_cookies.get("usi_force_group")):null==usi_cookies.get(this.split_test_name+t)?(usi_app["control_group_callback"+t]=i,usi_commons.load_script(usi_commons.domain+"/utility/split_test.jsp?siteID="+t+"&usi_visitor_id="+this.get_split_var(t))):i(usi_cookies.get(this.split_test_name+t))},instantiate:function(t,i){null==usi_cookies.get(this.split_test_name+t)?(0===i||i&&""!=i?this.split_group=i:Math.random()>.5?this.split_group="0":this.split_group="1",this.report_test(t,this.split_group),usi_cookies.set(this.split_test_name+t,this.split_group,86400*this.split_test_cookie_length,!0)):this.split_group=usi_cookies.get(this.split_test_name+t)}});

if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}if (typeof usi_aff === 'undefined') {
	usi_aff = {
		fix_linkshare: function() {
			try {
				if (usi_commons.gup("ranSiteID") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var date = now.getUTCFullYear() + ((now.getUTCMonth() + 1 < 10 ? "0" : "") + (now.getUTCMonth() + 1)) + ((now.getUTCDate() < 10 ? "0" : "") + now.getDate());
						var time = (now.getUTCHours() < 10 ? "0" : "") + now.getUTCHours() + ((now.getUTCMinutes() < 10 ? "0" : "") + now.getUTCMinutes());
						usi_cookies.create_nonencoded_cookie("usi_rmStore", "ald:" + date + "_" + time + "|atrv:" + usi_commons.gup("ranSiteID"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_rmStore") != null) {
					usi_cookies.create_nonencoded_cookie("rmStore", usi_cookies.read_cookie("usi_rmStore"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_cj: function() {
			try {
				if (usi_commons.gup("cjevent") != "" || usi_commons.gup("CJEVENT") != "") {
					usi_aff.log_url();
					var cjevent = usi_commons.gup("cjevent");
					if (cjevent == "") {
						cjevent = usi_commons.gup("CJEVENT");
					}
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_cjevent", cjevent, usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_cjevent") != null) {
					usi_cookies.create_nonencoded_cookie("cjevent", usi_cookies.read_cookie("usi_cjevent"), usi_cookies.expire_time.month);
					localStorage.setItem("as_onsite_cjevent", usi_cookies.read_cookie("usi_cjevent"));
					localStorage.setItem("cjevent", usi_cookies.read_cookie("usi_cjevent"));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_sas: function() {
			try {
				if (usi_commons.gup("sscid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_sscid", usi_commons.gup("sscid"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_sscid") != null) {
					usi_cookies.create_nonencoded_cookie("sas_m_awin", "{\"clickId\":\"" + usi_cookies.read_cookie("usi_sscid")+ "\"}", usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_awin: function(id) {
			try {
				if (usi_commons.gup("awc") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_awc", usi_commons.gup("awc"), usi_cookies.expire_time.month);
						usi_cookies.del("_aw_j_"+id);
					}
				}
				if (usi_cookies.read_cookie("usi_awc") != null) {
					usi_cookies.del("_aw_j_"+id);
					usi_cookies.create_nonencoded_cookie("AwinChannelCookie","aw",30*24*60*60,true);
					usi_cookies.create_nonencoded_cookie("AwinCookie","aw",30*24*60*60,true);
					usi_cookies.create_nonencoded_cookie("_aw_m_"+id, usi_cookies.read_cookie("usi_awc"), usi_cookies.expire_time.month);
					if (typeof(AWIN) !== "undefined") {
						AWIN.Tracking.StorageProvider.setAWC(id, usi_cookies.read_cookie("usi_awc"));
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_pj: function() {
			try {
				if (usi_commons.gup("clickId") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var usi_days = Math.floor(now / 8.64e7);
						usi_cookies.create_nonencoded_cookie('usi-pjn-click', '[{"id":"' + usi_commons.gup("clickId") + '","days":' + usi_days + ',"type":"p"}]', usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-pjn-click") != null) {
					usi_cookies.create_nonencoded_cookie("pjn-click", usi_cookies.read_cookie("usi-pjn-click"), usi_cookies.expire_time.month);
					localStorage.setItem("pjnClickData", usi_cookies.read_cookie("usi-pjn-click"));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_ir: function(id) {
			try {
				if (usi_commons.gup("irclickid") != "" || usi_commons.gup("clickid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var usi_click = usi_commons.gup("irclickid");
						if (usi_click == "") {
							usi_click = usi_commons.gup("clickid");
						}
						var date_now = Date.now().toString();
						var cookie_value = date_now + "|-1|" + date_now + "|" + usi_click + "|";
						usi_cookies.create_nonencoded_cookie("usi_IR_" + id, cookie_value, usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_IR_" + id) != null) {
					usi_cookies.create_nonencoded_cookie("IR_" + id, usi_cookies.read_cookie("usi_IR_" + id), usi_cookies.expire_time.month);
					usi_cookies.create_nonencoded_cookie("irclickid", usi_cookies.read_cookie("usi_IR_" + id).split("|")[3], usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_cf: function() {
			try {
				if (usi_commons.gup("cfclick") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi-cfjump-click", usi_commons.gup("cfclick"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-cfjump-click") != null) {
					usi_cookies.create_nonencoded_cookie("cfjump-click", usi_cookies.read_cookie("usi-cfjump-click"), usi_cookies.expire_time.month);
					usi_cookies.create_nonencoded_cookie("cfclick", usi_cookies.read_cookie("usi-cfjump-click"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_avantlink:function() {
			try {
				if (usi_commons.gup("avad") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_avad", usi_commons.gup("avad"), usi_cookies.expire_time.month);
						usi_aff.wait_for_avmws = function() {
							if (usi_cookies.get("avmws") != null) {
								usi_cookies.create_nonencoded_cookie("usi_avmws", usi_cookies.get("avmws"), usi_cookies.expire_time.month);
							} else {
								setTimeout(usi_aff.wait_for_avmws, 1000);
							}
						};
						usi_aff.wait_for_avmws();
					}
				}
				if (usi_cookies.read_cookie("usi_avmws") != null) {
					usi_cookies.create_nonencoded_cookie("avmws", usi_cookies.read_cookie("usi_avmws"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		get_impact_pixel: function () {
			var pixel = "";
			try {
				var scripts = document.getElementsByTagName("script");
				for (var i = 0; i < scripts.length; i++) {
					var text = scripts[i].innerText;
					if (text && (text.indexOf("ire('trackConversion'") != -1 || text.indexOf('ire("trackConversion"') != -1)) {
						pixel = text.trim().replace(/\s/g, '')
						pixel = pixel.split("trackConversion")[1];
						pixel = pixel.split("});")[0];
						return pixel;
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return pixel;
		},
		log_url: function() {
			usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?aff_click=" + encodeURIComponent(location.href));
		},
		monitor_affiliate_pixel: function (callback) {
			try {
				var pixels = usi_aff.report_affiliate_pixels();
				if (pixels) {
					if (typeof callback === "function") callback(pixels);
					return usi_aff.parse_pixels(pixels);
				}
				setTimeout(function () {
					usi_aff.monitor_affiliate_pixel(callback);
				}, 1000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		parse_pixels: function(pixels){
			try {
				usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?pixel_found=" + encodeURIComponent(location.href) +"&"+pixels);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		report_affiliate_pixels: function () {
			var params = '';
			try {
				var pixels = {
					cj: document.querySelector("[src*='emjcd.com']"),
					sas: document.querySelector("[src*='shareasale.com/sale.cfm']"),
					linkshare: document.querySelector("[src*='track.linksynergy.com']"),
					pj: document.querySelector("[src*='t.pepperjamnetwork.com/track']"),
					avant: document.querySelector("[src*='tracking.avantlink.com/ptcfp.php']"),
					ir: { src: usi_aff.get_impact_pixel() },
					awin1: document.querySelector("[src*='awin1.com/sread']"),
					awin2: document.querySelector("[src*='zenaps.com/sread.js']"),
					cf: document.querySelector("[src*='https://cfjump.'][src*='.com/track']"),
					saasler1: document.querySelector("[src*='engine.saasler.com']"),
					saasler2: document.querySelector("[src*='saasler-impact.herokuapp.com']")
				};
				for (var i in pixels) {
					if (pixels[i] && pixels[i].src) {
						params += '&' + i + '=' + encodeURIComponent(pixels[i].src);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return params;
		},
		load_script: function(source) {
			try {
				var docHead = document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				newScript.src = source;
				docHead.appendChild(newScript);
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	}
}


		usi_cookieless = true;
		usi_app = {};
		usi_commons.domain = usi_commons.cdn;
		usi_app.main = function () {
			try { // General
				usi_commons.log("usi_app.main()")
				usi_app.url = new usi_url.URL(location.href.toLowerCase());
				usi_app.url_href = location.href.toLowerCase();
				usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);
				usi_app.force_group = usi_commons.gup_or_get_cookie('usi_force_group');
				usi_app.force_version = usi_commons.gup_or_get_cookie('usi_force_version');

				usi_app.company_id = "5698";

				// Pages
				usi_app.is_create_account_page = location.href.indexOf("/users/new") != -1;
				usi_app.has_flex_account_page = usi_app.url_href.indexOf("freetrialflex10") != -1;
				usi_app.is_cart_page = usi_app.url_href.match("/cart") != null;
				usi_app.is_checkout_page = usi_app.url_href.match("/purchase") != null;
				usi_app.is_confirmation_page = location.href.indexOf("/purchase/success") != -1;
				usi_app.is_video_page = usi_app.is_video();
				usi_app.is_image_page = usi_app.is_image();
				usi_app.is_music_page = usi_app.is_music();
				usi_app.flex_destination_url = "https://www.shutterstock.com/explore/flex-subscriptions";
				usi_app.price_cart = null;

				usi_aff.fix_ir("1305");

				if (usi_app.is_video_page) {
					usi_cookies.set("usi_most_recent", "footage");
				} else if (usi_app.is_image_page) {
					usi_cookies.set("usi_most_recent", "image");
				} else if (usi_app.is_music_page) {
					usi_cookies.set("usi_most_recent", "music");
				}

				if (usi_cookies.get("usi_most_recent") === "image" && usi_app.is_checkout_page) {
					usi_cookies.set("usi_cart_contains_image", "true", 24 * 60 * 60, true);
				}

				usi_app.creative_flow_pages = [
					"/creative-flow",
					"/create",
					"/catalog",
					"/predict",
					"/planning",
					"/explore/photo-editor",
					"/explore/background-remover",
					"/explore/collage-maker",
					"/explore/crop-images",
					"/image-resizer",
					"/colors",
					"/file-converter"
				];

				usi_app.flex_pricing_page = [
						"/pricing",
						"/pricing/music",
						"/pricing/video"
				];

				//Pages to suppress flex campaigns
				usi_app.flex_supress_pages = [
					"/explore/flex-subscriptions"
				];

				//Pages to suppress all campaigns
				usi_app.suppress_pages = [
						"/video/embed",
						"/pricing"
				]

				usi_app.is_discover_page = location.href.toLowerCase().match("/10-free-stock-images/") != null;
				usi_app.is_creative_flow_page = location.href.toLowerCase().match(usi_app.creative_flow_pages.join("|")) != null;
				usi_app.is_flex_pricing_page = usi_app.flex_pricing_page.indexOf(usi_app.url.path.full) > -1 ? 1 : 0;
				usi_app.flex_suppress_page = usi_app.flex_supress_pages.indexOf(usi_app.url.path.full) > -1 ? 1 : 0;

				usi_app.suppress_page =  false;
				usi_app.suppress_pages.forEach(function(url) {
					if(location.href.match(url) != null) {
						usi_commons.log("[USI] Page Suppressed - All Campaigns Suppressed")
						usi_app.suppress_page = true;
					}
				})

				// Booleans
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.is_existing_customer = usi_app.check_existing_customer();
				usi_app.is_suppressed = location.href.indexOf("qa.shutterstock.com") != -1; /*|| !usi_app.is_video()*/
				usi_app.user_status = usi_app.get_user_status("user").isActive;
				usi_app.is_flex_account_page = usi_app.check_flex_account_page();

				usi_app.is_footage_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_footage", usi_cookies.expire_time.day, true) != "";
				usi_app.is_music_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_music", usi_cookies.expire_time.day, true) != "";
				usi_app.is_image_in_cart = usi_commons.gup_or_get_cookie("usi_cart_contains_image", usi_cookies.expire_time.day, true) != "";
				usi_app.check_language_site();
				usi_app.flex_lang = usi_app.flex_lang_check();
				usi_app.is_flexable = usi_app.can_flex();
				usi_app.is_lapsed_user = false;

				// Attempt to break out of iframe
				if (window !== window.parent) {
					return usi_commons.load_script("https://www.upsellit.com/active/shutterstock.jsp", null, true);
				}

				usi_aff.monitor_affiliate_pixel(function(){
					if (typeof USI_orderID == "undefined") {
						//usi_commons.load_script("//www.upsellit.com/active/shutterstock_pixel.jsp");
					}
				});

				if (usi_app.is_cart_page) {
					usi_app.save_cart();
				} else if (usi_app.is_checkout_page) {
					usi_app.scrape_subtotal();
					usi_app.scrape_order_summary();
				}

				if (usi_commons.gup("utm_campaign") == "Upsellit.com") {
					usi_app.set_utms();
				}

				// check suppressions
				if (usi_app.is_suppressed) {
					usi_commons.log("Company is suppressed");
					return;
				}

				if (usi_app.coupon != "" && usi_app.is_checkout_page) {
					//usi_app.boostbar.load();
					setTimeout(function () {
						usi_app.apply_coupon();
					}, 3000);
				} else if (!usi_app.is_create_account_page) {
					setTimeout(function () {
						usi_app.listen_for_active_cart();
					}, 1000);
				}

				if(!usi_app.is_cart_page && !usi_app.is_checkout_page){
					usi_app.get_ajax_cart();
					// Listen for add to cart
					usi_app.post_listen("https://www.shutterstock.com/napi/cart/relationships/items?application-namespace=sstk_cart", usi_app.handle_ajax_response2);
				}

				usi_app.load();

			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.listen_for_active_cart = function() {
			usi_commons.log('usi_app.listen_for_active_cart()');
			try {
				if (usi_app.is_cart_page) {
					var cart_items = document.querySelector("div[data-automation='CartBasket_itemsList_div']");

					if(cart_items == null) {
						cart_items = document.querySelector("[data-automation='CartItemsList']");
					}

					if (cart_items != null) {
						if(cart_items.textContent != "") {
							usi_cookies.set("usi_active_cart", "true", 24*60*60, true);
						}

						var subtotal = document.querySelector('[data-automation="Upsell_estimatedTotal_value"]');

						if(subtotal == null) {
							subtotal = document.querySelector('[class*=totalPrice]') != null ? document.querySelector('[class*=totalPrice]') : document.querySelector('[data-automation*="CartEstimatedTotal_Value"]')
						}

						if (subtotal != null) {
							subtotal = subtotal.textContent.replace(/[^0-9.]/g, '');

							// If the subtotal has changed, load - or if we've ended up here with no cart contents information
							if((usi_cookies.value_exists('usi_subtotal') && subtotal != usi_cookies.get('usi_subtotal'))
									|| (subtotal && !usi_cookies.value_exists('usi_subtotal'))
									|| (usi_cookies.value_exists('usi_subtotal') && !usi_app.is_footage_in_cart && !usi_app.is_music_in_cart && !usi_app.is_image_in_cart)) {
								// When the cart changes, recheck the contents to determine which TT to load
								usi_cookies.flush('usi_cart_contains_')

								usi_app.is_footage_in_cart = false;
								usi_app.is_music_in_cart = false;
								usi_app.is_image_in_cart = false;
								usi_app.is_premium_in_cart = false;

								// Check the cart page for evidence of what kind of content is in the cart
								// Video
								if(document.querySelector('[data-automation="CartSummaryItem_Video"]') != null || document.querySelector('div[data-automation="Upsell_videoUpsell_container"]') && document.querySelector('div[data-automation="Upsell_videoUpsell_container"]').children && document.querySelector('div[data-automation="Upsell_videoUpsell_container"]').children.length > 0) {
									usi_cookies.set("usi_cart_contains_footage", "true", 24 * 60 * 60, true);
									usi_app.is_footage_in_cart = true;
								}
								// Music
								if(document.querySelector('[data-automation="CartSummaryItem_Music"]') != null || document.querySelector('div[data-automation="Upsell_musicUpsell_container"]') && document.querySelector('div[data-automation="Upsell_musicUpsell_container"]').children && document.querySelector('div[data-automation="Upsell_musicUpsell_container"]').children.length > 0) {
									usi_cookies.set("usi_cart_contains_music", "true", 24 * 60 * 60, true);
									usi_app.is_music_in_cart = true;
								}
								// Images
								if(document.querySelector('[data-automation="CartSummaryItem_Image"]') != null || (document.querySelector('div[data-automation="Upsell_offsetUpsell_container"]') && document.querySelector('div[data-automation="Upsell_offsetUpsell_container"]').children && document.querySelector('div[data-automation="Upsell_offsetUpsell_container"]').children.length > 0)) {
									usi_cookies.set("usi_cart_contains_image", "true", 24 * 60 * 60, true);
									usi_app.is_image_in_cart = true;
								}
								// Anything premium
								if(document.querySelectorAll('.mui-19z690c-imageOverlayIcon').length != 0) {
									usi_cookies.set("usi_cart_contains_premium", "true", 24 * 60 * 60, true);
									usi_app.is_premium_in_cart = true;
								} else {
									usi_cookies.del("usi_cart_contains_premium");
									usi_app.is_premium_in_cart = false;
								}

								usi_app.save_cart()
								usi_app.load()
							}
						}
					} else if(usi_cookies.value_exists('usi_active_cart')) {
						// Cart was active, now it's inactive
						usi_cookies.del("usi_active_cart");
						usi_cookies.del("usi_cart_contains_footage")
						usi_cookies.del("usi_cart_contains_music")
						usi_cookies.del("usi_cart_contains_image")
						usi_cookies.del("usi_cart_contains_premium")
						usi_app.save_cart()
						usi_app.load()
					}
				} else {
					if (document.querySelector('.MuiBadge-badge.MuiBadge-anchorOriginTopRightCircular.MuiBadge-colorPrimary') != null) {
						var is_active_cart = false;
						var cart_count = Number(document.querySelector('.MuiBadge-badge.MuiBadge-anchorOriginTopRightCircular.MuiBadge-colorPrimary').textContent);
						if (cart_count > 0) {
							is_active_cart = true;
						} else if (document.querySelector('.MuiSnackbar-root .MuiAlert-filledSuccess') != null) {
							is_active_cart = true;
						}
						if (is_active_cart) {
							usi_app.is_active_cart = true;
							usi_cookies.set("usi_active_cart", "true", 24 * 60 * 60, true);

							if(document.querySelectorAll('.mui-19z690c-imageOverlayIcon').length != 0 && !usi_cookies.value_exists("usi_cart_contains_premium")) {
								usi_cookies.set("usi_cart_contains_premium", "true", 24 * 60 * 60, true);
								usi_app.is_premium_in_cart = true;
							} else {
								usi_cookies.del("usi_cart_contains_premium");
								usi_app.is_premium_in_cart = false;
							}

							if (usi_app.is_video_page && !usi_cookies.value_exists("usi_cart_contains_footage")) {
								usi_cookies.set("usi_cart_contains_footage", "true", 24 * 60 * 60, true);
								usi_app.is_footage_in_cart = true;
								usi_app.load();
								return;
							} else if (usi_app.is_music_page && !usi_cookies.value_exists("usi_cart_contains_music")) {
								usi_cookies.set("usi_cart_contains_music", "true", 24 * 60 * 60, true);
								usi_app.is_music_in_cart = true;
								usi_app.load();
								return;
							} else if (usi_app.is_image_page && !usi_cookies.value_exists("usi_cart_contains_image")) {
								usi_cookies.set("usi_cart_contains_image", "true", 24 * 60 * 60, true);
								usi_app.is_image_in_cart = true;
								usi_app.load();
								return;
							}
						} else if (cart_count == 0 && usi_cookies.value_exists('usi_active_cart')) {
							// Cart was active, now it's inactive
							usi_cookies.del("usi_active_cart");
							usi_cookies.del("usi_cart_contains_footage")
							usi_cookies.del("usi_cart_contains_music")
							usi_cookies.del("usi_cart_contains_image")
							usi_cookies.del("usi_cart_contains_premium")
							usi_app.save_cart()
							usi_app.load()
						}
					}

					if(usi_app.is_checkout_page && !usi_cookies.value_exists('usi_prod')) {
						if(document.querySelector("p[data-automation*='video'") != null) {
							usi_cookies.set("usi_cart_contains_footage", "true", 24 * 60 * 60, true);
							usi_app.is_footage_in_cart = true;
							usi_app.load();
							return;
						} else if (document.querySelector("p[data-automation*='audio'") != null) {
							usi_cookies.set("usi_cart_contains_music", "true", 24 * 60 * 60, true);
							usi_app.is_music_in_cart = true;
							usi_app.load();
							return;
						}
					}
				}
				setTimeout(usi_app.listen_for_active_cart, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.check_existing_customer = function() {
			try {
				//if (usi_cookies.value_exists("usi_existing_customer")) return true;
				if (window.dataLayer != undefined) {
					for (var i = 0; i < window.dataLayer.length; i++) {
						if (window.dataLayer[i]['user'] != undefined) {
							if (dataLayer[i].user.isActive == 'true' || dataLayer[i].user.status == 'customer') {
								//usi_cookies.set("usi_existing_customer", "1", 604800, true);
								return true;
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false; // new customer
		};

		usi_app.set_utms = function() {
			try {
				if (typeof ga == "undefined") return;
				var usi_ga = ga && ga.getAll();
				var usi_gtm = usi_ga && usi_ga[0].get('name');
				ga(usi_gtm + '.set', 'campaignName', usi_commons.gup("utm_campaign"));
				ga(usi_gtm + '.set', 'campaignSource', usi_commons.gup("utm_source"));
				ga(usi_gtm + '.set', 'campaignMedium', usi_commons.gup("utm_medium"));
				ga(usi_gtm + '.send', 'pageview');
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.can_flex = function(){
			return (usi_app.flex_lang && !usi_app.existing_customer && usi_app.user_status == 'false' && !usi_app.flex_suppress_page);
		};

		usi_app.flex_lang_check = function() {
			return !(usi_app.is_hindi_language || usi_app.is_tamil_language || usi_app.is_marathi_language || usi_app.is_telugu_language);
		};

		usi_app.get_user_type = function() {
			var user = usi_app.get_user_status("user");

			if(usi_commons.gup_or_get_cookie('usi_force_user_type')) {
				return usi_commons.gup_or_get_cookie('usi_force_user_type');
			}

			if(user.status == "guest" || (user.status == 'user' && user.isActive == 'false')) {
				return 'new'
			} else if(user.status == 'customer' && user.isActive == 'true') {
				return 'extension'
			} else if(user.status == 'customer' && user.isActive == 'false') {
				return 'reconversion'
			}
		}

		usi_app.load = function () {
			usi_commons.log("usi_app.load()");
			try {
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				if (!usi_app.suppress_page) {
					// New-new Launch Logic 10/24
					usi_commons.log("[USI] --- NEW LAUNCH FLOW 10/24 ---")

					// FLEX Pages Precapture
					if (usi_app.is_flex_account_page) {
						usi_commons.log('[usi] 45145 - Load Flex Account Create Page Precapture');
						usi_commons.load_precapture("NH7KffuvEx7CJuogK2t2pgG", "45145");
					}

					var language_key = usi_app.get_language_key();
					var checkout = document.querySelector('[data-automation="CheckoutOrderSummary_orderSummaryContainer_div"]');
					var key = usi_commons.device + language_key;

					var site_info = {};
					var user_type = usi_app.get_user_type();

					function load_campaign(site_info) {
						var site_key = site_info.site_key;
						var site_id = site_info.site_id;

						if(site_info.split_test_id) {
							usi_split_test.instantiate_callback(site_info.split_test_id, function(group) {
								if (group === '1') {
									return usi_commons.load_view(site_key, site_id, key);
								} else {
									usi_commons.log("[usi] CONTROL - Site ID " + site_id);
								}
							});
						} else {
							return usi_commons.load_view(site_key, site_id, key);
						}
					}

					if((user_type == 'reconversion' || user_type == 'extension') && !language_key.match('english')) {
						usi_commons.log('[usi] Suppressing on non-EN extension and reconversion customers')
						return;
					}

					var premium_content_detected = false;

					// New suppressions
					if(usi_app.url.full.match('offset') != null ||
							usi_app.url.full.match('editorial') != null ||
							(usi_app.is_checkout_page && document.getElementsByTagName("main").length > 0 && document.getElementsByTagName("main")[0].textContent.indexOf('Enhanced License') != -1)) {
						premium_content_detected = true;
					}

					if(document.querySelectorAll('.mui-19z690c-imageOverlayIcon').length > 0) {
						premium_content_detected = true;
					}

					if(document.querySelector('.mui-b7eh1n-actionsConversionContainer .mui-nd8umf-root-offsetRibbon') != null) {
						premium_content_detected = true;
					}

					if(usi_app.is_cart_page && document.querySelectorAll('.mui-19z690c-imageOverlayIcon').length > 0) {
						premium_content_detected = true;
					}

					if(usi_app.is_checkout_page) {
						var labels = document.querySelectorAll('strong');
						var premium = false;
						if (labels.length) {
							labels.forEach(function(label) {
								if(label.textContent && label.textContent.toLowerCase().indexOf('premium') != -1) {
									premium = true;
								}
							})

							if(premium) {
								premium_content_detected = true;
							}
						}
					}

					if(usi_app.is_cart_page) {
						var license_buttons = document.querySelectorAll('[data-automation="enhanced"] span input');

						if(license_buttons) {
							license_buttons.forEach(function(radio) {
								if(radio.checked) {
									premium_content_detected = true;
								}
							})
						}
					}

					if((usi_app.is_premium_in_cart || usi_cookies.value_exists('usi_cart_contains_premium') || premium_content_detected)) {
						usi_app.messaging = usi_app.get_messaging('message_premium_content');
						var site_info = usi_app.get_campaign_details('premium_content', user_type);

						usi_commons.log("[USI] " + site_info.site_id + " - Premium Content Reiteration TT");
						return load_campaign(site_info);
					}


					// AI Generator Pages / AI Eligible Checkout
					var checkout_ai_eligible = (usi_app.is_checkout_page && (/generationID=/i).test(location.href) || checkout != null && checkout.textContent.indexOf("AI Generator & Creative Flow") !== -1)
					if (((/.shutterstock.com\/image-generated|.shutterstock.com\/ai-image-generator|.shutterstock.com\/generate|.shutterstock.com\/search\?image_type=generated/i).test(location.href) || checkout_ai_eligible) && (language_key.includes("_english"))) {
						// Precise Promotion | AI Generator Exit TT

						var messaging = "generic_tenpercent";
						usi_app.messaging = usi_app.get_messaging(messaging);
						site_info = usi_app.get_campaign_details('tenpercent_precart_images', user_type);

						usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Pre Cart - AI Generator Context");
						return load_campaign(site_info);
					}

					// Creative Flow Pages
					if (usi_app.is_creative_flow_page) {
						var messaging = "generic_tenpercent";
						usi_app.messaging = usi_app.get_messaging(messaging);
						key = usi_commons.device + language_key;

						site_info = usi_app.get_campaign_details('tenpercent_precart_images', user_type);
						usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Pre Cart - Creative Flow Context");
						return load_campaign(site_info);
					}

					if (usi_app.is_image_page || usi_app.is_image_in_cart) {
						

						usi_app.messaging = usi_app.get_messaging("generic_tenpercent");
						if (usi_app.messaging && usi_app.messaging.header1) {

							if ((usi_app.is_cart_page)  || (usi_app.is_checkout_page && usi_cookies.value_exists('usi_prod_name_1'))) {
								site_info = usi_app.get_campaign_details('tenpercent_activecart_images', user_type);
								site_key = site_info.site_key;
								site_id = site_info.site_id;

								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Active Cart - Image Context");
								return load_campaign(site_info);
							} else {
								site_info = usi_app.get_campaign_details('tenpercent_precart_images', user_type);
								site_key = site_info.site_key;
								site_id = site_info.site_id;

								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Pre Cart - Image Context");
								return load_campaign(site_info);
							}
						}
					} else if (usi_app.is_video_page || usi_app.is_footage_in_cart) {
						usi_app.messaging = usi_app.get_messaging("generic_tenpercent");
						if (usi_app.messaging && usi_app.messaging.header1) {
							if ((usi_app.is_cart_page)  || (usi_app.is_checkout_page && usi_cookies.value_exists('usi_prod_name_1'))) {
								site_info = usi_app.get_campaign_details('tenpercent_activecart_video', user_type);
								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Active Cart - Video Context");
								return load_campaign(site_info)
							} else {
								site_info = usi_app.get_campaign_details('tenpercent_precart_video', user_type);
								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Pre Cart - Video Context");
								return load_campaign(site_info)
							}
						}
					} else if (usi_app.is_music_in_cart || usi_app.is_music_page) {
						if(usi_app.is_checkout_page && document.querySelector('p[data-automation*="subscriptionOrderItem-title-monthly_10_download_1_month_cmt_x12"]') != null) {
							// Suppress campaigns for the FLEX trial checkouts
							usi_commons.log("[USI] Suppressing campaigns on subscription checkouts")
							return;
						}

						usi_app.messaging = usi_app.get_messaging("generic_tenpercent");
						if (usi_app.messaging && usi_app.messaging.header1) {
							if ((usi_app.is_cart_page)  || (usi_app.is_checkout_page && usi_cookies.value_exists('usi_prod_name_1'))) {
								site_info = usi_app.get_campaign_details('tenpercent_activecart_music', user_type);
								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Active Cart - Music Context");
								return load_campaign(site_info);
							} else {
								site_info = usi_app.get_campaign_details('tenpercent_precart_music', user_type);
								usi_commons.log("[USI] " + site_info.site_id + " - Precise Promotion | 10% Off Pre Cart - Music Context");
								return load_campaign(site_info);
							}
						}
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.lookup = function (options) {
			try {
				usi_app.lookup_callback = function (found) {
					try {
						if (typeof options.callback == "function"){
							options.callback(found, options);
						}
					} catch (err) {
						usi_commons.report_error(err);
					}
				};
				var source = usi_commons.domain + "/utility/lookup_suppressions.jsp?companyID=" + usi_app.company_id +
						"&product=" + (Array.isArray(options.ids) ? options.ids.join(",") : options.ids) +
						"&label=" + options.list +
						"&match=" + options.match +
						"&callback=usi_app.lookup_callback";
				usi_commons.load_script(source);
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.get_split_key = function(split_key_a,split_key_b,split_percentage,has_enable){
			//currently only works with 2 options, but can be used multiple times on page. A should be Control, B Should be Test, has_enable will add an enable flag, and default to control (A)
			// To Do make work with array of options to allow for A/B/C/etc testing
			if(has_enable == "undefined"){
				has_enable = false;
			}

			var return_split_key = Math.random() < split_percentage ? split_key_a : split_key_b;

			if(has_enable){
				if(!usi_app.is_enabled){
					return_split_key = split_key_a;
				}
			}

			if (usi_app.force_version != "") {
				if(usi_app.force_version == "1"){
					return_split_key = split_key_a;
				}else{
					return_split_key = split_key_b
				}

			}
			return return_split_key;
		};

		usi_app.get_messaging = function(campaign) {


			var usi_language_key = usi_app.get_language_key().replace("_","");

			usi_commons.log(usi_language_key);
			usi_commons.log(campaign);

			if (campaign == "message_premium_content") {
				if(usi_language_key.match('english') != null) usi_language_key = 'english'
				if (usi_app.message_premium_content[usi_language_key] != "undefined") {
					return usi_app.message_premium_content[usi_language_key];
				}
			}

			if (campaign == "sitewide_20percent_q42024") {
				if(usi_language_key.match('english') != null) usi_language_key = 'english'
				if (usi_app.message_sitewide_20percent_q42024[usi_language_key] != "undefined") {
					return usi_app.message_sitewide_20percent_q42024[usi_language_key];
				}
			}

			if (campaign == "bfcm_2024") {
				if(usi_language_key.match('english') != null) usi_language_key = 'english'
				if (usi_app.message_bfcm_2024[usi_language_key] != "undefined") {
					return usi_app.message_bfcm_2024[usi_language_key];
				}
			}

			if(campaign == 'message_creative_flow_promotion') {
				if (usi_app.message_creative_flow_promotion[usi_language_key] != "undefined") {
					return usi_app.message_creative_flow_promotion[usi_language_key];
				}
			}
			if(campaign == 'sitewide_event_2023_bfcm') {
				if (usi_app.message_sitewide_event_2023_bfcm[usi_language_key] != "undefined") {
					return usi_app.message_sitewide_event_2023_bfcm[usi_language_key];
				}
			}else if(campaign == 'sitewide_event_q3_2023_new_users') {
				if (usi_app.message_sitewide_event_q3_2023_new_users[usi_language_key] != "undefined") {
					return usi_app.message_sitewide_event_q3_2023_new_users[usi_language_key];
				}
			}else if(campaign == 'sitewide_event_q3_2023_lapsed_users') {usi_app.get_messaging('');
				if (usi_app.message_sitewide_event_q3_2023_lapsed_users[usi_language_key] != "undefined") {
					return usi_app.message_sitewide_event_q3_2023_lapsed_users[usi_language_key];
				}
			}else if (campaign == "sitewide_event_20th") {
				if (usi_app.message_sitewide_20th[usi_language_key] != "undefined") {
					return usi_app.message_sitewide_20th[usi_language_key];
				}
			}else if (campaign == "image_flex") {
				if (usi_app.message_flex_images[usi_language_key] != "undefined") {
					return usi_app.message_flex_images[usi_language_key];
				}
			}else if (campaign == "video_flex") {
				if (usi_app.message_flex_videos[usi_language_key] != "undefined") {
					return usi_app.message_flex_videos[usi_language_key];
				}
			}else if (campaign == "music_flex") {
				if (usi_app.message_flex_music[usi_language_key] != "undefined") {
					return usi_app.message_flex_music[usi_language_key];
				}
			}else if (campaign == "images_sitewide_event") {
				if (usi_app.message_images_sitewide[usi_language_key] != "undefined") {
					return usi_app.message_images_sitewide[usi_language_key];
				}
			} else if (campaign == "video_sitewide_event") {
				if (usi_app.message_video_sitewide[usi_language_key] != "undefined") {
					return usi_app.message_video_sitewide[usi_language_key];
				}
			} else if (campaign == "images_freetrial") {
				if (usi_app.message_images_freetrial[usi_language_key] != "undefined") {
					return usi_app.message_images_freetrial[usi_language_key];
				}
			} else if (campaign == "footage_tenpercent") {
				if (usi_app.message_footage_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_footage_tenpercent[usi_language_key];
				}
			} else if (campaign == "music_tenpercent") {
				if (usi_app.message_music_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_music_tenpercent[usi_language_key];
				}
			} else if (campaign == "images_tenpercent") {
				if (usi_app.message_images_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_images_tenpercent[usi_language_key];
				}
			} else if (campaign == "generic_tenpercent") {
				if (usi_app.message_generic_tenpercent[usi_language_key] != "undefined") {
					return usi_app.message_generic_tenpercent[usi_language_key];
				}
			}
			return null;
		}

		usi_app.check_language_site = function() {
			try {
				usi_commons.log("usi_app.check_language_site()")
				if (!usi_app.is_create_account_page) {
					usi_app.is_czech_language = usi_app.url_href.match("/cs/") != null;
					usi_app.is_danish_language = usi_app.url_href.match("/da/") != null;
					usi_app.is_dutch_language = usi_app.url_href.match("/nl/") != null;
					usi_app.is_espanol_language = usi_app.url_href.match("/es/") != null;
					usi_app.is_finland_language = usi_app.url_href.match("/fi/") != null;
					usi_app.is_french_language = usi_app.url_href.match("/fr/") != null;
					usi_app.is_german_language = usi_app.url_href.match("/de/") != null || usi_app.url_href.match("/gr/") != null;
					usi_app.is_hungary_language = usi_app.url_href.match("/hu/") != null;
					usi_app.is_italian_language = usi_app.url_href.match("/it/") != null;
					usi_app.is_japanese_language = usi_app.url_href.match("/ja/") != null;
					usi_app.is_korean_language = usi_app.url_href.match("/ko/") != null;
					usi_app.is_norway_language = usi_app.url_href.match("/nb/") != null;
					usi_app.is_polish_language = usi_app.url_href.match("/pl/") != null;
					usi_app.is_portuguese_language = usi_app.url_href.match("/pt/") != null;
					usi_app.is_russia_language = usi_app.url_href.match("/ru/") != null;
					usi_app.is_simple_chinese_language = usi_app.url_href.match("/zh/") != null;
					usi_app.is_sweden_language = usi_app.url_href.match("/sv/") != null;
					usi_app.is_thai_language = usi_app.url_href.match("/th/") != null;
					usi_app.is_turkey_language = usi_app.url_href.match("/tr/") != null;
					usi_app.is_tradition_chinese_language = usi_app.url_href.match("/zh-hant/") != null;
					usi_app.is_hindi_language = usi_app.url_href.match("/hi/") != null;
					usi_app.is_tamil_language = usi_app.url_href.match("/ta/") != null;
					usi_app.is_telugu_language = usi_app.url_href.match("/te/") != null;
					usi_app.is_marathi_language = usi_app.url_href.match("/mr/") != null;
				} else {
					var decode_url = decodeURIComponent(location.href);
					var url = new URL(decode_url);
					var language_key = url.searchParams.get('hl')

					if (language_key == "cs") { usi_app.is_czech_language = true }
					else if (language_key == "da") { usi_app.is_danish_language = true }
					else if (language_key == "nl") { usi_app.is_dutch_language = true }
					else if (language_key == "es") { usi_app.is_espanol_language = true }
					else if (language_key == "fi") { usi_app.is_finland_language = true }
					else if (language_key == "fr") { usi_app.is_french_language = true }
					else if (language_key == "de") { usi_app.is_german_language = true }
					else if (language_key == "it") { usi_app.is_italian_language = true }
					else if (language_key == "ja") { usi_app.is_japanese_language = true }
					else if (language_key == "ko") { usi_app.is_korean_language = true }
					else if (language_key == "nb") { usi_app.is_norway_language = true }
					else if (language_key == "pl") { usi_app.is_polish_language = true }
					else if (language_key == "pt") { usi_app.is_portuguese_language = true }
					else if (language_key == "ru") { usi_app.is_russia_language = true }
					else if (language_key == "zh") { usi_app.is_simple_chinese_language = true }
					else if (language_key == "sv") { usi_app.is_sweden_language = true }
					else if (language_key == "th") { usi_app.is_thai_language = true }
					else if (language_key == "tr") { usi_app.is_turkey_language = true }
					else if (language_key == "zh-hant") { usi_app.is_tradition_chinese_language = true }
					else if (language_key == "hi") { usi_app.is_hindi_language = true }
					else if (language_key == "tn") { usi_app.is_tamil_language = true }
					else if (language_key == "te") { usi_app.is_telugu_language = true }
					else if (language_key == "mr") { usi_app.is_marathi_language = true }
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_language_key = function() {
			var language_key = "";

			// Testing override
			if(usi_commons.gup_or_get_cookie('usi_lang')) {
				return ("_" + usi_commons.gup_or_get_cookie('usi_lang'))
			}

			try {
				if (usi_app.is_czech_language) {
					language_key = "_czech";
				} else if (usi_app.is_danish_language) {
					language_key = "_danish";
				} else if (usi_app.is_dutch_language) {
					language_key = "_dutch";
				} else if (usi_app.is_espanol_language) {
					language_key = "_espanol";
				} else if (usi_app.is_finland_language) {
					language_key = "_finland";
				} else if (usi_app.is_french_language) {
					language_key = "_french";
				} else if (usi_app.is_german_language) {
					language_key = "_german";
				} else if (usi_app.is_hungary_language) {
					language_key = "_hungary";
				} else if (usi_app.is_italian_language) {
					language_key = "_italian";
				} else if (usi_app.is_japanese_language) {
					language_key = "_japanese";
				} else if (usi_app.is_korean_language) {
					language_key = "_korean";
				} else if (usi_app.is_norway_language) {
					language_key = "_norway";
				} else if (usi_app.is_polish_language) {
					language_key = "_polish";
				} else if (usi_app.is_portuguese_language) {
					language_key = "_portuguese";
				} else if (usi_app.is_russia_language) {
					language_key = "_russia";
				} else if (usi_app.is_simple_chinese_language) {
					language_key = "_sichinese";
				} else if (usi_app.is_sweden_language) {
					language_key = "_sweden";
				} else if (usi_app.is_thai_language) {
					language_key = "_thai";
				} else if (usi_app.is_turkey_language) {
					language_key = "_turkey";
				} else if (usi_app.is_tradition_chinese_language) {
					language_key = "_trchinese";
				} else if (usi_app.is_hindi_language) {
					language_key = "_hindi";
				} else if (usi_app.is_tamil_language) {
					language_key = "_tamil";
				} else if (usi_app.is_telugu_language) {
					language_key = "_telugu";
				} else if (usi_app.is_marathi_language) {
					language_key = "_marathi";
				} else {
					language_key = "_english";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return language_key;
		};

		usi_app.message_music_tenpercent = {
			"english": {header1:"Save 10% on music tracks and subscriptions.",cta:"Get Started"},
			"sichinese": {header1:"\u97F3\u4E50\u66F2\u76EE\u548C\u8BA2\u9605\u4EAB\u6709\u4E5D\u6298\u4F18\u60E0\u3002",cta:"\u5F00\u59CB\u4F7F\u7528"},
			"trchinese": {header1:"\u97F3\u6A02\u66F2\u76EE\u548C\u8A02\u95B1\u4EAB\u6709\u4E5D\u6298\u512A\u60E0\u3002",cta:"\u958B\u59CB\u4F7F\u7528"},
			"czech": {header1:"U\u0161et\u0159ete 10 % na hudebn\u00EDch skladb\u00E1ch a p\u0159edplatn\u00E9m.",cta:"Za\u010D\u00EDt"},
			"danish": {header1:"Spar 10 % p\u00E5 musiknumre og abonnementer",cta:"Kom i gang"},
			"finland": {header1:"Nyt voit s\u00E4\u00E4st\u00E4\u00E4 jopa 10% musiikista ja tilauksista.",cta:"Aloita t\u00E4st\u00E4"},
			"hungary": {header1:"10%-os megtakar\u00EDt\u00E1s a zenesz\u00E1mokon \u00E9s az el\u0151fizet\u00E9sen",cta:"Pr\u00F3b\u00E1lja ki most"},
			"norway": {header1:"Spar 10 % p\u00E5 musikkfiler og abonnementer.",cta:"Kom i gang"},
			"polish": {header1:"Zaoszcz\u0119d\u017A 10% na utworach muzycznych i subskrypcjach.",cta:"Rozpocznij"},
			"sweden": {header1:"Spara 10% p\u00E5 l\u00E5tar och abonnemang",cta:"Kom ig\u00E5ng"},
			"thai": {header1:"\u0E1B\u0E23\u0E30\u0E2B\u0E22\u0E31\u0E14 10% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E41\u0E17\u0E23\u0E47\u0E01\u0E40\u0E1E\u0E25\u0E07\u0E41\u0E25\u0E30\u0E01\u0E32\u0E23\u0E2A\u0E21\u0E31\u0E04\u0E23\u0E2A\u0E21\u0E32\u0E0A\u0E34\u0E01",cta:"\u0E40\u0E23\u0E34\u0E48\u0E21\u0E15\u0E49\u0E19"},
			"turkey": {header1:"M\u00FCzik par\u00E7alar\u0131 ve aboneliklerde %10 tasarruf edin.",cta:"\u015Eimdi Ba\u015Fla"},
			"italian": {header1:"Risparmia il 10% su tracce musicali e abbonamenti.",cta:"Inizia ora"},
			"espanol": {header1:"Ahorra 10% en pistas y suscripciones de m\u00FAsica",cta:"Comenzar"},
			"french": {header1:"\u00C9conomisez 10 % sur la musique et les abonnements.",cta:"Lancez-vous"},
			"portuguese": {header1:"Poupe 10% em faixas de m\u00FAsica e subscri\u00E7\u00F5es.",cta:"Comece agora"},
			"german": {header1:"Spare jetzt 10% auf Musik und Abos.",cta:"Loslegen"},
			"dutch": {header1:"Bespaar 10% op muzieknummers en abonnementen.",cta:"Begin nu"},
			"japanese": {header1:"\u97F3\u697D\u7D20\u6750\u3068\u5B9A\u984D\u30D7\u30E9\u30F3\u304C10\uFF05\u5272\u5F15",cta:"\u4ECA\u3059\u3050\u306F\u3058\u3081\u308B"},
			"hindi": {header1:"\u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0948\u0915 \u0914\u0930 \u0938\u092C\u094D\u0938\u0915\u094D\u0930\u093F\u092A\u094D\u0936\u0928 \u092A\u0930 10% \u092C\u091A\u093E\u090F\u0902\u0964",cta:"\u0936\u0941\u0930\u0941\u0906\u0924 \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BAE\u0BBF\u0BAF\u0BC2\u0B9A\u0BBF\u0B95\u0BCD (\u0B87\u0B9A\u0BC8) \u0B9F\u0BBF\u0BB0\u0BBE\u0B95\u0BCD\u0B95\u0BC1\u0B95\u0BB3\u0BCD \u0BAE\u0BB1\u0BCD\u0BB1\u0BC1\u0BAE\u0BCD \u0B9A\u0BA8\u0BCD\u0BA4\u0BBE\u0B95\u0BCD\u0B95\u0BB3\u0BBF\u0BB2\u0BCD 10% \u0B9A\u0BC7\u0BAE\u0BBF\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD.",cta:"\u0BA4\u0BCA\u0B9F\u0B99\u0BCD\u0B95\u0BB5\u0BC1\u0BAE\u0BCD"},
			"telugu": {header1:"\u0C2E\u0C4D\u0C2F\u0C42\u0C1C\u0C3F\u0C15\u0C4D \u0C1F\u0C4D\u0C30\u0C3E\u0C15\u0C4D\u200C\u0C32\u0C41 \u0C2E\u0C30\u0C3F\u0C2F\u0C41 \u0C38\u0C2C\u0C4D\u200C\u0C38\u0C4D\u0C15\u0C4D\u0C30\u0C3F\u0C2A\u0C4D\u0C37\u0C28\u0C4D\u200C\u0C32\u0C2A\u0C48 10% \u0C06\u0C26\u0C3E \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F.",cta:"\u0C2A\u0C4D\u0C30\u0C3E\u0C30\u0C02\u0C2D\u0C3F\u0C02\u0C1A\u0C02\u0C21\u0C3F"},
			"marathi": {header1:"\u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0945\u0915 \u0906\u0923\u093F \u0938\u0926\u0938\u094D\u092F\u0924\u094D\u0935\u093E\u0902\u0935\u0930 10% \u092C\u091A\u0924 \u0915\u0930\u093E.",cta:"\u0938\u0941\u0930\u0941 \u0915\u0930\u0942\u092F\u093E"}
		};

		usi_app.message_generic_tenpercent = {
			"english": {
				"header1": "Unleash your creativity",
				"header2": "Get 10% off your order today",
				"cta": "Redeem Now",
				"your_cart": "Your Cart",
				"subtotal": "Subtotal",
				"discount": "Discount",
				"new_total": "New Subtotal"
			},
			"english-a": {
				"header1": "Unleash your creativity",
				"header2": "Get 10% off your order today",
				"cta": "Redeem Now",
				"your_cart": "Your Cart",
				"subtotal": "Subtotal",
				"discount": "Discount",
				"new_total": "New Subtotal"
			},
			"english-b": {
				"header1": "Unleash your creativity",
				"header2": "Get 10% off your order today",
				"cta": "Claim Offer",
				"your_cart": "Your Cart",
				"subtotal": "Subtotal",
				"discount": "Discount",
				"new_total": "New Subtotal"
			},
			"english-c": {
				"header1": "Unleash your creativity",
				"header2": "Get 10% off your order today",
				"cta": "Get Your Discount",
				"your_cart": "Your Cart",
				"subtotal": "Subtotal",
				"discount": "Discount",
				"new_total": "New Subtotal"
			},
			"sichinese": {
				"header1": "\u91CA\u653E\u60A8\u7684\u521B\u4F5C\u624D\u534E",
				"header2": "\u4ECA\u5929\u53EF\u4EAB\u53D79\u6298\u4F18\u60E0",
				"cta": "\u5FEB\u6765\u5151\u6362\u5427",
				"your_cart": "\u60A8\u7684\u5361\u53F7",
				"subtotal": "\u5C0F\u8BA1",
				"discount": "\u6298\u6263",
				"new_total": "\u6298\u540E\u5C0F\u8BA1"
			},
			"trchinese": {
				"header1": "\u91CB\u653E\u60A8\u7684\u5275\u4F5C\u624D\u83EF",
				"header2": "\u4ECA\u5929\u53EF\u4EAB\u53D79\u6298\u4F18\u60E0",
				"cta": "\u5FEB\u4F86\u514C\u63DB\u5427",
				"your_cart": "\u60A8\u7684\u5361\u865F",
				"subtotal": "\u5C0F\u8A08",
				"discount": "\u6298\u6263",
				"new_total": "\u512A\u60E0\u5F8C\u5C0F\u8A08"
			},
			"czech": {
				"header1": "Popus\u0165te uzdu sv\u00E9 kreativit\u011B",
				"header2": "Z\u00EDskejte 10% slevu na svou objedn\u00E1vku je\u0161t\u011B dnes",
				"cta": "Uplatnit nyn\u00ED",
				"your_cart": "V\u00E1\u0161 ko\u0161\u00EDk",
				"subtotal": "Mezisou\u010Det",
				"discount": "Sleva",
				"new_total": "Nov\u00FD mezisou\u010Det"
			},
			"danish": {
				"header1": "Slip kreativiteten l\u00F8s",
				"header2": "F\u00E5 10% rabat p\u00E5 din ordre i dag",
				"cta": "Indl\u00F8s nu",
				"your_cart": "Din kurv",
				"subtotal": "Subtotal",
				"discount": "Rabat",
				"new_total": "Ny subtotal"
			},
			"finland": {
				"header1": "P\u00E4\u00E4st\u00E4 luovuutesi valloilleen",
				"header2": "Saat 10 % alennuksen tilauksestasi t\u00E4n\u00E4\u00E4n",
				"cta": "Lunasta nyt",
				"your_cart": "Ostoskorisi",
				"subtotal": "V\u00E4lisumma",
				"discount": "Alennus",
				"new_total": "Uusi v\u00E4lisumma"
			},
			"hungary": {
				"header1": "Engedje szabadj\u00E1ra a kreativit\u00E1s\u00E1t",
				"header2": "10% engedm\u00E9ny, ha ma rendel",
				"cta": "Szerezze meg most",
				"your_cart": "A kosara",
				"subtotal": "V\u00E9g\u00F6sszeg",
				"discount": "Engedm\u00E9ny",
				"new_total": "\u00DAj v\u00E9g\u00F6sszeg"
			},
			"norway": {
				"header1": "Slipp kreativiteten l\u00F8s",
				"header2": "F\u00E5 10 % rabatt p\u00E5 ordren din i dag",
				"cta": "L\u00F8s inn n\u00E5",
				"your_cart": "Din handlekurv",
				"subtotal": "Delsum",
				"discount": "Rabatt",
				"new_total": "Totalt"
			},
			"polish": {
				"header1": "Wyzw\u00F3l swoj\u0105 kreatywno\u015B\u0107",
				"header2": "Otrzymaj -10% na zam\u00F3wienie ju\u017C dzisiaj",
				"cta": "Skorzystaj teraz",
				"your_cart": "Tw\u00F3j koszyk",
				"subtotal": "Suma cz\u0119\u015Bciowa",
				"discount": "Zni\u017Cka",
				"new_total": "Nowa suma cz\u0119\u015Bciowa"
			},
			"russia": {
				"header1": "\u0420\u0430\u0441\u043A\u0440\u043E\u0439 \u0441\u0432\u043E\u044E \u043A\u0440\u0435\u0430\u0442\u0438\u0432\u043D\u043E\u0441\u0442\u044C",
				"header2": "\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 10% \u043D\u0430 \u0432\u0430\u0448 \u0437\u0430\u043A\u0430\u0437 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",
				"cta": "\u0410\u043A\u0442\u0438\u0432\u0438\u0440\u043E\u0432\u0430\u0442\u044C",
				"your_cart": "\u0412\u0430\u0448\u0430 \u041A\u043E\u0440\u0437\u0438\u043D\u0430",
				"subtotal": "\u041F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0418\u0442\u043E\u0433",
				"discount": "\u0421\u043A\u0438\u0434\u043A\u0430",
				"new_total": "\u041D\u043E\u0432\u044B\u0439 \u043F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433"
			},
			"sweden": {
				"header1": "Sl\u00E4pp loss din kreativitet",
				"header2": "F\u00E5 10% rabatt p\u00E5 din best\u00E4llning idag",
				"cta": "L\u00F6s in nu",
				"your_cart": "Din kundvagn",
				"subtotal": "Delsumma",
				"discount": "Rabatt",
				"new_total": "Ny delsumma"
			},
			"thai": {
				"header1": "\u0E1B\u0E25\u0E14\u0E1B\u0E25\u0E48\u0E2D\u0E22\u0E04\u0E27\u0E32\u0E21\u0E04\u0E34\u0E14\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E2A\u0E23\u0E23\u0E04\u0E4C\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",
				"header2": "\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 10% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",
				"cta": "\u0E1A\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49",
				"your_cart": "\u0E23\u0E16\u0E40\u0E02\u0E47\u0E19\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",
				"subtotal": "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22",
				"discount": "\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14",
				"new_total": "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22\u0E43\u0E2B\u0E21\u0E48"
			},
			"turkey": {
				"header1": "Yarat\u0131c\u0131l\u0131\u011F\u0131n\u0131z\u0131 serbest b\u0131rak\u0131n",
				"header2": "Bug\u00FCn verece\u011Finiz sipari\u015Finizde %10 indirim kazan\u0131n",
				"cta": "\u015Eimdi kullan",
				"your_cart": "Sepetiniz",
				"subtotal": "Ara Toplam",
				"discount": "\u0130ndirim",
				"new_total": "Yeni Ara Toplam"
			},
			"dutch": {
				"header1": "Laat je creativiteit op de vrije loop",
				"header2": "Ontvang vandaag 10% korting op je bestelling",
				"cta": "Ontvang nu",
				"your_cart": "Winkelwagen",
				"subtotal": "Totaal",
				"discount": "Korting",
				"new_total": "Nieuw totaal"
			},
			"french": {
				"header1": "Lib\u00E9rez votre cr\u00E9ativit\u00E9",
				"header2": "B\u00E9n\u00E9ficiez de 10 % de r\u00E9duction sur votre commande aujourd\u2019hui",
				"cta": "En profiter maintenant",
				"your_cart": "Votre panier",
				"subtotal": "Sous-total",
				"discount": "Remise",
				"new_total": "Nouveau sous-total"
			},
			"german": {
				"header1": "Lassen Sie Ihrer Kreativit\u00E4t freien Lauf",
				"header2": "Erhalten Sie heute 10% Rabatt auf Ihre Bestellung",
				"cta": "Jetzt einl\u00F6sen",
				"your_cart": "Ihr Warenkorb",
				"subtotal": "Zwischensumme",
				"discount": "Rabatt",
				"new_total": "Neue Zwischensumme"
			},
			"italian": {
				"header1": "Libera la tua creativit\u00E0",
				"header2": "Ricevi subito un 10% di sconto sul tuo ordine",
				"cta": "Approfittane ora",
				"your_cart": "Carrello",
				"subtotal": "Subtotale",
				"discount": "Sconto",
				"new_total": "Nuovo subtotale"
			},
			"korean": {
				"header1": "\uCC3D\uC758\uB825\uC744 \uB9C8\uC74C\uAECF \uBC1C\uD718\uD558\uC138\uC694",
				"header2": "\uC624\uB298 \uC8FC\uBB38\uC2DC 10% \uD560\uC778",
				"cta": "\uC9C0\uAE08 \uC0AC\uC6A9\uD558\uC138\uC694",
				"your_cart": "\uC7A5\uBC14\uAD6C\uB2C8",
				"subtotal": "\uD569\uACC4",
				"discount": "\uD560\uC778",
				"new_total": "\uC0C8\uB85C\uC6B4 \uD569\uACC4"
			},
			"portuguese": {
				"header1": "Expresse sua criatividade",
				"header2": "Obtenha hoje 10% de desconto em seu pedido",
				"cta": "Obtenha agora",
				"your_cart": "Seu carrinho",
				"subtotal": "Subtotal",
				"discount": "Desconto",
				"new_total": "Novo subtotal"
			},
			"espanol": {
				"header1": "Libera tu creatividad",
				"header2": "Consigue hoy un 10% de descuento en tu pedido",
				"cta": "Canjear ahora",
				"your_cart": "Tu Carrito",
				"subtotal": "Subtotal",
				"discount": "Descuento",
				"new_total": "Nuevo Subtotal"
			},
			"japanese": {
				"header1": "\u5275\u9020\u529B\u3092\u89E3\u304D\u653E\u3068\u3046\uFF01",
				"header2": "\u4ECA\u65E5\u306E\u3054\u6CE8\u6587\u304C10\uFF05\u30AA\u30D5\u306B\u306A\u308B",
				"cta": "\u4ECA\u3059\u3050\u5229\u7528",
				"your_cart": "\u30AB\u30FC\u30C8",
				"subtotal": "\u5C0F\u8A08",
				"discount": "\u30C7\u30A3\u30B9\u30AB\u30A6\u30F3\u30C8",
				"new_total": "\u65B0\u3057\u3044\u5C0F\u8A08"
			},
			"hindi": {
				"header1": "\u0905\u092A\u0928\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u0915\u094B \u0909\u091C\u093E\u0917\u0930 \u0915\u0930\u0947\u0902",
				"header2": "\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 10% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",
				"cta": "\u095E\u094D\u0930\u0940 \u092E\u0947\u0902 \u0906\u091C\u093C\u092E\u093E\u090F\u0901",
				"your_cart": "\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902",
				"cart": "\u0906\u092A\u0915\u093E \u0915\u093E\u0930\u094D\u091F",
				"subtotal": "\u0938\u092C\u091F\u094B\u091F\u0932",
				"discount": "\u0921\u093F\u0938\u094D\u0915\u093E\u0909\u0902\u091F",
				"new_total": "\u0928\u092F\u093E \u0938\u092C\u091F\u094B\u091F\u0932"
			},
			"tamil": {
				"header1": "\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BAA\u0B9F\u0BC8\u0BAA\u0BCD\u0BAA\u0BBE\u0BB1\u0BCD\u0BB1\u0BB2\u0BC8 \u0B95\u0B9F\u0BCD\u0B9F\u0BB5\u0BBF\u0BB4\u0BCD\u0BA4\u0BCD\u0BA4\u0BC1 \u0BB5\u0BBF\u0B9F\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",
				"header2": "\u0B87\u0BA9\u0BCD\u0BB1\u0BC1 \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BBF\u0BB2\u0BCD 10% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",
				"cta": "\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BAE\u0BC0\u0B9F\u0BCD\u0B9F\u0BC1\u0B95\u0BCD\u0B95\u0BCA\u0BB3\u0BCD\u0BB3\u0BB5\u0BC1\u0BAE\u0BCD",
				"your_cart": "\u0B89\u0BA9\u0BCD\u0BA9\u0BC1\u0B9F\u0BC8\u0BAF \u0BAA\u0BC8\u0BAF\u0BBF\u0BB2\u0BCD",
				"subtotal": "\u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8",
				"discount": "\u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF",
				"new_total": "\u0BAA\u0BC1\u0BA4\u0BBF\u0BAF \u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8",
				"css": '.usi_submitbutton {font-size: 1em !important;}'
			},
			"telugu": {
				"header1": "\u0C2E\u0C40 \u0C38\u0C43\u0C1C\u0C28\u0C3E\u0C24\u0C4D\u0C2E\u0C15\u0C24\u0C28\u0C41 \u0C35\u0C46\u0C32\u0C3F\u0C15\u0C3F\u0C24\u0C40\u0C2F\u0C02\u0C21\u0C3F",
				"header2": "\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C06\u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 10% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",
				"cta": "\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F",
				"cart": "\u0C2E\u0C40 \u0C15\u0C3E\u0C30\u0C4D\u0C1F\u0C4D",
				"subtotal": "\u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D",
				"discount": "\u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41",
				"new_total": "\u0C15\u0C4A\u0C24\u0C4D\u0C24 \u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D"
			},
			"marathi": {
				"header1": "\u0924\u0941\u092E\u091A\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u092C\u093E\u0939\u0947\u0930 \u092F\u0947\u0909 \u0926\u094D\u092F\u093E",
				"header2": "\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u0911\u0930\u094D\u0921\u0930\u0935\u0930 10% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",
				"cta": "\u0906\u0924\u093E\u091A \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E",
				"your_cart": "\u0924\u0941\u092E\u091A\u0940 \u0915\u093E\u0930\u094D\u091F",
				"subtotal": "\u090F\u0915\u0942\u0923",
				"discount": "\u0938\u0942\u091F",
				"new_total": "\u0928\u0935\u0940\u0928 \u090F\u0915\u0942\u0923"
			}
		};

		usi_app.message_premium_content = {
			"english": {
				header1: "Create projects that captivate",
				header2: "Discover premium content from award-winning artists",
				css: "",
				css_mobile: '',
				use_code: "",
				cta: "Shop Now",
				disclaimer: "We use your information in accordance with our privacy policy."
			},
			"sichinese": {
				header1:"\u6253\u9020\u5438\u5F15\u529B\u5341\u8DB3\u7684\u9879\u76EE",
				header2:"\u53D1\u73B0\u83B7\u5956\u827A\u672F\u5BB6\u7684\u7CBE\u5F69\u5185\u5BB9\n",
				css:'',
				css_mobile: '',
				use_code:"",
				cta:"\u5373\u523B\u8D2D\u4E70\n",
				disclaimer:"\u514D\u8D23\u58F0\u660E\uFF1A\u6211\u4EEC\u6839\u636E\u6211\u4EEC\u7684\u9690\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"
			},
			"trchinese": {
				header1:"\u6253\u9020\u5438\u5F15\u529B\u5341\u8DB3\u7684\u9805\u76EE\n",
				header2:"\u767C\u73FE\u7372\u734E\u85DD\u8853\u5BB6\u7684\u7CBE\u5F69\u5167\u5BB9\n",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u5373\u523B\u8CFC\u8CB7\n",
				disclaimer:"\u514D\u8CAC\u8072\u660E\uFF1A\u6211\u5011\u6839\u64DA\u6211\u5011\u7684\u96B1\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F\n"
			},
			"czech": {
				header1:"Tvo\u0159te projekty, kter\u00E9 zaujmou\n",
				header2:"Objevte pr\u00E9miov\u00FD obsah od uzn\u00E1van\u00FDch um\u011Blc\u016F\n",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Zakoupit",
				disclaimer:"Prohl\u00E1\u0161en\u00ED: Va\u0161e informace zpracov\u00E1v\u00E1me v souladu s na\u0161imi z\u00E1sadami o ochran\u011B osobn\u00EDch \u00FAdaj\u016F"
			},
			"danish": {
				header1:"Skab projekter, der f\u00E6nger\n",
				header2:"Udforsk f\u00F8rsteklasses content fra prisbel\u00F8nnede kunstnere",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Shop nu",
				disclaimer:"Ansvarsfraskrivelse: Vi bruger dine oplysninger i overensstemmelse med vores fortrolighedspolitik."
			},
			"finland": {
				header1:"Luo projekteja, jotka vangitsevat",
				header2:"L\u00F6yd\u00E4 premium-sis\u00E4lt\u00F6\u00E4 palkituilta artisteilta",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Osta nyt",
				disclaimer:"Vastuuvapauslauseke: K\u00E4yt\u00E4mme tietojasi tietosuojak\u00E4yt\u00E4nt\u00F6mme mukaisesti."
			},
			"hungary": {
				header1:"Hozzon l\u00E9tre mag\u00E1val lragad\u00F3 projekteket",
				header2:"Fedezze fel d\u00EDjnyertes m\u0171v\u00E9szek pr\u00E9mium tartalmait",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"V\u00E1s\u00E1roljon most",
				disclaimer:"- Jogi nyilatkozat: Az adatait az adatv\u00E9delmi nyilatkozatunk el\u0151\u00EDr\u00E1sai szerint haszn\u00E1ljuk fel."
			},
			"norway": {
				header1:"Skap prosjekter som fanger blikket",
				header2:"Utforsk premiuminnhold fra prisbelønte kunstnere\n",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Til butikken",
				disclaimer:"Vi bruker informasjonen din i samsvar med v\u00E5re personvernregler."
			},
			"polish": {
				header1:"Tw\u00F3rz projekty, kt\u00F3re przyci\u0105gaj\u0105 uwag\u0119",
				header2:"Odkryj tre\u015Bci premium od nagradzanych artyst\u00F3w",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Kup teraz",
				disclaimer:"Zastrze\u017Cenie: U\u017Cywamy Twoich danych zgodnie z nasz\u0105 polityk\u0105 prywatno\u015Bci."
			},
			"russia": {
				header1:"\u0421\u043E\u0437\u0434\u0430\u0432\u0430\u0439\u0442\u0435 \u043F\u0440\u043E\u0435\u043A\u0442\u044B, \u043A\u043E\u0442\u043E\u0440\u044B\u0435 \u0432\u043E\u0441\u0445\u0438\u0449\u0430\u044E\u0442",
				header2:"\u041E\u0446\u0435\u043D\u0438\u0442\u0435 \u043F\u0435\u0440\u0432\u043E\u043A\u043B\u0430\u0441\u0441\u043D\u044B\u0439 \u043A\u043E\u043D\u0442\u0435\u043D\u0442 \u043E\u0442 \u043F\u0440\u0438\u0437\u043D\u0430\u043D\u043D\u044B\u0445 \u0430\u0432\u0442\u043E\u0440\u043E\u0432",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u041F\u043E\u043A\u0443\u043F\u0430\u0439\u0442\u0435 \u0441\u0435\u0439\u0447\u0430\u0441",
				disclaimer:"\u041E\u0442\u043A\u0430\u0437 \u043E\u0442 \u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043D\u043D\u043E\u0441\u0442\u0438: \u041C\u044B \u0438\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0435\u043C \u0432\u0430\u0448\u0443 \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044E \u0432 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u0438 \u0441 \u043D\u0430\u0448\u0435\u0439 \u043F\u043E\u043B\u0438\u0442\u0438\u043A\u043E\u0439 \u043A\u043E\u043D\u0444\u0438\u0434\u0435\u043D\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0441\u0442\u0438."
			},
			"sweden": {
				header1:"Skapa projekt som f\u00E4ngsla",
				header2:"Uppt\u00E4ck premiuminneh\u00E5ll fr\u00E5n prisbel\u00F6nta konstn\u00E4rer",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Butik nu",
				disclaimer:"Observera: Vi anv\u00E4nder din information i enlighet med v\u00E5r integritetspolicy."
			},
			"thai": {
				header1:"\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E42\u0E1B\u0E23\u0E40\u0E08\u0E47\u0E01\u0E15\u0E4C\u0E17\u0E35\u0E48\u0E14\u0E36\u0E07\u0E14\u0E39\u0E14\u0E43\u0E08",
				header2:"\u0E1E\u0E1A\u0E40\u0E19\u0E37\u0E49\u0E2D\u0E2B\u0E32\u0E1E\u0E23\u0E35\u0E40\u0E21\u0E35\u0E22\u0E21\u0E08\u0E32\u0E01\u0E28\u0E34\u0E25\u0E1B\u0E34\u0E19\u0E17\u0E35\u0E48\u0E44\u0E14\u0E49\u0E23\u0E31\u0E1A\u0E23\u0E32\u0E07\u0E27\u0E31\u0E25",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u0E0B\u0E37\u0E49\u0E2D\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49",
				disclaimer:"\u0E02\u0E49\u0E2D\u0E08\u0E33\u0E01\u0E31\u0E14\u0E04\u0E27\u0E32\u0E21\u0E23\u0E31\u0E1A\u0E1C\u0E34\u0E14\u0E0A\u0E2D\u0E1A: \u0E40\u0E23\u0E32\u0E43\u0E0A\u0E49\u0E02\u0E49\u0E2D\u0E21\u0E39\u0E25\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E15\u0E32\u0E21\u0E19\u0E42\u0E22\u0E1A\u0E32\u0E22\u0E04\u0E27\u0E32\u0E21\u0E40\u0E1B\u0E47\u0E19\u0E2A\u0E48\u0E27\u0E19\u0E15\u0E31\u0E27\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32"
			},
			"turkey": {
				header1:"G\u00F6z al\u0131c\u0131 projeler yarat\u0131n",
				header2:"\u00D6d\u00FCll\u00FC sanat\u00E7\u0131lardan birinci s\u0131n\u0131f i\u00E7erikleri ke\u015Ffedin",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Hemen Sat\u0131n Al",
				disclaimer:"Sorumluluk Reddi: Bilgilerinizi gizlilik politikam\u0131za uygun olarak kullan\u0131yoruz."
			},
			"italian": {
				header1:"Crea progetti che catturano l'attenzione\n",
				header2:"Scopri i contenuti premium di artisti pluripremiati",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Acquista ora",
				disclaimer:"Avviso legale: utilizziamo le tue informazioni in conformit\u00E0 con la nostra politica sulla privacy."
			},
			"korean": {
				header1:"\uB208\uAE38\uC744 \uC0AC\uB85C\uC7A1\uB294 \uD504\uB85C\uC81D\uD2B8\uB97C \uB9CC\uB4E4\uC5B4\uBCF4\uC138\uC694",
				header2:"\uC218\uC0C1 \uACBD\uB825\uC5D0 \uBE5B\uB098\uB294 \uC544\uD2F0\uC2A4\uD2B8\uC758 \uD504\uB9AC\uBBF8\uC5C4 \uCF58\uD150\uCE20\uB97C \uB9CC\uB098\uBCF4\uC138\uC694",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\uC9C0\uAE08 \uC1FC\uD551\uD558\uAE30",
				disclaimer:"\uBA74\uCC45 \uC870\uD56D: \uC6B0\uB9AC\uB294 \uAC1C\uC778\uC815\uBCF4 \uBCF4\uD638\uC815\uCC45\uC5D0 \uB530\uB77C \uADC0\uD558\uC758 \uC815\uBCF4\uB97C \uC0AC\uC6A9\uD569\uB2C8\uB2E4"
			},
			"espanol": {
				header1:"Crea proyectos cautivadores",
				header2:"Descubre contenido premium de artistas premiados",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Comprar ahora",
				disclaimer:"Aviso legal: Utilizamos tu informaci\u00F3n de acuerdo con nuestra pol\u00EDtica de privacidad."
			},
			"french": {
				header1:"Cr\u00E9ez des projets qui captivent",
				header2:"D\u00E9couvrez du contenu premium d'artistes prim\u00E9s",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Parcourez maintenant",
				disclaimer:"Disclaimer : Nous utilisons vos informations conform\u00E9ment \u00E0 notre politique de confidentialit\u00E9. "
			},
			"portuguese": {
				header1:"Crie projetos cativantes",
				header2:"Descubra conte\u00FAdos exclusivos de artistas premiados",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Compre Agora",
				disclaimer:"Aviso Legal: Utilizamos a sua informa\u00E7\u00E3o de acordo com a nossa pol\u00EDtica de privacidade."
			},
			"german": {
				header1:"Erstellen Sie Projekte, die faszinieren",
				header2:"Entdecken Sie Premium-Inhalte von preisgekr\u00F6nten K\u00FCnstlern",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Jetzt kaufen",
				disclaimer:"Disclaimer: Wir nutzen Ihre Informationen im Einklang mit unserer Datenschutzrichtlinie."
			},
			"dutch": {
				header1:"Cre\u00EBer projecten die fascineren",
				header2:"Ontdek premium content van bekroonde artiesten",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"Nu shoppen",
				disclaimer:"Als je opzegt in de 1e maand betaal je niets!"
			},
			"japanese": {
				header1:"\u60F9\u304D\u3064\u3051\u308B\u30D7\u30ED\u30B8\u30A7\u30AF\u30C8\u3092\u4F5C\u6210",
				header2:"\u5404\u8CDE\u53D7\u8CDE\u306E\u30A2\u30FC\u30C6\u30A3\u30B9\u30C8\u306B\u3088\u308B\u30D7\u30EC\u30DF\u30A2\u30E0\u30B3\u30F3\u30C6\u30F3\u30C4\u3092\u30C7\u30A3\u30B9\u30AB\u30D0\u30FC",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u4ECA\u3059\u3050\u30C1\u30A7\u30C3\u30AF",
				disclaimer:"\u514D\u8CAC\u4E8B\u9805\uFF1A\u5F53\u793E\u306F\u3001\u304A\u5BA2\u69D8\u306E\u60C5\u5831\u3092\u5F53\u793E\u306E\u30D7\u30E9\u30A4\u30D0\u30B7\u30FC\u30DD\u30EA\u30B7\u30FC\u306B\u57FA\u3065\u304D\u4F7F\u7528\u3057\u307E\u3059\u3002"
			},
			"hindi": {
				header1:"\u0910\u0938\u0947 \u092A\u094D\u0930\u094B\u091C\u0947\u0915\u094D\u091F \u092C\u0928\u093E\u090F\u0902 \u091C\u094B \u0906\u092A\u0915\u094B \u0906\u0915\u0930\u094D\u0937\u093F\u0924 \u0915\u0930\u0947\u0902\n",
				header2:"\u092A\u0941\u0930\u0938\u094D\u0915\u093E\u0930 \u0935\u093F\u091C\u0947\u0924\u093E \u0915\u0932\u093E\u0915\u093E\u0930\u094B\u0902 \u0915\u0940 \u092A\u094D\u0930\u0940\u092E\u093F\u092F\u092E \u0938\u093E\u092E\u0917\u094D\u0930\u0940 \u0916\u094B\u091C\u0947\u0902",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u0905\u092D\u0940 \u0916\u0930\u0940\u0926\u0947\u0902\n",
				disclaimer:"\u0939\u092E \u0906\u092A\u0915\u0940 \u091C\u093E\u0928\u0915\u093E\u0930\u0940 \u0915\u093E \u0909\u092A\u092F\u094B\u0917 \u0939\u092E\u093E\u0930\u0940 \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0928\u0940\u0924\u093F \u0915\u0947 \u0905\u0928\u0941\u0938\u093E\u0930 \u0915\u0930\u0924\u0947 \u0939\u0948\u0902\u0964"
			},
			"tamil": {
				header1:"\u0BB5\u0B9A\u0BC0\u0B95\u0BB0\u0BBF\u0B95\u0BCD\u0B95\u0BC1\u0BAE\u0BCD \u0BA4\u0BBF\u0B9F\u0BCD\u0B9F\u0B99\u0BCD\u0B95\u0BB3\u0BC8 \u0B89\u0BB0\u0BC1\u0BB5\u0BBE\u0B95\u0BCD\u0B95\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",
				header2:"\u0BB5\u0BBF\u0BB0\u0BC1\u0BA4\u0BC1 \u0BAA\u0BC6\u0BB1\u0BCD\u0BB1 \u0B95\u0BB2\u0BC8\u0B9E\u0BB0\u0BCD\u0B95\u0BB3\u0BBF\u0B9F\u0BAE\u0BBF\u0BB0\u0BC1\u0BA8\u0BCD\u0BA4\u0BC1 \u0BAA\u0BBF\u0BB0\u0BC0\u0BAE\u0BBF\u0BAF\u0BAE\u0BCD \u0B89\u0BB3\u0BCD\u0BB3\u0B9F\u0B95\u0BCD\u0B95\u0BA4\u0BCD\u0BA4\u0BC8\u0B95\u0BCD \u0B95\u0BA3\u0BCD\u0B9F\u0BB1\u0BBF\u0BAF\u0BB5\u0BC1\u0BAE\u0BCD",
				css:".usi_header_text {font-size: 1em !important;} .usi_text_bottom{font-size: 1.75em !important;}",
				css_mobile: '',
				use_code:"",
				cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BB5\u0BBE\u0B99\u0BCD\u0B95\u0BB5\u0BC1\u0BAE\u0BCD",
				disclaimer:"\u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0BA9\u0BBF\u0BAF\u0BC1\u0BB0\u0BBF\u0BAE\u0BC8\u0B95\u0BCD \u0B95\u0BCA\u0BB3\u0BCD\u0B95\u0BC8\u0BAF\u0BBF\u0BA9\u0BCD\u0BAA\u0B9F\u0BBF \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0B95\u0BB5\u0BB2\u0BC8\u0BAA\u0BCD \u0BAA\u0BAF\u0BA9\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0B95\u0BBF\u0BB1\u0BCB\u0BAE\u0BCD."
			},
			"telugu": {
				header1:"\u0C06\u0C15\u0C30\u0C4D\u0C37\u0C23\u0C40\u0C2F\u0C2E\u0C48\u0C28 \u0C2A\u0C4D\u0C30\u0C3E\u0C1C\u0C46\u0C15\u0C4D\u0C1F\u0C4D\u200C\u0C32\u0C28\u0C41 \u0C38\u0C43\u0C37\u0C4D\u0C1F\u0C3F\u0C02\u0C1A\u0C02\u0C21\u0C3F",
				header2:"\u0C05\u0C35\u0C3E\u0C30\u0C4D\u0C21\u0C41 \u0C17\u0C46\u0C32\u0C41\u0C1A\u0C41\u0C15\u0C41\u0C28\u0C4D\u0C28 \u0C15\u0C33\u0C3E\u0C15\u0C3E\u0C30\u0C41\u0C32 \u0C28\u0C41\u0C02\u0C21\u0C3F \u0C2A\u0C4D\u0C30\u0C40\u0C2E\u0C3F\u0C2F\u0C02 \u0C15\u0C02\u0C1F\u0C46\u0C02\u0C1F\u0C4D\u200C\u0C28\u0C41 \u0C15\u0C28\u0C41\u0C17\u0C4A\u0C28\u0C02\u0C21\u0C3F",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C37\u0C3E\u0C2A\u0C3F\u0C02\u0C17\u0C4D \u0C1A\u0C47\u0C2F\u0C02\u0C21\u0C3F",
				disclaimer:"\u0C2E\u0C47\u0C2E\u0C41 \u0C2E\u0C40 \u0C38\u0C2E\u0C3E\u0C1A\u0C3E\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C2E\u0C3E \u0C17\u0C4B\u0C2A\u0C4D\u0C2F\u0C24\u0C3E \u0C35\u0C3F\u0C27\u0C3E\u0C28\u0C3E\u0C28\u0C3F\u0C15\u0C3F \u0C05\u0C28\u0C41\u0C17\u0C41\u0C23\u0C02\u0C17\u0C3E \u0C09\u0C2A\u0C2F\u0C4B\u0C17\u0C3F\u0C38\u0C4D\u0C24\u0C3E\u0C2E\u0C41."
			},
			"marathi": {
				header1:"\u092E\u094B\u0939\u0915 \u092A\u094D\u0930\u094B\u091C\u0947\u0915\u094D\u091F \u0924\u092F\u093E\u0930 \u0915\u0930\u093E",
				header2:"\u092A\u0941\u0930\u0938\u094D\u0915\u093E\u0930\u092A\u094D\u0930\u093E\u092A\u094D\u0924 \u0915\u0932\u093E\u0915\u093E\u0930\u093E\u0902\u0915\u0921\u0942\u0928 \u092A\u094D\u0930\u0940\u092E\u093F\u092F\u092E \u0938\u093E\u092E\u0917\u094D\u0930\u0940 \u0936\u094B\u0927\u093E",
				css:"",
				css_mobile: '',
				use_code:"",
				cta:"\u0906\u0924\u093E \u0916\u0930\u0947\u0926\u0940 \u0915\u0930\u093E",
				disclaimer:"\u0906\u092E\u094D\u0939\u0940 \u0924\u0941\u092E\u091A\u0940 \u092E\u093E\u0939\u093F\u0924\u0940 \u0906\u092E\u091A\u094D\u092F\u093E \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0927\u094B\u0930\u0923\u093E\u0928\u0941\u0938\u093E\u0930 \u0935\u093E\u092A\u0930\u0924\u094B."
			},
		};

		usi_app.message_sitewide_20percent_q42024 = {
			"english": {header1:"Unleash your creativity",header2:"Get 20% off your order today", header3: "", css:".usi_header1{font-size: 3.5em !important;} .usi_header2{width: 42% !important; left: 8% !important; top: 50% !important; font-weight: normal !important; font-size: 2.5em !important;}", css_mobile: '',  use_code:"",cta:"Redeem now", disclaimer:"We use your information in accordance with our privacy policy.", cart: {your_cart: 'Your Cart', subtotal: "Subtotal", discount:"Discount", new_subtotal: "New Subtotal"}},
			"sichinese": {header1:"\u91CA\u653E\u60A8\u7684\u521B\u4F5C\u624D\u534E",header2:"\u4ECA\u5929\u53EF\u4EAB8\u6298\u4F18\u60E0",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u5FEB\u6765\u5151\u6362\u5427", disclaimer:"\u514D\u8D23\u58F0\u660E\uFF1A\u6211\u4EEC\u6839\u636E\u6211\u4EEC\u7684\u9690\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F", cart: {your_cart: '\u60A8\u7684\u5361\u53F7', subtotal: "\u5C0F\u8BA1", discount:"\u6298\u6263", new_subtotal: "\u6298\u540E\u5C0F\u8BA1"}},
			"trchinese": {header1:"\u91CB\u653E\u60A8\u7684\u5275\u4F5C\u624D\u83EF",header2:"\u4ECA\u5929\u53EF\u4EAB\u53D78\u6298\u512A\u60E0",header3: "", css:'.usi_header2{font-size:3.5em !important;}', css_mobile: '', use_code:"",cta:"\u5FEB\u4F86\u514C\u63DB\u5427", disclaimer:"\u514D\u8CAC\u8072\u660E\uFF1A\u6211\u5011\u6839\u64DA\u6211\u5011\u7684\u96B1\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F", cart: {your_cart: '\u60A8\u7684\u5361\u865F', subtotal: "\u5C0F\u8A08", discount:"\u6298\u6263", new_subtotal: "\u512A\u60E0\u5F8C\u5C0F\u8A08"}},
			"czech": {header1:"Popus\u0165te uzdu sv\u00E9 kreativit\u011B",header2:"Z\u00EDskejte 20% slevu na svou objedn\u00E1vku je\u0161t\u011B dnes",header3: "", css:'', css_mobile: '', use_code:"",cta:"Uplatnit nyní", disclaimer:"Prohl\u00E1\u0161en\u00ED: Va\u0161e informace zpracov\u00E1v\u00E1me v souladu s na\u0161imi z\u00E1sadami o ochran\u011B osobn\u00EDch \u00FAdaj\u016F", cart: {your_cart: 'V\u00E1\u0161 ko\u0161\u00EDk', subtotal: "Mezisou\u010Det", discount:"Sleva", new_subtotal: "Nov\u00FD mezisou\u010Det"}},
			"danish": {header1:"Slip kreativiteten l\u00F8s",header2:"F\u00E5 20% rabat p\u00E5 din ordre i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"Indl\u00F8s nu", disclaimer:"Ansvarsfraskrivelse: Vi bruger dine oplysninger i overensstemmelse med vores fortrolighedspolitik.", cart: {your_cart: 'Din kurv', subtotal: "Subtotal", discount:"Rabat", new_subtotal: "Ny subtotal"}},
			"finland": {header1:"P\u00E4\u00E4st\u00E4 luovuutesi valloilleen",header2:"Saat 20 % alennuksen tilauksestasi t\u00E4n\u00E4\u00E4n",header3: "", css:'', css_mobile: '', use_code:"",cta:"Lunasta nyt", disclaimer:"Vastuuvapauslauseke: K\u00E4yt\u00E4mme tietojasi tietosuojak\u00E4yt\u00E4nt\u00F6mme mukaisesti.", cart: {your_cart: 'Ostoskorisi', subtotal: "V\u00E4lisumma", discount:"Alennus", new_subtotal: "Uusi v\u00E4lisumma"}},
			"hungary": {header1:"Engedje szabadj\u00E1ra a kreativit\u00E1s\u00E1t",header2:"20% engedm\u00E9ny, ha ma rendel",header3: "", css:'', css_mobile: '', use_code:"",cta:"Szerezze meg most", disclaimer:"Jogi nyilatkozat: Az adatait az adatv\u00E9delmi nyilatkozatunk el\u0151\u00EDr\u00E1sai szerint haszn\u00E1ljuk fel.", cart: {your_cart: 'A kosara', subtotal: "V\u00E9g\u00F6sszeg", discount:"Engedm\u00E9ny", new_subtotal: "\u00DAj v\u00E9g\u00F6sszeg"}},
			"norway": {header1:"Slipp kreativiteten l\u00F8s",header2:"F\u00E5 20 % rabatt p\u00E5 ordren din i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"L\u00F8s inn n\u00E5", disclaimer:"Vi bruker informasjonen din i samsvar med v\u00E5re personvernregler", cart: {your_cart: 'Din handlekurv', subtotal: "Delsum", discount:"Rabatt", new_subtotal: "Totalt"}},
			"polish": {header1:"Wyzw\u00F3l swoj\u0105 kreatywno\u015B\u0107",header2:"Otrzymaj -20% na zam\u00F3wienie ju\u017C dzisiaj",header3: "", css:'', css_mobile: '', use_code:"",cta:"Skorzystaj teraz", disclaimer:"Zastrze\u017Cenie: U\u017Cywamy Twoich danych zgodnie z nasz\u0105 polityk\u0105 prywatno\u015Bci", cart: {your_cart: 'Tw\u00F3j koszyk', subtotal: "Suma cz\u0119\u015Bciowa", discount:"Zni\u017Cka", new_subtotal: "Nowa suma cz\u0119\u015Bciowa"}},
			"russia": {header1:"\u0420\u0430\u0441\u043A\u0440\u043E\u0439 \u0441\u0432\u043E\u044E \u043A\u0440\u0435\u0430\u0442\u0438\u0432\u043D\u043E\u0441\u0442\u044C",header2:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 20% \u043D\u0430 \u0432\u0430\u0448 \u0437\u0430\u043A\u0430\u0437 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",header3: "", css:'.usi_label{font-size:12px !important;}', css_mobile: '', use_code:"",cta:"\u0410\u043A\u0442\u0438\u0432\u0438\u0440\u043E\u0432\u0430\u0442\u044C", disclaimer:"\u041E\u0442\u043A\u0430\u0437 \u043E\u0442 \u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043D\u043D\u043E\u0441\u0442\u0438: \u041C\u044B \u0438\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0435\u043C \u0432\u0430\u0448\u0443 \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044E \u0432 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u0438 \u0441 \u043D\u0430\u0448\u0435\u0439 \u043F\u043E\u043B\u0438\u0442\u0438\u043A\u043E\u0439 \u043A\u043E\u043D\u0444\u0438\u0434\u0435\u043D\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0441\u0442\u0438.", cart: {your_cart: '\u0412\u0430\u0448\u0430 \u041A\u043E\u0440\u0437\u0438\u043D\u0430', subtotal: "\u041F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0418\u0442\u043E\u0433", discount:"\u0421\u043A\u0438\u0434\u043A\u0430", new_subtotal: "\u041D\u043E\u0432\u044B\u0439 \u043F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433"}},
			"sweden": {header1:"Sl\u00E4pp loss din kreativitet",header2:"F\u00E5 20% rabatt p\u00E5 din best\u00E4llning idag",header3: "", css:'', css_mobile: '', use_code:"",cta:"L\u00F6s in nu", disclaimer:"Observera: Vi anv\u00E4nder din information i enlighet med v\u00E5r integritetspolicy.", cart: {your_cart: 'Din kundvagn', subtotal: "Delsumma", discount:"Rabatt", new_subtotal: "Ny delsumma"}},
			"thai": {header1:"\u0E1B\u0E25\u0E14\u0E1B\u0E25\u0E48\u0E2D\u0E22\u0E04\u0E27\u0E32\u0E21\u0E04\u0E34\u0E14\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E2A\u0E23\u0E23\u0E04\u0E4C\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",header2:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 20% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0E1A\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49", disclaimer:"\u0E02\u0E49\u0E2D\u0E08\u0E33\u0E01\u0E31\u0E14\u0E04\u0E27\u0E32\u0E21\u0E23\u0E31\u0E1A\u0E1C\u0E34\u0E14\u0E0A\u0E2D\u0E1A: \u0E40\u0E23\u0E32\u0E43\u0E0A\u0E49\u0E02\u0E49\u0E2D\u0E21\u0E39\u0E25\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E15\u0E32\u0E21\u0E19\u0E42\u0E22\u0E1A\u0E32\u0E22\u0E04\u0E27\u0E32\u0E21\u0E40\u0E1B\u0E47\u0E19\u0E2A\u0E48\u0E27\u0E19\u0E15\u0E31\u0E27\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32", cart: {your_cart: '\u0E23\u0E16\u0E40\u0E02\u0E47\u0E19\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13', subtotal: "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22", discount:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14", new_subtotal: "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22\u0E43\u0E2B\u0E21\u0E48"}},
			"turkey": {header1:"Yarat\u0131c\u0131l\u0131\u011F\u0131n\u0131z\u0131 serbest b\u0131rak\u0131n",header2:"Bug\u00FCn verece\u011Finiz sipari\u015Finizde %20 indirim kazan\u0131n",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u015Eimdi kullan", disclaimer:"Sorumluluk Reddi: Bilgilerinizi gizlilik politikam\u0131za uygun olarak kullan\u0131yoruz.", cart: {your_cart: 'Sepetiniz', subtotal: "Ara Toplam", discount:"\u0130ndirim", new_subtotal: "Yeni Ara Toplam"}},
			"italian": {header1:"Libera la tua creativit\u00E0",header2:"Ricevi subito un 20% di sconto sul tuo ordine",header3: "", css:'', css_mobile: '', use_code:"",cta:"Approfittane ora", disclaimer:"Avviso legale: utilizziamo le tue informazioni in conformit\u00E0 con la nostra politica sulla privacy.", cart: {your_cart: 'Carrello', subtotal: "Subtotale", discount:"Sconto", new_subtotal: "Nuovo subtotale"}},
			"korean": {header1:"\uCC3D\uC758\uB825\uC744 \uB9C8\uC74C\uAECF \uBC1C\uD718\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uC2DC 20% \uD560\uC778 ",header3: "", css:'', css_mobile: '', use_code:"",cta:"\uC9C0\uAE08 \uC0AC\uC6A9\uD558\uC138\uC694", disclaimer:"\uBA74\uCC45 \uC870\uD56D: \uC6B0\uB9AC\uB294 \uAC1C\uC778\uC815\uBCF4 \uBCF4\uD638\uC815\uCC45\uC5D0 \uB530\uB77C \uADC0\uD558\uC758 \uC815\uBCF4\uB97C \uC0AC\uC6A9\uD569\uB2C8\uB2E4", cart: {your_cart: '\uC7A5\uBC14\uAD6C\uB2C8', subtotal: "\uD569\uACC4", discount:"\uD560\uC778", new_subtotal: "\uC0C8\uB85C\uC6B4 \uD569\uACC4"}},
			"espanol": {header1:"Libera tu creatividad",header2:"Consigue hoy un 20% de descuento en tu pedido",header3: "", css:'', css_mobile: '', use_code:"",cta:"Canjear ahora", disclaimer:"Aviso legal: Utilizamos tu informaci\u00F3n de acuerdo con nuestra pol\u00EDtica de privacidad.", cart: {your_cart: 'Tu Carrito', subtotal: "Subtotal", discount:"Descuento", new_subtotal: "Nuevo Subtotal"}},
			"french": {header1:"Lib\u00E9rez votre cr\u00E9ativit\u00E9",header2:"B\u00E9n\u00E9ficiez de 20 % de r\u00E9duction sur votre commande aujourd\u2019hui",header3: "", css:'.usi_submitbutton{font-size: 1.3em !important;}', css_mobile: '', use_code:"",cta:"En profiter maintenant", disclaimer:"Disclaimer : Nous utilisons vos informations conform\u00E9ment \u00E0 notre politique de confidentialit\u00E9. ", cart: {your_cart: 'Votre panier', subtotal: "Sous-total ", discount:"Remise", new_subtotal: "Nouveau sous-total"}},
			"portuguese": {header1:"Expresse sua criatividade",header2:"Obtenha hoje 20% de desconto em seu pedido",header3: "", css:'', css_mobile: '', use_code:"",cta:"Obtenha agora", disclaimer:"Aviso Legal: Utilizamos a sua informa\u00E7\u00E3o de acordo com a nossa pol\u00EDtica de privacidade.", cart: {your_cart: 'Seu carrinho', subtotal: "Subtotal", discount:"Desconto", new_subtotal: "Novo subtotal"}},
			"german": {header1:"Lassen Sie Ihrer Kreativit\u00E4t freien Lauf",header2:"Erhalten Sie heute 20% Rabatt auf Ihre Bestellung",header3: "", css:'', css_mobile: '', use_code:"",cta:"Jetzt einl\u00F6sen", disclaimer:"Disclaimer: Wir nutzen Ihre Informationen im Einklang mit unserer Datenschutzrichtlinie.", cart: {your_cart: 'Ihr Warenkorb', subtotal: "Zwischensumme", discount:"Rabatt", new_subtotal: "Neue Zwischensumme"}},
			"dutch": {header1:"Laat je creativiteit op de vrije loop",header2:"Ontvang vandaag 20% korting op je bestelling",header3: "", css:'', css_mobile: '', use_code:"",cta:"Ontvang nu", disclaimer:"", cart: {your_cart: 'Winkelwagen', subtotal: "Totaal", discount:"Korting", new_subtotal: "Nieuw totaal"}},
			"japanese": {header1:"\u5275\u9020\u529B\u3092\u89E3\u304D\u653E\u3068\u3046\uFF01",header2:"\u4ECA\u65E5\u306E\u3054\u6CE8\u6587\u304C20\uFF05\u30AA\u30D5\u306B\u306A\u308B", header3: "",css:'', css_mobile: '', use_code:"",cta:"\u4ECA\u3059\u3050\u5229\u7528", disclaimer:"\u514D\u8CAC\u4E8B\u9805\uFF1A\u5F53\u793E\u306F\u3001\u304A\u5BA2\u69D8\u306E\u60C5\u5831\u3092\u5F53\u793E\u306E\u30D7\u30E9\u30A4\u30D0\u30B7\u30FC\u30DD\u30EA\u30B7\u30FC\u306B\u57FA\u3065\u304D\u4F7F\u7528\u3057\u307E\u3059\u3002", cart: {your_cart: '\u30AB\u30FC\u30C8', subtotal: "\u5C0F\u8A08", discount:"\u30C7\u30A3\u30B9\u30AB\u30A6\u30F3\u30C8", new_subtotal: "\u65B0\u3057\u3044\u5C0F\u8A08"}},
			"hindi": {header1:"\u0905\u092A\u0928\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u0915\u094B \u0909\u091C\u093E\u0917\u0930 \u0915\u0930\u0947\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 20% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902", disclaimer:"\u0939\u092E \u0906\u092A\u0915\u0940 \u091C\u093E\u0928\u0915\u093E\u0930\u0940 \u0915\u093E \u0909\u092A\u092F\u094B\u0917 \u0939\u092E\u093E\u0930\u0940 \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0928\u0940\u0924\u093F \u0915\u0947 \u0905\u0928\u0941\u0938\u093E\u0930 \u0915\u0930\u0924\u0947 \u0939\u0948\u0902\u0964", cart: {your_cart: '\u0906\u092A\u0915\u093E \u0915\u093E\u0930\u094D\u091F', subtotal: "\u0938\u092C\u091F\u094B\u091F\u0932", discount:"\u0921\u093F\u0938\u094D\u0915\u093E\u0909\u0902\u091F", new_subtotal: "\u0928\u092F\u093E \u0938\u092C\u091F\u094B\u091F\u0932"}},
			"tamil": {header1:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BAA\u0B9F\u0BC8\u0BAA\u0BCD\u0BAA\u0BBE\u0BB1\u0BCD\u0BB1\u0BB2\u0BC8 \u0B95\u0B9F\u0BCD\u0B9F\u0BB5\u0BBF\u0BB4\u0BCD\u0BA4\u0BCD\u0BA4\u0BC1 \u0BB5\u0BBF\u0B9F\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BA9\u0BCD\u0BB1\u0BC1 \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BBF\u0BB2\u0BCD 20% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header3: "", css:".usi_header1{font-size: 1.8em !important;} .usi_header2{font-size: 1.8em !important;}", css_mobile: '', use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BAE\u0BC0\u0B9F\u0BCD\u0B9F\u0BC1\u0B95\u0BCD\u0B95\u0BCA\u0BB3\u0BCD\u0BB3\u0BB5\u0BC1\u0BAE\u0BCD", disclaimer:"\u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0BA9\u0BBF\u0BAF\u0BC1\u0BB0\u0BBF\u0BAE\u0BC8\u0B95\u0BCD \u0B95\u0BCA\u0BB3\u0BCD\u0B95\u0BC8\u0BAF\u0BBF\u0BA9\u0BCD\u0BAA\u0B9F\u0BBF \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0B95\u0BB5\u0BB2\u0BC8\u0BAA\u0BCD \u0BAA\u0BAF\u0BA9\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0B95\u0BBF\u0BB1\u0BCB\u0BAE\u0BCD.", cart: {your_cart: '\u0B89\u0BA9\u0BCD\u0BA9\u0BC1\u0B9F\u0BC8\u0BAF \u0BAA\u0BC8\u0BAF\u0BBF\u0BB2\u0BCD', subtotal: "\u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8", discount:"\u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF", new_subtotal: "\u0BAA\u0BC1\u0BA4\u0BBF\u0BAF \u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8"}},
			"telugu": {header1:"\u0C2E\u0C40 \u0C38\u0C43\u0C1C\u0C28\u0C3E\u0C24\u0C4D\u0C2E\u0C15\u0C24\u0C28\u0C41 \u0C35\u0C46\u0C32\u0C3F\u0C15\u0C3F\u0C24\u0C40\u0C2F\u0C02\u0C21\u0C3F",header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C06\u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 20% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F", disclaimer:"\u0C2E\u0C47\u0C2E\u0C41 \u0C2E\u0C40 \u0C38\u0C2E\u0C3E\u0C1A\u0C3E\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C2E\u0C3E \u0C17\u0C4B\u0C2A\u0C4D\u0C2F\u0C24\u0C3E \u0C35\u0C3F\u0C27\u0C3E\u0C28\u0C3E\u0C28\u0C3F\u0C15\u0C3F \u0C05\u0C28\u0C41\u0C17\u0C41\u0C23\u0C02\u0C17\u0C3E \u0C09\u0C2A\u0C2F\u0C4B\u0C17\u0C3F\u0C38\u0C4D\u0C24\u0C3E\u0C2E\u0C41.", cart: {your_cart: '\u0C2E\u0C40 \u0C15\u0C3E\u0C30\u0C4D\u0C1F\u0C4D', subtotal: "\u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D", discount:"\u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41", new_subtotal: "\u0C15\u0C4A\u0C24\u0C4D\u0C24 \u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D"}},
			"marathi": {header1:"\u0924\u0941\u092E\u091A\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u092C\u093E\u0939\u0947\u0930 \u092F\u0947\u0909 \u0926\u094D\u092F\u093E",header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u0911\u0930\u094D\u0921\u0930\u0935\u0930 20% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0906\u0924\u093E\u091A \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E", disclaimer:"\u0906\u092E\u094D\u0939\u0940 \u0924\u0941\u092E\u091A\u0940 \u092E\u093E\u0939\u093F\u0924\u0940 \u0906\u092E\u091A\u094D\u092F\u093E \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0927\u094B\u0930\u0923\u093E\u0928\u0941\u0938\u093E\u0930 \u0935\u093E\u092A\u0930\u0924\u094B.", cart: {your_cart: '\u0924\u0941\u092E\u091A\u0940 \u0915\u093E\u0930\u094D\u091F', subtotal: "\u090F\u0915\u0942\u0923", discount:"\u0938\u0942\u091F", new_subtotal: "\u0928\u0935\u0940\u0928 \u090F\u0915\u0942\u0923"}},
		};

		usi_app.message_bfcm_2024 = {
			"english": {css:'.usi_header2{font-size:3.25em !important;}', css_mobile: '', header1:"Cyber Day Savings",header2:"For a limited time get 25% off your order", use_code:"",cta:"Save Now", disclaimer:"Exclusions Apply", cart: {your_cart: 'Your Cart', subtotal: "Subtotal", discount:"Discount", new_subtotal: "New Subtotal"}},
			"sichinese": {header1:"\u91CA\u653E\u60A8\u7684\u521B\u4F5C\u624D\u534E",header2:"\u4ECA\u5929\u53EF\u4EAB8\u6298\u4F18\u60E0", css:'', css_mobile: '', use_code:"",cta:"\u5FEB\u6765\u5151\u6362\u5427", disclaimer:"\u53EF\u80FD\u5B58\u5728\u4F8B\u5916\u60C5\u51B5", cart: {your_cart: '\u60A8\u7684\u5361\u53F7', subtotal: "\u5C0F\u8BA1", discount:"\u6298\u6263", new_subtotal: "\u6298\u540E\u5C0F\u8BA1"}},
			"trchinese": {header1:"\u91CB\u653E\u60A8\u7684\u5275\u4F5C\u624D\u83EF",header2:"\u4ECA\u5929\u53EF\u4EAB\u53D78\u6298\u512A\u60E0", css:'.usi_header2{font-size:3.5em !important;}', css_mobile: '', use_code:"",cta:"\u5FEB\u4F86\u514C\u63DB\u5427", disclaimer:"\u4F8B\u5916\u60C5\u6CC1\u53EF\u80FD\u9069\u7528", cart: {your_cart: '\u60A8\u7684\u5361\u865F', subtotal: "\u5C0F\u8A08", discount:"\u6298\u6263", new_subtotal: "\u512A\u60E0\u5F8C\u5C0F\u8A08"}},
			"czech": {header1:"Popus\u0165te uzdu sv\u00E9 kreativit\u011B",header2:"Z\u00EDskejte 25% slevu na svou objedn\u00E1vku je\u0161t\u011B dnes", css:'.usi_header2{font-size:2.5em !important;}', css_mobile: '', use_code:"",cta:"Uplatnit nyn\u00ED", disclaimer:"Nab\u00EDdka m\u016F\u017Ee podl\u00E9hat v\u00FDjimk\u00E1m", cart: {your_cart: 'V\u00E1\u0161 ko\u0161\u00EDk', subtotal: "Mezisou\u010Det", discount:"Sleva", new_subtotal: "Nov\u00FD mezisou\u010Det"}},
			"danish": {header1:"Slip kreativiteten l\u00F8s",header2:"F\u00E5 25% rabat p\u00E5 din ordre i dag", css:'', css_mobile: '', use_code:"",cta:"Indl\u00F8s nu", disclaimer:"Undtagelser kan v\u00E6re g\u00E6ldende", cart: {your_cart: 'Din kurv', subtotal: "Subtotal", discount:"Rabat", new_subtotal: "Ny subtotal"}},
			"finland": {header1:"P\u00E4\u00E4st\u00E4 luovuutesi valloilleen",header2:"Saat 25 % alennuksen tilauksestasi t\u00E4n\u00E4\u00E4n", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"Lunasta nyt", disclaimer:"Saattaa sis\u00E4lt\u00E4\u00E4 poikkeuksia", cart: {your_cart: 'Ostoskorisi', subtotal: "V\u00E4lisumma", discount:"Alennus", new_subtotal: "Uusi v\u00E4lisumma"}},
			"hungary": {header1:"Engedje szabadj\u00E1ra a kreativit\u00E1s\u00E1t",header2:"25% engedm\u00E9ny, ha ma rendel", css:'.usi_header2{top:34% !important; font-size:3.5em !important;}', css_mobile: '.usi_header2{top:21% !important;}', use_code:"",cta:"Szerezze meg most", disclaimer:"Kiz\u00E1r\u00E1sok vonatkozhatnak", cart: {your_cart: 'A kosara', subtotal: "V\u00E9g\u00F6sszeg", discount:"Engedm\u00E9ny", new_subtotal: "\u00DAj v\u00E9g\u00F6sszeg"}},
			"norway": {header1:"Slipp kreativiteten l\u00F8s",header2:"F\u00E5 25 % rabatt p\u00E5 ordren din i dag", css:'.usi_header2{font-size:3.5em !important;}', css_mobile: '', use_code:"",cta:"L\u00F8s inn n\u00E5", disclaimer:"Unntak kan forekomme", cart: {your_cart: 'Din handlekurv', subtotal: "Delsum", discount:"Rabatt", new_subtotal: "Totalt"}},
			"polish": {header1:"Wyzw\u00F3l swoj\u0105 kreatywno\u015B\u0107",header2:"Otrzymaj -25% na zam\u00F3wienie ju\u017C dzisiaj", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"Skorzystaj teraz", disclaimer:"Mog\u0105 obowi\u0105zywa\u0107 wy\u0142\u0105czenia",  cart: {your_cart: 'Tw\u00F3j koszyk', subtotal: "Suma cz\u0119\u015Bciowa", discount:"Zni\u017Cka", new_subtotal: "Nowa suma cz\u0119\u015Bciowa"}},
			"russia": {header1:"\u0420\u0430\u0441\u043A\u0440\u043E\u0439 \u0441\u0432\u043E\u044E \u043A\u0440\u0435\u0430\u0442\u0438\u0432\u043D\u043E\u0441\u0442\u044C",header2:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 25% \u043D\u0430 \u0432\u0430\u0448 \u0437\u0430\u043A\u0430\u0437 \u0441\u0435\u0433\u043E\u0434\u043D\u044F", css:'.usi_header2{font-size:3em !important;}', css_mobile: '.usi_label{font-size:8px !important;}', use_code:"",cta:"\u0410\u043A\u0442\u0438\u0432\u0438\u0440\u043E\u0432\u0430\u0442\u044C", disclaimer:"\u041C\u043E\u0433\u0443\u0442 \u0431\u044B\u0442\u044C \u0438\u0441\u043A\u043B\u044E\u0447\u0435\u043D\u0438\u044F", cart: {your_cart: '\u0412\u0430\u0448\u0430 \u041A\u043E\u0440\u0437\u0438\u043D\u0430', subtotal: "\u041F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0418\u0442\u043E\u0433", discount:"\u0421\u043A\u0438\u0434\u043A\u0430", new_subtotal: "\u041D\u043E\u0432\u044B\u0439 \u043F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433"}},
			"sweden": {header1:"Sl\u00E4pp loss din kreativitet",header2:"F\u00E5 25% rabatt p\u00E5 din best\u00E4llning idag", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"L\u00F6s in nu", disclaimer:"Undantag kan g\u00E4lla", cart: {your_cart: 'Din kundvagn', subtotal: "Delsumma", discount:"Rabatt", new_subtotal: "Ny delsumma"}},
			"thai": {header1:"\u0E1B\u0E25\u0E14\u0E1B\u0E25\u0E48\u0E2D\u0E22\u0E04\u0E27\u0E32\u0E21\u0E04\u0E34\u0E14\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E2A\u0E23\u0E23\u0E04\u0E4C\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",header2:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 25% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"\u0E1A\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49", disclaimer:"\u0E2D\u0E32\u0E08\u0E21\u0E35\u0E02\u0E49\u0E2D\u0E22\u0E01\u0E40\u0E27\u0E49\u0E19", cart: {your_cart: '\u0E23\u0E16\u0E40\u0E02\u0E47\u0E19\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13', subtotal: "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22", discount:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14", new_subtotal: "\u0E23\u0E32\u0E04\u0E32\u0E23\u0E27\u0E21\u0E22\u0E48\u0E2D\u0E22\u0E43\u0E2B\u0E21\u0E48"}},
			"turkey": {header1:"Yarat\u0131c\u0131l\u0131\u011F\u0131n\u0131z\u0131 serbest b\u0131rak\u0131n",header2:"Bug\u00FCn verece\u011Finiz sipari\u015Finizde %25 indirim kazan\u0131n", css:'.usi_header2{font-size:2.5em !important;}', css_mobile: '', use_code:"",cta:"\u015Eimdi kullan", disclaimer:"\u0130stisnalar olabilir", cart: {your_cart: 'Sepetiniz', subtotal: "Ara Toplam", discount:"\u0130ndirim", new_subtotal: "Yeni Ara Toplam"}},
			"dutch": {header1:"Laat je creativiteit op de vrije loop",header2:"Ontvang vandaag 25% korting op je bestelling", css:'.usi_header2{font-size:2.75em !important;}', css_mobile: '.usi_header2{top:19% !important;}', use_code:"",cta:"Ontvang nu", disclaimer:"Er kunnen uitsluitingen van toepassing zijn", cart: {your_cart: 'Winkelwagen', subtotal: "Totaal", discount:"Korting", new_subtotal: "Nieuw totaal"}},
			"french": {header1:"Lib\u00E9rez votre cr\u00E9ativit\u00E9",header2:"B\u00E9n\u00E9ficiez de 25 % de r\u00E9duction sur votre commande aujourd\u2019hui", css:'.usi_submitbutton {font-size:1.5em !important;} .usi_header2{font-size:2.75em !important;}', css_mobile: '', use_code:"",cta:"En profiter maintenant", disclaimer:"Des exclusions peuvent s'appliquer", cart: {your_cart: 'Votre panier', subtotal: "Sous-total ", discount:"Remise", new_subtotal: "Nouveau sous-total"}},
			"german": {header1:"Lassen Sie Ihrer Kreativit\u00E4t freien Lauf",header2:"Erhalten Sie heute 25% Rabatt auf Ihre Bestellung", css:'.usi_header2{font-size:2.5em !important;}', css_mobile: '.usi_header1{font-size:1.7em !important;} .usi_header2{top:19% !important;}', use_code:"",cta:"Jetzt einl\u00F6sen", disclaimer:"Ausschl\u00FCsse m\u00F6glich", cart: {your_cart: 'Ihr Warenkorb', subtotal: "Zwischensumme", discount:"Rabatt", new_subtotal: "Neue Zwischensumme"}},
			"italian": {header1:"Libera la tua creativit\u00E0",header2:"Ricevi subito un 25% di sconto sul tuo ordine", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"Approfittane ora", disclaimer:"Si applicano esclusioni", cart: {your_cart: 'Carrello', subtotal: "Subtotale", discount:"Sconto", new_subtotal: "Nuovo subtotale"}},
			"korean": {header1:"\uCC3D\uC758\uB825\uC744 \uB9C8\uC74C\uAECF \uBC1C\uD718\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uC2DC 25% \uD560\uC778 ", css:'', css_mobile: '', use_code:"",cta:"\uC9C0\uAE08 \uC0AC\uC6A9\uD558\uC138\uC694", disclaimer:"\uC81C\uC678\uC870\uAC74 \uC801\uC6A9\uB428", cart: {your_cart: '\uC7A5\uBC14\uAD6C\uB2C8', subtotal: "\uD569\uACC4", discount:"\uD560\uC778", new_subtotal: "\uC0C8\uB85C\uC6B4 \uD569\uACC4"}},
			"portuguese": {header1:"Expresse sua criatividade",header2:"Obtenha hoje 25% de desconto em seu pedido", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"Obtenha agora", disclaimer:"Podem haver exce\u00E7\u00F5es.", cart: {your_cart: 'Seu carrinho', subtotal: "Subtotal", discount:"Desconto", new_subtotal: "Novo subtotal"}},
			"espanol": {header1:"Libera tu creatividad",header2:"Consigue hoy un 25% de descuento en tu pedido", css:'.usi_header2{font-size:2.75em !important;}', css_mobile: '', use_code:"",cta:"Canjear ahora", disclaimer:"Pueden aplicarse exclusiones", cart: {your_cart: 'Tu Carrito', subtotal: "Subtotal", discount:"Descuento", new_subtotal: "Nuevo Subtotal"}},
			"japanese": {header1:"\u5275\u9020\u529B\u3092\u89E3\u304D\u653E\u3068\u3046\uFF01",header2:"\u4ECA\u65E5\u306E\u3054\u6CE8\u6587\u304C25\uFF05\u30AA\u30D5\u306B\u306A\u308B", css:'', css_mobile: '', use_code:"",cta:"\u4ECA\u3059\u3050\u5229\u7528", disclaimer:"\u9664\u5916\u4E8B\u9805\u304C\u9069\u7528\u3055\u308C\u308B\u5834\u5408\u3082\u3042\u308A\u307E\u3059\u3002", cart: {your_cart: '\u30AB\u30FC\u30C8', subtotal: "\u5C0F\u8A08", discount:"\u30C7\u30A3\u30B9\u30AB\u30A6\u30F3\u30C8", new_subtotal: "\u65B0\u3057\u3044\u5C0F\u8A08"}},
			"hindi": {header1:"\u0905\u092A\u0928\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u0915\u094B \u0909\u091C\u093E\u0917\u0930 \u0915\u0930\u0947\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 25% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902", css:'.usi_header2{font-size:3em !important;}', css_mobile: '', use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902", disclaimer:"\u092C\u0939\u093F\u0937\u094D\u0915\u0930\u0923 \u0932\u093E\u0917\u0942 \u0939\u094B \u0938\u0915\u0924\u0947 \u0939\u0948\u0902", cart: {your_cart: '\u0906\u092A\u0915\u093E \u0915\u093E\u0930\u094D\u091F', subtotal: "\u0938\u092C\u091F\u094B\u091F\u0932", discount:"\u0921\u093F\u0938\u094D\u0915\u093E\u0909\u0902\u091F", new_subtotal: "\u0928\u092F\u093E \u0938\u092C\u091F\u094B\u091F\u0932"}},
			"tamil": {header1:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BAA\u0B9F\u0BC8\u0BAA\u0BCD\u0BAA\u0BBE\u0BB1\u0BCD\u0BB1\u0BB2\u0BC8 \u0B95\u0B9F\u0BCD\u0B9F\u0BB5\u0BBF\u0BB4\u0BCD\u0BA4\u0BCD\u0BA4\u0BC1 \u0BB5\u0BBF\u0B9F\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BA9\u0BCD\u0BB1\u0BC1 \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BBF\u0BB2\u0BCD 25% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD", css:'.usi_submitbutton{font-size: 1em !important;} .usi_header2{top: 36% !important; font-size:2em !important;}', css_mobile: '.usi_submitbutton{font-size:1.5em !important;} .usi_header1{top:7% !important; font-size:1.5em !important;} .usi_header2{top:20% !important; font-size:1.5em !important;}', use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BAE\u0BC0\u0B9F\u0BCD\u0B9F\u0BC1\u0B95\u0BCD\u0B95\u0BCA\u0BB3\u0BCD\u0BB3\u0BB5\u0BC1\u0BAE\u0BCD", disclaimer:"\u0BB5\u0BBF\u0BB2\u0B95\u0BCD\u0B95\u0BC1\u0B95\u0BB3\u0BCD \u0BAA\u0BCA\u0BB0\u0BC1\u0BA8\u0BCD\u0BA4\u0BB2\u0BBE\u0BAE\u0BCD", cart: {your_cart: '\u0B89\u0BA9\u0BCD\u0BA9\u0BC1\u0B9F\u0BC8\u0BAF \u0BAA\u0BC8\u0BAF\u0BBF\u0BB2\u0BCD', subtotal: "\u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8", discount:"\u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF", new_subtotal: "\u0BAA\u0BC1\u0BA4\u0BBF\u0BAF \u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8"}},
			"telugu": {header1:"\u0C2E\u0C40 \u0C38\u0C43\u0C1C\u0C28\u0C3E\u0C24\u0C4D\u0C2E\u0C15\u0C24\u0C28\u0C41 \u0C35\u0C46\u0C32\u0C3F\u0C15\u0C3F\u0C24\u0C40\u0C2F\u0C02\u0C21\u0C3F",header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C06\u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 25% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F", css:'.usi_submitbutton{font-size: 1em !important;} .usi_header2{top: 37% !important; font-size:2.5em !important;}', css_mobile: '.usi_submitbutton{font-size:1.5em !important;} .usi_header1{top:7% !important; font-size:1.5em !important;} .usi_header2{top:20% !important; font-size:1.5em !important;}', use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F", disclaimer:"\u0C2E\u0C3F\u0C28\u0C39\u0C3E\u0C2F\u0C3F\u0C02\u0C2A\u0C41\u0C32\u0C41 \u0C35\u0C30\u0C4D\u0C24\u0C3F\u0C02\u0C1A\u0C35\u0C1A\u0C4D\u0C1A\u0C41", cart: {your_cart: '\u0C2E\u0C40 \u0C15\u0C3E\u0C30\u0C4D\u0C1F\u0C4D', subtotal: "\u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D", discount:"\u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41", new_subtotal: "\u0C15\u0C4A\u0C24\u0C4D\u0C24 \u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D"}},
			"marathi": {header1:"\u0924\u0941\u092E\u091A\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u092C\u093E\u0939\u0947\u0930 \u092F\u0947\u0909 \u0926\u094D\u092F\u093E",header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u0911\u0930\u094D\u0921\u0930\u0935\u0930 25% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E", css:'.usi_submitbutton{font-size: 1.5em !important;} .usi_header2{top: 37% !important; font-size:2.5em !important;}', css_mobile: '.usi_submitbutton{font-size:1.5em !important;} .usi_header1{top:7% !important; font-size:1.5em !important;} .usi_header2{top:20% !important; font-size:1.5em !important;}', use_code:"",cta:"\u0906\u0924\u093E\u091A \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E", disclaimer:"\u0905\u092A\u0935\u093E\u0926 \u0932\u093E\u0917\u0942 \u0939\u094B\u090A \u0936\u0915\u0924\u093E\u0924", cart: {your_cart: '\u0924\u0941\u092E\u091A\u0940 \u0915\u093E\u0930\u094D\u091F', subtotal: "\u090F\u0915\u0942\u0923", discount:"\u0938\u0942\u091F", new_subtotal: "\u0928\u0935\u0940\u0928 \u090F\u0915\u0942\u0923"}},
		};

		usi_app.message_creative_flow_promotion = {
			"english": {css:'', css_mobile: '', header1:"Try our All-in-One plan for FREE and design like a pro", header2:"Access over 450M images, videos, and music tracks-plus <span>Creative Flow</span>, our powerful suite of design tools.", use_code:"",cta:"Try for free", disclaimer:""},
			"sichinese": {header1:"\u5FEB\u6765\u514D\u8D39\u8BD5\u7528\u6211\u4EEC\u7684\u5168\u5305\u5957\u9910\uFF0C\u50CF\u4E13\u4E1A\u4EBA\u58EB\u4E00\u6837\u8FDB\u884C\u8BBE\u8BA1",header2:"\u62E5\u6709\u6211\u4EEC\u5F3A\u5927\u7684\u8BBE\u8BA1\u5DE5\u5177\u5957\u4EF6 \u201C<span>Creative Flow</span>\u201D\uFF0C\u5C31\u53EF\u4EE5\u8BBF\u95EE\u8D85\u8FC74.5\u4EBF\u7684\u56FE\u50CF\u3001\u89C6\u9891\u548C\u97F3\u9891\u6587\u4EF6", css:'', css_mobile: '', use_code:"",cta:"\u514D\u8D39\u8BD5\u7528", disclaimer:""},
			"trchinese": {header1:"\u7ACB\u5373\u514D\u8CBB\u8A66\u7528\u4E00\u689D\u9F8D\u5957\u9910\uFF0C\u540C\u5C08\u696D\u4EBA\u58EB\u4E00\u6A23\u958B\u5C55\u8A2D\u8A08",header2:"\u9019\u6B3E\u5F37\u5927\u7684\u8A2D\u8A08\u5DE5\u5177\u5957\u4EF6\u300C<span>Creative Flow</span>\u300D\u53EF\u4EE5\u8A2A\u554F\u8D85\u904E4.5\u5104\u7684\u5716\u50CF\u3001\u8996\u983B\u548C\u97F3\u983B\u6587\u4EF6", css:'', css_mobile: '', use_code:"",cta:"\u514D\u8CBB\u8A66\u7528", disclaimer:""},
			"czech": {header1:"Zkuste n\u00E1\u0161 pl\u00E1n v\u0161e v jednom ZDARMA a designujte jako prof\u00EDk",header2:"Z\u00EDskejte p\u0159\u00EDstup k v\u00EDce ne\u017E 450 mil. obr\u00E1zk\u016F, vide\u00ED a hudebn\u00EDch skladeb a k nabit\u00E9 sad\u011B n\u00E1stroj\u016F pro navrhov\u00E1n\u00ED <span>Creative Flow</span>.", css:'', css_mobile: '', use_code:"",cta:"Zkusit zdarma", disclaimer:""},
			"danish": {header1:"Pr\u00F8v vores alt-i-et-abonnement GRATIS og design som en pro",header2:"F\u00E5 adgang til over 450 mio billeder, videoer og musiknumre plus <span>Creative Flow</span>, vores kraftfulde suite af designv\u00E6rkt\u00F8jer.", css:'', css_mobile: '', use_code:"",cta:"Pr\u00F8v gratis", disclaimer:""},
			"finland": {header1:"Kokeile All-in-One -suunnitelmaamme ILMAISEKSI ja suunnittele kuin ammattilainen.",header2:"Saat k\u00E4ytt\u00F6\u00F6si yli 450 miljoonaa kuvaa, videota ja musiikkiraitaa - sek\u00E4 <span>Creative Flow</span>, tehokkaan suunnitteluty\u00F6kalupakettimme.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Kokeile Ilmaiseksi", disclaimer:""},
			"hungary": {header1:"Pr\u00F3b\u00E1lja ki a Teljes k\u00F6r\u0171 el\u0151fizet\u00E9st INGYENESEN \u00E9s tervezzen ak\u00E1r egy profi",header2:"T\u00F6bb mint 450 milli\u00F3 k\u00E9phez, vide\u00F3hoz \u00E9s zenesz\u00E1mhoz kap hozz\u00E1f\u00E9r\u00E9st, valamint a <span>Creative Flow</span>, ami a diz\u00E1jn eszk\u00F6zeinket tartalmaz\u00F3 kiv\u00E1l\u00F3 csomag", css:'', css_mobile: '', use_code:"",cta:"Pr\u00F3b\u00E1lja ki ingyenesen", disclaimer:""},
			"norway": {header1:"Pr\u00F8v v\u00E5r alt-i-ett-plan GRATIS og design som en proff",header2:"F\u00E5 tilgang til over 450 millioner bilder, videoer og musikk - pluss <span>Creative Flow</span>, v\u00E5r kraftige samling av designverkt\u00F8y.", css:'', css_mobile: '', use_code:"",cta:"Pr\u00F8v gratis", disclaimer:""},
			"polish": {header1:"Wypr\u00F3buj nasz DARMOWY plan All-in-One, aby projektowa\u0107 jak profesjonalista",header2:"Uzyskaj dost\u0119p do ponad 450 milion\u00F3w obraz\u00F3w, film\u00F3w i utwor\u00F3w muzycznych oraz <span>Creative Flow</span> \u2013 naszego pot\u0119\u017Cnego zestawu narz\u0119dzi do projektowania.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Wypr\u00F3buj za darmo", disclaimer:""},
			"russia": {header1:"\u041F\u043E\u043F\u0440\u043E\u0431\u0443\u0439\u0442\u0435 \u043D\u0430\u0448 \u043F\u043B\u0430\u043D \u00AB\u0412\u0441\u0451\n \u0432 \u043E\u0434\u043D\u043E\u043C\u00BB \u0411\u0415\u0421\u041F\u041B\u0410\u0422\u041D\u041E \u0438 \u0441\u043E\u0437\u0434\u0430\u0432\u0430\u0439\u0442\u0435 \u0434\u0438\u0437\u0430\u0439\u043D\u044B \u043A\u0430\u043A \u043F\u0440\u043E\u0444\u0438",header2:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0434\u043E\u0441\u0442\u0443\u043F \u043A \u0431\u043E\u043B\u0435\u0435 \u0447\u0435\u043C 450 \u043C\u0438\u043B\u043B\u0438\u043E\u043D\u0430\u043C \u0438\u0437\u043E\u0431\u0440\u0430\u0436\u0435\u043D\u0438\u0439, \u0432\u0438\u0434\u0435\u043E\u0440\u043E\u043B\u0438\u043A\u043E\u0432 \u0438 \u043C\u0443\u0437\u044B\u043A\u0430\u043B\u044C\u043D\u044B\u0445 \u0442\u0440\u0435\u043A\u043E\u0432, \u0430 \u0442\u0430\u043A\u0436\u0435 \u043A \u043D\u0430\u0448\u0435\u043C\u0443 \u043C\u043E\u0449\u043D\u043E\u043C\u0443 \u043A\u043E\u043C\u043F\u043B\u0435\u043A\u0442\u0443 \u0438\u043D\u0441\u0442\u0440\u0443\u043C\u0435\u043D\u0442\u043E\u0432 \u0434\u043B\u044F \u0434\u0438\u0437\u0430\u0439\u043D\u0430 \u2013 \u00AB<span>Creative Flow</span>\u00BB", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{font-size: 1.15em !important;}', css_mobile: '', use_code:"",cta:"\u041F\u043E\u043F\u0440\u043E\u0431\u0443\u0439\u0442\u0435 \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u043E", disclaimer:""},
			"sweden": {header1:"Testa v\u00E5r allt-i-ett plan GRATIS och designa som ett proffs",header2:"Tillg\u00E5ng till 450M+ bilder, videor och musiksp\u00E5r \u2013 plus <span>Creative Flow</span>, v\u00E5r kraftfulla svit av designverktyg.", css:'', css_mobile: '', use_code:"",cta:"Testa gratis", disclaimer:""},
			"thai": {header1:"\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E41\u0E1C\u0E19 All-in-One \u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32\u0E1F\u0E23\u0E35 \u0E41\u0E25\u0E30\u0E2D\u0E2D\u0E01\u0E41\u0E1A\u0E1A\u0E2D\u0E22\u0E48\u0E32\u0E07\u0E21\u0E37\u0E2D\u0E2D\u0E32\u0E0A\u0E35\u0E1E",header2:"\u0E40\u0E02\u0E49\u0E32\u0E16\u0E36\u0E07\u0E23\u0E39\u0E1B\u0E20\u0E32\u0E1E \u0E27\u0E34\u0E14\u0E35\u0E42\u0E2D \u0E41\u0E25\u0E30\u0E41\u0E17\u0E23\u0E47\u0E01\u0E14\u0E19\u0E15\u0E23\u0E35\u0E21\u0E32\u0E01\u0E01\u0E27\u0E48\u0E32 450 \u0E25\u0E49\u0E32\u0E19\u0E23\u0E32\u0E22\u0E01\u0E32\u0E23 \u0E1E\u0E23\u0E49\u0E2D\u0E21\u0E01\u0E31\u0E1A <span>Creative Flow</span> \u0E0A\u0E38\u0E14\u0E40\u0E04\u0E23\u0E37\u0E48\u0E2D\u0E07\u0E21\u0E37\u0E2D\u0E01\u0E32\u0E23\u0E2D\u0E2D\u0E01\u0E41\u0E1A\u0E1A\u0E2D\u0E31\u0E19\u0E17\u0E23\u0E07\u0E1E\u0E25\u0E31\u0E07\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32", css:'', css_mobile: '', use_code:"",cta:"\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E1F\u0E23\u0E35", disclaimer:""},
			"turkey": {header1:"Hepsi Bir Arada plan\u0131m\u0131z\u0131 \u00DCCRETS\u0130Z deneyin ve bir profesyonel gibi tasar\u0131m yap\u0131n",header2:"450 milyondan fazla resim, video ve m\u00FCzik par\u00E7as\u0131n\u0131n yan\u0131 s\u0131ra g\u00FC\u00E7l\u00FC tasar\u0131m ara\u00E7lar\u0131 paketimiz <span>Creative Flow</span>'a eri\u015Fin.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"\u00DCcretsiz deneyin", disclaimer:""},
			"italian": {header1:"Prova il nostro piano Tutto-in-uno GRATIS e realizza progetti professionali",header2:"Accedi a pi\u00F9 di 450 milioni di immagini, video e brani musicali, oltre a <span>Creative Flow</span>, la nostra potente suite di strumenti di progettazione.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Provalo gratis", disclaimer:""},
			"korean": {header1:"\uC62C\uC778\uC6D0 \uC694\uAE08\uC81C\uB97C \uBB34\uB8CC\uB85C \uC0AC\uC6A9 \uD574\uBCF4\uC2DC\uACE0, \uC804\uBB38\uAC00\uCC98\uB7FC \uB514\uC790\uC778\uD574\uBCF4\uC138\uC694.",header2:"4\uC5B55\uCC9C\uB9CC \uC7A5\uC774 \uB118\uB294 \uC774\uBBF8\uC9C0, \uB3D9\uC601\uC0C1, \uC74C\uC545 \uBC0F \uD30C\uC6CC\uD480\uD55C \uB514\uC790\uC778 \uB3C4\uAD6C \uBAA8\uC74C\uC778 <span>Creative Flow</span> \uC5D0 \uC811\uC18D\uD558\uC138\uC694.", css:'', css_mobile: '', use_code:"",cta:"\uBB34\uB8CC\uB85C \uC0AC\uC6A9\uD574\uBCF4\uC138\uC694.", disclaimer:""},
			"espanol": {header1:"Prueba GRATIS nuestro plan All-in-one y diseña como los profesionales",header2:"Accede a m\u00E1s de 450 millones de im\u00E1genes, videos y pistas musicales \u2014m\u00E1s <span>Creative Flow</span>, nuestra poderosa suite de herramientas de dise\u00F1o.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Prueba gratis", disclaimer:""},
			"french": {header1:"Essayez GRATUITEMENT notre abonnement tout-en-un et cr\u00E9ez comme un pro",header2:"Acc\u00E9dez \u00E0 plus de 450 millions d\u2019images, de vid\u00E9os et de musiques \u2013 ainsi qu\u2019\u00E0 <span>Creative Flow</span>, notre puissante suite d\u2019outils de conception.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Essayer gratuitement", disclaimer:""},
			"portuguese": {header1:"Experimente nosso plano tudo-em-um GRATUITAMENTE e desenhe como um profissional",header2:"Acesse mais de 450 milh\u00F5es de imagens, v\u00EDdeos e faixas de m\u00FAsica, al\u00E9m do <span>Creative Flow</span>, nosso poderoso conjunto de ferramentas de design.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Experimente gratuitamente", disclaimer:""},
			"german": {header1:"Testen Sie KOSTENLOS unseren umfassenden Plan  und designen Sie wie ein Profi",header2:"Greifen Sie auf \u00FCber 450 Mio. Bilder, Videos und Musiktitel sowie auf <span>Creative Flow</span>, unsere leistungsf\u00E4higen Designtools, zu.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Testen Sie den Plan kostenlos", disclaimer:""},
			"dutch": {header1:"Probeer GRATIS onze Alles-in-\u00E9\u00E9n-abonnement en ontwerp als een professional",header2:"Krijg toegang tot meer dan 450 miljoen afbeeldingen, video's en muzieknummers, plus <span>Creative Flow</span>, ons krachtige pakket ontwerptools.", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"Probeer gratis", disclaimer:""},
			"japanese": {header1:"\u30AA\u30FC\u30EB\u30A4\u30F3\u30EF\u30F3\u30D7\u30E9\u30F3\u3092\u7121\u6599\u3067\u8A66\u3057\u3066\u3001\u30D7\u30ED\u30EC\u30D9\u30EB\u306E\u30C7\u30B6\u30A4\u30F3\u3092\u5236\u4F5C",header2:"4\u51045000\u4E07\u70B9\u4EE5\u4E0A\u306E\u753B\u50CF\u3001\u52D5\u753B\u3001\u97F3\u697D\u7D20\u6750\u3001\u305D\u3057\u3066\u5F37\u529B\u306A\u30C7\u30B6\u30A4\u30F3\u30C4\u30FC\u30EB\u30B9\u30A4\u30FC\u30C8\u306E <span>Creative Flow</span> \u30D7\u30E9\u30B9\u3092\u3054\u5229\u7528\u3044\u305F\u3060\u3051\u307E\u3059\u3002", css:'.usi_header1{font-size: 1.75em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"\u7121\u6599\u30C8\u30E9\u30A4\u30A2\u30EB", disclaimer:""},
			"hindi": {header1:"\u0939\u092E\u093E\u0930\u0947 \u0911\u0932-\u0907\u0928-\u0935\u0928 \u092A\u094D\u0932\u093E\u0928 \u0915\u094B \u095E\u094D\u0930\u0940 \u092E\u0947\u0902 \u0906\u091C\u093C\u092E\u093E\u090F\u0901 \u0914\u0930 \u090F\u0915 \u092A\u094D\u0930\u094B\u095E\u0947\u0936\u0928\u0932 \u0915\u0940 \u0924\u0930\u0939 \u0921\u093F\u091C\u093C\u093E\u0907\u0928 \u0915\u0930\u0947\u0902",header2:"450M \u0938\u0947 \u0905\u0927\u093F\u0915 \u0907\u092E\u0947\u091C\u0947\u0938, \u0935\u0940\u0921\u093F\u092F\u094B \u0914\u0930 \u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0948\u0915-\u092A\u094D\u0932\u0938 <span>Creative Flow</span> \u0924\u0915 \u092A\u0939\u0941\u0902\u091A, \u0921\u093F\u091C\u093C\u093E\u0907\u0928 \u091F\u0942\u0932 \u0915\u093E \u0939\u092E\u093E\u0930\u093E \u092A\u093E\u0935\u0930\u092B\u0942\u0932 \u0938\u0942\u091F\u0964", css:'', css_mobile: '', use_code:"",cta:" \u095E\u094D\u0930\u0940 \u092E\u0947\u0902 \u0906\u091C\u093C\u092E\u093E\u090F\u0901", disclaimer:""},
			"tamil": {header1:"\u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB2\u0BCD-\u0B87\u0BA9\u0BCD-\u0B92\u0BA9\u0BCD \u0BA4\u0BBF\u0B9F\u0BCD\u0B9F\u0BA4\u0BCD\u0BA4\u0BC8 \u0B87\u0BB2\u0BB5\u0B9A\u0BAE\u0BBE\u0B95 \u0BAE\u0BC1\u0BAF\u0BB1\u0BCD\u0B9A\u0BBF\u0B95\u0BCD\u0B95\u0BB5\u0BC1\u0BAE\u0BCD \u0BAE\u0BB1\u0BCD\u0BB1\u0BC1\u0BAE\u0BCD \u0B92\u0BB0\u0BC1 \u0B9A\u0BBE\u0BB0\u0BCD\u0BAA\u0BC1 \u0BAA\u0BCB\u0BB2 \u0BB5\u0B9F\u0BBF\u0BB5\u0BAE\u0BC8\u0B95\u0BCD\u0B95\u0BB5\u0BC1\u0BAE\u0BCD",header2:" 450M \u0B85\u0BA4\u0BBF\u0B95\u0BAE\u0BBE\u0BA9 \u0BAA\u0B9F\u0B99\u0BCD\u0B95\u0BB3\u0BCD, \u0BB5\u0BC0\u0B9F\u0BBF\u0BAF\u0BCB\u0B95\u0BCD\u0B95\u0BB3\u0BCD \u0BAE\u0BB1\u0BCD\u0BB1\u0BC1\u0BAE\u0BCD \u0B87\u0B9A\u0BC8 \u0B9F\u0BBF\u0BB0\u0BBE\u0B95\u0BCD\u0B95\u0BC1\u0B95\u0BB3\u0BCD \u0BAE\u0BB1\u0BCD\u0BB1\u0BC1\u0BAE\u0BCD <span>Creative Flow</span> \u0BCB, \u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BBF\u0BA9\u0BCD \u0B9A\u0B95\u0BCD\u0BA4\u0BBF\u0BB5\u0BBE\u0BAF\u0BCD\u0BA8\u0BCD\u0BA4 \u0BB5\u0B9F\u0BBF\u0BB5\u0BAE\u0BC8\u0BAA\u0BCD\u0BAA\u0BC1 \u0B95\u0BB0\u0BC1\u0BB5\u0BBF\u0B95\u0BB3\u0BC8 \u0B85\u0BA3\u0BC1\u0B95\u0BB2\u0BBE\u0BAE\u0BCD.", css:'.usi_header1{font-size: 1.5em !important;} .usi_header2{font-size: 1em !important;} .usi_submitbutton{background:#FF2E37 !important; border-radius:50px !important; padding: 25px !important;}', css_mobile: '', use_code:"",cta:"\u0B87\u0BB2\u0BB5\u0B9A\u0BAE\u0BBE\u0B95 \u0BAE\u0BC1\u0BAF\u0BB1\u0BCD\u0B9A\u0BBF \u0B9A\u0BC6\u0BAF\u0BCD\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD", disclaimer:""},
			"telugu": {header1:"\u0C2E\u0C3E \u0C06\u0C32\u0C4D \u0C07\u0C28\u0C4D \u0C35\u0C28\u0C4D \u0C2A\u0C4D\u0C32\u0C3E\u0C28\u0C4D\u200C\u0C28\u0C3F \u0C09\u0C1A\u0C3F\u0C24\u0C02\u0C17\u0C3E \u0C2A\u0C4D\u0C30\u0C2F\u0C24\u0C4D\u0C28\u0C3F\u0C02\u0C1A\u0C02\u0C21\u0C3F \u0C2E\u0C30\u0C3F\u0C2F\u0C41 \u0C2A\u0C4D\u0C30\u0C4B \u0C32\u0C3E\u0C17\u0C3E \u0C21\u0C3F\u0C1C\u0C48\u0C28\u0C4D \u0C1A\u0C47\u0C2F\u0C02\u0C21\u0C3F",header2:"450M \u0C07\u0C2E\u0C47\u0C1C\u0C40\u0C32\u0C41, \u0C35\u0C40\u0C21\u0C3F\u0C2F\u0C4B\u0C32\u0C41 \u0C2E\u0C30\u0C3F\u0C2F\u0C41 \u0C2E\u0C4D\u0C2F\u0C42\u0C1C\u0C3F\u0C15\u0C4D \u0C1F\u0C4D\u0C30\u0C3E\u0C15\u0C4D\u200C\u0C32\u0C24\u0C4B \u0C2A\u0C3E\u0C1F\u0C41 <span>Creative Flow</span>, \u0C2E\u0C3E \u0C36\u0C15\u0C4D\u0C24\u0C3F\u0C35\u0C02\u0C24\u0C2E\u0C48\u0C28 \u0C21\u0C3F\u0C1C\u0C48\u0C28\u0C4D \u0C1F\u0C42\u0C32\u0C4D\u0C38\u0C4D \u0C38\u0C42\u0C1F\u0C4D\u200C\u0C32\u0C28\u0C41 \u0C2F\u0C3E\u0C15\u0C4D\u0C38\u0C46\u0C38\u0C4D \u0C1A\u0C47\u0C2F\u0C02\u0C21\u0C3F.", css:'.usi_header1{font-size: 1.5em !important;} .usi_header2{top:49% !important;}', css_mobile: '', use_code:"",cta:"\u0C09\u0C1A\u0C3F\u0C24\u0C02\u0C17\u0C3E \u0C2A\u0C4D\u0C30\u0C2F\u0C24\u0C4D\u0C28\u0C3F\u0C02\u0C1A\u0C02\u0C21\u0C3F", disclaimer:""},
			"marathi": {header1:"\u0906\u092E\u091A\u093E \u0911\u0932-\u0907\u0928-\u0935\u0928 \u092A\u094D\u0932\u0945\u0928 \u0935\u093F\u0928\u093E\u092E\u0942\u0932\u094D\u092F \u0935\u093E\u092A\u0930\u0942\u0928 \u092A\u0939\u093E \u0906\u0923\u093F \u090F\u0916\u093E\u0926\u094D\u092F\u093E \u092A\u094D\u0930\u094B \u092A\u094D\u0930\u092E\u093E\u0923\u0947 \u0921\u093F\u091D\u093E\u0907\u0928 \u0915\u0930\u093E",header2:"450M \u092A\u0947\u0915\u094D\u0937\u093E \u091C\u093E\u0938\u094D\u0924 \u092A\u094D\u0930\u0924\u093F\u092E\u093E, \u0935\u094D\u0939\u093F\u0921\u093F\u0913 \u0906\u0923\u093F \u0938\u0902\u0917\u0940\u0924 \u091F\u094D\u0930\u0945\u0915-\u092A\u094D\u0932\u0938 <span>Creative Flow</span> \u092E\u0927\u094D\u092F\u0947 \u092A\u094D\u0930\u0935\u0947\u0936 \u0915\u0930\u093E, \u0906\u092E\u091A\u094D\u092F\u093E \u0921\u093F\u091D\u093E\u0907\u0928 \u0938\u093E\u0927\u0928\u093E\u0902\u091A\u093E \u092A\u0949\u0935\u0930\u092B\u0942\u0932 \u0938\u0947\u091F.", css:'', css_mobile: '', use_code:"",cta:"\u0935\u093F\u0928\u093E\u092E\u0942\u0932\u094D\u092F \u0935\u093E\u092A\u0930\u0942\u0928 \u092A\u0939\u093E", disclaimer:""},
		};

		usi_app.message_sitewide_event_2023_bfcm = {
			"english": {header1:"Save 20%",header2:"Sitewide", header3: "", css:".usi_header1{font-size: 3.5em !important; top: 12% !important;} .usi_header2{top: 36% !important; left: 2.5% !important; font-size: 3.5em !important;} .usi_header3{top: 50% !important;}", css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."},
			"sichinese": {header1:"\u91CA\u653E\u60A8\u7684\u521B\u4F5C\u624D\u534E",header2:"\u4ECA\u5929\u53EF\u4EAB8\u6298\u4F18\u60E0",header3: "", css:'.usi_header2{top: 50% !important;}', css_mobile: '', use_code:"",cta:"\u5FEB\u6765\u5151\u6362\u5427", disclaimer:"\u514D\u8D23\u58F0\u660E\uFF1A\u6211\u4EEC\u6839\u636E\u6211\u4EEC\u7684\u9690\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"trchinese": {header1:"\u91CB\u653E\u60A8\u7684\u5275\u4F5C\u624D\u83EF",header2:"\u4ECA\u5929\u53EF\u4EAB\u53D78\u6298\u512A\u60E0",header3: "", css:'.usi_header2{top: 50% !important;}', css_mobile: '', use_code:"",cta:"\u5FEB\u4F86\u514C\u63DB\u5427", disclaimer:"\u514D\u8CAC\u8072\u660E\uFF1A\u6211\u5011\u6839\u64DA\u6211\u5011\u7684\u96B1\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"czech": {header1:"Popus\u0165te uzdu sv\u00E9 kreativit\u011B",header2:"Z\u00EDskejte 20% slevu na svou objedn\u00E1vku je\u0161t\u011B dnes",header3: "", css:'.usi_header1{top: 17% !important;} .usi_header2{top:44% !important;}', css_mobile: '', use_code:"",cta:"Uplatnit nyní", disclaimer:"Prohl\u00E1\u0161en\u00ED: Va\u0161e informace zpracov\u00E1v\u00E1me v souladu s na\u0161imi z\u00E1sadami o ochran\u011B osobn\u00EDch \u00FAdaj\u016F"},
			"danish": {header1:"Slip kreativiteten l\u00F8s",header2:"F\u00E5 20% rabat p\u00E5 din ordre i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"Indl\u00F8s nu", disclaimer:"Ansvarsfraskrivelse: Vi bruger dine oplysninger i overensstemmelse med vores fortrolighedspolitik."},
			"finland": {header1:"P\u00E4\u00E4st\u00E4 luovuutesi valloilleen",header2:"Saat 20 % alennuksen tilauksestasi t\u00E4n\u00E4\u00E4n",header3: "", css:'.usi_header1{top: 20% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"Lunasta nyt", disclaimer:"Vastuuvapauslauseke: K\u00E4yt\u00E4mme tietojasi tietosuojak\u00E4yt\u00E4nt\u00F6mme mukaisesti."},
			"hungary": {header1:"Engedje szabadj\u00E1ra a kreativit\u00E1s\u00E1t",header2:"20% engedm\u00E9ny, ha ma rendel",header3: "", css:'.usi_header1{top: 21% !important;} .usi_header2{top: 49% !important;}', css_mobile: '', use_code:"",cta:"Szerezze meg most", disclaimer:"Jogi nyilatkozat: Az adatait az adatv\u00E9delmi nyilatkozatunk el\u0151\u00EDr\u00E1sai szerint haszn\u00E1ljuk fel."},
			"norway": {header1:"Slipp kreativiteten l\u00F8s",header2:"F\u00E5 20 % rabatt p\u00E5 ordren din i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"L\u00F8s inn n\u00E5", disclaimer:"Vi bruker informasjonen din i samsvar med v\u00E5re personvernregler"},
			"polish": {header1:"Wyzw\u00F3l swoj\u0105 kreatywno\u015B\u0107",header2:"Otrzymaj -20% na zam\u00F3wienie ju\u017C dzisiaj",header3: "", css:'.usi_header1{top: 21% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"Skorzystaj teraz", disclaimer:"Zastrze\u017Cenie: U\u017Cywamy Twoich danych zgodnie z nasz\u0105 polityk\u0105 prywatno\u015Bci"},
			"russia": {header1:"\u0420\u0430\u0441\u043A\u0440\u043E\u0439 \u0441\u0432\u043E\u044E \u043A\u0440\u0435\u0430\u0442\u0438\u0432\u043D\u043E\u0441\u0442\u044C",header2:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 20% \u043D\u0430 \u0432\u0430\u0448 \u0437\u0430\u043A\u0430\u0437 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",header3: "", css:'.usi_header1{top: 20% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"\u0410\u043A\u0442\u0438\u0432\u0438\u0440\u043E\u0432\u0430\u0442\u044C", disclaimer:"\u041E\u0442\u043A\u0430\u0437 \u043E\u0442 \u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043D\u043D\u043E\u0441\u0442\u0438: \u041C\u044B \u0438\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0435\u043C \u0432\u0430\u0448\u0443 \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044E \u0432 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u0438 \u0441 \u043D\u0430\u0448\u0435\u0439 \u043F\u043E\u043B\u0438\u0442\u0438\u043A\u043E\u0439 \u043A\u043E\u043D\u0444\u0438\u0434\u0435\u043D\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0441\u0442\u0438."},
			"sweden": {header1:"Sl\u00E4pp loss din kreativitet",header2:"F\u00E5 20% rabatt p\u00E5 din best\u00E4llning idag",header3: "", css:'.usi_header1{top: 20% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"L\u00F6s in nu", disclaimer:"Observera: Vi anv\u00E4nder din information i enlighet med v\u00E5r integritetspolicy."},
			"thai": {header1:"\u0E1B\u0E25\u0E14\u0E1B\u0E25\u0E48\u0E2D\u0E22\u0E04\u0E27\u0E32\u0E21\u0E04\u0E34\u0E14\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E2A\u0E23\u0E23\u0E04\u0E4C\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",header2:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 20% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",header3: "", css:'.usi_header1{top: 20% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"\u0E1A\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49", disclaimer:"\u0E02\u0E49\u0E2D\u0E08\u0E33\u0E01\u0E31\u0E14\u0E04\u0E27\u0E32\u0E21\u0E23\u0E31\u0E1A\u0E1C\u0E34\u0E14\u0E0A\u0E2D\u0E1A: \u0E40\u0E23\u0E32\u0E43\u0E0A\u0E49\u0E02\u0E49\u0E2D\u0E21\u0E39\u0E25\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E15\u0E32\u0E21\u0E19\u0E42\u0E22\u0E1A\u0E32\u0E22\u0E04\u0E27\u0E32\u0E21\u0E40\u0E1B\u0E47\u0E19\u0E2A\u0E48\u0E27\u0E19\u0E15\u0E31\u0E27\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32"},
			"turkey": {header1:"Yarat\u0131c\u0131l\u0131\u011F\u0131n\u0131z\u0131 serbest b\u0131rak\u0131n",header2:"Bug\u00FCn verece\u011Finiz sipari\u015Finizde %20 indirim kazan\u0131n",header3: "", css:'.usi_header1{top: 18% !important;} .usi_header2{top: 44% !important;}', css_mobile: '', use_code:"",cta:"\u015Eimdi kullan", disclaimer:"Sorumluluk Reddi: Bilgilerinizi gizlilik politikam\u0131za uygun olarak kullan\u0131yoruz."},
			"italian": {header1:"Libera la tua creativit\u00E0",header2:"Ricevi subito un 20% di sconto sul tuo ordine",header3: "", css:'', css_mobile: '', use_code:"",cta:"Approfittane ora", disclaimer:"Avviso legale: utilizziamo le tue informazioni in conformit\u00E0 con la nostra politica sulla privacy."},
			"korean": {header1:"\uCC3D\uC758\uB825\uC744 \uB9C8\uC74C\uAECF \uBC1C\uD718\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uC2DC 20% \uD560\uC778 ",header3: "", css:'.usi_header2{top: 53% !important;}', css_mobile: '', use_code:"",cta:"\uC9C0\uAE08 \uC0AC\uC6A9\uD558\uC138\uC694", disclaimer:"\uBA74\uCC45 \uC870\uD56D: \uC6B0\uB9AC\uB294 \uAC1C\uC778\uC815\uBCF4 \uBCF4\uD638\uC815\uCC45\uC5D0 \uB530\uB77C \uADC0\uD558\uC758 \uC815\uBCF4\uB97C \uC0AC\uC6A9\uD569\uB2C8\uB2E4"},
			"espanol": {header1:"Libera tu creatividad",header2:"Consigue hoy un 20% de descuento en tu pedido",header3: "", css:'.usi_header1{top: 21% !important;} .usi_header2{top: 43% !important;}', css_mobile: '', use_code:"",cta:"Canjear ahora", disclaimer:"Aviso legal: Utilizamos tu informaci\u00F3n de acuerdo con nuestra pol\u00EDtica de privacidad."},
			"french": {header1:"Lib\u00E9rez votre cr\u00E9ativit\u00E9",header2:"B\u00E9n\u00E9ficiez de 20 % de r\u00E9duction sur votre commande aujourd\u2019hui",header3: "", css:'.usi_header1{top: 21% !important;} .usi_header2{top: 42% !important;} .usi_submitbutton{font-size: 1.3em !important;}', css_mobile: '', use_code:"",cta:"En profiter maintenant", disclaimer:"Disclaimer : Nous utilisons vos informations conform\u00E9ment \u00E0 notre politique de confidentialit\u00E9. "},
			"portuguese": {header1:"Expresse sua criatividade",header2:"Obtenha hoje 20% de desconto em seu pedido",header3: "", css:'.usi_header1{top: 17% !important;} .usi_header2{top: 43% !important;}', css_mobile: '', use_code:"",cta:"Obtenha agora", disclaimer:"Aviso Legal: Utilizamos a sua informa\u00E7\u00E3o de acordo com a nossa pol\u00EDtica de privacidade."},
			"german": {header1:"Lassen Sie Ihrer Kreativit\u00E4t freien Lauf",header2:"Erhalten Sie heute 20% Rabatt auf Ihre Bestellung",header3: "", css:'.usi_header1{top: 18% !important;} .usi_header2{top: 44% !important;}', css_mobile: '', use_code:"",cta:"Jetzt einl\u00F6sen", disclaimer:"Disclaimer: Wir nutzen Ihre Informationen im Einklang mit unserer Datenschutzrichtlinie."},
			"dutch": {header1:"Laat je creativiteit op de vrije loop",header2:"Ontvang vandaag 20% korting op je bestelling",header3: "", css:'.usi_header1{top: 19% !important;} .usi_header2{top: 46% !important;}', css_mobile: '', use_code:"",cta:"Ontvang nu", disclaimer:""},
			"japanese": {header1:"\u5275\u9020\u529B\u3092\u89E3\u304D\u653E\u3068\u3046\uFF01",header2:"\u4ECA\u65E5\u306E\u3054\u6CE8\u6587\u304C20\uFF05\u30AA\u30D5\u306B\u306A\u308B", header3: "",css:'', css_mobile: '', use_code:"",cta:"\u4ECA\u3059\u3050\u5229\u7528", disclaimer:"\u514D\u8CAC\u4E8B\u9805\uFF1A\u5F53\u793E\u306F\u3001\u304A\u5BA2\u69D8\u306E\u60C5\u5831\u3092\u5F53\u793E\u306E\u30D7\u30E9\u30A4\u30D0\u30B7\u30FC\u30DD\u30EA\u30B7\u30FC\u306B\u57FA\u3065\u304D\u4F7F\u7528\u3057\u307E\u3059\u3002"},
			"hindi": {header1:"\u0905\u092A\u0928\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u0915\u094B \u0909\u091C\u093E\u0917\u0930 \u0915\u0930\u0947\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 20% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",header3: "", css:'.usi_header1{top: 21% !important;} .usi_header2{top: 49% !important;}', css_mobile: '', use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902", disclaimer:"\u0939\u092E \u0906\u092A\u0915\u0940 \u091C\u093E\u0928\u0915\u093E\u0930\u0940 \u0915\u093E \u0909\u092A\u092F\u094B\u0917 \u0939\u092E\u093E\u0930\u0940 \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0928\u0940\u0924\u093F \u0915\u0947 \u0905\u0928\u0941\u0938\u093E\u0930 \u0915\u0930\u0924\u0947 \u0939\u0948\u0902\u0964"},
			"tamil": {header1:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BAA\u0B9F\u0BC8\u0BAA\u0BCD\u0BAA\u0BBE\u0BB1\u0BCD\u0BB1\u0BB2\u0BC8 \u0B95\u0B9F\u0BCD\u0B9F\u0BB5\u0BBF\u0BB4\u0BCD\u0BA4\u0BCD\u0BA4\u0BC1 \u0BB5\u0BBF\u0B9F\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BA9\u0BCD\u0BB1\u0BC1 \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BBF\u0BB2\u0BCD 20% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header3: "", css:".usi_header1{font-size: 1.8em !important;} .usi_header2{top: 48% !important; font-size: 1.8em !important;}", css_mobile: '', use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BAE\u0BC0\u0B9F\u0BCD\u0B9F\u0BC1\u0B95\u0BCD\u0B95\u0BCA\u0BB3\u0BCD\u0BB3\u0BB5\u0BC1\u0BAE\u0BCD", disclaimer:"\u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0BA9\u0BBF\u0BAF\u0BC1\u0BB0\u0BBF\u0BAE\u0BC8\u0B95\u0BCD \u0B95\u0BCA\u0BB3\u0BCD\u0B95\u0BC8\u0BAF\u0BBF\u0BA9\u0BCD\u0BAA\u0B9F\u0BBF \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0B95\u0BB5\u0BB2\u0BC8\u0BAA\u0BCD \u0BAA\u0BAF\u0BA9\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0B95\u0BBF\u0BB1\u0BCB\u0BAE\u0BCD."},
			"telugu": {header1:"\u0C2E\u0C40 \u0C38\u0C43\u0C1C\u0C28\u0C3E\u0C24\u0C4D\u0C2E\u0C15\u0C24\u0C28\u0C41 \u0C35\u0C46\u0C32\u0C3F\u0C15\u0C3F\u0C24\u0C40\u0C2F\u0C02\u0C21\u0C3F",header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C06\u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 20% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",header3: "", css:'.usi_header1{top: 20% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F", disclaimer:"\u0C2E\u0C47\u0C2E\u0C41 \u0C2E\u0C40 \u0C38\u0C2E\u0C3E\u0C1A\u0C3E\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C2E\u0C3E \u0C17\u0C4B\u0C2A\u0C4D\u0C2F\u0C24\u0C3E \u0C35\u0C3F\u0C27\u0C3E\u0C28\u0C3E\u0C28\u0C3F\u0C15\u0C3F \u0C05\u0C28\u0C41\u0C17\u0C41\u0C23\u0C02\u0C17\u0C3E \u0C09\u0C2A\u0C2F\u0C4B\u0C17\u0C3F\u0C38\u0C4D\u0C24\u0C3E\u0C2E\u0C41."},
			"marathi": {header1:"\u0924\u0941\u092E\u091A\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u092C\u093E\u0939\u0947\u0930 \u092F\u0947\u0909 \u0926\u094D\u092F\u093E",header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u0911\u0930\u094D\u0921\u0930\u0935\u0930 20% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",header3: "", css:'.usi_header1{top: 22% !important;} .usi_header2{top: 48% !important;}', css_mobile: '', use_code:"",cta:"\u0906\u0924\u093E\u091A \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E", disclaimer:"\u0906\u092E\u094D\u0939\u0940 \u0924\u0941\u092E\u091A\u0940 \u092E\u093E\u0939\u093F\u0924\u0940 \u0906\u092E\u091A\u094D\u092F\u093E \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0927\u094B\u0930\u0923\u093E\u0928\u0941\u0938\u093E\u0930 \u0935\u093E\u092A\u0930\u0924\u094B."},
		};

		usi_app.message_sitewide_event_q3_2023_lapsed_users = {
			"english": {header1:"Get 30% off any annual prepaid subscription",header2:"Use code: <span>T8FPHPCX</span>", header3: "", css:".usi_header1{font-size: 2.75em !important;} .usi_header2{width: 42% !important; left: 8% !important; top: 50% !important; font-weight: normal !important; font-size: 2.25em !important;}", css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."},
			"sichinese": {header1:"\u9884\u4ED8\u4EFB\u4F55\u5E74\u5EA6\u8BA2\u9605\u5747\u53EF\u83B7\u4EAB 30% \u7684\u4F18\u60E0",header2:"\u4F7F\u7528\u4F18\u60E0\u7801\uFF1A<span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u7ACB\u4EAB 30% \u7684\u4F18\u60E0", disclaimer:"\u514D\u8D23\u58F0\u660E\uFF1A\u6211\u4EEC\u6839\u636E\u6211\u4EEC\u7684\u9690\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"trchinese": {header1:"\u9810\u5148\u4ED8\u6B3E\u8CFC\u5165\u4EFB\u4F55\u5305\u5E74\u8A02\u8CFC\u65B9\u6848\uFF0C\u53EF\u4EAB 7 \u6298\u512A\u60E0",header2:"\u8F38\u5165\u4EE3\u78BC\uFF1A<span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u7ACB\u4EAB 7 \u6298", disclaimer:"\u514D\u8CAC\u8072\u660E\uFF1A\u6211\u5011\u6839\u64DA\u6211\u5011\u7684\u96B1\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"czech": {header1:"Z\u00EDskejte slevu 30 % na jak\u00E9koliv ro\u010Dn\u00ED p\u0159edplatn\u00E9 placen\u00E9 p\u0159edem",header2:"Pou\u017Eijte k\u00F3d: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"U\u0161et\u0159ete u\u017E te\u010F ", disclaimer:"Prohl\u00E1\u0161en\u00ED: Va\u0161e informace zpracov\u00E1v\u00E1me v souladu s na\u0161imi z\u00E1sadami o ochran\u011B osobn\u00EDch \u00FAdaj\u016F"},
			"danish": {header1:"F\u00E5 30 % rabat p\u00E5 alle \u00E5rlige abonnementer, der betales forud",header2:"Brug koden: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"Spar nu", disclaimer:"Ansvarsfraskrivelse: Vi bruger dine oplysninger i overensstemmelse med vores fortrolighedspolitik."},
			"finland": {header1:"30 % alennusta kaikista etuk\u00E4teen maksetuista vuositilauksista",header2:"K\u00E4yt\u00E4 koodia: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"S\u00E4\u00E4st\u00E4 nyt", disclaimer:"Vastuuvapauslauseke: K\u00E4yt\u00E4mme tietojasi tietosuojak\u00E4yt\u00E4nt\u00F6mme mukaisesti."},
			"hungary": {header1:"30% kedvezm\u00E9ny minden el\u0151re fizetett \u00E9ves el\u0151fizet\u00E9s \u00E1r\u00E1b\u00F3l",header2:"Haszn\u00E1lja a k\u00F6vetkez\u0151 k\u00F3dot: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important; top: 52% !important;}', css_mobile: '', use_code:"",cta:"Most 30% kedvezm\u00E9nnyel", disclaimer:"Jogi nyilatkozat: Az adatait az adatv\u00E9delmi nyilatkozatunk el\u0151\u00EDr\u00E1sai szerint haszn\u00E1ljuk fel."},
			"norway": {header1:"F\u00E5 30 % rabatt p\u00E5 et hvert forh\u00E5ndsbetalt \u00E5rsabonnement",header2:"Bruk koden: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"Spar n\u00E5", disclaimer:"Vi bruker informasjonen din i samsvar med v\u00E5re personvernregler"},
			"polish": {header1:"Zyskaj 30% zni\u017Cki na dowoln\u0105 subskrypcj\u0119 roczn\u0105 p\u0142atn\u0105 z g\u00F3ry",header2:"U\u017Cyj kodu: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"Zaoszcz\u0119d\u017A ju\u017C dzi\u015B", disclaimer:"Zastrze\u017Cenie: U\u017Cywamy Twoich danych zgodnie z nasz\u0105 polityk\u0105 prywatno\u015Bci"},
			"russia": {header1:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 30 % \u043D\u0430 \u043F\u0440\u0435\u0434\u043E\u043F\u043B\u0430\u0447\u0435\u043D\u043D\u0443\u044E \u0433\u043E\u0434\u043E\u0432\u0443\u044E \u043F\u043E\u0434\u043F\u0438\u0441\u043A\u0443",header2:"\u0412\u043E\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0439\u0442\u0435\u0441\u044C \u043A\u043E\u0434\u043E\u043C: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important; top: 52% !important;}', css_mobile: '', use_code:"",cta:"\u0412\u043E\u0441\u043F\u043E\u043B\u044C\u0437\u043E\u0432\u0430\u0442\u044C\u0441\u044F \u0441\u043A\u0438\u0434\u043A\u043E\u0439 ", disclaimer:"\u041E\u0442\u043A\u0430\u0437 \u043E\u0442 \u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043D\u043D\u043E\u0441\u0442\u0438: \u041C\u044B \u0438\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0435\u043C \u0432\u0430\u0448\u0443 \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044E \u0432 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u0438 \u0441 \u043D\u0430\u0448\u0435\u0439 \u043F\u043E\u043B\u0438\u0442\u0438\u043A\u043E\u0439 \u043A\u043E\u043D\u0444\u0438\u0434\u0435\u043D\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0441\u0442\u0438."},
			"sweden": {header1:"F\u00E5 30 % rabatt p\u00E5 valfri f\u00F6rskottsbetald \u00E5rlig prenumeration",header2:"Anv\u00E4nd koden: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important;}', css_mobile: '', use_code:"",cta:"Spara nu", disclaimer:"Observera: Vi anv\u00E4nder din information i enlighet med v\u00E5r integritetspolicy."},
			"thai": {header1:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 30% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E2A\u0E21\u0E31\u0E04\u0E23\u0E2A\u0E21\u0E32\u0E0A\u0E34\u0E01\u0E23\u0E32\u0E22\u0E1B\u0E35\u0E41\u0E1A\u0E1A\u0E08\u0E48\u0E32\u0E22\u0E40\u0E07\u0E34\u0E19\u0E25\u0E48\u0E27\u0E07\u0E2B\u0E19\u0E49\u0E32",header2:"\u0E43\u0E0A\u0E49\u0E23\u0E2B\u0E31\u0E2A: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 \u0E17\u0E31\u0E19\u0E17\u0E35", disclaimer:"\u0E02\u0E49\u0E2D\u0E08\u0E33\u0E01\u0E31\u0E14\u0E04\u0E27\u0E32\u0E21\u0E23\u0E31\u0E1A\u0E1C\u0E34\u0E14\u0E0A\u0E2D\u0E1A: \u0E40\u0E23\u0E32\u0E43\u0E0A\u0E49\u0E02\u0E49\u0E2D\u0E21\u0E39\u0E25\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E15\u0E32\u0E21\u0E19\u0E42\u0E22\u0E1A\u0E32\u0E22\u0E04\u0E27\u0E32\u0E21\u0E40\u0E1B\u0E47\u0E19\u0E2A\u0E48\u0E27\u0E19\u0E15\u0E31\u0E27\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32"},
			"turkey": {header1:"Pe\u015Fin \u00F6dedi\u011Finiz y\u0131ll\u0131k aboneliklerde %30 indirim",header2:"Kodu kullan\u0131n: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u015Eimdi tasarruf edin", disclaimer:"Sorumluluk Reddi: Bilgilerinizi gizlilik politikam\u0131za uygun olarak kullan\u0131yoruz."},
			"italian": {header1:"Risparmia il 30% su qualsiasi abbonamento annuale pagato in anticipo",header2:"Usa il codice: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"Risparmia subito il", disclaimer:"Avviso legale: utilizziamo le tue informazioni in conformit\u00E0 con la nostra politica sulla privacy."},
			"korean": {header1:"\uC5F0\uAC04 \uAD6C\uB3C5 \uC120\uBD88 \uC694\uAE08\uC744 30% \uD560\uC778\uBC1B\uC73C\uC138\uC694",header2:"\uCF54\uB4DC\uB97C \uC0AC\uC6A9\uD558\uC138\uC694: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important; top:52% !important;}', css_mobile: '', use_code:"",cta:"\uC9C0\uAE08 30% \uD560\uC778\uBC1B\uAE30", disclaimer:"\uBA74\uCC45 \uC870\uD56D: \uC6B0\uB9AC\uB294 \uAC1C\uC778\uC815\uBCF4 \uBCF4\uD638\uC815\uCC45\uC5D0 \uB530\uB77C \uADC0\uD558\uC758 \uC815\uBCF4\uB97C \uC0AC\uC6A9\uD569\uB2C8\uB2E4"},
			"espanol": {header1:"Obt\u00E9n un 30 % de descuento en cualquier suscripci\u00F3n anual con pago por adelantado",header2:"Usa el c\u00F3digo: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2{top: 60% !important;}', css_mobile: '', use_code:"",cta:"Ahorra ahora mismo", disclaimer:"Aviso legal: Utilizamos tu informaci\u00F3n de acuerdo con nuestra pol\u00EDtica de privacidad."},
			"french": {header1:"B\u00E9n\u00E9ficiez de 30 % de r\u00E9duction sur tous les abonnements annuels pr\u00E9pay\u00E9s",header2:"Utilisez ce code : <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important; top: 59% !important;}', css_mobile: '', use_code:"",cta:"\u00C9conomisez Maintenant", disclaimer:"Disclaimer : Nous utilisons vos informations conform\u00E9ment \u00E0 notre politique de confidentialit\u00E9. "},
			"portuguese": {header1:"Ganhe 30% de desconto em qualquer assinatura anual paga com anteced\u00EAncia",header2:"Use o c\u00F3digo: <span>T8FPHPCX</span>",header3: "", css:'', css_mobile: '', use_code:"",cta:"Economize agora mesmo", disclaimer:"Aviso Legal: Utilizamos a sua informa\u00E7\u00E3o de acordo com a nossa pol\u00EDtica de privacidade."},
			"german": {header1:"Erhalten Sie 30 % Rabatt bei einem j\u00E4hrlichen Abonnement mit Vorabzahlung",header2:"Verwenden Sie diesen Code: <span>T8FPHPCX</span>",header3: "", css:'.usi_header1{font-size: 2.25em !important;} .usi_header2 {font-size: 2em !important; top: 55% !important;}', css_mobile: '', use_code:"",cta:"Jetzt sparen", disclaimer:"Disclaimer: Wir nutzen Ihre Informationen im Einklang mit unserer Datenschutzrichtlinie."},
			"dutch": {header1:"Krijg 30% korting op elk vooraf betaald jaarabonnement",header2:"Gebruik deze code: <span>T8FPHPCX</span>",header3: "", css:'.usi_header2 {font-size: 2.25em !important; top: 50% !important;}', css_mobile: '', use_code:"",cta:"Bespaar nu", disclaimer:""},
			"japanese": {header1:"\u5E74\u9593\u5B9A\u984D\u30D7\u30E9\u30F3\uFF08\u524D\u6255\u3044\uFF09\u304C\u3059\u3079\u306630%\u30AA\u30D5",header2:"\u6B21\u306E\u30B3\u30FC\u30C9\u3092\u3054\u4F7F\u7528\u304F\u3060\u3055\u3044: <span>T8FPHPCX</span>", header3: "",css:'.usi_header2 {font-size: 2.25em !important; top: 52% !important;}', css_mobile: '', use_code:"",cta:"\u4ECA\u306A\u308930%\u5272\u5F15", disclaimer:"\u514D\u8CAC\u4E8B\u9805\uFF1A\u5F53\u793E\u306F\u3001\u304A\u5BA2\u69D8\u306E\u60C5\u5831\u3092\u5F53\u793E\u306E\u30D7\u30E9\u30A4\u30D0\u30B7\u30FC\u30DD\u30EA\u30B7\u30FC\u306B\u57FA\u3065\u304D\u4F7F\u7528\u3057\u307E\u3059\u3002"},
			"hindi": {header1:"Get 30% off any annual prepaid subscription",header2:"Use code: <span>T8FPHPCX</span>", header3: "", css:'', css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."},
			"tamil": {header1:"Get 30% off any annual prepaid subscription",header2:"Use code: <span>T8FPHPCX</span>", header3: "", css:'', css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."},
			"telugu": {header1:"Get 30% off any annual prepaid subscription",header2:"Use code: <span>T8FPHPCX</span>", header3: "", css:'', css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."},
			"marathi": {header1:"Get 30% off any annual prepaid subscription",header2:"Use code: <span>T8FPHPCX</span>", header3: "", css:'', css_mobile: '',  use_code:"",cta:"Save now", disclaimer:"We use your information in accordance with our privacy policy."}
		};

		usi_app.message_sitewide_event_q3_2023_new_users = {
			"english": {header1:"Unleash your creativity",header2:"Get 20% off your order today", header3: "", css:".usi_header1{font-size: 3.5em !important;} .usi_header2{width: 42% !important; left: 8% !important; top: 50% !important; font-weight: normal !important; font-size: 2.5em !important;}", css_mobile: '',  use_code:"",cta:"Redeem now", disclaimer:"We use your information in accordance with our privacy policy."},
			"sichinese": {header1:"\u91CA\u653E\u60A8\u7684\u521B\u4F5C\u624D\u534E",header2:"\u4ECA\u5929\u53EF\u4EAB8\u6298\u4F18\u60E0",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u5FEB\u6765\u5151\u6362\u5427", disclaimer:"\u514D\u8D23\u58F0\u660E\uFF1A\u6211\u4EEC\u6839\u636E\u6211\u4EEC\u7684\u9690\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"trchinese": {header1:"\u91CB\u653E\u60A8\u7684\u5275\u4F5C\u624D\u83EF",header2:"\u4ECA\u5929\u53EF\u4EAB\u53D78\u6298\u512A\u60E0",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u5FEB\u4F86\u514C\u63DB\u5427", disclaimer:"\u514D\u8CAC\u8072\u660E\uFF1A\u6211\u5011\u6839\u64DA\u6211\u5011\u7684\u96B1\u79C1\u653F\u7B56\u4F7F\u7528\u60A8\u7684\u4FE1\u606F"},
			"czech": {header1:"Popus\u0165te uzdu sv\u00E9 kreativit\u011B",header2:"Z\u00EDskejte 20% slevu na svou objedn\u00E1vku je\u0161t\u011B dnes",header3: "", css:'', css_mobile: '', use_code:"",cta:"Uplatnit nyní", disclaimer:"Prohl\u00E1\u0161en\u00ED: Va\u0161e informace zpracov\u00E1v\u00E1me v souladu s na\u0161imi z\u00E1sadami o ochran\u011B osobn\u00EDch \u00FAdaj\u016F"},
			"danish": {header1:"Slip kreativiteten l\u00F8s",header2:"F\u00E5 20% rabat p\u00E5 din ordre i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"Indl\u00F8s nu", disclaimer:"Ansvarsfraskrivelse: Vi bruger dine oplysninger i overensstemmelse med vores fortrolighedspolitik."},
			"finland": {header1:"P\u00E4\u00E4st\u00E4 luovuutesi valloilleen",header2:"Saat 20 % alennuksen tilauksestasi t\u00E4n\u00E4\u00E4n",header3: "", css:'', css_mobile: '', use_code:"",cta:"Lunasta nyt", disclaimer:"Vastuuvapauslauseke: K\u00E4yt\u00E4mme tietojasi tietosuojak\u00E4yt\u00E4nt\u00F6mme mukaisesti."},
			"hungary": {header1:"Engedje szabadj\u00E1ra a kreativit\u00E1s\u00E1t",header2:"20% engedm\u00E9ny, ha ma rendel",header3: "", css:'', css_mobile: '', use_code:"",cta:"Szerezze meg most", disclaimer:"Jogi nyilatkozat: Az adatait az adatv\u00E9delmi nyilatkozatunk el\u0151\u00EDr\u00E1sai szerint haszn\u00E1ljuk fel."},
			"norway": {header1:"Slipp kreativiteten l\u00F8s",header2:"F\u00E5 20 % rabatt p\u00E5 ordren din i dag",header3: "", css:'', css_mobile: '', use_code:"",cta:"L\u00F8s inn n\u00E5", disclaimer:"Vi bruker informasjonen din i samsvar med v\u00E5re personvernregler"},
			"polish": {header1:"Wyzw\u00F3l swoj\u0105 kreatywno\u015B\u0107",header2:"Otrzymaj -20% na zam\u00F3wienie ju\u017C dzisiaj",header3: "", css:'', css_mobile: '', use_code:"",cta:"Skorzystaj teraz", disclaimer:"Zastrze\u017Cenie: U\u017Cywamy Twoich danych zgodnie z nasz\u0105 polityk\u0105 prywatno\u015Bci"},
			"russia": {header1:"\u0420\u0430\u0441\u043A\u0440\u043E\u0439 \u0441\u0432\u043E\u044E \u043A\u0440\u0435\u0430\u0442\u0438\u0432\u043D\u043E\u0441\u0442\u044C",header2:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 \u0441\u043A\u0438\u0434\u043A\u0443 20% \u043D\u0430 \u0432\u0430\u0448 \u0437\u0430\u043A\u0430\u0437 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0410\u043A\u0442\u0438\u0432\u0438\u0440\u043E\u0432\u0430\u0442\u044C", disclaimer:"\u041E\u0442\u043A\u0430\u0437 \u043E\u0442 \u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0435\u043D\u043D\u043E\u0441\u0442\u0438: \u041C\u044B \u0438\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0435\u043C \u0432\u0430\u0448\u0443 \u0438\u043D\u0444\u043E\u0440\u043C\u0430\u0446\u0438\u044E \u0432 \u0441\u043E\u043E\u0442\u0432\u0435\u0442\u0441\u0442\u0432\u0438\u0438 \u0441 \u043D\u0430\u0448\u0435\u0439 \u043F\u043E\u043B\u0438\u0442\u0438\u043A\u043E\u0439 \u043A\u043E\u043D\u0444\u0438\u0434\u0435\u043D\u0446\u0438\u0430\u043B\u044C\u043D\u043E\u0441\u0442\u0438."},
			"sweden": {header1:"Sl\u00E4pp loss din kreativitet",header2:"F\u00E5 20% rabatt p\u00E5 din best\u00E4llning idag",header3: "", css:'', css_mobile: '', use_code:"",cta:"L\u00F6s in nu", disclaimer:"Observera: Vi anv\u00E4nder din information i enlighet med v\u00E5r integritetspolicy."},
			"thai": {header1:"\u0E1B\u0E25\u0E14\u0E1B\u0E25\u0E48\u0E2D\u0E22\u0E04\u0E27\u0E32\u0E21\u0E04\u0E34\u0E14\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E2A\u0E23\u0E23\u0E04\u0E4C\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",header2:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 20% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0E1A\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49", disclaimer:"\u0E02\u0E49\u0E2D\u0E08\u0E33\u0E01\u0E31\u0E14\u0E04\u0E27\u0E32\u0E21\u0E23\u0E31\u0E1A\u0E1C\u0E34\u0E14\u0E0A\u0E2D\u0E1A: \u0E40\u0E23\u0E32\u0E43\u0E0A\u0E49\u0E02\u0E49\u0E2D\u0E21\u0E39\u0E25\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13\u0E15\u0E32\u0E21\u0E19\u0E42\u0E22\u0E1A\u0E32\u0E22\u0E04\u0E27\u0E32\u0E21\u0E40\u0E1B\u0E47\u0E19\u0E2A\u0E48\u0E27\u0E19\u0E15\u0E31\u0E27\u0E02\u0E2D\u0E07\u0E40\u0E23\u0E32"},
			"turkey": {header1:"Yarat\u0131c\u0131l\u0131\u011F\u0131n\u0131z\u0131 serbest b\u0131rak\u0131n",header2:"Bug\u00FCn verece\u011Finiz sipari\u015Finizde %20 indirim kazan\u0131n",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u015Eimdi kullan", disclaimer:"Sorumluluk Reddi: Bilgilerinizi gizlilik politikam\u0131za uygun olarak kullan\u0131yoruz."},
			"italian": {header1:"Libera la tua creativit\u00E0",header2:"Ricevi subito un 20% di sconto sul tuo ordine",header3: "", css:'', css_mobile: '', use_code:"",cta:"Approfittane ora", disclaimer:"Avviso legale: utilizziamo le tue informazioni in conformit\u00E0 con la nostra politica sulla privacy."},
			"korean": {header1:"\uCC3D\uC758\uB825\uC744 \uB9C8\uC74C\uAECF \uBC1C\uD718\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uC2DC 20% \uD560\uC778 ",header3: "", css:'', css_mobile: '', use_code:"",cta:"\uC9C0\uAE08 \uC0AC\uC6A9\uD558\uC138\uC694", disclaimer:"\uBA74\uCC45 \uC870\uD56D: \uC6B0\uB9AC\uB294 \uAC1C\uC778\uC815\uBCF4 \uBCF4\uD638\uC815\uCC45\uC5D0 \uB530\uB77C \uADC0\uD558\uC758 \uC815\uBCF4\uB97C \uC0AC\uC6A9\uD569\uB2C8\uB2E4"},
			"espanol": {header1:"Libera tu creatividad",header2:"Consigue hoy un 20% de descuento en tu pedido",header3: "", css:'', css_mobile: '', use_code:"",cta:"Canjear ahora", disclaimer:"Aviso legal: Utilizamos tu informaci\u00F3n de acuerdo con nuestra pol\u00EDtica de privacidad."},
			"french": {header1:"Lib\u00E9rez votre cr\u00E9ativit\u00E9",header2:"B\u00E9n\u00E9ficiez de 20 % de r\u00E9duction sur votre commande aujourd\u2019hui",header3: "", css:'.usi_submitbutton{font-size: 1.3em !important;}', css_mobile: '', use_code:"",cta:"En profiter maintenant", disclaimer:"Disclaimer : Nous utilisons vos informations conform\u00E9ment \u00E0 notre politique de confidentialit\u00E9. "},
			"portuguese": {header1:"Expresse sua criatividade",header2:"Obtenha hoje 20% de desconto em seu pedido",header3: "", css:'', css_mobile: '', use_code:"",cta:"Obtenha agora", disclaimer:"Aviso Legal: Utilizamos a sua informa\u00E7\u00E3o de acordo com a nossa pol\u00EDtica de privacidade."},
			"german": {header1:"Lassen Sie Ihrer Kreativit\u00E4t freien Lauf",header2:"Erhalten Sie heute 20% Rabatt auf Ihre Bestellung",header3: "", css:'', css_mobile: '', use_code:"",cta:"Jetzt einl\u00F6sen", disclaimer:"Disclaimer: Wir nutzen Ihre Informationen im Einklang mit unserer Datenschutzrichtlinie."},
			"dutch": {header1:"Laat je creativiteit op de vrije loop",header2:"Ontvang vandaag 20% korting op je bestelling",header3: "", css:'', css_mobile: '', use_code:"",cta:"Ontvang nu", disclaimer:""},
			"japanese": {header1:"\u5275\u9020\u529B\u3092\u89E3\u304D\u653E\u3068\u3046\uFF01",header2:"\u4ECA\u65E5\u306E\u3054\u6CE8\u6587\u304C20\uFF05\u30AA\u30D5\u306B\u306A\u308B", header3: "",css:'', css_mobile: '', use_code:"",cta:"\u4ECA\u3059\u3050\u5229\u7528", disclaimer:"\u514D\u8CAC\u4E8B\u9805\uFF1A\u5F53\u793E\u306F\u3001\u304A\u5BA2\u69D8\u306E\u60C5\u5831\u3092\u5F53\u793E\u306E\u30D7\u30E9\u30A4\u30D0\u30B7\u30FC\u30DD\u30EA\u30B7\u30FC\u306B\u57FA\u3065\u304D\u4F7F\u7528\u3057\u307E\u3059\u3002"},
			"hindi": {header1:"\u0905\u092A\u0928\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u0915\u094B \u0909\u091C\u093E\u0917\u0930 \u0915\u0930\u0947\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 20% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902", disclaimer:"\u0939\u092E \u0906\u092A\u0915\u0940 \u091C\u093E\u0928\u0915\u093E\u0930\u0940 \u0915\u093E \u0909\u092A\u092F\u094B\u0917 \u0939\u092E\u093E\u0930\u0940 \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0928\u0940\u0924\u093F \u0915\u0947 \u0905\u0928\u0941\u0938\u093E\u0930 \u0915\u0930\u0924\u0947 \u0939\u0948\u0902\u0964"},
			"tamil": {header1:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BAA\u0B9F\u0BC8\u0BAA\u0BCD\u0BAA\u0BBE\u0BB1\u0BCD\u0BB1\u0BB2\u0BC8 \u0B95\u0B9F\u0BCD\u0B9F\u0BB5\u0BBF\u0BB4\u0BCD\u0BA4\u0BCD\u0BA4\u0BC1 \u0BB5\u0BBF\u0B9F\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BA9\u0BCD\u0BB1\u0BC1 \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BBF\u0BB2\u0BCD 20% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header3: "", css:".usi_header1{font-size: 1.8em !important;} .usi_header2{font-size: 1.8em !important;}", css_mobile: '', use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC1 \u0BAE\u0BC0\u0B9F\u0BCD\u0B9F\u0BC1\u0B95\u0BCD\u0B95\u0BCA\u0BB3\u0BCD\u0BB3\u0BB5\u0BC1\u0BAE\u0BCD", disclaimer:"\u0B8E\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0BA9\u0BBF\u0BAF\u0BC1\u0BB0\u0BBF\u0BAE\u0BC8\u0B95\u0BCD \u0B95\u0BCA\u0BB3\u0BCD\u0B95\u0BC8\u0BAF\u0BBF\u0BA9\u0BCD\u0BAA\u0B9F\u0BBF \u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BCD \u0BA4\u0B95\u0BB5\u0BB2\u0BC8\u0BAA\u0BCD \u0BAA\u0BAF\u0BA9\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0B95\u0BBF\u0BB1\u0BCB\u0BAE\u0BCD."},
			"telugu": {header1:"\u0C2E\u0C40 \u0C38\u0C43\u0C1C\u0C28\u0C3E\u0C24\u0C4D\u0C2E\u0C15\u0C24\u0C28\u0C41 \u0C35\u0C46\u0C32\u0C3F\u0C15\u0C3F\u0C24\u0C40\u0C2F\u0C02\u0C21\u0C3F",header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C06\u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 20% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F", disclaimer:"\u0C2E\u0C47\u0C2E\u0C41 \u0C2E\u0C40 \u0C38\u0C2E\u0C3E\u0C1A\u0C3E\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C2E\u0C3E \u0C17\u0C4B\u0C2A\u0C4D\u0C2F\u0C24\u0C3E \u0C35\u0C3F\u0C27\u0C3E\u0C28\u0C3E\u0C28\u0C3F\u0C15\u0C3F \u0C05\u0C28\u0C41\u0C17\u0C41\u0C23\u0C02\u0C17\u0C3E \u0C09\u0C2A\u0C2F\u0C4B\u0C17\u0C3F\u0C38\u0C4D\u0C24\u0C3E\u0C2E\u0C41."},
			"marathi": {header1:"\u0924\u0941\u092E\u091A\u0940 \u0915\u094D\u0930\u0940\u090F\u091F\u093F\u0935\u093F\u091F\u093F \u092C\u093E\u0939\u0947\u0930 \u092F\u0947\u0909 \u0926\u094D\u092F\u093E",header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u0911\u0930\u094D\u0921\u0930\u0935\u0930 20% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",header3: "", css:'', css_mobile: '', use_code:"",cta:"\u0906\u0924\u093E\u091A \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E", disclaimer:"\u0906\u092E\u094D\u0939\u0940 \u0924\u0941\u092E\u091A\u0940 \u092E\u093E\u0939\u093F\u0924\u0940 \u0906\u092E\u091A\u094D\u092F\u093E \u0917\u094B\u092A\u0928\u0940\u092F\u0924\u093E \u0927\u094B\u0930\u0923\u093E\u0928\u0941\u0938\u093E\u0930 \u0935\u093E\u092A\u0930\u0924\u094B."},
		};

		usi_app.message_images_freetrial = {
			"english": {header1:"Get 10 free images",bullet1:"Try 10 images per month plan for free",bullet2:"Pay just $29/mo after your trial ends", bullet3:"If you cancel in the 1st month you pay nothing!",cta:"Start your free trial",url:"https://www.shutterstock.com/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"sichinese": {header1:"\u7ACB\u5373\u83B7\u53D610\u5F20\u514D\u8D39\u56FE\u7247",bullet1:"\u514D\u8D39\u8BD5\u7528\u6BCF\u670810\u5F20\u56FE\u7247\u8BA1\u5212",bullet2:"\u8BD5\u7528\u7ED3\u675F\u540E\u4EC5\u9700\u652F\u4ED829\u7F8E\u5143/\u6708",bullet3:"\u8BD5\u7528\u7ED3\u675F\u540E\u4EC5\u9700\u652F\u4ED829\u7F8E\u5143\u6708",cta:"\u5982\u679C\u60A8\u5728\u7B2C\u4E00\u4E2A\u6708\u53D6\u6D88\uFF0C\u5219\u65E0\u9700\u652F\u4ED8\u4EFB\u4F55\u8D39\u7528",url:"https://www.shutterstock.com/zh/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"trchinese": {header1:"\u7ACB\u5373\u7372\u53D610\u5F35\u514D\u8CBB\u5716\u7247",bullet1:"\u514D\u8CBB\u8A66\u7528\u6BCF\u670810\u5F35\u5716\u7247\u8A08\u5283",bullet2:"\u8A66\u7528\u7D50\u675F\u5F8C\u50C5\u9700\u652F\u4ED829\u7F8E\u5143\u6708",bullet3:"\u5982\u679C\u60A8\u5728\u7B2C\u4E00\u500B\u6708\u53D6\u6D88\uFF0C\u5247\u7121\u9700\u652F\u4ED8\u4EFB\u4F55\u8CBB\u7528\uFF01",cta:"\u7ACB\u5373\u514D\u8CBB\u8A66\u7528",url:"https://www.shutterstock.com/zh-Hant/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"czech": {header1:"Vyzkou\u0161ejte pl\u00E1n 10 sn\u00EDmk\u016F za m\u011Bs\u00EDc zdarma",bullet1:"Pla\u0165te jen $29/m\u011Bs\u00ED\u010Dn\u011B po zku\u0161ebn\u00ED dob\u011B",bullet2:"Pokud zru\u0161\u00EDte v prvn\u00EDm m\u011Bs\u00EDci, neplat\u00EDte nic!",bullet3:"",cta:"Vyzkou\u0161ejte zdarma ihned!",url:"https://www.shutterstock.com/cs/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"danish": {header1:"F\u00E5 10 gratis billeder nu",bullet1:"Pr\u00F8v abonnementet med 10 billeder om m\u00E5neden gratis",bullet2:"Betal kun 29 USD/md. efter din pr\u00F8veperiode slutter",bullet3:"Hvis du afbestiller i 1. m\u00E5ned, betaler du intet!",cta:"Pr\u00F8v det gratis nu",url:"https://www.shutterstock.com/da/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"finland": {header1:"Hanki 10 ilmaista kuvaa nyt",bullet1:"Kokeile 10 kuukausittaisen kuvan ohjelmaa ilmaiseksi",bullet2:"Kokeilun j\u00E4lkeen maksat vain 29 \u20AC/kk",bullet3:"Jos peruutat ensimm\u00E4isen kuukauden aikana, et joudu maksamaan mit\u00E4\u00E4n!",cta:"Kokeile ilmaiseksi nyt",url:"https://www.shutterstock.com/fi/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"hungary": {header1:"10 k\u00E9p ingyenesen",bullet1:"Pr\u00F3b\u00E1lja ki a havonta 10 k\u00E9pet tartalmaz\u00F3 csomagot",bullet2:"A pr\u00F3baid\u0151 ut\u00E1n a csomag mind\u00F6ssze 29 usd/h\u00F3",bullet3:"Ha m\u00E1r az els\u0151 h\u00F3napban lemondja, akkor nem fizet semmit!",cta:"Pr\u00F3b\u00E1lja ki ingyenesen",url:"https://www.shutterstock.com/hu/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"norway": {header1:"F\u00E5 10 gratis bilder n\u00E5",bullet1:"Pr\u00F8v abonnementet med 10 bilder per m\u00E5ned gratis",bullet2:"Betal kun $ 29/mnd etter pr\u00F8veperioden",bullet3:"Du betaler ingenting hvis du kansellerer i den f\u00F8rste m\u00E5neden!",cta:"Pr\u00F8v gratis n\u00E5",url:"https://www.shutterstock.com/nb/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"polish": {header1:"Otrzymaj 10 darmowych zdj\u0119\u0107 ju\u017C teraz",bullet1:"Wypr\u00F3buj plan z 10 zdj\u0119ciami miesi\u0119cznie za darmo",bullet2:"P\u0142a\u0107 tylko 29 $/mies. po zako\u0144czeniu okresu pr\u00F3bnego",bullet3:"Je\u015Bli zrezygnujesz w pierwszym miesi\u0105cu, nie zap\u0142acisz nic!",cta:"Wypr\u00F3buj teraz za darmo",url:"https://www.shutterstock.com/pl/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"russia": {header1:"\u041F\u043E\u043B\u0443\u0447\u0438\u0442\u0435 10 \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u044B\u0445 \u0438\u0437\u043E\u0431\u0440\u0430\u0436\u0435\u043D\u0438\u0439 \u0441\u0435\u0439\u0447\u0430\u0441",bullet1:"\u0412\u043E\u0441\u043F\u043E\u043B\u044C\u0437\u0443\u0439\u0442\u0435\u0441\u044C \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u044B\u043C \u0442\u0430\u0440\u0438\u0444\u043E\u043C \u0441 10 \u0438\u0437\u043E\u0431\u0440\u0430\u0436\u0435\u043D\u0438\u044F\u043C\u0438 \u0432 \u043C\u0435\u0441\u044F\u0446",bullet2:"\u041F\u043B\u0430\u0442\u0438\u0442\u0435 $29/\u043C\u0435\u0441\u044F\u0446 \u043F\u043E\u0441\u043B\u0435 \u043E\u043A\u043E\u043D\u0447\u0430\u043D\u0438\u044F \u043F\u0440\u043E\u0431\u043D\u043E\u0433\u043E \u043F\u0435\u0440\u0438\u043E\u0434\u0430",bullet3:"\u0415\u0441\u043B\u0438 \u0432\u044B \u043E\u0442\u043C\u0435\u043D\u0438\u0442\u0435 \u043F\u043E\u0434\u043F\u0438\u0441\u043A\u0443 \u0432 \u0442\u0435\u0447\u0435\u043D\u0438\u0435 \u043F\u0435\u0440\u0432\u043E\u0433\u043E \u043C\u0435\u0441\u044F\u0446\u0430, \u0432\u044B \u043D\u0438\u0447\u0435\u0433\u043E \u043D\u0435 \u0437\u0430\u043F\u043B\u0430\u0442\u0438\u0442\u0435!",cta:"\u041F\u043E\u043F\u0440\u043E\u0431\u0443\u0439\u0442\u0435 \u0431\u0435\u0441\u043F\u043B\u0430\u0442\u043D\u043E \u0441\u0435\u0439\u0447\u0430\u0441",url:"https://www.shutterstock.com/ru/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"sweden": {header1:"F\u00E5 10 bilder gratis nu",bullet1:"Prova planen med 10 bilder per m\u00E5nad gratis",bullet2:"Betala endast $29/m\u00E5nad efter provperioden",bullet3:"Om du avslutar under den f\u00F6rsta m\u00E5naden betalar du ingenting!",cta:"Testa gratis nu",url:"https://www.shutterstock.com/sv/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"thai": {header1:"\u0E23\u0E31\u0E1A 10 \u0E20\u0E32\u0E1E\u0E1F\u0E23\u0E35\u0E17\u0E31\u0E19\u0E17\u0E35",bullet1:"\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E41\u0E1C\u0E19 10 \u0E20\u0E32\u0E1E\u0E15\u0E48\u0E2D\u0E40\u0E14\u0E37\u0E2D\u0E19\u0E1F\u0E23\u0E35",bullet2:"\u0E08\u0E48\u0E32\u0E22\u0E41\u0E04\u0E48\u0E40\u0E1E\u0E35\u0E22\u0E07 $29/\u0E40\u0E14\u0E37\u0E2D\u0E19 \u0E2B\u0E25\u0E31\u0E07\u0E08\u0E32\u0E01\u0E17\u0E35\u0E48\u0E2A\u0E34\u0E49\u0E19\u0E2A\u0E38\u0E14\u0E01\u0E32\u0E23\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13",bullet3:"\u0E2B\u0E32\u0E01\u0E04\u0E38\u0E13\u0E22\u0E01\u0E40\u0E25\u0E34\u0E01\u0E43\u0E19\u0E40\u0E14\u0E37\u0E2D\u0E19\u0E17\u0E35\u0E48 1 \u0E04\u0E38\u0E13\u0E08\u0E30\u0E44\u0E21\u0E48\u0E15\u0E49\u0E2D\u0E07\u0E08\u0E48\u0E32\u0E22\u0E2D\u0E30\u0E44\u0E23\u0E40\u0E25\u0E22!",cta:"\u0E17\u0E14\u0E25\u0E2D\u0E07\u0E43\u0E0A\u0E49\u0E1F\u0E23\u0E35\u0E17\u0E31\u0E19\u0E17\u0E35",url:"https://www.shutterstock.com/th/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"turkey": {header1:"\u015Eimdi 10 \u00FCcretsiz resim al",bullet1:"Ayl\u0131k 10 resim plan\u0131n\u0131 \u00FCcretsiz dene",bullet2:"Deneme s\u00FCresi bitince ayda sadece 29$ \u00F6de",bullet3:"\u0130lk ay iptal edersen hi\u00E7bir \u015Fey \u00F6demeyeceksin",cta:"\u015Eimdi \u00FCcretsiz dene",url:"https://www.shutterstock.com/tr/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"italian": {header1:"Ottieni subito 10 immagini gratis",bullet1:"Prova gratuitamente il piano di 10 immagini al mese",bullet2:"Paga solo 29 $/mese al termine del periodo di prova",bullet3:"Se annulli durante il primo mese non paghi nulla!",cta:"Prova ora gratis",url:"https://www.shutterstock.com/it/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"korean": {header1:"\uC9C0\uAE08 10\uAC1C\uC758 \uC774\uBBF8\uC9C0\uB97C \uBB34\uB8CC\uB85C \uBC1B\uC73C\uC138\uC694",bullet1:"\uB9E4\uC6D4 10\uAC1C\uC758 \uC774\uBBF8\uC9C0\uB97C \uBB34\uB8CC\uB85C \uC0AC\uC6A9\uD574 \uBCF4\uC138\uC694",bullet2:"\uD3C9\uAC00\uD310 \uC885\uB8CC \uD6C4 \uC6D4 $29\uB9CC \uC9C0\uBD88\uD558\uC138\uC694",bullet3:"\uCCAB \uB2EC\uC5D0 \uCDE8\uC18C \uC2DC \uC544\uBB34\uAC83\uB3C4 \uC9C0\uBD88\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4!",cta:"\uC9C0\uAE08 \uBC14\uB85C \uBB34\uB8CC \uCCB4\uD5D8\uD574\uBCF4\uC138\uC694",url:"https://www.shutterstock.com/ko/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"espanol": {header1:"Consigue 10 im\u00E1genes gratis ahora",bullet1:"Prueba gratis el plan de 10 im\u00E1genes por mes",bullet2:"Paga solo $29 al mes al terminar el periodo de prueba.",bullet3:"\u00A1Si cancelas dentro del primer mes, no pagas nada!",cta:"Prueba gratis ahora",url:"https://www.shutterstock.com/es/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"french": {header1:"Profitez de 10 images gratuites d\u00E8s aujourd\u2019hui",bullet1:"Essayez gratuitement l\u2019abonnement 10 images par mois",bullet2:"Payez seulement 29 $/mois \u00E0 la fin de votre p\u00E9riode d\u2019essai",bullet3:"Si vous r\u00E9siliez au cours du 1er mois, vous n\u2019avez rien \u00E0 payer !",cta:"Essayer gratuitement",url:"https://www.shutterstock.com/fr/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"portuguese": {header1:"Obtenha agora 10 imagens gratuitas",bullet1:"Experimente gratuitamente o plano de 10 imagens por m\u00EAs",bullet2:"Pague apenas 29$/m\u00EAs ap\u00F3s o seu per\u00EDodo experimental",bullet3:"Se cancelar no 1.\u00BA m\u00EAs, n\u00E3o paga nada!",cta:"Experimente agora de forma gratuita",url:"https://www.shutterstock.com/pt/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"german": {header1:"Sichern Sie sich jetzt 10 kostenlose Bilder",bullet1:"Testen Sie den Plan mit zehn kostenlosen Bildern pro Monat.",bullet2:"Nach dem Test zahlen Sie nur $29 pro Monat.",bullet3:"Wenn Sie im ersten Monat k\u00FCndigen, zahlen Sie nichts!",cta:"Jetzt kostenlos testen",url:"https://www.shutterstock.com/de/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"dutch": {header1:"Ontvang nu 10 gratis afbeeldingen",bullet1:"Probeer het abonnement gratis en ontvang 10 afbeeldingen",bullet2:"Betaal slechts $29 per maand nadat uw proefperiode is afgelopen",bullet3:"Als je opzegt in de 1e maand betaal je niets!",cta:"Probeer nu gratis",url:"https://www.shutterstock.com/nl/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"},
			"japanese": {header1:"\u4ECA\u306A\u3089\u753B\u50CF\u309210\u679A\u7121\u6599\u3067\u30D7\u30EC\u30BC\u30F3\u30C8",bullet1:"1\u30F6\u670810\u679A\u30D7\u30E9\u30F3\u3092\u7121\u6599\u3067\u304A\u8A66\u3057\u304F\u3060\u3055\u3044",bullet2:"\u30C8\u30E9\u30A4\u30A2\u30EB\u7D42\u4E86\u5F8C\u3001\u6708\u300529\u30C9\u30EB\u3092\u304A\u652F\u6255\u3044\u9802\u304D\u307E\u3059",bullet3:"1\u30F6\u6708\u4EE5\u5185\u306B\u89E3\u7D04\u3059\u308C\u3070\u3001\u652F\u6255\u3044\u306F\u4E00\u5207\u306A\u3057\uFF01",cta:"\u4ECA\u3059\u3050\u7121\u6599\u3067\u304A\u8A66\u3057\u3092",url:"https://www.shutterstock.com/ja/discover/10-free-stock-images?coupon_code=PICK10FREE&coupon=PICK10FREE"}
		};

		usi_app.message_footage_tenpercent = {
			"english": {header1:"Videos that make an impact",header2:"Get 10% off your footage order today",use_code:"",your_cart:"Your Cart", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"Redeem now"},
			"sichinese": {header1:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",header2:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",use_code:"",your_cart:"\u60A8\u7684\u8D2D\u7269\u8F66", subtotal:"\u5C0F\u8BA1", discount:"\u6298\u6263", new_total:"\u65B0\u5C0F\u8BA1",cta:"\u7ACB\u5373\u5151\u6362"},
			"trchinese": {header1:"\u6709\u5F71\u97FF\u529B\u7684\u8996\u983B",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u8996\u983B\u8A02\u55AE10%\u7684\u6298\u6263",use_code:"",your_cart:"\u60A8\u7684\u8CFC\u7269\u8ECA", subtotal:"\u5C0F\u8A08", discount:"\u6298\u6263", new_total:"\u65B0\u5C0F\u8A08",cta:"\u7ACB\u5373\u514C\u63DB"},
			"czech": {header1:"Videa, kter\u00E1 zap\u016Fsob\u00ED",header2:"Z\u00EDskejte 10% slevu na objedn\u00E1vku z\u00E1b\u011Br\u016F je\u0161t\u011B dnes",use_code:"",your_cart:"V\u00E1\u0161 ko\u0161\u00EDk", subtotal:"Mezisou\u010Det", discount:"Sleva", new_total:"Nov\u00FD Mezisou\u010Det",cta:"Uplatnit ihned"},
			"danish": {header1:"Videoer, der g\u00F8r indtryk",header2:"F\u00E5 10% i rabat p\u00E5 din bestilling af filmoptagelser i dag",use_code:"",your_cart:"Din kurv", subtotal:"Subtotal", discount:"Rabat", new_total:"Ny Subtotal",cta:"ndl\u00F8s nu"},
			"finland": {header1:"Videoita, jotka tekev\u00E4t vaikutuksen",header2:"Saat 10 % alennuksen videomateriaalitilauksestasi t\u00E4n\u00E4\u00E4n",use_code:"",your_cart:"Ostoskorisi", subtotal:"V\u00E4lisumma", discount:"Alennus", new_total:"Uusi v\u00E4lisumma",cta:"Lunasta nyt"},
			"hungary": {header1:"Vide\u00F3k, amelyek nagy hat\u00E1st gyakorolnak",header2:"10%-os engedm\u00E9ny a felv\u00E9telekb\u0151l ma",use_code:"",your_cart:"A kosarad", subtotal:"R\u00E9sz\u00F6sszeg", discount:"Kedvezm\u00E9ny", new_total:"\u00DAj r\u00E9sz\u00F6sszeg",cta:"V\u00C1LTSA BE MOST"},
			"norway": {header1:"Videoer som gj\u00F8r inntrykk",header2:"F\u00E5 10 % rabatt p\u00E5 videobestillingen din i dag",use_code:"",your_cart:"", subtotal:"Delsum", discount:"Rabatt", new_total:"Ny delsum", cta:"L\u00F8s inn n\u00E5"},
			"polish": {header1:"Znajd\u017A idealn\u0105 muzyk\u0119",header2:"Zaoszcz\u0119d\u017A 10% na swoich utworach muzycznych ju\u017C dzi\u015B",use_code:"",your_cart:"Tw\u00F3j w\u00F3zek", subtotal:"Suma cz\u0119\u015Bciowa", discount:"Rabat", new_total:"Nowa suma cz\u0119\u015Bciowa",cta:"SKORZYSTAJ TERAZ"},
			"russia": {header1:"\u0412\u0438\u0434\u0435\u043E, \u043A\u043E\u0442\u043E\u0440\u044B\u0435 \u043F\u0440\u043E\u0438\u0437\u0432\u043E\u0434\u044F\u0442 \u0432\u043F\u0435\u0447\u0430\u0442\u043B\u0435\u043D\u0438\u0435",header2:"10% \u0441\u043A\u0438\u0434\u043A\u0430 \u043D\u0430 \u0432\u044B\u0431\u0440\u0430\u043D\u043D\u044B\u0439 \u0432\u0430\u043C\u0438 \u0432\u0438\u0434\u0435\u043E\u0440\u044F\u0434 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",use_code:"",your_cart:"\u0412\u0430\u0448\u0430 \u043A\u043E\u0440\u0437\u0438\u043D\u0430", subtotal:"\u041F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433", discount:"\u0421\u043A\u0438\u0434\u043A\u0430", new_total:"\u041D\u043E\u0432\u044B\u0439 \u043F\u0440\u043E\u043C\u0435\u0436\u0443\u0442\u043E\u0447\u043D\u044B\u0439 \u0438\u0442\u043E\u0433",cta:"\u0417\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u043F\u0440\u044F\u043C\u043E \u0441\u0435\u0439\u0447\u0430\u0441"},
			"sweden": {header1:"Videor som g\u00F6r ett intryck",header2:"F\u00E5 10% rabatt p\u00E5 din videobest\u00E4llning idag",use_code:"",your_cart:"Din vagn", subtotal:"Delsumma", discount:"Rabatt", new_total:"Ny delsumma",cta:"Anv\u00E4nd nu"},
			"thai": {header1:"\u0E27\u0E34\u0E14\u0E35\u0E42\u0E2D\u0E17\u0E35\u0E48\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E1C\u0E25\u0E01\u0E23\u0E30\u0E17\u0E1A",header2:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 10% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E1F\u0E38\u0E15\u0E40\u0E17\u0E08\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",use_code:"",your_cart:"\u0E23\u0E16\u0E40\u0E02\u0E47\u0E19\u0E02\u0E2D\u0E07\u0E04\u0E38\u0E13", subtotal:"\u0E22\u0E2D\u0E14\u0E23\u0E27\u0E21", discount:"\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14", new_total:"\u0E22\u0E2D\u0E14\u0E23\u0E27\u0E21\u0E43\u0E2B\u0E21\u0E48",cta:"\u0E23\u0E31\u0E1A\u0E40\u0E25\u0E22\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49"},
			"turkey": {header1:"Ak\u0131llarda kalan videolar",header2:"Video sipari\u015Finde bug\u00FCn %10 indirim kazan",use_code:"",your_cart:"sepetiniz", subtotal:"Ara Toplam", discount:"\u0130ndirim", new_total:"Yeni Ara Toplam",cta:"\u015Eimdi kullan"},
			"italian": {header1:"Video che lasciano il segno",header2:"Ricevi subito uno sconto del 10% sul tuo ordine di filmati",use_code:"",your_cart:"Il tuo carrello", subtotal:"Subtotale", discount:"Sconto", new_total:"Nuovo Subtotale",cta:"Approfittane ora"},
			"korean": {header1:"\uD6A8\uACFC \uB9CC\uC810\uC758 \uB3D9\uC601\uC0C1\uC744 \uAD6C\uB9E4\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uD558\uBA74 10% \uD560\uC778",use_code:"",your_cart:"\uC7A5\uBC14\uAD6C\uB2C8", subtotal:"\uC18C\uACC4", discount:"\uD560\uC778", new_total:"\uC0C8 \uC18C\uACC4",cta:"\uC9C0\uAE08 \uD61C\uD0DD\uBC1B\uAE30"},
			"espanol": {header1:"V&iacute;deos que causan impacto",header2:"Consiga hoy 10% en su orden de v&iacute;deo",use_code:"",your_cart:"Tu Carrito", subtotal:"Precio", discount:"Descuento Nuevo", new_total:"Precio Nuevo",cta:"Canjear ahora"},
			"french": {header1:"Des vid\u00E9os qui font de l\u2019effet",header2:"Profitez d\u00E8s aujourd\u2019hui de 10\u00A0% de r\u00E9duction sur vos vid\u00E9os",use_code:"",your_cart:"Votre panier", subtotal:"Sous-total", discount:"Remise", new_total:"Nouveau Sous-Total",cta:"Profitez-en maintenant"},
			"portuguese": {header1:"Videos queles causam um impacto",header2:"Consigue 10 % de desconto de teu ordem de material hoje",use_code:"",your_cart:"Seu carrinho", subtotal:"Subtotal", discount:"Desconto", new_total:"Novo Subtotal",cta:"Redimir agora"},
			"german": {header1:"Videos, die \u00FCberzeugen",header2:"Erhalten Sie heute 10% Rabatt auf Ihr Bildmaterial",use_code:"",your_cart:"Ihr Warenkorb", subtotal:"Subtotal", discount:"Discount", new_total:"New Subtotal",cta:"Jetzt einl\u00F6sen"},
			"dutch": {header1:"Video's die impact maken.",header2:"Ontvang vandaag 10% korting op uw beeldmateriaal bestelling",use_code:"",your_cart:"sepetiniUw winkelwagenz", subtotal:"Subtotaal", discount:"Korting", new_total:"Nieuw subtotaal",cta:"Ontvang nu"},
			"japanese": {header1:"\u30A4\u30F3\u30D1\u30AF\u30C8\u306E\u3042\u308B\u30D3\u30C7\u30AA",header2:"\u672C\u65E5\u3054\u6CE8\u6587\u306B\u306A\u308B\u3068\u52D5\u753B\u304C10\uFF05\u30AA\u30D5",use_code:"",your_cart:"\u3042\u306A\u305F\u306E\u30AB\u30FC\u30C8", subtotal:"\u5C0F\u8A08", discount:"\u5272\u5F15", new_total:"\u65B0\u3057\u3044\u5C0F\u8A08",cta:"\u4ECA\u3059\u3050\u3054\u5229\u7528\u304F\u3060\u3055\u3044"},
			"hindi": {header1:"\u0910\u0938\u0947 \u0935\u0940\u0921\u093F\u092F\u094B \u091C\u094B \u092A\u094D\u0930\u092D\u093E\u0935 \u0921\u093E\u0932\u0924\u0947 \u0939\u0948\u0902",header2:"\u0906\u091C \u0939\u0940 \u0905\u092A\u0928\u0947 \u092B\u093C\u0941\u091F\u0947\u091C \u0911\u0930\u094D\u0921\u0930 \u092A\u0930 10% \u0915\u0940 \u091B\u0942\u091F \u092A\u093E\u090F\u0902",use_code:"",your_cart:"\u0906\u092A\u0915\u093E \u0915\u093E\u0930\u094D\u091F", subtotal:"\u0938\u092C\u091F\u094B\u091F\u0932", discount:"\u0921\u093F\u0938\u094D\u0915\u093E\u0909\u0902\u091F", new_total:"\u0928\u092F\u093E \u0938\u092C\u091F\u094B\u091F\u0932",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BA4\u0BBE\u0B95\u0BCD\u0B95\u0BA4\u0BCD\u0BA4\u0BC8 \u0B8F\u0BB1\u0BCD\u0BAA\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC1\u0BAE\u0BCD \u0BB5\u0BC0\u0B9F\u0BBF\u0BAF\u0BCB\u0B95\u0BCD\u0B95\u0BB3\u0BCD", header2:"\u0B89\u0B99\u0BCD\u0B95\u0BB3\u0BC1\u0B95\u0BCD\u0B95\u0BBE\u0BA9 \u0BAA\u0BA4\u0BBF\u0BB5\u0BC8 \u0B87\u0BA9\u0BCD\u0BB1\u0BC7 \u0B86\u0BB0\u0BCD\u0B9F\u0BB0\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BA4\u0BC1 10% \u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF \u0BAA\u0BC6\u0BB1\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",use_code:"",your_cart:"\u0B89\u0BA9\u0BCD\u0BA9\u0BC1\u0B9F\u0BC8\u0BAF \u0BAA\u0BC8\u0BAF\u0BBF\u0BB2\u0BCD", subtotal:"\u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8", discount:"\u0BA4\u0BB3\u0BCD\u0BB3\u0BC1\u0BAA\u0B9F\u0BBF", new_total:"\u0BAA\u0BC1\u0BA4\u0BBF\u0BAF \u0B95\u0BC2\u0B9F\u0BCD\u0B9F\u0BC1\u0BA4\u0BCD\u0BA4\u0BC6\u0BBE\u0B95\u0BC8",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC7 \u0BB0\u0BC0\u0B9F\u0BC0\u0BAE\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD"},
			"telugu": {header1:"\u0C2A\u0C4D\u0C30\u0C2D\u0C3E\u0C35\u0C02 \u0C1A\u0C42\u0C2A\u0C47 \u0C35\u0C40\u0C21\u0C3F\u0C2F\u0C4B\u0C32\u0C41", header2:"\u0C08\u0C30\u0C4B\u0C1C\u0C47 \u0C2E\u0C40 \u0C2B\u0C41\u0C1F\u0C47\u0C1C\u0C4D\u0C06 \u0C30\u0C4D\u0C21\u0C30\u0C4D\u200C\u0C2A\u0C48 10% \u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41 \u0C2A\u0C4A\u0C02\u0C26\u0C02\u0C21\u0C3F",use_code:"",your_cart:"\u0C2E\u0C40 \u0C15\u0C3E\u0C30\u0C4D\u0C1F\u0C4D", subtotal:"\u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D", discount:"\u0C24\u0C17\u0C4D\u0C17\u0C3F\u0C02\u0C2A\u0C41", new_total:"\u0C15\u0C4A\u0C24\u0C4D\u0C24 \u0C38\u0C2C\u0C4D \u0C1F\u0C4B\u0C1F\u0C32\u0C4D",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D\u0C1A\u0C47 \u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F\n"},
			"marathi": {header1:"\u092A\u094D\u0930\u092D\u093E\u0935\u093F\u0924 \u0915\u0930\u0923\u093E\u0930\u0947 \u0935\u094D\u0939\u093F\u0921\u093F\u0913", header2:"\u0906\u091C\u091A \u0924\u0941\u092E\u091A\u094D\u092F\u093E \u092B\u0941\u091F\u0947\u091C \u0911\u0930\u094D\u0921\u0930\u0935\u0930 10% \u0938\u0942\u091F \u092E\u093F\u0933\u0935\u093E",use_code:"",your_cart:"\u0924\u0941\u092E\u091A\u0940 \u0915\u093E\u0930\u094D\u091F", subtotal:"\u090F\u0915\u0942\u0923", discount:"\u0938\u0942\u091F", new_total:"\u0928\u0935\u0940\u0928 \u090F\u0915\u0942\u0923",cta:"\u0906\u0924\u093E \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E"}
		};

		usi_app.message_images_sitewide = {
			"english": {header1:"Share your colors",header2:"Save 25% while also giving back",use_code: "Use code",cta: "Get started"},
			"sichinese": {header1:"\u5206\u4EAB\u4F60\u7684\u989C\u8272",header2:"\u5728\u56DE\u9988\u7684\u540C\u65F6\u4EAB\u670975\u6298\u4F18\u60E0",use_code:"",cta:"\u5F00\u59CB"},
			"trchinese": {header1:"\u5206\u4EAB\u4F60\u7684\u984F\u8272",header2:"\u5728\u56DE\u994B\u7684\u540C\u6642\u4EAB\u670975\u6298\u512A\u60E0",use_code:"",cta:"\u958B\u59CB"},
			"czech": {header1:"Najd\u{11B}te perfektn\u{ED} sn\u{ED}mek",header2:"U\u{161}et\u{159}ete 25 % na sn\u{ED}mkov\u{FD}ch podkladech",use_code:"",cta:"Uplatnit nyn\u{ED}"},
			"danish": {header1:"Find det perfekte billede",header2:"Spar 25% p\u{E5} billedaktiver",use_code:"",cta:"Indl\u{F8}s nu"},
			"finland": {header1:"L\u{F6}yd\u{E4} t\u{E4}ydellinen kuva",header2:"S\u{E4}\u{E4}st\u{E4} 25 % kuvamateriaaleista",use_code:"",cta:"Lunasta Nyt"},
			"hungary": {header1:"Tal\u{E1}ld meg a t\u{F6}k\u{E9}letes k\u{E9}pet",header2:"Sp\u{F3}rolj 25%-ot a k\u{E9}pi elemeken",use_code:"",cta:"V\u{E1}ltsd be most"},
			"norway": {header1:"Finn det perfekte bildet",header2:"Spar 25 % p\u{E5} bilder og illustrasjoner",use_code:"",cta:"Aktiver tilbudet n\u{E5}"},
			"polish": {header1:"Znajd\u{17A} idealn\u{105} grafik\u{119}",header2:"Oszdz\u{119}d\u{17A} 25% na grafikach",use_code:"",cta:"Skorzystaj teraz"},
			"russia": {header1:"\u{41D}\u{430}\u{439}\u{434}\u{438} \u{438}\u{434}\u{435}\u{430}\u{43B}\u{44C}\u{43E}\u{435} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{435}",header2:"\u{421}\u{44D}\u{43A}\u{43E}\u{43D}\u{43E}\u{43C}\u{44C}\u{442}\u{435} 25% \u{43D}\u{430} \u{430}\u{43A}\u{442}\u{438}\u{432}\u{430}\u{445} \u{43F}\u{43E} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{44E}",use_code:"",cta:"\u{417}\u{430}\u{431}\u{435}\u{440}\u{438}\u{442}\u{435} \u{43F}\u{440}\u{44F}\u{43C}\u{43E} \u{441}\u{435}\u{439}\u{447}\u{430}\u{441}"},
			"sweden": {header1:"Hitta den perfekta bilden",header2:"25% rabatt p\u{E5} bildresurser",use_code:"",cta:"L\u{F6}s in nu"},
			"thai": {header1:"\u{E04}\u{E49}\u{E19}\u{E2B}\u{E32}\u{E20}\u{E32}\u{E1E}\u{E17}\u{E35}\u{E48}\u{E2A}\u{E21}\u{E1A}\u{E39}\u{E23}\u{E13}\u{E4C}\u{E41}\u{E1A}\u{E1A}",header2:"\u{E1B}\u{E23}\u{E30}\u{E2B}\u{E22}\u{E31}\u{E14} 25% \u{E2A}\u{E33}\u{E2B}\u{E23}\u{E31}\u{E1A}\u{E40}\u{E19}\u{E37}\u{E49}\u{E2D}\u{E2B}\u{E32}\u{E23}\u{E39}\u{E1B}\u{E20}\u{E32}\u{E1E}",use_code:"",cta:"\u{E1A}\u{E15}\u{E2D}\u{E19}\u{E19}\u{E35}\u{E49}"},
			"turkey": {header1:"M\u{FC}kemmel resmi bul",header2:"Resim \u{FC}r\u{FC}nlerinde % tasarruf",use_code:"",cta:"\u{15E}imdi Kullan"},
			"italian": {header1:"Trova l'immagine perfetta",header2:"Risparmia il 25% sulle immagini",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\u{C644}\u{BCBD}\u{D55C} \u{C774}\u{BBF8}\u{C9C0}\u{B97C} \u{CC3E}\u{C544}\u{BCF4}\u{C138}\u{C694}",use_code:"",cta:"\u{C774}\u{BBF8}\u{C9C0} \u{D30C}\u{C77C} \u{C694}\u{AE08}\u{C744} 25% \u{C544}\u{AEF4} \u{B4DC}\u{B9BD}\u{B2C8}\u{B2E4}",header2:"\u{C9C0}\u{AE08} \u{C774}\u{C6A9}\u{D558}\u{AE30}"},
			"espanol": {header1:"Encuentra la imagen perfecta",header2:"Ahorra 25% en elementos de imagen",use_code:"",cta:"Canjear Ahora"},
			"french": {header1:"Trouvez l\u{2019}image id\u{E9}ale",header2:"\u{C9}conomisez 25 % sur vos images",use_code:"",cta:"En profiter maintenant"},
			"portuguese": {header1:"Encontre a imagem perfeita",header2:"Poupe 25% em imagens",use_code:"",cta:"Obtenha agora"},
			"german": {header1:"Finden Sie das perfekte Bild",header2:"25 % bei Bildern sparen",use_code:"",cta:"Jetzt einl\u{F6}sen"},
			"dutch": {header1:"Vind de perfecte afbeelding",header2:"Bespaar 25% op afbeelding assets",use_code:"",cta:"Ontvang nu"},
			"japanese": {header1:"\u{6700}\u{9069}\u{306A}\u{753B}\u{50CF}\u{3092}\u{898B}\u{3064}\u{3051}\u{3066}\u{304F}\u{3060}\u{3055}\u{3044}",header2:"\u{753B}\u{50CF}\u{30A2}\u{30BB}\u{30C3}\u{30C8}\u{304C}25\u{FF05}\u{5F15}\u{304D}",use_code:"",cta:"\u{4ECA}\u{3059}\u{3050}\u{3054}\u{5229}\u{7528}\u{304F}\u{3060}\u{3055}\u{3044}"}
		};

		usi_app.message_images_tenpercent = {
			"english": {header1:"Find the perfect Image", header2:"SAVE 10%<br/>on image assets",use_code: "Use code",cta: "Redeem now"},
			"sichinese": {header1:"\u5206\u4EAB\u4F60\u7684\u989C\u8272",header2:"\u5728\u56DE\u9988\u7684\u540C\u65F6\u4EAB\u670975\u6298\u4F18\u60E0",use_code:"",cta:"\u5F00\u59CB"},
			"trchinese": {header1:"\u5206\u4EAB\u4F60\u7684\u984F\u8272",header2:"\u5728\u56DE\u994B\u7684\u540C\u6642\u4EAB\u670975\u6298\u512A\u60E0",use_code:"",cta:"\u958B\u59CB"},
			"czech": {header1:"Najd\u{11B}te perfektn\u{ED} sn\u{ED}mek",header2:"U\u{161}et\u{159}ete 10 % na sn\u{ED}mkov\u{FD}ch podkladech",use_code:"",cta:"Uplatnit nyn\u{ED}"},
			"danish": {header1:"Find det perfekte billede",header2:"Spar 10% p\u{E5} billedaktiver",use_code:"",cta:"Indl\u{F8}s nu"},
			"finland": {header1:"L\u{F6}yd\u{E4} t\u{E4}ydellinen kuva",header2:"S\u{E4}\u{E4}st\u{E4} 10 % kuvamateriaaleista",use_code:"",cta:"Lunasta Nyt"},
			"hungary": {header1:"Tal\u{E1}ld meg a t\u{F6}k\u{E9}letes k\u{E9}pet",header2:"Sp\u{F3}rolj 10%-ot a k\u{E9}pi elemeken",use_code:"",cta:"V\u{E1}ltsd be most"},
			"norway": {header1:"Finn det perfekte bildet",header2:"Spar 10 % p\u{E5} bilder og illustrasjoner",use_code:"",cta:"Aktiver tilbudet n\u{E5}"},
			"polish": {header1:"Znajd\u{17A} idealn\u{105} grafik\u{119}",header2:"Oszdz\u{119}d\u{17A} 10% na grafikach",use_code:"",cta:"Skorzystaj teraz"},
			"russia": {header1:"\u{41D}\u{430}\u{439}\u{434}\u{438} \u{438}\u{434}\u{435}\u{430}\u{43B}\u{44C}\u{43E}\u{435} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{435}",header2:"\u{421}\u{44D}\u{43A}\u{43E}\u{43D}\u{43E}\u{43C}\u{44C}\u{442}\u{435} 10% \u{43D}\u{430} \u{430}\u{43A}\u{442}\u{438}\u{432}\u{430}\u{445} \u{43F}\u{43E} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{44E}",use_code:"",cta:"\u{417}\u{430}\u{431}\u{435}\u{440}\u{438}\u{442}\u{435} \u{43F}\u{440}\u{44F}\u{43C}\u{43E} \u{441}\u{435}\u{439}\u{447}\u{430}\u{441}"},
			"sweden": {header1:"Hitta den perfekta bilden",header2:"10% rabatt p\u{E5} bildresurser",use_code:"",cta:"L\u{F6}s in nu"},
			"thai": {header1:"\u{E04}\u{E49}\u{E19}\u{E2B}\u{E32}\u{E20}\u{E32}\u{E1E}\u{E17}\u{E35}\u{E48}\u{E2A}\u{E21}\u{E1A}\u{E39}\u{E23}\u{E13}\u{E4C}\u{E41}\u{E1A}\u{E1A}",header2:"\u{E1B}\u{E23}\u{E30}\u{E2B}\u{E22}\u{E31}\u{E14} 10% \u{E2A}\u{E33}\u{E2B}\u{E23}\u{E31}\u{E1A}\u{E40}\u{E19}\u{E37}\u{E49}\u{E2D}\u{E2B}\u{E32}\u{E23}\u{E39}\u{E1B}\u{E20}\u{E32}\u{E1E}",use_code:"",cta:"\u{E1A}\u{E15}\u{E2D}\u{E19}\u{E19}\u{E35}\u{E49}"},
			"turkey": {header1:"M\u{FC}kemmel resmi bul",header2:"Resim \u{FC}r\u{FC}nlerinde % tasarruf",use_code:"",cta:"\u{15E}imdi Kullan"},
			"italian": {header1:"Trova l'immagine perfetta",header2:"Risparmia il 10% sulle immagini",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\u{C644}\u{BCBD}\u{D55C} \u{C774}\u{BBF8}\u{C9C0}\u{B97C} \u{CC3E}\u{C544}\u{BCF4}\u{C138}\u{C694}",use_code:"",cta:"\u{C774}\u{BBF8}\u{C9C0} \u{D30C}\u{C77C} \u{C694}\u{AE08}\u{C744} 10% \u{C544}\u{AEF4} \u{B4DC}\u{B9BD}\u{B2C8}\u{B2E4}",header2:"\u{C9C0}\u{AE08} \u{C774}\u{C6A9}\u{D558}\u{AE30}"},
			"espanol": {header1:"Encuentra la imagen perfecta",header2:"Ahorra 10% en elementos de imagen",use_code:"",cta:"Canjear Ahora"},
			"french": {header1:"Trouvez l\u{2019}image id\u{E9}ale",header2:"\u{C9}conomisez 10 % sur vos images",use_code:"",cta:"En profiter maintenant"},
			"portuguese": {header1:"Encontre a imagem perfeita",header2:"Poupe 10% em imagens",use_code:"",cta:"Obtenha agora"},
			"german": {header1:"Finden Sie das perfekte Bild",header2:"10 % bei Bildern sparen",use_code:"",cta:"Jetzt einl\u{F6}sen"},
			"dutch": {header1:"Vind de perfecte afbeelding",header2:"Bespaar 10% op afbeelding assets",use_code:"",cta:"Ontvang nu"},
			"japanese": {header1:"\u{6700}\u{9069}\u{306A}\u{753B}\u{50CF}\u{3092}\u{898B}\u{3064}\u{3051}\u{3066}\u{304F}\u{3060}\u{3055}\u{3044}",header2:"\u{753B}\u{50CF}\u{30A2}\u{30BB}\u{30C3}\u{30C8}\u{304C}10\u{FF05}\u{5F15}\u{304D}",use_code:"",cta:"\u{4ECA}\u{3059}\u{3050}\u{3054}\u{5229}\u{7528}\u{304F}\u{3060}\u{3055}\u{3044}"},
			"hindi": {header1:"\u092C\u093F\u0932\u094D\u0915\u0941\u0932 \u0938\u0939\u0940 \u0907\u092E\u0947\u091C \u0916\u094B\u091C\u0947\u0902",header2:"\u0907\u092E\u0947\u091C \u090F\u0938\u0947\u091F \u092A\u0930 10% \u0915\u0940 \u092C\u091A\u0924 \u0915\u0930\u0947\u0902",use_code:"",cta:"\u0905\u092D\u0940 \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u0947\u0902"},
			"tamil": {header1:"\u0BA4\u0BC1\u0BB3\u0BCD\u0BB3\u0BBF\u0BAF\u0BAE\u0BBE\u0BA9 \u0B87\u0BAE\u0BC7\u0B9C\u0BC8(\u0BAA\u0B9F\u0BAE\u0BCD) \u0B95\u0BA3\u0BCD\u0B9F\u0BC1\u0BAA\u0BBF\u0B9F\u0BC1\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",header2:"\u0B87\u0BAE\u0BC7\u0B9C\u0BCD \u0B85\u0BB8\u0BCD\u0BB8\u0BC6\u0B9F\u0BCD\u0B9F\u0BBF\u0BB2\u0BCD (\u0B9A\u0BC7\u0B95\u0BB0\u0BBF\u0BAA\u0BCD\u0BAA\u0BC1) 10% \u0B90 \u0B9A\u0BC7\u0BAE\u0BBF\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD",use_code:"",cta:"\u0B87\u0BAA\u0BCD\u0BAA\u0BCB\u0BA4\u0BC7 \u0BB0\u0BC0\u0B9F\u0BC0\u0BAE\u0BCD \u0B9A\u0BC6\u0BAF\u0BCD\u0BAF\u0BC1\u0B99\u0BCD\u0B95\u0BB3\u0BCD"},
			"telugu": {header1:"\u0C38\u0C30\u0C48\u0C28 \u0C1A\u0C3F\u0C24\u0C4D\u0C30\u0C3E\u0C28\u0C4D\u0C28\u0C3F \u0C15\u0C28\u0C41\u0C17\u0C4A\u0C28\u0C02\u0C21\u0C3F",header2:"\u0C1A\u0C3F\u0C24\u0C4D\u0C30 \u0C05\u0C38\u0C46\u0C1F\u0C4D\u0C38\u0C4D\u200C\u0C2A\u0C48 10% \u0C06\u0C26\u0C3E \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F",use_code:"",cta:"\u0C07\u0C2A\u0C4D\u0C2A\u0C41\u0C21\u0C47 \u0C30\u0C40\u0C21\u0C40\u0C2E\u0C4D \u0C1A\u0C47\u0C38\u0C41\u0C15\u0C4B\u0C02\u0C21\u0C3F"},
			"marathi": {header1:"\u092F\u094B\u0917\u094D\u092F \u0907\u092E\u0947\u091C \u0936\u094B\u0927\u093E",header2:"\u0907\u092E\u0947\u091C \u090F\u0938\u0947\u091F\u0935\u0930 10% \u092C\u091A\u0924 \u0915\u0930\u093E",use_code:"",cta:"\u0906\u0924\u093E \u0930\u093F\u0921\u0940\u092E \u0915\u0930\u093E"}
		};

		usi_app.message_video_sitewide = {
			"english": {header1:"Share your colors",header2:"Save 25% while also giving back ",use_code:"Use code ",cta:"Get started"},
			"sichinese": {header1:"\u6709\u5F71\u54CD\u529B\u7684\u89C6\u9891",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u89C6\u9891\u8BA2\u535525%\u7684\u6298\u6263",use_code:"",cta:"\u7ACB\u5373\u5151\u6362"},
			"trchinese": {header1:"\u6709\u5F71\u97FF\u529B\u7684\u8996\u983B",header2:"\u4ECA\u5929\u5C31\u53EF\u4EE5\u4EAB\u53D7\u8996\u983B\u8A02\u55AE25%\u7684\u6298\u6263",use_code:"",cta:"\u7ACB\u5373\u514C\u63DB"},
			"czech": {header1:"Videa, kter\u00E1 zap\u016Fsob\u00ED",header2:"Z\u00EDskejte 25% slevu na objedn\u00E1vku z\u00E1b\u011Br\u016F je\u0161t\u011B dnes",use_code:"",cta:"Uplatnit ihned"},
			"danish": {header1:"Videoer, der g\u00F8r indtryk",header2:"F\u00E5 25% i rabat p\u00E5 din bestilling af filmoptagelser i dag",use_code:"",cta:"ndl\u00F8s nu"},
			"finland": {header1:"Videoita, jotka tekev\u00E4t vaikutuksen",header2:"Saat 25 % alennuksen videomateriaalitilauksestasi t\u00E4n\u00E4\u00E4n",use_code:"",cta:"Lunasta nyt"},
			"hungary": {header1:"Vide\u00F3k, amelyek nagy hat\u00E1st gyakorolnak",header2:"25%-os engedm\u00E9ny a felv\u00E9telekb\u0151l ma",use_code:"",cta:"V\u00C1LTSA BE MOST"},
			"norway": {header1:"Videoer som gj\u00F8r inntrykk",header2:"F\u00E5 25 % rabatt p\u00E5 videobestillingen din i dag",use_code:"",cta:"L\u00F8s inn n\u00E5"},
			"polish": {header1:"Znajd\u017A idealn\u0105 muzyk\u0119",header2:"Zaoszcz\u0119d\u017A 25% na swoich utworach muzycznych ju\u017C dzi\u015B",use_code:"",cta:"SKORZYSTAJ TERAZ"},
			"russia": {header1:"\u0412\u0438\u0434\u0435\u043E, \u043A\u043E\u0442\u043E\u0440\u044B\u0435 \u043F\u0440\u043E\u0438\u0437\u0432\u043E\u0434\u044F\u0442 \u0432\u043F\u0435\u0447\u0430\u0442\u043B\u0435\u043D\u0438\u0435",header2:"25% \u0441\u043A\u0438\u0434\u043A\u0430 \u043D\u0430 \u0432\u044B\u0431\u0440\u0430\u043D\u043D\u044B\u0439 \u0432\u0430\u043C\u0438 \u0432\u0438\u0434\u0435\u043E\u0440\u044F\u0434 \u0441\u0435\u0433\u043E\u0434\u043D\u044F",use_code:"",cta:"\u0417\u0430\u0431\u0435\u0440\u0438\u0442\u0435 \u043F\u0440\u044F\u043C\u043E \u0441\u0435\u0439\u0447\u0430\u0441"},
			"sweden": {header1:"Videor som g\u00F6r ett intryck",header2:"F\u00E5 25% rabatt p\u00E5 din videobest\u00E4llning idag",use_code:"",cta:"Anv\u00E4nd nu"},
			"thai": {header1:"\u0E27\u0E34\u0E14\u0E35\u0E42\u0E2D\u0E17\u0E35\u0E48\u0E2A\u0E23\u0E49\u0E32\u0E07\u0E1C\u0E25\u0E01\u0E23\u0E30\u0E17\u0E1A",header2:"\u0E23\u0E31\u0E1A\u0E2A\u0E48\u0E27\u0E19\u0E25\u0E14 25% \u0E2A\u0E33\u0E2B\u0E23\u0E31\u0E1A\u0E01\u0E32\u0E23\u0E0B\u0E37\u0E49\u0E2D\u0E1F\u0E38\u0E15\u0E40\u0E17\u0E08\u0E27\u0E31\u0E19\u0E19\u0E35\u0E49",use_code:"",cta:"\u0E23\u0E31\u0E1A\u0E40\u0E25\u0E22\u0E15\u0E2D\u0E19\u0E19\u0E35\u0E49"},
			"turkey": {header1:"Ak\u0131llarda kalan videolar",header2:"Video sipari\u015Finde bug\u00FCn %25 indirim kazan",use_code:"",cta:"\u015Eimdi kullan"},
			"dutch": {header1:"Video's die impact maken",header2:"Ontvang vandaag 25% korting op uw beeldmateriaal bestelling",use_code:"",cta:"Ontvang nu"},
			"italian": {header1:"Video che lasciano il segno",header2:"Ricevi subito uno sconto del 25% sul tuo ordine di filmati",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\uD6A8\uACFC \uB9CC\uC810\uC758 \uB3D9\uC601\uC0C1\uC744 \uAD6C\uB9E4\uD558\uC138\uC694",header2:"\uC624\uB298 \uC8FC\uBB38\uD558\uBA74 25% \uD560\uC778",use_code:"",cta:"\uC9C0\uAE08 \uD61C\uD0DD\uBC1B\uAE30"},
			"espanol": {header1:"V\u00EDdeos que causan impacto",header2:"Consiga hoy 25% en su orden de v\u00EDdeo",use_code:"",cta:"Canjear ahora"},
			"french": {header1:"Des vid\u00E9os qui font de l\u2019effet",header2:"Profitez d\u00E8s aujourd\u2019hui de 25\u00A0% de r\u00E9duction sur vos vid\u00E9os",use_code:"",cta:"Profitez-en maintenant"},
			"portuguese": {header1:"Videos queles causam um impacto",header2:"Consigue 25 % de desconto de teu ordem de material hoje",use_code:"",cta:"Redimir agora"},
			"german": {header1:"Videos, die \u00FCberzeugen",header2:"Erhalten Sie heute 25\u00A0% Rabatt auf Ihr Bildmaterial",use_code:"",cta:"Jetzt einl\u00F6sen"}
		};

		usi_app.message_sitewide_20th = {
			"english": {header1:"Save 20% site wide",header2:"to celebrate 20 years of creativity.",use_code: "Use code",cta: "Redeem Now"},
			"sichinese": {header1:"\u5206\u4EAB\u4F60\u7684\u989C\u8272",header2:"\u5728\u56DE\u9988\u7684\u540C\u65F6\u4EAB\u670975\u6298\u4F18\u60E0",use_code:"",cta:"\u5F00\u59CB"},
			"trchinese": {header1:"\u5206\u4EAB\u4F60\u7684\u984F\u8272",header2:"\u5728\u56DE\u994B\u7684\u540C\u6642\u4EAB\u670975\u6298\u512A\u60E0",use_code:"",cta:"\u958B\u59CB"},
			"czech": {header1:"Najd\u{11B}te perfektn\u{ED} sn\u{ED}mek",header2:"U\u{161}et\u{159}ete 25 % na sn\u{ED}mkov\u{FD}ch podkladech",use_code:"",cta:"Uplatnit nyn\u{ED}"},
			"danish": {header1:"Find det perfekte billede",header2:"Spar 25% p\u{E5} billedaktiver",use_code:"",cta:"Indl\u{F8}s nu"},
			"finland": {header1:"L\u{F6}yd\u{E4} t\u{E4}ydellinen kuva",header2:"S\u{E4}\u{E4}st\u{E4} 25 % kuvamateriaaleista",use_code:"",cta:"Lunasta Nyt"},
			"hungary": {header1:"Tal\u{E1}ld meg a t\u{F6}k\u{E9}letes k\u{E9}pet",header2:"Sp\u{F3}rolj 25%-ot a k\u{E9}pi elemeken",use_code:"",cta:"V\u{E1}ltsd be most"},
			"norway": {header1:"Finn det perfekte bildet",header2:"Spar 25 % p\u{E5} bilder og illustrasjoner",use_code:"",cta:"Aktiver tilbudet n\u{E5}"},
			"polish": {header1:"Znajd\u{17A} idealn\u{105} grafik\u{119}",header2:"Oszdz\u{119}d\u{17A} 25% na grafikach",use_code:"",cta:"Skorzystaj teraz"},
			"russia": {header1:"\u{41D}\u{430}\u{439}\u{434}\u{438} \u{438}\u{434}\u{435}\u{430}\u{43B}\u{44C}\u{43E}\u{435} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{435}",header2:"\u{421}\u{44D}\u{43A}\u{43E}\u{43D}\u{43E}\u{43C}\u{44C}\u{442}\u{435} 25% \u{43D}\u{430} \u{430}\u{43A}\u{442}\u{438}\u{432}\u{430}\u{445} \u{43F}\u{43E} \u{438}\u{437}\u{43E}\u{431}\u{440}\u{430}\u{436}\u{435}\u{43D}\u{438}\u{44E}",use_code:"",cta:"\u{417}\u{430}\u{431}\u{435}\u{440}\u{438}\u{442}\u{435} \u{43F}\u{440}\u{44F}\u{43C}\u{43E} \u{441}\u{435}\u{439}\u{447}\u{430}\u{441}"},
			"sweden": {header1:"Hitta den perfekta bilden",header2:"25% rabatt p\u{E5} bildresurser",use_code:"",cta:"L\u{F6}s in nu"},
			"thai": {header1:"\u{E04}\u{E49}\u{E19}\u{E2B}\u{E32}\u{E20}\u{E32}\u{E1E}\u{E17}\u{E35}\u{E48}\u{E2A}\u{E21}\u{E1A}\u{E39}\u{E23}\u{E13}\u{E4C}\u{E41}\u{E1A}\u{E1A}",header2:"\u{E1B}\u{E23}\u{E30}\u{E2B}\u{E22}\u{E31}\u{E14} 25% \u{E2A}\u{E33}\u{E2B}\u{E23}\u{E31}\u{E1A}\u{E40}\u{E19}\u{E37}\u{E49}\u{E2D}\u{E2B}\u{E32}\u{E23}\u{E39}\u{E1B}\u{E20}\u{E32}\u{E1E}",use_code:"",cta:"\u{E1A}\u{E15}\u{E2D}\u{E19}\u{E19}\u{E35}\u{E49}"},
			"turkey": {header1:"M\u{FC}kemmel resmi bul",header2:"Resim \u{FC}r\u{FC}nlerinde % tasarruf",use_code:"",cta:"\u{15E}imdi Kullan"},
			"italian": {header1:"Trova l'immagine perfetta",header2:"Risparmia il 25% sulle immagini",use_code:"",cta:"Approfittane ora"},
			"korean": {header1:"\u{C644}\u{BCBD}\u{D55C} \u{C774}\u{BBF8}\u{C9C0}\u{B97C} \u{CC3E}\u{C544}\u{BCF4}\u{C138}\u{C694}",use_code:"",cta:"\u{C774}\u{BBF8}\u{C9C0} \u{D30C}\u{C77C} \u{C694}\u{AE08}\u{C744} 25% \u{C544}\u{AEF4} \u{B4DC}\u{B9BD}\u{B2C8}\u{B2E4}",header2:"\u{C9C0}\u{AE08} \u{C774}\u{C6A9}\u{D558}\u{AE30}"},
			"espanol": {header1:"Encuentra la imagen perfecta",header2:"Ahorra 25% en elementos de imagen",use_code:"",cta:"Canjear Ahora"},
			"french": {header1:"Trouvez l\u{2019}image id\u{E9}ale",header2:"\u{C9}conomisez 25 % sur vos images",use_code:"",cta:"En profiter maintenant"},
			"portuguese": {header1:"Encontre a imagem perfeita",header2:"Poupe 25% em imagens",use_code:"",cta:"Obtenha agora"},
			"german": {header1:"Finden Sie das perfekte Bild",header2:"25 % bei Bildern sparen",use_code:"",cta:"Jetzt einl\u{F6}sen"},
			"dutch": {header1:"Vind de perfecte afbeelding",header2:"Bespaar 25% op afbeelding assets",use_code:"",cta:"Ontvang nu"},
			"japanese": {header1:"\u{6700}\u{9069}\u{306A}\u{753B}\u{50CF}\u{3092}\u{898B}\u{3064}\u{3051}\u{3066}\u{304F}\u{3060}\u{3055}\u{3044}",header2:"\u{753B}\u{50CF}\u{30A2}\u{30BB}\u{30C3}\u{30C8}\u{304C}25\u{FF05}\u{5F15}\u{304D}",use_code:"",cta:"\u{4ECA}\u{3059}\u{3050}\u{3054}\u{5229}\u{7528}\u{304F}\u{3060}\u{3055}\u{3044}"}
		};

		usi_app.message_flex_images = {
			"english":{header1: "Get 10 free images now", listitem1: "Try the all-in-one plan for free", listitem2: "Pay just $29/mo after your trial ends", listitem3: "If you cancel in the 1st month you pay nothing!", cta_text: "Start your free trial"},
			"sichinese":{header1: "\u{7acb}\u{5373}\u{83b7}\u{5f97}\u{0031}\u{0030}\u{5f20}\u{514d}\u{8d39}\u{7684}\u{56fe}\u{50cf}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "", listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"trchinese":{header1: "\u{7acb}\u{5373}\u{83b7}\u{5f97}\u{0031}\u{0030}\u{5f20}\u{514d}\u{8d39}\u{7684}\u{56fe}\u{50cf}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "", listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"czech":{header1: "Z\u{00ED}skejte ihned 10 obr\u{00E1}zk\u{016F} zdarma", listitem1: "Vyzkou\u{0161}ejte zdarma pl\u{00E1}n v\u{0161}e v jednom", listitem2: "", listitem3: "Zru\u{0161}\u{00ED}te-li odb\u{011B}r b\u{011B}hem 1. m\u{011B}s\u{00ED}ce, neplat\u{00ED}te nic!", cta_text: "Spus\u{0165}te svou zku\u{0161}ebn\u{00ED} verzi zdarma"},
			"danish":{header1: "F\u{00E5} 10 gratis billeder nu", listitem1: "Pr\u{00F8}v alt-i-\u{00E9}n abonnementet gratis", listitem2: "", listitem3: "Hvis du afbestiller i den 1. m\u{00E5}ned, betaler du intet!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"finland":{header1: "Hanki nyt 10 ilmaista kuvaa.", listitem1: "Kokeile all-in-one suunnitelmaa ilmaiseksi.", listitem2: "", listitem3: "Jos perut tilauksen ensimm\u{00E4}isen kuukauden aikana, et maksa mit\u{00E4}\u{00E4}n!Hanki nyt 10 ilmaista kuvaa.", cta_text: "Aloita ilmainen kokeilujakso."},
			"hungary":{header1: "Kapj 10 ingyenes k\u{00E9}pet most", listitem1: "Pr\\u{00F3}b\\u{00E1}ld ki a mindent mag\\u{00E1}ban foglal\\u{00F3} csomagot ingyenesen", listitem2: "", listitem3: "Ha az els\\u{0151} h\\u{00F3}napban lemondod, nem fizetsz semmit!", cta_text: "Kezdd el el az ingyenes pr\u{00F3}baid\u{0151}szakot"},
			"norway":{header1: "F\u{00E5} 10 gratis bilder n\u{00E5}", listitem1: "Pr\u{00F8}v alt-i-ett-abonnementet gratis", listitem2: "", listitem3: "Hvis du kansellerer i l\u{00F8}pet av den f\u{00F8}rste m\u{00E5}neden betaler du ingenting!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"polish":{header1: "Pobierz 10 darmowych zdj\u{0119}\u{0107} teraz", listitem1: "Wypr\u{00F3}buj plan \u{201E}wszystko w jednym\u{201D} za darmo", listitem2: "", listitem3: "Je\u{015B}li zrezygnujesz w pierwszym miesi\u{0105}cu, nie zap\u{0142}acisz nic!", cta_text: "Rozpocznij darmowy okres pr\u{00F3}bny"},
			"russia":{header1: "\u{041F}\u{043E}\u{043B}\u{0443}\u{0447}\u{0438}\u{0442}\u{0435} \u{0441}\u{0440}\u{0430}\u{0437}\u{0443} 10 \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{044B}\u{0445} \u{0438}\u{0437}\u{043E}\u{0431}\u{0440}\u{0430}\u{0436}\u{0435}\u{043D}\u{0438}\u{0439}", listitem1: "\u{041F}\u{043E}\u{043F}\u{0440}\u{043E}\u{0431}\u{0443}\u{0439}\u{0442}\u{0435} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{0443}\u{044E} \u{0443}\u{043D}\u{0438}\u{0432}\u{0435}\u{0440}\u{0441}\u{0430}\u{043B}\u{044C}\u{043D}\u{0443}\u{044E} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443}", listitem2: "", listitem3: "\u{0415}\u{0441}\u{043B}\u{0438} \u{0432}\u{044B} \u{043E}\u{0442}\u{043C}\u{0435}\u{043D}\u{0438}\u{0442}\u{0435} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443} \u{0432} \u{0442}\u{0435}\u{0447}\u{0435}\u{043D}\u{0438}\u{0435} \u{043F}\u{0435}\u{0440}\u{0432}\u{043E}\u{0433}\u{043E} \u{043C}\u{0435}\u{0441}\u{044F}\u{0446}\u{0430}, \u{0442}\u{043E} \u{043D}\u{0438}\u{0447}\u{0435}\u{0433}\u{043E} \u{043D}\u{0435} \u{0437}\u{0430}\u{043F}\u{043B}\u{0430}\u{0442}\u{0438}\u{0442}\u{0435}!", cta_text: "\u{041D}\u{0430}\u{0447}\u{0430}\u{0442}\u{044C} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{044B}\u{0439} \u{043F}\u{0440}\u{043E}\u{0431}\u{043D}\u{044B}\u{0439} \u{043F}\u{0435}\u{0440}\u{0438}\u{043E}\u{0434} "},
			"sweden":{header1: "F\u{00E5} 10 gratis bilder nu", listitem1: "Prova allt-i-ett-planen gratis", listitem2: "", listitem3: "Om du s\u{00E4}ger upp dig under den f\u{00F6}rsta m\u{00E5}naden betalar du ingenting!", cta_text: "Starta din kostnadsfria provperiod"},
			"thai":{header1: "\u{0E23}\u{0E31}\u{0E1A}\u{0E20}\u{0E32}\u{0E1E}\u{0E1F}\u{0E23}\u{0E35} 10 \u{0E20}\u{0E32}\u{0E1E}\u{0E15}\u{0E2D}\u{0E19}\u{0E19}\u{0E35}\u{0E49}", listitem1: "\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E41}\u{0E1C}\u{0E19}\u{0E41}\u{0E1A}\u{0E1A}\u{0E04}\u{0E23}\u{0E1A}\u{0E43}\u{0E19}\u{0E2B}\u{0E19}\u{0E36}\u{0E48}\u{0E07}\u{0E40}\u{0E14}\u{0E35}\u{0E22}\u{0E27}\u{0E1F}\u{0E23}\u{0E35}", listitem2: "", listitem3: "\u{0E2B}\u{0E32}\u{0E01}\u{0E04}\u{0E38}\u{0E13}\u{0E22}\u{0E01}\u{0E40}\u{0E25}\u{0E34}\u{0E01}\u{0E43}\u{0E19}\u{0E40}\u{0E14}\u{0E37}\u{0E2D}\u{0E19}\u{0E41}\u{0E23}\u{0E01} \u{0E04}\u{0E38}\u{0E13}\u{0E08}\u{0E30}\u{0E44}\u{0E21}\u{0E48}\u{0E15}\u{0E49}\u{0E2D}\u{0E07}\u{0E08}\u{0E48}\u{0E32}\u{0E22}\u{0E2D}\u{0E30}\u{0E44}\u{0E23}\u{0E40}\u{0E25}\u{0E22}!", cta_text: "\u{0E40}\u{0E23}\u{0E34}\u{0E48}\u{0E21}\u{0E01}\u{0E32}\u{0E23}\u{0E17}\u{0E14}\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E1F}\u{0E23}\u{0E35}\u{0E02}\u{0E2D}\u{0E07}\u{0E04}\u{0E38}\u{0E13}"},
			"turkey":{header1: "\u{015E}imdi 10 \u{00FC}cretsiz resim al\u{0131}n", listitem1: "Hepsi bir arada plan\u{0131} \u{00FC}cretsiz deneyin", listitem2: "", listitem3: "\u{0130}lk ayda iptal ederseniz hi\u{00E7}bir \u{015F}ey \u{00F6}demezsiniz!", cta_text: "\u{00DC}cretsiz denemeyi ba\u{015F}la"},
			"italian":{header1: "Ricevi subito 10 immagini gratis", listitem1: "Prova gratis il piano tutto compreso", listitem2: "", listitem3: "Se cancelli il primo mese non paghi nulla!", cta_text: "Inizia una prova gratuita"},
			"korean":{header1: "\u{BB34}\u{B8CC}\u{C774}\u{BBF8}\u{C9C0} 10\u{AC1C} \u{C9C0}\u{AE08} \u{B2E4}\u{C6B4}\u{B85C}\u{B4DC}", listitem1: "\u{C62C}\u{C778}\u{C6D0} \u{C694}\u{AE08}\u{C81C}\u{B97C} \u{BB34}\u{B8CC}\u{B85C} \u{C774}\u{C6A9}", listitem2: "", listitem3: "\u{CCAB} \u{B2EC} \u{CDE8}\u{C18C} \u{C2DC} \u{C694}\u{AE08}\u{C774} \u{BD80}\u{ACFC}\u{B418}\u{C9C0} \u{C54A}\u{C74C}!", cta_text: "\u{BB34}\u{B8CC} \u{D3C9}\u{AC00}\u{D310} \u{C2DC}\u{C791}\u{D558}\u{AE30}"},
			"espanol":{header1: "Consigue ahora 10 im\u{00E1}genes gratis", listitem1: "Prueba gratis el plan todo en uno", listitem2: "", listitem3: "\u{00A1}Si cancelas durante el primer mes, no pagas nada!", cta_text: "Comienza tu prueba gratis"},
			"french":{header1: "Profitez de 10 images gratuites sans plus attendre", listitem1: "Essayez gratuitement l\u{2019}abonnement tout-en-un", listitem2: "", listitem3: "Si vous r\u{00E9}siliez au cours du 1er mois, vous n\u{2019}avez rien \u{00E0} payer !", cta_text: "Commencer votre essai gratuit"},
			"portuguese":{header1: "Obtenha 10 imagens gratuitas agora", listitem1: "Experimente gratuitamente o plano tudo-em-um", listitem2: "", listitem3: "Se cancelar no 1.\u{00BA} m\u{00EA}s n\u{00E3}o paga nada!", cta_text: "Inicie o seu per\u{00ED}odo de teste gratuito"},
			"german":{header1: "Erhalten Sie jetzt 10 kostenlose Bilder ", listitem1: "Testen Sie den umfassenden Plan kostenlos.", listitem2: "", listitem3: "Wenn Sie im ersten Monat k\u{00FC}ndigen, zahlen Sie nichts.", cta_text: "Kostenlosen Test jetzt beginnen"},
			"dutch":{header1: "Ontvang nu 10 gratis afbeeldingen", listitem1: "Probeer het alles-in-1 abonnement gratis", listitem2: "", listitem3: "Als je in de 1e maand opzegt, betaal je niets!", cta_text: "Start uw gratis proefperiode"},
			"japanese":{header1: "\u{4ECA}\u{3059}\u{3050}10\u{70B9}\u{306E}\u{7121}\u{6599}\u{753B}\u{50CF}\u{7D20}\u{6750}\u{3092}\u{30B2}\u{30C3}\u{30C8}", listitem1: "\u{30AA}\u{30FC}\u{30EB}\u{30A4}\u{30F3}\u{30EF}\u{30F3}\u{306E}\u{5B9A}\u{984D}\u{30D7}\u{30E9}\u{30F3}\u{3092}\u{7121}\u{6599}\u{3067}\u{304A}\u{8A66}\u{3057}\u{304F}\u{3060}\u{3055}\u{3044}", listitem2: "", listitem3: "\u{6700}\u{521D}\u{306E}1\u{304B}\u{6708}\u{306E}\u{9593}\u{306B}\u{30AD}\u{30E3}\u{30F3}\u{30BB}\u{30EB}\u{3059}\u{308C}\u{3070}\u{6599}\u{91D1}\u{306F}\u{767A}\u{751F}\u{3057}\u{307E}\u{305B}\u{3093}", cta_text: "\u{7121}\u{6599}\u{30C8}\u{30E9}\u{30A4}\u{30A2}\u{30EB}\u{3092}\u{4ECA}\u{3059}\u{3050}\u{59CB}\u{3081}\u{308B}"}
		};

		usi_app.message_flex_videos = {
			"english":{header1: "Get 1 free video now", listitem1: "Try the all-in-one plan for free", listitem2: "Pay just $29/mo after your trial ends", listitem3: "If you cancel in the 1st month you pay nothing!", cta_text: "Start your free trial"},
			"sichinese":{header1: "\u{7acb}\u{5373}\u{83b7}\u{53d6}\u{4e00}\u{90e8}\u{514d}\u{8d39}\u{89c6}\u{9891}\u{000d}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "",listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"trchinese":{header1: "\u{7acb}\u{5373}\u{7372}\u{5f97}\u{4e00}\u{90e8}\u{514d}\u{8cbb}\u{5f71}\u{7247}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "",listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"czech":{header1: "Z\u{00ED}skejte nyn\u{00ED} 1 video zdarma", listitem1: "Vyzkou\u{0161}ejte zdarma pl\u{00E1}n v\u{0161}e v jednom", listitem2: "",listitem3: "Zru\u{0161}\u{00ED}te-li odb\u{011B}r b\u{011B}hem 1. m\u{011B}s\u{00ED}ce, neplat\u{00ED}te nic!", cta_text: "Spus\u{0165}te svou zku\u{0161}ebn\u{00ED} verzi zdarma"},
			"danish":{header1: "F\u{00E5} 1 gratis video nu", listitem1: "Pr\u{00F8}v alt-i-\u{00E9}n abonnementet gratis", listitem2: "",listitem3: "Hvis du afbestiller i den 1. m\u{00E5}ned, betaler du intet!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"finland":{header1: "Saat heti 1 ilmaisen videon", listitem1: "Kokeile all-in-one suunnitelmaa ilmaiseksi.", listitem2: "",listitem3: "Jos perut tilauksen ensimm\u{00E4}isen kuukauden aikana, et maksa mit\u{00E4}\u{00E4}n!Hanki nyt 10 ilmaista kuvaa.", cta_text: "Aloita ilmainen kokeilujakso."},
			"hungary":{header1: "Kapj 1 ingyenes vide\u{00F3}t most", listitem1: "Pr\u{00F3}b\u{00E1}ld ki a mindent mag\u{00E1}ban foglal\u{00F3} csomagot ingyenesen", listitem2: "", listitem3: "Ha az els\u{0151} h\u{00F3}napban lemondod, nem fizetsz semmit!", cta_text: "Kezdd el el az ingyenes pr\u{00F3}baid\u{0151}szakot"},
			"norway":{header1: "F\u{00E5} 1 gratis video n\u{00E5}", listitem1: "Pr\u{00F8}v alt-i-ett-abonnementet gratis", listitem2: "",listitem3: "Hvis du kansellerer i l\u{00F8}pet av den f\u{00F8}rste m\u{00E5}neden betaler du ingenting!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"polish":{header1: "Otrzymaj 1 darmowe wideo ju\u{017C} teraz", listitem1: "Wypr\u{00F3}buj plan \u{201E}wszystko w jednym\u{201D} za darmo", listitem2: "",listitem3: "Je\u{015B}li zrezygnujesz w pierwszym miesi\u{0105}cu, nie zap\u{0142}acisz nic!", cta_text: "Rozpocznij darmowy okres pr\u{00F3}bny"},
			"russia":{header1: "\u{041F}\u{043E}\u{043B}\u{0443}\u{0447}\u{0438}\u{0442}\u{0435} \u{043E}\u{0434}\u{043D}\u{043E} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{043E}\u{0435} \u{0432}\u{0438}\u{0434}\u{0435}\u{043E} \u{043F}\u{0440}\u{044F}\u{043C}\u{043E} \u{0441}\u{0435}\u{0439}\u{0447}\u{0430}\u{0441}", listitem1: "\u{041F}\u{043E}\u{043F}\u{0440}\u{043E}\u{0431}\u{0443}\u{0439}\u{0442}\u{0435} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{0443}\u{044E} \u{0443}\u{043D}\u{0438}\u{0432}\u{0435}\u{0440}\u{0441}\u{0430}\u{043B}\u{044C}\u{043D}\u{0443}\u{044E} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443}", listitem2: "", listitem3: "\u{0415}\u{0441}\u{043B}\u{0438} \u{0432}\u{044B} \u{043E}\u{0442}\u{043C}\u{0435}\u{043D}\u{0438}\u{0442}\u{0435} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443} \u{0432} \u{0442}\u{0435}\u{0447}\u{0435}\u{043D}\u{0438}\u{0435} \u{043F}\u{0435}\u{0440}\u{0432}\u{043E}\u{0433}\u{043E} \u{043C}\u{0435}\u{0441}\u{044F}\u{0446}\u{0430}, \u{0442}\u{043E} \u{043D}\u{0438}\u{0447}\u{0435}\u{0433}\u{043E} \u{043D}\u{0435} \u{0437}\u{0430}\u{043F}\u{043B}\u{0430}\u{0442}\u{0438}\u{0442}\u{0435}!", cta_text: "\u{041D}\u{0430}\u{0447}\u{0430}\u{0442}\u{044C} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{044B}\u{0439} \u{043F}\u{0440}\u{043E}\u{0431}\u{043D}\u{044B}\u{0439} \u{043F}\u{0435}\u{0440}\u{0438}\u{043E}\u{0434} "},
			"sweden":{header1: "F\u{00E5} 1 gratis video nu", listitem1: "Prova allt-i-ett-planen gratis", listitem2: "", listitem3: "Om du s\u{00E4}ger upp dig under den f\u{00F6}rsta m\u{00E5}naden betalar du ingenting!", cta_text: "Starta din kostnadsfria provperiod"},
			"thai":{header1: "\u{0E23}\u{0E31}\u{0E1A}\u{0E27}\u{0E34}\u{0E14}\u{0E35}\u{0E42}\u{0E2D}\u{0E1F}\u{0E23}\u{0E35} 1 \u{0E23}\u{0E32}\u{0E22}\u{0E01}\u{0E32}\u{0E23}\u{0E15}\u{0E2D}\u{0E19}\u{0E19}\u{0E35}\u{0E49}", listitem1: "\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E41}\u{0E1C}\u{0E19}\u{0E41}\u{0E1A}\u{0E1A}\u{0E04}\u{0E23}\u{0E1A}\u{0E43}\u{0E19}\u{0E2B}\u{0E19}\u{0E36}\u{0E48}\u{0E07}\u{0E40}\u{0E14}\u{0E35}\u{0E22}\u{0E27}\u{0E1F}\u{0E23}\u{0E35}", listitem2: "",listitem3: "\u{0E2B}\u{0E32}\u{0E01}\u{0E04}\u{0E38}\u{0E13}\u{0E22}\u{0E01}\u{0E40}\u{0E25}\u{0E34}\u{0E01}\u{0E43}\u{0E19}\u{0E40}\u{0E14}\u{0E37}\u{0E2D}\u{0E19}\u{0E41}\u{0E23}\u{0E01} \u{0E04}\u{0E38}\u{0E13}\u{0E08}\u{0E30}\u{0E44}\u{0E21}\u{0E48}\u{0E15}\u{0E49}\u{0E2D}\u{0E07}\u{0E08}\u{0E48}\u{0E32}\u{0E22}\u{0E2D}\u{0E30}\u{0E44}\u{0E23}\u{0E40}\u{0E25}\u{0E22}!", cta_text: "\u{0E40}\u{0E23}\u{0E34}\u{0E48}\u{0E21}\u{0E01}\u{0E32}\u{0E23}\u{0E17}\u{0E14}\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E1F}\u{0E23}\u{0E35}\u{0E02}\u{0E2D}\u{0E07}\u{0E04}\u{0E38}\u{0E13}"},
			"turkey":{header1: "\u{015E}imdi 1 \u{00FC}cretsiz video al", listitem1: "Hepsi bir arada plan\u{0131} \u{00FC}cretsiz deneyin", listitem2: "",listitem3: "\u{0130}lk ayda iptal ederseniz hi\u{00E7}bir \u{015F}ey \u{00F6}demezsiniz!", cta_text: "\u{00DC}cretsiz denemeyi ba\u{015F}la"},
			"italian":{header1: "Ricevi subito 1 video gratuito", listitem1: "Prova gratis il piano tutto compreso", listitem2: "",listitem3: "Se cancelli il primo mese non paghi nulla!", cta_text: "Inizia una prova gratuita"},
			"korean":{header1: "\u{BB34}\u{B8CC} \u{C601}\u{C0C1} 1\u{AC1C} \u{BC1B}\u{AE30}", listitem1: "\u{C62C}\u{C778}\u{C6D0} \u{C694}\u{AE08}\u{C81C}\u{B97C} \u{BB34}\u{B8CC}\u{B85C} \u{C774}\u{C6A9}", listitem2: "",listitem3: "\u{CCAB} \u{B2EC} \u{CDE8}\u{C18C} \u{C2DC} \u{C694}\u{AE08}\u{C774} \u{BD80}\u{ACFC}\u{B418}\u{C9C0} \u{C54A}\u{C74C}!", cta_text: "\u{BB34}\u{B8CC} \u{D3C9}\u{AC00}\u{D310} \u{C2DC}\u{C791}\u{D558}\u{AE30}"},
			"espanol":{header1: "Consigue ahora 1 video gratis", listitem1: "Prueba gratis el plan todo en uno", listitem2: "",listitem3: "\u{00A1}Si cancelas durante el primer mes, no pagas nada!", cta_text: "Comienza tu prueba gratis"},
			"french":{header1: "Obtenez 1 vid\u{00E9}o gratuite sans plus attendre", listitem1: "Essayez gratuitement l\u{2019}abonnement tout-en-un", listitem2: "",listitem3: "Si vous r\u{00E9}siliez au cours du 1er mois, vous n\u{2019}avez rien \u{00E0} payer !", cta_text: "Commencer votre essai gratuit"},
			"portuguese":{header1: "Obtenha 1 v\u{00ED}deo gratuito agora", listitem1: "Experimente gratuitamente o plano tudo-em-um", listitem2: "",listitem3: "Se cancelar no 1.\u{00BA} m\u{00EA}s n\u{00E3}o paga nada!", cta_text: "Inicie o seu per\u{00ED}odo de teste gratuito"},
			"german":{header1: "Erhalten Sie ein kostenloses Video", listitem1: "Testen Sie den umfassenden Plan kostenlos.", listitem2: "",listitem3: "Wenn Sie im ersten Monat k\u{00FC}ndigen, zahlen Sie nichts.", cta_text: "Kostenlosen Test jetzt beginnen"},
			"dutch":{header1: "Ontvang nu 1 gratis video", listitem1: "Probeer het alles-in-1 abonnement gratis", listitem2: "",listitem3: "Als je in de 1e maand opzegt, betaal je niets!", cta_text: "Start uw gratis proefperiode"},
			"japanese":{header1: "\u{7121}\u{6599}\u{753B}\u{50CF}\u{3092}1\u{70B9}\u{4ECA}\u{3059}\u{3050}\u{30B2}\u{30C3}\u{30C8}", listitem1: "\u{30AA}\u{30FC}\u{30EB}\u{30A4}\u{30F3}\u{30EF}\u{30F3}\u{306E}\u{5B9A}\u{984D}\u{30D7}\u{30E9}\u{30F3}\u{3092}\u{7121}\u{6599}\u{3067}\u{304A}\u{8A66}\u{3057}\u{304F}\u{3060}\u{3055}\u{3044}", listitem2: "",listitem3: "\u{6700}\u{521D}\u{306E}1\u{304B}\u{6708}\u{306E}\u{9593}\u{306B}\u{30AD}\u{30E3}\u{30F3}\u{30BB}\u{30EB}\u{3059}\u{308C}\u{3070}\u{6599}\u{91D1}\u{306F}\u{767A}\u{751F}\u{3057}\u{307E}\u{305B}\u{3093}", cta_text: "\u{7121}\u{6599}\u{30C8}\u{30E9}\u{30A4}\u{30A2}\u{30EB}\u{3092}\u{4ECA}\u{3059}\u{3050}\u{59CB}\u{3081}\u{308B}"}
		};

		usi_app.message_flex_music = {
			"english":{header1: "Get 2 free music tracks now", listitem1: "Try the all-in-one plan for free", listitem2: "Pay just $29/mo after your trial ends", listitem3: "If you cancel in the 1st month you pay nothing!", cta_text: "Start your free trial"},
			"sichinese":{header1: "\u{7acb}\u{5373}\u{83b7}\u{53d6}\u{4e24}\u{9996}\u{514d}\u{8d39}\u{97f3}\u{4e50}\u{6b4c}\u{66f2}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "",listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"trchinese":{header1: "\u{7acb}\u{5373}\u{83b7}\u{53d6}\u{4e24}\u{9996}\u{514d}\u{8d39}\u{97f3}\u{4e50}\u{6b4c}\u{66f2}", listitem1: "\u{514d}\u{8d39}\u{8bd5}\u{7528}\u{5168}\u{529f}\u{80fd}\u{7684}\u{65b9}\u{6848}", listitem2: "",listitem3: "\u{5047}\u{5982}\u{60a8}\u{5728}\u{7b2c}\u{4e00}\u{4e2a}\u{6708}\u{53d6}\u{6d88}\u{ff0c}\u{4e0d}\u{7528}\u{4ed8}\u{4efb}\u{4f55}\u{8d39}\u{7528}\u{0021}", cta_text: "\u{5f00}\u{59cb}\u{60a8}\u{7684}\u{514d}\u{8d39}\u{8bd5}\u{7528}"},
			"czech":{header1: "Z\u{00ED}skejte nyn\u{00ED} 2 hudebn\u{00ED} skladby zdarma", listitem1: "Vyzkou\u{0161}ejte zdarma pl\u{00E1}n v\u{0161}e v jednom", listitem2: "",listitem3: "Zru\u{0161}\u{00ED}te-li odb\u{011B}r b\u{011B}hem 1. m\u{011B}s\u{00ED}ce, neplat\u{00ED}te nic!", cta_text: "Spus\u{0165}te svou zku\u{0161}ebn\u{00ED} verzi zdarma"},
			"danish":{header1: "F\u{00E5} 2 gratis musiknumre nu", listitem1: "Pr\u{00F8}v alt-i-\u{00E9}n abonnementet gratis", listitem2: "",listitem3: "Hvis du afbestiller i den 1. m\u{00E5}ned, betaler du intet!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"finland":{header1: "Saat heti 2 ilmaista musiikkikappaletta", listitem1: "Kokeile all-in-one suunnitelmaa ilmaiseksi.", listitem2: "",listitem3: "Jos perut tilauksen ensimm\u{00E4}isen kuukauden aikana, et maksa mit\u{00E4}\u{00E4}n!Hanki nyt 10 ilmaista kuvaa.", cta_text: "Aloita ilmainen kokeilujakso."},
			"hungary":{header1: "Kapj 2 ingyenes zenesz\u{00E1}mot most", listitem1: "Pr\u{00F3}b\u{00E1}ld ki a mindent mag\u{00E1}ban foglal\u{00F3} csomagot ingyenesen",listitem2: "", listitem3: "Ha az els\u{0151} h\u{00F3}napban lemondod, nem fizetsz semmit!", cta_text: "Kezdd el el az ingyenes pr\u{00F3}baid\u{0151}szakot"},
			"norway":{header1: "F\u{00E5} 2 gratis musikkfiler n\u{00E5}", listitem1: "Pr\u{00F8}v alt-i-ett-abonnementet gratis", listitem2: "",listitem3: "Hvis du kansellerer i l\u{00F8}pet av den f\u{00F8}rste m\u{00E5}neden betaler du ingenting!", cta_text: "Start din gratis pr\u{00F8}veperiode"},
			"polish":{header1: "Otrzymaj 2 darmowe utwory muzyczne ju\u{017C} teraz", listitem1: "Wypr\u{00F3}buj plan \u{201E}wszystko w jednym\u{201D} za darmo", listitem2: "",listitem3: "Je\u{015B}li zrezygnujesz w pierwszym miesi\u{0105}cu, nie zap\u{0142}acisz nic!", cta_text: "Rozpocznij darmowy okres pr\u{00F3}bny"},
			"russia":{header1: "\u{041F}\u{043E}\u{043B}\u{0443}\u{0447}\u{0438}\u{0442}\u{0435} \u{0434}\u{0432}\u{0430} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{044B}\u{0445} \u{043C}\u{0443}\u{0437}\u{044B}\u{043A}\u{0430}\u{043B}\u{044C}\u{043D}\u{044B}\u{0445} \u{0442}\u{0440}\u{0435}\u{043A}\u{043E}\u{0432} \u{043F}\u{0440}\u{044F}\u{043C}\u{043E} \u{0441}\u{0435}\u{0439}\u{0447}\u{0430}\u{0441}", listitem1: "\u{041F}\u{043E}\u{043F}\u{0440}\u{043E}\u{0431}\u{0443}\u{0439}\u{0442}\u{0435} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{0443}\u{044E} \u{0443}\u{043D}\u{0438}\u{0432}\u{0435}\u{0440}\u{0441}\u{0430}\u{043B}\u{044C}\u{043D}\u{0443}\u{044E} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443}", listitem2: "",listitem3: "\u{0415}\u{0441}\u{043B}\u{0438} \u{0432}\u{044B} \u{043E}\u{0442}\u{043C}\u{0435}\u{043D}\u{0438}\u{0442}\u{0435} \u{043F}\u{043E}\u{0434}\u{043F}\u{0438}\u{0441}\u{043A}\u{0443} \u{0432} \u{0442}\u{0435}\u{0447}\u{0435}\u{043D}\u{0438}\u{0435} \u{043F}\u{0435}\u{0440}\u{0432}\u{043E}\u{0433}\u{043E} \u{043C}\u{0435}\u{0441}\u{044F}\u{0446}\u{0430}, \u{0442}\u{043E} \u{043D}\u{0438}\u{0447}\u{0435}\u{0433}\u{043E} \u{043D}\u{0435} \u{0437}\u{0430}\u{043F}\u{043B}\u{0430}\u{0442}\u{0438}\u{0442}\u{0435}!", cta_text: "\u{041D}\u{0430}\u{0447}\u{0430}\u{0442}\u{044C} \u{0431}\u{0435}\u{0441}\u{043F}\u{043B}\u{0430}\u{0442}\u{043D}\u{044B}\u{0439} \u{043F}\u{0440}\u{043E}\u{0431}\u{043D}\u{044B}\u{0439} \u{043F}\u{0435}\u{0440}\u{0438}\u{043E}\u{0434} "},
			"sweden":{header1: "F\u{00E5} 2 gratis musiksp\u{00E5}r nu", listitem1: "Prova allt-i-ett-planen gratis", listitem2: "",listitem3: "Om du s\u{00E4}ger upp dig under den f\u{00F6}rsta m\u{00E5}naden betalar du ingenting!", cta_text: "Starta din kostnadsfria provperiod"},
			"thai":{header1: "\u{0E23}\u{0E31}\u{0E1A}\u{0E41}\u{0E17}\u{0E23}\u{0E47}\u{0E01}\u{0E40}\u{0E1E}\u{0E25}\u{0E07}\u{0E1F}\u{0E23}\u{0E35} 2 \u{0E23}\u{0E32}\u{0E22}\u{0E01}\u{0E32}\u{0E23}\u{0E15}\u{0E2D}\u{0E19}\u{0E19}\u{0E35}\u{0E49}", listitem1: "\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E41}\u{0E1C}\u{0E19}\u{0E41}\u{0E1A}\u{0E1A}\u{0E04}\u{0E23}\u{0E1A}\u{0E43}\u{0E19}\u{0E2B}\u{0E19}\u{0E36}\u{0E48}\u{0E07}\u{0E40}\u{0E14}\u{0E35}\u{0E22}\u{0E27}\u{0E1F}\u{0E23}\u{0E35}", listitem2: "",listitem3: "\u{0E2B}\u{0E32}\u{0E01}\u{0E04}\u{0E38}\u{0E13}\u{0E22}\u{0E01}\u{0E40}\u{0E25}\u{0E34}\u{0E01}\u{0E43}\u{0E19}\u{0E40}\u{0E14}\u{0E37}\u{0E2D}\u{0E19}\u{0E41}\u{0E23}\u{0E01} \u{0E04}\u{0E38}\u{0E13}\u{0E08}\u{0E30}\u{0E44}\u{0E21}\u{0E48}\u{0E15}\u{0E49}\u{0E2D}\u{0E07}\u{0E08}\u{0E48}\u{0E32}\u{0E22}\u{0E2D}\u{0E30}\u{0E44}\u{0E23}\u{0E40}\u{0E25}\u{0E22}!", cta_text: "\u{0E40}\u{0E23}\u{0E34}\u{0E48}\u{0E21}\u{0E01}\u{0E32}\u{0E23}\u{0E17}\u{0E14}\u{0E25}\u{0E2D}\u{0E07}\u{0E43}\u{0E0A}\u{0E49}\u{0E1F}\u{0E23}\u{0E35}\u{0E02}\u{0E2D}\u{0E07}\u{0E04}\u{0E38}\u{0E13}"},
			"turkey":{header1: "\u{015E}imdi 2 \u{00FC}cretsiz \u{015F}ark\u{0131} al", listitem1: "Hepsi bir arada plan\u{0131} \u{00FC}cretsiz deneyin", listitem2: "",listitem3: "\u{0130}lk ayda iptal ederseniz hi\u{00E7}bir \u{015F}ey \u{00F6}demezsiniz!", cta_text: "\u{00DC}cretsiz denemeyi ba\u{015F}la"},
			"italian":{header1: "Ricevi subito 2 brani musicali gratuity", listitem1: "Prova gratis il piano tutto compreso", listitem2: "",listitem3: "Se cancelli il primo mese non paghi nulla!", cta_text: "Inizia una prova gratuita"},
			"korean":{header1: "\u{BB34}\u{B8CC} \u{C74C}\u{C6D0} 2\u{AC1C} \u{BC1B}\u{AE30}", listitem1: "\u{C62C}\u{C778}\u{C6D0} \u{C694}\u{AE08}\u{C81C}\u{B97C} \u{BB34}\u{B8CC}\u{B85C} \u{C774}\u{C6A9}", listitem2: "",listitem3: "\u{CCAB} \u{B2EC} \u{CDE8}\u{C18C} \u{C2DC} \u{C694}\u{AE08}\u{C774} \u{BD80}\u{ACFC}\u{B418}\u{C9C0} \u{C54A}\u{C74C}!", cta_text: "\u{BB34}\u{B8CC} \u{D3C9}\u{AC00}\u{D310} \u{C2DC}\u{C791}\u{D558}\u{AE30}"},
			"espanol":{header1: "Consigue ahora 2 pistas de m\u{00FA}sica gratis", listitem1: "Prueba gratis el plan todo en uno", listitem2: "",listitem3: "\u{00A1}Si cancelas durante el primer mes, no pagas nada!", cta_text: "Comienza tu prueba gratis"},
			"french":{header1: "Obtenez 2 morceaux de musique sans plus attendre", listitem1: "Essayez gratuitement l\u{2019}abonnement tout-en-un", listitem2: "",listitem3: "Si vous r\u{00E9}siliez au cours du 1er mois, vous n\u{2019}avez rien \u{00E0} payer !", cta_text: "Commencer votre essai gratuit"},
			"portuguese":{header1: "Obtenha 2 faixas de m\u{00FA}sica gratuitas agora", listitem1: "Experimente gratuitamente o plano tudo-em-um", listitem2: "",listitem3: "Se cancelar no 1.\u{00BA} m\u{00EA}s n\u{00E3}o paga nada!", cta_text: "Inicie o seu per\u{00ED}odo de teste gratuito"},
			"german":{header1: "Erhalten Sie zwei kostenlose Tracks", listitem1: "Testen Sie den umfassenden Plan kostenlos.", listitem2: "",listitem3: "Wenn Sie im ersten Monat k\u{00FC}ndigen, zahlen Sie nichts.", cta_text: "Kostenlosen Test jetzt beginnen"},
			"dutch":{header1: "Ontvang nu 2 gratis muziek tracks", listitem1: "Probeer het alles-in-1 abonnement gratis", listitem2: "",listitem3: "Als je in de 1e maand opzegt, betaal je niets!", cta_text: "Start uw gratis proefperiode"},
			"japanese":{header1: "\u{7121}\u{6599}\u{97F3}\u{697D}\u{30C8}\u{30E9}\u{30C3}\u{30AF}\u{3092}2\u{70B9}\u{4ECA}\u{3059}\u{3050}\u{30B2}\u{30C3}\u{30C8}", listitem1: "\u{30AA}\u{30FC}\u{30EB}\u{30A4}\u{30F3}\u{30EF}\u{30F3}\u{306E}\u{5B9A}\u{984D}\u{30D7}\u{30E9}\u{30F3}\u{3092}\u{7121}\u{6599}\u{3067}\u{304A}\u{8A66}\u{3057}\u{304F}\u{3060}\u{3055}\u{3044}", listitem2: "",listitem3: "\u{6700}\u{521D}\u{306E}1\u{304B}\u{6708}\u{306E}\u{9593}\u{306B}\u{30AD}\u{30E3}\u{30F3}\u{30BB}\u{30EB}\u{3059}\u{308C}\u{3070}\u{6599}\u{91D1}\u{306F}\u{767A}\u{751F}\u{3057}\u{307E}\u{305B}\u{3093}", cta_text: "\u{7121}\u{6599}\u{30C8}\u{30E9}\u{30A4}\u{30A2}\u{30EB}\u{3092}\u{4ECA}\u{3059}\u{3050}\u{59CB}\u{3081}\u{308B}"}
		};



		usi_app.message_test_lang = {
			"english":{header1: "Get 2 free music tracks now", listitem1: "Try the all-in-one plan for free", listitem2: "Pay just $29/mo after your trial ends", listitem3: "If you cancel in the 1st month you pay nothing!", cta_text: "Start your free trial"},
			"french":{header1: "Get 2 free music tracks now", listitem1: "Try the all-in-one plan for free", listitem2: "Pay just $29/mo after your trial ends", listitem3: "If you cancel in the 1st month you pay nothing!", cta_text: "Start your free trial"},
		};

		usi_app.get_campaign_details = function(campaign, user_type) {
			var site_id = '';
			var site_key = '';
			var split_test_id = null;

			switch(campaign) {
				case 'premium_content':
					site_key = "95qymT2qSO29TZzflWhPlS9";
					site_id = "56039";
					break;
				case 'tenpercent_precart_images':
					switch (user_type) {
						case 'new':
							site_key = "s5dd5HVOolQktwbCp6oU8WS";
							site_id = "54483";
							break;
						case 'extension':
							site_key = "XAz4xesssWFVF88Fq3DsEMj";
							site_id = "54495";
							split_test_id = "54541";
							break;
						case 'reconversion':
							site_key = "dsX2kMOHWtVqGnVMaOgNCRf";
							site_id = "54507";
							split_test_id = "54553";
							break;
						default:
							site_key = "NUqqoRwwRYghS7ZenwlRRQX";
							site_id = "52759";
							break;
					}
					break;

				case 'tenpercent_activecart_images':
					switch (user_type) {
						case 'new':
							site_key = "ojQfvkEcgRVqVGFcyAKkFrd";
							site_id = "54481";
							break;
						case 'extension':
							site_key = "AGjzEAdz71Zz8PsYmHE995g";
							site_id = "54493";
							split_test_id = "54539";
							break;
						case 'reconversion':
							site_key = "HYRqXEQrHpZvanZsQDE3z2C";
							site_id = "54505";
							split_test_id = "54551";
							break;
						default:
							site_key = "7Iu6eQsC9zgaDfH3giUCiQP";
							site_id = "52761";
							break;
					}
					break;

				case 'tenpercent_precart_video':
					switch (user_type) {
						case 'new':
							site_key = "U8O5j2L2BKjdScXDZFhalTS";
							site_id = "54487";
							break;
						case 'extension':
							site_key = "MUicoakEoti3jZb2tcHvBp1";
							site_id = "54499";
							split_test_id = "54545";
							break;
						case 'reconversion':
							site_key = "FKK9TfRDj58bRtqdoOOeEWX";
							site_id = "54511";
							split_test_id = "54557"
							break;
						default:
							site_key = "NUqqoRwwRYghS7ZenwlRRQX";
							site_id = "52759";
							break;
					}
					break;

				case 'tenpercent_activecart_video':
					switch (user_type) {
						case 'new':
							site_key = "CnjSw0IXmgvmzAHtR4Wd6Wg";
							site_id = "54485";
							break;
						case 'extension':
							site_key = "XC7JJ0UKyH3VYw8DLSt9VkG";
							site_id = "54497";
							split_test_id = "54543";
							break;
						case 'reconversion':
							site_key = "5Srma0zuwGGnyiGcvlSIwQM";
							site_id = "54509";
							split_test_id = "54555";
							break;
						default:
							site_key = "7Iu6eQsC9zgaDfH3giUCiQP";
							site_id = "52761";
							break;
					}
					break;

				case 'tenpercent_precart_music':
					switch (user_type) {
						case 'new':
							site_key = "xInOwwQhrfQESPLSQP06HNA";
							site_id = "54491";
							break;
						case 'extension':
							site_key = "ItDpp6P20npW4fmHDtLPIf2";
							site_id = "54503";
							split_test_id = "54549";
							break;
						case 'reconversion':
							site_key = "TqHnXRHRwaaoMQkXiLVyZFt";
							site_id = "54515";
							split_test_id = "54561";
							break;
						default:
							site_key = "NUqqoRwwRYghS7ZenwlRRQX";
							site_id = "52759";
							break;
					}
					break;

				case 'tenpercent_activecart_music':
					switch (user_type) {
						case 'new':
							site_key = "6jd0tFqeGqg6C3hpt2cHeIo";
							site_id = "54489";
							break;
						case 'extension':
							site_key = "s9vMMi5gWdUbJMWlw9xGgSN";
							site_id = "54501";
							split_test_id = "54547";
							break;
						case 'reconversion':
							site_key = "IJJEKrffcAEsui06AyA7Atx";
							site_id = "54513";
							split_test_id = "54559";
							break;
						default:
							site_key = "7Iu6eQsC9zgaDfH3giUCiQP";
							site_id = "52761";
							break;
					}
					break;
				default:

					break;
			}

			usi_commons.log("usi_app.get_campaign_details() - " + user_type + " / " + campaign + " / " + split_test_id)
			usi_commons.log("   :: returning - " + site_id + " / " + site_key)

			return {
				site_id: site_id,
				site_key: site_key,
				split_test_id: split_test_id
			}
		}

		usi_app.is_video = function() {
			try {
				if (location.href.indexOf("/video/") != -1 || location.href.indexOf("/video") != -1) return true;
				if (window.dataLayer != undefined) {
					for (var i=0; i<dataLayer.length; i++) {
						if (typeof(dataLayer[i].products) !== "undefined") {
							for (var j=0; j < dataLayer[i].products.length; j++) {
								if (dataLayer[i].products[j].type == "videos") {
									return true;
								}
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.to_unicode = function (txt) {
			try {
				function dec2hex4(textString) {
					var hexequiv = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
					return hexequiv[(textString >> 12) & 0xF] + hexequiv[(textString >> 8) & 0xF] +
							hexequiv[(textString >> 4) & 0xF] + hexequiv[textString & 0xF];
				}

				function convertCharStr2jEsc(str) {
					// Converts a string of characters to JavaScript escapes
					// str: sequence of Unicode characters
					var highsurrogate = 0;
					var suppCP;
					var pad;
					var n = 0;
					var outputString = '';
					for (var i = 0; i < str.length; i++) {
						var cc = str.charCodeAt(i);
						if (cc < 0 || cc > 0xFFFF) {
							outputString += '!Error in convertCharStr2UTF16: unexpected charCodeAt result, cc=' + cc + '!';
						}
						if (highsurrogate != 0) { // this is a supp char, and cc contains the low surrogate
							if (0xDC00 <= cc && cc <= 0xDFFF) {
								suppCP = 0x10000 + ((highsurrogate - 0xD800) << 10) + (cc - 0xDC00);
								suppCP -= 0x10000;
								outputString += '\\u' + dec2hex4(0xD800 | (suppCP >> 10)) + '\\u' + dec2hex4(0xDC00 | (suppCP & 0x3FF));
								highsurrogate = 0;
								continue;
							} else {
								outputString += 'Error in convertCharStr2UTF16: low surrogate expected, cc=' + cc + '!';
								highsurrogate = 0;
							}
						}
						if (0xD800 <= cc && cc <= 0xDBFF) { // start of supplementary character
							highsurrogate = cc;
						} else { // this is a BMP character
							//outputString += dec2hex(cc) + ' ';
							switch (cc) {
								case 0:
									outputString += '\\0';
									break;
								case 8:
									outputString += '\\b';
									break;
								case 9:
									outputString += '\t';
									break;
								case 10:
									outputString += '\n';
									break;
								case 13:
									outputString += '\\r';
									break;
								case 11:
									outputString += '\\v';
									break;
								case 12:
									outputString += '\\f';
									break;
								case 34:
									outputString += '"';
									break;
								case 39:
									outputString += '\'';
									break;
								case 92:
									outputString += '\\\\';
									break;
								default:
									if (cc > 0x1f && cc < 0x7F) {
										outputString += String.fromCharCode(cc)
									} else {
										pad = cc.toString(16).toUpperCase();
										while (pad.length < 4) {
											pad = '0' + pad;
										}
										outputString += '\\u{' + pad + '}'
									}
							}
						}
					}
					return outputString;
				}

				return convertCharStr2jEsc(txt);
			} catch (e) {
				alert(e);
			}
		};

		usi_app.is_music = function() {
			try {
				if (location.href.indexOf("/music") != -1) return true;
				if (window.dataLayer != undefined) {
					for (var i = 0; i < dataLayer.length; i++) {
						if (typeof (dataLayer[i].products) !== "undefined") {
							for (var j = 0; j < dataLayer[i].products.length; j++) {
								if (dataLayer[i].products[j].type == "music") {
									return true;
								}
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.is_image = function() {
			try {
				if (location.href.indexOf("/images") != -1 || location.href.indexOf("/image-photo/") != -1 || location.href.indexOf("/image-illustration/") != -1
					|| location.href.indexOf("/vectors") != -1 || location.href.indexOf("/image-vector/") != -1
					|| location.href.indexOf("/offset") != -1 || location.href.indexOf("/photos") != -1
					|| location.href.indexOf("/featured-collections") != -1 || location.href.indexOf("/photos") != -1
					|| location.href.indexOf("?image_type=") != -1 || location.href.indexOf("/category/") != -1
					|| (location.href.indexOf("/editorial/") != -1 && location.href.indexOf("video") == -1)
					|| location.href.indexOf("/explore/royalty-free-images") != -1
					|| (location.href.indexOf("/pricing") != -1 && location.href.indexOf("/pricing/video") == -1 && location.href.indexOf("/pricing/music") == -1 && location.href.indexOf("/pricing/editorial") == -1 && location.href.indexOf("/pricing/creative-flow") == -1) )return true;

				if (window.dataLayer != undefined) {
					for (var i = 0; i < dataLayer.length; i++) {
						if (typeof (dataLayer[i].productFamily) !== "undefined") {
							if (dataLayer[i].productFamily == "Monthly Subscription" || dataLayer[i].productFamily == "On Demand Subscription") {
								return true;
							}
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.save_cart = function(){
			try {
				usi_commons.log("usi_app.save_cart()");
				var cart_prefix = "usi_prod_";
				usi_cookies.flush("usi_subtotal");
				usi_cookies.flush("usi_sale_notes");
				usi_cookies.flush(cart_prefix);
				usi_app.cart = {
					items: usi_app.scrape_cart(),
					subtotal: usi_app.scrape_subtotal()
				}
				usi_commons.log(usi_app.cart);

				if (typeof usi_app.cart.items != "undefined" && typeof usi_app.cart.subtotal != "undefined") {
					usi_cookies.set("usi_subtotal", usi_app.cart.subtotal, usi_cookies.expire_time.week);
					usi_app.cart.items.forEach(function(product, index){
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(cart_prefix + prop + "_" + (index + 1), product[prop], usi_cookies.expire_time.week);
							}
						}
					});

					if (usi_cookies.value_exists("usi_cart_count")) {
						usi_cookies.del("usi_cart_count");
					}
					usi_cookies.set("usi_cart_count", usi_app.cart.items.length, usi_cookies.expire_time.week);

					var order_summary = usi_app.scrape_order_summary();
					if(order_summary) {
						usi_cookies.set('usi_sale_notes', order_summary, usi_cookies.expire_time.week)
					}

				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_order_summary = function() {
			try {
				var order_data = []

				if(usi_app.is_cart_page) {


					// Video count
				  document.querySelector('[data-automation="CartSummaryItem_Video]') != null ? order_data.push(document.querySelector('[data-automation="Upsell_videoUpsell_container"] h6').textContent) : false;
					document.querySelector('[data-automation="CartSummaryItem_Video"] [class*=Summary]') != null ? order_data.push(document.querySelector('[data-automation="CartSummaryItem_Video"] [class*=Summary]').textContent) : false // new cart flow

				  // Image count
				  document.querySelector('[data-automation="Upsell_offsetUpsell_container"] h6') != null ? order_data.push(document.querySelector('[data-automation="Upsell_offsetUpsell_container"] h6').textContent) : false;
					document.querySelector('[data-automation="CartSummaryItem_Image"] [class*=Summary]') != null ? order_data.push(document.querySelector('[data-automation="CartSummaryItem_Image"] [class*=Summary]').textContent) : false // new cart flow

					// Music count
					document.querySelector('[data-automation="Upsell_musicUpsell_container"] h6') != null ? order_data.push(document.querySelector('[data-automation="Upsell_musicUpsell_container"] h6').textContent) : false;
					document.querySelector('[data-automation="CartSummaryItem_Music"] [class*=Summary]') != null ? order_data.push(document.querySelector('[data-automation="CartSummaryItem_Music"] [class*=Summary]').textContent) : false // new cart flow
				}

				if(usi_app.is_checkout_page) {
					document.querySelector('[data-automation*="subscriptionOrderItem"] strong') != null ? order_data.push(document.querySelector('[data-automation*="subscriptionOrderItem"] strong').textContent) : false;
					if(order_data && order_data.join('|').indexOf('Subscription')) {
						usi_cookies.set('usi_sale_notes', order_data.join('|'), usi_cookies.expire_time.week)
					}
				}

				return order_data.join('|');
			} catch(err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.scrape_subtotal = function() {
			try {
				var subtotal = document.querySelector('[data-automation="Upsell_estimatedTotal_value"]') ? document.querySelector('[data-automation="Upsell_estimatedTotal_value"]') : document.querySelector('[data-automation="CartEstimatedTotal_Value"]');
				if (subtotal != null) {
					subtotal = subtotal.textContent.replace(/[^0-9.]/g, '');
					usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week);
					return subtotal.replace(/[^0-9.]/g, '');
				}
				var subtotal = document.querySelector("div[data-automation='CompleteCheckout_totalPrice_div']");
				if (subtotal != null) {
					subtotal = subtotal.textContent.replace(/[^0-9.]/g, '');
					usi_cookies.set("usi_subtotal", subtotal, usi_cookies.expire_time.week);
					return subtotal.replace(/[^0-9.]/g, '');
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function() {
			try {
				usi_commons.log("usi_app.scrape_cart()")

				var cart_items = usi_dom.get_elements('[data-automation="CartBasket_itemsList_div"] [data-automation="ItemCard_container_div"]')

				if(cart_items.length == 0) {
					cart_items = usi_dom.get_elements('[data-automation="CartItemsList"] li')
				}

				return cart_items.map(function(container){
					var product = {};
					if (container.querySelector("a")) {
						product.link = container.querySelector("a").href;
						product.pid = product.link.substring(product.link.lastIndexOf("/") + 1);
					}

					var cart_item_name = container.querySelector('[data-automation="CartItem_Title"]') ? container.querySelector('[data-automation="CartItem_Title"]') : container.querySelector('[data-automation="ItemCard_header_title"]');

					if (cart_item_name != null) {
						product.name = cart_item_name.textContent.trim();

						var cart_item_type = container.querySelector('[class*="cartAssetFormat"]')

						if (cart_item_type.textContent.toLowerCase().includes('wav')) {
							product.type = "music";
						} else if (cart_item_type.textContent.toLowerCase().includes('mov')) {
							product.type = "video";
						}
					}

					if (container.querySelector("a img") != null) {
						product.image = container.querySelector("a img").src;
					} else if (product.type == "music") {
						product.image = usi_commons.domain+"/chatskins/5698/music-image.png";
					}
					if (container.querySelector('[data-automation="ItemCard_price"]') != null) {
						product.price = usi_dom.string_to_decimal(container.querySelector('[data-automation="ItemCard_price"]').textContent.trim());
					} else if (container.querySelector('[data-automation="CartItem_Price"]') != null) {
						product.price = usi_dom.string_to_decimal(container.querySelector('[data-automation="CartItem_Price"]').textContent.trim());
					}

					return product;
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.apply_coupon = function() {
			try {
				usi_commons.log("usi_app.apply_coupon()");

				var coupon_input = document.querySelector("#couponCode");

				if(!coupon_input) {
					coupon_input = document.querySelector("input[name='couponCode']")
				}

				var coupon_button = document.querySelector("[data-automation='coupon-handleApply']");

				var open_dialog_button = document.querySelector('button[data-automation="coupon-haveCouponCode"]')

				if(!coupon_input && !coupon_button && open_dialog_button != null) {
					// Open the dialog box, try again
					open_dialog_button.click();
					setTimeout(function(){
						usi_app.apply_coupon();
					},1000)
				}


				if (coupon_input !== null && coupon_button !== null) {
					// Register something
					var customEvent = new Event('input', { bubbles: true});
					var lastValue = coupon_input.value;
					customEvent.simulated = true;
					coupon_input.value = usi_app.coupon;
					coupon_input.defaultValue = usi_app.coupon;
					var tracker = coupon_input._valueTracker;
					if (tracker) {
						tracker.setValue(lastValue);
					}
					coupon_input.dispatchEvent(customEvent);
					usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week);
					usi_cookies.del("usi_coupon");
					usi_app.coupon = "";
					coupon_button.disabled = false;
					coupon_button.click();
					usi_commons.log("Coupon applied");
					usi_app.boostbar.close();
				} else {
					usi_commons.log("[ error ] * * * Coupon Input not found");
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.boostbar = {
			load: function(){
				usi_commons.log("usi_app.boostbar.load()");
				if (usi_cookies.get("usi_boostbar") == "closed") return;

				var usi_boost_css = [
					'#usi_boost_close {height:100%; width:5%; right:5%; top:0; bottom:0; position:absolute; color:rgba(12,18,28,.87); font-size:2em; text-decoration:none;}',
					'#usi_boost_container {position:fixed; bottom:0; left:0; right:0; width:100%; text-align:center; font-size:1.25em; background:#fff; color:rgba(12,18,28,.87); padding:1em 2.5em; line-height: 1; z-index:2147483647;box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.33);}'
				].join('');
				usi_app.boostbar.place_css(usi_boost_css);

				var usi_boost_container = document.createElement('div');
				usi_boost_container.innerHTML = [
					'<div id="usi_boost_container">',
					'<a id="usi_boost_close" href="javascript:usi_app.boostbar.close();">&times;</a>',
					'Your coupon will be applied at checkout!',
					'</div>'
				].join('');
				document.body.appendChild(usi_boost_container);
			},
			place_css:function(css) {
				usi_commons.log("usi_app.boostbar.place_css()");
				var usi_css = document.createElement("style");
				usi_css.type = "text/css";
				if (usi_css.styleSheet) usi_css.styleSheet.cssText = css;
				else usi_css.innerHTML = css;
				document.getElementsByTagName('head')[0].appendChild(usi_css);
			},
			close: function(){
				usi_commons.log("usi_app.boostbar.close()");
				var bar = document.getElementById('usi_boost_container');
				usi_cookies.set("usi_boostbar", "closed", usi_cookies.expire_time.week);
				if (bar != null) {
					bar.parentNode.removeChild(bar);
				}
			}
		};
		usi_app.check_sub_total_price = function(check_price){

			var return_check = false;

			if(!usi_app.is_flexable){
				return false;
			}
			if(usi_cookies.value_exists('usi_subtotal')){
				return_check = Number(usi_cookies.get("usi_subtotal")) <= check_price
			}else {
				return_check = usi_app.price_cart == null || (usi_app.price_cart != null && Number(usi_app.price_cart.sub_total) <= check_price)
			}

			return return_check;
		};
		usi_app.check_flex_account_page = function(){
			return usi_app.is_create_account_page && usi_app.has_flex_account_page && (!usi_app.user_status || usi_app.user_status == 'undefined')
		};
		usi_app.get_order_info = function (property) {
			try {
				if (window.dataLayer != undefined) {
					for (var i in dataLayer) {
						if (dataLayer[i]["page"] != undefined && dataLayer[i]["page"].hasOwnProperty(property)) {
							return dataLayer[i]["page"][property] === "en";
						}
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};
		usi_app.get_user_status = function (property) {
			try {
				if (window.dataLayer != undefined) {
					for (var i in dataLayer) {
						if (dataLayer[i][property] != undefined) {
							return dataLayer[i][property];
						}
					}
				}
				return {};
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.user_data = function() {
			try {
				var user_data = "";
				if (window.dataLayer != undefined) {
					for (var i = 0; i < window.dataLayer.length; i++) {
						if (typeof(window.dataLayer[i].user) != "undefined") {
							user_data = JSON.stringify(dataLayer[i].user);
						}
					}
				}
				if (usi_cookies.get("usi_reported") == null || usi_cookies.get("usi_reported") != user_data.length) {
					usi_cookies.set("usi_reported", user_data.length, 24*60*60);
					//usi_analytics.send_page_hit("VIEW", "5698", "&user=" + encodeURIComponent(user_data));
					return true;
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
			return false;
		};

		usi_app.check_for_change = function(){
			try {
				if (usi_app.current_page == undefined || usi_app.current_page != location.href) {
					usi_commons.log("USI: check for change");
					usi_app.current_page = location.href;
					usi_app.main();
					usi_commons.log("USI: running main");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_ajax_cart = function(){
			usi_app.get_listen("https://www.shutterstock.com/napi/cart?application-namespace=sstk_cart&include=items%2Citems.product", usi_app.handle_ajax_response);
		}

		usi_app.get_listen = function(url, callback) {
			try {
				var options = {
					url: url,
				}
				usi_commons.log("usi_app.get_listen()");
				if (!usi_app.ajax) usi_app.ajax = {};
				usi_app.ajax[url] = new usi_ajax.get_with_options(options, callback);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.is_json = function(str) {
			try {
				JSON.parse(str);
			} catch(err) {
				return false
			}
			return true;
		};
		usi_app.handle_ajax_response = function(err, response) {
			try {
				usi_commons.log("usi_app.handle_ajax_response()");
				if (usi_app.is_json(response.responseText)) {
					var data = JSON.parse(response.responseText);
					if (data.included) {
						// Handle response
						var price_items = [];
						var cart_items = [];
						for (var i = 0; i < data.included.length; i++) {
							var item = data.included[i];
							var item_type = item.type;
							if (item_type == 'cart-items') {
								var cart_item = {};
								var item_id = item.id;
								var price_id = item.relationships.product.data.id;
								cart_item.item_id = item_id;
								cart_item.price_id = price_id;
								cart_items.push(cart_item);
							} else if (item_type == 'products') {
								var product_item = {};
								var product_id = item.id;
								var business_unit = item.attributes.businessUnit;
								var product_price = item.attributes.price;
								product_item.product_id = product_id;
								product_item.business_unit = business_unit;
								product_item.product_price = product_price;
								price_items.push(product_item);
							}
						}
						usi_app.price_cart = usi_app.build_price_chart(cart_items, price_items);
						usi_app.load();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.post_listen = function(url, callback) {
			try {
				usi_commons.log("usi_app.post_listen()");
				if (!usi_app.ajax) usi_app.ajax = {};
				usi_app.ajax[url] = new usi_ajax.listener();
				usi_app.ajax[url].register('POST', url, callback);
				usi_app.ajax[url].listen();
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.handle_ajax_response2 = function(err, response) {
			try {
				usi_commons.log("usi_app.handle_ajax_response2()");
				if (err) {
					return usi_commons.report_error(err);
				} else if (!response || !response.responseText || !usi_app.is_json(response.responseText)) {
					return usi_commons.report_error('Incorrect response');
				}
				var data = JSON.parse(response.responseText);
				usi_app.get_ajax_cart();
				// Handle response
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.build_price_chart = function(cart_items,price_items){
			usi_commons.log(cart_items);
			usi_commons.log(price_items);
			var price_cart = {};
			price_cart.items = [];
			price_cart.sub_total = 0;
			for(var i = 0; i < price_items.length; i++){
				var price_item = price_items[i];
				var price_cart_item = {};
				price_cart_item.id = price_item.product_id;
				price_cart_item.unit_price = price_item.product_price;
				price_cart_item.count = 0;
				price_cart_item.sub_total = 0;
				for(var e = 0; e < cart_items.length; e++){
					var cart_item = cart_items[e];
					if(cart_item.price_id == price_item.product_id){
						price_cart_item.count++;
					}
				}
				price_cart_item.sub_total = price_cart_item.unit_price * price_cart_item.count;
				price_cart.sub_total = price_cart.sub_total + price_cart_item.sub_total;
				price_cart.items.push(price_cart_item);
			}
			usi_commons.log(price_cart);
			return price_cart;
		}


		usi_app.session_data_callback = function() {
			usi_commons.log("usi_app.session_data_callback()");
			usi_dom.ready(function () {
				try {
					if (usi_commons.device != "mobile") {
						usi_app.country = usi_app.session_data.country;
						usi_app.force_country = usi_commons.gup_or_get_cookie('usi_force_country');
						if (usi_app.force_country != "") {
							usi_app.country = usi_app.force_country;
						}
						usi_app.suppress_app = usi_commons.gup_or_get_cookie("usi_suppress_app", usi_cookies.expire_time.minute, true) != "";
						if (usi_app.suppress_app) {
							usi_commons.log('[ usi_dom.ready ] Suppressing app file!');
						} else {
							setInterval(usi_app.check_for_change, 900);
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			});
		};
		usi_commons.load_session_data();

		usi_app.setup_listener = function(url, callback) {
			usi_commons.log("setup_listener.setup_listener()");
			usi_app.ajaxListener = new usi_ajax.listener();
			usi_app.ajaxListener.register('POST', url, callback);
			usi_app.ajaxListener.listen();
		};

		usi_app.handle_ajax_response3 = function(err, response) {
			usi_commons.log("usi_app.handle_ajax_response()");
			if (response && response.requestObj) {
				var request_url = response.requestObj.url + " " + response.requestObj.params;
				usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?shutterstock_impact=" + encodeURIComponent(request_url));
			} else {
				usi_commons.report_error(err);
			}
		};

		usi_app.setup_listener("https://shutterstock.7eer.net/xconv/3030/1305", usi_app.handle_ajax_response3);

	} catch(err) {
		usi_commons.report_error(err);
	}
}