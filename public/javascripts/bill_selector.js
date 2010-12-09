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
			sum_goods_fee: "#sum_goods_fee",
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
				$.bill_selector.sum_info.sum_goods_fee = 0;
				$.bill_selector.sum_info.sum_insured_fee = 0;
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
				$.bill_selector.sum_info.sum_goods_fee = parseFloat($.bill_selector.sum_info.sum_goods_fee) + parseFloat(the_bill.goods_fee);
				$.bill_selector.sum_info.sum_insured_fee = parseFloat($.bill_selector.sum_info.sum_insured_fee) + parseFloat(the_bill.insured_fee);

			}
			else {
				var index = $.inArray(the_bill.id, $.bill_selector.selected_ids)
				if (index > - 1) $.bill_selector.selected_ids.splice(index, 1);

				$.bill_selector.sum_info.count -= 1;
				$.bill_selector.sum_info.sum_carrying_fee = parseFloat($.bill_selector.sum_info.sum_carrying_fee) - parseFloat(the_bill.carrying_fee);
				$.bill_selector.sum_info.sum_goods_fee = parseFloat($.bill_selector.sum_info.sum_goods_fee) - parseFloat(the_bill.goods_fee);
				$.bill_selector.sum_info.sum_insured_fee = parseFloat($.bill_selector.sum_info.sum_insured_fee) - parseFloat(the_bill.insured_fee);

			}
			$.bill_selector.update_html();
		},
		//更新界面显示
		update_html: function() {
			$($.bill_selector.options.count).html($.bill_selector.sum_info.count + "票");
			$($.bill_selector.options.sum_carrying_fee).html($.bill_selector.sum_info.sum_carrying_fee);
			$($.bill_selector.options.sum_goods_fee).html($.bill_selector.sum_info.sum_carrying_fee);
			$($.bill_selector.options.sum_insured_fee).html($.bill_selector.sum_info.sum_insured_fee);
			$($.bill_selector.options.sum_from_short_carrying_fee).html($.bill_selector.sum_info.sum_from_short_carrying_fee);
			$($.bill_selector.options.sum_to_short_carrying_fee).html($.bill_selector.sum_info.sum_to_short_carrying_fee);

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
				$.prompt('当前未添加任何运单,请添加运单后再保存!', {
					show: 'slideDown'
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
		var form_change = function(evt) {
			if (jQuery.inArray(evt.target.id, options["listen_change_els"]) > - 1) search_bills();
		};

		//绑定数据变化时触发查询事件
		return $(this).change(form_change);
		//首先初始化一下
		search_bills();
	};
	//默认设置
	$.fn.form_with_select_bills.defaults = {
		//运单列表table
		bills_table: '#bills_table',
		//form提交时附加到form上的已选择的运单数组 
		search_bill_params: function() {
			return {
				"search[from_org_id_eq]": ($('#from_org_id').length == 0) ? "": $('#from_org_id').val(),
				"search[to_org_id_eq]": ($('#to_org_id').length == 0) ? "": $('#to_org_id').val(),
				"search[transit_org_id_eq]": ($('#transit_org_id').length == 0) ? "": $('#transit_org_id').val(),
				"search[bill_date_eq]": ($('#bill_date_eq').length == 0) ? "": $('#bill_date_eq').val(),
				"search[state_eq]": ($('#state_eq').length == 0) ? "": $('#state_eq').val(),
				"search[type_in][]": ($('#type_in').length == 0) ? ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill'] : $('#type_in').data('type') //要查询的运单类型
			}
		},
		//查询运单参数
		listen_change_els: ["from_org_id", "to_org_id", "org_id", "bill_date_eq"] //值发生变化时触发运单查询的元素
	}
})(jQuery);

