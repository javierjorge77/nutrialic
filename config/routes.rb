Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "pages#home"
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', confirmations: "users/confirmations" }


  resources :professionals, except: [:new] do
    resource :about_section, only: [:new, :create, :edit, :update, :destroy]
    resources :appointments
    member do
      get 'edit', action: :edit
      patch 'update', action: :update
      post 'addPhoto'
      patch :finalizar, to: 'appointments#finalizar', as: :finalizar_appointment
    end
  end 
  delete '/gallery_images/:id', to: 'professionals#delete_image', as: :delete_gallery_image

  get "*unmatched_route", to: "errors#not_found"
  delete '/professionals/:id', to: 'professionals#destroy', as: "delete_professional"
  
  namespace :api do
    namespace :v1 do
      get 'zoom/get_access_token', to: 'zoom_api#get_access_token'
      get 'zoom/get_meeting_status', to: 'zoom_api#get_meeting_status'
    end
  end

  get '/pro/:id', to: 'professionals#show', as: 'show_by_username'

  resources :users, only: [:show]
  get '/review/new/:id', to: 'reviews#new', as: 'new_review'
  post 'review', to: 'reviews#create'
  delete '/review/:id', to: 'reviews#destroy', as: 'review_delete'
  patch '/review/:id', to: 'reviews#update', as: 'review_update'

  get 'appointments', to: 'appointments#show'
  get '/login_with_token', to: 'sessions#login_with_token', as: 'login_with_token'

  get '/meetings/:meeting_id', to: 'meetings#index', as: 'meeting'

  resources :professional_account_requests, only: [:new, :create]
  patch '/admin/professional_account_requests/:id', to: 'professional_account_requests#update', as: 'admin_update_professional_account_request'

  resources :checkouts do
    get 'success',  to: 'checkouts#success', on: :collection, as: 'success'
  end
end
