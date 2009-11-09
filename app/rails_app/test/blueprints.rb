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
  player
end

City.blueprint do
  player
end

Knight.blueprint do
  player { Player.make }
  level { 1 }
  activated { false }
end
