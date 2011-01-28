class DashboardController < ApplicationController
  def index
    #今日收货
    org_ids = current_user.current_ability_org_ids
    @today_billed =CarryingBill.today_billed(org_ids)
    #今日提货
    @today_deliveried = CarryingBill.today_deliveried(org_ids)
    #今日提款
    @today_paid = CarryingBill.today_paid(org_ids)
    #最近票据
    @recent_bills = CarryingBill.recent_bills(org_ids)
    #待提货票据
    @ready_delivery = CarryingBill.ready_delivery(org_ids)
    #待提款票据
    @ready_pay = CarryingBill.ready_pay(org_ids)
    #待确认收货清单
    @shipped_load_list = LoadList.shipped(org_ids)
    #待确认付款清单
    @refunded = Refound.refunded(org_ids)

  end
end
