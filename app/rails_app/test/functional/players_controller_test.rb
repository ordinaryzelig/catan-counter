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
  
  def test_play_soldier
    player = Player.make
    assert_difference('player.reload.soldiers.size') do
      put :play_soldier, :id => player
    end
  end
  
  def test_player_soldier_when_none_left_to_take
    player = Player.make
    player.game.soldiers.each { player.play_soldier }
    assert_raise(Soldier::NoMore) do
      put :play_soldier, :id => player
    end
  end
  
end
