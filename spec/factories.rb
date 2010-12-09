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
Factory.define :distribution_list do |dl|
  dl.association :org,:factory => :ay
end
