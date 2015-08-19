Rails.application.routes.draw do
  resource :user
  resources :tutorials
  resources :subjects
  resources :likes, only: [:index, :create, :destroy]

  get '/search', to: 'search#index'

  post '/login', to: 'sessions#create'

end
