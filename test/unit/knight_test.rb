require 'test_helper'

class KnightTest < ActiveSupport::TestCase

  def test_promote
    knight = Knight.make
    knight.promote
    assert_equal 2, knight.level
  end

  def test_bad_promotion
    player = Player.make
    2.times { player.knights.make(:level => 2) }
    assert_raise(ActiveRecord::RecordInvalid) { player.knights.make.promote }
  end

  def test_toggle_activation
    knight = Knight.make(:activated => true)
    knight.toggle_activation
    assert !knight.activated
    knight.toggle_activation
    assert knight.activated
  end

  def test_strength
    knight = Knight.make
    assert_equal 0, knight.strength
    assert_equal 1, knight.activate.strength
    assert_equal 2, knight.promote.strength
  end

end
