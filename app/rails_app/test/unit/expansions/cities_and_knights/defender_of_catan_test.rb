require 'test_helper'

class DefenderOfCatanTest < ActiveSupport::TestCase
  
  def test_limit_to_6_defenders_of_catan
    game = Game.make
    assert_equal DefenderOfCatan.limit_per_game, game.defenders_of_catan.size
    assert_raise(DefenderOfCatan::LimitExceeded) do
      game.defenders_of_catan.create!
    end
  end
  
end
