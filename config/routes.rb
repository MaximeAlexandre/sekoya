Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:show, :update]
  get "/profiles/:id/bookings/new", to: "bookings#new"
  post "/profiles/:id/bookings", to: "bookings#create"
end
