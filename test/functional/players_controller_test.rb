require 'test_helper'

class PlayersControllerTest < ActionController::TestCase

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
