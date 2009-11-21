Game.blueprint do
  victory_points_to_win {}
end

class Game
  # mimic how Game.make(:cities_and_knights) by saving game then creating expansions.
  def self.make(*args)
    return super unless args.first == :cities_and_knights
    expansion = args.shift
    game = super(*args)
    game.expansions = [Expansion.find_by_name('CitiesAndKnights') || Expansion.make(expansion)]
    game
  end
end
