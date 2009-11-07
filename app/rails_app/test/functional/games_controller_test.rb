require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  def test_create
    post :create, :game => {:game_type_attribute => 'StandardGame'}
    game = assigns('game')
    assert game = Game.find(game)
    assert game.is_a?(StandardGame)
  end
  
end
