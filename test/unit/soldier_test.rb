require 'test_helper'

class SoldierTest < ActiveSupport::TestCase

  def test_assign_largest_army
    player = Player.make
    player.game.create_components
    3.times { player.reload.play_soldier }
    assert player.largest_army
  end

  def test_tie_for_largest_army
    game = Game.make.create_components
    first_player_to_play_3_soldiers = game.players.make
    3.times { first_player_to_play_3_soldiers.reload.play_soldier }
    assert first_player_to_play_3_soldiers.reload.largest_army
    another_player = game.players.make
    3.times { another_player.reload.play_soldier }
    assert_equal first_player_to_play_3_soldiers, game.reload.players.with_largest_army
  end

end
