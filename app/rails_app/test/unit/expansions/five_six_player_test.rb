require 'test_helper'

class FiveSixPlayerTest < ActiveSupport::TestCase
  
  def test_colors
    game = Game.make(:expansions => [Expansion.make(:five_six_player)])
    assert_equal 6, game.colors.size
  end
  
end
