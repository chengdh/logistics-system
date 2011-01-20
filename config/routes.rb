IlYanzhao::Application.routes.draw do

  resources :change_insured_rate_from_carrying_bills

  resources :il_configs

  resources :config_cashes

  resources :config_transits

  resources :roles

  #将devise的url与model user产生的url区分开
  #参见https://github.com/plataformatec/devise/wiki/How-To:-Manage-users-through-a-CRUD-interface
  devise_for :users,:controllers => {:sessions => "sessions"} do
    #登录成功后显示设置角色与部门界面
    get "users/new_session_default",:to => "sessions#new_session_default",:as => :new_session_default
    #保存用户设置
    put  "users/update_session_default",:to => "sessions#update_session_default",:as => :update_session_default
  end

  match "users/new_session_default",:to => "sessions#new_session_default",:as => :user_root

  resources :users

  resources :transit_deliver_infos do
    resource :carrying_bill
  end

  resources :transit_companies

  resources :transit_infos do
    resource :carrying_bill
  end

  resources :post_infos do
    resources :carrying_bills
  end

  resources :transfer_pay_infos do
    resources :carrying_bills
  end


  resources :cash_pay_infos do
    resources :carrying_bills
  end

  resources :transfer_payment_lists do
    resources :carrying_bills
  end


  resources :cash_payment_lists do
    resources :carrying_bills
  end

  resources :vips

  resources :customers

  resources :banks

  resources :refounds do
    resources :carrying_bills
    get :process_handle,:on => :member
    resources :carrying_bills
  end
  #返款清单确认
  resources :receive_refounds do
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :settlements do
    resources :carrying_bills
  end

  resources :deliver_infos do
    resources :carrying_bills
  end


  resources :distribution_lists do
    resources :carrying_bills
  end

  resources :load_lists do
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :arrive_load_lists do
    get :process_handle,:on => :member
    resources :carrying_bills
  end

  resources :hand_transit_bills do
    get :search,:on => :collection
  end

  resources :transit_bills do
    get :search,:on => :collection
  end

  resources :hand_bills do
    get :search,:on => :collection
  end

  resources :return_bills do
    get :before_new,:on => :collection
    get :search,:on => :collection
  end

  resources :orgs
  resources :branches
  resources :departments

  #添加carrying_biils路由
  resources :carrying_bills do
    get :search,:on => :collection
  end

  resources :computer_bills do
    get :search,:on => :collection
  end

  root :to => "computer_bills#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
