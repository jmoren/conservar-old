Conservar::Application.routes.draw do

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match  '/admin' => "admin#index", :as => :admin
  get  'reports/deteriorations_to_gantt' => "reports#deteriorations_to_gantt"
  get  '/deterioration'                  => "deteriorations#get_deterioration"
  post 'deteriorations/:id/close'        => "deteriorations#close", :as => "close_deterioration"
  post 'deteriorations/:id/open'         => "deteriorations#open", :as => "open_deterioration"
  post 'deteriorations/update_in_place'  => "deteriorations#update_in_place"
  post 'galleries/update_in_place'       => "galleries#update_in_place"

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
  resources :reports do
    resources :observations, :only => [:new, :create,:show]
    resources :deteriorations, :only => [:show]
    resources :galleries, :only => [:new, :create,:show]
    resources :tasks
    member do
      post '/close' => "reports#close"
      post '/open' => "reports#open"
    end
  end
  namespace "admin" do
    resources :users
  end
  resources :sessions
  resources :users, :only => [:edit, :update]
  root :to => "reports#index"

end

