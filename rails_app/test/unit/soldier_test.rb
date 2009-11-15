require 'test_helper'

class SoldierTest < ActiveSupport::TestCase
  
  def test_limit_to_14_soldiers
    game = Game.make
    assert_equal Soldier.limit_per_game, game.soldiers.size
    assert_raise(Soldier::LimitExceeded) do
      game.soldiers.create!
    end
  end
  
  def test_assign_largest_army
    player = Player.make
    3.times { player.play_soldier }
    assert player.largest_army.id
  end
  
  def test_tie_for_largest_army
    game = Game.make
    players = 2.times.map do
      player = game.players.make
      3.times { player.play_soldier }
      player
    end
    assert players.shift.largest_army
    player_about_to_have_largest_army = players.shift
    player_about_to_have_largest_army.play_soldier
    assert player_about_to_have_largest_army.largest_army
  end
  
end
