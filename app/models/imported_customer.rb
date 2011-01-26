#coding: utf-8
#自运单导入的客户资料,用于客户分级
class ImportedCustomer < Customer
  #以下定义状态
  STATE_NORMAL = 'normal'           #正常状态,没有下降
  STATE_1_MTH_DOWN = 'down_1mth'    #低于标准一个月
  STATE_2_MTH_DOWN = 'down_2mth'    #低于标准两个月
  STATE_3_MTH_DOWN = 'down_3mth'    #低于标准三个月
  STATE_4_MTH_DOWN = 'down_4mth'    #低于标准四个月
  #计算vip的状态和级别
  def self.update_state!(org_id)
    vip_infos = self.where(:org_id => org_id)
    vip_infos.each do |vip_info|
      vip_info.cal_state!
      vip_info.save!
    end
  end
  #设置level描述
  def self.states
    ordered_hash = ActiveSupport::OrderedHash.new
    ordered_hash[STATE_NORMAL] = "正常"
    ordered_hash[STATE_1_MTH_DOWN] = "下降-1个月"
    ordered_hash[STATE_2_MTH_DOWN] = "下降-2个月"
    ordered_hash[STATE_3_MTH_DOWN] = "下降-3个月"
    ordered_hash[STATE_4_MTH_DOWN] = "下降-4个月"
    ordered_hash
  end
  

  #根据vip_info的当前信息计算其状态
  #贵宾客户分三个级别：钻石、金卡、银卡、普通
  #如升级后期贵宾客户所发货物运费低于所制定比例标准一个月，以黄色显示，第二个月以红色显示，第三个月以黑色显示，第四个月自动降级。
  def cal_state!
    cur_fee = self.cur_fee
    cur_level = self.level.blank? ? CustomerLevelConfig::VIP_NORMAL : self.level
    cur_mth = 1.months.ago.strftime("%Y%m")
    if self.last_import_mth < cur_mth
      #当月费用默认为0
      cur_fee = 0
    end
    #根据金额判断其级别
    the_level = CustomerLevelConfig.get_level(self.org_id,cur_fee)
    #如果计算级别高于当前级别,则客户升级
    if the_level >= cur_level
      self.level = the_level 
      self.state = STATE_NORMAL
    end
    #如果计算级别低于当前级别,设置其状态或降级
    if the_level < cur_level
      if self.state == STATE_NORMAL
        self.state = STATE_1_MTH_DOWN 
      elsif self.state == STATE_1_MTH_DOWN
        self.state = STATE_2_MTH_DOWN 
      elsif self.state == STATE_2_MTH_DOWN
        self.state = STATE_3_MTH_DOWN 
      elsif self.state == STATE_3_MTH_DOWN
        self.state = STATE_4_MTH_DOWN 
      end
      #如果连续三个月低于标准,则降级,重设状态为normal
      if self.state == STATE_4_MTH_DOWN
        self.state = STATE_NORMAL
        self.level = the_level
      end
    end
  end
  def org_name
    self.org.name
  end
  def level_des
    CustomerLevelConfig.levels[self.level]
  end
  def state_des
    CustomerLevelConfig.states[self.state]
  end
end
