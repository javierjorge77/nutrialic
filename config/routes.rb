Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  resources :professionals do
    resources :appointments, only: [:new, :create, :index]
    member do
      get ':name', action: :show, as: ''
    end
  end
  resources :users, only: [:show]
  post 'review', to: 'reviews#create'

  get 'appointments', to: 'appointments#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
