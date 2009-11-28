require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  def test_show
    player = Player.make
    player.game.create_components
    get :show, :id => player.game
    assert_response :success
  end
  
  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    post :create, :game => {}
    assert_redirected_to game_url(Game.first)
  end
  
  def test_create_and_add_expansions
    post :create, :game => {}, :add_expansions => '1'
    assert_redirected_to game_expansions_url(Game.first)
  end
  
  def test_cities_and_knights_shows_components
    game = Player.make.game.create_components
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
    game = Game.make.create_components
    expansion = Expansion.make(:cities_and_knights)
    put :update, :id => game, :game => {:expansion_ids => [expansion.id]}
    assert game.uses?(expansion)
  end
  
  def test_winners
    game = Game.make.create_components
    game.players.make.win
    get :show, :id => game
    winners = assigns(:winners)
    assert winners.any?
    assert_tag :tag => 'table', :attributes => {:id => 'winners'}, :content => winners.first.name
  end
  
end