require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  def test_create
    post :create, :game => {}
    game = assigns('game')
    assert game.reload
    assert_redirected_to game_url(game)
  end
  
  def test_create_with_players_attributes
    player = Player.make_unsaved(:name => 'asdf')
    assert_difference('Game.all.size') do
      assert_difference('Player.all.size') do
        post :create, :game => {:players_attributes => {0 => player.attributes, 1 => {:name => ''}}}
      end
    end
  end
  
  def test_show
    player = Player.make
    get :show, :id => player.game.to_param
    assert_response :success
  end
  
end
