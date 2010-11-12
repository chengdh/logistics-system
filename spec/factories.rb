#coding: utf-8
#定义一个根机构
Factory.define :org do |org|
  org.name 'org'
  org.simp_name 'o'
  org.phone  '0371-67519902'
  org.manager  'org'
  org.location  'location'
  org.code  "code"
  org.lock_input_time  "23:59"
end

Factory.define :zz,:parent => :org do |org|
  org.name 'A'
  org.simp_name 'A'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '南三环燕赵物流园'
  org.code  "A"
  org.lock_input_time  "23:59"
end
Factory.define :sjz,:parent => :org do |org|
  org.name '石家庄'
  org.simp_name '石'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "石"
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
end
