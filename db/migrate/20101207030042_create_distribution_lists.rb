class CreateDistributionLists < ActiveRecord::Migration
  def self.up
    create_table :distribution_lists do |t|
      t.date :bill_date
      t.references :user
      t.integer :org_id,:null => false
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :distribution_lists
  end
end
