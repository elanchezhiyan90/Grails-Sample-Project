// JavaScript Document

/***************************  Star Buttons- Favorite Marking - for Radio button ***************************/	

$.fn.starradio = function(){
		return this.each(function(){
			if($(this).hasClass('star_hidden')) {return;}

			var $input = $(this);
			var inputSelf = this;
				
			var aLink = $('<a href="'+ this.value +'" class="transform_star" rel="'+ this.name +'" ><span></span></a>');
			$input.addClass('star_hidden').wrap('<span class="star_wrapper"></span>').parent().prepend(aLink);
			
			$input.change(function(){
				inputSelf.checked && aLink.addClass('star_checked') || aLink.removeClass('star_checked');
				return true;
			});
			// Click Handler
			aLink.click(function(){
				if($input.attr('disabled')){return false;}
				$input.trigger('click').trigger('change');
				// uncheck all others of same name input radio elements
				$('input[name="'+$input.attr('name')+'"]',inputSelf.form).not($input).each(function(){
					$(this).attr('type')=='radio' && $(this).trigger('change');
				});
	
				return false;					
			});
			// set the default state
			inputSelf.checked && aLink.addClass('star_checked').parents("li").addClass("active").find(".hstry").show();
		});
	};
/*********************************** star checkbox *******************/

$.fn.starcheckbox = function(){
	return this.each(function(){
		if($(this).hasClass('star_hidden')) {return;}
		var $input = $(this);
		var inputSelf = this;
		var aLink = $('<a href="#" class="transform_star" rel="'+ this.name +'" ><span></span></a>');
		//wrap and add the link
		$input.addClass('star_hidden').wrap('<span class="star_wrapper"></span>').parent().prepend(aLink);
		//on change, change the class of the link
		$input.change(function(){
			this.checked && aLink.addClass('star_checked') || aLink.removeClass('star_checked');
			return true;
		});
		// Click Handler, trigger the click and change event on the input
		aLink.click(function(){
			//do nothing if the original input is disabled
			if($input.attr('disabled')){return false;}
			//trigger the envents on the input object
			$input.trigger('click').trigger("change");
			$('input[name="'+$input.attr('name')+'"]:checked').not($input).each(function(){
				$('input[name="'+$input.attr('name')+'"]:checked').not($input).attr('checked',false).trigger("change");
			});
			return false;
		});

		// set the default state
		this.checked && aLink.addClass('star_checked');		
	});
};
/*********************************** flag checkbox *******************/

$.fn.flagcheckbox = function(){
	return this.each(function(){
		if($(this).hasClass('flag_hidden')) {return;}
		var $input = $(this);
		var inputSelf = this;
		var aLink = $('<a href="#" class="transform_flag" rel="'+ this.name +'" ><span></span></a>');
		//wrap and add the link
		$input.addClass('star_hidden').wrap('<span class="flag_wrapper"></span>').parent().prepend(aLink);
		//on change, change the class of the link
		$input.change(function(){
			this.checked && aLink.addClass('flag_checked') || aLink.removeClass('flag_checked');
			return true;
		});
		// Click Handler, trigger the click and change event on the input
		aLink.click(function(){
			//do nothing if the original input is disabled
			if($input.attr('disabled')){return false;}
			//trigger the envents on the input object
			$input.trigger('click').trigger("change");
			return false;
		});

		// set the default state
		this.checked && aLink.addClass('flag_checked');		
	});
};
//Jquery Combobox- AutoComplete plugin
/* 
 * Exetend from jquery-UI AutoComplete - Combo box(customized)
 * 
*/
(function( $ ) {
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				 select = this.element.hide(),
				clx=select.attr("class"),
				 eror=select.attr("data-errormessage"),
				selected = select.find( ":selected" ),
				phold="Select",
				value = selected.val() ? selected.text() : "",
		   wrapper = this.wrapper = $("<span>")
					.addClass( "ui-combobox" )
					.insertAfter( select );
		
		if(select.attr("data-placeholder")){var phold=select.attr("data-placeholder");}
		if(select.attr("required")){//added new for validation
			var valid=	$('<input required="required" data-errormessage="'+eror+'">')
			select.removeAttr("required")		
		}else{
			var valid=$('<input>')
		}
			var input = valid
				.appendTo( wrapper )
				.val( value ).attr("placeholder", phold)/*fix for ie 9 */
				.addClass( "ui-state-default ui-combobox-input" ).addClass(clx)/*.css({'width':-20})//added new for styling*/
				.autocomplete({
					bullet: (this.options.bullet) ? this.options.bullet : null,
					msg:(this.options.msg)? this.options.msg : null,
					delay: 0,
					minLength: 0,
					source: function( request, response ) {
						var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
						response( select.find( "option" ).map(function() {
								optgroup = $(select).find('option[value="'+this.value+'"]').parent('optgroup');
								if (optgroup.length == 0) {
									var item_category = 0;
								} else {
									var item_category = optgroup.attr('label');
								}
								if( $(this).data('msg')){ 
									var mss="<span class='msg'>"+ $(this).data('msg')+"</span>"; 
									}else{var mss='';}
								
								var text = $( this ).text();
								if ( this.value && ( !request.term || matcher.test(text) ) )
									return {
										label: text.replace(
											new RegExp(
												"(?![^&;]+;)(?!<[^<>]*)(" +
												$.ui.autocomplete.escapeRegex(request.term) +
												")(?![^<>]*>)(?![^&;]+;)", "gi"
											), "<strong>$1</strong>" ),
										value: text,
										category: item_category,
										dmsg:mss,
										option: this
									};
						}) );
						
					},
					select: function( event, ui ) {
						ui.item.option.selected = true;
						self._trigger( "selected", event, {
							item: ui.item.option,
						});
						select.trigger("change"); 
					},
					
					change: function( event, ui ) {
							if ( !ui.item ) {
							var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
								valid = false;
							select.children( "option" ).each(function() {
								if ( $( this ).text().match( matcher ) ) {
									this.selected = valid = true;
									return false;
								}
							});
							if ( !valid ) {
								// remove invalid value, as it didn't match anything
								$( this ).val( "" );
								select.val( "" );
								input.data( "autocomplete" ).term = "";
								select.trigger("change"); 
								return false;
							}
							
						}
					
					}
				})
				.addClass( "ui-widget ui-widget-content ui-corner-left" );

			input.data( "autocomplete" )._renderItem = function( ul, item ) {
				if (this.options.bullet) {
					bullet = '&#8227;';
				} else {
					bullet = '';
				}
				if (this.options.msg){
					msg=item.dmsg ;
				}else{
					msg='';
				}
				return $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<a>" + bullet + item.label +"<br>"+ msg + "</a>" )
					.appendTo( ul );
			};
			input.data( "autocomplete" )._renderMenu = function( ul, items ) {
				var self = this,
					currentCategory = "";
				$.each( items, function( index, item ) {
					if (item.category != 0) {
						if ( item.category != currentCategory ) {
							ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
							currentCategory = item.category;
						}
					}
					self._renderItem( ul, item );
				});
			};
			input.on("blur",function(){// fix to trigger underling element reset to null value option if the component value is empty.
				if(input.val()==""){
					if(select.find("option").val() !==""){
						select.prepend("<option value='' selected='selected' >Select</option> ");
					}
					select.val( "" );
					select.trigger("change"); 
				}
			});
			
		  $( "<a>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "Show All Items" )
				.appendTo( wrapper )
				.button({
					icons: {
						primary: "ui-icon-triangle-1-s"
					},
					text: false
				})
				.removeClass( "ui-corner-all" )
				.addClass( "ui-corner-right ui-combobox-toggle" )
				.click(function() {
					// close if already visible
					if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
						input.autocomplete( "close" );
						return;
					}
					if(input.attr("disabled")){return false}//added new for check disabled
					// work around a bug (likely same cause as #5265)
					$( this ).blur();
					// pass empty string as value to search for, displaying all results
					input.autocomplete( "search", "" );
					input.focus();
				});
		},
		destroy: function() {
			this.wrapper.remove();
			this.element.show();
			$.Widget.prototype.destroy.call( this );
		}
	});
	
})( jQuery );
	
/*! Chosen v0.10.0 | (c) 2011-2013 by Harvest 
* MIT License, https://github.com/harvesthq/chosen/blob/master/LICENSE.md 
*/
(function(){var SelectParser;SelectParser=(function(){function SelectParser(){this.options_index=0;this.parsed=[]}SelectParser.prototype.add_node=function(child){if(child.nodeName.toUpperCase()==="OPTGROUP"){return this.add_group(child)}else{return this.add_option(child)}};SelectParser.prototype.add_group=function(group){var group_position,option,_i,_len,_ref,_results;group_position=this.parsed.length;this.parsed.push({array_index:group_position,group:true,label:group.label,children:0,disabled:group.disabled});_ref=group.childNodes;_results=[];for(_i=0,_len=_ref.length;_i<_len;_i++){option=_ref[_i];_results.push(this.add_option(option,group_position,group.disabled))}return _results};SelectParser.prototype.add_option=function(option,group_position,group_disabled){if(option.nodeName.toUpperCase()==="OPTION"){if(option.text!==""){if(group_position!=null){this.parsed[group_position].children+=1}this.parsed.push({array_index:this.parsed.length,options_index:this.options_index,value:option.value,text:option.text,html:option.innerHTML,selected:option.selected,disabled:group_disabled===true?group_disabled:option.disabled,group_array_index:group_position,classes:option.className,style:option.style.cssText})}else{this.parsed.push({array_index:this.parsed.length,options_index:this.options_index,empty:true})}return this.options_index+=1}};return SelectParser})();SelectParser.select_to_array=function(select){var child,parser,_i,_len,_ref;parser=new SelectParser();_ref=select.childNodes;for(_i=0,_len=_ref.length;_i<_len;_i++){child=_ref[_i];parser.add_node(child)}return parser.parsed};this.SelectParser=SelectParser}).call(this);(function(){var AbstractChosen,root;root=this;AbstractChosen=(function(){function AbstractChosen(form_field,options){this.form_field=form_field;this.options=options!=null?options:{};if(!AbstractChosen.browser_is_supported()){return}this.is_multiple=this.form_field.multiple;this.set_default_text();this.set_default_values();this.setup();this.set_up_html();this.register_observers();this.finish_setup()}AbstractChosen.prototype.set_default_values=function(){var _this=this;this.click_test_action=function(evt){return _this.test_active_click(evt)};this.activate_action=function(evt){return _this.activate_field(evt)};this.active_field=false;this.mouse_on_container=false;this.results_showing=false;this.result_highlighted=null;this.result_single_selected=null;this.allow_single_deselect=(this.options.allow_single_deselect!=null)&&(this.form_field.options[0]!=null)&&this.form_field.options[0].text===""?this.options.allow_single_deselect:false;this.disable_search_threshold=this.options.disable_search_threshold||0;this.disable_search=this.options.disable_search||false;this.enable_split_word_search=this.options.enable_split_word_search!=null?this.options.enable_split_word_search:true;this.search_contains=this.options.search_contains||false;this.single_backstroke_delete=this.options.single_backstroke_delete||false;this.max_selected_options=this.options.max_selected_options||Infinity;return this.inherit_select_classes=this.options.inherit_select_classes||false};AbstractChosen.prototype.set_default_text=function(){if(this.form_field.getAttribute("data-placeholder")){this.default_text=this.form_field.getAttribute("data-placeholder")}else if(this.is_multiple){this.default_text=this.options.placeholder_text_multiple||this.options.placeholder_text||AbstractChosen.default_multiple_text}else{this.default_text=this.options.placeholder_text_single||this.options.placeholder_text||AbstractChosen.default_single_text}return this.results_none_found=this.form_field.getAttribute("data-no_results_text")||this.options.no_results_text||AbstractChosen.default_no_result_text};AbstractChosen.prototype.mouse_enter=function(){return this.mouse_on_container=true};AbstractChosen.prototype.mouse_leave=function(){return this.mouse_on_container=false};AbstractChosen.prototype.input_focus=function(evt){var _this=this;if(this.is_multiple){if(!this.active_field){return setTimeout((function(){return _this.container_mousedown()}),50)}}else{if(!this.active_field){return this.activate_field()}}};AbstractChosen.prototype.input_blur=function(evt){var _this=this;if(!this.mouse_on_container){this.active_field=false;return setTimeout((function(){return _this.blur_test()}),100)}};AbstractChosen.prototype.result_add_option=function(option){var classes,style;option.dom_id=this.container_id+"_o_"+option.array_index;classes=[];if(!option.disabled&&!(option.selected&&this.is_multiple)){classes.push("active-result")}if(option.disabled&&!(option.selected&&this.is_multiple)){classes.push("disabled-result")}if(option.selected){classes.push("result-selected")}if(option.group_array_index!=null){classes.push("group-option")}if(option.classes!==""){classes.push(option.classes)}style=option.style.cssText!==""?" style=\""+option.style+"\"":"";return'<li id="'+option.dom_id+'" class="'+classes.join(' ')+'"'+style+'>'+option.html+'</li>'};AbstractChosen.prototype.results_update_field=function(){this.set_default_text();if(!this.is_multiple){this.results_reset_cleanup()}this.result_clear_highlight();this.result_single_selected=null;return this.results_build()};AbstractChosen.prototype.results_toggle=function(){if(this.results_showing){return this.results_hide()}else{return this.results_show()}};AbstractChosen.prototype.results_search=function(evt){if(this.results_showing){return this.winnow_results()}else{return this.results_show()}};AbstractChosen.prototype.choices_count=function(){var option,_i,_len,_ref;if(this.selected_option_count!=null){return this.selected_option_count}this.selected_option_count=0;_ref=this.form_field.options;for(_i=0,_len=_ref.length;_i<_len;_i++){option=_ref[_i];if(option.selected){this.selected_option_count+=1}}return this.selected_option_count};AbstractChosen.prototype.choices_click=function(evt){evt.preventDefault();if(!(this.results_showing||this.is_disabled)){return this.results_show()}};AbstractChosen.prototype.keyup_checker=function(evt){var stroke,_ref;stroke=(_ref=evt.which)!=null?_ref:evt.keyCode;this.search_field_scale();switch(stroke){case 8:if(this.is_multiple&&this.backstroke_length<1&&this.choices_count()>0){return this.keydown_backstroke()}else if(!this.pending_backstroke){this.result_clear_highlight();return this.results_search()}break;case 13:evt.preventDefault();if(this.results_showing){return this.result_select(evt)}break;case 27:if(this.results_showing){this.results_hide()}return true;case 9:case 38:case 40:case 16:case 91:case 17:break;default:return this.results_search()}};AbstractChosen.prototype.generate_field_id=function(){var new_id;new_id=this.generate_random_id();this.form_field.id=new_id;return new_id};AbstractChosen.prototype.generate_random_char=function(){var chars,newchar,rand;chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";rand=Math.floor(Math.random()*chars.length);return newchar=chars.substring(rand,rand+1)};AbstractChosen.prototype.container_width=function(){if(this.options.width!=null){return this.options.width}else{return""+this.form_field.offsetWidth+"px"}};AbstractChosen.browser_is_supported=function(){var _ref;if(window.navigator.appName==="Microsoft Internet Explorer"){return(null!==(_ref=document.documentMode)&&_ref>=8)}return true};AbstractChosen.default_multiple_text="Select Some Options";AbstractChosen.default_single_text="Select an Option";AbstractChosen.default_no_result_text="No results match";return AbstractChosen})();root.AbstractChosen=AbstractChosen}).call(this);(function(){var $,Chosen,root,_ref,__hasProp={}.hasOwnProperty,__extends=function(child,parent){for(var key in parent){if(__hasProp.call(parent,key))child[key]=parent[key]}function ctor(){this.constructor=child}ctor.prototype=parent.prototype;child.prototype=new ctor();child.__super__=parent.prototype;return child};root=this;$=jQuery;$.fn.extend({chosen:function(options){if(!AbstractChosen.browser_is_supported()){return this}return this.each(function(input_field){var $this;$this=$(this);if(!$this.hasClass("chzn-done")){return $this.data('chosen',new Chosen(this,options))}})}});Chosen=(function(_super){__extends(Chosen,_super);function Chosen(){_ref=Chosen.__super__.constructor.apply(this,arguments);return _ref}Chosen.prototype.setup=function(){this.form_field_jq=$(this.form_field);this.current_selectedIndex=this.form_field.selectedIndex;return this.is_rtl=this.form_field_jq.hasClass("chzn-rtl")};Chosen.prototype.finish_setup=function(){return this.form_field_jq.addClass("chzn-done")};Chosen.prototype.set_up_html=function(){var container_classes,container_props;this.container_id=this.form_field.id.length?this.form_field.id.replace(/[^\w]/g,'_'):this.generate_field_id();this.container_id+="_chzn";container_classes=["chzn-container"];container_classes.push("chzn-container-"+(this.is_multiple?"multi":"single"));if(this.inherit_select_classes&&this.form_field.className){container_classes.push(this.form_field.className)}if(this.is_rtl){container_classes.push("chzn-rtl")}container_props={'id':this.container_id,'class':container_classes.join(' '),'style':"width: "+(this.container_width())+";",'title':this.form_field.title};this.container=$("<div />",container_props);if(this.is_multiple){this.container.html('<ul class="chzn-choices"><li class="search-field"><input type="text" value="'+this.default_text+'" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chzn-drop"><ul class="chzn-results"></ul></div>')}else{this.container.html('<a href="javascript:void(0)" class="chzn-single chzn-default" tabindex="-1"><span>'+this.default_text+'</span><div><b></b></div></a><div class="chzn-drop"><div class="chzn-search"><input type="text" autocomplete="off" /></div><ul class="chzn-results"></ul></div>')}this.form_field_jq.hide().after(this.container);this.dropdown=this.container.find('div.chzn-drop').first();this.search_field=this.container.find('input').first();this.search_results=this.container.find('ul.chzn-results').first();this.search_field_scale();this.search_no_results=this.container.find('li.no-results').first();if(this.is_multiple){this.search_choices=this.container.find('ul.chzn-choices').first();this.search_container=this.container.find('li.search-field').first()}else{this.search_container=this.container.find('div.chzn-search').first();this.selected_item=this.container.find('.chzn-single').first()}this.results_build();this.set_tab_index();this.set_label_behavior();return this.form_field_jq.trigger("liszt:ready",{chosen:this})};Chosen.prototype.register_observers=function(){var _this=this;this.container.mousedown(function(evt){_this.container_mousedown(evt)});this.container.mouseup(function(evt){_this.container_mouseup(evt)});this.container.mouseenter(function(evt){_this.mouse_enter(evt)});this.container.mouseleave(function(evt){_this.mouse_leave(evt)});this.search_results.mouseup(function(evt){_this.search_results_mouseup(evt)});this.search_results.mouseover(function(evt){_this.search_results_mouseover(evt)});this.search_results.mouseout(function(evt){_this.search_results_mouseout(evt)});this.search_results.bind('mousewheel DOMMouseScroll',function(evt){_this.search_results_mousewheel(evt)});this.form_field_jq.bind("liszt:updated",function(evt){_this.results_update_field(evt)});this.form_field_jq.bind("liszt:activate",function(evt){_this.activate_field(evt)});this.form_field_jq.bind("liszt:open",function(evt){_this.container_mousedown(evt)});this.search_field.blur(function(evt){_this.input_blur(evt)});this.search_field.keyup(function(evt){_this.keyup_checker(evt)});this.search_field.keydown(function(evt){_this.keydown_checker(evt)});this.search_field.focus(function(evt){_this.input_focus(evt)});if(this.is_multiple){return this.search_choices.click(function(evt){_this.choices_click(evt)})}else{return this.container.click(function(evt){evt.preventDefault()})}};Chosen.prototype.search_field_disabled=function(){this.is_disabled=this.form_field_jq[0].disabled;if(this.is_disabled){this.container.addClass('chzn-disabled');this.search_field[0].disabled=true;if(!this.is_multiple){this.selected_item.unbind("focus",this.activate_action)}return this.close_field()}else{this.container.removeClass('chzn-disabled');this.search_field[0].disabled=false;if(!this.is_multiple){return this.selected_item.bind("focus",this.activate_action)}}};Chosen.prototype.container_mousedown=function(evt){if(!this.is_disabled){if(evt&&evt.type==="mousedown"&&!this.results_showing){evt.preventDefault()}if(!((evt!=null)&&($(evt.target)).hasClass("search-choice-close ui-icon ui-icon-close"))){if(!this.active_field){if(this.is_multiple){this.search_field.val("")}$(document).click(this.click_test_action);this.results_show()}else if(!this.is_multiple&&evt&&(($(evt.target)[0]===this.selected_item[0])||$(evt.target).parents("a.chzn-single").length)){evt.preventDefault();this.results_toggle()}return this.activate_field()}}};Chosen.prototype.container_mouseup=function(evt){if(evt.target.nodeName==="ABBR"&&!this.is_disabled){return this.results_reset(evt)}};Chosen.prototype.search_results_mousewheel=function(evt){var delta,_ref1,_ref2;delta=-((_ref1=evt.originalEvent)!=null?_ref1.wheelDelta:void 0)||((_ref2=evt.originialEvent)!=null?_ref2.detail:void 0);if(delta!=null){evt.preventDefault();if(evt.type==='DOMMouseScroll'){delta=delta*40}return this.search_results.scrollTop(delta+this.search_results.scrollTop())}};Chosen.prototype.blur_test=function(evt){if(!this.active_field&&this.container.hasClass("chzn-container-active")){return this.close_field()}};Chosen.prototype.close_field=function(){$(document).unbind("click",this.click_test_action);this.active_field=false;this.results_hide();this.container.removeClass("chzn-container-active");this.clear_backstroke();this.show_search_field_default();return this.search_field_scale()};Chosen.prototype.activate_field=function(){this.container.addClass("chzn-container-active");this.active_field=true;this.search_field.val(this.search_field.val());return this.search_field.focus()};Chosen.prototype.test_active_click=function(evt){if($(evt.target).parents('#'+this.container_id).length){return this.active_field=true}else{return this.close_field()}};Chosen.prototype.results_build=function(){var content,data,_i,_len,_ref1;this.parsing=true;this.selected_option_count=null;this.results_data=root.SelectParser.select_to_array(this.form_field);if(this.is_multiple){this.search_choices.find("li.search-choice").remove()}else if(!this.is_multiple){this.selected_item.addClass("chzn-default").find("span").text(this.default_text);if(this.disable_search||this.form_field.options.length<=this.disable_search_threshold){this.container.addClass("chzn-container-single-nosearch")}else{this.container.removeClass("chzn-container-single-nosearch")}}content='';_ref1=this.results_data;for(_i=0,_len=_ref1.length;_i<_len;_i++){data=_ref1[_i];if(data.group){content+=this.result_add_group(data)}else if(!data.empty){content+=this.result_add_option(data);if(data.selected&&this.is_multiple){this.choice_build(data)}else if(data.selected&&!this.is_multiple){this.selected_item.removeClass("chzn-default").find("span").text(data.text);if(this.allow_single_deselect){this.single_deselect_control_build()}}}}this.search_field_disabled();this.show_search_field_default();this.search_field_scale();this.search_results.html(content);return this.parsing=false};Chosen.prototype.result_add_group=function(group){group.dom_id=this.container_id+"_g_"+group.array_index;return'<li id="'+group.dom_id+'" class="group-result">'+$("<div />").text(group.label).html()+'</li>'};Chosen.prototype.result_do_highlight=function(el){var high_bottom,high_top,maxHeight,visible_bottom,visible_top;if(el.length){this.result_clear_highlight();this.result_highlight=el;this.result_highlight.addClass("highlighted");maxHeight=parseInt(this.search_results.css("maxHeight"),10);visible_top=this.search_results.scrollTop();visible_bottom=maxHeight+visible_top;high_top=this.result_highlight.position().top+this.search_results.scrollTop();high_bottom=high_top+this.result_highlight.outerHeight();if(high_bottom>=visible_bottom){return this.search_results.scrollTop((high_bottom-maxHeight)>0?high_bottom-maxHeight:0)}else if(high_top<visible_top){return this.search_results.scrollTop(high_top)}}};Chosen.prototype.result_clear_highlight=function(){if(this.result_highlight){this.result_highlight.removeClass("highlighted")}return this.result_highlight=null};Chosen.prototype.results_show=function(){if(this.is_multiple&&this.max_selected_options<=this.choices_count()){this.form_field_jq.trigger("liszt:maxselected",{chosen:this});return false}this.container.addClass("chzn-with-drop");this.form_field_jq.trigger("liszt:showing_dropdown",{chosen:this});this.results_showing=true;this.search_field.focus();this.search_field.val(this.search_field.val());return this.winnow_results()};Chosen.prototype.results_hide=function(){if(this.results_showing){this.result_clear_highlight();this.container.removeClass("chzn-with-drop");this.form_field_jq.trigger("liszt:hiding_dropdown",{chosen:this})}return this.results_showing=false};Chosen.prototype.set_tab_index=function(el){var ti;if(this.form_field_jq.attr("tabindex")){ti=this.form_field_jq.attr("tabindex");this.form_field_jq.attr("tabindex",-1);return this.search_field.attr("tabindex",ti)}};Chosen.prototype.set_label_behavior=function(){var _this=this;this.form_field_label=this.form_field_jq.parents("label");if(!this.form_field_label.length&&this.form_field.id.length){this.form_field_label=$("label[for='"+this.form_field.id+"']")}if(this.form_field_label.length>0){return this.form_field_label.click(function(evt){if(_this.is_multiple){return _this.container_mousedown(evt)}else{return _this.activate_field()}})}};Chosen.prototype.show_search_field_default=function(){if(this.is_multiple&&this.choices_count()<1&&!this.active_field){this.search_field.val(this.default_text);return this.search_field.addClass("default")}else{this.search_field.val("");return this.search_field.removeClass("default")}};Chosen.prototype.search_results_mouseup=function(evt){var target;target=$(evt.target).hasClass("active-result")?$(evt.target):$(evt.target).parents(".active-result").first();if(target.length){this.result_highlight=target;this.result_select(evt);return this.search_field.focus()}};Chosen.prototype.search_results_mouseover=function(evt){var target;target=$(evt.target).hasClass("active-result")?$(evt.target):$(evt.target).parents(".active-result").first();if(target){return this.result_do_highlight(target)}};Chosen.prototype.search_results_mouseout=function(evt){if($(evt.target).hasClass("active-result"||$(evt.target).parents('.active-result').first())){return this.result_clear_highlight()}};Chosen.prototype.choice_build=function(item){var choice,close_link,_this=this;choice=$('<li />',{"class":"search-choice"}).html("<span>"+item.html+"</span>");if(item.disabled){choice.addClass('search-choice-disabled')}else{close_link=$('<a />',{href:'#',"class":'search-choice-close ui-icon ui-icon-close',rel:item.array_index});close_link.click(function(evt){return _this.choice_destroy_link_click(evt)});choice.append(close_link)}return this.search_container.before(choice)};Chosen.prototype.choice_destroy_link_click=function(evt){evt.preventDefault();evt.stopPropagation();if(!this.is_disabled){return this.choice_destroy($(evt.target))}};Chosen.prototype.choice_destroy=function(link){if(this.result_deselect(link.attr("rel"))){this.show_search_field_default();if(this.is_multiple&&this.choices_count()>0&&this.search_field.val().length<1){this.results_hide()}link.parents('li').first().remove();return this.search_field_scale()}};Chosen.prototype.results_reset=function(){this.form_field.options[0].selected=true;this.selected_option_count=null;this.selected_item.find("span").text(this.default_text);if(!this.is_multiple){this.selected_item.addClass("chzn-default")}this.show_search_field_default();this.results_reset_cleanup();this.form_field_jq.trigger("change");if(this.active_field){return this.results_hide()}};Chosen.prototype.results_reset_cleanup=function(){this.current_selectedIndex=this.form_field.selectedIndex;return this.selected_item.find("abbr").remove()};Chosen.prototype.result_select=function(evt){var high,high_id,item,position;if(this.result_highlight){high=this.result_highlight;high_id=high.attr("id");this.result_clear_highlight();if(this.is_multiple&&this.max_selected_options<=this.choices_count()){this.form_field_jq.trigger("liszt:maxselected",{chosen:this});return false}if(this.is_multiple){high.removeClass("active-result")}else{this.search_results.find(".result-selected").removeClass("result-selected");this.result_single_selected=high;this.selected_item.removeClass("chzn-default")}high.addClass("result-selected");position=high_id.substr(high_id.lastIndexOf("_")+1);item=this.results_data[position];item.selected=true;this.form_field.options[item.options_index].selected=true;this.selected_option_count=null;if(this.is_multiple){this.choice_build(item)}else{this.selected_item.find("span").first().text(item.text);if(this.allow_single_deselect){this.single_deselect_control_build()}}if(!((evt.metaKey||evt.ctrlKey)&&this.is_multiple)){this.results_hide()}this.search_field.val("");if(this.is_multiple||this.form_field.selectedIndex!==this.current_selectedIndex){this.form_field_jq.trigger("change",{'selected':this.form_field.options[item.options_index].value})}this.current_selectedIndex=this.form_field.selectedIndex;return this.search_field_scale()}};Chosen.prototype.result_activate=function(el,option){if(option.disabled){return el.addClass("disabled-result")}else if(this.is_multiple&&option.selected){return el.addClass("result-selected")}else{return el.addClass("active-result")}};Chosen.prototype.result_deactivate=function(el){return el.removeClass("active-result result-selected disabled-result")};Chosen.prototype.result_deselect=function(pos){var result,result_data;result_data=this.results_data[pos];if(!this.form_field.options[result_data.options_index].disabled){result_data.selected=false;this.form_field.options[result_data.options_index].selected=false;this.selected_option_count=null;result=$("#"+this.container_id+"_o_"+pos);result.removeClass("result-selected").addClass("active-result").show();this.result_clear_highlight();this.winnow_results();this.form_field_jq.trigger("change",{deselected:this.form_field.options[result_data.options_index].value});this.search_field_scale();return true}else{return false}};Chosen.prototype.single_deselect_control_build=function(){if(!this.allow_single_deselect){return}if(!this.selected_item.find("abbr").length){this.selected_item.find("span").first().after("<abbr class=\"search-choice-close ui-icon ui-icon-close\"></abbr>")}return this.selected_item.addClass("chzn-single-with-deselect")};Chosen.prototype.winnow_results=function(){var found,option,part,parts,regex,regexAnchor,result,result_id,results,searchText,startpos,text,zregex,_i,_j,_len,_len1,_ref1;this.no_results_clear();results=0;searchText=this.search_field.val()===this.default_text?"":$('<div/>').text($.trim(this.search_field.val())).html();regexAnchor=this.search_contains?"":"^";regex=new RegExp(regexAnchor+searchText.replace(/[-[\]{}()*+?.,\\^$|#\s]/g,"\\$&"),'i');zregex=new RegExp(searchText.replace(/[-[\]{}()*+?.,\\^$|#\s]/g,"\\$&"),'i');_ref1=this.results_data;for(_i=0,_len=_ref1.length;_i<_len;_i++){option=_ref1[_i];if(!option.empty){if(option.group){$('#'+option.dom_id).css('display','none')}else{found=false;result_id=option.dom_id;result=$("#"+result_id);if(regex.test(option.html)){found=true;results+=1}else if(this.enable_split_word_search&&(option.html.indexOf(" ")>=0||option.html.indexOf("[")===0)){parts=option.html.replace(/\[|\]/g,"").split(" ");if(parts.length){for(_j=0,_len1=parts.length;_j<_len1;_j++){part=parts[_j];if(regex.test(part)){found=true;results+=1}}}}if(found){if(searchText.length){startpos=option.html.search(zregex);text=option.html.substr(0,startpos+searchText.length)+'</em>'+option.html.substr(startpos+searchText.length);text=text.substr(0,startpos)+'<em>'+text.substr(startpos)}else{text=option.html}result.html(text);this.result_activate(result,option);if(option.group_array_index!=null){$("#"+this.results_data[option.group_array_index].dom_id).css('display','list-item')}}else{if(this.result_highlight&&result_id===this.result_highlight.attr('id')){this.result_clear_highlight()}this.result_deactivate(result)}}}}if(results<1&&searchText.length){return this.no_results(searchText)}else{return this.winnow_results_set_highlight()}};Chosen.prototype.winnow_results_set_highlight=function(){var do_high,selected_results;if(!this.result_highlight){selected_results=!this.is_multiple?this.search_results.find(".result-selected.active-result"):[];do_high=selected_results.length?selected_results.first():this.search_results.find(".active-result").first();if(do_high!=null){return this.result_do_highlight(do_high)}}};Chosen.prototype.no_results=function(terms){var no_results_html;no_results_html=$('<li class="no-results">'+this.results_none_found+' "<span></span>"</li>');no_results_html.find("span").first().html(terms);return this.search_results.append(no_results_html)};Chosen.prototype.no_results_clear=function(){return this.search_results.find(".no-results").remove()};Chosen.prototype.keydown_arrow=function(){var next_sib;if(this.results_showing&&this.result_highlight){next_sib=this.result_highlight.nextAll("li.active-result").first();if(next_sib){return this.result_do_highlight(next_sib)}}else{return this.results_show()}};Chosen.prototype.keyup_arrow=function(){var prev_sibs;if(!this.results_showing&&!this.is_multiple){return this.results_show()}else if(this.result_highlight){prev_sibs=this.result_highlight.prevAll("li.active-result");if(prev_sibs.length){return this.result_do_highlight(prev_sibs.first())}else{if(this.choices_count()>0){this.results_hide()}return this.result_clear_highlight()}}};Chosen.prototype.keydown_backstroke=function(){var next_available_destroy;if(this.pending_backstroke){this.choice_destroy(this.pending_backstroke.find("a").first());return this.clear_backstroke()}else{next_available_destroy=this.search_container.siblings("li.search-choice").last();if(next_available_destroy.length&&!next_available_destroy.hasClass("search-choice-disabled")){this.pending_backstroke=next_available_destroy;if(this.single_backstroke_delete){return this.keydown_backstroke()}else{return this.pending_backstroke.addClass("search-choice-focus")}}}};Chosen.prototype.clear_backstroke=function(){if(this.pending_backstroke){this.pending_backstroke.removeClass("search-choice-focus")}return this.pending_backstroke=null};Chosen.prototype.keydown_checker=function(evt){var stroke,_ref1;stroke=(_ref1=evt.which)!=null?_ref1:evt.keyCode;this.search_field_scale();if(stroke!==8&&this.pending_backstroke){this.clear_backstroke()}switch(stroke){case 8:this.backstroke_length=this.search_field.val().length;break;case 9:if(this.results_showing&&!this.is_multiple){this.result_select(evt)}this.mouse_on_container=false;break;case 13:evt.preventDefault();break;case 38:evt.preventDefault();this.keyup_arrow();break;case 40:this.keydown_arrow();break}};Chosen.prototype.search_field_scale=function(){var div,h,style,style_block,styles,w,_i,_len;if(this.is_multiple){h=0;w=0;style_block="position:absolute; left: -1000px; top: -1000px; display:none;";styles=['font-size','font-style','font-weight','font-family','line-height','text-transform','letter-spacing'];for(_i=0,_len=styles.length;_i<_len;_i++){style=styles[_i];style_block+=style+":"+this.search_field.css(style)+";"}div=$('<div />',{'style':style_block});div.text(this.search_field.val());$('body').append(div);w=div.width()+25;div.remove();if(!this.f_width){this.f_width=this.container.outerWidth()}if(w>this.f_width-10){w=this.f_width-10}return this.search_field.css({'width':w+'px'})}};Chosen.prototype.generate_random_id=function(){var string;string="sel"+this.generate_random_char()+this.generate_random_char()+this.generate_random_char();while($("#"+string).length>0){string+=this.generate_random_char()}return string};return Chosen})(AbstractChosen);root.Chosen=Chosen}).call(this);
	
// Mouse wheel	
/*! Copyright (c) 2011 Brandon Aaron (http://brandonaaron.net)
 * Licensed under the MIT License (LICENSE.txt).
 *
 * Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
 * Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
 * Thanks to: Seamus Leahy for adding deltaX and deltaY
 *
 * Version: 3.0.6
 * 
 * Requires: 1.2.2+
 */

(function($){var types=['DOMMouseScroll','mousewheel'];if($.event.fixHooks){for(var i=types.length;i;){$.event.fixHooks[types[--i]]=$.event.mouseHooks}}$.event.special.mousewheel={setup:function(){if(this.addEventListener){for(var i=types.length;i;){this.addEventListener(types[--i],handler,false)}}else{this.onmousewheel=handler}},teardown:function(){if(this.removeEventListener){for(var i=types.length;i;){this.removeEventListener(types[--i],handler,false)}}else{this.onmousewheel=null}}};$.fn.extend({mousewheel:function(fn){return fn?this.bind("mousewheel",fn):this.trigger("mousewheel")},unmousewheel:function(fn){return this.unbind("mousewheel",fn)}});function handler(event){var orgEvent=event||window.event,args=[].slice.call(arguments,1),delta=0,returnValue=true,deltaX=0,deltaY=0;event=$.event.fix(orgEvent);event.type="mousewheel";if(orgEvent.wheelDelta){delta=orgEvent.wheelDelta/120}if(orgEvent.detail){delta=-orgEvent.detail/3}deltaY=delta;if(orgEvent.axis!==undefined&&orgEvent.axis===orgEvent.HORIZONTAL_AXIS){deltaY=0;deltaX=-1*delta}if(orgEvent.wheelDeltaY!==undefined){deltaY=orgEvent.wheelDeltaY/120}if(orgEvent.wheelDeltaX!==undefined){deltaX=-1*orgEvent.wheelDeltaX/120}args.unshift(event,delta,deltaX,deltaY);return($.event.dispatch||$.event.handle).apply(this,args)}})(jQuery);


/*! jScrollPane - v2.0.0beta11 - 2011-07-04
 * http://jscrollpane.kelvinluck.com/
 *
 * Copyright (c) 2010 Kelvin Luck
 * Dual licensed under the MIT and GPL licenses.
 */
(function(b,a,c){b.fn.jScrollPane=function(e){function d(D,O){var az,Q=this,Y,ak,v,am,T,Z,y,q,aA,aF,av,i,I,h,j,aa,U,aq,X,t,A,ar,af,an,G,l,au,ay,x,aw,aI,f,L,aj=true,P=true,aH=false,k=false,ap=D.clone(false,false).empty(),ac=b.fn.mwheelIntent?"mwheelIntent.jsp":"mousewheel.jsp";aI=D.css("paddingTop")+" "+D.css("paddingRight")+" "+D.css("paddingBottom")+" "+D.css("paddingLeft");f=(parseInt(D.css("paddingLeft"),10)||0)+(parseInt(D.css("paddingRight"),10)||0);function at(aR){var aM,aO,aN,aK,aJ,aQ,aP=false,aL=false;az=aR;if(Y===c){aJ=D.scrollTop();aQ=D.scrollLeft();D.css({overflow:"hidden",padding:0});ak=D.innerWidth()+f;v=D.innerHeight();D.width(ak);Y=b('<div class="jspPane" />').css("padding",aI).append(D.children());am=b('<div class="jspContainer" />').css({width:ak+"px",height:v+"px"}).append(Y).appendTo(D)}else{D.css("width","");aP=az.stickToBottom&&K();aL=az.stickToRight&&B();aK=D.innerWidth()+f!=ak||D.outerHeight()!=v;if(aK){ak=D.innerWidth()+f;v=D.innerHeight();am.css({width:ak+"px",height:v+"px"})}if(!aK&&L==T&&Y.outerHeight()==Z){D.width(ak);return}L=T;Y.css("width","");D.width(ak);am.find(">.jspVerticalBar,>.jspHorizontalBar").remove().end()}Y.css("overflow","auto");if(aR.contentWidth){T=aR.contentWidth}else{T=Y[0].scrollWidth}Z=Y[0].scrollHeight;Y.css("overflow","");y=T/ak;q=Z/v;aA=q>1;aF=y>1;if(!(aF||aA)){D.removeClass("jspScrollable");Y.css({top:0,width:am.width()-f});n();E();R();w();ai()}else{D.addClass("jspScrollable");aM=az.maintainPosition&&(I||aa);if(aM){aO=aD();aN=aB()}aG();z();F();if(aM){N(aL?(T-ak):aO,false);M(aP?(Z-v):aN,false)}J();ag();ao();if(az.enableKeyboardNavigation){S()}if(az.clickOnTrack){p()}C();if(az.hijackInternalLinks){m()}}if(az.autoReinitialise&&!aw){aw=setInterval(function(){at(az)},az.autoReinitialiseDelay)}else{if(!az.autoReinitialise&&aw){clearInterval(aw)}}aJ&&D.scrollTop(0)&&M(aJ,false);aQ&&D.scrollLeft(0)&&N(aQ,false);D.trigger("jsp-initialised",[aF||aA])}function aG(){if(aA){am.append(b('<div class="jspVerticalBar" />').append(b('<div class="jspCap jspCapTop" />'),b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragTop" />'),b('<div class="jspDragBottom" />'))),b('<div class="jspCap jspCapBottom" />')));U=am.find(">.jspVerticalBar");aq=U.find(">.jspTrack");av=aq.find(">.jspDrag");if(az.showArrows){ar=b('<a class="jspArrow jspArrowUp" />').bind("mousedown.jsp",aE(0,-1)).bind("click.jsp",aC);af=b('<a class="jspArrow jspArrowDown" />').bind("mousedown.jsp",aE(0,1)).bind("click.jsp",aC);if(az.arrowScrollOnHover){ar.bind("mouseover.jsp",aE(0,-1,ar));af.bind("mouseover.jsp",aE(0,1,af))}al(aq,az.verticalArrowPositions,ar,af)}t=v;am.find(">.jspVerticalBar>.jspCap:visible,>.jspVerticalBar>.jspArrow").each(function(){t-=b(this).outerHeight()});av.hover(function(){av.addClass("jspHover")},function(){av.removeClass("jspHover")}).bind("mousedown.jsp",function(aJ){b("html").bind("dragstart.jsp selectstart.jsp",aC);av.addClass("jspActive");var s=aJ.pageY-av.position().top;b("html").bind("mousemove.jsp",function(aK){V(aK.pageY-s,false)}).bind("mouseup.jsp mouseleave.jsp",ax);return false});o()}}function o(){aq.height(t+"px");I=0;X=az.verticalGutter+aq.outerWidth();Y.width(ak-X-f);try{if(U.position().left===0){Y.css("margin-left",X+"px")}}catch(s){}}function z(){if(aF){am.append(b('<div class="jspHorizontalBar" />').append(b('<div class="jspCap jspCapLeft" />'),b('<div class="jspTrack" />').append(b('<div class="jspDrag" />').append(b('<div class="jspDragLeft" />'),b('<div class="jspDragRight" />'))),b('<div class="jspCap jspCapRight" />')));an=am.find(">.jspHorizontalBar");G=an.find(">.jspTrack");h=G.find(">.jspDrag");if(az.showArrows){ay=b('<a class="jspArrow jspArrowLeft" />').bind("mousedown.jsp",aE(-1,0)).bind("click.jsp",aC);x=b('<a class="jspArrow jspArrowRight" />').bind("mousedown.jsp",aE(1,0)).bind("click.jsp",aC);
if(az.arrowScrollOnHover){ay.bind("mouseover.jsp",aE(-1,0,ay));x.bind("mouseover.jsp",aE(1,0,x))}al(G,az.horizontalArrowPositions,ay,x)}h.hover(function(){h.addClass("jspHover")},function(){h.removeClass("jspHover")}).bind("mousedown.jsp",function(aJ){b("html").bind("dragstart.jsp selectstart.jsp",aC);h.addClass("jspActive");var s=aJ.pageX-h.position().left;b("html").bind("mousemove.jsp",function(aK){W(aK.pageX-s,false)}).bind("mouseup.jsp mouseleave.jsp",ax);return false});l=am.innerWidth();ah()}}function ah(){am.find(">.jspHorizontalBar>.jspCap:visible,>.jspHorizontalBar>.jspArrow").each(function(){l-=b(this).outerWidth()});G.width(l+"px");aa=0}function F(){if(aF&&aA){var aJ=G.outerHeight(),s=aq.outerWidth();t-=aJ;b(an).find(">.jspCap:visible,>.jspArrow").each(function(){l+=b(this).outerWidth()});l-=s;v-=s;ak-=aJ;G.parent().append(b('<div class="jspCorner" />').css("width",aJ+"px"));o();ah()}if(aF){Y.width((am.outerWidth()-f)+"px")}Z=Y.outerHeight();q=Z/v;if(aF){au=Math.ceil(1/y*l);if(au>az.horizontalDragMaxWidth){au=az.horizontalDragMaxWidth}else{if(au<az.horizontalDragMinWidth){au=az.horizontalDragMinWidth}}h.width(au+"px");j=l-au;ae(aa)}if(aA){A=Math.ceil(1/q*t);if(A>az.verticalDragMaxHeight){A=az.verticalDragMaxHeight}else{if(A<az.verticalDragMinHeight){A=az.verticalDragMinHeight}}av.height(A+"px");i=t-A;ad(I)}}function al(aK,aM,aJ,s){var aO="before",aL="after",aN;if(aM=="os"){aM=/Mac/.test(navigator.platform)?"after":"split"}if(aM==aO){aL=aM}else{if(aM==aL){aO=aM;aN=aJ;aJ=s;s=aN}}aK[aO](aJ)[aL](s)}function aE(aJ,s,aK){return function(){H(aJ,s,this,aK);this.blur();return false}}function H(aM,aL,aP,aO){aP=b(aP).addClass("jspActive");var aN,aK,aJ=true,s=function(){if(aM!==0){Q.scrollByX(aM*az.arrowButtonSpeed)}if(aL!==0){Q.scrollByY(aL*az.arrowButtonSpeed)}aK=setTimeout(s,aJ?az.initialDelay:az.arrowRepeatFreq);aJ=false};s();aN=aO?"mouseout.jsp":"mouseup.jsp";aO=aO||b("html");aO.bind(aN,function(){aP.removeClass("jspActive");aK&&clearTimeout(aK);aK=null;aO.unbind(aN)})}function p(){w();if(aA){aq.bind("mousedown.jsp",function(aO){if(aO.originalTarget===c||aO.originalTarget==aO.currentTarget){var aM=b(this),aP=aM.offset(),aN=aO.pageY-aP.top-I,aK,aJ=true,s=function(){var aS=aM.offset(),aT=aO.pageY-aS.top-A/2,aQ=v*az.scrollPagePercent,aR=i*aQ/(Z-v);if(aN<0){if(I-aR>aT){Q.scrollByY(-aQ)}else{V(aT)}}else{if(aN>0){if(I+aR<aT){Q.scrollByY(aQ)}else{V(aT)}}else{aL();return}}aK=setTimeout(s,aJ?az.initialDelay:az.trackClickRepeatFreq);aJ=false},aL=function(){aK&&clearTimeout(aK);aK=null;b(document).unbind("mouseup.jsp",aL)};s();b(document).bind("mouseup.jsp",aL);return false}})}if(aF){G.bind("mousedown.jsp",function(aO){if(aO.originalTarget===c||aO.originalTarget==aO.currentTarget){var aM=b(this),aP=aM.offset(),aN=aO.pageX-aP.left-aa,aK,aJ=true,s=function(){var aS=aM.offset(),aT=aO.pageX-aS.left-au/2,aQ=ak*az.scrollPagePercent,aR=j*aQ/(T-ak);if(aN<0){if(aa-aR>aT){Q.scrollByX(-aQ)}else{W(aT)}}else{if(aN>0){if(aa+aR<aT){Q.scrollByX(aQ)}else{W(aT)}}else{aL();return}}aK=setTimeout(s,aJ?az.initialDelay:az.trackClickRepeatFreq);aJ=false},aL=function(){aK&&clearTimeout(aK);aK=null;b(document).unbind("mouseup.jsp",aL)};s();b(document).bind("mouseup.jsp",aL);return false}})}}function w(){if(G){G.unbind("mousedown.jsp")}if(aq){aq.unbind("mousedown.jsp")}}function ax(){b("html").unbind("dragstart.jsp selectstart.jsp mousemove.jsp mouseup.jsp mouseleave.jsp");if(av){av.removeClass("jspActive")}if(h){h.removeClass("jspActive")}}function V(s,aJ){if(!aA){return}if(s<0){s=0}else{if(s>i){s=i}}if(aJ===c){aJ=az.animateScroll}if(aJ){Q.animate(av,"top",s,ad)}else{av.css("top",s);ad(s)}}function ad(aJ){if(aJ===c){aJ=av.position().top}am.scrollTop(0);I=aJ;var aM=I===0,aK=I==i,aL=aJ/i,s=-aL*(Z-v);if(aj!=aM||aH!=aK){aj=aM;aH=aK;D.trigger("jsp-arrow-change",[aj,aH,P,k])}u(aM,aK);Y.css("top",s);D.trigger("jsp-scroll-y",[-s,aM,aK]).trigger("scroll")}function W(aJ,s){if(!aF){return}if(aJ<0){aJ=0}else{if(aJ>j){aJ=j}}if(s===c){s=az.animateScroll}if(s){Q.animate(h,"left",aJ,ae)
}else{h.css("left",aJ);ae(aJ)}}function ae(aJ){if(aJ===c){aJ=h.position().left}am.scrollTop(0);aa=aJ;var aM=aa===0,aL=aa==j,aK=aJ/j,s=-aK*(T-ak);if(P!=aM||k!=aL){P=aM;k=aL;D.trigger("jsp-arrow-change",[aj,aH,P,k])}r(aM,aL);Y.css("left",s);D.trigger("jsp-scroll-x",[-s,aM,aL]).trigger("scroll")}function u(aJ,s){if(az.showArrows){ar[aJ?"addClass":"removeClass"]("jspDisabled");af[s?"addClass":"removeClass"]("jspDisabled")}}function r(aJ,s){if(az.showArrows){ay[aJ?"addClass":"removeClass"]("jspDisabled");x[s?"addClass":"removeClass"]("jspDisabled")}}function M(s,aJ){var aK=s/(Z-v);V(aK*i,aJ)}function N(aJ,s){var aK=aJ/(T-ak);W(aK*j,s)}function ab(aW,aR,aK){var aO,aL,aM,s=0,aV=0,aJ,aQ,aP,aT,aS,aU;try{aO=b(aW)}catch(aN){return}aL=aO.outerHeight();aM=aO.outerWidth();am.scrollTop(0);am.scrollLeft(0);while(!aO.is(".jspPane")){s+=aO.position().top;aV+=aO.position().left;aO=aO.offsetParent();if(/^body|html$/i.test(aO[0].nodeName)){return}}aJ=aB();aP=aJ+v;if(s<aJ||aR){aS=s-az.verticalGutter}else{if(s+aL>aP){aS=s-v+aL+az.verticalGutter}}if(aS){M(aS,aK)}aQ=aD();aT=aQ+ak;if(aV<aQ||aR){aU=aV-az.horizontalGutter}else{if(aV+aM>aT){aU=aV-ak+aM+az.horizontalGutter}}if(aU){N(aU,aK)}}function aD(){return -Y.position().left}function aB(){return -Y.position().top}function K(){var s=Z-v;return(s>20)&&(s-aB()<10)}function B(){var s=T-ak;return(s>20)&&(s-aD()<10)}function ag(){am.unbind(ac).bind(ac,function(aM,aN,aL,aJ){var aK=aa,s=I;Q.scrollBy(aL*az.mouseWheelSpeed,-aJ*az.mouseWheelSpeed,false);return aK==aa&&s==I})}function n(){am.unbind(ac)}function aC(){return false}function J(){Y.find(":input,a").unbind("focus.jsp").bind("focus.jsp",function(s){ab(s.target,false)})}function E(){Y.find(":input,a").unbind("focus.jsp")}function S(){var s,aJ,aL=[];aF&&aL.push(an[0]);aA&&aL.push(U[0]);Y.focus(function(){D.focus()});D.attr("tabindex",0).unbind("keydown.jsp keypress.jsp").bind("keydown.jsp",function(aO){if(aO.target!==this&&!(aL.length&&b(aO.target).closest(aL).length)){return}var aN=aa,aM=I;switch(aO.keyCode){case 40:case 38:case 34:case 32:case 33:case 39:case 37:s=aO.keyCode;aK();break;case 35:M(Z-v);s=null;break;case 36:M(0);s=null;break}aJ=aO.keyCode==s&&aN!=aa||aM!=I;return !aJ}).bind("keypress.jsp",function(aM){if(aM.keyCode==s){aK()}return !aJ});if(az.hideFocus){D.css("outline","none");if("hideFocus" in am[0]){D.attr("hideFocus",true)}}else{D.css("outline","");if("hideFocus" in am[0]){D.attr("hideFocus",false)}}function aK(){var aN=aa,aM=I;switch(s){case 40:Q.scrollByY(az.keyboardSpeed,false);break;case 38:Q.scrollByY(-az.keyboardSpeed,false);break;case 34:case 32:Q.scrollByY(v*az.scrollPagePercent,false);break;case 33:Q.scrollByY(-v*az.scrollPagePercent,false);break;case 39:Q.scrollByX(az.keyboardSpeed,false);break;case 37:Q.scrollByX(-az.keyboardSpeed,false);break}aJ=aN!=aa||aM!=I;return aJ}}function R(){D.attr("tabindex","-1").removeAttr("tabindex").unbind("keydown.jsp keypress.jsp")}function C(){if(location.hash&&location.hash.length>1){var aL,aJ,aK=escape(location.hash);try{aL=b(aK)}catch(s){return}if(aL.length&&Y.find(aK)){if(am.scrollTop()===0){aJ=setInterval(function(){if(am.scrollTop()>0){ab(aK,true);b(document).scrollTop(am.position().top);clearInterval(aJ)}},50)}else{ab(aK,true);b(document).scrollTop(am.position().top)}}}}function ai(){b("a.jspHijack").unbind("click.jsp-hijack").removeClass("jspHijack")}function m(){ai();b("a[href^=#]").addClass("jspHijack").bind("click.jsp-hijack",function(){var s=this.href.split("#"),aJ;if(s.length>1){aJ=s[1];if(aJ.length>0&&Y.find("#"+aJ).length>0){ab("#"+aJ,true);return false}}})}function ao(){var aK,aJ,aM,aL,aN,s=false;am.unbind("touchstart.jsp touchmove.jsp touchend.jsp click.jsp-touchclick").bind("touchstart.jsp",function(aO){var aP=aO.originalEvent.touches[0];aK=aD();aJ=aB();aM=aP.pageX;aL=aP.pageY;aN=false;s=true}).bind("touchmove.jsp",function(aR){if(!s){return}var aQ=aR.originalEvent.touches[0],aP=aa,aO=I;Q.scrollTo(aK+aM-aQ.pageX,aJ+aL-aQ.pageY);aN=aN||Math.abs(aM-aQ.pageX)>5||Math.abs(aL-aQ.pageY)>5;
return aP==aa&&aO==I}).bind("touchend.jsp",function(aO){s=false}).bind("click.jsp-touchclick",function(aO){if(aN){aN=false;return false}})}function g(){var s=aB(),aJ=aD();D.removeClass("jspScrollable").unbind(".jsp");D.replaceWith(ap.append(Y.children()));ap.scrollTop(s);ap.scrollLeft(aJ)}b.extend(Q,{reinitialise:function(aJ){aJ=b.extend({},az,aJ);at(aJ)},scrollToElement:function(aK,aJ,s){ab(aK,aJ,s)},scrollTo:function(aK,s,aJ){N(aK,aJ);M(s,aJ)},scrollToX:function(aJ,s){N(aJ,s)},scrollToY:function(s,aJ){M(s,aJ)},scrollToPercentX:function(aJ,s){N(aJ*(T-ak),s)},scrollToPercentY:function(aJ,s){M(aJ*(Z-v),s)},scrollBy:function(aJ,s,aK){Q.scrollByX(aJ,aK);Q.scrollByY(s,aK)},scrollByX:function(s,aK){var aJ=aD()+Math[s<0?"floor":"ceil"](s),aL=aJ/(T-ak);W(aL*j,aK)},scrollByY:function(s,aK){var aJ=aB()+Math[s<0?"floor":"ceil"](s),aL=aJ/(Z-v);V(aL*i,aK)},positionDragX:function(s,aJ){W(s,aJ)},positionDragY:function(aJ,s){V(aJ,s)},animate:function(aJ,aM,s,aL){var aK={};aK[aM]=s;aJ.animate(aK,{duration:az.animateDuration,easing:az.animateEase,queue:false,step:aL})},getContentPositionX:function(){return aD()},getContentPositionY:function(){return aB()},getContentWidth:function(){return T},getContentHeight:function(){return Z},getPercentScrolledX:function(){return aD()/(T-ak)},getPercentScrolledY:function(){return aB()/(Z-v)},getIsScrollableH:function(){return aF},getIsScrollableV:function(){return aA},getContentPane:function(){return Y},scrollToBottom:function(s){V(i,s)},hijackInternalLinks:function(){m()},destroy:function(){g()}});at(O)}e=b.extend({},b.fn.jScrollPane.defaults,e);b.each(["mouseWheelSpeed","arrowButtonSpeed","trackClickSpeed","keyboardSpeed"],function(){e[this]=e[this]||e.speed});return this.each(function(){var f=b(this),g=f.data("jsp");if(g){g.reinitialise(e)}else{g=new d(f,e);f.data("jsp",g)}})};b.fn.jScrollPane.defaults={showArrows:false,maintainPosition:true,stickToBottom:false,stickToRight:false,clickOnTrack:true,autoReinitialise:false,autoReinitialiseDelay:500,verticalDragMinHeight:0,verticalDragMaxHeight:99999,horizontalDragMinWidth:0,horizontalDragMaxWidth:99999,contentWidth:c,animateScroll:false,animateDuration:300,animateEase:"linear",hijackInternalLinks:false,verticalGutter:4,horizontalGutter:4,mouseWheelSpeed:0,arrowButtonSpeed:0,arrowRepeatFreq:50,arrowScrollOnHover:false,trackClickSpeed:0,trackClickRepeatFreq:70,verticalArrowPositions:"split",horizontalArrowPositions:"split",enableKeyboardNavigation:true,hideFocus:false,keyboardSpeed:0,initialDelay:300,speed:30,scrollPagePercent:0.8}})(jQuery,this);


//ceebox
/*!
 * CeeBox 2.1.5.1 jQuery Plugin
 * Requires jQuery 1.3.2 and swfobject.jquery.js plugin to work
 * Code hosted on GitHub (http://github.com/catcubed/ceebox) Please visit there for version history information
 * By Colin Fahrion (http://www.catcubed.com)
 * Inspiration for ceebox comes from Thickbox (http://jquery.com/demo/thickbox/) and Videobox (http://videobox-lb.sourceforge.net/)
 * However, along the upgrade path ceebox has morphed a long way from those roots.
 * Copyright (c) 2009 Colin Fahrion
 * Licensed under the MIT License: http://www.opensource.org/licenses/mit-license.php
*/

// To make ceebox work add $(".ceebox").ceebox(); to your global js file or if you don't have one just uncomment the following...
//$(document).ready(function(){ $(".ceebox").ceebox();});

/* OPTIONAL DEFAULT opts
  * You can change many of the default options
  * $(".ceebox").ceebox({vidWidth:600,vidHeight:400,htmlWidth:600,htmlHeight:400,animSpeed:"fast",overlayColor:"#f00",overlayOpacity:0.8});
*/
(function($){$.ceebox={version:"2.1.5.1"};$.fn.ceebox=function(opts){opts=$.extend({selector:$(this).selector},$.fn.ceebox.defaults,opts);var elem=this;var selector=$(this).selector;if(opts.videoJSON){$.getJSON(opts.videoJSON,function(json){$.extend($.fn.ceebox.videos,json);init(elem,opts,selector)})}else{init(elem,opts,selector)}return this};$.fn.ceebox.defaults={html:true,image:false,video:false,modal:false,titles:true,htmlGallery:true,imageGallery:true,videoGallery:true,videoWidth:false,videoHeight:false,videoRatio:"16:9",htmlWidth:false,htmlHeight:false,htmlRatio:false,imageWidth:false,imageHeight:false,animSpeed:"normal",easing:"swing",fadeOut:400,fadeIn:400,overlayColor:"#666666",overlayOpacity:0.8,boxColor:"",textColor:"",borderColor:"",borderWidth:"3px",padding:15,margin:150,onload:null,videoJSON:null,iPhoneRedirect:true};$.fn.ceebox.ratios={"4:3":1.333,"3:2":1.5,"16:9":1.778,"1:1":1,"square":1};$.fn.ceebox.relMatch={width:/(?:width:)([0-9]+)/i,height:/(?:height:)([0-9]+)/i,ratio:/(?:ratio:)([0-9\.:]+)/i,modal:/modal:true/i,nonmodal:/modal:false/i,videoSrc:/(?:videoSrc:)(http:[\/\-\._0-9a-zA-Z:]+)/i,videoId:/(?:videoId:)([\-\._0-9a-zA-Z:]+)/i,start:/(?:start:)([0-9]+)/i};$.fn.ceebox.loader="<div id='cee_load' style='z-index:105;top:50%;left:50%;position:fixed'></div>";$.fn.ceebox.videos={base:{param:{wmode:"transparent",allowFullScreen:"true",allowScriptAccess:"always"},flashvars:{autoplay:true}},facebook:{siteRgx:/facebook\.com\/video/i,idRgx:/(?:v=)([a-zA-Z0-9_]+)/i,src:"http://www.facebook.com/v/[id]"},youtube:{siteRgx:/youtube\.com\/watch/i,idRgx:/(?:v=)([a-zA-Z0-9_\-]+)/i,src:"http://www.youtube.com/v/[id]&hl=en&fs=1&autoplay=1"},metacafe:{siteRgx:/metacafe\.com\/watch/i,idRgx:/(?:watch\/)([a-zA-Z0-9_]+)/i,src:"http://www.metacafe.com/fplayer/[id]/.swf"},google:{siteRgx:/google\.com\/videoplay/i,idRgx:/(?:id=)([a-zA-Z0-9_\-]+)/i,src:"http://video.google.com/googleplayer.swf?docId=[id]&hl=en&fs=true",flashvars:{playerMode:"normal",fs:true}},spike:{siteRgx:/spike\.com\/video|ifilm\.com\/video/i,idRgx:/(?:\/)([0-9]+)/i,src:"http://www.spike.com/efp",flashvars:{flvbaseclip:"[id]"}},vimeo:{siteRgx:/vimeo\.com\/[0-9]+/i,idRgx:/(?:\.com\/)([a-zA-Z0-9_]+)/i,src:"http://www.vimeo.com/moogaloop.swf?clip_id=[id]&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=&fullscreen=1"},dailymotion:{siteRgx:/dailymotion\.com\/video/i,idRgx:/(?:video\/)([a-zA-Z0-9_]+)/i,src:"http://www.dailymotion.com/swf/[id]&related=0&autoplay=1"},cnn:{siteRgx:/cnn\.com\/video/i,idRgx:/(?:\?\/video\/)([a-zA-Z0-9_\/\.]+)/i,src:"http://i.cdn.turner.com/cnn/.element/apps/cvp/3.0/swf/cnn_416x234_embed.swf?context=embed&videoId=[id]",width:416,height:374}};$.fn.ceebox.overlay=function(opts){opts=$.extend({width:60,height:30,type:"html"},$.fn.ceebox.defaults,opts);if($("#cee_overlay").size()===0){$("<div id='cee_overlay'></div>").css({opacity:opts.overlayOpacity,position:"absolute",top:0,left:0,backgroundColor:opts.overlayColor,width:"100%",height:$(document).height(),zIndex:100}).appendTo($("body"))}if($("#cee_box").size()===0){var pos=boxPos(opts);var boxCSS={position:pos.position,zIndex:102,top:"50%",left:"50%",height:opts.height+"px",width:opts.width+"px",marginLeft:pos.mleft+'px',marginTop:pos.mtop+'px',opacity:0,borderWidth:opts.borderWidth,borderColor:opts.borderColor,backgroundColor:opts.boxColor,color:opts.textColor};$("<div id='cee_box'></div>").css(boxCSS).appendTo("body").animate({opacity:1},opts.animSpeed,function(){$("#cee_overlay").addClass("cee_close")})}$("#cee_box").removeClass().addClass("cee_"+opts.type);if($("#cee_load").size()===0){$($.fn.ceebox.loader).appendTo("body")}$("#cee_load").show("fast").animate({opacity:1},"fast")};$.fn.ceebox.popup=function(content,opts){var page=pageSize(opts.margin);opts=$.extend({width:page.width,height:page.height,modal:false,type:"html",onload:null},$.fn.ceebox.defaults,opts);var gallery,family;if($(content).is("a,area,input")&&(opts.type=="html"||opts.type=="image"||opts.type=="video")){if(opts.gallery){family=$(opts.selector).eq(opts.gallery.parentId).find("a[href],area[href],input[href]")}Build[opts.type].prototype=new BoxAttr(content,opts);var cb=new Build[opts.type]();content=cb.content;opts.action=cb.action;opts.modal=cb.modal;if(opts.titles){opts.titleHeight=$(cb.titlebox).contents().contents().wrap("<div></div>").parent().attr("id","ceetitletest").css({position:"absolute",top:"-300px",width:cb.width+"px"}).appendTo("body").height();$("#ceetitletest").remove();opts.titleHeight=(opts.titleHeight>=10)?opts.titleHeight+20:30}else{opts.titleHeight=0}opts.width=cb.width+2*opts.padding;opts.height=cb.height+opts.titleHeight+2*opts.padding}$.fn.ceebox.overlay(opts);base.action=opts.action;base.onload=opts.onload;var pos=boxPos(opts);var animOpts={marginLeft:pos.mleft,marginTop:pos.mtop,width:opts.width+"px",height:opts.height+"px",borderWidth:opts.borderWidth};if(opts.borderColor){var reg=/#[1-90a-f]+/gi;var borderColor=cssParse(opts.borderColor,reg);animOpts=$.extend(animOpts,{borderTopColor:borderColor[0],borderRightColor:borderColor[1],borderBottomColor:borderColor[2],borderLeftColor:borderColor[3]})}animOpts=(opts.textColor)?$.extend(animOpts,{color:opts.textColor}):animOpts;animOpts=(opts.boxColor)?$.extend(animOpts,{backgroundColor:opts.boxColor}):animOpts;$("#cee_box").animate(animOpts,opts.animSpeed,opts.easing,function(){var children=$(this).append(content).children().hide();var len=children.length;var onloadcall=true;children.fadeIn(opts.fadeIn,function(){if($(this).is("#cee_iframeContent")){onloadcall=false}if(onloadcall&&this==children[len-1]){$.fn.ceebox.onload()}});if(opts.modal===true){$("#cee_overlay").removeClass("cee_close")}else{$("<a href='#' id='cee_closeBtn' class='cee_close' title='Close'>close</a>").prependTo("#cee_box");if(opts.gallery){addGallery(opts.gallery,family,opts)}keyEvents(gallery,family,opts.fadeOut)}})};$.fn.ceebox.closebox=function(fade){fade=fade||400;$("#cee_box").fadeOut(fade);$("#cee_overlay").fadeOut((typeof fade=='number')?fade*2:"slow",function(){$('#cee_box,#cee_overlay,#cee_HideSelect,#cee_load').unbind().remove()})};$.fn.ceebox.onload=function(opts){$("#cee_load").hide(300).fadeOut(600,function(){$(this).remove()});if(isFunction(base.action)){base.action();base.action=null}if(isFunction(base.onload)){base.onload();base.onload=null}};var base={};function init(elem,opts,selector){base.vidRegex=function(){var regStr="";$.each($.fn.ceebox.videos,function(i,v){if(v.siteRgx!==null&&typeof v.siteRgx!=='string'){var tmp=String(v.siteRgx);regStr=regStr+tmp.slice(1,tmp.length-2)+"|"}});return new RegExp(regStr+"\\.swf$","i")}();base.userAgent=navigator.userAgent;$(".cee_close").die().live("click",function(){$.fn.ceebox.closebox();return false});if(selector!=false){$(elem).each(function(i){ceeboxLinkSort(this,i,opts,selector)})}$(elem).bind("click",function(e){var tgt=$(e.target).closest("[href]");var tgtData=tgt.data("ceebox");if(tgtData){var linkOpts=(tgtData.opts)?$.extend({},opts,tgtData.opts):opts;$.fn.ceebox.overlay(linkOpts);if(tgtData.type=="image"){var imgPreload=new Image();imgPreload.onload=function(){var w=imgPreload.width,h=imgPreload.height;linkOpts.imageWidth=getSmlr(w,$.fn.ceebox.defaults.imageWidth);linkOpts.imageHeight=getSmlr(h,$.fn.ceebox.defaults.imageHeight);linkOpts.imageRatio=w/h;$.fn.ceebox.popup(tgt,$.extend(linkOpts,{type:tgtData.type},{gallery:tgtData.gallery}))};imgPreload.src=$(tgt).attr("href")}else{$.fn.ceebox.popup(tgt,$.extend(linkOpts,{type:tgtData.type},{gallery:tgtData.gallery}))}return false}})}var ceeboxLinkSort=function(parent,parentId,opts,selector){var family,cbLinks=[],galleryLinks=[],gNum=0;($(parent).is("[href]"))?family=$(parent):family=$(parent).find("[href]");var urlMatch={image:function(h,r){if(r&&r.match(/\bimage\b/i)){return true}else{return h.match(/\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$/i)||false}},video:function(h,r){if(r&&r.match(/\bvideo\b/i)){return true}else{return h.match(base.vidRegex)||false}},html:function(h){return true}};var familyLen=family.length;family.each(function(i){var alink=this;var metadata=$.metadata?$(alink).metadata():false;var linkOpts=metadata?$.extend({},opts,metadata):opts;$.each(urlMatch,function(type){if(urlMatch[type]($(alink).attr("href"),$(alink).attr("rel"))&&linkOpts[type]){var gallery=false;if(linkOpts[type+"Gallery"]===true){galleryLinks[galleryLinks.length]=i;gallery=true}cbLinks[cbLinks.length]={linkObj:alink,type:type,gallery:gallery,linkOpts:linkOpts};return false}})});var gLen=galleryLinks.length;$.each(cbLinks,function(i){if(cbLinks[i].gallery){var gallery={parentId:parentId,gNum:gNum,gLen:gLen};if(gNum>0){gallery.prevId=galleryLinks[gNum-1]}if(gNum<gLen-1){gallery.nextId=galleryLinks[gNum+1]}gNum++}if(!$.support.opacity&&$(parent).is("map")){$(cbLinks[i].linkObj).click(function(e){e.preventDefault()})}$.data(cbLinks[i].linkObj,"ceebox",{type:cbLinks[i].type,opts:cbLinks[i].linkOpts,gallery:gallery})})};var BoxAttr=function(cblink,o){var w=o[o.type+"Width"];var h=o[o.type+"Height"];var r=o[o.type+"Ratio"]||w/h;var rel=$(cblink).attr("rel");if(rel&&rel!==""){var m={};$.each($.fn.ceebox.relMatch,function(i,v){m[i]=v.exec(rel)});if(m.modal){o.modal=true}if(m.nonmodal){o.modal=false}if(m.width){w=Number(lastItem(m.width))}if(m.height){h=Number(lastItem(m.height))}if(m.ratio){r=lastItem(m.ratio);r=(Number(r))?Number(r):String(r)}if(m.videoSrc){this.videoSrc=String(lastItem(m.videoSrc))}if(m.videoId){this.videoId=String(lastItem(m.videoId))}if(m.start){this.startTime=Number(lastItem(m.start))}}var p=pageSize(o.margin);w=getSmlr(w,p.width);h=getSmlr(h,p.height);if(r){if(!Number(r)){r=($.fn.ceebox.ratios[r])?Number($.fn.ceebox.ratios[r]):1}if(w/h>r){w=parseInt(h*r,10)}if(w/h<r){h=parseInt(w/r,10)}}this.modal=o.modal;this.href=$(cblink).attr("href");this.title=$(cblink).attr("title")||cblink.t||"";this.titlebox=(o.titles)?"<div id='cee_title'><h2>"+this.title+"</h2></div>":"";this.width=w;this.height=h;this.rel=rel;this.iPhoneRedirect=o.iPhoneRedirect};var Build={image:function(){this.content="<img id='cee_img' src='"+this.href+"' width='"+this.width+"' height='"+this.height+"' alt='"+this.title+"'/>"+this.titlebox},video:function(){var content="",cb=this;var vid=function(){var rtn=this,id=cb.videoId;rtn.flashvars=rtn.param={};rtn.src=cb.videoSrc||cb.href;rtn.width=cb.width;rtn.height=cb.height;$.each($.fn.ceebox.videos,function(i,v){if(v.siteRgx&&typeof v.siteRgx!='string'&&v.siteRgx.test(cb.href)){if(v.idRgx){v.idRgx=new RegExp(v.idRgx);id=String(lastItem(v.idRgx.exec(cb.href)))}rtn.src=(v.src)?v.src.replace("[id]",id):rtn.src;var startTimeMinReg=new RegExp(/(?:t=)*([0-9]+)m/i);var startTimeSecReg=new RegExp(/(?:t=)*([0-9]+)s/i);var startTimeMin=startTimeMinReg.exec(cb.href);var startTimeSec=startTimeSecReg.exec(cb.href);var startTime=0;if(startTimeMin){startTime=Number(startTimeMin[1])*60}if(startTimeSec){startTime=startTime+Number(startTimeSec[1])}if(v.flashvars){$.each(v.flashvars,function(ii,vv){if(typeof vv=='string'){rtn.flashvars[ii]=vv.replace("[id]",id)}})}if(v.param){$.each(v.param,function(ii,vv){if(typeof vv=='string'){rtn.param[ii]=vv.replace("[id]",id)}})}if(cb.startTime||startTime){rtn.param["start"]=startTime||cb.startTime}rtn.width=v.width||rtn.width;rtn.height=v.height||rtn.height;rtn.site=i;return}});return rtn}();if($.flash.hasVersion(8)){this.width=vid.width;this.height=vid.height;this.action=function(){$('#cee_vid').flash({swf:vid.src,params:$.extend($.fn.ceebox.videos.base.param,vid.param),flashvars:$.extend($.fn.ceebox.videos.base.flashvars,vid.flashvars),width:vid.width,height:vid.height})}}else{this.width=400;this.height=200;if(((base.userAgent.match(/iPhone/i))&&this.iPhoneRedirect)||((base.userAgent.match(/iPod/i))&&this.iPhoneRedirect)){var redirect=this.href;this.action=function(){$.fn.ceebox.closebox(400,function(){window.location=redirect})}}else{vid.site=vid.site||"SWF file";content="<p style='margin:20px'>Adobe Flash 8 or higher is required to view this movie. You can either:</p><ul><li>Follow link to <a href='"+this.href+"'>"+vid.site+" </a></li><li>or <a href='http://www.adobe.com/products/flashplayer/'>Install Flash</a></li><li> or <a href='#' class='cee_close'>Close This Popup</a></li></ul>"}}this.content="<div id='cee_vid' style='width:"+this.width+"px;height:"+this.height+"px;'>"+content+"</div>"+this.titlebox},html:function(){var h=this.href,r=this.rel;var m=[h.match(/[a-zA-Z0-9_\.]+\.[a-zA-Z]{2,4}/i),h.match(/^http:+/),(r)?r.match(/^iframe/):false];if((document.domain==m[0]&&m[1]&&!m[2])||(!m[1]&&!m[2])){var id,ajx=(id=h.match(/#[a-zA-Z0-9_\-]+/))?String(h.split("#")[0]+" "+id):h;this.content=this.titlebox+"<div id='cee_ajax' style='width:"+(this.width-30)+"px;height:"+(this.height-20)+"px'></div>";this.action=function(){$.post(ajx,function(data){$("#cee_ajax").empty().append(data)})}}else{$("#cee_iframe").remove();this.content=this.titlebox+"<iframe frameborder='0' hspace='0' src='"+h+"' id='cee_iframeContent' name='cee_iframeContent"+Math.round(Math.random()*1000)+"' onload='jQuery.fn.ceebox.onload()' style='width:"+(this.width)+"px;height:"+(this.height)+"px;' > </iframe>"}}};function pageSize(margin){var de=document.documentElement;margin=margin||100;this.width=(window.innerWidth||self.innerWidth||(de&&de.clientWidth)||document.body.clientWidth)-margin;this.height=(window.innerHeight||self.innerHeight||(de&&de.clientHeight)||document.body.clientHeight)-margin;return this}function boxPos(opts){var pos="fixed",scroll=0,reg=/[0-9]+/g,b=cssParse(opts.borderWidth,reg);if(!window.XMLHttpRequest){if($("#cee_HideSelect")===null){$("body").append("<iframe id='cee_HideSelect'></iframe>")}pos="absolute";scroll=parseInt((document.documentElement&&document.documentElement.scrollTop||document.body.scrollTop),10)}this.mleft=parseInt(-1*((opts.width)/2+Number(b[3])),10);this.mtop=parseInt(-1*((opts.height)/2+Number(b[0])),10)+scroll;this.position=pos;return this}function cssParse(css,reg){var temp=css.match(reg),rtn=[],l=temp.length;if(l>1){rtn[0]=temp[0];rtn[1]=temp[1];rtn[2]=(l==2)?temp[0]:temp[2];rtn[3]=(l==4)?temp[3]:temp[1]}else{rtn=[temp,temp,temp,temp]}return rtn}function keyEvents(){document.onkeydown=function(e){e=e||window.event;var kc=e.keyCode||e.which;switch(kc){case 13:return false;case 27:$.fn.ceebox.closebox();document.onkeydown=null;break;case 188:case 37:$("#cee_prev").trigger("click");break;case 190:case 39:$("#cee_next").trigger("click");break;default:break}return true}}function addGallery(g,family,opts){var h=opts.height,w=opts.width,th=opts.titleHeight,p=opts.padding;var nav={image:{w:parseInt(w/2,10),h:h-th-2*p,top:p,bgtop:(h-th-2*p)/2},video:{w:60,h:80,top:parseInt(((h-th-10)-2*p)/2,10),bgtop:24}};nav.html=nav.video;function navLink(btn,id){var s,on=nav[opts.type].bgtop,off=(on-2000),px="px";(btn=="prev")?s=[{left:0},"left"]:s=[{right:0},x="right"];var style=function(y){return $.extend({zIndex:105,width:nav[opts.type].w+px,height:nav[opts.type].h+px,position:"absolute",top:nav[opts.type].top,backgroundPosition:s[1]+" "+y+px},s[0])};$("<a href='#'></a>").text(btn).attr({id:"cee_"+btn}).css(style(off)).hover(function(){$(this).css(style(on))},function(){$(this).css(style(off))}).one("click",function(e){e.preventDefault();(function(f,id,fade){$("#cee_prev,#cee_next").unbind().click(function(){return false});document.onkeydown=null;var content=$("#cee_box").children(),len=content.length;content.fadeOut(fade,function(){$(this).remove();if(this==content[len-1]){f.eq(id).trigger("click")}})})(family,id,opts.fadeOut)}).appendTo("#cee_box")}if(g.prevId>=0){navLink("prev",g.prevId)}if(g.nextId){navLink("next",g.nextId)}$("#cee_title").append("<div id='cee_count'>Item "+(g.gNum+1)+" of "+g.gLen+"</div>")}function getSmlr(a,b){return((a&&a<b)||!b)?a:b}function isFunction(a){return typeof a=='function'}function lastItem(a){var l=a.length;return(l>1)?a[l-1]:a}function debug(a,tag,opts){if(debugging===true){var bugs="",header="[ceebox]("+(tag||"")+")";($.isArray(a)||typeof a=='object'||typeof a=='function')?$.each(a,function(i,val){bugs=bugs+i+":"+val+", "}):bugs=a;if(window.console&&window.console.log){window.console.log(header+bugs)}else{if($("#debug").size()===0){$("<ul id='debug'></ul>").appendTo("body").css({border:"1px solid #ccf",position:"fixed",top:"10px",right:"10px",width:"300px",padding:"10px",listStyle:"square"});$("<li>").css({margin:"0 0 5px"}).appendTo("#debug").append(header).wrapInner("<b></b>").append(" "+bugs)}}}}})(jQuery);

/*
* jQuery timepicker addon
* By: Trent Richardson [http://trentrichardson.com]
* Version 1.0.0
* Last Modified: 02/05/2012
*/
/*! Copyright 2012 Trent Richardson
* Dual licensed under the MIT and GPL licenses.
* http://trentrichardson.com/Impromptu/GPL-LICENSE.txt
* http://trentrichardson.com/Impromptu/MIT-LICENSE.txt
*/
/* HERES THE CSS:
* .ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
* .ui-timepicker-div dl { text-align: left; }
* .ui-timepicker-div dl dt { height: 25px; margin-bottom: -25px; }
* .ui-timepicker-div dl dd { margin: 0 10px 10px 65px; }
* .ui-timepicker-div td { font-size: 90%; }
* .ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }
*/
(function($){$.ui.timepicker=$.ui.timepicker||{};if($.ui.timepicker.version){return}$.extend($.ui,{timepicker:{version:"1.0.0"}});function Timepicker(){this.regional=[];this.regional['']={currentText:'Now',closeText:'Done',ampm:false,amNames:['AM','A'],pmNames:['PM','P'],timeFormat:'hh:mm tt',timeSuffix:'',timeOnlyTitle:'Choose Time',timeText:'Time',hourText:'Hour',minuteText:'Minute',secondText:'Second',millisecText:'Millisecond',timezoneText:'Time Zone'};this._defaults={showButtonPanel:true,timeOnly:false,showHour:true,showMinute:true,showSecond:false,showMillisec:false,showTimezone:false,showTime:true,stepHour:1,stepMinute:1,stepSecond:1,stepMillisec:1,hour:0,minute:0,second:0,millisec:0,timezone:'+0000',hourMin:0,minuteMin:0,secondMin:0,millisecMin:0,hourMax:23,minuteMax:59,secondMax:59,millisecMax:999,minDateTime:null,maxDateTime:null,onSelect:null,hourGrid:0,minuteGrid:0,secondGrid:0,millisecGrid:0,alwaysSetTime:true,separator:' ',altFieldTimeOnly:true,showTimepicker:true,timezoneIso8609:false,timezoneList:null,addSliderAccess:false,sliderAccessArgs:null};$.extend(this._defaults,this.regional[''])};$.extend(Timepicker.prototype,{$input:null,$altInput:null,$timeObj:null,inst:null,hour_slider:null,minute_slider:null,second_slider:null,millisec_slider:null,timezone_select:null,hour:0,minute:0,second:0,millisec:0,timezone:'+0000',hourMinOriginal:null,minuteMinOriginal:null,secondMinOriginal:null,millisecMinOriginal:null,hourMaxOriginal:null,minuteMaxOriginal:null,secondMaxOriginal:null,millisecMaxOriginal:null,ampm:'',formattedDate:'',formattedTime:'',formattedDateTime:'',timezoneList:null,setDefaults:function(settings){extendRemove(this._defaults,settings||{});return this},_newInst:function($input,o){var tp_inst=new Timepicker(),inlineSettings={};for(var attrName in this._defaults){var attrValue=$input.attr('time:'+attrName);if(attrValue){try{inlineSettings[attrName]=eval(attrValue)}catch(err){inlineSettings[attrName]=attrValue}}}tp_inst._defaults=$.extend({},this._defaults,inlineSettings,o,{beforeShow:function(input,dp_inst){if($.isFunction(o.beforeShow))return o.beforeShow(input,dp_inst,tp_inst)},onChangeMonthYear:function(year,month,dp_inst){tp_inst._updateDateTime(dp_inst);if($.isFunction(o.onChangeMonthYear))o.onChangeMonthYear.call($input[0],year,month,dp_inst,tp_inst)},onClose:function(dateText,dp_inst){if(tp_inst.timeDefined===true&&$input.val()!='')tp_inst._updateDateTime(dp_inst);if($.isFunction(o.onClose))o.onClose.call($input[0],dateText,dp_inst,tp_inst)},timepicker:tp_inst});tp_inst.amNames=$.map(tp_inst._defaults.amNames,function(val){return val.toUpperCase()});tp_inst.pmNames=$.map(tp_inst._defaults.pmNames,function(val){return val.toUpperCase()});if(tp_inst._defaults.timezoneList===null){var timezoneList=[];for(var i=-11;i<=12;i++)timezoneList.push((i>=0?'+':'-')+('0'+Math.abs(i).toString()).slice(-2)+'00');if(tp_inst._defaults.timezoneIso8609)timezoneList=$.map(timezoneList,function(val){return val=='+0000'?'Z':(val.substring(0,3)+':'+val.substring(3))});tp_inst._defaults.timezoneList=timezoneList}tp_inst.hour=tp_inst._defaults.hour;tp_inst.minute=tp_inst._defaults.minute;tp_inst.second=tp_inst._defaults.second;tp_inst.millisec=tp_inst._defaults.millisec;tp_inst.ampm='';tp_inst.$input=$input;if(o.altField)tp_inst.$altInput=$(o.altField).css({cursor:'pointer'}).focus(function(){$input.trigger("focus")});if(tp_inst._defaults.minDate==0||tp_inst._defaults.minDateTime==0){tp_inst._defaults.minDate=new Date()}if(tp_inst._defaults.maxDate==0||tp_inst._defaults.maxDateTime==0){tp_inst._defaults.maxDate=new Date()}if(tp_inst._defaults.minDate!==undefined&&tp_inst._defaults.minDate instanceof Date)tp_inst._defaults.minDateTime=new Date(tp_inst._defaults.minDate.getTime());if(tp_inst._defaults.minDateTime!==undefined&&tp_inst._defaults.minDateTime instanceof Date)tp_inst._defaults.minDate=new Date(tp_inst._defaults.minDateTime.getTime());if(tp_inst._defaults.maxDate!==undefined&&tp_inst._defaults.maxDate instanceof Date)tp_inst._defaults.maxDateTime=new Date(tp_inst._defaults.maxDate.getTime());if(tp_inst._defaults.maxDateTime!==undefined&&tp_inst._defaults.maxDateTime instanceof Date)tp_inst._defaults.maxDate=new Date(tp_inst._defaults.maxDateTime.getTime());return tp_inst},_addTimePicker:function(dp_inst){var currDT=(this.$altInput&&this._defaults.altFieldTimeOnly)?this.$input.val()+' '+this.$altInput.val():this.$input.val();this.timeDefined=this._parseTime(currDT);this._limitMinMaxDateTime(dp_inst,false);this._injectTimePicker()},_parseTime:function(timeString,withDate){var regstr=this._defaults.timeFormat.toString().replace(/h{1,2}/ig,'(\\d?\\d)').replace(/m{1,2}/ig,'(\\d?\\d)').replace(/s{1,2}/ig,'(\\d?\\d)').replace(/l{1}/ig,'(\\d?\\d?\\d)').replace(/t{1,2}/ig,this._getPatternAmpm()).replace(/z{1}/ig,'(z|[-+]\\d\\d:?\\d\\d)?').replace(/\s/g,'\\s?')+this._defaults.timeSuffix+'$',order=this._getFormatPositions(),ampm='',treg;if(!this.inst)this.inst=$.datepicker._getInst(this.$input[0]);if(withDate||!this._defaults.timeOnly){var dp_dateFormat=$.datepicker._get(this.inst,'dateFormat');var specials=new RegExp("[.*+?|()\\[\\]{}\\\\]","g");regstr='^.{'+dp_dateFormat.length+',}?'+this._defaults.separator.replace(specials,"\\$&")+regstr}treg=timeString.match(new RegExp(regstr,'i'));if(treg){if(order.t!==-1){if(treg[order.t]===undefined||treg[order.t].length===0){ampm='';this.ampm=''}else{ampm=$.inArray(treg[order.t].toUpperCase(),this.amNames)!==-1?'AM':'PM';this.ampm=this._defaults[ampm=='AM'?'amNames':'pmNames'][0]}}if(order.h!==-1){if(ampm=='AM'&&treg[order.h]=='12')this.hour=0;else if(ampm=='PM'&&treg[order.h]!='12')this.hour=(parseFloat(treg[order.h])+12).toFixed(0);else this.hour=Number(treg[order.h])}if(order.m!==-1)this.minute=Number(treg[order.m]);if(order.s!==-1)this.second=Number(treg[order.s]);if(order.l!==-1)this.millisec=Number(treg[order.l]);if(order.z!==-1&&treg[order.z]!==undefined){var tz=treg[order.z].toUpperCase();switch(tz.length){case 1:tz=this._defaults.timezoneIso8609?'Z':'+0000';break;case 5:if(this._defaults.timezoneIso8609)tz=tz.substring(1)=='0000'?'Z':tz.substring(0,3)+':'+tz.substring(3);break;case 6:if(!this._defaults.timezoneIso8609)tz=tz=='Z'||tz.substring(1)=='00:00'?'+0000':tz.replace(/:/,'');else if(tz.substring(1)=='00:00')tz='Z';break}this.timezone=tz}return true}return false},_getPatternAmpm:function(){var markers=[],o=this._defaults;if(o.amNames)$.merge(markers,o.amNames);if(o.pmNames)$.merge(markers,o.pmNames);markers=$.map(markers,function(val){return val.replace(/[.*+?|()\[\]{}\\]/g,'\\$&')});return'('+markers.join('|')+')?'},_getFormatPositions:function(){var finds=this._defaults.timeFormat.toLowerCase().match(/(h{1,2}|m{1,2}|s{1,2}|l{1}|t{1,2}|z)/g),orders={h:-1,m:-1,s:-1,l:-1,t:-1,z:-1};if(finds)for(var i=0;i<finds.length;i++)if(orders[finds[i].toString().charAt(0)]==-1)orders[finds[i].toString().charAt(0)]=i+1;return orders},_injectTimePicker:function(){var $dp=this.inst.dpDiv,o=this._defaults,tp_inst=this,hourMax=parseInt((o.hourMax-((o.hourMax-o.hourMin)%o.stepHour)),10),minMax=parseInt((o.minuteMax-((o.minuteMax-o.minuteMin)%o.stepMinute)),10),secMax=parseInt((o.secondMax-((o.secondMax-o.secondMin)%o.stepSecond)),10),millisecMax=parseInt((o.millisecMax-((o.millisecMax-o.millisecMin)%o.stepMillisec)),10),dp_id=this.inst.id.toString().replace(/([^A-Za-z0-9_])/g,'');if($dp.find("div#ui-timepicker-div-"+dp_id).length===0&&o.showTimepicker){var noDisplay=' style="display:none;"',html='<div class="ui-timepicker-div" id="ui-timepicker-div-'+dp_id+'"><dl>'+'<dt class="ui_tpicker_time_label" id="ui_tpicker_time_label_'+dp_id+'"'+((o.showTime)?'':noDisplay)+'>'+o.timeText+'</dt>'+'<dd class="ui_tpicker_time" id="ui_tpicker_time_'+dp_id+'"'+((o.showTime)?'':noDisplay)+'></dd>'+'<dt class="ui_tpicker_hour_label" id="ui_tpicker_hour_label_'+dp_id+'"'+((o.showHour)?'':noDisplay)+'>'+o.hourText+'</dt>',hourGridSize=0,minuteGridSize=0,secondGridSize=0,millisecGridSize=0,size=null;html+='<dd class="ui_tpicker_hour"><div id="ui_tpicker_hour_'+dp_id+'"'+((o.showHour)?'':noDisplay)+'></div>';if(o.showHour&&o.hourGrid>0){html+='<div style="padding-left: 1px"><table class="ui-tpicker-grid-label"><tr>';for(var h=o.hourMin;h<=hourMax;h+=parseInt(o.hourGrid,10)){hourGridSize++;var tmph=(o.ampm&&h>12)?h-12:h;if(tmph<10)tmph='0'+tmph;if(o.ampm){if(h==0)tmph=12+'a';else if(h<12)tmph+='a';else tmph+='p'}html+='<td>'+tmph+'</td>'}html+='</tr></table></div>'}html+='</dd>';html+='<dt class="ui_tpicker_minute_label" id="ui_tpicker_minute_label_'+dp_id+'"'+((o.showMinute)?'':noDisplay)+'>'+o.minuteText+'</dt>'+'<dd class="ui_tpicker_minute"><div id="ui_tpicker_minute_'+dp_id+'"'+((o.showMinute)?'':noDisplay)+'></div>';if(o.showMinute&&o.minuteGrid>0){html+='<div style="padding-left: 1px"><table class="ui-tpicker-grid-label"><tr>';for(var m=o.minuteMin;m<=minMax;m+=parseInt(o.minuteGrid,10)){minuteGridSize++;html+='<td>'+((m<10)?'0':'')+m+'</td>'}html+='</tr></table></div>'}html+='</dd>';html+='<dt class="ui_tpicker_second_label" id="ui_tpicker_second_label_'+dp_id+'"'+((o.showSecond)?'':noDisplay)+'>'+o.secondText+'</dt>'+'<dd class="ui_tpicker_second"><div id="ui_tpicker_second_'+dp_id+'"'+((o.showSecond)?'':noDisplay)+'></div>';if(o.showSecond&&o.secondGrid>0){html+='<div style="padding-left: 1px"><table><tr>';for(var s=o.secondMin;s<=secMax;s+=parseInt(o.secondGrid,10)){secondGridSize++;html+='<td>'+((s<10)?'0':'')+s+'</td>'}html+='</tr></table></div>'}html+='</dd>';html+='<dt class="ui_tpicker_millisec_label" id="ui_tpicker_millisec_label_'+dp_id+'"'+((o.showMillisec)?'':noDisplay)+'>'+o.millisecText+'</dt>'+'<dd class="ui_tpicker_millisec"><div id="ui_tpicker_millisec_'+dp_id+'"'+((o.showMillisec)?'':noDisplay)+'></div>';if(o.showMillisec&&o.millisecGrid>0){html+='<div style="padding-left: 1px"><table><tr>';for(var l=o.millisecMin;l<=millisecMax;l+=parseInt(o.millisecGrid,10)){millisecGridSize++;html+='<td>'+((l<10)?'0':'')+l+'</td>'}html+='</tr></table></div>'}html+='</dd>';html+='<dt class="ui_tpicker_timezone_label" id="ui_tpicker_timezone_label_'+dp_id+'"'+((o.showTimezone)?'':noDisplay)+'>'+o.timezoneText+'</dt>';html+='<dd class="ui_tpicker_timezone" id="ui_tpicker_timezone_'+dp_id+'"'+((o.showTimezone)?'':noDisplay)+'></dd>';html+='</dl></div>';$tp=$(html);if(o.timeOnly===true){$tp.prepend('<div class="ui-widget-header ui-helper-clearfix ui-corner-all">'+'<div class="ui-datepicker-title">'+o.timeOnlyTitle+'</div>'+'</div>');$dp.find('.ui-datepicker-header, .ui-datepicker-calendar').hide()}this.hour_slider=$tp.find('#ui_tpicker_hour_'+dp_id).slider({orientation:"horizontal",value:this.hour,min:o.hourMin,max:hourMax,step:o.stepHour,slide:function(event,ui){tp_inst.hour_slider.slider("option","value",ui.value);tp_inst._onTimeChange()}});this.minute_slider=$tp.find('#ui_tpicker_minute_'+dp_id).slider({orientation:"horizontal",value:this.minute,min:o.minuteMin,max:minMax,step:o.stepMinute,slide:function(event,ui){tp_inst.minute_slider.slider("option","value",ui.value);tp_inst._onTimeChange()}});this.second_slider=$tp.find('#ui_tpicker_second_'+dp_id).slider({orientation:"horizontal",value:this.second,min:o.secondMin,max:secMax,step:o.stepSecond,slide:function(event,ui){tp_inst.second_slider.slider("option","value",ui.value);tp_inst._onTimeChange()}});this.millisec_slider=$tp.find('#ui_tpicker_millisec_'+dp_id).slider({orientation:"horizontal",value:this.millisec,min:o.millisecMin,max:millisecMax,step:o.stepMillisec,slide:function(event,ui){tp_inst.millisec_slider.slider("option","value",ui.value);tp_inst._onTimeChange()}});this.timezone_select=$tp.find('#ui_tpicker_timezone_'+dp_id).append('<select></select>').find("select");$.fn.append.apply(this.timezone_select,$.map(o.timezoneList,function(val,idx){return $("<option />").val(typeof val=="object"?val.value:val).text(typeof val=="object"?val.label:val)}));this.timezone_select.val((typeof this.timezone!="undefined"&&this.timezone!=null&&this.timezone!="")?this.timezone:o.timezone);this.timezone_select.change(function(){tp_inst._onTimeChange()});if(o.showHour&&o.hourGrid>0){size=100*hourGridSize*o.hourGrid/(hourMax-o.hourMin);$tp.find(".ui_tpicker_hour table").css({width:size+"%",marginLeft:(size/(-2*hourGridSize))+"%",borderCollapse:'collapse'}).find("td").each(function(index){$(this).click(function(){var h=$(this).html();if(o.ampm){var ap=h.substring(2).toLowerCase(),aph=parseInt(h.substring(0,2),10);if(ap=='a'){if(aph==12)h=0;else h=aph}else if(aph==12)h=12;else h=aph+12}tp_inst.hour_slider.slider("option","value",h);tp_inst._onTimeChange();tp_inst._onSelectHandler()}).css({cursor:'pointer',width:(100/hourGridSize)+'%',textAlign:'center',overflow:'hidden'})})}if(o.showMinute&&o.minuteGrid>0){size=100*minuteGridSize*o.minuteGrid/(minMax-o.minuteMin);$tp.find(".ui_tpicker_minute table").css({width:size+"%",marginLeft:(size/(-2*minuteGridSize))+"%",borderCollapse:'collapse'}).find("td").each(function(index){$(this).click(function(){tp_inst.minute_slider.slider("option","value",$(this).html());tp_inst._onTimeChange();tp_inst._onSelectHandler()}).css({cursor:'pointer',width:(100/minuteGridSize)+'%',textAlign:'center',overflow:'hidden'})})}if(o.showSecond&&o.secondGrid>0){$tp.find(".ui_tpicker_second table").css({width:size+"%",marginLeft:(size/(-2*secondGridSize))+"%",borderCollapse:'collapse'}).find("td").each(function(index){$(this).click(function(){tp_inst.second_slider.slider("option","value",$(this).html());tp_inst._onTimeChange();tp_inst._onSelectHandler()}).css({cursor:'pointer',width:(100/secondGridSize)+'%',textAlign:'center',overflow:'hidden'})})}if(o.showMillisec&&o.millisecGrid>0){$tp.find(".ui_tpicker_millisec table").css({width:size+"%",marginLeft:(size/(-2*millisecGridSize))+"%",borderCollapse:'collapse'}).find("td").each(function(index){$(this).click(function(){tp_inst.millisec_slider.slider("option","value",$(this).html());tp_inst._onTimeChange();tp_inst._onSelectHandler()}).css({cursor:'pointer',width:(100/millisecGridSize)+'%',textAlign:'center',overflow:'hidden'})})}var $buttonPanel=$dp.find('.ui-datepicker-buttonpane');if($buttonPanel.length)$buttonPanel.before($tp);else $dp.append($tp);this.$timeObj=$tp.find('#ui_tpicker_time_'+dp_id);if(this.inst!==null){var timeDefined=this.timeDefined;this._onTimeChange();this.timeDefined=timeDefined}var onSelectDelegate=function(){tp_inst._onSelectHandler()};this.hour_slider.bind('slidestop',onSelectDelegate);this.minute_slider.bind('slidestop',onSelectDelegate);this.second_slider.bind('slidestop',onSelectDelegate);this.millisec_slider.bind('slidestop',onSelectDelegate);if(this._defaults.addSliderAccess){var sliderAccessArgs=this._defaults.sliderAccessArgs;setTimeout(function(){if($tp.find('.ui-slider-access').length==0){$tp.find('.ui-slider:visible').sliderAccess(sliderAccessArgs);var sliderAccessWidth=$tp.find('.ui-slider-access:eq(0)').outerWidth(true);if(sliderAccessWidth){$tp.find('table:visible').each(function(){var $g=$(this),oldWidth=$g.outerWidth(),oldMarginLeft=$g.css('marginLeft').toString().replace('%',''),newWidth=oldWidth-sliderAccessWidth,newMarginLeft=((oldMarginLeft*newWidth)/oldWidth)+'%';$g.css({width:newWidth,marginLeft:newMarginLeft})})}}},0)}}},_limitMinMaxDateTime:function(dp_inst,adjustSliders){var o=this._defaults,dp_date=new Date(dp_inst.selectedYear,dp_inst.selectedMonth,dp_inst.selectedDay);if(!this._defaults.showTimepicker)return;if($.datepicker._get(dp_inst,'minDateTime')!==null&&$.datepicker._get(dp_inst,'minDateTime')!==undefined&&dp_date){var minDateTime=$.datepicker._get(dp_inst,'minDateTime'),minDateTimeDate=new Date(minDateTime.getFullYear(),minDateTime.getMonth(),minDateTime.getDate(),0,0,0,0);if(this.hourMinOriginal===null||this.minuteMinOriginal===null||this.secondMinOriginal===null||this.millisecMinOriginal===null){this.hourMinOriginal=o.hourMin;this.minuteMinOriginal=o.minuteMin;this.secondMinOriginal=o.secondMin;this.millisecMinOriginal=o.millisecMin}if(dp_inst.settings.timeOnly||minDateTimeDate.getTime()==dp_date.getTime()){this._defaults.hourMin=minDateTime.getHours();if(this.hour<=this._defaults.hourMin){this.hour=this._defaults.hourMin;this._defaults.minuteMin=minDateTime.getMinutes();if(this.minute<=this._defaults.minuteMin){this.minute=this._defaults.minuteMin;this._defaults.secondMin=minDateTime.getSeconds()}else if(this.second<=this._defaults.secondMin){this.second=this._defaults.secondMin;this._defaults.millisecMin=minDateTime.getMilliseconds()}else{if(this.millisec<this._defaults.millisecMin)this.millisec=this._defaults.millisecMin;this._defaults.millisecMin=this.millisecMinOriginal}}else{this._defaults.minuteMin=this.minuteMinOriginal;this._defaults.secondMin=this.secondMinOriginal;this._defaults.millisecMin=this.millisecMinOriginal}}else{this._defaults.hourMin=this.hourMinOriginal;this._defaults.minuteMin=this.minuteMinOriginal;this._defaults.secondMin=this.secondMinOriginal;this._defaults.millisecMin=this.millisecMinOriginal}}if($.datepicker._get(dp_inst,'maxDateTime')!==null&&$.datepicker._get(dp_inst,'maxDateTime')!==undefined&&dp_date){var maxDateTime=$.datepicker._get(dp_inst,'maxDateTime'),maxDateTimeDate=new Date(maxDateTime.getFullYear(),maxDateTime.getMonth(),maxDateTime.getDate(),0,0,0,0);if(this.hourMaxOriginal===null||this.minuteMaxOriginal===null||this.secondMaxOriginal===null){this.hourMaxOriginal=o.hourMax;this.minuteMaxOriginal=o.minuteMax;this.secondMaxOriginal=o.secondMax;this.millisecMaxOriginal=o.millisecMax}if(dp_inst.settings.timeOnly||maxDateTimeDate.getTime()==dp_date.getTime()){this._defaults.hourMax=maxDateTime.getHours();if(this.hour>=this._defaults.hourMax){this.hour=this._defaults.hourMax;this._defaults.minuteMax=maxDateTime.getMinutes();if(this.minute>=this._defaults.minuteMax){this.minute=this._defaults.minuteMax;this._defaults.secondMax=maxDateTime.getSeconds()}else if(this.second>=this._defaults.secondMax){this.second=this._defaults.secondMax;this._defaults.millisecMax=maxDateTime.getMilliseconds()}else{if(this.millisec>this._defaults.millisecMax)this.millisec=this._defaults.millisecMax;this._defaults.millisecMax=this.millisecMaxOriginal}}else{this._defaults.minuteMax=this.minuteMaxOriginal;this._defaults.secondMax=this.secondMaxOriginal;this._defaults.millisecMax=this.millisecMaxOriginal}}else{this._defaults.hourMax=this.hourMaxOriginal;this._defaults.minuteMax=this.minuteMaxOriginal;this._defaults.secondMax=this.secondMaxOriginal;this._defaults.millisecMax=this.millisecMaxOriginal}}if(adjustSliders!==undefined&&adjustSliders===true){var hourMax=parseInt((this._defaults.hourMax-((this._defaults.hourMax-this._defaults.hourMin)%this._defaults.stepHour)),10),minMax=parseInt((this._defaults.minuteMax-((this._defaults.minuteMax-this._defaults.minuteMin)%this._defaults.stepMinute)),10),secMax=parseInt((this._defaults.secondMax-((this._defaults.secondMax-this._defaults.secondMin)%this._defaults.stepSecond)),10),millisecMax=parseInt((this._defaults.millisecMax-((this._defaults.millisecMax-this._defaults.millisecMin)%this._defaults.stepMillisec)),10);if(this.hour_slider)this.hour_slider.slider("option",{min:this._defaults.hourMin,max:hourMax}).slider('value',this.hour);if(this.minute_slider)this.minute_slider.slider("option",{min:this._defaults.minuteMin,max:minMax}).slider('value',this.minute);if(this.second_slider)this.second_slider.slider("option",{min:this._defaults.secondMin,max:secMax}).slider('value',this.second);if(this.millisec_slider)this.millisec_slider.slider("option",{min:this._defaults.millisecMin,max:millisecMax}).slider('value',this.millisec)}},_onTimeChange:function(){var hour=(this.hour_slider)?this.hour_slider.slider('value'):false,minute=(this.minute_slider)?this.minute_slider.slider('value'):false,second=(this.second_slider)?this.second_slider.slider('value'):false,millisec=(this.millisec_slider)?this.millisec_slider.slider('value'):false,timezone=(this.timezone_select)?this.timezone_select.val():false,o=this._defaults;if(typeof(hour)=='object')hour=false;if(typeof(minute)=='object')minute=false;if(typeof(second)=='object')second=false;if(typeof(millisec)=='object')millisec=false;if(typeof(timezone)=='object')timezone=false;if(hour!==false)hour=parseInt(hour,10);if(minute!==false)minute=parseInt(minute,10);if(second!==false)second=parseInt(second,10);if(millisec!==false)millisec=parseInt(millisec,10);var ampm=o[hour<12?'amNames':'pmNames'][0];var hasChanged=(hour!=this.hour||minute!=this.minute||second!=this.second||millisec!=this.millisec||(this.ampm.length>0&&(hour<12)!=($.inArray(this.ampm.toUpperCase(),this.amNames)!==-1))||timezone!=this.timezone);if(hasChanged){if(hour!==false)this.hour=hour;if(minute!==false)this.minute=minute;if(second!==false)this.second=second;if(millisec!==false)this.millisec=millisec;if(timezone!==false)this.timezone=timezone;if(!this.inst)this.inst=$.datepicker._getInst(this.$input[0]);this._limitMinMaxDateTime(this.inst,true)}if(o.ampm)this.ampm=ampm;this.formattedTime=$.datepicker.formatTime(this._defaults.timeFormat,this,this._defaults);if(this.$timeObj)this.$timeObj.text(this.formattedTime+o.timeSuffix);this.timeDefined=true;if(hasChanged)this._updateDateTime()},_onSelectHandler:function(){var onSelect=this._defaults.onSelect;var inputEl=this.$input?this.$input[0]:null;if(onSelect&&inputEl){onSelect.apply(inputEl,[this.formattedDateTime,this])}},_formatTime:function(time,format){time=time||{hour:this.hour,minute:this.minute,second:this.second,millisec:this.millisec,ampm:this.ampm,timezone:this.timezone};var tmptime=(format||this._defaults.timeFormat).toString();tmptime=$.datepicker.formatTime(tmptime,time,this._defaults);if(arguments.length)return tmptime;else this.formattedTime=tmptime},_updateDateTime:function(dp_inst){dp_inst=this.inst||dp_inst;var dt=$.datepicker._daylightSavingAdjust(new Date(dp_inst.selectedYear,dp_inst.selectedMonth,dp_inst.selectedDay)),dateFmt=$.datepicker._get(dp_inst,'dateFormat'),formatCfg=$.datepicker._getFormatConfig(dp_inst),timeAvailable=dt!==null&&this.timeDefined;this.formattedDate=$.datepicker.formatDate(dateFmt,(dt===null?new Date():dt),formatCfg);var formattedDateTime=this.formattedDate;if(dp_inst.lastVal!==undefined&&(dp_inst.lastVal.length>0&&this.$input.val().length===0))return;if(this._defaults.timeOnly===true){formattedDateTime=this.formattedTime}else if(this._defaults.timeOnly!==true&&(this._defaults.alwaysSetTime||timeAvailable)){formattedDateTime+=this._defaults.separator+this.formattedTime+this._defaults.timeSuffix}this.formattedDateTime=formattedDateTime;if(!this._defaults.showTimepicker){this.$input.val(this.formattedDate)}else if(this.$altInput&&this._defaults.altFieldTimeOnly===true){this.$altInput.val(this.formattedTime);this.$input.val(this.formattedDate)}else if(this.$altInput){this.$altInput.val(formattedDateTime);this.$input.val(formattedDateTime)}else{this.$input.val(formattedDateTime)}this.$input.trigger("change")}});$.fn.extend({timepicker:function(o){o=o||{};var tmp_args=arguments;if(typeof o=='object')tmp_args[0]=$.extend(o,{timeOnly:true});return $(this).each(function(){$.fn.datetimepicker.apply($(this),tmp_args)})},datetimepicker:function(o){o=o||{};tmp_args=arguments;if(typeof(o)=='string'){if(o=='getDate')return $.fn.datepicker.apply($(this[0]),tmp_args);else return this.each(function(){var $t=$(this);$t.datepicker.apply($t,tmp_args)})}else return this.each(function(){var $t=$(this);$t.datepicker($.timepicker._newInst($t,o)._defaults)})}});$.datepicker.formatTime=function(format,time,options){options=options||{};options=$.extend($.timepicker._defaults,options);time=$.extend({hour:0,minute:0,second:0,millisec:0,timezone:'+0000'},time);var tmptime=format;var ampmName=options['amNames'][0];var hour=parseInt(time.hour,10);if(options.ampm){if(hour>11){ampmName=options['pmNames'][0];if(hour>12)hour=hour%12}if(hour===0)hour=12}tmptime=tmptime.replace(/(?:hh?|mm?|ss?|[tT]{1,2}|[lz])/g,function(match){switch(match.toLowerCase()){case'hh':return('0'+hour).slice(-2);case'h':return hour;case'mm':return('0'+time.minute).slice(-2);case'm':return time.minute;case'ss':return('0'+time.second).slice(-2);case's':return time.second;case'l':return('00'+time.millisec).slice(-3);case'z':return time.timezone;case't':case'tt':if(options.ampm){if(match.length==1)ampmName=ampmName.charAt(0);return match.charAt(0)=='T'?ampmName.toUpperCase():ampmName.toLowerCase()}return''}});tmptime=$.trim(tmptime);return tmptime};$.datepicker._base_selectDate=$.datepicker._selectDate;$.datepicker._selectDate=function(id,dateStr){var inst=this._getInst($(id)[0]),tp_inst=this._get(inst,'timepicker');if(tp_inst){tp_inst._limitMinMaxDateTime(inst,true);inst.inline=inst.stay_open=true;this._base_selectDate(id,dateStr);inst.inline=inst.stay_open=false;this._notifyChange(inst);this._updateDatepicker(inst)}else this._base_selectDate(id,dateStr)};$.datepicker._base_updateDatepicker=$.datepicker._updateDatepicker;$.datepicker._updateDatepicker=function(inst){var input=inst.input[0];if($.datepicker._curInst&&$.datepicker._curInst!=inst&&$.datepicker._datepickerShowing&&$.datepicker._lastInput!=input){return}if(typeof(inst.stay_open)!=='boolean'||inst.stay_open===false){this._base_updateDatepicker(inst);var tp_inst=this._get(inst,'timepicker');if(tp_inst)tp_inst._addTimePicker(inst)}};$.datepicker._base_doKeyPress=$.datepicker._doKeyPress;$.datepicker._doKeyPress=function(event){var inst=$.datepicker._getInst(event.target),tp_inst=$.datepicker._get(inst,'timepicker');if(tp_inst){if($.datepicker._get(inst,'constrainInput')){var ampm=tp_inst._defaults.ampm,dateChars=$.datepicker._possibleChars($.datepicker._get(inst,'dateFormat')),datetimeChars=tp_inst._defaults.timeFormat.toString().replace(/[hms]/g,'').replace(/TT/g,ampm?'APM':'').replace(/Tt/g,ampm?'AaPpMm':'').replace(/tT/g,ampm?'AaPpMm':'').replace(/T/g,ampm?'AP':'').replace(/tt/g,ampm?'apm':'').replace(/t/g,ampm?'ap':'')+" "+tp_inst._defaults.separator+tp_inst._defaults.timeSuffix+(tp_inst._defaults.showTimezone?tp_inst._defaults.timezoneList.join(''):'')+(tp_inst._defaults.amNames.join(''))+(tp_inst._defaults.pmNames.join(''))+dateChars,chr=String.fromCharCode(event.charCode===undefined?event.keyCode:event.charCode);return event.ctrlKey||(chr<' '||!dateChars||datetimeChars.indexOf(chr)>-1)}}return $.datepicker._base_doKeyPress(event)};$.datepicker._base_doKeyUp=$.datepicker._doKeyUp;$.datepicker._doKeyUp=function(event){var inst=$.datepicker._getInst(event.target),tp_inst=$.datepicker._get(inst,'timepicker');if(tp_inst){if(tp_inst._defaults.timeOnly&&(inst.input.val()!=inst.lastVal)){try{$.datepicker._updateDatepicker(inst)}catch(err){$.datepicker.log(err)}}}return $.datepicker._base_doKeyUp(event)};$.datepicker._base_gotoToday=$.datepicker._gotoToday;$.datepicker._gotoToday=function(id){var inst=this._getInst($(id)[0]),$dp=inst.dpDiv;this._base_gotoToday(id);var now=new Date();var tp_inst=this._get(inst,'timepicker');if(tp_inst&&tp_inst._defaults.showTimezone&&tp_inst.timezone_select){var tzoffset=now.getTimezoneOffset();var tzsign=tzoffset>0?'-':'+';tzoffset=Math.abs(tzoffset);var tzmin=tzoffset%60;tzoffset=tzsign+('0'+(tzoffset-tzmin)/60).slice(-2)+('0'+tzmin).slice(-2);if(tp_inst._defaults.timezoneIso8609)tzoffset=tzoffset.substring(0,3)+':'+tzoffset.substring(3);tp_inst.timezone_select.val(tzoffset)}this._setTime(inst,now);$('.ui-datepicker-today',$dp).click()};$.datepicker._disableTimepickerDatepicker=function(target,date,withDate){var inst=this._getInst(target),tp_inst=this._get(inst,'timepicker');$(target).datepicker('getDate');if(tp_inst){tp_inst._defaults.showTimepicker=false;tp_inst._updateDateTime(inst)}};$.datepicker._enableTimepickerDatepicker=function(target,date,withDate){var inst=this._getInst(target),tp_inst=this._get(inst,'timepicker');$(target).datepicker('getDate');if(tp_inst){tp_inst._defaults.showTimepicker=true;tp_inst._addTimePicker(inst);tp_inst._updateDateTime(inst)}};$.datepicker._setTime=function(inst,date){var tp_inst=this._get(inst,'timepicker');if(tp_inst){var defaults=tp_inst._defaults,hour=date?date.getHours():defaults.hour,minute=date?date.getMinutes():defaults.minute,second=date?date.getSeconds():defaults.second,millisec=date?date.getMilliseconds():defaults.millisec;if((hour<defaults.hourMin||hour>defaults.hourMax)||(minute<defaults.minuteMin||minute>defaults.minuteMax)||(second<defaults.secondMin||second>defaults.secondMax)||(millisec<defaults.millisecMin||millisec>defaults.millisecMax)){hour=defaults.hourMin;minute=defaults.minuteMin;second=defaults.secondMin;millisec=defaults.millisecMin}tp_inst.hour=hour;tp_inst.minute=minute;tp_inst.second=second;tp_inst.millisec=millisec;if(tp_inst.hour_slider)tp_inst.hour_slider.slider('value',hour);if(tp_inst.minute_slider)tp_inst.minute_slider.slider('value',minute);if(tp_inst.second_slider)tp_inst.second_slider.slider('value',second);if(tp_inst.millisec_slider)tp_inst.millisec_slider.slider('value',millisec);tp_inst._onTimeChange();tp_inst._updateDateTime(inst)}};$.datepicker._setTimeDatepicker=function(target,date,withDate){var inst=this._getInst(target),tp_inst=this._get(inst,'timepicker');if(tp_inst){this._setDateFromField(inst);var tp_date;if(date){if(typeof date=="string"){tp_inst._parseTime(date,withDate);tp_date=new Date();tp_date.setHours(tp_inst.hour,tp_inst.minute,tp_inst.second,tp_inst.millisec)}else tp_date=new Date(date.getTime());if(tp_date.toString()=='Invalid Date')tp_date=undefined;this._setTime(inst,tp_date)}}};$.datepicker._base_setDateDatepicker=$.datepicker._setDateDatepicker;$.datepicker._setDateDatepicker=function(target,date){var inst=this._getInst(target),tp_date=(date instanceof Date)?new Date(date.getTime()):date;this._updateDatepicker(inst);this._base_setDateDatepicker.apply(this,arguments);this._setTimeDatepicker(target,tp_date,true)};$.datepicker._base_getDateDatepicker=$.datepicker._getDateDatepicker;$.datepicker._getDateDatepicker=function(target,noDefault){var inst=this._getInst(target),tp_inst=this._get(inst,'timepicker');if(tp_inst){this._setDateFromField(inst,noDefault);var date=this._getDate(inst);if(date&&tp_inst._parseTime($(target).val(),tp_inst.timeOnly))date.setHours(tp_inst.hour,tp_inst.minute,tp_inst.second,tp_inst.millisec);return date}return this._base_getDateDatepicker(target,noDefault)};$.datepicker._base_parseDate=$.datepicker.parseDate;$.datepicker.parseDate=function(format,value,settings){var date;try{date=this._base_parseDate(format,value,settings)}catch(err){if(err.indexOf(":")>=0){date=this._base_parseDate(format,value.substring(0,value.length-(err.length-err.indexOf(':')-2)),settings)}else{throw err}}return date};$.datepicker._base_formatDate=$.datepicker._formatDate;$.datepicker._formatDate=function(inst,day,month,year){var tp_inst=this._get(inst,'timepicker');if(tp_inst){tp_inst._updateDateTime(inst);return tp_inst.$input.val()}return this._base_formatDate(inst)};$.datepicker._base_optionDatepicker=$.datepicker._optionDatepicker;$.datepicker._optionDatepicker=function(target,name,value){var inst=this._getInst(target),tp_inst=this._get(inst,'timepicker');if(tp_inst){var min=null,max=null,onselect=null;if(typeof name=='string'){if(name==='minDate'||name==='minDateTime')min=value;else if(name==='maxDate'||name==='maxDateTime')max=value;else if(name==='onSelect')onselect=value}else if(typeof name=='object'){if(name.minDate)min=name.minDate;else if(name.minDateTime)min=name.minDateTime;else if(name.maxDate)max=name.maxDate;else if(name.maxDateTime)max=name.maxDateTime}if(min){if(min==0)min=new Date();else min=new Date(min);tp_inst._defaults.minDate=min;tp_inst._defaults.minDateTime=min}else if(max){if(max==0)max=new Date();else max=new Date(max);tp_inst._defaults.maxDate=max;tp_inst._defaults.maxDateTime=max}else if(onselect)tp_inst._defaults.onSelect=onselect}if(value===undefined)return this._base_optionDatepicker(target,name);return this._base_optionDatepicker(target,name,value)};function extendRemove(target,props){$.extend(target,props);for(var name in props)if(props[name]===null||props[name]===undefined)target[name]=props[name];return target};$.timepicker=new Timepicker();$.timepicker.version="1.0.0"})(jQuery);

/******************** touch support plugin  ***********/
if(Modernizr.touch){
	
/*
* jQuery UI Touch Punch 0.2.2
*
* Copyright 2011, Dave Furfero
* Dual licensed under the MIT or GPL Version 2 licenses.
*
* Depends:
* jquery.ui.widget.js
* jquery.ui.mouse.js
*/
(function(b){b.support.touch="ontouchend" in document;if(!b.support.touch){return;}var c=b.ui.mouse.prototype,e=c._mouseInit,a;function d(g,h){if(g.originalEvent.touches.length>1){return;}g.preventDefault();var i=g.originalEvent.changedTouches[0],f=document.createEvent("MouseEvents");f.initMouseEvent(h,true,true,window,1,i.screenX,i.screenY,i.clientX,i.clientY,false,false,false,false,0,null);g.target.dispatchEvent(f);}c._touchStart=function(g){var f=this;if(a||!f._mouseCapture(g.originalEvent.changedTouches[0])){return;}a=true;f._touchMoved=false;d(g,"mouseover");d(g,"mousemove");d(g,"mousedown");};c._touchMove=function(f){if(!a){return;}this._touchMoved=true;d(f,"mousemove");};c._touchEnd=function(f){if(!a){return;}d(f,"mouseup");d(f,"mouseout");if(!this._touchMoved){d(f,"click");}a=false;};c._mouseInit=function(){var f=this;f.element.bind("touchstart",b.proxy(f,"_touchStart")).bind("touchmove",b.proxy(f,"_touchMove")).bind("touchend",b.proxy(f,"_touchEnd"));e.call(f);};})(jQuery);

}

/*!
 * Treeview 1.5pre - jQuery plugin to hide and show branches of a tree
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-treeview/
 * http://docs.jquery.com/Plugins/Treeview
 *
 * Copyright (c) 2007 Jörn Zaefferer
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Revision: $Id: jquery.treeview.js 5759 2008-07-01 07:50:28Z joern.zaefferer $
 *
 */

(function($){$.extend($.fn,{swapClass:function(c1,c2){var c1Elements=this.filter('.'+c1);this.filter('.'+c2).removeClass(c2).addClass(c1);c1Elements.removeClass(c1).addClass(c2);return this},replaceClass:function(c1,c2){return this.filter('.'+c1).removeClass(c1).addClass(c2).end()},hoverClass:function(className){className=className||"hover";return this.hover(function(){$(this).addClass(className)},function(){$(this).removeClass(className)})},heightToggle:function(animated,callback){animated?this.animate({height:"toggle"},animated,callback):this.each(function(){jQuery(this)[jQuery(this).is(":hidden")?"show":"hide"]();if(callback)callback.apply(this,arguments)})},heightHide:function(animated,callback){if(animated){this.animate({height:"hide"},animated,callback)}else{this.hide();if(callback)this.each(callback)}},prepareBranches:function(settings){if(!settings.prerendered){this.filter(":last-child:not(ul)").addClass(CLASSES.last);this.filter((settings.collapsed?"":"."+CLASSES.closed)+":not(."+CLASSES.open+")").find(">ul").hide()}return this.filter(":has(>ul)")},applyClasses:function(settings,toggler){this.filter(":has(>ul):not(:has(>a))").find(">span").unbind("click.treeview").bind("click.treeview",function(event){if(this==event.target)toggler.apply($(this).next())}).add($("a",this)).hoverClass();if(!settings.prerendered){this.filter(":has(>ul:hidden)").addClass(CLASSES.expandable).replaceClass(CLASSES.last,CLASSES.lastExpandable);this.not(":has(>ul:hidden)").addClass(CLASSES.collapsable).replaceClass(CLASSES.last,CLASSES.lastCollapsable)}},treeview:function(settings){settings=$.extend({cookieId:"treeview"},settings);if(settings.toggle){var callback=settings.toggle;settings.toggle=function(){return callback.apply($(this).parent()[0],arguments)}}function treeController(tree,control){function handler(filter){return function(){toggler.apply($("div."+CLASSES.hitarea,tree).filter(function(){return filter?$(this).parent("."+filter).length:true}));return false}}$("a:eq(0)",control).click(handler(CLASSES.collapsable));$("a:eq(1)",control).click(handler(CLASSES.expandable));$("a:eq(2)",control).click(handler())}function toggler(){$(this).parent().find(">.hitarea").swapClass(CLASSES.collapsableHitarea,CLASSES.expandableHitarea).swapClass(CLASSES.lastCollapsableHitarea,CLASSES.lastExpandableHitarea).end().swapClass(CLASSES.collapsable,CLASSES.expandable).swapClass(CLASSES.lastCollapsable,CLASSES.lastExpandable).find(">ul").heightToggle(settings.animated,settings.toggle);if(settings.unique){$(this).parent().siblings().find(">.hitarea").replaceClass(CLASSES.collapsableHitarea,CLASSES.expandableHitarea).replaceClass(CLASSES.lastCollapsableHitarea,CLASSES.lastExpandableHitarea).end().replaceClass(CLASSES.collapsable,CLASSES.expandable).replaceClass(CLASSES.lastCollapsable,CLASSES.lastExpandable).find(">ul").heightHide(settings.animated,settings.toggle)}}this.data("toggler",toggler);function serialize(){function binary(arg){return arg?1:0}var data=[];branches.each(function(i,e){data[i]=$(e).is(":has(>ul:visible)")?1:0});$.cookie(settings.cookieId,data.join(""),settings.cookieOptions)}function deserialize(){var stored=$.cookie(settings.cookieId);if(stored){var data=stored.split("");branches.each(function(i,e){$(e).find(">ul")[parseInt(data[i])?"show":"hide"]()})}}this.addClass("treeview");var branches=this.find("li").prepareBranches(settings);switch(settings.persist){case"cookie":var toggleCallback=settings.toggle;settings.toggle=function(){serialize();if(toggleCallback){toggleCallback.apply(this,arguments)}};deserialize();break;case"location":var current=this.find("a").filter(function(){return this.href.toLowerCase()==location.href.toLowerCase()});if(current.length){var items=current.addClass("selected").parents("ul, li").add(current.next()).show();if(settings.prerendered){items.filter("li").swapClass(CLASSES.collapsable,CLASSES.expandable).swapClass(CLASSES.lastCollapsable,CLASSES.lastExpandable).find(">.hitarea").swapClass(CLASSES.collapsableHitarea,CLASSES.expandableHitarea).swapClass(CLASSES.lastCollapsableHitarea,CLASSES.lastExpandableHitarea)}}break}branches.applyClasses(settings,toggler);if(settings.control){treeController(this,settings.control);$(settings.control).show()}return this}});$.treeview={};var CLASSES=($.treeview.classes={open:"open",closed:"closed",expandable:"expandable",expandableHitarea:"expandable-hitarea",lastExpandableHitarea:"lastExpandable-hitarea",collapsable:"collapsable",collapsableHitarea:"collapsable-hitarea",lastCollapsableHitarea:"lastCollapsable-hitarea",lastCollapsable:"lastCollapsable",lastExpandable:"lastExpandable",last:"last",hitarea:"hitarea"})})(jQuery);

/******************* sticky header of grid layout function**************/
function sticky_relocate_top() {
  var window_top = $(window).scrollTop();
  var div_top = $('.start-stick_top').offset().top;
  if (window_top > div_top){
	$('.grid_stickyhead_top').addClass('stick');
	$('.grid_stickyhead_top').css({'width':$('.grid_stickyhead_top').next("table").width()});
	
  }
  else
	$('.grid_stickyhead_top').removeClass('stick');
  }
/********** sticky bottom table header *********/
/*function sticky_relocate_bot() {
  var window_bot = $(window).scrollTop() + $(window).height();
  var div_bot = $('.start-stick_bot').offset().top+10;
  if (window_bot < div_bot){
	$('.grid_stickyhead_bot').addClass('stick');
	$('.grid_stickyhead_bot').css({'width':$('.grid_stickyhead_bot').prev(".grid").width()});
  }
  else
	$('.grid_stickyhead_bot').removeClass('stick');
  }*/
/************** End of sticky head function ************/
			
/***************loading polyfill for form elements **************/
$.webshims.activeLang('en');
if(!Modernizr.touch){ // on load check and replace the UI for non-touch browser
	$.webshims.setOptions('forms-ext', {
		number: { calculateWidth: true },
		replaceUI:true,
        date:"jquery-ui",
		types: 'range date time number month color'
	});
	$.webshims.formcfg = {
    en: {
        dFormat: '-',
        dateSigns: '-',
        patterns: {
                 d:"dd-mm-yy"
             }
        }
  };
}

$.webshims.setOptions('forms', { // enable validation
			customMessages: true,
			replaceValidationUI: true,
			addValidators: true,
			placeholderType: 'over',
		});
		$.webshims.setOptions({
			extendNative: false,
			waitReady: false
		});
$.webshims.polyfill();// enable polyfill
		
		

/*****************Initialize Jsscroll pane loader ****************/
$(function()
  {
	  var win = $(window);
	  // Full body scroll
	  var isResizing = false;
	  win.bind(
		  'resize',
		  function()
		  {
			  if (!isResizing) {
				  isResizing = true;
				  var container = $('.body-scroll,.rht_menu');
				  container.css(
					  {
						  'width': 1,
						  'height': 1
					  }
				  );
				  // Now make it the size of the window...
				  container.css(
					  {
						  'width': win.width(),
						  'height': win.height()
					  }
				  );
				  isResizing = false;
				  container.jScrollPane();
				  $('.jspDrag').on("mouseenter",function(){
					$(this).stop(true,true).css({"opacity":"0.7"}).parents(".jspVerticalBar").animate({width:"10px"},"fast").css({"background":"rgba(0, 0, 0, 0.1)","box-shadow":"0 0 1px #999 inset"});	}).mouseleave(function(){
					$(this).stop(true,true).css({"opacity":"0.5"}).parents(".jspVerticalBar").animate({width:"7px"},"fast").stop(true,true).css({"background":"transparent","box-shadow":"none"})
						
					});
			  }
		  }
	  ).trigger('resize');
	  if ($('.body-scroll,.rht_menu').width() != win.width()) {
		  win.trigger('resize');
	  }
	  $(window).bind('load',function(){win.trigger('resize')});
	  reinitialiseScrollPane =function()	{
		  $('.body-scroll,.rht_menu').jScrollPane();
		  
		   $('.jspDrag').on("mouseenter",function(){
					$(this).stop(true,true).css({"opacity":"0.7"}).parents(".jspVerticalBar").animate({width:"10px"},"fast").stop(true,true).css({"background":"rgba(0, 0, 0, 0.1)","box-shadow":"0 0 1px #999 inset"});	}).mouseleave(function(){ 
					$(this).stop(true,true).css({"opacity":"0.5"}).parents(".jspVerticalBar").animate({width:"7px"},"fast").stop(true,true).css({"background":"transparent","box-shadow":"none"})
			});
		   $("#pdmsgcont,#cee_ajax,.body-scroll").on("scroll",function() {
	            $(".ui-autocomplete").hide();
	       });
	  }
	  $('.jspContainer').on("mouseenter",function(){
		  $(this).find('.jspTrack').stop(true,true).fadeIn("slow");
		  }).mouseleave(function(){
		  $(this).find('.jspTrack').stop(true,true).fadeOut("slow");	
		  })
	 /* $(".body-scroll,.hold,.rht_menu").scroll(function(){
		  $(this).find('.jspTrack').stop(true,true).fadeIn("slow");
		  $(this).find('.jspTrack').delay(1500).fadeOut("slow");
		  });*/
		  $("#pdmsgcont,#cee_ajax,.body-scroll").on("scroll",function() {
	            $(".ui-autocomplete").hide();
	      });
  });

  //form elements mandatory feilds global styling 
  var mandifunc=function(){
	  $("input[required], select[required], textarea[required]").each(function(){
		  if($(this).parents("p").find("span").hasClass("mandi")){
			  return true			
		  }
		  else{$(this).wrap('<span class="mandi-wrap"></span>');
		  $(this).closest(".mandi-wrap").prepend("<span class='mandi' title='Mandatory Field'>*</span>");
		  }
		  
	  });
	  
  }
/*********************** show drop down selected index below the component ************************/
var selectshow=function(){
	$("select").each(function(index, element){
			var des=$(element).parents('p').find( ".selected_des" ).html();
			var sor="";
			$(element).change(function(){
				$(element).find("option:selected").each(function () {
					if($(this).data('msg')){
						sor=$(this).data('msg');
					}else{sor=""}
				});
				$(element).parents('p').find( ".selected_des" ).html(des+sor);
			});	
	});
}//end of selectshow
/************************ Popup selected details of account *****************************************/
var selectedDetail=function(){
	$("select").each(function(index, element){
			var btn=$(element).parents('p').find( ".selectedDetail" );
			$(btn).click(function( event ) {event.preventDefault();});
			var detail
			$(element).change(function(){
				$(element).find("option:selected").each(function () {
					if($(this).data('msg')){
						detail= "<p><span class='lbl'>Nick Name :</span>"+$(this).data('msg')+"</p><p><span class='lbl'>Bank Code :</span>"+$(this).data('code')+"</p><p><span class='lbl'>Bank Name :</span>"+$(this).data('bank')+"</p><p><span class='lbl'>City :</span>"+$(this).data('city')+"</p><p><span class='lbl'>Country :</span>"+$(this).data('country')+"</p>";
					}else{detail=""}
					
				});
				$( document ).tooltip({
					items:btn,
					content: function() {return detail;},
					 position: {
							my: "left+32 center",
							at: "center left",
							using: function( position, feedback ) {
								$(this).css( position );
								$("<div>")
								.addClass("arrow")
								.addClass(feedback.vertical)
								.addClass(feedback.horizontal)
								.appendTo(this);
								}
							}	
				 });
			});	
	});
}  //end of selectedDetail
/******************************** Extending chosen plugin functionaity ***************************/						
$.fn.chosenExtended=function(){
	$(this).chosen();
	$(this).each(function(){
	var $multi= $(this);
	if($multi.is("[required]")){
		var ID = $multi.attr("id");
		$multi.addClass("modichosen")
		$multi.next("#" + ID + "_chzn").focusout(function(){
			if($multi.val()<1){
				$("#" + ID + "_chzn .chzn-choices").addClass("chosen-error");
				}
			else{
				$("#" + ID + "_chzn .chzn-choices").removeClass("chosen-error");
				}
			}).prev($multi).change(function(){
				if($multi.val()<1){
				$("#" + ID + "_chzn .chzn-choices").addClass("chosen-error");
				}
			else{
				$("#" + ID + "_chzn .chzn-choices").removeClass("chosen-error");
				}
				
				});
		}
	$(this).trigger("liszt:updated");
	});	
	
}
/**************************** Extending combobox funtionality ************************/
$.fn.comboExtend=function(){
	$("select").not("[multiple]").each(function(){
		var that=$(this);
		if(that.find("option").size() > 1){
				if(that.find("option[selected]").size()>0){
					that.combobox({msg:true})
				}else
				{
					that.prepend("<option value=''>Select</option>");
					setTimeout(function(){
					that.find("option[value='']").attr("selected","selected");
					that.combobox({msg:true});
					},10);//hack for IE
				}
		}
		else if (that.find("option").size() == 0){
			that.prepend("<option value='' selected='selected'>Select</option> ").combobox({msg:true});
		}
		else{that.combobox({msg:true})}

	});
	$("select[multiple]").change(function(){ reinitialiseScrollPane();});
}


/*******************on load check and replace custom UI element from actual elements  **********/
$(document).ready(function () {
	if(!Modernizr.touch){
		$("select").not("[multiple]").comboExtend();/*apply costum combobox to select element*/
	}
	mandifunc();/*enable manditory feilds*/
	$("select[multiple]").chosenExtended();
	selectshow();
	selectedDetail();
});
		
/**************** reconstructing custom elements on dynamic page update **************/
$.fn.dynamicfieldupdate=function(){
	  if(!Modernizr.touch){
		  $("select").not("[multiple]").comboExtend();
	  }
	  $("select[multiple]").chosenExtended();
	  $(this).updatePolyfill();
	  mandifunc();/*enable manditory feilds*/
	//  selectshow();
	selectedDetail();
	 reinitialiseScrollPane();
	 
}