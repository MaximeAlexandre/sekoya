Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/profiles', to: 'profiles#helper_list', as: 'profiles'
  get '/profiles/:id', to: 'profiles#helper_details', as: 'profile'

  resources :bookings, only: [:show] do
    resources :reviews, only: [:create]
  end

  post "/profiles/:id/bookings", to: "bookings#create", as: 'booking_create'
  get "/bookings/:id/edit_tasks", to: "bookings#edit_tasks", as: 'tasks'
  get "/bookings/:id/edit_validation", to: "bookings#edit_validation", as: 'validation'
  patch "/bookings/:id/tasks", to: "bookings#update_task", as: 'booking_update_tasks'
  patch "/bookings/:id/validation", to: "bookings#update_validation", as: 'booking_update_validation'
  patch "/bookings/:id/status", to: "bookings#update_status", as: 'status_change'
  get "/senior", to: "pages#senior", as: 'senior'
  get "/helper", to: "pages#helper", as: 'helper'
  get 'calendars/show', to:"calendars#show", as: 'calendar'
  post "calendars/sch_generate", to: "calendars#sch_generate", as: 'sch_generate'
  get "/favoris", to: "favoris#index", as: 'favoris_index'
  post "/favoris", to: "favoris#create"
  delete "/favoris/:id", to: "favoris#destroy",as: 'favoris_destroy'

end
