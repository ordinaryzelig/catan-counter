CatanCounter::Application.routes.draw do

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
    end
    resources 'settlements', :only => [:create] do
      collection do
        post 'upgrade_to_city'
      end
      # normal destrooy requires specific settlement, this one does not.
      collection do
        delete 'destroy'
      end
    end
    post 'cities/downgrade_to_settlement' => 'cities#downgrade_to_settlement'
    resources 'knights' do
      member do
        put 'promote'
        put 'toggle_activation'
      end
    end
  end

end
