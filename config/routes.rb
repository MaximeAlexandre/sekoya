Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/profiles', to: 'profiles#helper_list', as: 'profiles'
  get '/profiles/:id', to: 'profiles#helper_details', as: 'profile'

  resources :bookings, only: [:show]

  post "/profiles/:id/bookings", to: "bookings#create", as: 'booking_create'
  get "/bookings/:id/edit_tasks", to: "bookings#edit_tasks", as: 'tasks'
  get "/bookings/:id/edit_validation", to: "bookings#edit_validation", as: 'validation'
  patch "/bookings/:id/tasks", to: "bookings#update_task", as: 'booking_update_tasks'
  patch "/bookings/:id/validation", to: "bookings#update_validation", as: 'booking_update_validation'
end
