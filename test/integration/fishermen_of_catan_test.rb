require 'test_helper'

class FishermenOfCatanTest < ActionDispatch::IntegrationTest

  test 'take boot' do
    game = Game.make(:fishermen_of_catan)
    game.create_components
    player = game.players.make
    visit game_url(game)
    click_link 'take boot', :method => 'put'
    player.reload
    assert player.boot.present?
  end

end
