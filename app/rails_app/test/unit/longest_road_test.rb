require 'test_helper'

class LongestRoadTest < ActiveSupport::TestCase
  
  def test_one_per_game
    game = Game.make
    2.times { game.players.make }
    players = game.players
    LongestRoad.make(:player => players.pop)
    assert_raise(ActiveRecord::RecordInvalid) do
      LongestRoad.make(:player => players.pop)
    end
  end
  
end
