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

  test 'lone knight can be promoted?' do
    knight = Knight.make(:level => 1)
    assert knight.can_be_promoted?
  end

  test 'level 3 knight cannot be promoted' do
    knight = Knight.make(:level => 3)
    assert !knight.can_be_promoted?
  end

  test 'level 1 knight cannot be promoted because already 2 level 2 knights' do
    player = Player.make
    level_2_knights = 2.times { player.knights.make(:level => 2) }
    level_1_knight = player.knights.make(:level => 1)
    assert !level_1_knight.can_be_promoted?
  end

end
