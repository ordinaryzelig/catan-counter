require 'machinist/active_record'
require 'sham'

StandardGame.blueprint do
end

Sham.color { |i| Player::COLORS[i -1] }

Player.blueprint do
  color
  game
end

Road.blueprint do
  player
end
