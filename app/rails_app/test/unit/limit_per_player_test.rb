require 'test_helper'

class LimitPerPlayerTest < ActiveSupport::TestCase
  
  def setup
    @player = Player.make
  end
  
  def test_roads
    Road.limit_per_player.times { Road.make(:player => @player) }
    assert_raise(ActiveRecord::RecordInvalid) { Road.make(:player => @player) }
  end
  
end
