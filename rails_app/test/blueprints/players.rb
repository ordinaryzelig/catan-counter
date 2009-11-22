Sham.color { |i| ['blue', 'red', 'white', 'orange'][i -1] }

Player.blueprint do
  color
  game { Game.make }
end

class Player
  # build a bunch of stuff and the player should have enough points to win.
  def win
    while can_build_city?
      cities.make
    end
    while can_build_settlement?
      settlements.make
    end
  end
end
