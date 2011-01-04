#coding: utf-8
#定义一个根机构
Factory.define :department do |dep|
  dep.name 'department'
  dep.simp_name 'o'
  dep.phone  '0371-67519902'
  dep.manager  'org'
  dep.location  'location'
  dep.code  "code"
  dep.lock_input_time  "23:59"
end
Factory.define :branch do |branch|
  branch.name 'branch'
  branch.simp_name 'o'
  branch.phone  '0371-67519902'
  branch.manager  'org'
  branch.location  'location'
  branch.code  "code"
  branch.lock_input_time  "23:59"
end


Factory.define :zz,:parent => :branch do |org|
  org.name 'A'
  org.simp_name 'A'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '南三环燕赵物流园'
  org.code  "A"
  org.lock_input_time  "23:59"
end
Factory.define :ay,:parent => :branch do |org|
  org.name '安阳'
  org.simp_name 'AY'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "AY"
  org.lock_input_time  "23:59"
end

Factory.define :sjz,:parent => :branch do |org|
  org.name '石家庄'
  org.simp_name '石'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "石"
  org.lock_input_time  "23:59"
end
Factory.define :kf,:parent => :branch do |org|
  org.name '开封'
  org.simp_name '开'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '开封'
  org.code  "开"
  org.lock_input_time  "23:59"
end

#机打票
Factory.define :computer_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.association :from_org,:factory => :zz
  bill.association :to_org,:factory => :sjz
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.goods_info "机打运单"
end
#带有VIP客户信息的票据
Factory.define :computer_bill_with_vip ,:parent => :computer_bill do |bill|
  bill.association :from_customer,:factory => :vip
end
#已装车机打票
Factory.define :computer_bill_loaded,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create {|bill| bill.standard_process }  #装车操作
end
#已发货机打票
Factory.define :computer_bill_shipped,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
  end
end
#已到货机打票
Factory.define :computer_bill_reached,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
  end
end
#已分货机打票
Factory.define :computer_bill_distributed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
  end
end
#已提货运单
Factory.define :computer_bill_deliveried,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
  end
end
#已结算运单
Factory.define :computer_bill_settlemented,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
  end
end
#已返款确认运单
Factory.define :computer_bill_refounded_confirmed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
  end
end
#已做付款清单运单
Factory.define :computer_bill_payment_listed,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.payment_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
    bill.standard_process   #结算清单
  end
end
#已支付货款运单
Factory.define :computer_bill_paid,:parent => :computer_bill do |bill|
  bill.load_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.distribution_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的装车单id
  bill.deliver_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.settlement_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.refound_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.payment_list_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.pay_info_id 1  #FIXME 为避免state_machine错误此处设置其对应的提货单id
  bill.after_create do |bill| 
    bill.standard_process   #装车操作
    bill.standard_process   #发货操作
    bill.standard_process   #到货操作
    bill.standard_process   #分货操作
    bill.standard_process   #提货操作
    bill.standard_process   #结算操作
    bill.standard_process   #返款操作
    bill.standard_process   #返款确认
    bill.standard_process   #代收货款支付清单
    bill.standard_process   #代收货款提款
  end
end

#手工票
Factory.define :hand_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.association :from_org,:factory => :zz
  bill.association :to_org,:factory => :sjz
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20
  bill.bill_no "hand_bill_bill_no"
  bill.goods_no "hand_bill_goods_no"
  bill.goods_info "手工运单"
end
#中转票
Factory.define :transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH
  bill.goods_num 20

  bill.goods_info "中转运单"
  bill.association :from_org,:factory => :ay
  bill.association :transit_org,:factory => :zz
  bill.association :to_org,:factory => :kf
end
#手工中转票
Factory.define :hand_transit_bill do |bill|
  bill.bill_date Date.today
  bill.from_customer_name "发货人"
  bill.from_customer_phone "13676997527"
  bill.to_customer_name "收货人"
  bill.to_customer_phone "15138665197"
  bill.insured_amount 1000
  bill.insured_rate 0.001
  bill.carrying_fee 200
  bill.goods_fee 5000
  bill.from_short_carrying_fee 20
  bill.to_short_carrying_fee 20
  bill.pay_type CarryingBill::PAY_TYPE_CASH

  bill.bill_no "hand_transit_bill_bill_no"
  bill.goods_no "hand_transit_bill_goods_no"
  bill.goods_info "手工中转运单"
  bill.association :from_org,:factory => :ay
  bill.association :transit_org,:factory => :zz
  bill.association :to_org,:factory => :kf
end
#大车装车单,还未装车
Factory.define :load_list do |load_list|
  load_list.bill_no "load_list_bill_no_001"
  load_list.association :from_org,:factory => :zz
  load_list.association :to_org,:factory => :ay
end
Factory.define :load_list_with_bills,:parent => :load_list do |load_list|
  load_list.after_create do |load|
    load.carrying_bills << Factory(:computer_bill)
  end
end
#大车装车单,已装车
Factory.define :load_list_loaded,:parent => :load_list_with_bills do |load_list|
  load_list.after_create do |load|
    load.process
  end
end
#大车装车单,已发货
Factory.define :load_list_shipped,:parent => :load_list_with_bills do |load_list|
  load_list.after_create do |load|
    load.process
    load.process
  end
end
#分货单
Factory.define :distribution_list do |dl|
  dl.association :org,:factory => :ay
end
#提货单据
Factory.define :deliver_info do |deliver|
  deliver.customer_name "提货人"
end
Factory.define :deliver_info_with_bills,:parent => :deliver_info do |deliver|
  deliver.after_create do |dl|
    dl.carrying_bills << Factory(:computer_bill_distributed)
  end
end

#返程运单结算
Factory.define :settlement do |s|
  s.association :org,:factory => :zz
end
Factory.define :settlement_with_bills,:parent => :settlement do |s|
  s.after_create do |st|
    st.carrying_bills << Factory(:computer_bill_deliveried)
  end
end
#返款清单
Factory.define :refound do |r|
  r.association :from_org,:factory => :zz
  r.association :to_org,:factory => :ay
end
Factory.define :refound_with_bills,:parent => :refound do |r|
  r.after_create do |rf|
    rf.carrying_bills << Factory(:computer_bill_settlemented)
  end
end
#客户信息
Factory.define :customer do |c|
  c.name "0000001"
  c.code "0000001"
  c.phone "0000001"
end
#银行信息
Factory.define :bank do |b|
  b.name "银行"
  b.code '0'
end
Factory.define :icbc,:parent => :bank do |b|
  b.name "中国工商银行"
  b.code '1'
end
#VIP客户信息
Factory.define :vip do |vip|
  vip.name "张三"
  vip.phone "1763636634343"
  vip.association :org,:factory => :zz
  vip.association :bank,:factory => :icbc
  vip.bank_card "6222032031714562349"
  vip.id_number "410221197510020418"
end
#现金代收货款支付清单
Factory.define :cash_payment_list do |p_list|
  p_list.association :org,:factory => :zz
end
Factory.define :cash_payment_list_with_bills,:parent => :cash_payment_list do |p_list|
  p_list.after_create do |pl|
    pl.carrying_bills << Factory(:computer_bill_refounded_confirmed)
  end
end
#银行代收货款转账清单
Factory.define :transfer_payment_list do |p_list|
  p_list.association :org,:factory => :zz
  p_list.association :bank,:factory => :icbc 
end
Factory.define :transfer_payment_list_with_bills,:parent => :transfer_payment_list do |p_list|
  p_list.after_create do |pl|
    pl.carrying_bills << Factory(:computer_bill_refounded_confirmed)
  end
end
#客户提款-现金
Factory.define :cash_pay_info do |p|
  p.association :org,:factory => :zz
  p.customer_name "张三"
end
Factory.define :cash_pay_info_with_bills,:parent => :cash_pay_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_payment_listed)
  end
end
#客户提款-转账
Factory.define :transfer_pay_info do |p|
  p.association :org,:factory => :zz
  p.customer_name "张三"
end
Factory.define :transfer_pay_info_with_bills,:parent => :transfer_pay_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_payment_listed)
  end
end
#每日过帐信息汇总
Factory.define :post_info do |p|
  p.association :org,:factory => :zz
end
Factory.define :post_info_with_bills,:parent => :post_info do |p|
  p.after_create do |pi|
    pi.carrying_bills << Factory(:computer_bill_paid)
  end
end
