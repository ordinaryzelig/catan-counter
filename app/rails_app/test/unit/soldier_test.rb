require 'test_helper'

class SoldierTest < ActiveSupport::TestCase
  
  def test_limit_to_14_soldiers
    game = Game.make
    assert_equal Soldier.limit_per_game, game.soldiers.size
    assert_raise(Soldier::LimitExceeded) do
      game.soldiers.create!
    end
  end
  
end
