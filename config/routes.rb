Rails.application.routes.draw do
  root "homepage#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :articles, only: [:show, :index, :new, :create,:edit, :update,:destroy]
  resources :articles
  resources :products
  resources :sales
  get "signup", to: "users#new"
  resources :users, except: [:new]
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :categories
  resources :product_lists
  resources :shipments
  resources :vendors
end
