#coding: utf-8
class IlConfig < ActiveRecord::Base
  validates_presence_of :key
  validates :key,:presence => true,:uniqueness => true
  #保价费设置比例
  KEY_INSURED_RATE = 'insured_rate'
  #用户名称设置
  KEY_CLIENT_NAME = "client_name"
  #logo设置
  KEY_LOGO = "client_logo"
  #title
  KEY_TITLE = 'system_title'
  def self.insured_rate
    @insured_rate ||= self.find_by_key(KEY_INSURED_RATE)
    @insured_rate ||= self.create(:key => KEY_INSURED_RATE,:title => '保价费比例设置',:value => '0.003')
    @insured_rate.value
  end
  def self.client_name
    @client_name ||=self.find_by_key(KEY_CLIENT_NAME)
    @client_name ||= self.create(:key => KEY_CLIENT_NAME,:title => '公司名称',:value => 'XXX物流公司')
    @client_name.value
  end
  def self.client_logo
    @client_logo ||= self.find_by_key(KEY_LOGO)
    @client_logo ||= self.create(:key => KEY_LOGO,:title => '公司标志',:value => '/images/logo.png')
    @client_logo.value
  end
  def self.system_title
    @system_title ||= self.find_by_key(KEY_TITLE)
    @system_title ||= self.create(:key => KEY_TITLE,:title => '系统名称',:value => 'IL综合物流业务系统')
    @system_title.value
  end
end
