Rails.application.routes.draw do
  devise_for :users
  # Devise  : Root of application
  root to: "articles#index"
  resources :comments
  resources :articles
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
