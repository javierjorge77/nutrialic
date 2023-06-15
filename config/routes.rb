Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  resources :professionals do
    resources :appointments
    member do
      get 'edit', action: :edit
      patch 'update', action: :update
      get ':name', action: :show, as: 'show_by_name'
    end
  end

  resources :users, only: [:show]
  post 'review', to: 'reviews#create'

  get 'appointments', to: 'appointments#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
