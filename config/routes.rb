Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  resources :professionals do
    resources :appointments
    member do
      get 'edit', action: :edit
      patch 'update', action: :update
    end
  end

  get '/professionals/:id', to: 'professionals#show', as: 'show_by_username'

  resources :users, only: [:show]
  post 'review', to: 'reviews#create'
  delete '/review/:id', to: 'reviews#destroy', as: 'review_delete'
  patch '/review/:id', to: 'reviews#update', as: 'review_update'

  get 'appointments', to: 'appointments#show'
  get '/login_with_token', to: 'sessions#login_with_token', as: 'login_with_token'

  get '/meetings', to: 'meetings#index'
end
