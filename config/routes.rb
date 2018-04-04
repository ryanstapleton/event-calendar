Rails.application.routes.draw do
  get 'admin', to: 'pages#admin'
  get 'dashboard', to: 'pages#dashboard'

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  get '/redirect', to: 'pages#admin', as: 'redirect'
  get '/callback', to: 'pages#admin', as: 'callback'
  post '/events/:calendar_id', to: 'pages#dashboard', as: 'created_event', calendar_id: /[^\/]+/

  
  resources :events do
    member do
      get :approve
      get :reject
    end
  end
  
  resources :rsvps, only: [:new, :create, :destroy]
  resources :favorites, only: [:new, :create, :destroy]

  root :to => 'events#index'
end
