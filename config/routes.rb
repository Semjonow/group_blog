GroupBlog::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'

  match "/login"  => "sessions#new",     :via => :get,    :as => :login
  match "/login"  => "sessions#create",  :via => :post,   :as => :login
  match "/logout" => "sessions#destroy", :via => :delete, :as => :logout

  match "/register" => "users#new",      :via => :get,    :as => :register
  match "/register" => "users#create",   :via => :post,   :as => :register

  resources :invites, :only => [:new, :create, :show] do
    put :accept, :on => :member
  end

  resources :posts, :only => [:new, :create]

  root :to => "blogs#index"
end
