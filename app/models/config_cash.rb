#coding: utf-8
class ConfigCash < ActiveRecord::Base
  validates_presence_of :fee_from,:fee_to,:hand_fee
  #得到默认的手续费设置
  #客户需求中
  #< 1000 1元
  #1000 ~ 2000 2元
  #2000 ~ 3000 3元
  def self.default_hand_fee(goods_fee)
    q,r = goods_fee.divmod(1000.0)
    if r > 0
      q + 1
    else
      q
    end
  end
  #得到手续费设置比例数组
  def self.hand_fee_a
    ret =[]
    self.where(:is_active => true).order('created_at DESC').each do |config|
      ret += [[(config.fee_from..config.fee_to),config.hand_fee]]
    end
    ret
  end
  #根据设置计算手续费
  def self.cal_hand_fee(goods_fee)
    found = false
    ret = 0
    hand_fee_a.each do |fee_rate|
      if fee_rate[0].include? goods_fee
        found = true
        ret = fee_rate[1]
      end
    end
    ret = default_hand_fee(goods_fee) if !found
    ret
  end
end
