require 'test_helper'

class GoldPointVictoryPointTest < ActiveSupport::TestCase
  
  def test_limit
    game = Game.make(:great_river).create_components
    assert_equal GoldPointVictoryPoint.limit_per_game, game.gold_point_victory_points.size
    assert_raise(GoldPointVictoryPoint::LimitExceeded) do
      game.gold_point_victory_points.create!
    end
  end
  
end
