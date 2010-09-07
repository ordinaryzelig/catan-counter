require 'test_helper'

class CitiesAndKnightsTest < ActionDispatch::IntegrationTest

  def setup
    super
    @game = Game.make(:cities_and_knights)
    @game.create_components
    @player = @game.players.make
  end

  test 'build knight' do
    visit game_url(@game)
    click_link 'build knight', :method => 'post'
    assert_equal 1, @player.knights.size
  end

  test 'promote knight' do
    knight = @player.knights.make
    visit game_url(@game)
    click_link 'promote', :method => 'put'
    knight.reload
    assert_equal 2, knight.level
  end

  test 'desert' do
    @player.knights.make
    visit game_url(@game)
    click_link 'desert', :method => 'delete'
    assert_equal 0, @player.knights.size
  end

  test 'activate knight' do
    @player.knights.make
    visit game_url(@game)
    click_link 'activate', :method => 'put'
    @player.reload
    assert_equal 1, @player.knights.strength
  end

  test 'deactivate knight' do
    @player.knights.make(:activated => true)
    visit game_url(@game)
    click_link 'deactivate', :method => 'put'
    @player.reload
    assert_equal 0, @player.knights.strength
  end

  test 'take merchant' do
    visit game_url(@game)
    click_link 'take merchant', :method => 'put'
    @player.reload
    assert @player.merchant
  end

  test 'take progress card victory point' do
    visit game_url(@game)
    click_link 'take progress card victory point', :method => 'put'
    @player.reload
    assert_equal 1, @player.progress_card_victory_points.size
  end

  test 'barbarians attack and player loses city' do
    flunk
  end

  test 'barbarians attack and player is defender of catan' do
    flunk
  end

  test 'barbarians attack and 2 players tie for most activated knights' do
    flunk
  end

  test 'build metropolis' do
    flunk
  end

end
