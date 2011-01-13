class UsersController < BaseController
  def new
    @user = User.new_with_roles
  end
end
