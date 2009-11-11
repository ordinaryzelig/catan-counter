require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  
  def test_take_longest_road
    player1 = Player.make
    player1.take_longest_road
    player2 = player1.game.players.make
    assert_difference('player2.victory_points', 2) do
      assert_difference('player1.victory_points', -2) do
        put :take_longest_road, :id => player2
      end
    end
  end
  
end
