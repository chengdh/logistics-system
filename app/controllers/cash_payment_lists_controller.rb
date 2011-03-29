#coding: utf-8
class CashPaymentListsController < BaseController
  table :bill_date,:org,:user,:note
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
  def export_excel
    @cash_payment_list = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
  end
end
