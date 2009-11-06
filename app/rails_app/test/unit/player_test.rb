require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_blueprint
    game = StandardGame.make
    Player::COLORS.size.times do
      assert Player.make(:game => game)
    end
  end
  
  def test_starter_buildtings
    player = Player.make(:game => StandardGame.make)
    assert_equal 2, player.settlements.size
  end
  
end
