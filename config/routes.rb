Bimotaweb::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  namespace :me do
    root to: 'users#show'

    resource :user do
      member do
        get :profile
        post :commit_user_information
      end
    end
    resources :orders
    resources :vehicles do
      resources :orders, controller: 'vehicle_orders'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :orders
    end
  end

  namespace :admin do
    root to: 'orders#index'

    resources :users do
      member do
       post :commit_user_information
      end
      collection do
        get :check_existing_rut
      end
    end
    resources :orders
    resources :consumable_supplies do
      collection do
        get :add_units_modal
      end
      member do
        post :add_units
      end
    end
    resources :part_supplies do
      collection do
        get :add_units_modal
      end
      member do
        post :add_units
      end
    end
    resources :vehicles do
      resources :orders, controller: 'vehicle_orders' do
        member do
          post :add_comment, :start, :finish, :commit_new_task, :commit_supply, :commit_remove_supply, :commit_labor_cost
          get :add_consumable_supply, :remove_consumable_supply, :remove_part_supply, :get_consumed_supplies, :get_supply_stock, :add_part_supply, :labor_cost_form, :finish_task, :task_details, :pending_task
          delete :delete_task, :delete_comment
        end
      end
      member do
        get :assign_to_user, :find_users, :fetch_selected_user, :dissociate_user
        post :assign, :create_and_assign_user
      end
    end
    resources :bike_brands
    resource :setting do
      member do
        patch :commit_changes
      end
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
