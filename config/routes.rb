Conservar::Application.routes.draw do

  resources :events

  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  #admin routes
  match 'admin' => "admin#index", :as => :admin
  match 'admin/estadisticas' => "admin#statistics", :as => "admin_statistics"
  match 'admin/configuracion' => "admin#configuration", :as => "admin_configuration"
  #institution
  post '/admin/institutions/update_in_place'  => "admin::Institutions#update_in_place"
  # deterioration categories
  get  'admin/det_categories/:id/enable' => "admin::DetCategories#enable_category", :as => "admin_enable_category"
  get  'admin/det_categories/:id/disable' => "admin::DetCategories#disable_category", :as => "admin_disable_category"
  post 'admin/det_categories/update_in_place'  => "admin::DetCategories#update_in_place"
  #items_categories
  get  'admin/item_categories/:id/enable' => "admin::ItemCategories#enable_category", :as => "admin_enable_item_category"
  get  'admin/item_categories/:id/disable' => "admin::ItemCategories#disable_category", :as => "admin_disable_item_category"

  # deteriorations routes
  get  'deterioration'                  => "deteriorations#get_deterioration"
  post 'deteriorations/:id/close'        => "deteriorations#close", :as => "close_deterioration"
  post 'deteriorations/:id/open'         => "deteriorations#open", :as => "open_deterioration"
  post 'deteriorations/update_in_place'  => "deteriorations#update_in_place"
  post 'galleries/update_in_place'       => "galleries#update_in_place"
  #get  'reports/deteriorations_to_gantt' => "reports#deteriorations_to_gantt"
  post 'observations/update_in_place'  => "observations#update_in_place"
  #item_categories
  get 'items/get_subcategories' => "items#get_subcategories", :as => 'get_subcategories'
  #calendar
  post '/events/:id/update_in_calendar' => 'events#update_in_calendar'

  resources :items do
    resources :reports, :only => [:new, :create]
    member do
      post 'remover' => "items#remove_from_collection"
      get :complete_fields
    end
  end
  resources :collections
  resources :galleries, :except => [:new, :create] do
    collection do
      post :upload
    end
    member do
      get :uploader
    end
  end
  resources :tasks, :except => [:new, :create] do
    resources :galleries, :only => [:new, :create, :show]
  end
  resources :observations, :except => [:new, :create]
  resources :reports, :except => [:new,:create] do
    resources :observations, :only => [:new, :create,:show]
    resources :deteriorations, :only => [:show]
    resources :galleries, :only => [:new, :create,:show] do
      collection do
        get '/gallery_1' => "galleries#get_gallery_1"
        get '/gallery_2' => "galleries#get_gallery_2"
      end
    end
    resources :tasks
    member do
      match 'print/report_:closed_at' => "reports#print", :as => :print_pdf
      post '/close' => "reports#close"
      post '/open' => "reports#open"
      get '/compare' => "reports#compare_galleries", :as => 'compare_galleries'
    end
  end
  namespace "admin" do
    resources :users do
      member do
        get '/enable' => "users#enable", :as => 'enable'
        get '/disable' => "users#disable", :as => 'disable'
      end
    end
    resources :det_categories, :only => [:create]
    resources :item_categories, :only => [:create,:show]
    resources :generic_fields
    resources :institutions, :only => [:new, :create, :edit, :update]
  end
  resources :sessions
  resources :users, :only => [:edit, :update]
  root :to => "items#index"

end

