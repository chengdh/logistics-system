// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//自动加载validation及facebox类库
jQuery(function($) {
	//初始化formtastic_validation
	var init_formtastic_validation = function() {
		var formtasticValidation = new FormtasticValidation;
		formtasticValidation.initialize();

	};
	init_formtastic_validation.apply();
	var calculate_carrying_bill = function() {
		//计算保价费合计
		var insured_amount = parseFloat($('#insured_amount').val());
		var insured_rate = parseFloat($('#insured_rate').val());
		var insured_fee = insured_amount * insured_rate / 1000;
		$('#insured_fee').val(insured_fee);
		//计算运费合计
		var carrying_fee = parseFloat($('#carrying_fee').val());
		var from_short_carrying_fee = parseFloat($('#from_short_carrying_fee').val());
		var to_short_carrying_fee = parseFloat($('#to_short_carrying_fee').val());
		var sum_carrying_fee = carrying_fee + from_short_carrying_fee + to_short_carrying_fee;
		$('#sum_carrying_fee').text(sum_carrying_fee);
		//计算总金额合计
		var goods_fee = parseFloat($('#goods_fee').val());
		var sum_fee = sum_carrying_fee + goods_fee;

		$('#sum_fee').text(sum_fee);

	};

	$('form.carrying_bill').live("change", calculate_carrying_bill);
	//绑定所有日期选择框
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd'
	});
	$.datepicker.setDefaults($.datepicker.regional['zh_CN']);
	$('.datepicker').livequery(function() {
		$(this).datepicker();
	});

	//初始化左侧菜单树,icon显示有问题
	$('#menu_bar').accordion({
		event: 'mouseover'
	});
	$('#menu_bar .ui-icon').attr('style', "display : none;");

	$('.fancybox').livequery(function() {
		$(this).fancybox({
			scrolling: 'no',
			padding: 20
		});
	});
	//初始化区域选择
	$('.select_org').livequery(function() {
		$(this).ufd();
	});
	//初始化tip
	$('.tipsy').livequery(function() {
		$('.tipsy').tipsy({
			gravity: 's',
		});

	});
	//将回车转换为tab
	//运单列表表头点击事件
	$('#table_wrap th a,#table_wrap .pagination a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
});
//bill_selector
var util = {};
util.BillSelector = function(el, options) {
	$(el).livequery(jQuery.proxy(function() {
		this.initialize(el, options);
	},
	this)

	);
};
util.BillSelector.prototype = {
	//初始化函数
	//el 初始化的table_el
	//option 初始化的一些选项 
	initialize: function(el, options) {
		this.el = $(el);
		this.ids = $(el).data('ids');

		if (typeof(this.initialized) == 'undefined' || ! this.initialized) {

			this.sum_info = $(el).data('sum');

			this.options = $.extend({},
			this.default_options, options);
			this.selected_ids = $(el).data('ids');
			$('[data-bill]').livequery('click', jQuery.proxy(this.bill_click, this));
			$(this).bind('set_all', this.set_all);
			//绑定全选和不选按钮
			$(this.options.btn_select_all).livequery('click', jQuery.proxy(function() {
				$(this).triggerHandler('set_all', [true]);
			},
			this));
			$(this.options.btn_unselect_all).livequery('click', jQuery.proxy(function() {
				$(this).triggerHandler('set_all', [false]);
			},
			this));

			this.initialized = true;
		}
		this.set_checkbox();
		this.update_html();

	},
	//重置对象,重新初始化
	reset: function() {
		this.initialized = false;
		$('[data-bill]').expire('click');
		$(this).unbind('set_all');
		//绑定全选和不选按钮
		if (typeof(this.options) != 'undefined') {
			$(this.options.btn_select_all).expire('click');
			$(this.options.btn_unselect_all).expire('click');
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
		this.selected_ids = is_select ? $(this.el).data('ids') : [];
		if (is_select) this.sum_info = $(this.el).data('sum');
		else {
			this.sum_info.count = 0;
			this.sum_info.sum_carrying_fee = 0;
			this.sum_info.sum_goods_fee = 0;
			this.sum_info.sum_insured_fee = 0;
			this.sum_info.sum_from_short_carrying_fee = 0;
			this.sum_info.sum_to_short_carrying_fee = 0;
		}
		this.set_checkbox();
		this.update_html();

	},
	//根据选择情况,设置checkbox的选中情况         
	set_checkbox: function() {
		$('input[type|="checkbox"][data-bill]').attr('checked', false);
		jQuery.each(this.selected_ids, function(index, value) {
			$('input[type|="checkbox"][value|="' + value + '"]').attr('checked', true);
		});

	},

	//选中或不选中某张票据
	bill_click: function(event) {
		var cur_el = $(event.target);
		var the_bill = cur_el.data('bill');
		if (cur_el.attr('checked')) {
			//向selected_ids中添加选中票据的id
			if ($.inArray(the_bill.id, this.selected_ids) == - 1) this.selected_ids.push(the_bill.id);
			this.sum_info.count += 1;
			this.sum_info.sum_carrying_fee = parseFloat(this.sum_info.sum_carrying_fee) + parseFloat(the_bill.carrying_fee);
			this.sum_info.sum_goods_fee = parseFloat(this.sum_info.sum_goods_fee) + parseFloat(the_bill.goods_fee);
			this.sum_info.sum_insured_fee = parseFloat(this.sum_info.sum_insured_fee) + parseFloat(the_bill.insured_fee);

		}
		else {
			var index = $.inArray(the_bill.id, this.selected_ids)
			if (index > - 1) this.selected_ids.splice(index, 1);

			this.sum_info.count -= 1;
			this.sum_info.sum_carrying_fee = parseFloat(this.sum_info.sum_carrying_fee) - parseFloat(the_bill.carrying_fee);
			this.sum_info.sum_goods_fee = parseFloat(this.sum_info.sum_goods_fee) - parseFloat(the_bill.goods_fee);
			this.sum_info.sum_insured_fee = parseFloat(this.sum_info.sum_insured_fee) - parseFloat(the_bill.insured_fee);

		}
		this.update_html();
	},
	//更新界面显示
	update_html: function() {
		$(this.options.count).html(this.sum_info.count + "票");
		$(this.options.sum_carrying_fee).html(this.sum_info.sum_carrying_fee);
		$(this.options.sum_goods_fee).html(this.sum_info.sum_carrying_fee);
		$(this.options.sum_insured_fee).html(this.sum_info.sum_insured_fee);
		$(this.options.sum_from_short_carrying_fee).html(this.sum_info.sum_from_short_carrying_fee);
		$(this.options.sum_to_short_carrying_fee).html(this.sum_info.sum_to_short_carrying_fee);

	}

};

