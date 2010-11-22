#coding: utf-8
class ComputerBillsController < BaseController
  #autocomplete on from_org and to_org
  autocomplete :branch,:py,:display_value => :funky_method
end
