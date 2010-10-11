require 'test_helper'

class MetropolisTest < ActiveSupport::TestCase

  def test_development_area_named_scope
    metropolises = 3.times.map { Metropolis.make(:development_area => 'politics') }
    3.times.map { Metropolis.make(:development_area => 'science') }
    assert_equal metropolises, Metropolis.development_area('politics').all
  end

end
