require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_case_name
    game = StandardGame.make
    Player::COLORS[0...-1].each do |color|
      game.players.make(:color => color)
    end
    assert_equal [Player::COLORS.last], game.players.colors_left
  end
  
end
