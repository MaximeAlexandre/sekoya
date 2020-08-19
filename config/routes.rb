Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/profiles', to: 'profiles#helper_list'
  get '/profiles/:id', to: 'profiles#helper_details'

  resources :bookings, only: [:show, :update]
  get "/profiles/:id/bookings/new", to: "bookings#new", as: :new_booking
  post "/profiles/:id/bookings", to: "bookings#create"
end
