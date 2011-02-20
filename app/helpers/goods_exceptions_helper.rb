#coding: utf-8
#coding: utf-8
module GoodsExceptionsHelper
  #货物异常类别方式显示
  def exception_type_des(exception_type)
    exception_type_des = ""
    GoodsException.exception_types.each {|des,code| exception_type_des = des if code == exception_type }
    exception_type_des
  end
  #核销方式
  def exception_op_type_des(op_type)
    op_type_des = ""
    GexceptionAuthorizeInfo.op_types.each {|des,code| op_type_des = des if code == op_type }
    op_type_des
  end
end
