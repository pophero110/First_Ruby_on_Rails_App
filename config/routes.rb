Rails.application.routes.draw do
  get 'about', to: 'welcome#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :articles, only: [:show, :index, :new, :create,:edit, :update,:destroy]
  resources :articles

  root 'welcome#index'
end
