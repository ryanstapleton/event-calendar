Rails.application.routes.draw do
  get 'admin', to: 'pages#admin'
  get 'dashboard', to: 'pages#dashboard'

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}
  
  # resources :api do
    get '/redirect', to: 'events#redirect', as: 'redirect'
    get '/callback', to: 'events#callback', as: 'callback'
    get '/current_events', to: 'events#calendars', as: 'current_events'
    post '/send', to: 'events#send', calendar_id: 'primary'
  # end

  
  resources :events do
    member do
      get :approve
      get :reject
      # post :send, calendar_id: 'primary'
    end
  end
  
  resources :rsvps, only: [:new, :create, :destroy]
  resources :favorites, only: [:new, :create, :destroy]

  root :to => 'events#index'
end
