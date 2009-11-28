require 'test_helper'

class ProgressCardVictoryPointTest < ActiveSupport::TestCase
  
  def test_limit
    game = Game.make(:cities_and_knights).create_components
    assert_equal ProgressCardVictoryPoint.limit_per_game, game.progress_card_victory_points.size
    assert_raise(ProgressCardVictoryPoint::LimitExceeded) do
      game.progress_card_victory_points.create!
    end
  end
  
end
