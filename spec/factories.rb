#coding: utf-8
#定义一个根机构
Factory.define :root_org,:class => Org do |root_org|
  root_org.name "root"
end

Factory.define :org_zz,:class => Org do |org|
  org.name 'A'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  '南三环燕赵物流园'
  org.code  "A"
  org.lock_input_time  "23:59"
end
Factory.define :org_sjz,:class => Org do |org|
  org.name '石家庄'
  org.phone  '0371-67519902'
  org.manager  '张三'
  org.location  ''
  org.code  "石"
  org.lock_input_time  "23:59"
end
