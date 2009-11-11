require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  
  def test_take_longest_road
    player = Player.make
    assert_difference('player.victory_points', 2) do
      put :take_longest_road, :id => player
    end
  end
  
end
