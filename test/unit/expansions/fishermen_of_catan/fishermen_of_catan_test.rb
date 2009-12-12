require 'test_helper'

class FishermenOfCatanTest < ActiveSupport::TestCase
  
  def setup
    super
    @game = Game.make(:fishermen_of_catan).create_components
  end
  
  def test_game_create_components
    assert @game.soldiers.any?
    assert_not_nil @game.largest_army
    assert_not_nil @game.longest_road
    assert @game.boot
  end
  
  def test_player_victory_points_to_win
    player = @game.players.make
    assert_equal @game.victory_points_to_win, player.victory_points_needed_to_win
    assert_difference('player.victory_points_needed_to_win') do
      player.take_boot
    end
  end
  
  def test_game_creates_standard_components
    assert @game.soldiers.any?
  end
  
  def test_game_creates_cities_and_knights_components
    Expansion.destroy_all
    expansions = Expansion::EXPANSIONS.map { |expansion| Expansion.make(expansion) }
    game = Game.make
    game.expansions.push(*expansions)
    game.create_components
    assert_not_nil game.boot
    assert game.defenders_of_catan.any?
  end
  
  def test_game_players_with_enough_victory_points_to_win_if_player_has_boot
    2.times { @game.players.make }
    player = @game.players.first
    # build enough buildings to get player to 10 victory points.
    while player.can_build_city? do
      player.cities.make
    end
    until player.victory_points == player.victory_points_needed_to_win do
      player.settlements.build
    end
    assert_equal player.victory_points_needed_to_win, player.victory_points
    assert_equal [player], @game.players.with_enough_victory_points_to_win
    # give player the boot and player should not be winning any more.
    player.take_boot
    assert @game.reload.players.with_enough_victory_points_to_win.empty?
  end
  
  def test_player_take_boot
    player = @game.players.make
    player.take_boot
    assert_equal player, player.boot.player
  end
  
end
