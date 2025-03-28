if("undefined"==typeof usi_cookies){if(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,i,n){try{var t=-1;if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t=r.getTime()}var o=window.top||window,l=0;null!=i&&-1!=i.indexOf("=")&&(i=i.replace(RegExp("=","g"),"USIEQLS")),null!=i&&-1!=i.indexOf(";")&&(i=i.replace(RegExp(";","g"),"USIPRNS"));for(var a=o.name.split(";"),u="",f=0;f<a.length;f++){var c=a[f].split("=");3==c.length?(c[0]==e&&(c[1]=i,c[2]=t,l=1),null!=c[1]&&"null"!=c[1]&&(u+=c[0]+"="+c[1]+"="+c[2]+";")):""!=a[f]&&(u+=a[f]+";")}0==l&&(u+=e+"="+i+"="+t+";"),o.name=u}catch(s){}},flush_window_name:function(e){try{for(var i=window.top||window,n=i.name.split(";"),t="",r=0;r<n.length;r++){var o=n[r].split("=");3==o.length&&(0==o[0].indexOf(e)||(t+=n[r]+";"))}i.name=t}catch(l){}},get_from_window_name:function(e){try{for(var i,n,t=(window.top||window).name.split(";"),r=0;r<t.length;r++){var o=t[r].split("=");if(3==o.length){if(o[0]==e&&(n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),!("-1"!=o[2]&&0>usi_cookies.datediff(o[2]))))return i=[n,o[2]]}else if(2==o.length&&o[0]==e)return n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),i=[n,new Date().getTime()+6048e5]}}catch(l){}return null},datediff:function(e){return e-new Date().getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),i=e[e.length-1];if("com"==i||"net"==i||"org"==i||"us"==i||"co"==i||"ca"==i)return e[e.length-2]+"."+e[e.length-1]}catch(n){}return 0==document.domain.indexOf("www.")?document.domain.replace("www.",""):document.domain},create_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(i)+t+"; path=/;domain="+l+"; "+o}},create_nonencoded_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled&&void 0===window.usi_nocookies){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();document.cookie=e+"="+i+t+"; path=/;domain="+location.host+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain="+l+"; "+o,document.cookie=e+"="+i+t+"; path=/;domain=; "+o}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var i=e+"=",n=[];try{n=document.cookie.split(";")}catch(t){}for(var r=0;r<n.length;r++){for(var o=n[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(i))return decodeURIComponent(o.substring(i.length,o.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(i){}},get_ls:function(e){try{var i=localStorage.getItem(e);if(null!=i){if(0==i.indexOf("{")&&-1!=i.indexOf("usi_expires")){var n=JSON.parse(i);if(new Date().getTime()>n.usi_expires)return localStorage.removeItem(e),null;i=n.value}return decodeURIComponent(i)}}catch(t){}return null},get:function(e){var i=usi_cookies.read_cookie(e);if(null!=i)return i;try{if(null!=localStorage&&(i=usi_cookies.get_ls(e),null!=i))return i;if(null!=sessionStorage&&(i=sessionStorage.getItem(e),void 0===i&&(i=null),null!=i))return decodeURIComponent(i)}catch(n){}var t=usi_cookies.get_from_window_name(e);if(null!=t&&t.length>1)try{i=decodeURIComponent(t[0])}catch(r){return t[0]}return i},get_json:function(e){var i=null,n=usi_cookies.get(e);if(null==n)return null;try{i=JSON.parse(n)}catch(t){n=n.replace(/\\"/g,'"');try{i=JSON.parse(JSON.parse(n))}catch(r){try{i=JSON.parse(n)}catch(o){}}}return i},search_cookies:function(e){e=e||"";var i=[];return document.cookie.split(";").forEach(function(n){var t=n.split("=")[0].trim();(""===e||0===t.indexOf(e))&&i.push(t)}),i},set:function(e,i,n,t){"undefined"!=typeof usi_nevercookie&&!0==usi_nevercookie&&(t=!1),void 0===n&&(n=-1);try{i=i.replace(/(\r\n|\n|\r)/gm,"")}catch(r){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",i+"",n);try{if(n>0&&null!=localStorage){var o=new Date,l={value:i,usi_expires:o.getTime()+1e3*n};localStorage.setItem(e,JSON.stringify(l))}else null!=sessionStorage&&sessionStorage.setItem(e,i)}catch(a){}if(t||null==i){if(null!=i){if(null==usi_cookies.read_cookie(e)&&!t&&usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count){usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);return}if(i.length>usi_cookies.max_cookie_length){usi_cookies.report_error('Cookie "'+e+'" truncated ('+i.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length);return}}usi_cookies.create_cookie(e,i,n)}},set_json:function(e,i,n,t){var r=JSON.stringify(i).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,r,n,t)},flush:function(e){e=e||"usi_";var i,n,t,r=document.cookie.split(";");for(i=0;i<r.length;i++)0==(n=r[i]).trim().toLowerCase().indexOf(e)&&(t=n.trim().split("=")[0],usi_cookies.del(t));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var o in localStorage)0==o.indexOf(e)&&localStorage.removeItem(o);if(null!=sessionStorage)for(var o in sessionStorage)0==o.indexOf(e)&&sessionStorage.removeItem(o)}catch(l){}},print:function(){for(var e=document.cookie.split(";"),i="",n=0;n<e.length;n++){var t=e[n];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(t.trim())+" (cookie)"),i+=","+t.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&"string"==typeof localStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+usi_cookies.get_ls(r)+" (localStorage)"),i+=","+r+",");if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&"string"==typeof sessionStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+sessionStorage[r]+" (sessionStorage)"),i+=","+r+",")}catch(o){}for(var l=(window.top||window).name.split(";"),a=0;a<l.length;a++){var u=l[a].split("=");if(3==u.length&&0==u[0].indexOf("usi_")&&-1==i.indexOf(","+u[0]+",")){var f=u[1];-1!=f.indexOf("USIEQLS")&&(f=f.replace(/USIEQLS/g,"=")),-1!=f.indexOf("USIPRNS")&&(f=f.replace(/USIPRNS/g,";")),console.log(u[0]+"="+f+" (window.name)"),i+=","+t.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,i;for(e=0;e<arguments.length;e++)if(i=usi_cookies.get(arguments[e]),""===i||null===i||"null"===i||"undefined"===i)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie)try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-new Date().getTime())/1e3,!0),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}-1!=location.href.indexOf("usi_clearcookies")&&usi_cookies.flush()}
if (typeof usi_js === 'undefined') {
	usi_js = {
		campaign: {
			id: '9283021349176857368468',
			site_id: 54483,
			original_site_id: 54483,
			config_id: 123735,
			company_id: 5698,
			key: 'desktop_english',
			link: '',
			deep_link: 'https://shutterstock.7eer.net/c/16669/42913/1305?sharedid=10EvergreenStatic&url=',
			domains: '',
			host: usi_commons.domain,
			images: usi_commons.cdn,
			launch_cookie: 1209600,
			click_cookie: 1209600,
			sale_window: 1209600,
			force_load: (location.href.indexOf('usi_force=') !== -1 || typeof usi_force !== 'undefined'),
			email_id: '0',
			coupon: 'USF10OFF',
			reuse_coupon: false,
			cookie_append: ''
		},
		launch: {
			enabled: true,
			suppress: false,
			sales_suppression: false,
			launched: false,
			launch_methods: '1,',
			confirm_msg: "",
			suppress_on_back: 0,
			launch_delay: 0,
			content_start: 150,
			exit_area: 20,
			speed_upward: 750,
			time_above_y: 500,
			time_hover_requirement: 1000,
			any_trajectory: 0,
			no_pop_quadrant: 15,
			no_mouse_move: 0,
			tab_detection_time: 1000,
			backtrap_timestamp_difference: 100,
			backtrap_load_delay: 0,
			backtrap_placement_delay: 50,
			backtrap_check_against_event_state: 1,
			back_trap_window_stop: 0,
			delay_div_placement: 0,
			close_on_esc: 1,
			do_not_encode_deeplink: 0,
			proactive_idle: 0,
			previous_selected: null,
			require_scroll_up: "1",
			scroll_up_speed: "4000",
			activation_start: "25",
			activation_start_unit: "%",
			launch_start: "0",
			launch_start_unit: "px",
			scroll_top_launch_delay: "0",
			window_ratio: "1.5",
			scroll_placement_delay: 5000
		},
		translations: {
			email_alert: "Please enter a valid email address",
			email_good: "Valid Email",
			email_bad: "Invalid Email",
			close_modal: "Close"
		},
		visitor: {
			ip: '45.249.79.243',
			country: 'in',
			city: 'Guntur',
			state: 'AP',
			zip: '522237'
		},
		machine: {
			is_mobile: (/iphone|ipod|ipad|android|blackberry|iemobile/i).test(navigator.userAgent.toLowerCase()),
			is_tablet: (/tablet|ipad/i).test(navigator.userAgent.toLowerCase()),
			is_mac: navigator.platform.toUpperCase().indexOf('MAC')>=0,
			is_iphone: (/iphone|ipod|ipad/i).test(navigator.userAgent.toLowerCase())
		},
		display_vars: {
			width: '900px',
			height: '443px',
			top: '',
			left: '',
			right: '',
			bottom: '',
			mobilefit: 0,
			background: "/chatskins/5698/Shutterstock-TT-1-24-dsktp-blank-nocart-b.jpg",
			p1: "",
			p2: "",
			intrinsic_size: {
				background: {
					height: 600,
					width: 1220
				},
			p1: {
					height: 0,
					width: 0
				},
			p2: {
					height: 0,
					width: 0
				}
			},
			brand_link: 'http://www.upsellit.com/customer-recovery-solutions.jsp',
			emailsuccess: "/images/validate-success.png",
			emailerror: "/images/validate-error.png",
			fallback_format: 'png',
			transition_speed: 500.0,
			countdown: '',
			enable_shadow: 1,
			shadow_opacity: 50,
			shadow_close_on_click: 1,
			shadow_transition_css: '#usi_shadow {background-color:#000000; opacity: 0.5;filter: alpha(opacity=50);} #usi_shadow.usi_show_shadow_css {display:block;visibility:visible;} #usi_shadow.usi_hide_shadow_css {display:none;visibility:hidden;}',
			shadow_css: '#usi_shadow {background-color:#000000; opacity: 0.5;filter: alpha(opacity=50);} #usi_shadow.usi_show_shadow_css {display:block;visibility:visible;} #usi_shadow.usi_hide_shadow_css {display:none;visibility:hidden;}',
			display_css: ".usi_display {left:50%;margin-left:-450px;top:50%;margin-top:-221px;width:900px;height:443px;}.usi_display img { pointer-events: none; } #usi_close { position:absolute;left:85%;top:0px;width:15%;height:15%;z-index:2000000300;cursor:pointer;border:none;background:none;margin:0;padding:0; } #usi_content { position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:2000000200; } #usi_background { position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:2000000100; } #usi_page { position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:2000000150; } .usi_display * {padding:0 0 0 0;margin:0 0 0 0;color:#000000;font-weight:normal;font-size:12pt;text-decoration:none;line-height:12pt;box-shadow: none;border: none; outline: none;text-align: left;font-family: Helvetica, Arial, sans-serif;float:none;} .usi_quickhide_css {display:none;visibility:hidden;} button#usi_close, button#usi_close:hover, button#usi_close:active, button#usi_close:focus { background:none;border:none;cursor:pointer; }.usi_sr_only { position: absolute !important; clip: rect(1px 1px 1px 1px); clip: rect(1px, 1px, 1px, 1px); }",
			transition_css: '.usi_display.usi_show_css {transition:transform 0.5s ease; transform: translate(0px, 0px); } .usi_display.usi_hide_css {transition:transform 0.5s ease; transform: translate(0px, -2000px); }',
			notransition_css: '.usi_display.usi_show_css {display:block;visibility:visible;} .usi_display.usi_hide_css {display:none;visibility:hidden;}',
			css: ".usi_display * {  font-size: 1em;  line-height: 1.2;  box-sizing: border-box;  color: inherit;  font-family: Roboto, Arial;}.usi_display {  color: #000;  font-family: Roboto, Arial;}.usi_header_text span {  font-family: inherit;  color: #000;  letter-spacing: -1px;}.usi_header_text2 span {  font-weight: bold;  font-family: inherit;  color: #000;  letter-spacing: -1px;}.usi_header_text {  position: absolute;  top: 20%;  left: 4%;  width: 45%;  height: 15%;  font-size: 1.53em;  color: #000;  text-align: center;}.usi_text_bottom {\tposition: absolute;  top: 35%;  left: 4%;  width: 45%;  height: 28%;  font-size: 3.2em;  color: #000;}.usi_header_text span {  text-align: center;}.usi_text_bottom span {\tfont-weight: bold;  text-align: center;}.usi_header_text2 {  position: absolute;  top: 28%;  left: 9%;  width: 74%;  height: 33%;  color: #000;}.usi_bullet_container {  position: absolute;  display: block;  top: 42%;  left: 9%;  }.usi_bullet_text {  display: block;  font-size: 1.7em;  color: #000;  padding-bottom: 6px;  width: 100%;}/* Submit Button */.usi_submitbutton:hover, .usi_submitbutton:active, .usi_submitbutton:focus {  background: none;  border: none;}.usi_submitbutton {  position: absolute;\ttop: 64.5%;  left: 9.5%;  width: 34%;  height: 13.5%;  display: inline-block;  background: none;  border: none;  margin: 0;  padding: 0;  cursor: pointer;  text-align: center;  color: #fff;  font-weight: bold;  font-size: 1.4em;}",
			focus_trap: 0
		},
		timers: {
			display_timer: -1,
			verify_email_loop_id: -1
		},
		mouse_info: {
			trajectory: 'down',
			on_page_timestamp: -1,
			last_mouse_y: -1,
			last_mouse_x: -1,
			is_runnable: 1,
			is_mouse_over_page: 0,
			last_seen_timestamp: -1,
			total_time_over_page: 0
		},
		page_status: {
			focus: 'focus',
			focused_at_exit: 0,
			resize_happened: 0,
			back_set: false,
			location_hash: "",
			back_state_set_time: -1,
			script_id: 0,
			back_means_exit: 1,
			email_last: "",
			error_reported: 0,
			at_page_bottom: false,
			unload_called: false,
			scroll_activation_hit: false,
			previous_scroll_position: 0,
			scroll_timer: 0
		},
		REACTIVE_METHOD: '0',
		PREDICTIVE_METHOD: '1',
		PROACTIVE_METHOD: '3',
		BACKBUTTON_TRAP: '5',
		SCROLL: '6',
		privacy_disclaimer_options: {},
		trace_items:[],
		add_class: function (element, className) {
			try {
				if (element != null) {
					var classes = usi_js.get_classes(element);
					if (classes.indexOf(className) === -1) {
						classes.push(className);
						element.className = classes.join(' ');
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		attach_event:function(eventname, func, node) {
			try {
				usi_js.trace('attach_event(' + eventname + ')');
				var attachToNode = usi_js.find_supported_node(eventname, node);
				if (attachToNode.addEventListener) {
					attachToNode.addEventListener(eventname, func, false);
				} else {
					attachToNode.attachEvent('on' + eventname, func);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		back_trap_launched:function() {
		},
		build:function() {
			try {
				usi_js.trace('build()');
				if (typeof(usi_commons) !== "undefined" && typeof(usi_commons.cdn) !== "undefined") usi_js.campaign.images = usi_commons.cdn;
				if (location.href.indexOf("usi_flush") != -1) usi_cookies.flush();
				if (location.href.indexOf("usi_print") != -1) usi_cookies.print();
				if (!usi_js.display_allowed(true)) return;
				if (usi_js.launch.delay_div_placement == 0) {
					if (usi_js.transitions_allowed())
						usi_js.place_css(usi_js.display_vars.display_css + usi_js.display_vars.shadow_transition_css + usi_js.display_vars.transition_css);
					else
						usi_js.place_css(usi_js.display_vars.display_css + usi_js.display_vars.shadow_css + usi_js.display_vars.notransition_css);
					if (!usi_js.place_div()) {
						return;
					}
				}
				usi_js.set_triggers();
				usi_js.campaign.tracking_link = usi_js.campaign.host+'/link.jsp?id='+usi_js.campaign.id+'&cid='+usi_js.campaign.company_id+'&sid='+usi_js.campaign.site_id+'&duration='+usi_js.campaign.sale_window;
				usi_js.launch.build_time = new Date().getTime();
				if (location.href.indexOf("usi_launch") != -1) usi_js.display(true, usi_js.PROACTIVE_METHOD);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		check_blur_default:function(elmt) {
			try {
				usi_js.trace('check_blur_default()');
				if (elmt.value == "") {
					elmt.value = elmt.title;
					elmt.style.color = "#000000";
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		check_data_exists:function(obj) {
			try {
				usi_js.trace('check_data_exists()');
				for (var i in obj) {
					if (obj[i] == null && obj.hasOwnProperty(i)) {
						usi_js.launch.suppress = true;
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		check_focus_default:function(elmt) {
			try {
				usi_js.trace('check_focus_default()');
				if (elmt.title == elmt.value) {
					elmt.value = "";
					elmt.style.color = "#000000";
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		check_for_change_events:function(iterations) {
			try {
				usi_js.trace('check_for_change_events()');
				var usi_display = document.getElementById("usi_display");
				var usi_shadow = document.getElementById("usi_shadow");
				usi_js.log((new Date()).getTime() + " check_for_change_events: usi_js.page_status.focus: " + usi_js.page_status.focus + ", usi_js.page_status.resize_happened: " + usi_js.page_status.resize_happened);
				if (usi_js.page_status.focus == 'blur' || usi_js.page_status.resize_happened == 1) {
					usi_js.log("check_for_change_events: hiding because of blur");
					usi_cookies.del("usi_launched"+usi_js.campaign.cookie_append);
					usi_js.timers.launch_cookie_del = setTimeout(usi_js.launch_cookie_del, 1500);
					usi_js.launch.launched = false;
					if (usi_display != null) usi_display.className = "usi_quickhide_css usi_display";
					if (usi_shadow != null) usi_shadow.className = "usi_quickhide_css usi_display";
				} else if (iterations > 0) {
					usi_js.log("check_for_change_events iterations: " + iterations);
					usi_js.timers.check_for_change_events = setTimeout(function(){
						if (typeof(usi_js) === "undefined") return;
						usi_js.check_for_change_events(iterations - 1);
					}, 250);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		cleanup:function() {
			try {
				usi_js.trace('cleanup()');
				var usi_display = document.getElementById("usi_display");
				var usi_shadow = document.getElementById("usi_shadow");
				var usi_style_tag = document.getElementsByClassName("usi_style_tag");
				usi_js.stop_mouse_monitor();
				usi_js.stop_focus_monitor();
				usi_js.stop_timers();
				if (usi_display != null && usi_display.parentNode != null) {
					usi_display.parentNode.removeChild(usi_display);
				}
				if (usi_shadow != null && usi_shadow.parentNode != null) {
					usi_shadow.parentNode.removeChild(usi_shadow);
				}
				if (typeof(usi_js.countdown_vars) != "undefined") {
					clearInterval(usi_js.countdown_vars.timer_id);
				}
				if (typeof usi_commons != "undefined") {
					usi_commons.last_view = "";
				}
				var itrs = 0;
				while (itrs < 10 && usi_style_tag.length) {
					itrs++;
					usi_style_tag[0].parentNode.removeChild(usi_style_tag[0]);
				}
				usi_js.detach_event("popstate", usi_js.check_back_state, window);
				delete usi_js;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		click_cookie:function() {
			try {
				if (usi_js.campaign.click_cookie != 0) usi_cookies.set('usi_launched' + usi_js.campaign.cookie_append, usi_js.campaign.id, usi_js.campaign.click_cookie, true);
				usi_cookies.set("usi_click_id", usi_js.campaign.id, usi_js.campaign.sale_window, true);
				usi_cookies.set("usi_clicked_1", "1", 60, true);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		close:function() {
			try {
				usi_js.trace('close()');
				if (!usi_js.pre_close()) return;
				usi_js.remove_display_div();
				usi_js.remove_shadow_div();
				if (usi_js.launch.close_on_esc == 1) usi_js.detach_event("keyup", usi_js.monitor_for_esc);
				usi_js.detach_event("orientationchange", usi_js.mobilefit_delay, window);
				usi_js.detach_event("resize", usi_js.mobilefit_delay, window);
				usi_js.post_close();
				usi_js.post_close = function() {};
				if (usi_js.launch.previous_selected != null) {
					usi_js.launch.previous_selected.focus();
				}
				var usi_display = document.getElementById("usi_display");
				if (usi_display != null) {
					usi_js.detach_event("keydown", usi_js.focus_trap, usi_display)
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		countdown_initiate:function(str) {
			try {
				usi_js.trace('countdown_initiate()');
				if (str == "eod" || str.indexOf("-") != -1) usi_js.countdown_to(str);
				else if (str.split(":").length == 4) usi_js.countdown(str.split(":")[0], str.split(":")[1], str.split(":")[2], str.split(":")[3]);
				else if (str.split(":").length == 3) usi_js.countdown(0, str.split(":")[0], str.split(":")[1], str.split(":")[2]);
				else if (str.split(":").length == 2) usi_js.countdown(0, 0, str.split(":")[0], str.split(":")[1]);
				else if (str.split(":").length == 1) usi_js.countdown(0, 0, 0, str.split(":")[0]);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		countdown_to:function(date) {
			try {
				usi_js.trace('countdown_to()');
				usi_js.load_js("utility/countdown.jsp?date="+encodeURIComponent(date));
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		countdown_finished:function() {
			try {
				usi_js.trace('countdown_finished()');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		countdown:function(d, h, m, s) {
			try {
				usi_js.trace('countdown()');
				if (typeof(usi_js.countdown_vars) != "undefined") {
					clearTimeout(usi_js.countdown_vars.timer_id);
				}
				usi_js.countdown_vars = {};
				d = parseInt(d,10);
				h = parseInt(h,10);
				m = parseInt(m,10);
				s = parseInt(s,10);
				if(d < 0 || h < 0 || m < 0 || s <0 || isNaN(d) || isNaN(h) || isNaN(m) || isNaN(s)) { return; }

				usi_js.countdown_vars.days = d;
				usi_js.countdown_vars.hours = h;
				usi_js.countdown_vars.minutes = m;
				usi_js.countdown_vars.seconds = s;
				usi_js.countdown_vars.updateTimer = function(days,hrs,mins,secs) {
					try {
						if (document.getElementById("usi_days") != null) document.getElementById("usi_days").innerHTML = (days < 10 ? days : days);
						if (document.getElementById("usi_hours") != null) document.getElementById("usi_hours").innerHTML = (hrs < 10 ? '0'+hrs : hrs);
						if (document.getElementById("usi_minutes") != null) document.getElementById("usi_minutes").innerHTML = (mins < 10 ? '0'+mins : mins);
						if (document.getElementById("usi_seconds") != null) document.getElementById("usi_seconds").innerHTML = (secs < 10 ? '0'+secs : secs);
					} catch(err) {
						if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
					}
				};
				usi_js.countdown_vars.updateTimer(d, h, m, s);
				usi_js.countdown_vars.doCountDown = function() {
					try {
						if (typeof(usi_js) === "undefined") return;
						if(usi_js.countdown_vars.seconds == 0) {
							if(usi_js.countdown_vars.minutes == 0) {
								if(usi_js.countdown_vars.hours == 0) {
									if(usi_js.countdown_vars.days == 0) {
										usi_js.countdown_finished();
										return;
									} else {
										usi_js.countdown_vars.hours=23;
										usi_js.countdown_vars.minutes=59;
										usi_js.countdown_vars.seconds=60;
										usi_js.countdown_vars.days--;
									}
								} else {
									usi_js.countdown_vars.minutes=59;
									usi_js.countdown_vars.seconds=60;
									usi_js.countdown_vars.hours--;
								}
							} else {
								usi_js.countdown_vars.seconds=60;
								usi_js.countdown_vars.minutes--;
							}
						}
						usi_js.countdown_vars.seconds--;
						usi_js.countdown_vars.updateTimer(usi_js.countdown_vars.days,usi_js.countdown_vars.hours,usi_js.countdown_vars.minutes,usi_js.countdown_vars.seconds);
					} catch(err) {
						if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
					}
					usi_js.countdown_vars.timer_id = setTimeout(usi_js.countdown_vars.doCountDown,1000);
				};
				usi_js.countdown_vars.timer_id = setTimeout(usi_js.countdown_vars.doCountDown,1000);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		custom_alert:function(msg) {
			try {
				alert(msg);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		current_time:function() {
			try {
				var d = new Date();
				return d.getTime();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		decode_html:function(html) {
			try {
				var txt = document.createElement("textarea");
				txt.innerHTML = html;
				return txt.value;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		deep_link:function(destination) {
			try {
				usi_js.trace('deep_link()');
				usi_js.click_cookie();
				top.location.href = usi_js.get_deep_link(destination);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		deep_link_new_window:function(destination) {
			try {
				usi_js.trace('deep_link()');
				usi_js.click_cookie();
				window.open(usi_js.get_deep_link(destination));
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		get_srcset: function(imgPage) {
			var img = {"src": "", "srcset": ""};
			try {
				var _campWidthInt = (usi_js.display_vars.width ? parseInt(usi_js.display_vars.width.replace("px", "")) : -1);
				if (usi_js.display_vars.intrinsic_size[imgPage] && usi_js.display_vars.intrinsic_size[imgPage].width > 0 && Math.floor(usi_js.display_vars.intrinsic_size[imgPage].width / _campWidthInt) > 1) {
					var dppx = Math.floor(usi_js.display_vars.intrinsic_size[imgPage].width / _campWidthInt);
					for (var i = 2; i <= dppx; i++) {
						if (img.srcset != "") img.srcset += ",";
						var _w = (_campWidthInt * i);
						img.srcset += usi_js.campaign.images + "/w:" + _w + "/d" + usi_js.display_vars[imgPage].replace('/chatskins', '') + " " + _w + "w";
					}
					img.src = usi_js.campaign.images + '/w:' + _campWidthInt + '/d' + usi_js.display_vars[imgPage].replace('/chatskins', '');
				}
				if (!img.srcset && usi_js.display_vars[imgPage].indexOf(".webp") != -1) {
					img.src = usi_js.campaign.images + '/w:' + _campWidthInt + '/format:webp/d' + usi_js.display_vars[imgPage].replace('/chatskins', '');
					img.srcset = usi_js.campaign.images + "/w:" + _campWidthInt + "/format:webp/d" + usi_js.display_vars[imgPage].replace('/chatskins', '') + " " + _campWidthInt + "w";
				} else if (img.srcset && usi_js.display_vars[imgPage].indexOf(".webp") != -1) {
					img.src = img.src.replace(/\/d/g, "/format:webp/d");
					img.srcset = img.srcset.replace(/\/d/g, "/format:webp/d");
				}
			} catch (err) {
				if (typeof (usi_commons) !== "undefined") usi_commons.report_error(err);
			}
			return img;
		},
		launch_cookie_set:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_cookies.set("usi_launched"+usi_js.campaign.cookie_append, usi_js.campaign.id, usi_js.campaign.launch_cookie, true);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		launch_cookie_del:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_cookies.del("usi_launched"+usi_js.campaign.cookie_append);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		detach_event:function(eventname, func, node) {
			try {
				usi_js.trace('detach_event(' + eventname + ')');
				var removeFromNode = usi_js.find_supported_node(eventname, node);
				if (removeFromNode.removeEventListener) {
					removeFromNode.removeEventListener(eventname, func, false);
				} else {
					removeFromNode.detachEvent('on' + eventname, func);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		display_allowed:function(aggressive) {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('display_allowed()');
				if (usi_js.launch.build_time && (new Date().getTime() - usi_js.launch.build_time) > 86400000) {
					usi_js.log("display_allowed: not launching because build was 24 hours ago");
					return false;
				} else if (usi_js.launch.launched) {
					usi_js.log("display_allowed: not launching because already launched");
					return false;
				} else if (!usi_js.launch.enabled) {
					usi_js.log("display_allowed: not launching because enabled == false");
					return false;
				} else if (!usi_js.campaign.force_load && usi_js.launch.sales_suppression) {
					usi_js.log("display_allowed: not launching because sales_suppression == true");
					return false;
				} else if (!usi_js.campaign.force_load && typeof(usi_pixel) !== "undefined") {
					usi_js.log("display_allowed: not launching because usi_pixel on the page");
					return false;
				} else if (!aggressive && usi_js.launch.suppress) {
					usi_js.log("display_allowed: not launching because suppress == true");
					return false;
				} else if (!usi_js.pre_display()) {
					usi_js.log("display_allowed: not launching because of pre_display check");
					return false;
				} else if (!usi_js.campaign.force_load && usi_cookies.get("usi_launched"+usi_js.campaign.cookie_append) != null) {
					usi_js.log("display_allowed: not launching because launch suppressed");
					return false;
				} else if (!usi_js.campaign.force_load && usi_cookies.get("usi_sale") != null) {
					usi_js.log("display_allowed: not launching because sale suppressed");
					return false;
				} else if (!usi_js.campaign.force_load && usi_cookies.get("usi_suppress"+usi_js.campaign.cookie_append) != null) {
					usi_js.log("display_allowed: not launching because cookie suppressed");
					return false;
				}
				return true;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
			return false;
		},
		display:function(aggressive, launchMethod) {
			try {
				usi_js.trace('display()');
				launchMethod = launchMethod || "";
				usi_js.launch.previous_selected = document.activeElement;
				if (usi_js.launch.delay_div_placement == 1) {
					if (usi_js.transitions_allowed())
						usi_js.place_css(usi_js.display_vars.display_css + usi_js.display_vars.shadow_transition_css + usi_js.display_vars.transition_css);
					else
						usi_js.place_css(usi_js.display_vars.display_css + usi_js.display_vars.shadow_css + usi_js.display_vars.notransition_css);
					usi_js.place_div();
				}
				var usi_display = document.getElementById("usi_display");
				var usi_close = document.getElementById("usi_close");
				if (usi_close != null) usi_js.attach_event("click", usi_js.close, usi_close);
				if (!usi_js.display_allowed(aggressive)) return false;
				if (usi_display != null) {
					usi_js.launch.launched = true;
					usi_display.style.display = 'block';
					usi_js.timers.display_class_change = setTimeout(function() {
						if (typeof(usi_js) === "undefined") return false;
						usi_js.remove_class(usi_display, 'usi_hide_css');
						usi_js.remove_class(usi_display, 'usi_quickhide_css');
						usi_js.add_class(usi_display, 'usi_show_css');
					}, 20);
					if (usi_js.display_vars.enable_shadow > 0) {
						usi_js.drop_shadow();
					}
				}
				usi_js.load_js('load.jsp?id='+usi_js.campaign.id+'&sid='+usi_js.campaign.site_id+'&cid='+usi_js.campaign.config_id+'&url='+encodeURIComponent(location.href)+"&lm="+launchMethod, function(){
					usi_js.post_display(launchMethod);
				});
				if (usi_js.campaign.launch_cookie != 0) {
					usi_js.timers.launch_cookie_set = setTimeout(usi_js.launch_cookie_set, 1500);
				}
				usi_js.remove_onbeforeunload();
				if (usi_js.page_status.focused_at_exit == 1 && usi_js.launch.launch_methods.indexOf(usi_js.PREDICTIVE_METHOD) != -1) { usi_js.start_tab_detection(); }
				if (usi_js.display_vars.p2 != "") {
					try {
						if (usi_js.get_srcset("p2").src && usi_js.get_srcset("p2").srcset) {
							usi_js.preload_img(usi_js.get_srcset("p2").src, usi_js.get_srcset("p2").srcset);
						} else {
							usi_js.preload_img(usi_js.campaign.images + usi_js.display_vars.p2);
						}
					} catch(err) {
						if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
					}
				}
				usi_js.timers.verify_email_loop_id = setTimeout(usi_js.verify_email_loop, 1000);
				if (usi_js.display_vars.mobilefit == 1) {
					usi_js.attach_event("orientationchange", usi_js.mobilefit_delay, window);
					usi_js.attach_event("resize", usi_js.mobilefit_delay, window);
					usi_js.mobilefit();
				} else {
					usi_js.fix_to_top();
				}
				if (usi_js.launch.close_on_esc == 1) usi_js.attach_event("keyup", usi_js.monitor_for_esc);
				if (usi_js.display_vars.focus_trap == 1) {
					usi_js.set_focus_trap();
				} else {
					usi_js.focus_proper_element();
				}
				if (usi_js.display_vars.countdown != "") { usi_js.countdown_initiate(usi_js.display_vars.countdown); }
				return true;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		drop_shadow:function() {
			try {
				usi_js.trace('drop_shadow()');
				if (document.getElementById("usi_shadow") == null) {
					var shadow_div = document.createElement('div');
					shadow_div.setAttribute('id',"usi_shadow");
					shadow_div.style.zIndex = 2000000000;
					shadow_div.style.left = '0px';
					shadow_div.style.top = '0px';
					shadow_div.style.width = '100%';
					shadow_div.style.height = '100%';
					shadow_div.style.position = 'fixed';
					shadow_div.className = "usi_hide_shadow_css";
					document.getElementsByTagName('body')[0].appendChild(shadow_div);
					usi_js.timers.usi_show_shadow_css = setTimeout(function() {
						if (typeof(usi_js) === "undefined") return;
						document.getElementById("usi_shadow").className = "usi_show_shadow_css";
					}, 20);
					if (usi_js.display_vars.shadow_close_on_click == 1 || usi_js.machine.is_mobile) {
						usi_js.timers.set_shadow_click_close = setTimeout(function () {
							if (typeof(usi_js) === "undefined") return;
							usi_js.set_shadow_click_close();
						}, 2000);
					}
				} else {
					usi_js.timers.usi_show_shadow_css = setTimeout(function(){
						if (document.getElementById("usi_shadow") != null) {
							document.getElementById("usi_shadow").className = "usi_show_shadow_css";
						}
					}, 20);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		error_report:function(err) {
			if (typeof(usi_js) === "undefined") return;
			usi_js.trace('error_report()');
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			if(usi_js.page_status.error_reported == 0) {
				usi_js.page_status.error_reported = 1;
				if (location.href.indexOf('usishowerrors') !== -1) throw err;
				else usi_js.load_js('err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			}
			usi_js.trace(err.message);
		},
		error_report_image:function(event, img) {
			try {
				usi_js.trace('error_report_image()');
				usi_js.launch.enabled = false;
				usi_js.launch.suppress = true;
				return true;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		escape_quotes: function(string){
			try {
				return string.replace(/"/g, '\\"').replace(/'/g, "\\'");
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		find_supported_node:function(eventname, node) {
			try {
				node = (node || document);
				if (node === window) {
					return window;
				} else if (usi_js.is_event_supported(eventname, node) === true) {
					return node;
				} else {
					if (node === document) {
						return window;
					} else {
						return usi_js.find_supported_node(eventname, document);
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		fix_to_top:function() {
			try {
				usi_js.trace('fix_to_top()');
				var usi_display = document.getElementById("usi_display");
				if (window.innerHeight < Number(usi_js.display_vars.height.replace("px",""))) {
					usi_display.style.position = "absolute";
					usi_display.style.top = "0px";
					usi_display.style.marginTop="0px";
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		focus_proper_element:function() {
			
			try {
				if (document.getElementById("usi_submitbutton") != null) {
					document.getElementById("usi_submitbutton").focus();
				} else if (document.getElementsByClassName("usi_submitbutton").length > 0) {
					document.getElementsByClassName("usi_submitbutton")[0].focus();
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
			
		},
		focus_trap:function (e) {
			try {
				var usi_display = document.getElementById("usi_display");
				var focusable_elements = usi_display.querySelectorAll("[tabindex], a, button, input, select");
				var firstFocusableEl = focusable_elements[0];
				var lastFocusableEl = focusable_elements[focusable_elements.length - 2];
				if (e.keyCode === 9) {
					if (e.shiftKey && document.activeElement === firstFocusableEl) {
						e.preventDefault();
						lastFocusableEl.focus();
					} else if (!e.shiftKey && document.activeElement === lastFocusableEl) {
						e.preventDefault();
						firstFocusableEl.focus();
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		get_classes: function (element) {
			try {
				var classes = [];
				if (element != null && element.classList != null) {
					classes = Array.prototype.slice.call(element.classList);
				}
				return classes;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		get_hash:function() {
			try {
				if (location.href.indexOf("#") == -1) return "";
				var usi_hash = location.href.substring(location.href.indexOf("#")+1, location.href.length);
				if (usi_hash == "") return "usi_blank";
				return usi_hash;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		get_deep_link:function(destination) {
			try {
				usi_js.trace('get_deep_link()');
				if ((destination || '') === '') {
					destination = location.href;
				}
				var usi_url = encodeURIComponent(usi_js.campaign.deep_link + encodeURIComponent(destination));
				if (usi_js.launch.do_not_encode_deeplink == 1) {
					usi_url = encodeURIComponent(usi_js.campaign.deep_link + destination);
				}
				var redirectLink = usi_js.campaign.tracking_link + "&url=" + usi_url;
				usi_js.trace('redirectLink: ' + redirectLink);
				return redirectLink;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		get_session:function() {
			try {
				usi_js.trace('get_session()');
				var sess = null;
				if (usi_cookies.get("usi_sess") != null) {
					sess = usi_cookies.get("usi_sess");
				} else {
					sess = "usi_sess_"+usi_js.campaign.site_id +"_"+ Math.round(1000 * Math.random()) + "_" + (new Date()).getTime();
					usi_cookies.set("usi_sess", sess, 30*24*60*60, true);
				}
				return sess;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		is_event_supported:function(eventname, node) {
			try {
				return (node != null && typeof node['on' + eventname] !== 'undefined');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		link:function(destination) {
			try {
				usi_js.trace('link()');
				usi_js.click_cookie();
				if (!destination) destination = usi_js.campaign.link;
				if ((!destination || destination == "") && usi_js.campaign.deep_link != "") usi_js.deep_link();
				else if (!destination || destination == "") usi_js.link_clicked();
				else top.location.href = usi_js.campaign.tracking_link+"&url="+encodeURIComponent(destination);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		link_new_window:function(destination) {
			try {
				usi_js.trace('link()');
				usi_js.click_cookie();
				if (!destination) destination = usi_js.campaign.link;
				if ((!destination || destination == "") && usi_js.campaign.deep_link != "") usi_js.deep_link();
				else if (!destination || destination == "") usi_js.link_clicked();
				else window.open(usi_js.campaign.tracking_link+"&url="+encodeURIComponent(destination));
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		link_callback:function() {
			try {
				usi_js.link_callback = function() {};
				usi_js.trace('link_callback()');
				usi_js.close();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		link_clicked:function() {
			try {
				usi_js.trace('link_clicked()');
				usi_js.click_cookie();
				usi_js.load_js(usi_js.campaign.tracking_link+"&ajax=1");
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		link_injection:function(destination, callback) {
			try {
				usi_js.trace('link_injection()');
				if (!destination && usi_js.campaign.link != "") {
					destination = usi_js.campaign.link;
				} else if (!destination && usi_js.campaign.deep_link != "") {
					destination = usi_js.campaign.deep_link + encodeURIComponent(location.href);
					if (usi_js.launch.do_not_encode_deeplink == 1) {
						destination = usi_js.campaign.deep_link + location.href;
					}
				}
				var iframe = document.createElement("iframe");
				iframe.style.width = "1px";
				iframe.style.height = "1px";
				iframe.src = destination;
				if (typeof callback == "function") iframe.onload = callback;
				document.getElementsByTagName('body')[0].appendChild(iframe);
				usi_js.link_clicked();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		load_js:function(js_url, callback) {
			try {
				usi_js.trace('load_js(' + js_url + ')');
				usi_js.page_status.script_id++;
				var USI_headID = document.getElementsByTagName("head")[0];
				var USI_dynScript = document.createElement("script");
				USI_dynScript.setAttribute("id","usi_AJAXScript"+usi_js.page_status.script_id);
				USI_dynScript.setAttribute("type","text/javascript");
				if (js_url.indexOf("http") == 0) {
					USI_dynScript.setAttribute("src",js_url);
				} else {
					USI_dynScript.setAttribute("src",usi_js.campaign.host+"/"+js_url);
				}
				if (typeof callback == "function") {
					USI_dynScript.onload = function() {
						callback();
					};
				}
				USI_headID.appendChild(USI_dynScript);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		load_page:function(usi_page) {
			try {
				usi_js.trace('load_page()');
				var usi_change_made = 0;
				if (document.getElementById("usi_page") != null) {
					if (typeof(usi_js.display_vars["p"+usi_page]) != "undefined") {
						if (usi_js.get_srcset("p" + usi_page).src && usi_js.get_srcset("p" + usi_page).srcset) {
							var srcsetData = usi_js.get_srcset("p" + usi_page);
							if (usi_js.display_vars["p"+usi_page].indexOf(".webp") != -1) {
								document.getElementById("usi_page").innerHTML = '<picture aria-hidden="true" onerror="usi_js.error_report_image(event, this);" style="width:100%;height:100%;">'+
										'<source srcset="' + srcsetData.srcset + '" type="image/webp">'+
										'<source srcset="' + srcsetData.srcset.replace(/\/format:webp\/d\//g, '/format:'+usi_js.display_vars.fallback_format+'/d/') + '" type="image/'+usi_js.display_vars.fallback_format+'	">'+
										'<img src="' + srcsetData.src.replace(/\/format:webp\/d\//g, '/format:'+usi_js.display_vars.fallback_format+'/d/') + '" alt="" style="width:100%;height:100%;">'+
									'</picture>';
							} else {
								document.getElementById("usi_page").innerHTML = '<img srcset="' + srcsetData.srcset + '" src="' + srcsetData.src + '" aria-hidden="true" alt="" style="width:100%;height:100%;" onerror="usi_js.error_report_image(event, this);"/>';
							}
						} else {
							document.getElementById("usi_page").innerHTML = '<img src="' + usi_js.campaign.images + usi_js.display_vars["p" + usi_page] + '" aria-hidden="true" alt="" style="width:100%;height:100%;" onerror="usi_js.error_report_image(event, this);"/>';
						}
						usi_change_made = 1;
					}
				}
				if (document.getElementById('usi_content') != null) {
					if (typeof(usi_js.display_vars["p"+usi_page+"_html"]) == "string") {
						document.getElementById('usi_content').innerHTML = usi_js.display_vars["p"+usi_page+"_html"];
						usi_change_made = 1;
					} else if (typeof(usi_js.display_vars["p"+usi_page+"_html"]) == "function") {
						document.getElementById('usi_content').innerHTML = usi_js.display_vars["p"+usi_page+"_html"]();
						usi_change_made = 1;
					}
				}
				if (usi_change_made == 0 && usi_page == 2) {
					if (usi_js.campaign.link != "") {
						usi_js.link();
					} else if (usi_js.campaign.deep_link != "") {
						usi_js.deep_link();
					}
				}
				usi_js.place_alt();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		log:function(message) {
			
		},
		mobilefit:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('mobilefit()');
				var usi_display = document.getElementById("usi_display");
				if (usi_display != null) {
					usi_display.style.height = "1px";
					usi_display.style.width = "1px";

					var doc = document.documentElement || document.body;
					var window_width = window.innerWidth || doc.clientWidth || 0;
					var window_height = window.innerHeight || doc.clientHeight || 0;
					var display_height = window_height;
					var display_width = window_width;
					if ((usi_js.display_vars.height || "") != "") {
						display_height = parseInt(usi_js.display_vars.height.replace("px", ""));
					}
					if ((usi_js.display_vars.width || "") != "") {
						display_width = parseInt(usi_js.display_vars.width.replace("px", ""));
					}
					var max_width, max_height, new_font_size;
					if (typeof(usi_js.display_vars.font_size) === "undefined") {
						usi_js.display_vars.font_size = window.getComputedStyle(usi_display).getPropertyValue("font-size").replace("px", "")
					}
					if (usi_js.machine.is_tablet && (window_height > display_height) && (window_width > display_width)) {
						max_width = display_width;
						max_height = display_height;
					} else if ((window_height/window_width) > (display_height/display_width)) {
						max_width = window_width;
						max_height = window_width * (display_height/display_width);
					} else {
						max_width = window_height * (display_width/display_height);
						max_height = window_height;
					}
					new_font_size = max_width / (display_width / usi_js.display_vars.font_size);
					if (usi_js.display_vars.top == "" && usi_js.display_vars.bottom == "") {
						usi_display.style.top = "0px";
						usi_display.style.marginTop = "0px";
					}
					if (usi_js.display_vars.right == "" && usi_js.display_vars.left == "") {
						usi_display.style.left = "50%";
						usi_display.style.marginLeft = "-" + (max_width * .5) + "px";
					}
					usi_display.style.fontSize = new_font_size + "px";
					usi_display.style.height = max_height + "px";
					usi_display.style.width = max_width + "px";
					if (max_width < 145) {
						usi_js.close();
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		mobilefit_delay:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('mobilefit_delay()');
				usi_js.timers.mobilefit = setTimeout(usi_js.mobilefit, 500);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		monitor_for_esc:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('monitor_for_esc()');
				if(event.which == 27) {
					usi_js.log('usi: escape clicked');
					usi_js.close();
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		mouse_out:function(event) {
			try {
				var doc = document.documentElement || document.body;

				if (typeof(usi_js) === "undefined") return;
				var e = event.toElement || event.relatedTarget;
				if (e == null || e.nodeName === 'HTML') {
					usi_js.mouse_info.is_mouse_over_page = 0;
					if (usi_js.mouse_info.last_seen_timestamp != -1) usi_js.mouse_info.total_time_over_page += (Number(new Date()) - usi_js.mouse_info.last_seen_timestamp);
					if (usi_js.page_status.unload_called) {
						usi_js.log('usi: suppressing because page is currently unloading');
						return;
					}
					if (usi_js.mouse_info.total_time_over_page < usi_js.launch.time_hover_requirement) {
						usi_js.log('usi: not on page long enough: ' + usi_js.mouse_info.total_time_over_page);
						return;
					}
					if (usi_js.launch.any_trajectory == 0) {
						if (usi_js.mouse_info.last_mouse_y > usi_js.launch.exit_area) {
							usi_js.log('usi: exit from non-top movement area ' + usi_js.mouse_info.last_mouse_y);
							return;
						}
					} else {

						var window_width = window.innerWidth || doc.clientWidth || 0;
						var window_height = window.innerHeight || doc.clientHeight || 0;
						if (usi_js.mouse_info.last_mouse_y > usi_js.launch.exit_area &&
							usi_js.mouse_info.last_mouse_x > usi_js.launch.exit_area &&
							usi_js.mouse_info.last_mouse_y < window_width - usi_js.launch.exit_area &&
							usi_js.mouse_info.last_mouse_x < window_height - usi_js.launch.exit_area) {
							usi_js.log('usi: exit not from edge ' + usi_js.mouse_info.last_mouse_y + ' / ' + usi_js.mouse_info.last_mouse_x);
							return;
						}
					}
					if ((Number(new Date()) - usi_js.mouse_info.on_page_timestamp) > usi_js.launch.speed_upward) {
						if ((Number(new Date()) - usi_js.mouse_info.on_page_timestamp) > 100000) {
							usi_js.log('usi: did not move mouse down to content (starts at '+usi_js.launch.content_start+' px)');
						} else {
							usi_js.log('usi: slow approach: ' + (Number(new Date()) - usi_js.mouse_info.on_page_timestamp) + 'ms');
						}
						return;
					}
					var window_width = window.innerWidth || doc.clientWidth || 0;
					if (!usi_js.machine.is_mac && usi_js.mouse_info.last_mouse_x/window_width <= usi_js.launch.no_pop_quadrant/100) {
						usi_js.log('usi: too far to the left ' + (usi_js.mouse_info.last_mouse_x/window_width) + '%');
						return;
					}
					usi_js.mouse_info.last_seen_timestamp = Number(new Date());
					if ((usi_js.launch.any_trajectory == 1 || usi_js.mouse_info.trajectory == 'up') && usi_js.timers.display_timer == -1) {
						usi_js.log('usi: up and out!');
						if (usi_js.launch.launch_methods.indexOf(usi_js.PREDICTIVE_METHOD) != -1) {
							if (usi_js.page_status.focus == 'focus') usi_js.page_status.focused_at_exit = 1;
							else usi_js.page_status.focused_at_exit = 0;
							usi_js.timers.display_timer = setTimeout(function(){
								if (typeof(usi_js) === "undefined") return;
								usi_js.display(false, usi_js.PREDICTIVE_METHOD);
							}, usi_js.launch.time_above_y );
						}
					} else if (usi_js.mouse_info.trajectory == 'down') {
						usi_js.log('usi: mouse moving down');
					} else if (usi_js.timers.display_timer != -1) {
						usi_js.log('usi: timer to launch seems to be running...');
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		mouse_over:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;
				if (usi_js.launch.no_mouse_move == 1) usi_js.mouse_move(event);
				usi_js.log('usi: usi_js.mouse_info.is_mouse_over_page = 1');
				if (usi_js.mouse_info.is_mouse_over_page == 0) {
					usi_js.mouse_info.last_seen_timestamp = Number(new Date());
				}
				usi_js.mouse_info.is_mouse_over_page = 1;
				if (usi_js.timers.display_timer != -1) {
					clearTimeout(usi_js.timers.display_timer);
					usi_js.timers.display_timer = -1;
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		mouse_move:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;

				var doc = document.scrollingElement ? document.scrollingElement : document.documentElement || document.body;
				var mouseX = document.all? event.clientX: event.pageX - (doc && doc.scrollLeft);
				var mouseY = document.all? event.clientY: event.pageY - (doc && doc.scrollTop);
				if (mouseY > usi_js.launch.content_start) {
					usi_js.mouse_info.on_page_timestamp = Number(new Date());
				}
				if (usi_js.mouse_info.last_mouse_y >= mouseY) {
					usi_js.mouse_info.trajectory = 'up';
				} else {
					usi_js.mouse_info.trajectory = 'down';
				}
				usi_js.mouse_info.last_mouse_y = mouseY;
				usi_js.mouse_info.last_mouse_x = mouseX;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		onbeforeunload_called:function() {
			try {
				if (typeof(usi_js) !== "undefined") {
					usi_js.page_status.unload_called = true;
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		place_alt:function() {
			try {
				if (document.getElementById('usi_background_img') != null && document.getElementsByClassName("usi_sr_only").length > 0) {
					document.getElementById('usi_background_img').setAttribute('alt', document.getElementsByClassName("usi_sr_only")[0].innerHTML);
					document.getElementById('usi_display').setAttribute('aria-label', document.getElementsByClassName("usi_sr_only")[0].innerHTML);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		place_background:function() {
			try {
				var html = "";
				if (usi_js.display_vars.background.indexOf(".mp4") != -1) {
					html = [
						'<div id="usi_background">',
						'<video class="usi_video" autoplay loop muted playsinline src="',usi_js.campaign.images+usi_js.display_vars.background,'" style="width:100%;height:100%;" id="usi_background_video"/>',
						'</div>'
					].join('');
				} else {
					if (usi_js.get_srcset('background').srcset) {
						var srcsetData = usi_js.get_srcset('background');
						if (usi_js.display_vars["background"].indexOf(".webp") != -1) {
							html = '<picture id="usi_background" aria-hidden="true" onerror="usi_js.error_report_image(event, this);">'+
									'<source srcset="' + srcsetData.srcset + '" type="image/webp">'+
									'<source srcset="' + srcsetData.srcset.replace(/\/format:webp\/d\//g, '/format:'+usi_js.display_vars.fallback_format+'/d/') + '" type="image/'+usi_js.display_vars.fallback_format+'">'+
									'<img src="' + srcsetData.src.replace(/\/format:webp\/d\//g, '/format:'+usi_js.display_vars.fallback_format+'/d/') + '" alt="" style="width:100%;height:100%;">'+
								'</picture>'
						} else {
							html = [
								'<div id="usi_background">',
								'<img srcset="',srcsetData.srcset,'" src="',srcsetData.src,'" aria-hidden="true" alt="" style="width:100%;height:100%;" id="usi_background_img" onerror="usi_js.error_report_image(event, this);"/>',
								'</div>'
							].join('');
						}
					} else {
						html = [
							'<div id="usi_background">',
							'<img src="',usi_js.campaign.images+usi_js.display_vars.background,'" aria-hidden="true" alt="" style="width:100%;height:100%;" id="usi_background_img" onerror="usi_js.error_report_image(event, this);"/>',
							'</div>'
						].join('');
					}
				}
				return html;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		place_css:function(css) {
			try {
				usi_js.trace('place_css()');
				var usi_css = document.createElement("style");
				usi_css.type = "text/css";
				if(usi_css.styleSheet) usi_css.styleSheet.cssText = css;
				else usi_css.innerHTML = css;
				usi_css.className = "usi_style_tag";
				document.getElementsByTagName('head')[0].appendChild(usi_css);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		place_div:function() {
			usi_js.trace('place_div()');
			try {
				if (document.getElementById("usi_display") == null && document.getElementsByTagName("body")[0]) {
					var display_div = document.createElement("div");
					display_div.setAttribute("id","usi_display");
					display_div.style.zIndex = 2000010000;
					display_div.style.position = 'fixed';
					display_div.style.display = 'none';
					display_div.setAttribute("role", "alertdialog");
					display_div.setAttribute("aria-label", "usi_display");
					display_div.setAttribute("aria-modal", "true");
					display_div.className = "usi_hide_css usi_display";
					
					var usi_container = document.createElement("div");
					usi_container.setAttribute("id","usi_container");
					document.getElementsByTagName("body")[0].appendChild(usi_container);
					usi_container.appendChild(display_div);
					
					var display_html = "";
					/** Test Data: START */
					
					/** Test Data: END */
					if (usi_cookies.get("usi_enable") == "2") {
						usi_js.load_js("utility/testing_util.jsp");
					} else if (usi_cookies.get("usi_enable") == "wizard") {
						usi_js.load_js("utility/wizard.jsp");
					}
					/** Extra Javascript: START */
					// Active cart site IDs
var new_user_site_ids = [54483, 54487, 54491];
var extension_user_site_ids = [54495, 54499, 54503];
var reconversion_user_site_ids = [54507, 54511, 54515];

var image_site_ids = [54481, 54483, 54493, 54495, 54505, 54507]
var video_site_ids = [54485, 54487, 54497, 54499, 54509, 54511]
var music_site_ids = [54489, 54491, 54501, 54503, 54513, 54515]

 
var affiliate_link_id = ''
var shared_id = ''

if(usi_app.is_enabled) {
  if(new_user_site_ids.includes(usi_js.campaign.original_site_id)) {
    shared_id = 'New';
  } else if(extension_user_site_ids.includes(usi_js.campaign.original_site_id)) {
    shared_id = 'Extension';  
  } else if(reconversion_user_site_ids.includes(usi_js.campaign.original_site_id)) {
    shared_id = 'Reconversion';  
  }

  if(image_site_ids.includes(usi_js.campaign.original_site_id)) {
    affiliate_link_id = '42913'
  } else if(video_site_ids.includes(usi_js.campaign.original_site_id)) {
    affiliate_link_id = '1348628'
  } else if(music_site_ids.includes(usi_js.campaign.original_site_id)) {
    affiliate_link_id = '949345'
  }

  if(affiliate_link_id && shared_id) {
    usi_js.campaign.deep_link = 'https://shutterstock.7eer.net/c/16669/' + affiliate_link_id + '/1305?sharedid=' + shared_id + '&url=';  
  }
}


if(usi_date.is_before('2025-01-06T23:59:00-08:00')) {
  usi_commons.log('[usi] SHUTTERSTOCK Q4 20% OFF OVERRIDE');
	usi_app.messaging = usi_app.get_messaging('sitewide_20percent_q42024')
  usi_js.campaign.coupon = 'USF20OFF';
}

usi_js.click_cta = function(){
	usi_js.set_coupon();
	if (location.href.indexOf("/purchase") != -1) {
    usi_app.coupon = usi_cookies.get("usi_coupon");
    usi_app.apply_coupon();
    usi_js.link_injection();
  } else {   	 
    usi_js.deep_link();    
  }
};

usi_js.pre_display = function() {
	if(document.querySelector('.MuiDialog-container') != null) {
    usi_commons.log("[usi] Can't launch because client modal is open")
    return false;
  }
  
  return true;
};

usi_js.post_display = function(){
	var usi_header_text = document.querySelector(".usi_header_text");
  if (usi_header_text) {
  	usi_dom.fit_text(usi_header_text)
  }
  var usi_text_bottom = document.querySelector(".usi_text_bottom");
  if (usi_text_bottom) {
  	usi_dom.fit_text(usi_text_bottom)
  }
}

usi_js.display_vars.p1_html = [
  '<div class="usi_header_text">',(usi_app.messaging.header1 || ""),'</div>',
  '<div class="usi_text_bottom">',usi_app.messaging.header2,'</div>',
	'<button class="usi_submitbutton" onclick="usi_js.click_cta();" type="button">',usi_app.messaging.cta,'</button>',
].join('');


					/** Extra Javascript: END */
					if (typeof(usi_js.display_vars.css) != "undefined" && usi_js.display_vars.css != "") {
						usi_js.place_css(usi_js.display_vars.css);
					}
					if (usi_js.display_vars.background != "") {
						display_html += usi_js.place_background();
					}
					if (usi_js.display_vars.p1 != "") {
						display_html += '<div id="usi_page"></div>';
					}
					display_div.innerHTML = '<button type="button" id="usi_close" aria-label="' + usi_js.translations.close_modal + '"></button><div id="usi_content"></div>' + display_html;
					usi_js.load_page(1);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
				return false;
			}
			return true;
		},
		post_set_backtrap:function() {},
		post_close:function() {
			try {
				usi_js.trace('post_close()');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		post_display:function(launchMethod) {
			try {
				usi_js.trace('post_display()');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		pre_close:function() {
			try {
				usi_js.trace('pre_close()');
				return true;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		pre_display:function() {
			try {
				usi_js.trace('pre_display()');
				return true;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		preload_img:function(src, srcset) {
			try {
				usi_js.trace('preload_img(' + src + ')');
				if (typeof(src) != "undefined" && src != null && src.indexOf("//") != -1) {
					var img_preloader= document.createElement("div");
					document.getElementsByTagName('body')[0].appendChild(img_preloader);
					img_preloader.innerHTML = '<div style="position:absolute;left:-20000px !important;top:-20000px !important;"><img aria-hidden="true" src="'+src+'" '+(srcset ? 'srcset="'+srcset+'" ' : "")+'onerror="usi_js.error_report_image(event, this);"/></div>';
					var imageArray = new Image();
					imageArray.src = src;
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		print_trace:function() {
			try {
				usi_js.log('--- VIEW TRACE ---');
				usi_js.trace_items.forEach(function(trace_item) {
					usi_js.log(trace_item);
				});
				usi_js.log('--- END VIEW TRACE ---');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		pull_coupon:function(coupon) {
			try {
				usi_js.trace('pull_coupon(' + coupon + ')');
				if (usi_js.campaign.reuse_coupon && usi_cookies.get("usi_coupon") != null) {
					return usi_js.promo_callback(usi_cookies.get("usi_coupon"));
				}
				if (!coupon) usi_js.load_js("utility/promo.jsp?promo_desc="+usi_js.campaign.coupon.replace("dynamic:","")+"&companyID="+usi_js.campaign.company_id+"&id=" + usi_js.campaign.id+"&session="+usi_js.get_session());
				else usi_js.load_js("utility/promo.jsp?promo_desc="+coupon+"&companyID="+usi_js.campaign.company_id+"&id="+usi_js.campaign.id+"&session="+usi_js.get_session());
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		promo_callback:function(usi_promo) {
			try {
				usi_js.trace('promo_callback(' + usi_promo + ')');
				usi_cookies.set("usi_coupon", encodeURIComponent(usi_promo), usi_cookies.expire_time.day, true);
				if (usi_js.campaign.email_id != 0) {
					usi_js.send_data("usi_coupon", usi_promo);
				}
				usi_js.load_page(2);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		register_onbeforeunload:function() {
			try {
				usi_js.trace('register_onbeforeunload()');
				usi_js.attach_event('beforeunload', usi_js.onbeforeunload_called, window);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		remove_class: function (element, className) {
			try {
				if (element != null) {
					var existingClasses = usi_js.get_classes(element);
					var newClasses = [];
					existingClasses.forEach(function (existingClass) {
						if (existingClass !== className) {
							newClasses.push(existingClass);
						}
					});
					element.className = newClasses.join(' ');
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		remove_onbeforeunload:function() {
			try {
				usi_js.trace('remove_onbeforeunload()');
				usi_js.timers.remove_onbeforeunload = setTimeout(function(){
					if (typeof(usi_js) === "undefined") return;
					usi_js.detach_event('beforeunload', usi_js.onbeforeunload_called, window);
				}, 2000);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		remove_display_div:function() {
			try {
				usi_js.trace('remove_display_div()');
				if (document.getElementById("usi_display") != null) {
					document.getElementById("usi_display").className = "usi_hide_css usi_display";
					usi_js.timers.remove_display_div = setTimeout(function(){
						if (document.getElementById("usi_display") != null) {
							document.getElementById("usi_display").style.display = "none";
						}
					}, usi_js.display_vars.transition_speed);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		remove_js:function(usi_js_id) {
			try {
				usi_js.trace('remove_js()');
				var scriptToRemove = document.getElementById("usi_AJAXScript"+usi_js_id);
				if (scriptToRemove != null) {
					document.getElementsByTagName("head")[0].removeChild(scriptToRemove);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		remove_shadow_div:function() {
			try {
				usi_js.trace('remove_shadow_div()');
				if (document.getElementById("usi_shadow") != null) {
					document.getElementById("usi_shadow").style.display = "none";
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		send_data:function(name, value) {
			try {
				usi_js.trace('send_data(' + name + ' = ' + value + ')');
				usi_js.load_js("hound/saveData.jsp?siteID=" + usi_js.campaign.email_id + "&onsite_configID=" + usi_js.campaign.config_id + "&USI_value=" + encodeURIComponent(value) + "&USI_name=" + encodeURIComponent(name) + "&USI_Session=" + usi_js.get_session() + "&id=" + usi_js.campaign.id + "&bustCache=" + (new Date()).getTime());
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		heart_beat:function() {
			try {
				if (typeof usi_js === 'undefined') return;
				usi_js.last_beat = usi_js.current_time();
				usi_js.timers.heart_beat = setTimeout(usi_js.heart_beat, 1000);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_backtrap:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('set_backtrap()');
				if (usi_js.campaign.domains != "") {
					for (var i=0; i<usi_js.campaign.domains.split(",").length; i++) {
						if (document.referrer.toLowerCase().indexOf(usi_js.campaign.domains.split(",")[i].trim()) != -1) {
							usi_js.page_status.back_means_exit = 0;
						}
					}
				}
				usi_js.heart_beat();
				if (usi_js.page_status.back_means_exit == 1 && usi_js.launch.launch_methods.indexOf(usi_js.BACKBUTTON_TRAP) != -1) {
					if (history.pushState) {
						usi_js.check_back_state = function(event) {
							try {
								if (typeof(usi_js) === "undefined") return;
								if (usi_js.page_status.back_means_exit == 1 && usi_js.launch.launch_methods.indexOf(usi_js.BACKBUTTON_TRAP) != -1) {
									if ((usi_js.current_time()-usi_js.last_beat) < 2500) {
										if (usi_js.page_status.back_set && usi_js.page_status.location_hash == usi_js.get_hash() && (usi_js.launch.backtrap_check_against_event_state == 0 || event.state == null || event.state.usi_back != null)) {
											usi_js.detach_event("popstate", usi_js.check_back_state, window);
											if (usi_js.current_time() - usi_js.page_status.back_state_set_time > usi_js.launch.backtrap_timestamp_difference) {
												if (usi_js.launch.back_trap_window_stop == 1) {
													window.stop();
												}
												if (usi_js.display(false, usi_js.BACKBUTTON_TRAP)) {
													usi_js.back_trap_launched();
												}
											}
										}
									}
								}
							} catch(err) {
								if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
							}
						};
						usi_js.attach_event("popstate", usi_js.check_back_state, window);
						if (usi_js.machine.is_iphone) usi_js.timers.set_backtrap_timeout = usi_js.set_backtrap_timeout();
						else usi_js.timers.set_backtrap_timeout = setTimeout(usi_js.set_backtrap_timeout, usi_js.launch.backtrap_placement_delay);
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_backtrap_timeout:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.page_status.location_hash = usi_js.get_hash();
				usi_js.page_status.back_state_set_time = usi_js.current_time();
				history.pushState({"usi_back":"true"+Math.random()}, null, location.href);
				usi_js.page_status.back_set = true;
				usi_js.log('Backtrap set');
				usi_js.trace('Backtrap set');
				usi_js.post_set_backtrap();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_backtrap_delay:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				if (typeof(document.readyState) != "undefined" && document.readyState !== "complete") {
					if (usi_js.machine.is_iphone) return;
					usi_js.timers.set_backtrap_delay = setTimeout(usi_js.set_backtrap_delay, 1500);
				} else {
					if (typeof(usi_js.back_trap_set) === "undefined") {
						usi_js.back_trap_set = true;
						if (usi_js.machine.is_iphone) usi_js.set_backtrap();
						else usi_js.timers.set_backtrap = setTimeout(usi_js.set_backtrap, 10 + usi_js.launch.backtrap_load_delay);
						usi_js.detach_event("scroll", usi_js.set_backtrap_delay, window);
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_focus_trap:function () {
			try {
				var usi_display = document.getElementById("usi_display");
				if (usi_display != null) {
					usi_js.attach_event("keydown", usi_js.focus_trap, usi_display);
					var focus_element = usi_display.querySelector("#usi_content button, #usi_content a");
					if (typeof usi_js.focus_element != 'undefined') {
						focus_element = usi_js.focus_element;
					}
					if (focus_element != null) {
						focus_element.focus();
					}
					if (document.getElementById("end_focus_trap") == null) {
						var end_focus_trap = document.createElement('div');
						end_focus_trap.id = 'end_focus_trap';
						end_focus_trap.setAttribute('tabindex', '0');
						usi_display.appendChild(end_focus_trap);
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_shadow_click_close:function() {
			try {
				usi_js.trace('set_shadow_click_close()');
				if (document.getElementById("usi_shadow") != null) {
					document.getElementById("usi_shadow").onclick = usi_js.close;
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_coupon:function() {
			try {
				usi_js.trace('set_coupon()');
				if (typeof(usi_js.campaign.coupon) !== "undefined") {
					usi_cookies.set("usi_coupon", encodeURIComponent(usi_js.campaign.coupon), usi_cookies.expire_time.day, true);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		reset_timer:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				var date = new Date();
				usi_js.timestamp = date.getTime();
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		check_for_idle:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				var date = new Date();
				if ((date.getTime() - usi_js.timestamp) > usi_js.launch.launch_delay) {
					usi_js.display(false, usi_js.PROACTIVE_METHOD);
				} else {
					usi_js.timers.check_for_idle = setTimeout(usi_js.check_for_idle, 1000);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		set_triggers:function() {
			try {
				usi_js.trace('set_triggers(' + usi_js.launch.launch_methods + ')');
				if (usi_js.launch.launch_methods.indexOf(usi_js.PREDICTIVE_METHOD) != -1) {
					usi_js.start_mouse_monitor();
					usi_js.register_onbeforeunload();
				}
				if (usi_js.launch.launch_methods.indexOf(usi_js.BACKBUTTON_TRAP) != -1) {
					if (usi_js.machine.is_iphone) usi_js.attach_event("click", usi_js.set_backtrap_delay, document);
					else usi_js.set_backtrap_delay();
				}
				if (usi_js.launch.launch_methods.indexOf(usi_js.PROACTIVE_METHOD) != -1) {
					if (usi_js.launch.proactive_idle == 1) {
						document.addEventListener("mousemove", usi_js.reset_timer, false);
						document.addEventListener("mousedown", usi_js.reset_timer, false);
						document.addEventListener("keypress", usi_js.reset_timer, false);
						document.addEventListener("touchmove", usi_js.reset_timer, false);
						document.addEventListener("click", usi_js.reset_timer, false);
						document.addEventListener("scroll", usi_js.reset_timer, false);
						usi_js.reset_timer();
						usi_js.check_for_idle();
					} else {
						usi_js.timers.launch_delay = setTimeout(function(){
							usi_js.display(false, usi_js.PROACTIVE_METHOD);
						}, 10+usi_js.launch.launch_delay);
					}
				}
				if (usi_js.launch.tab_detection_time > 0) {
					usi_js.start_focus_monitor();
				}
				if (usi_js.launch.launch_methods.indexOf(usi_js.SCROLL) > -1) {
					usi_js.timers.scroll_monitor = setTimeout(usi_js.scroll_monitor, usi_js.launch.scroll_placement_delay);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		start_focus_monitor:function() {
			try {
				usi_js.trace('start_focus_monitor()');
				usi_js.attach_event("focus", usi_js.window_focus, window);
				usi_js.attach_event("blur", usi_js.window_blur, window);
				usi_js.attach_event("resize", usi_js.window_resize, window);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		start_tab_detection:function() {
			try {
				usi_js.trace('start_tab_detection()');
				if (usi_js.launch.tab_detection_time > 0) {
					usi_js.page_status.resize_happened = 0;
					usi_js.timers.check_for_change_events = setTimeout(function(){
						if (typeof(usi_js) === "undefined") return;
						usi_js.check_for_change_events(usi_js.launch.tab_detection_time/250);
					}, 250);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		start_mouse_monitor:function() {
			try {
				usi_js.trace('start_mouse_monitor()');
				usi_js.attach_event("mouseout", usi_js.mouse_out);
				usi_js.attach_event("mouseover", usi_js.mouse_over);
				if (usi_js.launch.no_mouse_move == 0) usi_js.attach_event("mousemove", usi_js.mouse_move);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		stop_mouse_monitor:function() {
			try {
				usi_js.trace('stop_mouse_monitor()');
				usi_js.detach_event("mouseout", usi_js.mouse_out);
				usi_js.detach_event("mouseover", usi_js.mouse_over);
				if (usi_js.launch.no_mouse_move == 0) usi_js.detach_event("mousemove", usi_js.mouse_move);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		stop_timers:function() {
			try {
				usi_js.trace('stop_timers()');
				for (var t in usi_js.timers) {
					clearTimeout(usi_js.timers[t]);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		stop_focus_monitor:function() {
			try {
				usi_js.trace('stop_focus_monitor()');
				usi_js.detach_event("focus", usi_js.window_focus, window);
				usi_js.detach_event("blur", usi_js.window_blur, window);
				usi_js.detach_event("resize", usi_js.window_resize, window);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		scroll_launched: function() {
		},
		scroll_monitor: function(do_launch) {
			try {
				if (typeof(usi_js) === "undefined") return;
				if (usi_js.previous_scroll_height != document.body.scrollHeight) {
					do_launch = false;
				}
				usi_js.previous_scroll_height = document.body.scrollHeight;
				if ((window.innerHeight || document.body.clientHeight || 0)*Number(usi_js.launch.window_ratio) < document.body.scrollHeight) {
					var usi_activation_zone = false;
					var usi_scroll_top = document.scrollingElement ? document.scrollingElement.scrollTop : document.documentElement.scrollTop;
					var percentage_scrolled = Math.floor(usi_scroll_top / (document.body.scrollHeight - (window.innerHeight || document.body.clientHeight || 0)) * 100);
					if (usi_js.page_status.previous_scroll_position < usi_scroll_top) {
						usi_js.page_status.scroll_timer = 0;
					} else if (usi_js.page_status.previous_scroll_position > usi_scroll_top) {
						if (usi_js.page_status.scroll_timer == 0) {
							usi_js.page_status.scroll_timer = Number(new Date());
						}
					}
					usi_js.page_status.previous_scroll_position = usi_scroll_top;
					if ((usi_js.launch.activation_start_unit == "px" && usi_scroll_top > Number(usi_js.launch.activation_start)) || (usi_js.launch.activation_start_unit == "%" && percentage_scrolled > Number(usi_js.launch.activation_start))) {
						usi_activation_zone = true;
					}
					if (usi_activation_zone) {
						usi_js.page_status.scroll_activation_hit = true;
					}
					if (usi_js.page_status.scroll_activation_hit) {
						if (usi_js.launch.require_scroll_up == "0") {
							if (usi_activation_zone) {
								if (do_launch) {
									if (usi_js.display(true, usi_js.SCROLL)) usi_js.scroll_launched();
									return;
								}
							} else {
								usi_js.timers.scroll_top_delay = setTimeout(usi_js.scroll_top_delay, usi_js.launch.scroll_top_launch_delay);
								return;
							}
						} else if ((usi_js.launch.launch_start_unit == "px" && usi_scroll_top <= Number(usi_js.launch.launch_start)) || (usi_js.launch.launch_start_unit == "%" && percentage_scrolled <= Number(usi_js.launch.launch_start))) {
							if (do_launch) {
								if (usi_js.display(true, usi_js.SCROLL)) usi_js.scroll_launched();
								return;
							} else {
								if ((Number(new Date()) - usi_js.page_status.scroll_timer) < Number(usi_js.launch.scroll_up_speed)) {
									usi_js.timers.scroll_top_delay = setTimeout(usi_js.scroll_top_delay, usi_js.launch.scroll_top_launch_delay);
									return;
								}
							}
						}
					}
				}
				usi_js.timers.scroll_monitor = setTimeout(usi_js.scroll_monitor, 500);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		scroll_top_delay: function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.scroll_monitor(true);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		submit_product:function() {
			try {
				usi_js.trace('submit_product()');
				for (var key in usi_js.product) {
					if (usi_js.product.hasOwnProperty(key)) {
						var obj = usi_js.product[key];
						if (obj != null) {
							usi_js.send_data(key, obj);
						}
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		submit_success:function() {
			try {
				usi_js.trace('submit_success()');
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		submit:function() {
			try {
				usi_js.trace('submit()');
				var usi_email = document.getElementById("usi_email");
				if (usi_email != null && usi_js.validate_email(usi_email.value.trim())) {
					usi_js.send_data("usi_email", usi_email.value.trim());
					usi_js.submit_product();
				} else if (usi_email != null) {
					usi_js.custom_alert(usi_js.translations.email_alert);
					usi_email.focus();
					return;
				}
				usi_js.submit_success();
				if (usi_js.campaign.coupon.indexOf("dynamic:") != -1) {
					usi_js.pull_coupon();
				} else if (usi_js.campaign.coupon != "") {
					usi_js.promo_callback(usi_js.campaign.coupon);
				} else {
					usi_js.load_page(2);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		suppress:function(seconds) {
			try {
				usi_js.trace('suppress(' + seconds + ')');
				seconds = seconds || 30*24*60*60;
				usi_js.launch.enabled = false;
				usi_js.launch.suppress = true;
				usi_cookies.set("usi_suppress"+usi_js.campaign.cookie_append, "t"+usi_js.current_time(), seconds, true);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		trace:function(trace_item) {
			try {
				usi_js.trace_items.push(trace_item);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		transitions_allowed:function() {
			try {
				usi_js.trace('transitions_allowed()');
				var p = document.createElement('p').style;
				var allowed = ('transition' in p || 'WebkitTransition' in p || 'MozTransition' in p || 'msTransition' in p || 'OTransition' in p);
				if (!allowed) usi_js.display_vars.transition_speed = 0;
				return allowed;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		validate_email:function(email) {
			try {
				usi_js.trace('validate_email(' + email + ')');
				var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
				return re.test(email);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		verify_email_loop_result:function(isokay) {
			try {
				var emailCheck = document.getElementById("usi_email_good");
				if (emailCheck != null) {
					if (!isokay && emailCheck.src.indexOf(usi_js.display_vars.emailerror) == -1) {
						emailCheck.src = usi_js.campaign.images + usi_js.display_vars.emailerror;
						emailCheck.alt = usi_js.translations.email_bad;
					} else if (isokay && emailCheck.src.indexOf(usi_js.display_vars.emailsuccess) == -1) {
						emailCheck.src = usi_js.campaign.images + usi_js.display_vars.emailsuccess;
						emailCheck.alt = usi_js.translations.email_good;
					}
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		verify_email_loop:function() {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('verify_email_loop()');
				if (document.getElementById("usi_email") != null) {
					var emailInput = document.getElementById("usi_email");
					var email = emailInput.value;
					if (usi_js.page_status.email_last != email && email != emailInput.title) {
						usi_js.page_status.email_last = email;
						usi_js.verify_email_loop_result(usi_js.validate_email(email.trim()));
					}
					usi_js.timers.verify_email_loop_id = setTimeout(usi_js.verify_email_loop, 1000);
				}
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		window_resize:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('window_resize()');
				usi_js.page_status.resize_happened = 1;
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		window_blur:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('window_blur()');
				usi_js.page_status.focus = 'blur';
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		},
		window_focus:function(event) {
			try {
				if (typeof(usi_js) === "undefined") return;
				usi_js.trace('window_focus()');
				usi_js.page_status.focus = 'focus';
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		}
	};
	usi_js.build();
}