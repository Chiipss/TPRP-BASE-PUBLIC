//GNU General Public License v3.0
//Created by Scotty1944
//Do not modify it
(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD. Register as an anonymous module.
		define(['jquery'], factory);
	} else if (typeof exports === 'object') {
		// Node/CommonJS
		factory(require('jquery'));
	} else {
		// Browser globals
		factory(jQuery);
	}
}(function ($) {
	// Create the defaults once
	var defaults = {
		element: 'body',
		position: null,
		type: "info",
		allow_dismiss: true,
		newest_on_top: false,
		showProgressbar: false,
		placement: {
			from: "top",
			align: "right"
		},
		offset: 20,
		spacing: 10,
		z_index: 1031,
		delay: 5000,
		timer: 1000,
		url_target: '_blank',
		mouse_over: null,
		animate: {
			enter: 'animated fadeInDown',
			exit: 'animated fadeOutUp'
		},
	};
	
	$.fn.exists = function(){
		return this.length > 0;
	};
	
	Math.Clamp = function(val, min, max) {
		return Math.min(Math.max(val, min), max);
	};
	
	String.format = function() {
	  var s = arguments[0];
	  for (var i = 0; i < arguments.length - 1; i++) {       
		var reg = new RegExp("\\{" + i + "\\}", "gm");             
		s = s.replace(reg, arguments[i + 1]);
	  }

	  return s;
	};
	
	String.Format = function(str) {
		var args = arguments,
		flag = true,
		i = 1;

		str = str.replace(/%s/g, function() {
			var arg = args[i++];

			if (typeof arg === 'undefined') {
				flag = false;
				return '';
			}
			return arg;
		});
		return flag ? str : '';
	};
	
	String.Comma = function(num){ 
		var parts = num.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	};
	
	$.zIndex = function( html, zIndex ) {
		if ( zIndex !== undefined ) {
			return html.css( "zIndex", zIndex );
		}

		if ( html.length ) {
			var elem = $( html[ 0 ] ), position, value;
			while ( elem.length && elem[ 0 ] !== document ) {
				// Ignore z-index if position is set to a value where z-index is ignored by the browser
				// This makes behavior of this function consistent across browsers
				// WebKit always returns auto if the element is positioned
				position = elem.css( "position" );
				if ( position === "absolute" || position === "relative" || position === "fixed" ) {
					// IE returns 0 when zIndex is not specified
					// other browsers return a string
					// we ignore the case of nested elements with an explicit value of 0
					// <div style="z-index: -10;"><div style="z-index: 0;"></div></div>
					value = parseInt( elem.css( "zIndex" ), 10 );
					if ( !isNaN( value ) && value !== 0 ) {
						return value;
					}
				}
				elem = elem.parent();
			}
		}

		return 0;
	};
	
	$.FormattedTime = function( seconds ){
		var days = Math.floor( seconds / 86400 );
		var hours = Math.floor( (seconds / 3600) % 24 );
		var minutes = Math.floor( ( seconds / 60 ) % 60 );
		var millisecs = ( seconds - Math.floor( seconds ) ) * 100;
		
		seconds = Math.floor( seconds % 60 );

		return {
			"d": days,
			"h": hours,
			"m": minutes,
			"s": seconds,
			"ms": millisecs
		};
	};
	
	$.TimeAgo = function(second, nice){
		var now = Date.now() / 1000;
		var time = (now - second);
		
		var day_text = "day";
		var hour_text = "hour";
		var min_text = "minute";
		var second_text = "second";

		var final_str = "";
		var formated_time = $.FormattedTime(time);
		var ft = formated_time;
		
		if (!nice){
			if ((formated_time.d + "").length <= 1)
				formated_time.d = ("0" + formated_time.d);
			if ((formated_time.h + "").length <= 1)
				formated_time.h = ("0" + formated_time.h);
			if ((formated_time.m + "").length <= 1)
				formated_time.m = ("0" + formated_time.m);
			if ((formated_time.s + "").length <= 1)
				formated_time.s = ("0" + formated_time.s);
			if ((formated_time.ms + "").length <= 1)
				formated_time.ms = ("0" + formated_time.ms);
		}
		
		if (time >= 86400) {
			final_str = String.format("{0}:{1}:{2}", formated_time.h, formated_time.m, formated_time.s);
			if (nice) {
				final_str = String.format("{0} " + day_text + " {1} " + hour_text + " {2} " + min_text + " {3} " + second_text + "", ft.d, ft.h, ft.m, ft.s);
			}
		}else if (time >= 3600) {
			final_str = String.format("{0}:{1}:{2}", formated_time.h, formated_time.m, formated_time.s);
			if (nice) {
				final_str = String.format("{0} " + hour_text + " {1} " + min_text + " {2} " + second_text + "", formated_time.h, formated_time.m, formated_time.s);
			}
		}else if (time >= 60) {
			final_str = String.format("{0}:{1}", formated_time.m, formated_time.s);
			if (nice) {
				final_str = String.format("{0} " + min_text + " {1} " + second_text + "", formated_time.m, formated_time.s);
			}
		}else{
			final_str = String.format("{0}", formated_time.s);
			if (nice) {
				final_str = String.format("{0} " + second_text + "", formated_time.s);
			}
			if (time <= 0) {
				final_str = "0";
				if (nice) {
					final_str = "0 second";
				}
			}
		}
		return final_str + " before";
	};

	$.dVal = function(val, defaultVal){
		return val !== undefined ? val : defaultVal;;
	};

	$.commaVal = function(x) {
		var parts = x.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}

	var defID = "scottyDialog"
	var template = '<div id="'+defID+'{0}" class="dialog"><h2 style="color:black; font-family:\'SF Pro Text\'; padding-left:1%; padding-right:1%;">{1}</h2><p class="text-pad" style="color:gray;">{2}</p><div class="dialog-btn-div"><input type="submit" value="CANCEL" onclick="$({3}).fadeOut(\'fast\', function(){ window[\'{4}\'](); });" class="dialog-btn-left" style="font-family:\'SF Pro Text\';"><input type="submit" onclick="$({5}).fadeOut(\'fast\', function(){ window[\'{6}\'](); });" value="OK" class="dialog-btn-right"></div></div>';
	var template2 = '<div id="'+defID+'{0}" class="dialog"><h2 style="color:black; font-family:\'SF Pro Text\'; padding-left:1%; padding-right:1%;">{1}</h2><p class="text-pad" style="color:gray;">{2}</p><div class="dialog-btn-div"><input type="submit"onclick="$({3}).fadeOut(\'fast\', function(){ window[\'{4}\'](); });" value="OK" class="dialog-btn-middle"></div></div>';
	var template3 = '<div id="'+defID+'{0}" class="dialog"><h2 style="color:black; font-family:\'SF Pro Text\'; padding-left:1%; padding-right:1%;">{1}</h2><p class="text-pad" style="color:gray;">{2}</p><input id="sd{3}_text" class="dialog-input" type="text" placeholer="{4}" value="{5}"><br><br><div class="dialog-btn-div"><input type="submit" value="CANCEL" onclick="$({6}).fadeOut(\'fast\', function(){ window[\'{7}\'](); });" class="dialog-btn-left" style="font-family:\'SF Pro Text\';"><input type="submit" onclick="$({8}).fadeOut(\'fast\', function(){ var text = $(\'#sd{9}_text\').val(); window[\'{10}\'](text); });" value="OK" class="dialog-btn-right"></div></div>';

	function Dialog (title, message, cb, cb2) {
		if($(".dialog")[0]){
			$(".dialog").fadeOut(100, function(){
				$(".dialog").remove();
			});
		}
		var random = Math.floor(Math.random() * (+9999999 - +0)) + +0;
		var def = "'#"+defID+random+"'";
		
		window["sd"+random+"_accept"] = function(){
			if (typeof(cb) != "undefined") {
				cb();
			}
		};
		window["sd"+random+"_decline"] = function(){
			if (typeof(cb2) != "undefined") {
				cb2();
			}
		};

		$( "body" ).append($(String.format(template, random, title, message, def, "sd"+random+"_decline", def, "sd"+random+"_accept")).hide().fadeIn());
	};

	function Dialog2 (title, message, cb) {
		if($(".dialog")[0]){
			$(".dialog").fadeOut(100, function(){
				$(".dialog").remove();
			});
		}
		var random = Math.floor(Math.random() * (+9999999 - +0)) + +0;
		var def = "'#"+defID+random+"'";
		
		window["sd"+random+"_accept"] = function(){
			if (typeof(cb) != "undefined") {
				cb();
			}
		};

		$( "body" ).append($(String.format(template2, random, title, message, def, "sd"+random+"_accept")).hide().fadeIn());
	};
	
	function Dialog3 (title, message, placeholder, value, cb, cb2) {
		if($(".dialog")[0]){
			$(".dialog").fadeOut(100, function(){
				$(this).remove();
			});
		}
		var random = Math.floor(Math.random() * (+9999999 - +0)) + +0;
		var def = "'#"+defID+random+"'";
		
		window["sd"+random+"_accept"] = function(...args){
			if (typeof(cb) != "undefined") {
				cb(args);
			}
		};
		window["sd"+random+"_decline"] = function(){
			if (typeof(cb2) != "undefined") {
				cb2();
			}
		};
		
		if (typeof(placeholder) == "undefined") {
			placeholder = "";
		}

		$( "body" ).append($(String.format(template3, random, title, message, random, placeholder, value, def, "sd"+random+"_decline", def, random, "sd"+random+"_accept")).hide().fadeIn());
	};

	$.displayConfirm = function ( content, options ) {
		var plugin = new Dialog(content.title, content.message, content.onaccept, content.ondecline );
		return plugin.displayConfirm;
	};
	
	$.displayRequest = function ( content, options ) {
		var plugin = new Dialog3(content.title, content.message, content.placeholder, content.value, content.onaccept, content.ondecline );
		return plugin.displayConfirm;
	};
	
	$.displayDialog = function ( content, options ) {
		var plugin = new Dialog2(content.title, content.message, content.onaccept );
		return plugin.displayDialog;
	};
	
	var temp = '<div class="category" id="category-{0}"><a class="category-link" id="category-link-{1}">{2}</a><div class="category-content" id="category-content-{3}"></div></div>';
	function CreateCategory(html,title){
		var random = Math.floor(Math.random() * (+9999999 - +0)) + +0;
		var app = String.format(temp, random, random, title, random);
		$(html).append(app);
		
		$("#category-link-"+random).click(function(){
			$("#category-content-"+random).slideToggle( "fast", function() {
				
			});
		});
		return $('#category-'+random);
	}
	
	var temp2 = '<a class="category-link-content"> - {0}</a>';
	function CreateCategoryLink(html,title,cb){
		var app = $(String.format(temp2, title));
		$(html).children("div").append(app);
		
		app.click(function(){
			if (typeof(cb) != "undefined"){
				cb();
			}
		})
		return app;
	}
	
	$.createCategory = function (html,title) {
		var plugin = new CreateCategory(html,title);
		return plugin;
	};
	
	$.createCategoryLink = function (html,title,cb) {
		var plugin = new CreateCategoryLink(html,title,cb);
		return plugin;
	};
	
	var temp_tool = "<div class=\"tooltip\">{0}</div>";
	function CreateTooltip(html,content){
		var mouse_func = function(e) {
			if ($(".rmenu")[0] || $(".ui-draggable-dragging")[0]){
				return false;
			}
			
			if ($(".tooltip")[0]){
				$(".tooltip").remove();
			}
			
			var app = $(String.format(temp_tool, content));
			$("html").append(app);
			
			app.off();
			
			app.css({left:e.pageX+5, top:e.pageY+5});
			
			app.fadeIn("fast");
			
			var mousemove = function( e ) {
				app.css({left:e.pageX+5, top:e.pageY+5});
			}
			
			var mouseleave = function() {
				app.fadeOut(50, function() {
					app.remove();
				});
			}
			
			html.data("tooltip", app);
			
			html.data("tooltip_mm", mousemove);
			html.data("tooltip_ml", mouseleave);
			
			html.on("mousemove", mousemove);
			html.on("mouseleave", mouseleave);
		}
		
		html.data("tooltip", mouse_func);
		html.on("mouseover", mouse_func);
		html.on("remove", function(){
			if (html.data("tooltip") !== undefined){
				html.data("tooltip").remove();
			}
		});
	}
	
	$.createTooltip = function (html,content) {
		var plugin = new CreateTooltip(html,content);
	};
	
	var temp_rmenu = '<div class="rmenu"></div>';
	var temp_rmenu2 = '<div class="rmenu-c"></div>';
	function CreateRMenu(html, content){
		var ex_func = html.data("rmenu");
		var context_func = function(e){
			var menu = $(temp_rmenu);
			$("body").append(menu);
			$("html").find(".tooltip").remove();
			
			$.each(content, function (index, value) {
				var title = value["title"];
				var app = $('<a>'+title+'</a>');
				
				if (value["tree"] !== undefined){
					app.append('<i class="rmenu-arrow-left"/>');
				}
				
				menu.append(app);
				if (value["func"] !== undefined) {
					app.click(function(){
						if (typeof(value["func"]) != "undefined") {
							value["func"]();
						}
					});
				}

				app.on("mouseover", function(){
					if (menu.data("tree") !== undefined && menu.data("tree_k") == index)
						return;
					
					if (menu.data("tree") !== undefined && menu.data("tree_k") != index){
						menu.data("tree").remove();
					}
					
					if (value["tree"] === undefined)
						return;

					var pos = {
						"left": (app.offset().left - $(window).scrollLeft()),
						"top": (app.offset().top - $(window).scrollTop()),
					};
					
					var menu2 = $(temp_rmenu2);
					menu2.hide();
					$("body").append(menu2);
					
					menu.data("tree", menu2);
					menu.data("tree_k", index);
					
					$.each(value["tree"], function(i, v){
						var app2 = $('<a>'+v["title"]+'</a>');
						menu2.append(app2);
						
						if (v["func"] !== undefined) {
							app2.click(function(){
								if (typeof(v["func"]) != "undefined") {
									v["func"]();
								}
							});
						}
					});
					
					menu2.css({left:pos.left + menu.width(), top:pos.top});
					menu2.fadeIn(100);
					
					var co = false;
					
					menu.on("remove", function () {
						menu2.remove();
					});
					
					menu2.on("remove", function () {
						menu2.remove();
						menu.removeData("tree");
						menu.removeData("tree_k");
					});
					
					menu.add(menu2).on('mouseenter', function() {
						co = false;
					});
					
					menu.add(menu2).on('mouseleave', function() {
						co = true;
						setTimeout(function () {
							if (co)
								menu2.fadeOut(100, function() { menu2.remove(); });
						}, 50);
					});
				});
			});
			
			menu.css({left:e.pageX+5, top:e.pageY+5});
			
			var func_remove = function(){
				menu.fadeOut(100, function(){ menu.remove(); });
			}
			
			setTimeout(function(){
				$("body").one("click", func_remove);
				$("body").one("contextmenu", func_remove);
			},100);
		}
		
		if(typeof(ex_func) != "undefined"){
			html.off("contextmenu", ex_func);
		}
		html.data("rmenu", context_func);
		html.on("contextmenu", context_func);
	}
	
	function Reset(html){
		var ex_func = html.data("rmenu");
		if(typeof(ex_func) != "undefined"){
			html.off("contextmenu", ex_func);
			html.data("rmenu", null);
		}
		
		var ex_func2 = html.data("tooltip");
		if(typeof(ex_func2) != "undefined"){
			html.off("mouseover", ex_func2);
			html.data("tooltip", null);
			
			html.off("mousemove", html.data("tooltip_mm"));
			html.off("mouseleave", html.data("tooltip_ml"));
			
			html.data("tooltip_mm", null);
			html.data("tooltip_ml", null);
		}
	}
	
	$.resetScottyFunc = function(html){
		Reset(html);
	}
	
	$.createRMenu = function (html,content) {
		var plugin = new CreateRMenu(html,content);
	};
}));