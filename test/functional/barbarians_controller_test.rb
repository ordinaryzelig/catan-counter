require 'test_helper'

class BarbariansControllerTest < ActionController::TestCase

  def test_attack
    game = Game.make(:cities_and_knights)
    player = game.players.make
    assert_equal 1, player.cities.size
    put :attack, :game_id => game
    assert player.reload.cities.empty?
  end

end
