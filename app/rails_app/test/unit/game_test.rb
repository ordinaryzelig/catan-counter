require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_players_colors_left
    game = StandardGame.make
    game.class.colors[0...-1].each do |color|
      game.players.make(:color => color)
    end
    assert_equal [game.class.colors.last], game.players.colors_left
  end
  
end
