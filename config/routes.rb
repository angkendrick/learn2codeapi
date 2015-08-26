Rails.application.routes.draw do
  resource :user, only: [:create, :show, :update], format: 'json'
  resources :tutorials, only: [:index, :create, :show, :update, :destroy], format: 'json'
  #resources :subjects, format: 'json'
  resources :likes, only: [:show, :create, :destroy, :update], format: 'json'
  resources :reviews, only: [:create, :destroy], format: 'json'

  get '/search', to: 'search#index', format: 'json'

  post '/login', to: 'sessions#create', format: 'json'
  delete '/logout', to: 'sessions#destroy', format: 'json'

end
