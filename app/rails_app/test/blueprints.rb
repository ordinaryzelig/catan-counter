require 'machinist/active_record'
require 'sham'

Sham.color { |i| ['blue', 'red', 'white', 'orange'][i -1] }

Game.blueprint do
  victory_points_to_win {}
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
Expansion.blueprint(:cities_and_knights) do
  name { 'CitiesAndKnights' }
  display_name { 'cities and knights' }
  description { 'adds knights, metropolises, and barbarians. first to 13 wins.' }
end

Knight.blueprint do
  player { Player.make }
  level { 1 }
  activated { false }
end

class Player
  def win
    while can_build_settlement?
      settlements.make
    end
    while can_build_city?
      cities.make
    end
  end
end
