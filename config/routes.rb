Bimotaweb::Application.routes.draw do
  devise_for :users

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'


end
