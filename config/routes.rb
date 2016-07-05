Rails.application.routes.draw do

  root 'projects#index'

  resources :inventories do
    get 'label' => 'inventories#label'
    resources :items do
      get 'claim' => 'items#claim'
      get 'unclaim' => 'items#unclaim'
    end
    resources :tags, except: :show
    get 'tags/:tag', to: 'inventories#filter'
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  match "/my-projects" => "projects#mine", :via => :get, :as => :my_projects
  match "/about" => "projects#about", :via => :get, :as => :about
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile


  resources :projects do
    resources :teams do
      get 'join_team' => 'teams#join_team'
      delete 'leave_team' => 'teams#leave_team'
      resources :budgets
      resources :todos do
        get 'claim' => 'todos#claim'
        get 'unclaim' => 'todos#unclaim'
      end
    end
  end

  get 'profiles/show'

  resources :users do
    resources :skills
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
