require 'machinist/active_record'
require 'sham'

Sham.color { |i| ['blue', 'red', 'white', 'orange'][i -1] }

Game.blueprint do
end

Player.blueprint do
  color
  game { Game.make }
end

Settlement.blueprint do
  player { Player.make }
end

City.blueprint do
  player { Player.make }
end

Expansion.blueprint do
end
Expansion.blueprint(:five_six_player) do
  name { 'FiveSixPlayer' }
  display_name { '5-6 player' }
end
Expansion.blueprint(:cities_and_knights) do
  name { 'CitiesAndKnights' }
  display_name { 'cities and knights' }
end

Knight.blueprint do
  player { Player.make }
  level { 1 }
  activated { false }
end
