require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_players_colors_left
    game = Game.make
    game.colors[0...-1].each do |color|
      game.players.make(:color => color)
    end
    assert_equal [game.colors.last], game.players.colors_left
  end
  
  def test_create_starter_buildings
    game = Game.make
    player = game.players.make
    assert_equal 2, player.reload.settlements.size
  end
  
end
