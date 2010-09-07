require 'test_helper'

class GameSetupTest < ActionDispatch::IntegrationTest

  test 'create new basic game with some players' do
    visit new_game_url
    fill_in 'blue', :with => 'blue player'
    fill_in 'red', :with => 'red player'
    click_button 'save'
    follow_redirect!
    assert_contain 'blue player'
    assert_contain 'red player'
  end

  test 'customize victory points required to win' do
    game = Game.make
    visit game_url(game)
    click_link 'customize game'
    fill_in 'victory points to win', :with => '11'
    click_button 'save'
    game.reload
    assert_equal 11, game.victory_points_to_win
  end

end
