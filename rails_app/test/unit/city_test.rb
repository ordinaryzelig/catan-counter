require 'test_helper'

class CityTest < ActiveSupport::TestCase
  
  def test_downgrade_to_settlement
    player = Player.make
    (player.settlements.left - 1).times { player.settlements.make }
    city = player.cities.make
    city.downgrade_to_settlement
    assert_nil City.find_by_id(city)
    assert_equal 5, player.settlements.size
    # try with no settlements left to build.
    assert !player.can_build_settlement?
    city = player.cities.make
    assert_difference('player.victory_points', -2) do
      city.downgrade_to_settlement
    end
  end
  
  def test_without_metropolis_named_scope
    game = Game.make(:cities_and_knights).create_components
    player = game.players.make
    city = player.cities.first
    assert player.cities.without_metropolis.include?(city)
    game.metropolises.first.update_attributes!(:city => city)
    assert player.cities.without_metropolis.empty?
  end
  
end
