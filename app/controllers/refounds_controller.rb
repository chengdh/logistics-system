#coding: utf-8
class RefoundsController < BaseController
  include BillOperate
  table :bill_date,:from_org,:to_org,:human_state_name,:user,:sum_goods_fee,:sum_carrying_fee,:note
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
  #导出到excel
  #GET /refounds/:id/export_excel
  def export_excel
    @refound = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
  end
end
