class GexceptionAuthorizeInfosController < BaseController
  def index
    redirect_to goods_exceptions_path(:search => params[:search])
  end
end
