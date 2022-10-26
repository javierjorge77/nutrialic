Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resources :professional do
    resources :appointments, only: [:new, :create]
  end
  resources :user, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
