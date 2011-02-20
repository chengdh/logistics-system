#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class DistributionListsController < BaseController
  include BillOperate
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
end

