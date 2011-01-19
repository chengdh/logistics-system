class CreateChangeInsuredRateFromCarryingBills < ActiveRecord::Migration
  def self.up
    change_column :carrying_bills,:insured_rate,:decimal,:precision => 15,:scale => 4,:default => 0
  end

  def self.down
  end
end
