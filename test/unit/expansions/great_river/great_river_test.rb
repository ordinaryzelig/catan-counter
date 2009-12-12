require 'test_helper'

class GreatRiverTest < ActiveSupport::TestCase
  
  def setup
    super
    @game = Game.make(:great_river).create_components
  end
  
  def test_game_default_victory_points_to_win
    assert_equal 12, @game.default_victory_points_to_win
    @game.expansions << Expansion.make(:cities_and_knights)
    assert_equal 15, @game.default_victory_points_to_win
  end
  
  def test_game_create_components
    assert @game.soldiers.any?
    assert_not_nil @game.largest_army
    assert_not_nil @game.longest_road
    assert @game.gold_point_victory_points.any?
  end
  
  def test_player_victory_points
    player = @game.players.make
    player.take_gold_point_victory_point
    assert_equal 3, player.victory_points
  end
  
  def test_player_take_gold_point_victory_point
    player = @game.players.make
    assert_difference('@game.reload.gold_point_victory_points.not_taken.size', -1) do
      player.take_gold_point_victory_point
    end
  end
  
end
