require 'test_helper'

class LimitPerPlayerTest < ActiveSupport::TestCase
  
  def test_settlements
    player = Player.make
    player.settlements.left.times { player.settlements.make }
    assert_raise(ActiveRecord::RecordInvalid) { player.settlements.make }
  end
  
end
