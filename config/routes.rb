Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/profiles', to: 'profiles#helper_list', as: 'profiles'
  get '/profiles/:id', to: 'profiles#helper_details', as: 'profile'

  resources :bookings, only: [:show, :update]
  get "/profiles/:id/bookings/new", to: "bookings#new", as: "booking_new"
  post "/profiles/:id/bookings", to: "bookings#create", as: "booking_create"
end
