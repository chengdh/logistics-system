class RemittancesController < BaseController
  def update
    @remittance = Remittance.find(params[:id])
    @remittance.process
    update!
  end
end
