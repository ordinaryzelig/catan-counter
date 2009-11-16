Sham.color { |i| ['blue', 'red', 'white', 'orange'][i -1] }

Player.blueprint do
  color
  game { Game.make }
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
