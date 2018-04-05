Rails.application.routes.draw do
  get 'admin', to: 'pages#admin'
  get 'dashboard', to: 'pages#dashboard'

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  
  # resources :api do
    get '/redirect', to: 'api#redirect', as: 'redirect'
    get '/callback', to: 'api#callback', as: 'callback'
    get '/current_events', to: 'api#calendars', as: 'current_events'
    post '/api/create_event', to: 'api#create_event', as: 'create_event', calendar_id: 'primary'
  # end

  
  resources :events do
    member do
      get :approve
      get :reject
    end
  end
  
  resources :rsvps, only: [:new, :create, :destroy]
  resources :favorites, only: [:new, :create, :destroy]
  resources :api, only: [:callback, :redirect, :calendars, :create_event ]

  root :to => 'events#index'
end
