ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'games', :action => 'new'
  
  map.resources :games do |game|
    game.resources :players
  end
  
  map.resources :players do |player|
    player.resources :settlements
    player.resources :cities
    player.resources :knights
  end
  
  map.upgrade_to_city_settlement 'settlements/:id/upgrade_to_city', :controller => 'settlements', :action => 'upgrade_to_city', :conditions => {:method => :post}
  map.downgrade_to_settlement_city 'cities/:id/downgrade_to_settlement', :controller => 'cities', :action => 'downgrade_to_settlement', :conditions => {:method => :post}
  
  map.resources :knights, :member => {:promote => :post}
  
end
