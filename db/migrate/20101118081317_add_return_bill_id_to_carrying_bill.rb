#添加对应退货单id
class AddReturnBillIdToCarryingBill < ActiveRecord::Migration
  def self.up
    add_column :carrying_bills, :original_bill_id, :integer
  end

  def self.down
    remove_column :carrying_bills, :original_bill_id
  end
end
