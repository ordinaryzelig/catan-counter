require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_victory_points
    player = Player.make
    player.settlements.destroy_all
    player.cities.destroy_all
    2.times { player.settlements.make }
    2.times { player.cities.make }
    assert_equal 6, player.victory_points
  end
  
  def test_can_build_settlement?
    player = Player.make
    player.settlements.left.times { player.settlements.make  }
    assert !player.can_build_settlement?
    player.settlements.last.destroy
    assert player.can_build_settlement?
  end
  
  def test_can_build_city?
    player = Player.make
    assert player.can_build_city?
    # no settlements to upgrade.
    player.settlements.destroy_all
    assert !player.can_build_city?
    # settlements, but no cities left.
    player.settlements.make
    assert player.can_build_city?
    player.cities.left.times { player.cities.make }
    assert !player.can_build_city?
  end
  
  def test_default_name_to_color
    color = Player::COLORS.first
    player = Player.make(:color => color, :name => nil)
    assert_equal color, player.name
  end
  
end
