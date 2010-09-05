require 'test_helper'

class SettlementTest < ActiveSupport::TestCase

  def test_upgrade_to_city
    settlement = Settlement.make
    city = settlement.upgrade_to_city
    assert_nil Settlement.find_by_id(settlement)
  end

  def test_upgrade_to_city_with_no_cities_left
    player = Player.make
    4.times { player.cities.make }
    settlement = player.settlements.make
    assert_raise(ActiveRecord::RecordInvalid) { settlement.upgrade_to_city }
  end

end
