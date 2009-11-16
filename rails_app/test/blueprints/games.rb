Game.blueprint do
  victory_points_to_win {}
end

Game.blueprint(:cities_and_knights) do
  expansions { [Expansion.make(:cities_and_knights)] }
end

class Game
  def self.make(*args)
    return super unless args.first == :cities_and_knights
    expansion = args.shift
    game = super(*args)
    game.expansions = [Expansion.make(expansion)]
    game
  end
end
