require 'machinist/active_record'
require 'sham'

StandardGame.blueprint do
end

Sham.color { |i| Player::COLORS[i -1] }

Player.blueprint do
  color
  game { StandardGame.make }
end

Road.blueprint do
  player { Player.make }
end

Knight.blueprint do
  player { Player.make }
  level
  activated { false }
end
