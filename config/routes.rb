Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'errors#routing'

  get '/6ba041bf35229938ba869a7a9c59f3a0/api/civility/list' => 'civilities#api_list'

  get '/6ba041bf35229938ba869a7a9c59f3a0/api/sex/list' => 'sexes#api_list'

  get '/6ba041bf35229938ba869a7a9c59f3a0/api/users/account/create/:civility_id/:sex_id/:pseudo/:firstname/:lastname/:email/:password/:password_confirmation/:msisdn/:birthdate/:creation_mode' => 'users#api_create', :constraints => {:email => /.*/}
  get '/6ba041bf35229938ba869a7a9c59f3a0/api/users/account/update/:id/:civility_id/:sex_id/:pseudo/:firstname/:lastname/:email/:msisdn/:birthdate' => 'users#api_update', :constraints => {:email => /.*/}
  get '/6ba041bf35229938ba869a7a9c59f3a0/api/users/account/email/login/:email/:password' => 'users#api_email_login', :constraints => {:email => /.*/}
  get '/6ba041bf35229938ba869a7a9c59f3a0/api/users/account/msisdn/login/:msisdn/:password' => 'users#api_msisdn_login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  get '*rogue_url', :to => 'errors#routing'
  post '*rogue_url', :to => 'errors#routing'
end
