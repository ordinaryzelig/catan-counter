Game.blueprint do
  victory_points_to_win {}
end

# see make() below for named blueprints for expansions that would look like this:
# Game.blueprint(:cities_and_knights)

class Game
  # override to mimic Game.make(expansion_name) by saving game then creating expansions.
  def self.make(*args)
    return super unless Expansion::EXPANSIONS.include?(args.first)
    expansion_arg = args.shift
    expansion = Expansion.find_by_name(expansion_arg.to_s.camelize) || Expansion.make(expansion_arg)
    game = super(*args)
    game.expansions << expansion
    game.reload
  end
end
