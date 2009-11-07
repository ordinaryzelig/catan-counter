require 'test_helper'

class KnightTest < ActiveSupport::TestCase
  
  def test_limit
    player = Player.make
    level_1s = 2.times.map { Knight.make(:player => player, :level => 1) }
    Knight.make(:player => player, :level => 2)
    assert_raise(ActiveRecord::RecordInvalid) { Knight.make(:player => player, :level => 1) }
  end
  
end
