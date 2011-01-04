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
	//根据客户编号查询查询客户信息
	var search_customer_by_code = function() {
		var code = $(this).val();
		if (code == "") return;
		$.get('/customers', {
			"search[code_eq]": code
		},
		null, 'script');

	};
	$('#customer_code').live('change', search_customer_by_code);
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
		$('.tipsy').tipSwift({
			gravity: $.tipSwift.gravity.autoWE,
			plugins: [
			$.tipSwift.plugins.tip({
				offset: 5,
				gravity: 's',
				opacity: 0.6,
				showEffect: $.tipSwift.effects.fadeIn,
				hideEffect: $.tipSwift.effects.fadeOut
			})]
		});

	});
	//将回车转换为tab
	$('form input').livequery(function() {
		$(this).tabEnter();
	});
	//运单列表表头点击事件
	$('#table_wrap th a,#table_wrap .pagination a').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$('form.bill_selector').livequery(function() {
		$(this).form_with_select_bills();
	});
	$('#container').ajaxStart(function() {
		$(this).activity({
			segments: 12,
			width: 3,
			space: 2,
			length: 2,
			color: '#030303',
			speed: 1.5
		});
	}).ajaxStop(function() {
		$(this).activity(false);
	});
	//search box
	$('.search_box').livequery(function() {
		$(this).watermark('录入运单编号查询', {
			userNative: false
		}).tipSwift({
			gravity: $.tipSwift.gravity.autoWE,
			live: true,
			plugins: [
			$.tipSwift.plugins.tip({
				offset: 5,
				gravity: 'e',
				title: function() {
					return "回车查询要处理的运单"
				},
				opacity: 0.6,
				showEffect: $.tipSwift.effects.fadeIn,
				hideEffect: $.tipSwift.effects.fadeOut
			})]
		}).change(function() {
			if ($(this).val() == "") return;
			var params = $(this).data('params');
			$.extend(params, {
				"search[bill_no_eq]": $(this).val()
			});
			//添加发货站或到货站id
			if ($('#from_org_id').length > 0) $.extend(params, {
				"search[from_org_id_eq]": $('#from_org_id').val()
			});
			if ($('#to_org_id').length > 0) $.extend(params, {
				"search[to_org_id_eq]": $('#to_org_id').val()
			});
			$.get('/carrying_bills', params, null, 'script');
		})
	});
	//绑定提货处理的ajax:before
	$('#deliver_info_form,#cash_pay_info_form,#transfer_pay_info').livequery(function() {
		$(this).bind('ajax:before', function() {
			var bill_els = $('[data-bill]');
			var bill_ids = [];
			if (bill_els.length == 0) {
				$.notifyBar({
					html: "未查找到任何运单,请先查询要处理的运单",
					delay: 3000,
					animationSpeed: "normal",
					cls: 'error'
				});
				return false;
			}
			else {
				bill_els.each(function() {
					var bill_id = $(this).data('bill').id;
					bill_ids.push(bill_id);
				});
				$(this).data('params', {
					"bill_ids[]": bill_ids
				});
			}
			return true;
		})
	});
	//对票据进行操作时,计算合计值
	var cal_sum = function() {
		var sum_carrying_fee = 0;
		var sum_goods_fee = 0;
		var sum_from_short_carrying_fee = 0;
		var sum_to_short_carrying_fee = 0;
		var sum_insured_fee = 0;

		$('[data-bill]').each(function() {
			var the_bill = $(this).data('bill');
			sum_carrying_fee += parseFloat(the_bill.carrying_fee);
			sum_goods_fee += parseFloat(the_bill.goods_fee);
			sum_from_short_carrying_fee += parseFloat(the_bill.from_short_carrying_fee);
			sum_to_short_carrying_fee += parseFloat(the_bill.to_short_carrying_fee);
			sum_insured_fee += parseFloat(the_bill.insured_fee);

		});

		$('#count').html($('[data-bill]').length + '票');
		$('#sum_carrying_fee').html(sum_carrying_fee);
		$('#sum_goods_fee').html(sum_goods_fee);
		$('#sum_insured_fee').html(sum_insured_fee);

	};

	$('.bill_cal_sum').livequery(function() {
		cal_sum();
	},
	function() {
		cal_sum();
	});
	//生成结算清单时,绑定查询条件
	$('#btn_generate_settlement').bind('ajax:before', function() {
		var params = {
			"search[to_org_id_or_transit_org_id_eq]": $('#to_org_id').val(),
			"search[state_eq]": 'deliveried',
			"search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill']
		};
		$(this).data('params', params);
	}).bind('ajax:complete', function() {
		if ($('#bills_table').length == 0) return;
		var sum_info = $('#bills_table').data('sum');
		var ids = $('#bills_table').data('ids');
		$('#settlement_sum_carrying_fee').val(sum_info.sum_carrying_fee);
		$('#settlement_sum_goods_fee').val(sum_info.sum_goods_fee);
		$('#settlement_form').data('params', {
			'bill_ids[]': ids
		});

	});

	//生成返款清单时,收款单位变化时,列出结算清单
	$('[name="refound[to_org_id]"],[name="refound[from_org_id]"]').live('change', function() {
		if ($(this).val() == "") return;
		$.get('/settlements', {
			"search[carrying_bills_from_org_id_eq]": $('[name="refound[to_org_id]"]').val(),
			"search[carrying_bills_to_org_id_eq]": $('[name="refound[to_org_id]"]').val(),
			"search[carrying_bills_type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[carrying_bills_state_eq]": "settlemented",
			"search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
		},
		null, 'script')
	});
	//全选结算清单
	$('#check_all').live('click', function() {
		$('input[name^="bill_selector"]').each(function() {
			$(this).attr('checked', $('#check_all').attr('checked'));
		});

	});
	//绑定生成支付清单按钮
	$('#btn_generate_refound').bind('ajax:before', function() {
		var selected_bill_ids = [];
		$('input[name^="bill_selector"]').each(function() {
			if ($(this).attr('checked')) selected_bill_ids.push($(this).val());
		});
		if (selected_bill_ids.length == 0) {
			$.notifyBar({
				html: "请选择要生成支付清单的结算清单!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;

		}

		var params = {
			"search[from_org_id_eq]": $('[name="refound[to_org_id]"]').val(),
			"search[type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[state_eq]": "settlemented",
			"search[goods_fee_or_carrying_fee_gt]": 0,
			"search[settlement_id_in][]": selected_bill_ids
		};
		$(this).data('params', params);
		//选定单据改变时,修改对应返款清单相关金额字段
		$($.bill_selector).bind('select:change', function() {
			$('#refound_sum_goods_fee').val($.bill_selector.sum_info.sum_goods_fee);
			$('#refound_sum_carrying_fee').val($.bill_selector.sum_info.sum_carrying_fee);
			$('#refound_sum_fee').html(parseFloat($.bill_selector.sum_info.sum_carrying_fee) + parseFloat($.bill_selector.sum_info.sum_goods_fee));
		});

	});
	//生成代收货款支付清单
	var gen_payment_list = function(evt) {
		var params = {
			"search[state_eq]": "refunded_confirmed",
			"search[type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[goods_fee_gt]": 0
		};
		if (evt.data.is_cash) {
			params["search[from_customer_id_is_null"] = "1";
			params["search[from_org_id_eq]"] = $('#from_org_id').val();
		}
		else {
			params["search[from_customer_id_is_not_null"] = "1";
			params["search[from_customer_bank_id_eq]"] = $('#bank_id').val();
		}

		$.get('/carrying_bills', params, null, 'script');

	};
	$('#btn_generate_cash_payment_list').click({
		is_cash: true
	},
	gen_payment_list);
	$('#btn_generate_transfer_payment_list').click({
		is_cash: false
	},
	gen_payment_list);

	//批量提款,银行转账界面,绑定生成批量提款清单按钮功能
	$('#btn_generate_transfer_pay_info').bind('ajax:before', function() {
		var selected_bill_ids = [];
		$('input[name^="bill_selector"]').each(function() {
			if ($(this).attr('checked')) selected_bill_ids.push($(this).val());
		});
		if (selected_bill_ids.length == 0) {
			$.notifyBar({
				html: "请选择要批量提款的代收货款支付清单!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			return false;

		}
		var params = {
			"search[type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[state_eq]": "payment_listed",
			"search[payment_list_id_in][]": selected_bill_ids
		};
		$(this).data('params', params);
	});

	//客户提款结算清单
        //实领金额变化时,更新余额
        var cal_rest_fee = function(){
          var amount_fee = parseFloat($('#post_info_amount_fee').val());
          var sum_pay_fee = parseFloat($('#sum_pay_fee').val());
          var rest_fee = amount_fee - sum_pay_fee;
          $('#sum_rest_fee').val(rest_fee);

        };

	$('#btn_generate_post_info').bind('ajax:before', function() {
		var params = {
			"search[from_org_id_eq]": $('#from_org_id').val(),
			"search[state_eq]": 'paid',
			"search[from_customer_id_is_null]" :  1,
			"search[type_in][]": ['ComputerBill', 'HandBill', 'TransitBill', 'HandTransitBill']
		};
		$(this).data('params', params);
	}).bind('ajax:complete', function() {
		if ($('#bills_table').length == 0) return;
		var sum_info = $('#bills_table').data('sum');
		var ids = $('#bills_table').data('ids');
		$('#sum_goods_fee').val(sum_info.sum_goods_fee);
		$('#sum_k_carrying_fee').val(sum_info.sum_k_carrying_fee);
		$('#sum_k_hand_fee').val(sum_info.sum_k_hand_fee);
                //计算实际提款及余额
		$('#sum_pay_fee').val(sum_info.sum_pay_fee);
		$('#pay_info_form').data('params', {
			'bill_ids[]': ids
		});
                cal_rest_fee();
	});
        //绑定实领金额变化事件
        $('#post_info_amount_fee').change(cal_rest_fee);
});

