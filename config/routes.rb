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
    member do
      get 'like'
      get 'dislike'
    end
  end
  resources :relationships, only: [:create, :destroy]

  post '/sign_in', to: 'sessions#create'
  get '/sign_in', to: 'sessions#new'
  get '/sign_up', to: 'users#new'
  get '/logout', to: 'sessions#destroy'
end
