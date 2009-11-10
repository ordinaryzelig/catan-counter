require 'test_helper'

class ExpansionsControllerTest < ActionController::TestCase     
  
  def test_index
    game = Game.make
    get :index, :game_id => game
    assert_response :success
  end
  
end
