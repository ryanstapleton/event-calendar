Rails.application.routes.draw do
  get 'admin', to: 'pages#admin'
  get 'dashboard', to: 'pages#dashboard'

  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, controllers: { omniauth_callbacks: "callbacks" }
  
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
