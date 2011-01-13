// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//bill_selector
(function($) {
	$.bill_selector = function() {};
	$.extend($.bill_selector, {
		//初始化函数
		//el 初始化的table_el
		//option 初始化的一些选项 
		initialize: function(el, options) {

			if ($.bill_selector.initialized);
			else {
				$.bill_selector.reset();
				$.bill_selector.el = el;
				$.bill_selector.ids = $.bill_selector.el.data('ids');

				$.bill_selector.sum_info = $.bill_selector.el.data('sum');

				$.bill_selector.options = $.extend({},
				$.bill_selector.default_options, options);
				$.bill_selector.selected_ids = $.bill_selector.el.data('ids');
				$('[data-bill]').live('click', $.bill_selector.bill_click);
				$($.bill_selector).bind('set_all', $.bill_selector.set_all);
				//绑定全选和不选按钮
				$($.bill_selector.options.btn_select_all).live("click", function() {
					$($.bill_selector).trigger('set_all', [true]);
				});
				$($.bill_selector.options.btn_unselect_all).live("click", function() {
					$($.bill_selector).trigger('set_all', [false]);
				});

				$.bill_selector.initialized = true;
			}
			$.bill_selector.set_checkbox();
			$.bill_selector.update_html();
			//显示票据选择控件
			$('.select_bill_bar,.cbx_select_bill').show();
			//给显示票据详细信息的链接添加fancybox属性
			$('.show_link').addClass('fancybox');
			$('.show_link').each(function() {
				var href = $(this).attr('href');
				$(this).attr('href', href + '.js');
			});

		},
		//重置对象,重新初始化
		reset: function() {
			$.bill_selector.initialized = false;
			$('[data-bill]').die('click');
			$($.bill_selector).unbind('set_all');
			//绑定全选和不选按钮
			if (typeof($.bill_selector.options) != 'undefined') {
				$($.bill_selector.options.btn_select_all).die('click');
				$($.bill_selector.options.btn_unselect_all).die('click');
			}

		},
		//默认设置
		default_options: {
			count: "#bill_count",
			sum_carrying_fee: "#sum_carrying_fee",
			sum_carrying_fee_th: "#sum_carrying_fee_th",
			sum_k_carrying_fee: "#sum_k_carrying_fee",
			sum_k_hand_fee: "#sum_k_hand_fee",
			sum_act_pay_fee: "#sum_act_pay_fee",
			sum_goods_fee: "#sum_goods_fee",
			sum_transit_carrying_fee: "#sum_transit_carrying_fee",
			sum_transit_hand_fee: "#sum_transit_hand_fee",
			sum_agent_carrying_fee: "#sum_agent_carrying_fee",
			sum_th_amount: "#sum_th_amount",
			sum_insured_fee: "#sum_insured_fee",
			sum_from_short_carrying_fee: "#sum_from_short_carrying_fee",
			sum_to_short_carrying_fee: "#sum_to_short_carrying_fee",
			btn_select_all: "#btn_select_all",
			btn_unselect_all: "#btn_unselect_all"

		},
		//选中或不选中全部
		set_all: function(event, is_select) {
			$.bill_selector.selected_ids = is_select ? $.bill_selector.el.data('ids') : [];
			if (is_select) $.bill_selector.sum_info = $.bill_selector.el.data('sum');
			else {
				$.bill_selector.sum_info.count = 0;
				$.bill_selector.sum_info.sum_carrying_fee = 0;
				$.bill_selector.sum_info.sum_carrying_fee_th = 0;
				$.bill_selector.sum_info.sum_k_carrying_fee = 0;
				$.bill_selector.sum_info.sum_k_hand_fee = 0;
				$.bill_selector.sum_info.sum_act_pay_fee = 0;
				$.bill_selector.sum_info.sum_goods_fee = 0;
				$.bill_selector.sum_info.sum_insured_fee = 0;
				$.bill_selector.sum_info.sum_transit_carrying_fee = 0;
				$.bill_selector.sum_info.sum_transit_hand_fee = 0;
				$.bill_selector.sum_info.sum_agent_carrying_fee = 0;
				$.bill_selector.sum_info.sum_th_amount = 0;
				$.bill_selector.sum_info.sum_from_short_carrying_fee = 0;
				$.bill_selector.sum_info.sum_to_short_carrying_fee = 0;
			}
			$.bill_selector.set_checkbox();
			$.bill_selector.update_html();

		},
		//根据选择情况,设置checkbox的选中情况         
		set_checkbox: function() {
			$('input[type|="checkbox"][data-bill]').attr('checked', false);
			jQuery.each($.bill_selector.selected_ids, function(index, value) {
				$('input[type|="checkbox"][value|="' + value + '"]').attr('checked', true);
			});

		},

		//选中或不选中某张票据
		bill_click: function(event) {
			var cur_el = $(event.target);
			var the_bill = cur_el.data('bill');
			if (cur_el.attr('checked')) {
				//向selected_ids中添加选中票据的id
				if ($.inArray(the_bill.id, $.bill_selector.selected_ids) == - 1) $.bill_selector.selected_ids.push(the_bill.id);
				$.bill_selector.sum_info.count += 1;
				$.bill_selector.sum_info.sum_carrying_fee = parseFloat($.bill_selector.sum_info.sum_carrying_fee) + parseFloat(the_bill.carrying_fee);
				$.bill_selector.sum_info.sum_carrying_fee_th = parseFloat($.bill_selector.sum_info.sum_carrying_fee_th) + parseFloat(the_bill.carrying_fee_th);
				$.bill_selector.sum_info.sum_goods_fee = parseFloat($.bill_selector.sum_info.sum_goods_fee) + parseFloat(the_bill.goods_fee);
				$.bill_selector.sum_info.sum_insured_fee = parseFloat($.bill_selector.sum_info.sum_insured_fee) + parseFloat(the_bill.insured_fee);
				$.bill_selector.sum_info.sum_k_hand_fee = parseFloat($.bill_selector.sum_info.sum_k_hand_fee) + parseFloat(the_bill.k_hand_fee);
				$.bill_selector.sum_info.sum_k_carrying_fee = parseFloat($.bill_selector.sum_info.sum_k_carrying_fee) + parseFloat(the_bill.k_carrying_fee);
				$.bill_selector.sum_info.sum_act_pay_fee = parseFloat($.bill_selector.sum_info.sum_act_pay_fee) + parseFloat(the_bill.act_pay_fee);
				$.bill_selector.sum_info.sum_from_short_carrying_fee = parseFloat($.bill_selector.sum_info.sum_from_short_carrying_fee) + parseFloat(the_bill.from_short_carrying_fee);
				$.bill_selector.sum_info.sum_to_short_carrying_fee = parseFloat($.bill_selector.sum_info.sum_to_short_carrying_fee) + parseFloat(the_bill.to_short_carrying_fee);

				$.bill_selector.sum_info.sum_transit_carrying_fee = parseFloat($.bill_selector.sum_info.sum_transit_carrying_fee) + parseFloat(the_bill.transit_carrying_fee);
				$.bill_selector.sum_info.sum_transit_hand_fee = parseFloat($.bill_selector.sum_info.sum_transit_hand_fee) + parseFloat(the_bill.transit_hand_fee);
				$.bill_selector.sum_info.sum_agent_carrying_fee = parseFloat($.bill_selector.sum_info.sum_agent_carrying_fee) + parseFloat(the_bill.agent_carrying_fee);
				$.bill_selector.sum_info.sum_th_amount = parseFloat($.bill_selector.sum_info.th_amount) + parseFloat(the_bill.th_amount);

			}
			else {
				var index = $.inArray(the_bill.id, $.bill_selector.selected_ids)
				if (index > - 1) $.bill_selector.selected_ids.splice(index, 1);

				$.bill_selector.sum_info.count -= 1;
				$.bill_selector.sum_info.sum_carrying_fee = parseFloat($.bill_selector.sum_info.sum_carrying_fee) - parseFloat(the_bill.carrying_fee);
				$.bill_selector.sum_info.sum_carrying_fee_th = parseFloat($.bill_selector.sum_info.sum_carrying_fee_th) - parseFloat(the_bill.carrying_fee_th);
				$.bill_selector.sum_info.sum_goods_fee = parseFloat($.bill_selector.sum_info.sum_goods_fee) - parseFloat(the_bill.goods_fee);
				$.bill_selector.sum_info.sum_insured_fee = parseFloat($.bill_selector.sum_info.sum_insured_fee) - parseFloat(the_bill.insured_fee);
				$.bill_selector.sum_info.sum_k_hand_fee = parseFloat($.bill_selector.sum_info.sum_k_hand_fee) - parseFloat(the_bill.k_hand_fee);
				$.bill_selector.sum_info.sum_k_carrying_fee = parseFloat($.bill_selector.sum_info.sum_k_carrying_fee) - parseFloat(the_bill.k_carrying_fee);
				$.bill_selector.sum_info.sum_act_pay_fee = parseFloat($.bill_selector.sum_info.sum_act_pay_fee) - parseFloat(the_bill.act_pay_fee);
				$.bill_selector.sum_info.sum_from_short_carrying_fee = parseFloat($.bill_selector.sum_info.sum_from_short_carrying_fee) - parseFloat(the_bill.from_short_carrying_fee);
				$.bill_selector.sum_info.sum_to_short_carrying_fee = parseFloat($.bill_selector.sum_info.sum_to_short_carrying_fee) - parseFloat(the_bill.to_short_carrying_fee);

				$.bill_selector.sum_info.sum_transit_carrying_fee = parseFloat($.bill_selector.sum_info.sum_transit_carrying_fee) - parseFloat(the_bill.transit_carrying_fee);
				$.bill_selector.sum_info.sum_transit_hand_fee = parseFloat($.bill_selector.sum_info.sum_transit_hand_fee) - parseFloat(the_bill.transit_hand_fee);
				$.bill_selector.sum_info.sum_agent_carrying_fee = parseFloat($.bill_selector.sum_info.sum_agent_carrying_fee) - parseFloat(the_bill.agent_carrying_fee);
				$.bill_selector.sum_info.sum_th_amount = parseFloat($.bill_selector.sum_info.th_amount) - parseFloat(the_bill.th_amount);

			}
			$.bill_selector.update_html();
		},
		//更新界面显示
		update_html: function() {
			$($.bill_selector.options.count).html($.bill_selector.sum_info.count + "票");
			$($.bill_selector.options.sum_carrying_fee).html($.bill_selector.sum_info.sum_carrying_fee);
			$($.bill_selector.options.sum_carrying_fee_th).html($.bill_selector.sum_info.sum_carrying_fee_th);
			$($.bill_selector.options.sum_k_carrying_fee).html($.bill_selector.sum_info.sum_k_carrying_fee);
			$($.bill_selector.options.sum_k_hand_fee).html($.bill_selector.sum_info.sum_k_hand_fee);
			$($.bill_selector.options.sum_act_pay_fee).html($.bill_selector.sum_info.sum_act_pay_fee);
			$($.bill_selector.options.sum_goods_fee).html($.bill_selector.sum_info.sum_goods_fee);
			$($.bill_selector.options.sum_insured_fee).html($.bill_selector.sum_info.sum_insured_fee);
			$($.bill_selector.options.sum_from_short_carrying_fee).html($.bill_selector.sum_info.sum_from_short_carrying_fee);

			$($.bill_selector.options.sum_to_short_carrying_fee).html($.bill_selector.sum_info.sum_to_short_carrying_fee);

			$($.bill_selector.options.sum_transit_carrying_fee).html($.bill_selector.sum_info.sum_transit_carrying_fee);
			$($.bill_selector.options.sum_transit_hand_fee).html($.bill_selector.sum_info.sum_transit_hand_fee);
			$($.bill_selector.options.sum_agent_carrying_fee).html($.bill_selector.sum_info.sum_agent_carrying_fee);
			$($.bill_selector.options.sum_th_amount).html($.bill_selector.sum_info.sum_th_amount);
			//触发选择改变事件
			$($.bill_selector).trigger('select:change');

		}

	});
	$.fn.bill_selector = function(options) {
		$.bill_selector.initialize(this, options);
	};

	//扩展form,使其可以选择运单,大车装车单,分货单,提货单,返款清单都属于此类
	$.fn.form_with_select_bills = function(setting) {
		var options = $.extend({},
		$.fn.form_with_select_bills.defaults, setting);
		$(options.bills_table).livequery(function() {
			$(this).bill_selector();
		});

		//绑定ajax:before事件
		var ajax_before = function() {
			if (typeof($.bill_selector.selected_ids) == 'undefined' || $.bill_selector.selected_ids.length == 0) {
				$.notifyBar({
					html: "当前未选择任何要处理的运单,请先选择要处理的运单",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});

				return false;
			}
			else {
				//将选择的运单ids附加到form上
				var attach_params = {
					"bill_ids[]": $.bill_selector.selected_ids
				};
				$(this).data('params', attach_params);
			}
			return true;

		};
		$(this).bind("ajax:before", ajax_before);
		//查询运单函数
		var search_bills = function() {
			$.get('/carrying_bills', options["search_bill_params"](), function() {
				$.bill_selector.reset();
			},
			'script');
		};
		//自动将默认参数传递给search_form
		var set_search_form = function() {
			var default_values = options["search_bill_params"]();
			//判断是否传递了发货地与到货地
			if (default_values["from_org_id_eq"] != "") {
				$('#search_from_org_id_eq').val(default_values["from_org_id_eq"]).trigger('change');
				$('#search_from_org_id_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[from_org_id_eq]": default_values["from_org_id_eq"]
				});
			}
			if (default_values["search[to_org_id_eq]"] != "") {
				$('#search_to_org_id_eq').val(default_values["to_org_id_eq"]).trigger('change');
				$('#search_to_org_id_eq').attr('disabled', true);
				jQuery.extend(default_values, {
					"search[to_org_id_or_transit_org_id_eq]": default_values["to_org_id_eq"]
				});
			}
			$('#search_bill_form').data('params', default_values)
		};
		$('#search_bill_form').livequery(function() {
			set_search_form();
		});
		return this;
	};
	//默认设置
	$.fn.form_with_select_bills.defaults = {
		//运单列表table
		bills_table: '#bills_table',
		//是否与search_bill_form关联
		with_search_bill_form: true,
		//form提交时附加到form上的已选择的运单数组 
		search_bill_params: function() {
			return {
				"from_org_id_eq": ($('#from_org_id').length == 0) ? "": $('#from_org_id').val(),
				"to_org_id_eq": ($('#to_org_id').length == 0) ? "": $('#to_org_id').val(),
				"transit_org_id_eq": ($('#transit_org_id').length == 0) ? "": $('#transit_org_id').val(),
				"search[bill_date_eq]": ($('#bill_date_eq').length == 0) ? "": $('#bill_date_eq').val(),
				"search[state_eq]": ($('#state_eq').length == 0) ? "": $('#state_eq').val(),
				"search[type_in][]": ($('#type_in').length == 0) ? ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill'] : $('#type_in').data('type') //要查询的运单类型
			}
		},
		//查询运单参数
		listen_change_els: ["from_org_id", "to_org_id", "org_id", "bill_date_eq"] //值发生变化时触发运单查询的元素
	}
})(jQuery);

