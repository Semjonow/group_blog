GroupBlog::Application.routes.draw do
  match "/login"  => "sessions#new",     :via => :get,    :as => :login
  match "/login"  => "sessions#create",  :via => :post,   :as => :login
  match "/logout" => "sessions#destroy", :via => :delete, :as => :logout

  match "/register" => "users#new",      :via => :get,    :as => :register
  match "/register" => "users#create",   :via => :post,   :as => :register

  root :to => "application#index"
end
