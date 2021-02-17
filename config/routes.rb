Rails.application.routes.draw do
  get 'sessions/new'
  get '/' => 'users#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login'  => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  get '/list' => 'courses#list'
  get '/clist' => 'registrations#list'
  resources :users
  resources :courses
  resources :registrations
end
