CatanCounter::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  root :to => 'games#new'

  resources 'games' do
    resources 'barbarians', :only => [] do
      collection do
        put 'attack'
      end
    end
  end

  resources 'players' do
    member do
      put 'take_longest_road'
      put 'play_soldier'
      put 'build_metropolis'
      put 'take_boot'
      put 'take_merchant'
      put 'take_progress_card_victory_point'
      put 'take_gold_point_victory_point'
    end
    resources 'settlements' do
      member do
        post 'upgrade_to_city'
      end
    end
    resources 'cities' do
      member do
        post 'downgrade_to_settlement'
      end
    end
    resources 'knights' do
      member do
        put 'promote'
        put 'toggle_activation'
      end
    end
  end

end
