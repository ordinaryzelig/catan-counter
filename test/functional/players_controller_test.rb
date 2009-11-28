require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  
  def test_take_longest_road
    player1 = Player.make
    player1.game.create_components
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
    player.game.create_components
    assert_difference('player.reload.soldiers.size') do
      put :play_soldier, :id => player
    end
  end
  
  def test_play_soldier_when_none_left_to_take
    player = Player.make
    player.game.create_components
    player.game.soldiers.each { player.play_soldier }
    assert_raise(Soldier::NoMore) do
      put :play_soldier, :id => player
    end
  end
  
  def test_build_metropolis
    game = Game.make(:cities_and_knights)
    game.create_components
    player = game.players.make
    assert_difference('player.cities.without_metropolises.size', -1) do
      put :build_metropolis, :id => player, :development_area => 'politics'
    end
  end
  
  def test_take_boot
    game = Game.make(:fishermen_of_catan).create_components
    player = game.players.make
    put :take_boot, :id => player
    assert player.boot
  end
  
  def test_take_progress_card_victory_point
    game = Game.make(:cities_and_knights).create_components
    player = game.players.make
    assert_difference('player.reload.progress_card_victory_points.size') do
      put :take_progress_card_victory_point, :id => player
    end
  end
  
end
