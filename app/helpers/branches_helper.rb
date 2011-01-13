module BranchesHelper
  def branches_for_select
    Branch.where(:is_active => true).all.map {|b| ["#{b.name}(#{b.py})",b.id]}
  end
  #根据当前登录用户的选择机构
  def current_org_for_select
    {current_user.default_org.name => current_user.default_org.id}
  end
  #除去当前机构的机构选择
  def branches_for_select_ex
    Branch.search(:is_active_eq => true,:id_ne => current_user.default_org.id).all.map {|b| ["#{b.name}(#{b.py})",b.id]}

  end
end
