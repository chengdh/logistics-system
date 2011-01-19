require 'spec_helper'

describe "ChangeInsuredRateFromCarryingBills" do
  describe "GET /change_insured_rate_from_carrying_bills" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get change_insured_rate_from_carrying_bills_path
      response.status.should be(200)
    end
  end
end
