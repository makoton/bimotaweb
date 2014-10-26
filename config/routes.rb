Bimotaweb::Application.routes.draw do
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  resources :clients
  resources :users
  resources :orders
  resources :consumable_supplies
  resources :part_supplies
  resources :vehicles
  resources :car_vehicles
  resources :bike_vehicles
  resources :settings
end
