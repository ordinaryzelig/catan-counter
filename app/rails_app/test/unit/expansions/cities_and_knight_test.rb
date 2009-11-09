require 'test_helper'

class CitiesAndKnightTest < ActiveSupport::TestCase
  
  def test_default_victory_points_to_win
    game = Game.make(:expansions => [Expansion.make(:cities_and_knights)])
    assert_equal 13, game.default_victory_points_to_win
  end
  
end
