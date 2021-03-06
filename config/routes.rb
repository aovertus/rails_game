Rails.application.routes.draw do
  resources :games do
    resources :comments
    member do
      post :notify_friend
    end
  end
  resources :users do
    member do 
      post :sign_up_mail
    end
  end
  resources :tournaments do
    resources :matches
  end
  
  ## API
  
 namespace :api do
  resources :games
 end


  
  resource :session
  match "/login" => "sessions#new", :as => "login", via: [:get, :post]
  match "/logout" => "sessions#destroy", :as => "logout", via: [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # OmniathFacebook
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  


  # You can have the root of your site routed with "root"
  root 'games#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  
  #Register
  match "tournament/:id/register" => "tournaments#register", as: :tournament_register, via: [:get, :post]
  
  #Match list
  match "my_matches" => "matches#list", as: :my_matches, via: [:get, :post]
  match "all_match" => "matches#all", as: :all_match, via: [:get, :post] 
  match "ranking" => "tournaments#ranking", as: :ranking, via: [:get, :post] 
  
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
