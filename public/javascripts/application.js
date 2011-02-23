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

	//双击某条记录打开详细信息
	$('tr[data-dblclick]').livequery('dblclick', function() {
		var el_anchor = $(this).find('.show_link');
		if ($(el_anchor).hasClass('fancybox')) $(el_anchor).click();
		else {
			window.location = $(el_anchor).attr('href');
			$.fancybox.showActivity();

		}

	});

	//form 自动获取焦点
	$('form').livequery(function() {
		$(this).focus();
	});

	//角色功能列表
	$('#role_orgs_list').treeList();
	//组织机构列表
	$('#orgs_list').treeList();
	$('#role_orgs_list').treeList();
	$('#role_system_functions_list').accordion();
	$('#role_tab a').click(function() {
		var active_el = $($(this).attr('href'));
		$('#role_org_tab').hide();
		$('#role_system_functions_list').hide();
		$(active_el).show();

	});
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
	$('form.carrying_bill').livequery(calculate_carrying_bill);

	//根据不同的运单录入界面,隐藏部分字段
	$('form.computer_bill').livequery(function() {
		$('#computer_bill_bill_no').attr('readonly', true);
		$('#computer_bill_goods_no').attr('readonly', true);
	});
	$('form.hand_bill').livequery(function() {
		$('#hand_bill_bill_no').attr('readonly', false);
		$('#hand_bill_goods_no').attr('readonly', false);

	});
	$('form.transit_bill').livequery(function() {
		$('#transit_bill_bill_no').attr('readonly', true);
		$('#transit_bill_goods_no').attr('readonly', true);

	});
	$('form.hand_transit_bill').livequery(function() {
		$('#hand_transit_bill_bill_no').attr('readonly', false);
		$('#hand_transit_bill_goods_no').attr('readonly', false);
	});
	$('form.return_bill').livequery(function() {
		$(this).find('input').attr('readonly', true);
		$('#return_bill_note').attr('readonly', false);

	});

	//绑定所有日期选择框
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd'
	});
	$.datepicker.setDefaults($.datepicker.regional['zh_CN']);
	$('.datepicker').livequery(function() {
		$(this).datepicker();
	});

	//初始化左侧菜单树
	var cookieName = 'il_menubar';
	var get_current_menu = function() {
		var cookie_menu = $.cookies.get(cookieName);
		var cur_menu = 0;
		if (cookie_menu) cur_menu = parseInt(cookie_menu.substr(12));
		return cur_menu;
	};

	$('#menu_bar').accordion({
		active: get_current_menu.apply(),
		change: function(e, ui) {
			$.cookies.set(cookieName, "cur_il_menu_" + $(this).find('h3').index(ui.newHeader[0]));
		}
	});

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
	//提高select_org list-wrapper的z-index
	$('.list-wrapper').livequery(function() {
		$(this).css('z-index', 9001);
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
	//运单列表表头点击事件
	$('#table_wrap th a[href!="#"],#table_wrap .pagination a[href!="#"]').live('click', function() {
		$.getScript(this.href);
		return false;
	});
	$('form.bill_selector').livequery(function() {
		$(this).form_with_select_bills();
	});
	$('#container').ajaxStart(function() {
		$.fancybox.showActivity();
	}).ajaxStop(function() {
		$.fancybox.hideActivity();
	});
	//首页运单查询
	$('#home-search-box').watermark('录入运单号/货号查询').keyup(function(e) {
		if (e.keyCode == 13) {
			$.fancybox.showActivity();
			$('#home-search-form').trigger('submit');
		}
	});
	$('#btn_home_search').click(function() {
		$('#home-search-form').trigger('submit');
		return false;
	});
	//search box
	$('.search_box').livequery(function() {
		$(this).watermark('录入运单编号查询', {
			userNative: false
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
			if ($('#transit_org_id').length > 0) $.extend(params, {
				"search[transit_org_id_eq]": $('#transit_org_id').val()
			});
			$.get('/carrying_bills', params, null, 'script');
		}).focus(function() {
			$(this).select();
		})
	});
	//绑定提货/提款/中转/中转提货处理的ajax:before
	$('#deliver_info_form,#cash_pay_info_form,#transfer_pay_info_form,#transit_info_form,#transit_deliver_form,#short_fee_info_form,#goods_exception_form,#send_list_form,#send_list_post_form').livequery(function() {
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
		var sum_carrying_fee_th = 0;
		var sum_k_carrying_fee = 0;
		var sum_k_hand_fee = 0;
		var sum_act_pay_fee = 0;
		var sum_from_short_carrying_fee = 0;
		var sum_to_short_carrying_fee = 0;
		var sum_insured_fee = 0;
		var sum_th_amount = 0;

		$('[data-bill]').each(function() {
			var the_bill = $(this).data('bill');
			sum_carrying_fee += parseFloat(the_bill.carrying_fee);
			sum_carrying_fee_th += parseFloat(the_bill.carrying_fee_th);
			sum_k_carrying_fee += parseFloat(the_bill.k_carrying_fee);
			sum_th_amount += parseFloat(the_bill.th_amount);
			sum_k_hand_fee += parseFloat(the_bill.k_hand_fee);
			sum_act_pay_fee += parseFloat(the_bill.act_pay_fee);
			sum_goods_fee += parseFloat(the_bill.goods_fee);
			sum_from_short_carrying_fee += parseFloat(the_bill.from_short_carrying_fee);
			sum_to_short_carrying_fee += parseFloat(the_bill.to_short_carrying_fee);
			sum_insured_fee += parseFloat(the_bill.insured_fee);

		});

		$('#count').html($('[data-bill]').length + '票');
		$('#sum_carrying_fee').html(sum_carrying_fee);
		$('#sum_from_short_carrying_fee').html(sum_from_short_carrying_fee);
		$('#sum_to_short_carrying_fee').html(sum_to_short_carrying_fee);
		$('#sum_k_carrying_fee').html(sum_k_carrying_fee);
		$('#sum_carrying_fee_th').html(sum_carrying_fee_th);
		$('#sum_hand_fee').html(sum_k_hand_fee);
		$('#sum_act_pay_fee').html(sum_act_pay_fee);
		$('#sum_goods_fee').html(sum_goods_fee);
		$('#sum_th_amount').html(sum_th_amount);
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
			"search[completed_eq]": 0,
			"search[type_in][]": ['ComputerBill', 'HandBill', 'ReturnBill', 'TransitBill', 'HandTransitBill'],
			//以下设定运单列表中的显示及隐藏字段,设定为css选择符
			"hide_fields": ".carrying_fee,.insured_fee",
			"show_fields": ".carrying_fee_th,.th_amount"
		};
		$(this).data('params', params);
	}).bind('ajax:complete', function() {
		if ($('#bills_table').length == 0) return;
		var sum_info = $('#bills_table').data('sum');
		var ids = $('#bills_table').data('ids');
		$('#settlement_sum_carrying_fee').val(sum_info.sum_carrying_fee_th);
		$('#settlement_sum_goods_fee').val(sum_info.sum_goods_fee);
		$('#settlement_sum_fee').html(parseFloat(sum_info.sum_goods_fee) + parseFloat(sum_info.sum_carrying_fee_th));
		$('#settlement_form').data('params', {
			'bill_ids[]': ids
		});
	});

	//生成返款清单时,收款单位变化时,列出结算清单
	$('[name="refound[to_org_id]"],[name="refound[from_org_id]"]').live('change', function() {
		if ($(this).val() == "") return;
		$.get('/settlements', {
			"search[carrying_bills_from_org_id_eq]": $('[name="refound[to_org_id]"]').val(),
			"search[carrying_bills_to_org_id_eq]": $('[name="refound[from_org_id]"]').val(),
			"search[carrying_bills_type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[carrying_bills_state_eq]": "settlemented",
			"search[carrying_bills_completed_eq]": 0,
			"search[carrying_bills_goods_fee_or_carrying_bills_carrying_fee_gt]": 0
		},
		null, 'script')
	});
	//全选结算清单
	$('#check_all').live('click', function() {
		$('input[name^="selector"]').each(function() {
			$(this).attr('checked', $('#check_all').attr('checked'));
		});

	});
	//绑定生成支付清单按钮
	$('#btn_generate_refound').bind('ajax:before', function() {
		var selected_bill_ids = [];
		$('input[name^="selector"]').each(function() {
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
			"search[to_org_id_eq]": $('[name="refound[from_org_id]"]').val(),
			"search[type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[state_eq]": "settlemented",
			"search[completed_eq]": 0,
			"search[goods_fee_or_carrying_fee_gt]": 0,
			"search[settlement_id_in][]": selected_bill_ids,
			"hide_fields": ".carrying_fee,.insured_fee",
			'show_fields': ".carrying_fee_th,.th_amount"
		};
		$(this).data('params', params);
		//选定单据改变时,修改对应返款清单相关金额字段
		$($.bill_selector).bind('select:change', function() {
			$('#refound_sum_goods_fee').val($.bill_selector.sum_info.sum_goods_fee);
			$('#refound_sum_carrying_fee').val($.bill_selector.sum_info.sum_carrying_fee_th);
			$('#refound_sum_fee').html(parseFloat($.bill_selector.sum_info.sum_carrying_fee) + parseFloat($.bill_selector.sum_info.sum_goods_fee));
		});

	});
	//生成代收货款支付清单
	var gen_payment_list = function(evt) {
		var params = {
			"search[state_eq]": "refunded_confirmed",
			"search[type_in][]": ["ComputerBill", "HandBill", "TransitBill", "HandTransitBill"],
			"search[goods_fee_gt]": 0,
			"search[completed_eq]": 0,
			//运单列表显示的字段
			"hide_fields": ".carrying_fee,.insured_fee",
			"show_fields": ".k_carrying_fee,.k_hand_fee,.act_pay_fee"
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
		$('input[name^="selector"]').each(function() {
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
			"search[payment_list_id_in][]": selected_bill_ids,
			"hide_fields": ".carrying_fee,.insured_fee",
			"show_fields": ".k_carrying_fee,.k_hand_fee,.act_pay_fee"
		};
		$(this).data('params', params);
	});

	//客户提款结算清单
	//实领金额变化时,更新余额
	var cal_rest_fee = function() {
		var amount_fee = parseFloat($('#post_info_amount_fee').val());
		var sum_pay_fee = parseFloat($('#sum_pay_fee').val());
		var rest_fee = amount_fee - sum_pay_fee;
		$('#sum_rest_fee').val(rest_fee);

	};

	$('#btn_generate_post_info').bind('ajax:before', function() {
		var params = {
			"search[from_org_id_eq]": $('#from_org_id').val(),
			"search[state_eq]": 'paid',
			"search[completed_eq]": 0,
			"search[from_customer_id_is_null]": 1,
			"search[type_in][]": ['ComputerBill', 'HandBill', 'TransitBill', 'HandTransitBill'],
			"hide_fields": ".carrying_fee,.insured_fee",
			"show_fields": ".k_carrying_fee,.k_hand_fee,.act_pay_fee"

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
		$('#sum_pay_fee').val(sum_info.sum_act_pay_fee);
		$('#pay_info_form').data('params', {
			'bill_ids[]': ids
		});
		cal_rest_fee();
	});
	//绑定实领金额变化事件
	$('#post_info_amount_fee').change(cal_rest_fee);

	//中转运单中转操作,处理中转公司下拉列表变化事件
	$('#select_transit_company').change(function() {
		if ($(this).val() == "") {
			$('#new_transit_company').show();
			$('[name*="transit_company_attributes"]').attr('disabled', false);
		}
		else {
			$('#new_transit_company').hide();
			$('[name*="transit_company_attributes"]').attr('disabled', true);
		}
	});
	//用户新建及修改界面,处理删除角色
	$('input[name*="is_select"][type="checkbox"]').livequery('click', function() {
		$(this).next().val(!$(this).attr('checked'));

	});

	//送货清单,查询运单后,自动清除已核销或正在送货中的运单记录
	$('#send_list_form_after_wrap tr[data-bill]').livequery(function() {
		var bill = $(this).data('bill');
		//移除已送货或正在送货中的运单
		if (bill.send_state == 'posted' || bill.send_state == 'sended') {
			$.notifyBar({
				html: "该运单已送货或正在送货中!",
				delay: 3000,
				animationSpeed: "normal",
				cls: 'error'
			});
			$(this).remove();

		}

	});

	//送货员未交票统计
	$('#btn_send_list_line_query').bind('ajax:before', function() {
		var params = {
			"search[send_list_line_send_list_sender_id_eq]": $('#sender_id').val(),
			"search[send_list_line_state_eq]": "sended",
			"search[to_org_id_eq]": $('#to_org_id').val(),
			"hide_fields": ".carrying_fee,.insured_fee",
			"show_fields": ".carrying_fee_th,.to_short_carrying_fee"
		};
		$(this).data('params', params);

	});
	//帐目盘点登记表,自动计算合计功能
	$('#journal_form').change(function() {
		var settled_no_rebate_fee = parseFloat($('#journal_settled_no_rebate_fee').val());
		var deliveried_no_settled_fee = parseFloat($('#journal_deliveried_no_settled_fee').val());
		var input_fee_1 = parseFloat($('#journal_input_fee_1').val());
		var input_fee_2 = parseFloat($('#journal_input_fee_2').val());
		var input_fee_3 = parseFloat($('#journal_input_fee_3').val());
		var journal_sum_1 = settled_no_rebate_fee + deliveried_no_settled_fee + input_fee_1 + input_fee_2 + input_fee_3;
		$('#journal_sum_1').html(journal_sum_1);
		var cash = parseFloat($('#journal_cash').val());
		var deposits = parseFloat($('#journal_deposits').val());
		var goods_fee = parseFloat($('#journal_goods_fee').val());
		var short_fee = parseFloat($('#journal_short_fee').val());
		var other_fee = parseFloat($('#journal_other_fee').val());
		var journal_sum_2 = cash + deposits + goods_fee + short_fee + other_fee;
		$('#journal_sum_2').html(journal_sum_2);
		//客户欠款
		var current_debt = parseFloat($('#journal_current_debt').val());
		var current_debt_2_3 = parseFloat($('#journal_current_debt_2_3').val());
		var current_debt_4_5 = parseFloat($('#journal_current_debt_4_5').val());
		var current_debt_ge_6 = parseFloat($('#journal_current_debt_ge_6').val());
		var journal_sum_4 = current_debt + current_debt_2_3 + current_debt_4_5 + current_debt_ge_6;
		$('#journal_sum_4').html(journal_sum_4);

	});

	//vip统计列表
	$('#imported_customer_org_id').change(function() {
		$.get('/imported_customers', {
			"search[org_id_eq]": $(this).val()
		},
		function() {
			$('.tabs a').removeClass('here');
			$('.tabs a').first().addClass('here');
		},
		'script');
	});
	$('#imported_customers_tab a').bind('ajax:before', function() {
		$(this).data('params', {
			"search[org_id_eq]": $('#imported_customer_org_id').val()
		});

	});
	$('.tabs a').click(function() {
		$('.tabs a').removeClass('here');
		$(this).addClass('here');

	});

	//未提货报表,处理各种票据列表底色
	$('.rpt_no_delivery tr.white-bill').css('background', 'white');
	$('.rpt_no_delivery tr.blue-bill').css('background', 'blue');
	$('.rpt_no_delivery tr.green-bill').css('background', 'green');
	$('.rpt_no_delivery tr.yellow-bill').css('background', 'yellow');
	$('.rpt_no_delivery tr.red-bill').css('background', 'red');
	$('.rpt_no_delivery tr.black-bill').css('background', 'black');
	$('.turnover_chart').visualize({
		width: '850px'
	});

	//提货时,仅仅打印运单
	$('.btn_deliver_only_print').click(function() {
		if ($('.carrying_bill_show').length == 0) $.notifyBar({
			html: "请先查询要提货的运单,然后再进行打印操作.",
			delay: 3000,
			animationSpeed: "normal",
			cls: 'error'
		});
		else

		$('.carrying_bill_show').printElement({
			overrideElementCSS: ['/stylesheets/bill_print.css']
		});

	});

});

