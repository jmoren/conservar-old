Conservar::Application.routes.draw do

  resources :special_tasks

  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'profile' => 'users#profile', :as => :profile
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
  post 'admin/generic_fields/update_in_place'  => "admin::GenericFields#update_in_place"
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
  #alerts
  post 'alerts/update_in_place'  => "alerts#update_in_place"

  resources :items do
    resources :alerts
    resources :reports, :only => [:new, :create]
    member do
      post 'remover' => "items#remove_from_collection"
      get :complete_fields
      get 'flag' => "items#flag"
      get 'unflag' => "items#unflag"
    end
  end

  resources :galleries, :except => [:new, :create] do
    post :upload, :on => :collection
    get :uploader, :on => :member
  end

  resources :tasks, :except => [:new, :create] do
    resources :galleries, :only => [:new, :create, :show]
  end

  resources :reports, :except => [:new,:create] do
    resources :alerts
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
      get 'conclusion' => 'reports#conclusion'
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
  resources :observations, :only => [:destroy]
  resources :alerts
  resources :events
  resources :collections do
    get :list, :on => :member
  end  
  resources :sessions
  resources :users, :only => [:edit, :update]
  root :to => "items#index"

end

