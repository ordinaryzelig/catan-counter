require 'test_helper'

class MetropolisTest < ActiveSupport::TestCase
  
  def test_limit
    game = Game.make(:cities_and_knights).create_components
    assert_equal Metropolis::DEVELOPMENT_AREAS.size, game.metropolises.size
    assert_raise(Metropolis::LimitExceeded) do
      game.metropolises.first.clone.save!
    end
  end
  
end
