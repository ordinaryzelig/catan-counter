ActionController::Routing::Routes.draw do |map|
  
  map.resources :games do |game|
    game.resources :players
  end
  
  map.resources :cities
  
  map.resources :settlements
  
  map.resources :knights
  
end
