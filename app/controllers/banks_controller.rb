class BanksController < BaseController
  table :except => [:created_at,:updated_at]
end
