require 'test_helper'

class StandardGameTest < ActiveSupport::TestCase
  
  def test_create_starter_buildings
    game = StandardGame.make
    player = game.players.make
    assert_equal 2, player.reload.settlements.size
  end
  
end
