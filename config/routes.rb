Rails.application.routes.draw do
  resources :titles, path: "/calendar/titles"

  resources :episodes

  devise_for :admins, :path => '', :controllers => {:sessions => 'sessions'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'pages#index'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  get 'calendar' => 'calendar#calendar'
  get 'cv' => 'cv#index'
  get 'calendar/show_all' => 'title#index'
  #get 'edit_title/:id' => 'calendar#edit'
  #patch 'edit_title/:id' => 'calendar#update'
  get 'show_form_title' => 'calendar#show_form_title'
  get 'show_form_episode' => 'calendar#show_form_episode'
  #patch 'edit_episode/:id' => 'calendar#update_episode'
  get 'refresh_API' => 'titles#refresh_API'
  get 'show_popup/:name' => "titles#show_popup"
  #get 'refresh_test' => 'calendar#refresh_test'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  post 'select_time_zone' => 'calendar#select_time_zone'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  get 'set_cookies/:name' => 'calendar#set_cookies'
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
end
