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

  test 'remove' do
    @player.knights.make
    visit game_url(@game)
    within('.knights') do
      click_link 'remove', :method => 'delete'
    end
    assert_equal 0, @player.reload.knights.size
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
    visit game_url(@game)
    barbarians_attack
    @player.reload
    assert_equal 0, @player.cities.count
  end

  test 'barbarians attack and player is defender of catan' do
    @player.knights.create!(:activated => true, :level => 1)
    visit game_url(@game)
    barbarians_attack
    @player.reload
    assert_equal 1, @player.defenders_of_catan.count
  end

  test 'barbarians attack and 2 players tie for most activated knights' do
    player_2 = @game.players.make
    [@player, player_2].each do |player|
      player.knights.create!(:activated => true, :level => 1)
    end
    visit game_url(@game)
    barbarians_attack
    @player.reload
    assert_equal 0, @player.defenders_of_catan.count
  end

  test 'build metropolis' do
    visit game_url(@game)
    click_link 'trade', :method => 'put'
    @player.reload
    assert @player.metropolises.first
  end

  # ==================================================
  # helpers.

  def barbarians_attack
    click_link 'barbarians attack', :method => 'put'
  end

end
