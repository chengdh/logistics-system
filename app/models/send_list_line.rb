class SendListLine < ActiveRecord::Base
  belongs_to :send_list
  belongs_to :carrying_bill
  belongs_to :send_list_post
  belongs_to :send_list_back
  #validates_presence_of :send_list_id,:carrying_bill_id
  #定义状态机
  state_machine :initial => :sended do
    #核销
    event :post do
      transition :sended =>:posted
    end
    #退回
    event :back do
      transition :sended => :backed
    end
  end
end
