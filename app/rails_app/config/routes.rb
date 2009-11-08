ActionController::Routing::Routes.draw do |map|
  
  map.resources :games do |game|
    game.resources :players
  end
  
  map.resources :players do |player|
    player.resources :settlements
    player.resources :cities
    player.resources :knights
  end
  
  map.settlement_upgrade_to_city 'settlements/:id/upgrade_to_city', :controller => 'settlements', :action => 'upgrade_to_city', :conditions => {:method => :post}
  map.city_downgrade_to_settlement 'cities/:id/downgrade_to_settlement', :controller => 'cities', :action => 'downgrade_to_settlement', :conditions => {:method => :post}
  # map.knight_promote 'knights/:id/promote', :controller => 'knights', :action => 'promote', :conditions => {:method => :post}
  
end
