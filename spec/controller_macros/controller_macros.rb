module ControllerMacros
  def login_admin
    before(:each) do
      sign_out :user
      sign_in Factory(:admin)
    end
  end
end
