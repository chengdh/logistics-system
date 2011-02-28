#coding: utf-8
module CarryingBillsHelper
  #运费支付方式显示
  def pay_type_des(pay_type)
    pay_type_des = ""
    CarryingBill.pay_types.each {|des,code| pay_type_des = des if code == pay_type }
    pay_type_des
  end
  #票据状态
  def states_for_select
    CarryingBill.state_machine.states.collect{|state| [state.human_name,state.value] }
  end
  #得到查询对象的id数组
  def search_ids
    @search.select("carrying_bills.id").map {|bill| bill.id }.to_json
  end
  #得到票据合计信息
  def search_sum
    sum_info = CarryingBill.search_sum(@search)
    sum_info
  end
  #得到滞留天数对应的class
  #4天之内为白色，5—8天为兰色，9—12天为绿色，13—16天为黄色，17—20天为红色，21天后全部为黑色。
  def stranded_class(days)
    ret_class=''
    ret_class="white-bill" if days <= 4
    ret_class="blue-bill" if days >= 4 and days <= 8
    ret_class="green-bill" if days >= 9 and days <= 12
    ret_class="yellow-bill" if days >= 13 and days <= 16
    ret_class="red-bill" if days >= 17 and days <= 20
    ret_class="black-bill" if days >= 21
    ret_class
  end

end
