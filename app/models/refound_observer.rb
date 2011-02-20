#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
#coding: utf-8
class RefoundObserver < ActiveRecord::Observer
  def after_create(refound)
    refound.create_remittance(:from_org => refound.from_org,:to_org => refound.to_org,:should_fee => refound.sum_fee)
  end
end
