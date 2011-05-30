Conservar::Application.routes.draw do
  get '/deterioration' => "deteriorations#get_deterioration"
  post 'deteriorations/:id/close' => "deteriorations#close", :as => "close_deterioration"
  post 'deteriorations/:id/open' => "deteriorations#open", :as => "open_deterioration"
  post 'deteriorations/update_in_place' => "deteriorations#update_in_place"
  post 'galleries/update_in_place' => "galleries#update_in_place"
  resources :galleries, :except => [:new, :create] do
    collection do
      post :upload
    end
    member do
      get :uploader
    end
  end

  resources :reports do
    resources :deteriorations, :only => [:show]
    resources :galleries, :only => [:new, :create]
    resources :tasks
    collection do
      put :update_attribute_on_the_spot
    end
    member do
      post '/close' => "reports#close"
      post '/open' => "reports#open"
    end
  end
  root :to => "reports#index"
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

