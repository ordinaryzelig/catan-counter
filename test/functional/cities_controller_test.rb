require 'test_helper'

class CitiesControllerTest < ActionController::TestCase

  def test_downgrade_to_settlement
    city = City.make
    assert_difference('city.player.settlements.size') do
      post :downgrade_to_settlement, :player_id => city.player, :id => city
    end
    assert_nil City.find_by_id(city)
  end

end
