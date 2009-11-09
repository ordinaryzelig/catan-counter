require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  def test_show
    player = Player.make
    get :show, :id => player.game.to_param
    assert_response :success
  end
  
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
  
  def test_cities_and_knights_shows_knights
    game = Player.make.game
    get :show, :id => game.to_param
    assert_no_tag :div, :attributes => {:class => 'knights'}
    game.expansions << Expansion.make(:cities_and_knights)
    get :show, :id => game.to_param
    assert_tag :div, :attributes => {:class => 'knights'}
  end
  
end
