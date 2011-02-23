class AddCompletedToCarryingBill < ActiveRecord::Migration
  def self.up

    #以下添加mysql 分区表
    execute("ALTER TABLE carrying_bills 
            partition by list(completed)
            (
            partition p0 values in(0),
            partition p1 values in(1)
           )")
  end

  def self.down
    execute("ALTER TABLE carrying_bills DROP PARTITION p0")
    execute("ALTER TABLE carrying_bills DROP PARTITION p1")
    remove_column :carrying_bills, :completed
  end
end
