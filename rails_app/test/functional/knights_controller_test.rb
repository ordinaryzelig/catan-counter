require 'test_helper'

class KnightsControllerTest < ActionController::TestCase
  
  def test_create
    player = Player.make
    assert_difference('player.knights.level(1).size') do
      post :create, :player_id => player
    end
  end
  
  def test_destroy
    knight = Knight.make
    delete :destroy, :id => knight
    assert_nil Knight.find_by_id(knight)
  end
  
  def test_promote
    knight = Knight.make
    post :promote, :id => knight
    assert_equal 2, knight.reload.level
  end
  
end