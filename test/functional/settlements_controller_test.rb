require 'test_helper'

class SettlementsControllerTest < ActionController::TestCase
  
  def test_create
    player = Player.make
    assert_difference('player.settlements.size') do
      post :create, :player_id => player
    end
  end
  
  def test_upgrade_to_city
    player = Player.make
    assert_difference('player.settlements.size', -1) do
      assert_difference('player.reload.cities.size') do
        post :upgrade_to_city, :id => player.settlements.first
      end
    end
  end
  
  def test_destroy
    settlement = Settlement.make
    delete :destroy, :id => settlement
    assert_nil Settlement.find_by_id(settlement)
  end
  
end