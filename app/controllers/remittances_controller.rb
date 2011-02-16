class RemittancesController < BaseController
  def update
    @remittance = Remittance.find(params[:id])
    @remittance.process
    update!
  end
  #GET search
  #显示查询窗口
  def search
    @search = resource_class.search(params[:search])
    render :partial => "search",:object => @search
  end

end
