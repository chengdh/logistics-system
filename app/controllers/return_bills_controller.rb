#coding: utf-8
class ReturnBillsController <  CarryingBillsController
  def before_new
  end
  def new
    if params[:bill_no].blank? 
      flash[:error] = "请录入原运单号码." 
      render :action => :before_new
    elsif CarryingBill.find_by_bill_no(params[:bill_no]).blank?
      flash[:error] = "未找到原始运单信息." 
      render :action => :before_new
    else
      original_bill = CarryingBill.find_by_bill_no(params[:bill_no])
      @return_bill = ReturnBill.new_with_ori_bill(original_bill)
      render :new
    end
  end
end
