Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'blogs#index'
  resources :blogs
  resources :sessions
  namespace :admin do
    resources :users
  end
  resources :users
end
