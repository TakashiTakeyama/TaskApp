Rails.application.routes.draw do
  root to: 'sessions#new'
  # get 'sessions/new'
  resources :blogs
  resources :sessions
  namespace :admin do
    resources :users
  end
  resources :users
  resources :labelings
  resources :labels
end
