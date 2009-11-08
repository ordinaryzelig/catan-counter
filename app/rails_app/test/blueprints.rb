require 'machinist/active_record'
require 'sham'

StandardGame.blueprint do
end

Sham.color { |i| Player::COLORS[i -1] }

Player.blueprint do
  color
  game { StandardGame.make }
end

Settlement.blueprint do
  player
end

City.blueprint do
  player
end

Knight.blueprint do
  player { Player.make }
  level
  activated { false }
end
