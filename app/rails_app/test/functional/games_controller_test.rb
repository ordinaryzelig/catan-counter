require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  def test_show
    player = Player.make
    get :show, :id => player.game
    assert_response :success
  end
  
  def test_create
    post :create, :game => {}
    game = assigns('game')
    assert_redirected_to game_url(Game.first)
  end
  
  def test_cities_and_knights_shows_components
    game = Player.make.game
    get :show, :id => game
    assert_no_tag :div, :attributes => {:class => 'knights'}
    game.expansions << Expansion.make(:cities_and_knights)
    get :show, :id => game
    assert_tag :div, :attributes => {:class => 'knights'}
  end
  
  def test_edit
    game = Game.make
    get :edit, :id => game
    assert_response :success
  end
  
  def test_update
    game = Game.make
    expansion = Expansion.make(:cities_and_knights)
    put :update, :id => game, :game => {:expansion_ids => [expansion.id]}
    assert game.uses?(expansion)
  end
  
end
