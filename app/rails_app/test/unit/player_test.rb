require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_starter_buildtings
    player = Player.make(:game => StandardGame.make)
    assert_equal 2, player.settlements.size
  end
  
end
