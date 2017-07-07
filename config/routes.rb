Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions
  resources :posts do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
