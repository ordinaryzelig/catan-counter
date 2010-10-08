require 'test_helper'

class BasicGamePlayTest < ActionDispatch::IntegrationTest

  def setup
    super
    @game = Game.make
    @game.create_components
    @player = @game.players.make
  end

  test 'build settlement' do
    visit game_url(@game)
    click_link 'build', :method => 'post'
    assert_equal 3, @player.reload.settlements.size
  end

  test 'upgrade settlement to city' do
    visit game_url(@game)
    click_link 'upgrade', :method => 'post'
    @player.reload
    assert_equal 1, @player.cities.size
    assert_equal 1, @player.settlements.size
  end

  test 'downgrade city to settlement' do
    @player.cities.make
    visit game_url(@game)
    click_link 'downgrade', :method => 'post'
    @player.reload
    assert_equal 0, @player.cities.size
    assert_equal 3, @player.settlements.size
  end

  test 'destroy settlement' do
    visit game_url(@game)
    click_link 'destroy', :method => 'delete'
    @player.reload
    assert_equal 1, @player.settlements.size
  end

  test 'play knight/soldier card' do
    visit game_url(@game)
    click_link 'play', :method => 'put'
    assert_equal 1, @player.soldiers.size
  end

  test 'take longest road' do
    visit game_url(@game)
    click_link 'take longest road', :method => 'put'
    assert_equal 4, @player.victory_points
  end

  test 'message shows player has enough victory points to win' do
    @game.update_attributes!(:victory_points_to_win => 2)
    visit game_url(@game)
    assert_contain 'has enough victory points to win'
  end

end