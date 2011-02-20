#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class IlConfig < ActiveRecord::Base
  #保价费设置比例
  KEY_INSURED_RATE = 'insured_rate'
  #用户名称设置
  KEY_CLIENT_NAME = "client_name"
  #logo设置
  KEY_LOGO = "client_logo"
  #title 
  KEY_TITLE = 'system_title'
  def self.insured_rate
   if self.find_by_key(KEY_INSURED_RATE).blank?
     self.create(:key => KEY_INSURED_RATE,:title => '保价费比例设置',:value => '0.003')
   end
   self.find_by_key(KEY_INSURED_RATE).value.to_f
  end
  def self.client_name
   if self.find_by_key(KEY_CLIENT_NAME).blank?
     self.create(:key => KEY_CLIENT_NAME,:title => '公司名称',:value => '郑州市燕赵货运服务有限公司')
   end
   self.find_by_key(KEY_CLIENT_NAME).value
  end
  def self.client_logo
   if self.find_by_key(KEY_LOGO).blank?
     self.create(:key => KEY_LOGO,:title => '公司标志',:value => '/images/logo.png')
   end
   self.find_by_key(KEY_LOGO).value
  end
  def self.system_title
   if self.find_by_key(KEY_TITLE).blank?
     self.create(:key => KEY_TITLE,:title => '系统名称',:value => 'IL综合物流业务系统')
   end
   self.find_by_key(KEY_TITLE).value
  end

end
